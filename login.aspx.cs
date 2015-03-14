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
        /*Make ad DB connection object */
        SqlConnection conn = new SqlConnection();
        /* Set connection string using Web.config */
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;

        string[] UserNameCollection = { "13029096@studentmail.ul.ie", "ScottGu", "SimonMu" };
        string[] PasswordCollection = { "password", "password", "password" };

        for (int Iterator = 0; Iterator <= UserNameCollection.Length - 1; Iterator++)
        {
            bool UserNameIsValid = (string.Compare(txtEmail.Text, UserNameCollection[Iterator], true) == 0);
            bool PasswordIsValid = (string.Compare(txtPassword.Text, PasswordCollection[Iterator], false) == 0);

            if (UserNameIsValid && PasswordIsValid)
            {
                FormsAuthentication.RedirectFromLoginPage("Abdul Halim", chkRemember.Checked);
            }
        }
    }
}