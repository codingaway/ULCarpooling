using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OfferNotifications : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void offerNotifcationsLV_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Decline")
        {
            if (e.CommandArgument != null)
            {
                //Debug.WriteLine("Hopefully the offer_id: " + e.CommandArgument);
                SqlCommand cmd2 = new SqlCommand("UPDATE offer_response SET status = @status Where user_id = " + ViewState["pID"].ToString() + " AND offer_id =" + e.CommandArgument);
                cmd2.Parameters.AddWithValue("@status", "Declined");
                InsertUpdateData(cmd2);

                Response.Redirect(Request.RawUrl);
            }
        }
        if (e.CommandName == "Confirm")
        {
            if (e.CommandArgument != null)
            {
                string seats = checkSeats(e.CommandArgument.ToString());
                if (!seats.Equals(""))
                {
                    Label error = (Label)e.Item.FindControl("lblError");
                    error.Visible = false;
                    //Debug.WriteLine("Hopefully the offer_id: " + e.CommandArgument);
                    SqlCommand cmd2 = new SqlCommand("UPDATE offer_response SET status = @status Where user_id = " + ViewState["pID"].ToString() + " AND offer_id =" + e.CommandArgument);
                    cmd2.Parameters.AddWithValue("@status", "Confirmed");
                    InsertUpdateData(cmd2);

                    SqlCommand cmd = new SqlCommand("UPDATE offer_rec SET seats = seats - 1 Where seats > 0 and offer_id =" + e.CommandArgument);
                    InsertUpdateData(cmd);

                    Response.Redirect(Request.RawUrl);
                }
                else
                {
                    Label error = (Label)e.Item.FindControl("lblError");
                    error.Visible = true;
                    error.Text = "No seats available!";
                }
            }
        }
    }
    protected void offerNotifcationsLV_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Button btn = (Button)e.Item.FindControl("btnDecline");
        Button btn2 = (Button)e.Item.FindControl("btnConfirm");
        DataRowView rowView = (DataRowView)e.Item.DataItem;
        btn.CommandArgument = rowView["offer_id"].ToString();
        btn2.CommandArgument = rowView["offer_id"].ToString();
        ViewState["pID"] = rowView["passenger_id"].ToString();
    }

    private Boolean InsertUpdateData(SqlCommand cmd)
    {
        string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
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

    private string checkSeats(string offerID)
    {
        string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = connection;
        string seats = "";
        using (SqlCommand cmd = new SqlCommand("Select seats from offer_rec Where offer_id =" + offerID, conn))
        {
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = conn;

            conn.Open();

            SqlDataReader reader = cmd.ExecuteReader();
            
            if (reader.HasRows)
            {
                seats = reader["seats"].ToString();
            }
        }
        return seats;
    }
}