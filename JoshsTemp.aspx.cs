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
            
            SqlConnection sql = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Loaner\\ULCarpooling\\App_Data\\carpooling_db.mdf;Integrated Security=True;");
            SqlCommand cmd = new SqlCommand();
            SqlDataReader reader;

            cmd.CommandText = "Select * from users Where User_ID = 3";
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = sql;

            sql.Open();

            reader = cmd.ExecuteReader();

            if(reader.HasRows)
            {
                while(reader.Read())
                {
                    txtName.Text = reader.GetString(1) + " " + reader.GetString(2);
                    txtEmail.Text = reader.GetString(3);
                    txtPhone.Text = reader.GetString(4);

                }
            }
            else
            {
                Response.Write("No data found");
            }
            reader.Close();
            sql.Close();


            //Need a command to load feedback from DB to feedbackImage

            //Need a command to load Active Offers/Requests from DB

            //Need a command to load Notifications from DB

            //Need a command to load Trip Histories from DB
        }
    }
}