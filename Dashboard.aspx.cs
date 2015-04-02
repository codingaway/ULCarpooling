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
    public string userID;
    private string accLevel;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        //profileImage.ImageUrl = "~/Images/emptyProfileImage.png";

        if (Request.IsAuthenticated) //Check first if request is authenticated 
        {
            //Code to get User_ID from cookie
            getUserID();
        }

        if (!IsPostBack)
        {
            
            profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
            //Need a command to load users image from DB and display to profileImage
            //profileImage.ImageUrl = "~/DisplayImg.ashx?id=" + 3; //User_ID from cookie needed

            //Need commands to load name, email and phone from DB and display to txtName, txtEmail, txtPhone
            if (Request.IsAuthenticated) //Check first if request is authenticated 
            {
                //Code to get User_ID from cookie
               
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
                        txtOldPW.Text = pw;
                    }
                    else
                    {
                        lblPW.Text = "Error loading password";
                    }
                    reader.Close();
                }

                // Ban a user/ view list of banned users

                using(SqlCommand cmd = new SqlCommand("SELECT FName, Sname FROM users Join blocked_user on User_ID = blocked_user.blocked_user Where blocked_user.blocked_by =" + userID , conn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    //cmd.Parameters.Add("@id", SqlDbType.Int).Value = userID;
                    cmd.Connection = conn;

                    SqlDataAdapter reader = new SqlDataAdapter(cmd);
                    DataSet myDS = new DataSet();
                    reader.Fill(myDS, "BlockedUsers");
                    DataTable myDataTable = myDS.Tables[0];
                    DataRow tempRow = null;

                    foreach(DataRow tempRow_Variable in myDataTable.Rows)
                    {
                        tempRow = tempRow_Variable;
                        bannedUserLB.Items.Add((tempRow["FName"] + " " + tempRow["SName"]));
                    }
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

                //Need a command to load Notifications from DB

                //Need a command to load Trip Histories from DB
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

    protected void editDetails_Click(object sender, EventArgs e)
    {
        // Read the file and convert it to Byte Array
        string filePath = imageUpload.PostedFile.FileName;
        string filename = Path.GetFileName(filePath);
        string ext = Path.GetExtension(filename);
        string contenttype = String.Empty;

        //Set the contenttype based on File Extension
        switch (ext)
        {
            case ".jpg": contenttype = "image/jpg"; break;
            case ".png": contenttype = "image/png"; break;
            case ".gif": contenttype = "image/gif"; break;
            case ".pdf": contenttype = "application/pdf"; break;
        }
        if (contenttype != String.Empty)
        {
            Stream fs = imageUpload.PostedFile.InputStream;
            BinaryReader br = new BinaryReader(fs);
            Byte[] bytes = br.ReadBytes((Int32)fs.Length);

            HttpPostedFile File = imageUpload.PostedFile;

            fs.Close();
            br.Close();

            string[] name = (txtName.Text).Split(new Char[] { ' ' });
            string mobile = txtPhone.Text;

            //insert the file into database 
            string strQuery = "UPDATE users SET FName = @FName, SName = @Sname, Mobile = @Mobile WHERE User_ID =" + userID;
            SqlCommand cmd = new SqlCommand(strQuery);
            cmd.Parameters.Add("@FName", SqlDbType.VarChar).Value = name[0];
            cmd.Parameters.Add("@SName", SqlDbType.VarChar).Value = name[1];
            cmd.Parameters.Add("@Mobile", SqlDbType.Char).Value = mobile;
            InsertUpdateData(cmd);

            string strQuery2 = "UPDATE profile_image SET image_name = @iName, content_type = @cType, data = @data WHERE user_ID =" + userID;
            SqlCommand cmd2 = new SqlCommand(strQuery2);
            cmd2.Parameters.Add("@data", SqlDbType.Binary).Value = bytes;
            cmd2.Parameters.Add("@cType", SqlDbType.VarChar).Value = contenttype;
            cmd2.Parameters.Add("@iName", SqlDbType.VarChar).Value = filename;
            InsertUpdateData(cmd2);
        }
    }

    private Boolean InsertUpdateData(SqlCommand cmd)
    {
        SqlConnection con = new SqlConnection();
        con.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            return true;
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            return false;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    protected void btnBan_Click(object sender, EventArgs e)
    {
        //Ban another user
    }

    protected void btnUnBan_Click(object sender, EventArgs e)
    {
        //Unban a user
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