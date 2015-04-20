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

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.IsAuthenticated)//If user is already logged in then hide login form
        {
            pnlAnonymous.Visible = false;
            pnlLoggedin.Visible = true;
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {

        if (DBHelper.verifyUser(txtEmail.Text, txtPassword.Text))
        {
            //Create FormAuthentication ticket with user Full name

            DataSet dsUserData = getUserInfo(txtEmail.Text);

            string userName = dsUserData.Tables["UserData"].Rows[0]["Name"].ToString();
            string userID = dsUserData.Tables["UserData"].Rows[0]["User_ID"].ToString();
            string accessLevel = dsUserData.Tables["UserData"].Rows[0]["Access_level"].ToString();

            int accLevel = Convert.ToInt32(accessLevel);

            if (accLevel > 0)
            {
                //Create custom FormAuthentication ticket with User Name that also saves user ID for user identification purpose
                creatAuthTicket(userName, userID + "," + accessLevel);

                //Redirect user to original Return URL 
                string strRedirect;
                strRedirect = Request["ReturnUrl"];
                if (strRedirect == null)
                    strRedirect = "default.aspx";
                Response.Redirect(strRedirect, true);
            }
            else //User access level is:0 = Access revoked
            {
                lblErrorMsg.Text = "Invalid User ID or Password.";
                lblErrorMsg.Visible = true;
            }
        }
        else
        {
            //Authentication failed, show error message
            lblErrorMsg.Text = "Invalid User ID or Password.";
            lblErrorMsg.Visible = true;
        }
    }

    private DataSet getUserInfo(string userEmail)
    {
        DataSet dsUserData = new DataSet();

        /*Make ad DB connection object */
        SqlConnection conn = new SqlConnection();

        /* Set connection string using Web.config */
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        string aQuery = "SELECT User_ID, Name, Access_level from login_info "
            + "WHERE Email = @email";
        SqlCommand cmd = new SqlCommand(aQuery, conn);
        //Add parametere
        cmd.Parameters.Add(new SqlParameter("@email", txtEmail.Text));

        try
        {
            //Create Data adapter with the conn and cmd
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            conn.Open();
            da.Fill(dsUserData, "UserData");       
        }
        finally
        {
            //Dispose sql Command and Connection
            cmd.Dispose();
            conn.Dispose();
        }
        return dsUserData;
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