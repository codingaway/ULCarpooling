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
using System.Globalization;


public partial class Dashboard : System.Web.UI.Page
{
    public string userID;
    private string accLevel;
    private string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.IsAuthenticated)
        {
            Response.Redirect("~/Default.aspx");
        }

        if (!IsPostBack)
        {
            //Code to get User_ID from cookie
            getUserID();
            ViewState["userID"] = userID;
            ViewState["AccessID"]= accLevel;
            pageInit();

            for (int i = 1; i < 9; i++)
            {
                dataBind(i);
            }

            fillModalForm();
            fillBlockedUsersForm();
        }
        else
        {
            userID = ViewState["userID"].ToString();
            accLevel = ViewState["AccessID"].ToString();
        }
    }

    protected void pageInit()
    {
        switch (accLevel)
        {
            case ("3"):
                {
                    btnAddPlace.Visible = true;
                    //btnReviewComplaints.Visible = true;
                    btnBan.Visible = true;
                    btnRemoveUser.Visible = true;
                    btnChangeUsersPW.Visible = true;
                    btnEditMod.Visible = true;
                    lblSiteManagement.Visible = true;
                    lblRecentlyAdded.Visible = true;
                    //lblBanActivity.Visible = true;
                    //lblPassActivity.Visible = true;
                    //editModActivity.Visible = true;
                    //lblRemoveUser.Visible = true;
                    loadUserLists();
                    loadUserEmailAdd();
                    loadModEmailAdd();
                    userRemovalList();
                    loadCountyList();
                } break;
            case ("2"):
                {
                    btnAddPlace.Visible = true;
                    //btnReviewComplaints.Visible = true;
                    btnBan.Visible = true;
                    lblSiteManagement.Visible = true;
                    lblRecentlyAdded.Visible = true;
                    //lblBanActivity.Visible = true;
                    loadUserLists();
                    loadCountyList();
                } break;
            default: break;
        }

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = connection;
        profileImage.ImageUrl = "~/Images/emptyProfileImage.png";
        //Need a command to load users image from DB and display to profileImage

        //Need commands to load name, email and phone from DB and display to txtName, txtEmail, txtPhone
        using (SqlCommand cmd = new SqlCommand("Select User_ID, FName, SName, Email, Mobile, FORMAT(dob, 'dd/MM/yyyy', 'en-gb') as dob, Smoker, cat_no, gender from users Where User_ID =" + userID, conn))
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
            

        //Need a command to load feedback from DB to feedbackImage
        string[] ratingInfo = DBHelper.getUserReview(userID);
        if (ratingInfo != null)
        {
            lblRating.Text = ratingInfo[0];
            lblRatingCount.Text = ratingInfo[1];
        }

        //Need a command to load Notifications from DB

        conn.Close();
        
    }

    protected void dataBind(int num)
    {
        //ListView active;
        string query = "";
        ListView active = new ListView();

        switch(num)
        {
            case(1):{
                query = "Select * FROM vOfferDetails WHERE User_ID =" + userID + " AND date_time >= GETDATE()";
                active = (ListView)PendingOffers.FindControl("pendingOffersLV");
            } break;
            case(2):{
                query = "Select * FROM vRequestDetails WHERE User_ID =" + userID + " AND date_time >= GETDATE()";
                active = (ListView)PendingRequests.FindControl("pendingRequestsLV");
            } break;
            case (3):{
                query = "Select offer_rec.offer_id, p1.place_name as frm_place, p2.place_name as to_place, offer_rec.date_time FROM offer_rec join places p1 on offer_rec.place_from = p1.Place_id join places p2 on offer_rec.place_to = p2.Place_id WHERE user_id = " + userID + " AND date_time < GETDATE()";
                active = (ListView)OfferHistory.FindControl("completedOffersLV");
            } break;
            case (4):{
                query = "Select req_rec.Request_id, p1.place_name as frm_place, p2.place_name as to_place, req_rec.date_time FROM req_rec join places p1 on req_rec.place_from = p1.Place_id join places p2 on req_rec.place_to = p2.Place_id WHERE user_id = " + userID + " AND date_time < GETDATE()";
                active = (ListView)RequestHistory.FindControl("completedRequestsLV");
            } break;
            case (5):{
                query = "Select * FROM vOfferNotifications WHERE driver_id =" + userID + " AND date_time >= GETDATE()";
                active = (ListView)OfferNotifications.FindControl("offerNotifcationsLV");
            } break;
            case (6):{
                query = "Select * FROM vRequestsNotifications WHERE passenger_id =" + userID + " AND date_time >= GETDATE()";
                active = (ListView)RequestNotifications.FindControl("requestNotifcationsLV");
            } break;
            case (7):{
                query = "Select offer_id, status FROM offer_response where user_id = " + userID + " AND r_date >= GETDATE() - 1";
                active = (ListView)OfferNotificationResponse.FindControl("OfferNotificationResponseLV");
            } break;
            case (8):{
                query = "Select req_id, status FROM req_response where user_id = " + userID + " AND r_date >= GETDATE() - 1";
                active = (ListView)RequestNotificationResponse.FindControl("RequestNotificationResponseLV");
            } break;
            default: break;
        }
        

        SqlConnection myConnection = new SqlConnection(connection);
        SqlCommand cmd = new SqlCommand(query, myConnection);
        try
        {
            myConnection.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            active.DataSource = ds;
            active.DataBind();
        }
        finally
        {
            cmd.Dispose();
            myConnection.Dispose();
        }
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

            string strQuery2 = "";

            if(isImageExist(userID))
            {
                strQuery2 = "UPDATE profile_image SET image_name = @iName, content_type = @cType, data = @data WHERE user_ID =" + userID;
            }
            else
            {
                strQuery2 = "INSERT into profile_image(user_ID, image_name, content_type, data) VALUES(" + userID + ", @iName, @cType, @data)";
            }

            
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

        if (!txtDOB.Text.Equals(""))
        {
            //Localized the date format
            DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime dob = Convert.ToDateTime(txtDOB.Text, dateInfo);
            cmd.Parameters.AddWithValue("@DOB", dob);
        }
        else
        {
            valid = false;
        }

        if(!txtNewPW.Text.Equals("") && txtNewPW.Text.Equals(txtConPW.Text))
        {
            string newPw = txtNewPW.Text.Trim();
                
            if(!txtOldPW.Text.Equals("")  && DBHelper.verifyUser(lblEmail.Text, txtOldPW.Text))
            {
                DBHelper.changePassword(lblEmail.Text, newPw);
            }
        }

        if (valid)
        {
            InsertUpdateData(cmd);
            //Page_Load(sender, e);
            Response.Redirect(Request.RawUrl);
        }
    }

    private bool isImageExist(string userID)
    {
        bool imageExist = false;

        try
        {
            string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = conString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("select count(*) from profile_image where user_ID = @userID", conn);
            SqlParameter param = new SqlParameter();
            param.ParameterName = "@userID";
            param.Value = userID;
            cmd.Parameters.Add(param);
            int count = (int)cmd.ExecuteScalar();
            if (count > 0)
                imageExist = true;
            cmd.Dispose();
            conn.Dispose();
        }
        catch (SqlException ex)
        {}
       
        return imageExist;
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

    protected void btnUnBlock_Click(object sender, EventArgs e)
    {
        if(bannedUserLB.SelectedItem != null)
        {
            string item = bannedUserLB.SelectedItem.ToString();
            int index = item.IndexOf("(");
            int blockedUser = Int32.Parse(item.Substring((index + 1), 1));
            SqlCommand cmd = new SqlCommand("DELETE FROM blocked_user WHERE blocked_by =" + userID + " AND blocked_user = " + blockedUser);
            InsertUpdateData(cmd);

            Response.Redirect(Request.RawUrl);
        }
    }

    protected void btnBan_Click(object sender, EventArgs e)
    {
        //Admin ban a user
        string newQuery = "UPDATE user_secret SET Access_level = 0 WHERE User_ID = " + ddlUsers.SelectedValue;
        string aQuery = "IF (NOT EXISTS(SELECT User_ID FROM Banned_user WHERE User_ID = " + ddlUsers.SelectedValue + "))" +
                     "BEGIN " +
                        "INSERT INTO Banned_User(User_ID, duration) " +
                        "VALUES(" + ddlUsers.SelectedValue + ", '" + ddlSelectDuration.Text + "')" +
                     "END ELSE " +
                     "BEGIN " +
                        "UPDATE Banned_User " +
                        "SET start_date = GetDate(), " +
                        "duration = '" + ddlSelectDuration.Text + "', " +
                        "ban_count = (ban_count + 1), " +
                        "active = 'y'" +
                        "WHERE User_ID = " + ddlUsers.SelectedValue + " END";

        string q1 = "UPDATE offer_rec SET active = 'n' WHERE User_ID = " + ddlUsers.SelectedValue;
        string q2 = "UPDATE req_rec SET active = 'n' WHERE User_ID = " + ddlUsers.SelectedValue;

        SqlCommand cmd = new SqlCommand(q1);
        InsertUpdateData(cmd);
        SqlCommand cmd2 = new SqlCommand(q2);
        InsertUpdateData(cmd2);

        SqlCommand newCommand = new SqlCommand(newQuery);
        InsertUpdateData(newCommand);
        SqlCommand aCommand = new SqlCommand(aQuery);
        InsertUpdateData(aCommand);
        //lblBanActivity.Text = "Added " + ddlUsers.DataTextField + " to ban list";
        Response.Redirect(Request.RawUrl);
    }

    protected void btnUnBan_Click(object sender, EventArgs e)
    {
        ////Admin unban
        ////Set Access_level of selected user to 1 
        ////Set 'active' attribute in Banned_user table to 'n' for selected user
        string newQuery = "UPDATE user_secret SET Access_level = 1 WHERE User_ID =" + ddlBannedUsers.SelectedValue;
        string aQuery = "UPDATE Banned_user " +
                        "SET active = 'n' " +
                        "WHERE User_ID =" + ddlBannedUsers.SelectedValue;
        SqlCommand newCommand = new SqlCommand(newQuery);
        SqlCommand aCommand = new SqlCommand(aQuery);
        InsertUpdateData(newCommand);
        InsertUpdateData(aCommand);
        lblBanActivity.Text = "Removed " + ddlBannedUsers.SelectedValue + " from ban list";
        Response.Redirect(Request.RawUrl);
    }

    protected void addPlace_Click(object sender, EventArgs e)
    {
        string area = txtArea.Text.ToString();
        string town = txtTown.Text.ToString();
        if (area == "")
        {
            //Cannot add empty string to places table
            lblRecentlyAdded.Text = "No new location added";
        }
        else
        {
            if (!(town == ""))
            {
                //append town string to area string
                area += ", " + town;
            }
            string newQuery = "INSERT INTO places (place_name, c_code) " +
                              "values('" + area + "', " + ddlSelectCounty.SelectedValue + ")";
            SqlCommand newCommand = new SqlCommand(newQuery);
            InsertUpdateData(newCommand);
            lblRecentlyAdded.Text = "Recently Added " + area;
            txtTown.Text = "";
            txtArea.Text = "";
            //lblCountySelected.Text = ", " + ddlSelectCounty.Text.ToString();
            //lblCountySelected.Text = "Number Selected: " + cCode;
        }
    }

    protected void loadCountyList()
    {
        //method to instantiate county DropDownList for 
        //add new place/location modal
        SqlConnection newConnection = new SqlConnection();
        newConnection.ConnectionString = connection;
        SqlCommand newCommand = new SqlCommand();
        SqlDataReader newDataReader;
        string newQuery = "SELECT c_code, Name FROM County";
        newCommand = new SqlCommand(newQuery, newConnection);
        newConnection.Open();
        newDataReader = newCommand.ExecuteReader();
        ddlSelectCounty.DataSource = newDataReader;
        ddlSelectCounty.DataTextField = "Name";
        ddlSelectCounty.DataValueField = "c_code";
        ddlSelectCounty.DataBind();
        newDataReader.Close();
        newConnection.Close();
    }

    protected void removeComp_Click(object sender, EventArgs e)
    {
        //admin remove complaints
    }

    protected void changeUserPW_Click(object sender, EventArgs e)
    {
        //admin change users pw
        //Send to DBHelper.cs changePassword method
        //takes two arguments, email string and new password string
        string userEmail = ddlUserEmail.SelectedValue;
        string passW = newPass.Text;
        string passC = newPassConfirm.Text;
        if (passW == "")
        {
            lblPassActivity.Text = "Error: No password entered!";
        }
        else
        {
            if (!(passW.Equals(passC)))
            {
                lblPassActivity.Text = "Error: Passwords do not match";
            }
            else
            {
                //pass email and password strings to DBHelper changePassword method
                DBHelper.changePassword(userEmail, passW);
                lblPassActivity.Text = "Changed password for: " + userEmail;
            }
        }
    }

    protected void loadUserEmailAdd()
    {
        //method to instantiate email address lists for 
        //admin changing user password modal
        SqlConnection newConnection = new SqlConnection();
        newConnection.ConnectionString = connection;
        SqlCommand newCommand = new SqlCommand();
        SqlDataReader newDataReader;
        string newQuery = "SELECT users.Email, users.User_ID as id, users.FName + ' ' + users.SName as full_name FROM users JOIN user_secret on users.User_ID = user_secret.User_ID WHERE user_secret.Access_level = 1 OR  users.User_ID IN (SELECT User_ID FROM Banned_user)";
        newCommand = new SqlCommand(newQuery, newConnection);
        newConnection.Open();
        newDataReader = newCommand.ExecuteReader();
        ddlUserEmail.DataSource = newDataReader;
        ddlUserEmail.DataTextField = "full_name";
        ddlUserEmail.DataValueField = "Email";
        ddlUserEmail.DataBind();
        newDataReader.Close();
        newConnection.Close();
    }

    protected void loadUserLists()
    {
        //method to instantiate lists for users and banned users for Ban/Unban modal
        SqlConnection newConnection = new SqlConnection();
        newConnection.ConnectionString = connection;
        SqlCommand newCommand = new SqlCommand();
        SqlCommand aCommand = new SqlCommand();
        SqlDataReader newDataReader;
        SqlDataReader aDataReader;
        string newQuery = "SELECT users.User_ID as id, users.FName + ' ' + users.SName + ' (' + CONVERT(varchar, users.User_ID) + ')' as full_name, " +
                          "Banned_user.User_ID FROM users JOIN Banned_user " +
                          "ON users.User_ID = Banned_user.User_ID " +
                          "WHERE active = 'y'";
        string aQuery = "SELECT * FROM vGetUserNameID";
            
            //"SELECT users.User_ID as id, users.FName + ' ' + users.SName _ ' (' + as full_name " + 
            //"FROM users JOIN user_secret on users.User_ID = user_secret.User_ID " + 
            //"WHERE users.User_ID  NOT IN (SELECT User_ID FROM  Banned_user WHERE active = 'y') " + 
            //"AND user_secret.Access_level = 1";
        newCommand = new SqlCommand(newQuery, newConnection);
        aCommand = new SqlCommand(aQuery, newConnection);
        newConnection.Open();
        newDataReader = newCommand.ExecuteReader();
        ddlBannedUsers.DataSource = newDataReader;
        ddlBannedUsers.DataTextField = "full_name"; //How to concatenate FName and SName?
        ddlBannedUsers.DataValueField = "id";
        ddlBannedUsers.DataBind();
        newDataReader.Close();
        if (ddlBannedUsers.Items.Count == 0)
        {
            btnUnbanUser.Enabled = false;
        }
        aDataReader = aCommand.ExecuteReader();
        ddlUsers.DataSource = aDataReader;
        ddlUsers.DataTextField = "full_name";
        ddlUsers.DataValueField = "id";
        ddlUsers.DataBind();
        aDataReader.Close();
        newConnection.Close();
    }

    protected void btnAddMod_Click(object sender, EventArgs e)
    {
        //admin add mod
        //set Access_level in user_secret table to 2
        SqlConnection newConnection = new SqlConnection();
        newConnection.ConnectionString = connection;
        SqlCommand newCommand = new SqlCommand();
        string newQuery = "UPDATE user_secret " +
                          "SET Access_level=2 " +
                          "WHERE User_ID = " + ddlUsersToMod.SelectedValue;
        newCommand = new SqlCommand(newQuery, newConnection);
        newConnection.Open();
        newCommand.ExecuteNonQuery();
        newConnection.Close();
        editModActivity.Text = "Gave mod privileges to " + ddlUsersToMod.SelectedValue;
        Response.Redirect(Request.RawUrl);
    }

    protected void btnRemoveMod_Click(object sender, EventArgs e)
    {
        string newQuery = "UPDATE user_secret SET Access_level=1 " +
                          "WHERE User_ID = " + ddlRemoveMod.SelectedValue;
        SqlCommand newCommand = new SqlCommand(newQuery);
        InsertUpdateData(newCommand);
        editModActivity.Text = "Removed mod privileges from " + ddlRemoveMod.SelectedValue;
        loadModEmailAdd();
    }

    protected void loadModEmailAdd()
    {
        //method to instantiate email address lists for 
        //admin to give mod privileges

        SqlConnection newConnection = new SqlConnection();
        newConnection.ConnectionString = connection;
        SqlCommand newCommand = new SqlCommand();
        SqlCommand aCommand = new SqlCommand();
        SqlDataReader newDataReader;
        SqlDataReader aDataReader;
        string newQuery = "SELECT user_secret.User_ID as id, users.FName + ' ' + users.SName + ' (' + CONVERT(varchar, user_secret.User_ID) + ')' as full_name " +
                          "FROM users INNER JOIN user_secret " +
                          "ON users.User_ID=user_secret.User_ID " +
                          "WHERE user_secret.Access_level=2";
        string aQuery = "SELECT user_secret.User_ID as id, users.FName + ' ' + users.SName + ' (' + CONVERT(varchar, user_secret.User_ID) + ')' as full_name " +
                        "FROM users INNER JOIN user_secret " +
                        "ON users.User_ID=user_secret.User_ID " +
                        "WHERE user_secret.Access_level=1";
        newCommand = new SqlCommand(newQuery, newConnection);
        aCommand = new SqlCommand(aQuery, newConnection);
        newConnection.Open();
        newDataReader = newCommand.ExecuteReader();
        ddlRemoveMod.DataSource = newDataReader;
        
        ddlRemoveMod.DataTextField = "full_name";
        ddlRemoveMod.DataValueField = "id";
        ddlRemoveMod.DataBind();
        newDataReader.Close();
        if (ddlRemoveMod.Items.Count == 0)
        {
            Button1.Enabled = false;
        }
        aDataReader = aCommand.ExecuteReader();
        ddlUsersToMod.DataSource = aDataReader;
        ddlUsersToMod.DataTextField = "full_name";
        ddlUsersToMod.DataValueField = "id";
        ddlUsersToMod.DataBind();
        aDataReader.Close();
        newConnection.Close();
    }

    protected void btnRemoveUser_Click(object sender, EventArgs e)
    {
        //admin remove a user 
        //set access level to 0
        //remove user's records from Banned_user table if they exist
        SqlConnection newConnection = new SqlConnection();
        newConnection.ConnectionString = connection;
        //SqlCommand newCommand = new SqlCommand();
        string newQuery = "UPDATE user_secret SET Access_level=0 " +
                         "WHERE User_ID = " + ddlRemoveUser.SelectedValue;
        string aQuery = "DELETE FROM Banned_user " +
                        "WHERE User_ID = " + ddlRemoveUser.SelectedValue;
        string q1 = "UPDATE offer_rec SET active = 'n' WHERE User_ID = " + ddlRemoveUser.SelectedValue;
        string q2 = "UPDATE req_rec SET active = 'n' WHERE User_ID = " + ddlRemoveUser.SelectedValue;

        SqlCommand aCommand = new SqlCommand();
        aCommand = new SqlCommand(aQuery, newConnection);

        SqlCommand newCommand = new SqlCommand(newQuery);
        SqlCommand cmd = new SqlCommand(q1);
        SqlCommand cmd2 = new SqlCommand(q2);

        newConnection.Open();
        //newCommand.ExecuteNonQuery();
        aCommand.ExecuteNonQuery();
        newConnection.Close();

        InsertUpdateData(newCommand);
        //InsertUpdateData(aCommand);
        InsertUpdateData(cmd);
        InsertUpdateData(cmd2);

        lblRemoveUser.Text = "Removed " + ddlRemoveUser.SelectedValue;
        //userRemovalList();
        Response.Redirect(Request.RawUrl);
    }

    protected void userRemovalList()
    {
        //method to instantiate lists for 
        //admin removal of user(s)
        SqlConnection newConnection = new SqlConnection();
        newConnection.ConnectionString = connection;
        SqlCommand newCommand = new SqlCommand();
        SqlDataReader newDataReader;
        string newQuery = "SELECT users.User_ID as id, users.FName + ' ' + users.SName as full_name FROM users JOIN user_secret on users.User_ID = user_secret.User_ID WHERE user_secret.Access_level = 1 OR  users.User_ID IN (SELECT User_ID FROM Banned_user)";
        newCommand = new SqlCommand(newQuery, newConnection);
        newConnection.Open();
        newDataReader = newCommand.ExecuteReader();
        ddlRemoveUser.DataSource = newDataReader;
        ddlRemoveUser.DataTextField = "full_name";
        ddlRemoveUser.DataValueField = "id";
        ddlRemoveUser.DataBind();
        newDataReader.Close();
        newConnection.Close();
    }
}