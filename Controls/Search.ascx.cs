using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.UserControl
{

    public string loggedIntUserId { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        DataBind();

        if(loggedIntUserId != null)
        {
            lblMessage.Text = "The user is: " + loggedIntUserId;
        }
        else
        {
            lblMessage.Text = "User ID is not available";
        }
    }
}