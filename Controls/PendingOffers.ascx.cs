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


public partial class PendingOffers : System.Web.UI.UserControl
{
    public string userID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        DataBind();
        string query = "Select * FROM vUserInfo WHERE User_ID =" + userID;
        SqlDataSource2.SelectCommand = query;
        ListView2.DataBind();
    }

    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }
}