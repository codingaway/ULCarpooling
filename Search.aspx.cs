using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

public partial class Search : System.Web.UI.Page
{
    private ASP.controls_uscofferlist_ascx uscOfferList;
    private ASP.controls_uscrequestlist_ascx uscRequestList;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string placeFrom = null, placeTo = null;
            if(ddlTripFrom.SelectedIndex > 0 )
                placeFrom = ddlTripFrom.SelectedItem.ToString();
            if(ddlTripTo.SelectedIndex > 0)
                placeTo = ddlTripTo.SelectedItem.ToString();
            
            DateTime startDate, endDate;
            string format = "dd/MM/yyyy HH:mm";
            bool startDateExist = DateTime.TryParseExact(txtStartDate.Text, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out startDate);
            bool endDateExist = DateTime.TryParseExact(txtEndDate.Text, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out endDate);

            string cmdString = "select * from";
            cmdString += " vOfferDetails";
            if(placeFrom != null || placeTo != null || startDateExist || endDateExist)
            {
                cmdString += " where";
                if (placeFrom != null)
                    cmdString += " frm_place = '" + placeFrom + "'";
                if(placeTo != null)
                    cmdString += " toplace = '" + placeTo + "'";
                if(startDateExist)
                    cmdString += " date_time >= '" + startDate.ToString("yyyy-MM-dd HH:mm:ss") + "'";
                if (endDateExist)
                    cmdString += " date_time <= '" + endDate.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            }
            

            if (chkSearchType.Checked)
            {
                uscRequestList = (ASP.controls_uscrequestlist_ascx)LoadControl("~/Controls/uscRequestList.ascx");
                PlaceHolder1.Controls.Clear();
                PlaceHolder1.Controls.Add(uscRequestList);
            }
            else
            {
                uscOfferList = (ASP.controls_uscofferlist_ascx)LoadControl("~/Controls/uscOfferList.ascx");
                PlaceHolder1.Controls.Clear();
                ListView listView = (ListView)uscOfferList.FindControl("ListView1");

                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;

                SqlCommand cmd = new SqlCommand(cmdString, conn);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                conn.Close();

                listView.DataSource = ds;
                listView.DataSourceID = null;
                listView.DataBind();

                PlaceHolder1.Controls.Add(uscOfferList);
            }
        }
    }
}