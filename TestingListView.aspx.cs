﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TestingListView : System.Web.UI.Page
{
    protected string userID;
    private string accLevel;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if(Request.IsAuthenticated)
        {
            //Code to get User_ID from cookie
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