using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;


public partial class PendingRequests : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void pendingRequestsLV_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "ItemCommand")
        {
            if (e.CommandArgument != null)
            {
                SqlCommand cmd = new SqlCommand("UPDATE req_rec SET active = @active Where Request_id =" + e.CommandArgument);
                cmd.Parameters.AddWithValue("@active", "n");
                InsertUpdateData(cmd);

                SqlCommand cmd2 = new SqlCommand("UPDATE req_response SET status = @status Where req_id =" + e.CommandArgument);
                cmd2.Parameters.AddWithValue("@status", "Cancelled");
                InsertUpdateData(cmd2);
            }
        }
    }

    protected void pendingRequestsLV_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Button btn = (Button)e.Item.FindControl("btnCancelRequest");
        DataRowView rowView = (DataRowView)e.Item.DataItem;
        btn.CommandArgument = rowView["id"].ToString();
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
}