using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_RequestHistory : System.Web.UI.UserControl
{
    private string userID, accLevel;
    private string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void completedRequestsLV_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName != null)
        {
            switch (e.CommandName)
            {
                case ("Review"):
                    {
                        if (e.CommandArgument != null)
                        {
                            setContent(1, e);
                            ViewState["table"] = "Reviews";
                            ViewState["request_id"] = e.CommandArgument;
                        }
                    } break;
                case ("Report"):
                    {
                        if (e.CommandArgument != null)
                        {
                            setContent(2, e);
                            ViewState["table"] = "Complaints";
                            ViewState["request_id"] = e.CommandArgument;
                        }
                    } break;
                case ("Submit"):
                    {
                        setContent(3, e);

                    } break;
                case ("Close"):
                    {
                        setContent(4, e);
                    } break;

                default: break;
            }
        }
    }

    protected void completedRequestsLV_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Button btn3 = (Button)e.Item.FindControl("btnReview2");
        Button btn4 = (Button)e.Item.FindControl("btnReport2");

        DataRowView rowView = (DataRowView)e.Item.DataItem;
        btn3.CommandArgument = rowView["Request_id"].ToString();
        btn4.CommandArgument = rowView["Request_id"].ToString();
    }

    protected void setContent(int num, ListViewCommandEventArgs e)
    {
        Label errorLabel = (Label)e.Item.FindControl("lblError2");
        errorLabel.Visible = false;

        if (num == 1)
        {
            Panel panel = (Panel)e.Item.FindControl("contentPanel2");
            panel.Visible = true;
            Label lbl = (Label)e.Item.FindControl("lblListBox2");
            lbl.Text = "Select user to review";
            Label lbl2 = (Label)e.Item.FindControl("lblTextBox2");
            lbl2.Text = "Review comment";
            Label lbl3 = (Label)e.Item.FindControl("lblRating2");
            lbl3.Visible = true;
            lbl3.Text = "Select rating";

            Label lbl7 = (Label)e.Item.FindControl("lblBlock2");
            lbl7.Visible = false;
            CheckBox chk = (CheckBox)e.Item.FindControl("blockCB2");
            chk.Visible = false;
            string offerID = e.CommandArgument.ToString();
            fillList(offerID, e);

            DropDownList ddl = (DropDownList)e.Item.FindControl("ratingDDL2");
            ddl.Visible = true;
        }
        else if (num == 2)
        {
            Panel panel = (Panel)e.Item.FindControl("contentPanel2");
            panel.Visible = true;
            Label lbl4 = (Label)e.Item.FindControl("lblListBox2");
            lbl4.Text = "Select user to report";
            Label lbl5 = (Label)e.Item.FindControl("lblTextBox2");
            lbl5.Text = "Report comment";
            string offerID = e.CommandArgument.ToString();
            fillList(offerID, e);

            CheckBox chk = (CheckBox)e.Item.FindControl("blockCB2");
            chk.Visible = true;
            Label lbl8 = (Label)e.Item.FindControl("lblBlock2");
            lbl8.Visible = true;
            lbl8.Text = "Check to block user";
            Label lbl6 = (Label)e.Item.FindControl("lblRating2");
            lbl6.Visible = false;
            DropDownList ddl = (DropDownList)e.Item.FindControl("ratingDDL2");
            ddl.Visible = false;
        }
        else if (num == 3)
        {
            //get selected user in list box
            bool valid = true;
            int selectedUser = 0;
            ListBox lb = (ListBox)e.Item.FindControl("tripUsersLB2");
            if (lb.SelectedIndex != -1)
            {
                string item = lb.SelectedItem.ToString();
                int index = item.IndexOf("(");
                selectedUser = Int32.Parse(item.Substring((index + 1), 1));
            }
            else
                valid = false;

            //get comment from text box
            TextBox tb = (TextBox)e.Item.FindControl("txtComment2");
            string comment = tb.Text;
            if (comment.Equals(""))
                valid = false;

            //get rating from drop down list if it is visible
            DropDownList ddl = (DropDownList)e.Item.FindControl("ratingDDL2");
            int rating = 0;
            if (ddl.Visible)
            {
                rating = Int32.Parse(ddl.SelectedItem.Text);
            }

            bool block = false;
            CheckBox chk = (CheckBox)e.Item.FindControl("blockCB2");
            if (chk.Visible)
            {
                if (chk.Checked)
                    block = true;
            }
            //get user id
            getUserID();

            //string table = ViewState["table"].ToString();
            SqlCommand cmd;
            if (ViewState["table"].Equals("Reviews"))
            {
                cmd = new SqlCommand("Insert into Reviews(user_id, reviewed_by, listing_id, listing_type, rating, comment, submit_date) Values(@userID, @reviewedBy, @listingID, @listingType, @rating, @comment, @sumbmitDate)");
                cmd.Parameters.AddWithValue("@userID", selectedUser);
                cmd.Parameters.AddWithValue("@reviewedBy", userID);
                cmd.Parameters.AddWithValue("@listingID", ViewState["request_id"].ToString());
                cmd.Parameters.AddWithValue("@listingType", "RQ");
                cmd.Parameters.AddWithValue("@rating", rating);
                cmd.Parameters.AddWithValue("@comment", comment);
                cmd.Parameters.AddWithValue("@submitDate", DateTime.Now);

                if (valid)
                {
                    if (!InsertUpdateData(cmd))
                    {
                        errorLabel.Visible = true;
                        errorLabel.Text = "Error review already made!";
                    }
                    else
                    {
                        errorLabel.Visible = false;
                        Panel panel = (Panel)e.Item.FindControl("contentPanel2");
                        panel.Visible = false;
                    }
                    //
                }
                else
                {
                    errorLabel.Visible = true;
                    errorLabel.Text = "Invlaid submit!";
                }
            }

            else if (ViewState["table"].Equals("Complaints"))
            {
                cmd = new SqlCommand("Insert into Complaints(com_by, com_for, listing_id, listing_type, Details) Values(@complaintBy, @complaintFor, @listingID, @listingType, @details)");
                cmd.Parameters.AddWithValue("@complaintBy", userID);
                cmd.Parameters.AddWithValue("@complaintFor", selectedUser);
                cmd.Parameters.AddWithValue("@listingID", ViewState["request_id"].ToString());
                cmd.Parameters.AddWithValue("@listingType", "RQ");
                cmd.Parameters.AddWithValue("@details", comment);

                if (valid)
                {
                    if (!InsertUpdateData(cmd))
                    {
                        errorLabel.Visible = true;
                        errorLabel.Text = "Error complaint already made!";
                    }
                    if (block)
                    {
                        if (!blockUser(selectedUser))
                        {
                            errorLabel.Visible = true;
                            errorLabel.Text = "User blocked already";
                        }
                        else
                        {
                            errorLabel.Visible = false;
                            Panel panel = (Panel)e.Item.FindControl("contentPanel2");
                            panel.Visible = false;
                            Response.Redirect(Request.RawUrl);
                        }
                    }
                    else
                    {
                        //need to display a confirmation message
                        errorLabel.Visible = false;
                        Panel panel = (Panel)e.Item.FindControl("contentPanel2");
                        panel.Visible = false;
                        Response.Redirect(Request.RawUrl);
                    }
                }
                else
                {
                    errorLabel.Visible = true;
                    errorLabel.Text = "Invalid submit!";
                }
            }
        }
        else
        {
            Panel panel = (Panel)e.Item.FindControl("contentPanel");
            panel.Visible = false;
            errorLabel.Text = "";
            errorLabel.Visible = false;
            TextBox tb = (TextBox)e.Item.FindControl("txtComment");
            tb.Text = "";
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

    protected void fillList(string argument, ListViewCommandEventArgs e)
    {
        ListBox lb = (ListBox)e.Item.FindControl("tripUsersLB2");
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = connection;
        string query = "SELECT driver_name, driver_id FROM vCompletedRequests Where Request_id =" + argument;


        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = conn;

            SqlDataAdapter reader = new SqlDataAdapter(cmd);
            DataSet myDS = new DataSet();
            reader.Fill(myDS, "TripUsers");
            DataTable myDataTable = myDS.Tables[0];
            DataRow tempRow = null;
            lb.Items.Clear();
            foreach (DataRow tempRow_Variable in myDataTable.Rows)
            {
                tempRow = tempRow_Variable;
                lb.Items.Add((tempRow["driver_name"] + " (" + tempRow["driver_id"] + ")"));
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

    protected Boolean blockUser(int selectedUser)
    {
        SqlCommand cmd = new SqlCommand("Insert into blocked_user(blocked_by, blocked_user) Values(@blockedBy, @blockedUser)");
        cmd.Parameters.AddWithValue("@blockedBy", userID);
        cmd.Parameters.AddWithValue("@blockedUser", selectedUser);
        if (!InsertUpdateData(cmd))
        {
            return false;
        }
        else
            return true;

    }
}