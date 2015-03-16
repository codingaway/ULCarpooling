using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class OfferForm : System.Web.UI.Page
{
    SqlConnection connect1;
    SqlCommand command1;
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
            
    }


    protected void btnSelectDate_Click(object sender, EventArgs e)
    {
        Calendar1.Visible = true;
    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        txtDate.Text = Calendar1.SelectedDate.ToShortDateString();
        Calendar1.Visible = false;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        connect1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True");
        connect1.Open();
        int count = 0;
        string str1 = DDdepartLoc.SelectedItem.Value;
        string str4 = DDarrivalLoc.SelectedItem.Value;

        using (command1 = new SqlCommand("select count(*) from offer_rec", connect1))
        {
            count = (int)command1.ExecuteScalar(); 
        }

        

        using (command1 = new SqlCommand("insert into offer_rec values(@offer_id,@user_id,@from,@to,@date_time,@seats)", connect1))
        {

            command1.Parameters.AddWithValue("@offer_id", count.ToString());
            command1.Parameters.AddWithValue("@user_id", txtID.Text);
            command1.Parameters.AddWithValue("@from", str1);
            command1.Parameters.AddWithValue("to", str4);
            command1.Parameters.AddWithValue("@date_time", txtDate.Text);
            command1.Parameters.AddWithValue("@seats", txtSeats.Text);
            command1.ExecuteNonQuery();
        }

        
        //command1.Dispose();
        
        connect1.Close();
        
    }
}