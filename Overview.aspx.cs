using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using AjaxControlToolkit;

public partial class Overview : System.Web.UI.Page
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True;MultipleActiveResultSets=True;");
    SqlCommand cmd1;
    SqlDataAdapter adp1;
    SqlDataReader rd1;
    protected void Page_Load(object sender, EventArgs e)
    {
        string userAge = "";
        string user_id = Request.QueryString["id"].ToString();
        userImage.ImageUrl = "~/GetImage.aspx?ImageID=" + user_id;

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
            
            using (cmd1 = new SqlCommand("SELECT FName,SName,dob,Smoker,Gender,User_category.Description As Category from users JOIN User_category on users.cat_no = User_category.Cat_no WHERE User_ID ="+user_id, con1))
            {
                rd1 = cmd1.ExecuteReader();
                if (rd1.Read())
                {
                    userName.Text = rd1["FName"].ToString() + " " + rd1["SName"].ToString();
                    userAge = rd1["dob"].ToString();
                    if (userAge == "")
                    { lblUserAge.Text = "No DOB"; }
                    else 
                    {
                        lblUserAge.Text = userAge;
                        DateTime dt = Convert.ToDateTime(userAge);

                        DateTime now = DateTime.Today;
                        int age = now.Year - dt.Year;
                        if (now < dt.AddYears(age))
                            age--;
                        lblUserAge.Text = age.ToString() + " age";
                    }
                    

                    //To check if smoker
                    if (rd1["Smoker"].ToString().Equals("y"))
                    {
                        lblisSmoker.Text = "Smoker";
                    }
                    else 
                    {
                        lblisSmoker.Text = "Non Smoker";
                    }

                    //To check if Non Smoker
                    if (rd1["Gender"].ToString().Equals("m"))
                    {
                        lblGender.Text = "Male";
                    }
                    else
                    {
                        lblGender.Text = "Female";
                    }

                    lblUserCat.Text = rd1["Category"].ToString();
                    
                }
                rd1.Close();
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
}