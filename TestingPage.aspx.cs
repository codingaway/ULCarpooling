using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;

public partial class TestingPage : System.Web.UI.Page
{
    protected string userID { set; get; }
    private string accLevel;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.IsAuthenticated)
        {
            getUserID();
        }
    }

    protected void getUserID()
    {
        //Get user ID from FormAuthentocation Ticket
        string[] userData;
        HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
        FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
        userData = ticket.UserData.Split(',');
        userID = userData[0];
        accLevel = userData[1];
    }
}