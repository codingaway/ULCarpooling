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

        //if (!IsPostBack)
        //{
        //    string query = "Select * FROM vOfferDetails WHERE User_ID =" + userID + " AND date_time >= GETDATE()";
        //    SqlDataSource2.SelectCommand = query;
        //    ListView2.DataBind();
        //}
        //else
        //{

        //}
    }

    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if(e.CommandName == "CancelOffer")
        {
            if (e.CommandArgument != null)
            {
                string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = connection;
                

                using (SqlCommand cmd = new SqlCommand("UPDATE offer_rec SET active Where offer_id =" + e.CommandArgument, conn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = conn;
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }
                    finally
                    {
                        conn.Close();
                        conn.Dispose();
                    }

                }
            }
        }
    }
    protected void ListView2_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Button btn = (Button)e.Item.FindControl("btnCancelOffer");
        DataRowView rowView = (DataRowView)e.Item.DataItem;
        btn.CommandArgument = rowView["id"].ToString();
    }
}