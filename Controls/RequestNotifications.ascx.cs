using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RequestNotifications : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void requestNotifcationsLV_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Decline")
        {
            if (e.CommandArgument != null)
            {
                //Debug.WriteLine("Hopefully the offer_id: " + e.CommandArgument);
                SqlCommand cmd2 = new SqlCommand("UPDATE req_response SET status = @status Where user_id = " + ViewState["dID"].ToString() + " AND req_id =" + e.CommandArgument);
                cmd2.Parameters.AddWithValue("@status", "Declined");
                InsertUpdateData(cmd2);

                Response.Redirect(Request.RawUrl);
            }
        }
        if (e.CommandName == "Confirm")
        {
            if (e.CommandArgument != null)
            {
                 //Debug.WriteLine("Hopefully the offer_id: " + e.CommandArgument);
                 SqlCommand cmd2 = new SqlCommand("UPDATE req_response SET status = @status Where user_id = " + ViewState["dID"].ToString() + " AND req_id =" + e.CommandArgument);
                 cmd2.Parameters.AddWithValue("@status", "Confirmed");
                 InsertUpdateData(cmd2);

                 Response.Redirect(Request.RawUrl);
            }
        }
    }
    protected void requestNotifcationsLV_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Button btn3 = (Button)e.Item.FindControl("btnDecline");
        Button btn4 = (Button)e.Item.FindControl("btnConfirm");
        DataRowView rowView = (DataRowView)e.Item.DataItem;
        HyperLink hpl = (HyperLink)e.Item.FindControl("hlViewOverview");
        btn3.CommandArgument = rowView["Request_id"].ToString();
        btn4.CommandArgument = rowView["Request_id"].ToString();
        ViewState["dID"] = rowView["driver_id"].ToString();

        string request_id = rowView["Request_id"].ToString();
        string[] nameID = getDriverNameID(request_id);
        hpl.Text = nameID[1];
        hpl.NavigateUrl = ResolveClientUrl("/Overview.aspx") + "?id=" + nameID[0];
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

    protected string[] getDriverNameID(string requestID)
    {
        string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = connection;
        string[] nameID = new string[2];
        using (SqlCommand cmd = new SqlCommand("Select driver_id, driver_name  from vRequestsNotifications Where Request_id =" + requestID, conn))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            try
            {
                conn.Open();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    nameID[0] = row["driver_id"].ToString();
                    nameID[1] = row["driver_name"].ToString();
                }
            }
            finally
            {
                da.Dispose();
                conn.Dispose();
            }
        }
        return nameID;
    }
}