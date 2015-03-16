using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;

public partial class JoshsTemp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            //Code to get User_ID from cookie

            //Need a command to load users image from DB and display to profileImage
            //profileImage.ImageUrl = "~/DisplayImg.ashx?id=" + 3; //User_ID from cookie needed

            //Need commands to load name, email and phone from DB and display to txtName, txtEmail, txtPhone

            SqlConnection sql = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Loaner\\ULCarpooling\\App_Data\\carpooling_db.mdf;Integrated Security=True;");
            //SqlCommand cmd = new SqlCommand();

            using(SqlCommand cmd = new SqlCommand("Select * from users Where User_ID = 3", sql))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;

                sql.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows){
                    while (reader.Read()){
                        txtName.Text = reader.GetString(1) + " " + reader.GetString(2);
                        txtEmail.Text = reader.GetString(3);
                        txtPhone.Text = reader.GetString(4);
                    
                        if (reader["profile_pic"] == System.DBNull.Value){
                            profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
                        }
                        else{
                            //profileImage.ImageUrl = "~/DisplayImg.ashx?id=" + 3;
                        }
                    }
                }
                else{
                    Response.Write("No data found");
                }
                reader.Close();
            }

            using(SqlCommand cmd = new SqlCommand("SELECT password FROM secret WHERE user_id = 3", sql))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;

                SqlDataReader reader = cmd.ExecuteReader();

                if(reader.Read()){
                    string pw = "";
                    for (int i = 0; i < (reader["password"].ToString()).Length; i++){
                        pw += "*";
                    }
                    txtPassword.Text = pw;
                } 
                else{
                    txtPassword.Text = "Error loading password";
                }
                reader.Close();
            }
            
            

            //Need a command to load feedback from DB to feedbackImage

            //Need a command to load Active Offers/Requests from DB

            //Need a command to load Notifications from DB

            //Need a command to load Trip Histories from DB

            //reader.Close();
            sql.Close();
        }
    }

    protected void editDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("JoshsEditProfile.aspx");
    }

    protected void btnChangePW_Click(object sender, EventArgs e)
    {
        Response.Redirect("JoshsChangePW.aspx");
    }
}