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
using System.Diagnostics;


public partial class PendingOffers : System.Web.UI.UserControl
{


    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void pendingOffersLV_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "ItemCommand")
        {
            if (e.CommandArgument != null)
            {
                Debug.WriteLine("Hopefully the offer_id: " + e.CommandArgument);
                SqlCommand cmd = new SqlCommand("UPDATE offer_rec SET active = @active Where offer_id =" + e.CommandArgument);
                cmd.Parameters.AddWithValue("@active", "n");
                InsertUpdateData(cmd);


                Debug.WriteLine("Hopefully the offer_id: " + e.CommandArgument);
                SqlCommand cmd2 = new SqlCommand("UPDATE offer_response SET status = @status Where offer_id =" + e.CommandArgument);
                cmd2.Parameters.AddWithValue("@status", "Cancelled");
                InsertUpdateData(cmd2);
            }
        }
    }

    protected void pendingOffersLV_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Button btn = (Button)e.Item.FindControl("btnCancelOffer");
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