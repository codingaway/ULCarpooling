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


public partial class PendingOffers : System.Web.UI.UserControl
{
    public string userID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        DataBind();
        string query = "Select * FROM vOfferDetails WHERE User_ID =" + userID + " AND date_time >= GETDATE()";
        SqlDataSource2.SelectCommand = query;
        ListView2.DataBind();
    }

    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if(e.CommandName == "CancelOffer")
        {
            if (e.CommandArgument != null)
            {
                SqlCommand cmd = new SqlCommand("UPDATE offer_rec SET active = @active Where offer_id =" + e.CommandArgument);
                cmd.Parameters.AddWithValue("@active", "n");
                InsertUpdateData(cmd);

                SqlCommand cmd2 = new SqlCommand("UPDATE offer_response SET status = @status Where offer_id =" + e.CommandArgument);
                cmd.Parameters.AddWithValue("@status", "Cancelled");
                InsertUpdateData(cmd2);
            }
        }
    }

    protected void ListView2_ItemDataBound(object sender, ListViewItemEventArgs e)
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