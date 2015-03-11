using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Get Login link button from master page
        MasterPage mstr = (MasterPage)this.Parent.Page.Master;
        LinkButton loginLink = mstr.FindControl("lbtnLogin") as LinkButton;

    }
}