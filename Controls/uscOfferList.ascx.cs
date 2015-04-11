using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class uscOfferList : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

        if (Request.IsAuthenticated)
        {

            Panel p1 = (Panel)e.Item.FindControl("pnlAnonymous");
            Panel p2 = (Panel)e.Item.FindControl("pnlLoggedIn");

            p1.Visible = false;
            p2.Visible = true;

        }
    }
}