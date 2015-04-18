using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using AjaxControlToolkit;

public partial class ReviewPage : System.Web.UI.Page
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True");
    SqlCommand cmd1;
    SqlDataAdapter adp1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRatings();

            con1.Open();
            using (cmd1 = new SqlCommand("SELECT trip_rec.place_from,trip_rec.place_to,users.FName,users.SName,Reviews.rating,Reviews.comment FROM Reviews JOIN trip_rec ON trip_rec.trip_id=Reviews.trip_id JOIN users ON Reviews.reviewed_by = users.User_ID WHERE Reviews.user_id=5", con1));
            {
                grdResult.DataSource = cmd1.ExecuteReader();
                grdResult.DataBind();
            }
            con1.Close();
        }
    }

    public void BindRatings()
    {
        int Total = 0;
        con1.Open();
        cmd1 = new SqlCommand("SELECT rating FROM Reviews where user_id = 1", con1);
        adp1 = new SqlDataAdapter(cmd1);
        DataTable dt = new DataTable();
        adp1.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Total += Convert.ToInt32(dt.Rows[i][0].ToString());
            }
            int Average = Total / (dt.Rows.Count);
            Rating1.CurrentRating = Average;
           /* Label1.Text = dt.Rows.Count + " " + "Users have rated this Product";
            Label2.Text = "Average rating for this Product is" + " " + Convert.ToString(Average); */
        }
        con1.Close();
    }

    protected void OnRatingChanged(object sender, RatingEventArgs e)
    {
        
    }

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[0].Text = "Depart";
            e.Row.Cells[1].Text = "Arrive";
            e.Row.Cells[2].Text = "First Name";
            e.Row.Cells[3].Text = "Surname";
            e.Row.Cells[4].Text = "Rating";
            e.Row.Cells[5].Text = "Comment";
        }
    }
}