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


public partial class PendingRequests : System.Web.UI.UserControl
{
    public string userID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        DataBind();
        string query = "Select * FROM vRequestDetails WHERE User_ID =" + userID;
        SqlDataSource3.SelectCommand = query;
        ListView3.DataBind();
    }

    protected void ListView3_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }
}