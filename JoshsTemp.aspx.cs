using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class JoshsTemp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            //Need a command to load users image from DB and display to profileImage

            //Need commands to load name, email, phone and password from DB and display to txtName, txtEmail, txtPhone and txtPassword
            /*SqlConnection sql = new SqlConnection("ViewDataWindow_MSSQL__/_LocalDB__v11.0/C__USERS_LOANER_ULCARPOOLING_APP_DATA_CARPOOLING_DB.MDF/True/SqlTable/dbo.users.sql");
            SqlCommand cmd = new SqlCommand("select FName from users", sql);
            SqlDataAdapter da = new SqlDataAdapter(cmd);*/


            //Need a command to load feedback from DB to feedbackImage

            //Need a command to load Active Offers/Requests from DB

            //Need a command to load Notifications from DB

            //Need a command to load Trip Histories from DB
        }
    }
}