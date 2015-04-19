using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;

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

        switch (e.CommandName)
        {
            case "SendRequest": DBHelper.CreatePendingRequest(userID, e.CommandArgument.ToString()); 
                break;

            case "SendOffer": DBHelper.CreatePendingOffer(userID, e.CommandArgument.ToString());
                break;
        }
       
    }

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

        if (Request.IsAuthenticated)
        {
            Label ratingStars = (Label)e.Item.FindControl("lblStars");
            Label reviewCount = (Label)e.Item.FindControl("lblCount");
            Button btn = (Button)e.Item.FindControl("btnCmd");
            DataRowView rowView = (DataRowView)e.Item.DataItem;//Get current data row
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
            
                lblSeats.Text += rowView["seats"].ToString();

                btn.CommandName = "SendRequest";
                btn.CommandArgument = rowView["id"].ToString();
                btn.Text = "Send Request";
            }
            if(this.listType == DBHelper.REQ_LIST)
            {
                btn.CommandName = "SendOffer";
                btn.CommandArgument = rowView["id"].ToString();
                btn.Text = "Send Offer";
            }

            Panel p1 = (Panel)e.Item.FindControl("pnlAnonymous");
            Panel p2 = (Panel)e.Item.FindControl("pnlLoggedIn");

            p1.Visible = false;
            p2.Visible = true;

        }
    }


}