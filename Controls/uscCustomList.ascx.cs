using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;

public partial class uscCustomList : System.Web.UI.UserControl
{
    public string userID { get; set; }
    public int listType {get; set;} 


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.IsAuthenticated) //Check first if request is authenticated 
        {
            //Get user ID from FormAuthentocation Ticket
            string[] userData;
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
            userData = ticket.UserData.Split(',');
            userID = userData[0];
        }

        lblHeading.Text = listType == DBHelper.OFFER_LIST ? "Offers" : "Request";
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Button btn = (Button)e.CommandSource;
        //string id = getUserIDFromCookie();
        bool success = false;
        switch (e.CommandName)
        {
            case "SendRequest":
                {
                    success = DBHelper.processResponse(userID, e.CommandArgument.ToString(), DBHelper.OFFER_LIST);
                    if(success)
                    {
                        btn.Text = "Request sent";
                        btn.Enabled = false;
                    }
                    else
                    { 
                        btn.Text = "Request failed";
                        btn.Enabled = false;
                    }
                }
                break;

            case "SendOffer":
                {
                    success = DBHelper.processResponse(userID, e.CommandArgument.ToString(), DBHelper.REQ_LIST);
                    if (success)
                    {
                        btn.Text = "Offer sent";
                        btn.Enabled = false;
                    }
                    else
                    {
                        btn.Text = "Offer failed";
                        btn.Enabled = false;
                    }
                }
                break;
        }
       
    }

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

        if (Request.IsAuthenticated)
        {
            string id = getUserIDFromCookie();

            Label ratingStars = (Label)e.Item.FindControl("lblStars");
            Label reviewCount = (Label)e.Item.FindControl("lblCount");
            Button btn = (Button)e.Item.FindControl("btnCmd");
            DataRowView rowView = (DataRowView)e.Item.DataItem;//Get current data row
            string listingID = rowView["id"].ToString();
            HyperLink hpl = (HyperLink)e.Item.FindControl("hlViewOverview");

            string adLister = rowView["User_ID"].ToString(); //Get ad lister user ID
            string[] ratingInfo = DBHelper.getUserReview(adLister); //Get user avg rating and rating count

            hpl.NavigateUrl = ResolveClientUrl("/Overview.aspx") + "?id=" + adLister;
            
            if (ratingInfo != null)
            {
                ratingStars.Text = ratingInfo[0];
                reviewCount.Text = ratingInfo[1];
            }
            else
            {
                ratingStars.Text = "0";
                reviewCount.Text = "0";
            }

               

            if (this.listType == DBHelper.OFFER_LIST)
            {
                Label lblSeats = (Label)e.Item.FindControl("lblSeats");
                lblSeats.Enabled = true;
                lblSeats.Visible = true;
                string numOfSeats = rowView["seats"].ToString();

                /* Show confirmed users for this trip using this offer ID and lister's id */
                DataSet dsPassengers = new DataSet();
                int n = getConfirmedPassengers(listingID, dsPassengers);
                // If we get any row back enable datalist view with the dataset
                if( n >  0)
                {
                    DataList datalist = (DataList)e.Item.FindControl("DataList1");
                    datalist.Enabled = true;
                    datalist.DataSource = dsPassengers;
                    datalist.DataBind();
                }

                int seatAvailable = Convert.ToInt32(numOfSeats) - n;
                lblSeats.Text += numOfSeats + "(" + seatAvailable.ToString() + " available)";
                
                if (seatAvailable < 1) //If there's no seat available disbale the Send request button
                    btn.Enabled = false;

            }
           

            if (awaitingConfirm(id, listingID))
            {
                btn.Text = "Awaiting Confirmation";
                btn.Enabled = false;
            }
            else if(this.listType == DBHelper.REQ_LIST)
            {
                btn.CommandName = "SendOffer";
                btn.CommandArgument = listingID;
                btn.Text = "Send Offer";
            }
            else
            {
                btn.CommandName = "SendRequest";
                btn.CommandArgument = listingID;
                btn.Text = "Send Request";
            }

            Panel p1 = (Panel)e.Item.FindControl("pnlAnonymous");
            Panel p2 = (Panel)e.Item.FindControl("pnlLoggedIn");

            p1.Visible = false;
            p2.Visible = true;

        }
    }

    private bool awaitingConfirm(string id, string listingID)
    {
        int row = 0;
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ToString();
        //DataSet dataset = new DataSet();

        string aQuery;
        if (listType == DBHelper.OFFER_LIST)
        {
            aQuery = "SELECT count(*) FROM offer_response"
                + " WHERE offer_id = @list_id"
                + " AND user_id = @userID";
        }
        else
        {
            aQuery = "SELECT count(*) FROM req_response"
                + " WHERE req_id = @list_id"
                + " AND user_id = @userID";
        }
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(aQuery, conn);
        cmd.Parameters.AddWithValue("@list_id", listingID);
        cmd.Parameters.AddWithValue("@userID", id);

        try
        {
            conn.Open();
            row = Convert.ToInt32(cmd.ExecuteScalar());
        }
        finally
        {
            conn.Dispose();
            cmd.Dispose();
        }
        if (row > 0)
            return true;
        else
            return false;        
    }

    /* Medhods that returns a dataset of confiremd user given an offer_id*/
    private int getConfirmedPassengers(string offer_id, DataSet dataset)
    {
        int rowCount = 0;
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ToString();
        string aQuery = "SELECT offer_response.user_id, users.FName + ' ' + users.SName AS uname FROM users"
            + " JOIN offer_response ON users.User_ID = offer_response.user_id"
            + " WHERE offer_response.offer_id = @list_id"
            + " AND offer_response.status = 'Confirmed'";
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(aQuery, conn);
        cmd.Parameters.AddWithValue("@list_id", offer_id);

        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = cmd;
        try
        {
            conn.Open();
            rowCount = da.Fill(dataset);
        }
        finally
        {
            da.Dispose();
            cmd.Dispose();
        }
        return rowCount;
    }

    private string getUserIDFromCookie()
    {
        //Get user ID from FormAuthentocation Ticket
        string[] userData;
        HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
        FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
        userData = ticket.UserData.Split(',');
        return userData[0];
    }
}