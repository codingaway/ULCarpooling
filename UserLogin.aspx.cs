using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default6 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ASP.login_ascx login = (ASP.login_ascx)LoadControl("~/Login.ascx");
        plhLogin.Controls.Add(login);
    }
}