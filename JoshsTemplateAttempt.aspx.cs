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
    protected static int offer, request;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //Code to get User_ID from cookie

            //Need a command to load users image from DB and display to profileImage
            //profileImage.ImageUrl = "~/DisplayImg.ashx?id=" + 3; //User_ID from cookie needed

            //Need commands to load name, email and phone from DB and display to txtName, txtEmail, txtPhone

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
                            profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
                        }
                        else
                        {
                            profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
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
            using (SqlCommand cmd = new SqlCommand("SELECT AVG(rating) FROM Reviews WHERE user_id = 3", sql))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;

                SqlDataReader reader = cmd.ExecuteReader();
                
                if(reader.Read())
                {
                    lblRating.Text = reader.GetValue(0).ToString();
                }

                reader.Close();
            }

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
                    if (checkIfPending(offerID, 0))
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
                            lblPendingOffer1.Visible = true;
                            btnCancel.Visible = true;
                            offer = offerID;
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

            using (SqlCommand cmd = new SqlCommand("SELECT * FROM req_rec WHERE user_id = 3", sql))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;

                SqlDataReader reader = cmd.ExecuteReader();
                string display;
                int from, to;

                if (reader.Read())
                {
                    int requestID = Int32.Parse(reader["Request_id"].ToString());
                    reader.Close();
                    if (checkIfPending(requestID, 1))
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
                            lblPendingRequests1.Text = display;
                            lblPendingRequests1.Visible = true;
                            btnCancel3.Visible = true;
                            request = requestID;
                        }
                        else
                            lblPendingRequests1.Text = "No pending requests3";
                    }
                    else
                        lblPendingRequests1.Text = "No pending requests2";
                }
                else
                    lblPendingRequests1.Text = "No pending requests";
                reader.Close();
            }

            //Need a command to load Notifications from DB

            //Need a command to load Trip Histories from DB
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM trip_rec WHERE driver = 3", sql))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;

                SqlDataReader reader = cmd.ExecuteReader();
                string display;
                int from, to;

                if (reader.Read())
                {
                    display = reader["date_time"].ToString() + " ";
                    from = Int32.Parse(reader["from"].ToString());
                    to = Int32.Parse(reader["to"].ToString());
                    reader.Close();
                    display += getPlaceName(from) + " - ";
                    display += getPlaceName(to);
                    lblHistory1.Text = display;
                    lblHistory1.Visible = true;
                    btnReviewTrip.Visible = true;
                    btnReportTrip.Visible = true;
                }
                else
                    lblHistory1.Text = "No trip histories found3";
                reader.Close();
            }

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

    protected bool checkIfPending(int id, int flag)
    {
        if (flag == 0)
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
        else
        {
            SqlCommand command = new SqlCommand("SELECT * from pending_req WHERE request_id = @id", sql);
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

    }

    protected void editDetails_Click(object sender, EventArgs e)
    {
        //Response.Redirect("JoshsEditProfile.aspx");
        //edit details
    }

    protected void btnChangePW_Click(object sender, EventArgs e)
    {
        //Response.Redirect("JoshsChangePW.aspx");
        // change password
    }

    protected void btnBan_Click(object sender, EventArgs e)
    {
        //Ban another user
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        using (SqlCommand cmd = new SqlCommand("DELETE * FROM pending_offer WHERE offer_id = @id", sql))
        {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = sql;
                
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = 101;
                //lblPendingOffer1.Visible = false;
                btnCancel.Visible = false;
                lblPendingOffer1.Text = offer.ToString();
                //Response.Redirect("JoshsTemplateAttempt.aspx");
        }
    }

    protected void btnCancel3_Click(object sender, EventArgs e)
    {
        using (SqlCommand cmd = new SqlCommand("DELETE * FROM pending_req WHERE request_id = @id", sql))
        {
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = sql;

            cmd.Parameters.Add("@id", SqlDbType.Int).Value = request;
            //lblPendingRequests1.Visible = false;
            btnCancel3.Visible = false;
            lblPendingRequests1.Text = request.ToString();
            //Response.Redirect("JoshsTemplateAttempt.aspx");
        }
    }

    protected void btnReviewTrip_Click(object sender, EventArgs e)
    {
        //review a trip
    }

    protected void btnReportTrip_Click(object sender, EventArgs e)
    {
        //report a trip
    }
}