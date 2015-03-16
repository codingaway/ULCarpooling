using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration; /*Required for reading connection string from Web.config */
using System.Data;
using System.Data.SqlClient;

public partial class Default6 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ASP.login_ascx login = (ASP.login_ascx)LoadControl("~/Login.ascx");
        //plhLogin.Controls.Add(login);
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        DataSet dsUserData = new DataSet(); //Dataset to hold UserID, User Name, Access Level

        if (ValidateUser(txtEmail.Text, txtPassword.Text, dsUserData))
        {
            //Create FormAuthentication ticket with user Full name
            string userName = dsUserData.Tables["UserData"].Rows[0]["Name"].ToString();
            string userID = dsUserData.Tables["UserData"].Rows[0]["User_ID"].ToString();
            string accessLevel = dsUserData.Tables["UserData"].Rows[0]["Access_level"].ToString();

            //FormsAuthentication.RedirectFromLoginPage(userName, chkRemember.Checked);

            //Create custom FormAuthentication ticket with User Name that also saves user ID for user identification purpose
            creatAuthTicket(userName, userID + "," + accessLevel);

            //Redirect user to original Returin URL 
            string strRedirect;
            strRedirect = Request["ReturnUrl"];
            if (strRedirect == null)
                strRedirect = "default.aspx";
            Response.Redirect(strRedirect, true);
        }
        else
        {
            //Authentication failed, show error message
            //optionally redirect user 
            lblErrorMsg.Text = "Invalid User ID or Password.";
            lblErrorMsg.Visible = true;
        }
    }

    private bool ValidateUser(string userEmail, string passwordInput, DataSet dsUserData)
    {
        if (userEmail == null || userEmail.Length == 0 || passwordInput == null || passwordInput.Length == 0)
        {
            return false;
        }
        try
        {
            /*Make ad DB connection object */
            SqlConnection conn = new SqlConnection();

            /* Set connection string using Web.config */
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;

            //Create sql command that calls a stored procedure "get_user_data"
            SqlCommand cmd = new SqlCommand("get_user_data", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //Add parameter value for the stored procedure
            cmd.Parameters.Add(new SqlParameter("@email", txtEmail.Text));

            //Create Data adapter with the conn and cmd
            SqlDataAdapter daUserData = new SqlDataAdapter();
            daUserData.SelectCommand = cmd;
            daUserData.SelectCommand.Connection.Open();
            daUserData.Fill(dsUserData, "UserData");

            //Dispose sql Command and Connection
            cmd.Dispose();
            conn.Dispose();
        }
        catch (Exception ex) { }

        if (dsUserData.Tables.Count == 0 || dsUserData.Tables["UserData"].Rows.Count == 0)
            return false; //No data found for this email

        string retrivedPassword = dsUserData.Tables["UserData"].Rows[0]["user_pass"].ToString();

        //Check user supplied password with actual password was extracted from database for this user
        return (passwordInput.CompareTo(retrivedPassword) == 0);
    }

    private void creatAuthTicket(string userName, string user_ID)
    {
        FormsAuthenticationTicket tkt;
        string cookiestr;
        HttpCookie ck;
        tkt = new FormsAuthenticationTicket(1, userName, DateTime.Now,
        DateTime.Now.AddMinutes(30), chkRemember.Checked,user_ID); //storing user_ID as User Data in cookie
        cookiestr = FormsAuthentication.Encrypt(tkt);
        ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
        if (chkRemember.Checked)
            ck.Expires = tkt.Expiration;
        ck.Path = FormsAuthentication.FormsCookiePath;
        Response.Cookies.Add(ck);
    }
}