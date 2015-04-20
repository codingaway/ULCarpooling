using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default : System.Web.UI.Page
{

    protected void Page_PreInit(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_PreLoad(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if(!IsPostBack)
        {
            loadRequests();
            loadOffers();
        }
        else //PostBack
        {

        }
    }

    protected void loadRequests()
    {

        RequestList.listType = DBHelper.REQ_LIST;
        ListView listView = (ListView)RequestList.FindControl("ListView1");
        
        string ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(ConnectionString);
        string aQuery = "select * from vRequestDetails";
        SqlCommand cmd = new SqlCommand(aQuery, myConnection);
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

    protected void loadOffers()
    {
        OfferList.listType = DBHelper.OFFER_LIST;
        ListView listView = (ListView)OfferList.FindControl("ListView1");
        string ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(ConnectionString);
        string aQuery = "select * from vOfferDetails";
        SqlCommand cmd = new SqlCommand(aQuery, myConnection);
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
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {

    }

    protected void Page_Render(object sender, EventArgs e)
    {

    }

    protected void Page_SaveStateComplete(object sender, EventArgs e)
    {

    }

    protected void Page_Unload(object sender, EventArgs e)
    {

    }


}