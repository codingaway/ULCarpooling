using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class AddOffer : System.Web.UI.Page
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True");
    SqlCommand cmd1;
    SqlDataAdapter adpt1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!this.IsPostBack)
        {
            fillDepartList();   
        }
    }

    private void fillDepartList()
    {
       
        con1.Open();

        adpt1 = new SqlDataAdapter("Select * from County", con1);
        DataTable dt = new DataTable();
        adpt1.Fill(dt);
        DDdepartLoc.DataSource = dt;
        DDdepartLoc.DataTextField = "Name";
        DDdepartLoc.DataValueField = "c_code";
        DDdepartLoc.DataBind();
        con1.Close();
        //Adding "Please select" option in dropdownlist for validation
        DDdepartLoc.Items.Insert(0, new ListItem("Please select", "0"));
        
        
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        con1.Open();
        int count = 0;
        string str1 = DDdepartLoc.SelectedItem.Value;
        string str4 = DDarrivalLoc.SelectedItem.Value;

        using (cmd1 = new SqlCommand("select count(*) from offer_rec", con1))
        {
            count = (int)cmd1.ExecuteScalar();
            count++;
        }



        using (cmd1 = new SqlCommand("insert into offer_rec values(@Request_id,@from,@to,@date_time,@seats)", con1))
        {

            cmd1.Parameters.AddWithValue("@Request_id", count.ToString());
            cmd1.Parameters.AddWithValue("@from", str1);
            cmd1.Parameters.AddWithValue("@to", str4);
            cmd1.Parameters.AddWithValue("@date_time", txtDate.Text);
            cmd1.Parameters.AddWithValue("@seats", txtSeats.Text);
            cmd1.ExecuteNonQuery();
        }


        //command1.Dispose();

        con1.Close();
    }
    
    protected void DDdepartLoc_SelectedIndexChanged1(object sender, EventArgs e)
    {
        con1.Open();
        string selectSQL = "SELECT * FROM County ";
        selectSQL += "WHERE c_code!='" + DDdepartLoc.SelectedItem.Value + "'";

        adpt1 = new SqlDataAdapter(selectSQL, con1);
        DataTable dt = new DataTable();
        adpt1.Fill(dt);
        DDarrivalLoc.DataSource = dt;
        DDarrivalLoc.DataTextField = "Name";
        DDarrivalLoc.DataValueField = "c_code";
        DDarrivalLoc.DataBind();
        con1.Close();
        //Adding "Please select" option in dropdownlist for validation
        DDarrivalLoc.Items.Insert(0, new ListItem("Please select", "0"));
    }
}