using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OfferNotificationResponse : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void OfferNotificationResponseLV_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }

    protected void OfferNotificationResponseLV_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

        Label lbl1 = (Label)e.Item.FindControl("lblResponse");
        DataRowView rowView = (DataRowView)e.Item.DataItem;
        string offer_id = rowView["offer_id"].ToString();
        string status;
        status = (rowView["status"].ToString()).Trim();
        //Debug.WriteLine("Offer id is: " + offer_id + " Status is: " + status);

        if(status.CompareTo("Confirmed") == 0)
            lbl1.Text = " has accepted your request for a lift";
        else if (status.CompareTo("Declined") == 0)
            lbl1.Text = " has declined your request for a lift";

        Label lbl2 = (Label)e.Item.FindControl("lblName");
        lbl2.Text = getDriverName(offer_id);
    }

    protected string getDriverName(string offerID)
    {
        string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = connection;
        string name = "";
        using (SqlCommand cmd = new SqlCommand("Select * from vOfferDetails Where id =" + offerID, conn))
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
                    name = row["full_name"].ToString();
                }
            }
            finally
            {
                da.Dispose();
                conn.Dispose();
            }
        }
        return name;
    }
}