using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using AjaxControlToolkit;
using System.Configuration;
using System.Security;

public partial class Overview : System.Web.UI.Page
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True;MultipleActiveResultSets=True;");
    SqlCommand cmd1;
    SqlDataAdapter adp1;
    SqlDataReader rd1;
    protected void Page_Load(object sender, EventArgs e)
    {
        string userAge = "";
        

        if (!IsPostBack)
        {
            //getting user id from request query 
            string user_id = Request.QueryString["id"].ToString();

            BindRatings(user_id);
           
            //method for listview
            BindListViewControls(user_id);

            con1.Open();
            
            using (cmd1 = new SqlCommand("SELECT FName,SName,dob,Smoker,Gender,User_category.Description As Category from users JOIN User_category on users.cat_no = User_category.Cat_no WHERE User_ID ="+user_id, con1))
            {
                rd1 = cmd1.ExecuteReader();
                if (rd1.Read())
                {
                    userName.Text = rd1["FName"].ToString() + " " + rd1["SName"].ToString();
                    userAge = rd1["dob"].ToString();
                    if (userAge == "")
                    {
                        lblUserAge.Text = "No DOB Found";
                    }
                    else
                    {
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


    public void BindRatings(string userID)
    {
        string[] ratingInfo = DBHelper.getUserReview(userID); //Get user avg rating and rating count

        if (ratingInfo != null)
        {
            lblStars.Text = ratingInfo[0];
            lblCount.Text = ratingInfo[1];
        }
        else
        {
            lblStars.Text = "0";
            lblCount.Text = "0";
        }
    }

    private void BindListViewControls(string userID)
    {
        con1.Open();
        string query = "Select TOP 5 comment from Reviews WHERE user_id=" + userID + " AND comment!=null ORDER BY submit_date DESC";

        SqlDataAdapter da = new SqlDataAdapter(query, con1);
        DataTable table = new DataTable();

        da.Fill(table);

        ListView1.DataSource = table;
        ListView1.DataBind();
        con1.Close();
    }
}