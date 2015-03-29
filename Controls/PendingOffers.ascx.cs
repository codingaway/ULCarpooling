using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class PendingOffers : System.Web.UI.UserControl
{
    public string userID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write(userID);
        SqlDataSource2.SelectParameters.Add("@id", userID);

    }
    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }
}