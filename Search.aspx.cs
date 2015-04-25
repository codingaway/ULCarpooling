using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Web.Security;

public partial class Search : System.Web.UI.Page
{
    protected int searchType {
        get
        {
            return Convert.ToInt32(ViewState["searchType"]);
        }
        set
        {
            ViewState["searchType"] = value;
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            rblSearchOption.SelectedIndex = 0;
            searchType = 0;
            initFromList();
            initToList();
        }
        else
        {
            SqlDataSource1.SelectCommand = (string)ViewState["searchQuery"];
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {

            //ResultList.listType = searchType;
            lblHeading.Text = "Search Results: ";
            lblHeading.Text += rblSearchOption.SelectedIndex == 0 ? "Offers" : "Request";
            string resultTable;

            Panel1.Visible = true;
            DateTime startDate, endDate;
            string placeFrom = null, placeTo = null;
            if (ddlTripFrom.SelectedIndex > 0)
                placeFrom = ddlTripFrom.SelectedValue;
            if (ddlTripTo.SelectedIndex > 0)
                placeTo = ddlTripTo.SelectedValue;

            string formatString = "dd/MM/yyyy HH:mm";

            bool startDateExist = DateTime.TryParseExact(txtStartDate.Text, formatString, CultureInfo.InvariantCulture, DateTimeStyles.None, out startDate);
            bool endDateExist = DateTime.TryParseExact(txtEndDate.Text, formatString, CultureInfo.InvariantCulture, DateTimeStyles.None, out endDate);


            if (rblSearchOption.SelectedIndex == 1) //Offers
            {
                resultTable = "vRequestDetails";
            }
            else
            {
                resultTable = "vOfferDetails";
            }

            string searchQuery = "SELECT * FROM " + resultTable + " WHERE 1 = 1";

            if (placeFrom != null)
                searchQuery += " AND frm_id = " + placeFrom;

            if (placeTo != null)
                searchQuery += " AND to_id = " + placeTo;

            if (startDateExist)
                searchQuery += " AND date_time >= '" + startDate.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            else
                searchQuery += " AND date_time >= GETDATE()"; //Default: only get listings that are not from past

            if (endDateExist)
                searchQuery += " AND date_time <= '" + endDate.ToString("yyyy-MM-dd HH:mm:ss") + "'";

            searchQuery += " ORDER BY [date_time]";
            
                SqlDataSource1.SelectCommand = searchQuery;
                ListView1.DataBind();
                ViewState["searchQuery"] = searchQuery; //Save query for postback binding
        }
    }

    protected void btnFrmHidden_Click(object sender, EventArgs e)
    {
        initFromList();
    }

    protected void initFromList()
    {
        string tableName = rblSearchOption.SelectedIndex == 0 ? "vOfferFromPlace" : "vReqFromPlace";

        string aQuery = "select distinct * from " + tableName;
        SqlDataSource2.SelectCommand = aQuery;
        ddlTripFrom.Items.Clear();
        ddlTripFrom.DataBind();
        ddlTripFrom.Items.Insert(0, new ListItem("", "0"));
    }

    protected void rblSearchOption_SelectedIndexChanged(object sender, EventArgs e)
    {
        searchType = rblSearchOption.SelectedIndex;
        initFromList();
        initToList();
    }

    protected void initToList()
    {
        string tableName = rblSearchOption.SelectedIndex == 0 ? "vOfferToPlace" : "vReqToPlace";
        string aQuery;
        if (ddlTripFrom.SelectedIndex > 0)
        {
            aQuery = "select distinct pname, place_id from " + tableName + " WHERE frm_id = "
                        + ddlTripFrom.SelectedValue;
        }
        else
        {
            aQuery = "select distinct pname, place_id from " + tableName;
        }
        SqlDataSource3.SelectCommand = aQuery;
        ddlTripTo.Items.Clear();
        ddlTripTo.DataBind();
        ddlTripTo.Items.Insert(0, new ListItem("", "0"));
    }
    protected void ddlTripFrom_SelectedIndexChanged(object sender, EventArgs e)
    {
        initToList();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        rblSearchOption.SelectedIndex = 0;
        initFromList();
        initToList();
        txtEndDate.Text = "";
        txtStartDate.Text = "";
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
                    if (success)
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



            if (this.searchType == DBHelper.OFFER_LIST)
            {
                Label lblSeats = (Label)e.Item.FindControl("lblSeats");
                lblSeats.Enabled = true;
                lblSeats.Visible = true;
                string numOfSeats = rowView["seats"].ToString();

                /* Show confirmed users for this trip using this offer ID and lister's id */
                DataSet dsPassengers = new DataSet();
                int n = DBHelper.getConfirmedPassengers(listingID, dsPassengers);
                // If we get any row back enable datalist view with the dataset
                if (n > 0)
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


            if (DBHelper.isOwnListing(id, listingID, searchType)) //Check if this is user own listing
            {
                btn.Text = "Send Offer";
                btn.Enabled = false;
            }

            else if (DBHelper.awaitingConfirm(id, listingID, searchType))
            {
                btn.Text = "Awaiting Confirmation";
                btn.Enabled = false;
            }
            else if (this.searchType == DBHelper.REQ_LIST)
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