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
    public int listType { get; set;  }
    public string selectCmd { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = selectCmd;
        if (Request.IsAuthenticated) //Check first if request is authenticated 
        {
            userID = getUserIDFromCookie();
        }

        if(!IsPostBack)
        {
        }
        
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Button btn = (Button)e.CommandSource;
        string userID = getUserIDFromCookie();
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
                int n = DBHelper.getConfirmedPassengers(listingID, dsPassengers);
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


            if (DBHelper.isOwnListing(id, listingID, listType)) //Check if this is user own listing
            {
                btn.Text = "Send Offer";
                btn.Enabled = false;
            }

            else if (DBHelper.awaitingConfirm(id, listingID, listType))
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