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
using System.Configuration;
using System.Web.Security;
using System.Web.UI.HtmlControls;

public partial class Dashboard : System.Web.UI.Page
{
    protected static int offer, request;

    protected string userID;
    private string accLevel;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        getUserID();
        //profileImage.ImageUrl = "~/Images/emptyProfileImage.png";

        if (!IsPostBack)
        {
            
            profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
            //Need a command to load users image from DB and display to profileImage
            //profileImage.ImageUrl = "~/DisplayImg.ashx?id=" + 3; //User_ID from cookie needed

            //Need commands to load name, email and phone from DB and display to txtName, txtEmail, txtPhone
            if (Request.IsAuthenticated) //Check first if request is authenticated 
            {
                //Code to get User_ID from cookie
                getUserID();
                using (SqlCommand cmd = new SqlCommand("Select * from users Where User_ID =" + userID, conn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = conn;

                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            lblName.Text = reader.GetString(1) + " " + reader.GetString(2);
                            lblEmail.Text = reader.GetString(3);
                            lblPhone.Text = reader.GetString(4);
                            txtName.Text = reader.GetString(1) + " " + reader.GetString(2);
                            txtPhone.Text = reader.GetString(4);
                            if (reader["profile_pic"] == System.DBNull.Value)
                            {
                                //profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
                                //(HtmlImageControl)(FindControl("profileImage")).
                                //profileImage.ImageUrl = "~/GetImage.aspx?ImageID=" + userID;
                            }
                            else
                            {
                                profileImage.ImageUrl = "~/GetImage.aspx?ImageID=" + userID;
                            }
                        }
                    }
                    else
                    {
                        Response.Write("No data found");
                    }
                    reader.Close();
                }


                using (SqlCommand cmd = new SqlCommand("SELECT user_pass FROM user_secret WHERE User_id =" + userID, conn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = conn;

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string pw = "";
                        for (int i = 0; i < (reader["user_pass"].ToString()).Length; i++)
                        {
                            pw += "*";
                        }
                        lblPW.Text = pw;
                        txtPW.Text = pw;
                        txtConPW.Text = pw;
                    }
                    else
                    {
                        lblPW.Text = "Error loading password";
                    }
                    reader.Close();
                }



                //Need a command to load feedback from DB to feedbackImage
                using (SqlCommand cmd = new SqlCommand("SELECT AVG(rating) FROM Reviews WHERE user_id =" + userID, conn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = conn;

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        lblRating.Text = reader.GetValue(0).ToString();
                    }

                    reader.Close();
                }

                //Need a command to load Active Offers/Requests from DB
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM offer_rec WHERE user_id =" + userID, conn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = conn;

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
                                from = Int32.Parse(reader["place_from"].ToString());
                                to = Int32.Parse(reader["place_to"].ToString());
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

                using (SqlCommand cmd = new SqlCommand("SELECT * FROM req_rec WHERE user_id =" + userID, conn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = conn;

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
                                from = Int32.Parse(reader["place_from"].ToString());
                                to = Int32.Parse(reader["place_to"].ToString());
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
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM trip_rec WHERE driver =" + userID, conn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = conn;

                    SqlDataReader reader = cmd.ExecuteReader();
                    string display;
                    int from, to;

                    if (reader.Read())
                    {
                        display = reader["date_time"].ToString() + " ";
                        from = Int32.Parse(reader["place_from"].ToString());
                        to = Int32.Parse(reader["place_to"].ToString());
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
                conn.Close();
            }
            else
            {
                conn.Close();
                Response.Redirect("~/login.aspx");
            }
            
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

    protected string getPlaceName(int Place_id)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        
        SqlCommand cmd2 = new SqlCommand("SELECT place_name FROM places WHERE Place_id = @Place_id", conn);
        cmd2.Parameters.Add("@Place_id", SqlDbType.Int).Value = Place_id;
        conn.Open();
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
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        if (flag == 0)
        {
            SqlCommand command = new SqlCommand("SELECT * from pending_offer WHERE offer_id = @id", conn);
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;
            command.Connection = conn;
            conn.Open();
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
            SqlCommand command = new SqlCommand("SELECT * from pending_req WHERE request_id = @id", conn);
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;
            command.Connection = conn;
            conn.Open();
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

    protected void btnBan_Click(object sender, EventArgs e)
    {
        //Ban another user
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        using (SqlCommand cmd = new SqlCommand("DELETE * FROM pending_offer WHERE offer_id = @id", conn))
        {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = conn;
                
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = offer;
                //lblPendingOffer1.Visible = false;
                btnCancel.Visible = false;
                lblPendingOffer1.Text = offer.ToString();
                //Response.Redirect("JoshsTemplateAttempt.aspx");
        }
    }

    protected void btnCancel3_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        using (SqlCommand cmd = new SqlCommand("DELETE * FROM pending_req WHERE request_id = @id", conn))
        {
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = conn;

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