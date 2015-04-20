using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;


public partial class TripHistory : System.Web.UI.UserControl
{
    public string userID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        string query1 = "Select * FROM vCompletedOffers WHERE driver_id =" + userID + " AND date_time < GETDATE()";
        SqlDataSource4.SelectCommand = query1;
        ListView4.DataBind();

        string query2 = "Select * FROM vCompletedRequests WHERE passenger_id =" + userID + " AND date_time < GETDATE()";
        SqlDataSource5.SelectCommand = query2;
        ListView5.DataBind();
        
    }

    protected void ListView4_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }

    protected void ListView5_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }
}