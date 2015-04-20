using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using AjaxControlToolkit;

public partial class OtherUserReviews : System.Web.UI.Page
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True;MultipleActiveResultSets=True;");
    SqlCommand cmd1;
    SqlDataAdapter adp1;
    SqlDataReader rd1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRatings();
            int countRows = 0;
            con1.Open();
            using (cmd1 = new SqlCommand("SELECT count(*) from Reviews WHERE user_id = 1", con1))
            {
                countRows = (int)cmd1.ExecuteScalar();
                numberUserRating.Text = "("+ countRows.ToString() +")";
            }

            using (cmd1 = new SqlCommand("SELECT FName,SName from users WHERE User_ID = 1", con1))
            {
                rd1 = cmd1.ExecuteReader();
                if (rd1.Read())
                {
                    userName.Text = rd1["FName"].ToString() + " " + rd1["SName"].ToString();
                }
            }
            rd1.Close();

            using (cmd1 = new SqlCommand("SELECT TOP 2 comment FROM Reviews WHERE user_id=1 ORDER BY submit_date", con1))
            {
                if (countRows > 0)
                {
                    grdResult.DataSource = cmd1.ExecuteReader();
                    grdResult.DataBind();
                }
                else
                {
                    lblGrdResult.Visible = true;
                    lblGrdResult.Text = "No Comments For This User Yet";
                }
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
            e.Row.Cells[0].Text = "Comments By Other Users";
        }
    }
}