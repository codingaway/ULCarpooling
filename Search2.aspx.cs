using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search2 : System.Web.UI.Page
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

        }
        else
        {

        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        SqlDataSource1.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlDataSource1.SelectCommand = "select * from vOfferDetails where user_ID = 1";
        //ListView1.DataSourceID = null;
        //ListView1.DataSource = SqlDataSource1;
        //ListView1.DataBind();
    }

    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        //ListView1.DataBind();
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


    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

        /* this works */
        //if (Request.IsAuthenticated)
        //{

        //    Panel p1 = (Panel)e.Item.FindControl("pnlAnonymous");
        //    Panel p2 = (Panel)e.Item.FindControl("pnlLoggedIn");

        //    p1.Visible = false;
        //    p2.Visible = true;

        //}
        /* this works */

        //LoginView lv = (LoginView)e.Item.FindControl("LoginView1");
        //lv.DataBind();

        //Event handler for assigning loggedinview template correctly on postback

        //LoginView lv = (LoginView)e.Item.FindControl("LoginView1");

        //Label label = (Label)lv.FindControl("Label1");

        //if(e.Item.ItemType == ListViewItemType.DataItem)
        //{
        //    DataRowView rowView = (DataRowView)e.Item.DataItem;
        //    label.Text = rowView["full_name"].ToString();
        //}

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        SqlDataSource1.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlDataSource1.SelectCommand = "select * from vOfferDetails where user_ID = 1";
    }
}