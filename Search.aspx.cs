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
    protected const int FROM_LIST = 0;
    protected const int TO_LIST =  1;

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            fillDdlData(ddlTripFrom, FROM_LIST);
            fillDdlData(ddlTripTo, TO_LIST);
        }
        else
        {

        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string resultTable;

            Panel1.Visible = true;
            DateTime startDate, endDate;
            string placeFrom = null, placeTo = null;
            if (Convert.ToInt32(ddlTripFrom.SelectedValue) > 0)
                placeFrom = ddlTripFrom.SelectedValue;
            if (Convert.ToInt32(ddlTripTo.SelectedValue) > 0)
                placeTo = ddlTripTo.SelectedValue;

            string formatString = "dd/MM/yyyy HH:mm";

            bool startDateExist = DateTime.TryParseExact(txtStartDate.Text, formatString, CultureInfo.InvariantCulture, DateTimeStyles.None, out startDate);
            bool endDateExist = DateTime.TryParseExact(txtEndDate.Text, formatString, CultureInfo.InvariantCulture, DateTimeStyles.None, out endDate);

            if (chkSearchType.Checked) //Request
            {
                resultTable = "vRequestDetails";
                lblHeading.Text = "Search results: Requests";
            }
            else //Offers
            {
                resultTable = "vOfferDetails";
                lblHeading.Text = "Search results: Offers";
            }

            string selectCommand = "select * from " + resultTable;


            if (placeFrom != null || placeTo != null || startDateExist || endDateExist)
            {
                selectCommand += " where";
                bool firstFilter = true;
                if (placeFrom != null)
                {
                    selectCommand += " frm_id = " + placeFrom;
                    firstFilter = false;
                }
                if (placeTo != null)
                {
                    if (!firstFilter)
                        selectCommand += " and ";
                    selectCommand += " to_id = " + placeTo;
                    firstFilter = false;
                }
                if (startDateExist)
                {
                    if (!firstFilter)
                        selectCommand += " and ";
                    selectCommand += " date_time >= '" + startDate.ToString("yyyy-MM-dd HH:mm:ss") + "'";
                    firstFilter = false;
                }
                if (endDateExist)
                {
                    if (!firstFilter)
                        selectCommand += " and ";
                    selectCommand += " date_time <= '" + endDate.ToString("yyyy-MM-dd HH:mm:ss") + "'";
                }
            }
            SqlDataSource1.SelectCommand = selectCommand;
        }
    }


    protected void Page_PreRender(object sender, EventArgs e)
    {
    }

    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if(!chkSearchType.Checked) //Offer List
        {
            Label lblSeats = (Label)e.Item.FindControl("lblSeats");
            lblSeats.Enabled = true;
            lblSeats.Visible = true;
            DataRowView rowView = (DataRowView)e.Item.DataItem;
            lblSeats.Text += rowView["seats"].ToString();
            
            Button btn = (Button)e.Item.FindControl("btnCmd");
            btn.Text = "Send Offer";

            

        }

        if (Request.IsAuthenticated)
        {

            Panel p1 = (Panel)e.Item.FindControl("pnlAnonymous");
            Panel p2 = (Panel)e.Item.FindControl("pnlLoggedIn");

            p1.Visible = false;
            p2.Visible = true;
        }


    }

    protected void CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        fillDdlData(ddlTripFrom, FROM_LIST);
        fillDdlData(ddlTripTo, TO_LIST);
    }

    protected void ddlTripFrom_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillDdlData(ddlTripTo, TO_LIST);		
    }

    protected void fillDdlData(DropDownList ddl, int listType)
    {
        string selectTable = chkSearchType.Checked ? "req_rec" : "offer_rec";
  
        string ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(ConnectionString);

        string aQuery = "select places.place_name + ', ' + [County].[Name] as p_name, " + selectTable;
        aQuery += listType == FROM_LIST ? ".place_from " : ".place_to "; 
        aQuery += " as p_id from places inner join " + selectTable + " on places.Place_id = " + selectTable;
        aQuery += listType == FROM_LIST? ".place_from" : ".place_to";
        aQuery +=" inner join County on places.c_code = County.c_code";
        aQuery += listType == FROM_LIST? "": " WHERE " + selectTable + ".place_from = " + ddlTripFrom.SelectedValue;
        aQuery += " order by County.Name, places.place_name";

        SqlCommand aCommand = new SqlCommand(aQuery, myConnection);

        try
        {
            myConnection.Open();
            SqlDataReader aReader = aCommand.ExecuteReader();
            ddl.DataSource = aReader;
            ddl.DataTextField = "p_name";
            ddl.DataValueField = "p_id";
            ddl.Items.Clear();
            ddl.DataBind();
            aReader.Close();
        }
        finally
        {
            aCommand.Dispose();
            myConnection.Dispose();

        }
    }
}