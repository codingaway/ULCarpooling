using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Default2 : System.Web.UI.Page
{
    private string userID;
    private string accLevel;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.IsAuthenticated) //Check first if request is authenticated 
        {
            //Get user ID from FormAuthentocation Ticket
            string [] userData;
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
            userData = ticket.UserData.Split(',');
            userID = userData[0];
            accLevel = userData[1];

            if(userID != null)
            {
                lblUserID.Text = "User ID for this session is: " + userID;
            }
            if(accLevel != null)
            {
                lblAccessLevel.Text = "Access Level is: " + accLevel;
            }
        }
        else
        {
            Response.Redirect("~/login.aspx");
        }
    }
}