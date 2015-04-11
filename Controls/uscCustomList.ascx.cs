using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class uscCustomList : System.Web.UI.UserControl
{
    public string userID { get; set; }
    public int listType {get; set;} 


    protected void Page_Load(object sender, EventArgs e)
    {
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
        Button btn = (Button)e.Item.FindControl("btnCmd");
        DataRowView rowView = (DataRowView)e.Item.DataItem;//Get current data row

        if (this.listType == DBHelper.OFFER_LIST)
        {
            Label lblSeats = (Label)e.Item.FindControl("lblSeats");
            lblSeats.Enabled = true;
            lblSeats.Visible = true;
            
            lblSeats.Text += rowView["seats"].ToString();

            btn.CommandName = "SendOffer";
            btn.CommandArgument = rowView["id"].ToString();
            btn.Text = "Send Offer";
        }
        if(this.listType == DBHelper.REQ_LIST)
        {
            btn.CommandName = "SendRequest";
            btn.CommandArgument = rowView["id"].ToString();
            btn.Text = "Send Request";
        }

        if (Request.IsAuthenticated)
        {

            Panel p1 = (Panel)e.Item.FindControl("pnlAnonymous");
            Panel p2 = (Panel)e.Item.FindControl("pnlLoggedIn");

            p1.Visible = false;
            p2.Visible = true;

        }
    }


}