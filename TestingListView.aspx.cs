using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ToString();
        DataSet dataset = new DataSet();
        string aQuery = "SELECT FName + ' ' + SName AS uname FROM users";
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(aQuery, conn);

        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = cmd;
        try{
            conn.Open();
            da.Fill(dataset);
            DataList1.DataSource = dataset;
            DataList1.DataBind();
        }
        finally
        {   
            da.Dispose();
            cmd.Dispose();
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