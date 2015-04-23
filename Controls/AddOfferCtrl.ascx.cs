using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Subgurim.Controles;
using Subgurim.Controls;
using Subgurim.Web;
using System.Web.Security;
using System.Configuration;
using System.Globalization;


public partial class AddOfferCtrl : System.Web.UI.UserControl
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True");
    SqlCommand cmd1;
    SqlDataAdapter adpt1;

    public string userID;
    private string accLevel;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.IsAuthenticated) //Check first if request is authenticated 
        {
            panelGostUser.Visible = true;
            panelLoginUser.Visible = false;
            
        }
        else
        {
            tb_fromPoint.Style.Add("visibility", "hidden");
            tb_endPoint.Style.Add("visibility", "hidden");
            getUserID();
            GMap1.Key = "GoogleKey";
            Page.DataBind();
            if (!this.IsPostBack)
            {
                //Get user ID from FormAuthentocation Ticket
              

               
                panelLoginUser.Visible = true;
                panelGostUser.Visible = false;

                fillDepartList();
                GMap1.GZoom = 9;
                GMap1.Add(new GControl(GControl.preBuilt.LargeMapControl));

                GDirection direction = new GDirection();
                direction.autoGenerate = false;
                direction.buttonElementId = "bt_Go";
                direction.fromElementId = tb_fromPoint.ClientID;
                direction.toElementId = tb_endPoint.ClientID;
                direction.divElementId = "div_directions";
                direction.clearMap = true;

                GMap1.Add(direction);
            }
        }
    }

    protected void getUserID()
    {
        //Get user ID from FormAuthentocation Ticket
        string[] userData;
        HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
        FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
        userData = ticket.UserData.Split(',');
        userID = userData[0];
    }

    private void fillDepartList()
    {
        con1.Open();

        adpt1 = new SqlDataAdapter("Select * from County", con1);
        DataTable dt = new DataTable();
        adpt1.Fill(dt);
        DDdepartCounty.DataSource = dt;
        DDdepartCounty.DataTextField = "Name";
        DDdepartCounty.DataValueField = "c_code";
        DDdepartCounty.DataBind();
        con1.Close();
        //Adding "Please select" option in dropdownlist for validation
        DDdepartCounty.Items.Insert(0, new ListItem("Please select", "0"));
    }

    protected void DDdepartCounty_SelectedIndexChanged1(object sender, EventArgs e)
    {
        con1.Open();
        string selectSQL = "SELECT * FROM places ";
        selectSQL += "WHERE c_code='" + DDdepartCounty.SelectedItem.Value + "'";
        DDdepartPlaces.Enabled = true;
        adpt1 = new SqlDataAdapter(selectSQL, con1);
        DataTable dt = new DataTable();
        adpt1.Fill(dt);
        DDdepartPlaces.DataSource = dt;
        DDdepartPlaces.DataTextField = "place_name";
        DDdepartPlaces.DataValueField = "Place_id";
        DDdepartPlaces.DataBind();
        con1.Close();
        //Adding "Please select" option in dropdownlist for validation
        DDdepartPlaces.Items.Insert(0, new ListItem("Please select", "0"));
    }

    protected void DDdepartPlaces_SelectedIndexChanged1(object sender, EventArgs e)
    {
        con1.Open();
        string selectSQL = "SELECT * FROM County ";
        DDarrivalCounty.Enabled = true;
        adpt1 = new SqlDataAdapter(selectSQL, con1);
        DataTable dt = new DataTable();
        adpt1.Fill(dt);
        DDarrivalCounty.DataSource = dt;
        DDarrivalCounty.DataTextField = "Name";
        DDarrivalCounty.DataValueField = "c_code";
        DDarrivalCounty.DataBind();
        con1.Close();
        //Adding "Please select" option in dropdownlist for validation
        DDarrivalCounty.Items.Insert(0, new ListItem("Please select", "0"));
        tb_fromPoint.Text = DDdepartPlaces.SelectedItem.Text + ", " + DDdepartCounty.SelectedItem.Text;
    }

    protected void DDarrivalCounty_SelectedIndexChanged1(object sender, EventArgs e)
    {
        con1.Open();
        string selectSQL = "SELECT * FROM places ";
        selectSQL += "WHERE c_code='" + DDarrivalCounty.SelectedItem.Value + "' AND place_name != '" + DDdepartPlaces.SelectedItem.Text + "'";
        DDarrivalPlaces.Enabled = true;
        adpt1 = new SqlDataAdapter(selectSQL, con1);
        DataTable dt = new DataTable();
        adpt1.Fill(dt);
        DDarrivalPlaces.DataSource = dt;
        DDarrivalPlaces.DataTextField = "place_name";
        DDarrivalPlaces.DataValueField = "Place_id";
        DDarrivalPlaces.DataBind();
        con1.Close();
        //Adding "Please select" option in dropdownlist for validation
        DDarrivalPlaces.Items.Insert(0, new ListItem("Please select", "0"));
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string uID = userID;
        con1.Open();
        int count = 0;
        string str1 = DDdepartPlaces.SelectedItem.Value;
        string str4 = DDarrivalPlaces.SelectedItem.Value;

        //Convert DateTime in microsoftSql Format
        string DateString = txtDate.Text;
        DateTime date = new DateTime();
        date = DateTime.ParseExact(DateString, "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);
        string dateTime = date.ToString("MM/dd/yyyy HH:mm:ss");

        //Suppose User Id = 2


        using (cmd1 = new SqlCommand("select MAX(offer_id) from offer_rec", con1))
        {
            count = (int)cmd1.ExecuteScalar()+1;  
        }

        using (cmd1 = new SqlCommand("insert into [offer_rec]([offer_id],[user_id],[place_from],[place_to],[date_time],[seats]) values(@offer_id,@user_ID,@from,@to,@date_time,@seats)", con1))
        {
            cmd1.Parameters.AddWithValue("@offer_id", count.ToString());
            cmd1.Parameters.AddWithValue("@user_ID", uID);
            cmd1.Parameters.AddWithValue("@from", str1);
            cmd1.Parameters.AddWithValue("@to", str4);
            cmd1.Parameters.AddWithValue("@date_time", dateTime);
            cmd1.Parameters.AddWithValue("@seats", txtSeats.Text);
            cmd1.ExecuteNonQuery();
        }
        con1.Close(); 
    }
    
    protected void DDarrivalPlaces_SelectedIndexChanged1(object sender, EventArgs e)
    {
        tb_endPoint.Text = DDarrivalPlaces.SelectedItem.Text + ", " + DDarrivalCounty.SelectedItem.Text;
    }
}