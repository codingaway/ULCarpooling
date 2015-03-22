using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Data;

public partial class JoshsTemplateAttempt : System.Web.UI.Page
{
    protected SqlConnection sql = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Loaner\\ULCarpooling\\App_Data\\carpooling_db.mdf;Integrated Security=True;");

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //Code to get User_ID from cookie

            //Need a command to load users image from DB and display to profileImage
            //profileImage.ImageUrl = "~/DisplayImg.ashx?id=" + 3; //User_ID from cookie needed

            //Need commands to load name, email and phone from DB and display to txtName, txtEmail, txtPhone

            //SqlConnection sql = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Loaner\\ULCarpooling\\App_Data\\carpooling_db.mdf;Integrated Security=True;");
            //SqlCommand cmd = new SqlCommand();

            using (SqlCommand cmd = new SqlCommand("Select * from users Where User_ID = 3", sql))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;

                sql.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        lblName.Text = reader.GetString(1) + " " + reader.GetString(2);
                        lblEmail.Text = reader.GetString(3);
                        lblPhone.Text = reader.GetString(4);

                        if (reader["profile_pic"] == System.DBNull.Value)
                        {
                            //profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
                        }
                        else
                        {
                            //profileImage.ImageUrl = "~/DisplayImg.ashx?id=" + 3;
                        }
                    }
                }
                else
                {
                    Response.Write("No data found");
                }
                reader.Close();
            }

            using (SqlCommand cmd = new SqlCommand("SELECT user_pass FROM user_secret WHERE User_id = 3", sql))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string pw = "";
                    for (int i = 0; i < (reader["user_pass"].ToString()).Length; i++)
                    {
                        pw += "*";
                    }
                    lblPW.Text = pw;
                }
                else
                {
                    lblPW.Text = "Error loading password";
                }
                reader.Close();
            }



            //Need a command to load feedback from DB to feedbackImage

            //Need a command to load Active Offers/Requests from DB
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM offer_rec WHERE user_id = 3", sql))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;

                SqlDataReader reader = cmd.ExecuteReader();
                string display;
                int from, to;

                if (reader.Read())
                {
                    int offerID = Int32.Parse(reader["offer_id"].ToString());
                    reader.Close();
                    if (checkIfPending(offerID))
                    {
                        reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            display = reader["date_time"].ToString() + " ";
                            from = Int32.Parse(reader["from"].ToString());
                            to = Int32.Parse(reader["to"].ToString());
                            reader.Close();
                            display += getPlaceName(from) + " - ";
                            display += getPlaceName(to);
                            lblPendingOffer1.Text = display;
                        }
                        else
                            lblPendingOffer1.Text = "No pending offers3";
                    }
                    else
                        lblPendingOffer1.Text = "No pending offers2";
                }
                else
                    lblPendingOffer1.Text = "No pending offers";
                reader.Close();
            }

            //Need a command to load Notifications from DB

            //Need a command to load Trip Histories from DB

            //reader.Close();
            sql.Close();
        }
    }

    protected string getPlaceName(int Place_id)
    {
        SqlCommand cmd2 = new SqlCommand("SELECT place_name FROM places WHERE Place_id = @Place_id", sql);
        cmd2.Parameters.Add("@Place_id", SqlDbType.Int).Value = Place_id;
        SqlDataReader reader = cmd2.ExecuteReader();
        string placeName;

        if (reader.Read())
        {
            placeName = reader["place_name"].ToString();
            reader.Close();
            return placeName;
        }
        else
        {
            placeName = "Place_id mismatch";
            reader.Close();
            return placeName;
        }
    }

    protected bool checkIfPending(int id)
    {
        SqlCommand command = new SqlCommand("SELECT * from pending_offer WHERE offer_id = @id", sql);
        command.Parameters.Add("@id", SqlDbType.Int).Value = id;
        command.Connection = sql;

        SqlDataReader reader2 = command.ExecuteReader();
        if (reader2.Read())
        {
            reader2.Close();
            return true;
        }
        else
        {
            reader2.Close();
            return false;
        }


    }

    protected void editDetails_Click(object sender, EventArgs e)
    {
        //Response.Redirect("JoshsEditProfile.aspx");
    }

    protected void btnChangePW_Click(object sender, EventArgs e)
    {
        //Response.Redirect("JoshsChangePW.aspx");
    }
}