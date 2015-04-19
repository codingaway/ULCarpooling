using System;
using System.Diagnostics;
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
    private string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Request.IsAuthenticated) //Check first if request is authenticated 
        {
            //Code to get User_ID from cookie
            getUserID();
            pageInit();
        }
        else
        {
            Response.Redirect("~/Default.aspx");
        }

        if (!IsPostBack)
        {
            fillModalForm();
            fillBlockedUsersForm();
        }
    }

    protected void pageInit()
    {
        switch (accLevel)
        {
            case ("3"):
                {
                    btnAddPlace.Visible = true;
                    btnReviewComplaints.Visible = true;
                    btnBan.Visible = true;
                    btnRemoveUser.Visible = true;
                    btnChangeUsersPW.Visible = true;
                    btnEditMod.Visible = true;
                    lblSiteManagement.Visible = true;
                } break;
            case ("2"):
                {
                    btnAddPlace.Visible = true;
                    btnReviewComplaints.Visible = true;
                    btnBan.Visible = true;
                    lblSiteManagement.Visible = true;
                } break;
            default: break;
        }

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = connection;
        profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
        //Need a command to load users image from DB and display to profileImage

        //Need commands to load name, email and phone from DB and display to txtName, txtEmail, txtPhone
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
                            string[] dob = (reader["dob"].ToString()).Split(new Char[] { ' ' });
                            lblDOB.Text = dob[0];
                            lblGender.Text = reader["gender"].Equals("m") ? "Male" : "Female";
                            checkBoxSmoker.Checked = reader["Smoker"].Equals("y") ? true : false;
                            profileImage.ImageUrl = "~/GetImage.aspx?ImageID=" + userID;
                    }
                }
                else
                {
                    Response.Write("No data found");
                }
                reader.Close();
        }
        //Populate the blocked list of users

            

        //Need a command to load feedback from DB to feedbackImage
        string[] ratingInfo = DBHelper.getUserReview(userID);
        if(ratingInfo != null)
        {
            lblRating.Text = ratingInfo[0];
            lblRatingCount.Text = ratingInfo[1];
        }


        //Need a command to load Notifications from DB

        conn.Close();
        
    }

    protected void fillModalForm()
    {
        txtName.Text = lblName.Text;
        txtPhone.Text = lblPhone.Text;
        genderDDL.SelectedIndex = lblGender.Text.Equals("Male") ? 0 : 1;
        chkBoxSmoker.Checked = checkBoxSmoker.Checked ? true : false;
        txtDOB.Text = lblDOB.Text;

    }

    protected void fillBlockedUsersForm()
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = connection;
        using (SqlCommand cmd = new SqlCommand("SELECT FName, Sname, blocked_user.blocked_user as blocked FROM users Join blocked_user on User_ID = blocked_user.blocked_user Where blocked_user.blocked_by =" + userID, conn))
        {
            cmd.CommandType = System.Data.CommandType.Text;
            //cmd.Parameters.Add("@id", SqlDbType.Int).Value = userID;
            cmd.Connection = conn;

            SqlDataAdapter reader = new SqlDataAdapter(cmd);
            DataSet myDS = new DataSet();
            reader.Fill(myDS, "BlockedUsers");
            DataTable myDataTable = myDS.Tables[0];
            DataRow tempRow = null;

            foreach (DataRow tempRow_Variable in myDataTable.Rows)
            {
                tempRow = tempRow_Variable;
                bannedUserLB.Items.Add((tempRow["FName"] + " " + tempRow["SName"] + " (" + tempRow["blocked"] + ")"));
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

    protected void saveDetails_Click(object sender, EventArgs e)
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

            string strQuery2 = "UPDATE profile_image SET image_name = @iName, content_type = @cType, data = @data WHERE user_ID =" + userID;
            SqlCommand cmd2 = new SqlCommand(strQuery2);
            cmd2.Parameters.Add("@data", SqlDbType.Binary).Value = bytes;
            cmd2.Parameters.Add("@cType", SqlDbType.VarChar).Value = contenttype;
            cmd2.Parameters.Add("@iName", SqlDbType.VarChar).Value = filename;
            InsertUpdateData(cmd2);
        }

        string strQuery = "UPDATE users SET FName = @FName, SName = @Sname, Mobile = @Mobile, dob = @DOB, gender = @Gender, Smoker = @Smoker WHERE User_ID =" + userID;
        SqlCommand cmd = new SqlCommand(strQuery);

        bool valid = true;
        string[] name;
        string mobile;

        if (!txtName.Text.Equals(""))
        {
            name = (txtName.Text).Split(new Char[] { ' ' });
            cmd.Parameters.Add("@FName", SqlDbType.VarChar).Value = name[0];
            cmd.Parameters.Add("@SName", SqlDbType.VarChar).Value = name[1];
        }
        else
        {
            valid = false;
        }

        if (!txtPhone.Text.Equals(""))
        {
            mobile = txtPhone.Text;
            cmd.Parameters.Add("@Mobile", SqlDbType.Char).Value = mobile;
        }
        else
        {
            valid = false;
        }

        string selectedGender = genderDDL.SelectedItem.Text;
        string smoker;
        if (!selectedGender.Equals(""))
        {
            if (selectedGender.Equals("Male"))
                cmd.Parameters.AddWithValue("@Gender", "m");
            else
                cmd.Parameters.AddWithValue("@Gender", "f");
        }
        if (chkBoxSmoker.Checked)
            smoker = "y";
        else
            smoker = "n";
        cmd.Parameters.AddWithValue("@Smoker", smoker);

        if(!txtDOB.Text.Equals(""))
        {
            cmd.Parameters.AddWithValue("@DOB", txtDOB.Text);
        }
        else
        {
            valid = false;
        }

        if (valid)
        {
            InsertUpdateData(cmd);
            Page_Load(sender, e);
        }
    }

    private Boolean InsertUpdateData(SqlCommand cmd)
    {
        SqlConnection con = new SqlConnection();
        con.ConnectionString = connection;
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

    //protected void btnBlock_Click(object sender, EventArgs e)
    //{
    //    // block user to user
    //}

    protected void btnUnBlock_Click(object sender, EventArgs e)
    {
        if(bannedUserLB.SelectedItem != null)
        {
            //SqlConnection conn = new SqlConnection();
            //conn.ConnectionString = connection;

            string item = bannedUserLB.SelectedItem.ToString();
            int index = item.IndexOf("(");
            int blockedUser = Int32.Parse(item.Substring((index + 1), 1));
            //Debug.WriteLine("Blocked userID: " + blockedUser);
            SqlCommand cmd = new SqlCommand("DELETE FROM blocked_user WHERE blocked_by =" + userID + " AND blocked_user = " + blockedUser);
            InsertUpdateData(cmd);
        }
    }

    protected void btnBan_Click(object sender, EventArgs e)
    {
        //Admin ban a user
    }

    protected void btnUnBan_Click(object sender, EventArgs e)
    {
        //Admin unban
    }

    protected void addPlace_Click(object sender, EventArgs e)
    {
        //admin add place
    }

    protected void removeComp_Click(object sender, EventArgs e)
    {
        //admin remove complaints
    }

    protected void changeUserPW_Click(object sender, EventArgs e)
    {
        //admin change users pw
    }

    protected void btnRemoveUser_Click(object sender, EventArgs e)
    {
        //admin remove a user 
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //remove a pending offer/request
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