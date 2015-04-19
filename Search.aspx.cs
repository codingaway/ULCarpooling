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
using System.Text.RegularExpressions;

public partial class Search : System.Web.UI.Page
{
    protected int searchType;

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if(!IsPostBack)
        {
            rblSearchOption.SelectedIndex = 0;
            initFromList();
            initToList();
        }
        else
        {
            searchType = rblSearchOption.SelectedIndex == 0 ? DBHelper.OFFER_LIST : DBHelper.REQ_LIST;
            ResultList.listType = searchType;

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
            if (ddlTripFrom.SelectedIndex > 0)
                placeFrom = ddlTripFrom.SelectedValue;
            if (ddlTripTo.SelectedIndex > 0)
                placeTo = ddlTripTo.SelectedValue;

            string formatString = "dd/MM/yyyy HH:mm";

            bool startDateExist = DateTime.TryParseExact(txtStartDate.Text, formatString, CultureInfo.InvariantCulture, DateTimeStyles.None, out startDate);
            bool endDateExist = DateTime.TryParseExact(txtEndDate.Text, formatString, CultureInfo.InvariantCulture, DateTimeStyles.None, out endDate);

            
            if (rblSearchOption.SelectedIndex == 1) //Offers
            {
                resultTable = "vRequestDetails";
            }
            else
            {
                resultTable = "vOfferDetails";
            }

            string searchQuery = "SELECT * FROM " + resultTable + " WHERE 1 = 1";

            if (placeFrom != null)
                searchQuery += " AND frm_id = " + placeFrom;
            
            if (placeTo != null)
                searchQuery += " AND to_id = " + placeTo;
            
            if (startDateExist)
                searchQuery += " AND date_time >= '" + startDate.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            
            if (endDateExist)
                searchQuery += " AND date_time <= '" + endDate.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            

            ListView listView = (ListView)ResultList.FindControl("ListView1");
            string ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
            SqlConnection myConnection = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand(searchQuery, myConnection);
            try
            {
                myConnection.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                listView.DataSource = ds;
                listView.DataBind();
            }
            finally
            {
                cmd.Dispose();
                myConnection.Dispose();

            }
        }
    }


    protected void Page_PreRender(object sender, EventArgs e)
    {
    }

    //protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    //{

    //}

    //protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    //{

    //    if(rblSearchOption.SelectedIndex == 0)
    //    {
    //        Label lblSeats = (Label)e.Item.FindControl("lblSeats");
    //        lblSeats.Enabled = true;
    //        lblSeats.Visible = true;
    //        DataRowView rowView = (DataRowView)e.Item.DataItem;
    //        lblSeats.Text += rowView["seats"].ToString();
            
    //        Button btn = (Button)e.Item.FindControl("btnCmd");
    //        btn.Text = "Send Offer";

            

    //    }

    //    //If user is logged in then show buttons to send response to the offer/request
    //    if (Request.IsAuthenticated)
    //    {

    //        Panel p1 = (Panel)e.Item.FindControl("pnlAnonymous");
    //        Panel p2 = (Panel)e.Item.FindControl("pnlLoggedIn");

    //        p1.Visible = false;
    //        p2.Visible = true;
    //    }


    //}

    protected void btnFrmHidden_Click(object sender, EventArgs e)
    {
        initFromList();
    }

    protected void initFromList()
    {
        string tableName = rblSearchOption.SelectedIndex == 0 ? "vOfferFromPlace" : "vReqFromPlace";

        string aQuery = "select * from " + tableName;
        SqlDataSource2.SelectCommand = aQuery;
        ddlTripFrom.Items.Clear();
        ddlTripFrom.DataBind();
        ddlTripFrom.Items.Insert(0, new ListItem("", "0"));
    }

    protected void rblSearchOption_SelectedIndexChanged(object sender, EventArgs e)
    {
        initFromList();
        initToList();
    }

    protected void initToList()
    {
        string tableName = rblSearchOption.SelectedIndex == 0 ? "vOfferToPlace" : "vReqToPlace";
        string aQuery;
        if (ddlTripFrom.SelectedIndex > 0)
        {
            aQuery = "select pname, place_id from " + tableName + " WHERE frm_id = "
                        + ddlTripFrom.SelectedValue;
        }
        else
        {
            aQuery = "select pname, place_id from " + tableName;
        }
        SqlDataSource3.SelectCommand = aQuery;
        ddlTripTo.Items.Clear();
        ddlTripTo.DataBind();
        ddlTripTo.Items.Insert(0, new ListItem("", "0"));
    }
    protected void ddlTripFrom_SelectedIndexChanged(object sender, EventArgs e)
    {
        initToList();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        rblSearchOption.SelectedIndex = 0;
        initFromList();
        initToList();
        txtEndDate.Text = "";
        txtStartDate.Text = "";
    }
}