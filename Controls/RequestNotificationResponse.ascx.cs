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

public partial class RequestNotificationResponse : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RequestNotificationResponseLV_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }
    protected void RequestNotificationResponseLV_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Label lbl1 = (Label)e.Item.FindControl("lblResponse");
        DataRowView rowView = (DataRowView)e.Item.DataItem;
        HyperLink hpl = (HyperLink)e.Item.FindControl("hlViewOverview");
        string req_id = rowView["req_id"].ToString();
        string status;
        status = (rowView["status"].ToString()).Trim();
        //Debug.WriteLine("Offer id is: " + offer_id + " Status is: " + status);

        if (status.CompareTo("Confirmed") == 0)
            lbl1.Text = "Confirmed by ";
        else if (status.CompareTo("Declined") == 0)
            lbl1.Text = "Declined by ";
        else if (status.CompareTo("pending") == 0)
            lbl1.Text = "Pending confirmation from ";

        string[] nameID = getPassengerNameID(req_id);
        hpl.Text = nameID[1];
        hpl.NavigateUrl = ResolveClientUrl("/Overview.aspx") + "?id=" + nameID[0];
    }

    protected string[] getPassengerNameID(string requestID)
    {
        string connection = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = connection;
        string[] nameID = new string[2];
        using (SqlCommand cmd = new SqlCommand("Select User_ID, full_name  from vRequestDetails Where id =" + requestID, conn))
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
                    nameID[0] = row["User_ID"].ToString();
                    nameID[1] = row["full_name"].ToString();
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