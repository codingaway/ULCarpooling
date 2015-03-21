using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration; /*Required for reading connection string from Web.config */
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for DBHelper
/// </summary>
public class DBHelper
{
    //public readonly string connectionString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True";
	private DBHelper()
	{
        //This class contains static methods, do not want to instantiate new onject from it
	}

    public static bool isEmailUnique(string email)
    {
        bool isUnique = false;
        try
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("select count(*) from users where email =@Email", conn);
            SqlParameter param = new SqlParameter();
            param.ParameterName = "@Email";
            param.Value = email;
            cmd.Parameters.Add(param);
            int count = (int)cmd.ExecuteScalar();
            if (count == 0)
                isUnique = true;
            cmd.Dispose();
            conn.Dispose();
        }
        catch (SqlException ex) 
        {
            return isUnique;
        }

        return isUnique;
    }

     public static bool addNewUser(string fName, string sName, string email, DateTime dob, string password, string question, string answer, string mobile, int category, string smoker, string gender)
     {
         bool success = false;
         try
         {
             SqlConnection conn = new SqlConnection();
             conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
             conn.Open();
             SqlCommand cmd = new SqlCommand();
             cmd.Connection = conn;
             cmd.CommandType = CommandType.StoredProcedure;
             cmd.CommandText = "uspCreateNewUser";
             cmd.Parameters.Add(new SqlParameter("@FName", fName));
             cmd.Parameters.Add(new SqlParameter("@SName", sName));
             cmd.Parameters.Add(new SqlParameter("@Email", email));
             cmd.Parameters.Add(new SqlParameter("@DoB", dob));
             cmd.Parameters.Add(new SqlParameter("@Password", password));
             cmd.Parameters.Add(new SqlParameter("@Question", question));
             cmd.Parameters.Add(new SqlParameter("@Answer", answer));
             cmd.Parameters.Add(new SqlParameter("@Mobile", mobile));
             cmd.Parameters.Add(new SqlParameter("@Smoker", smoker));
             cmd.Parameters.Add(new SqlParameter("@Category", category));
             cmd.Parameters.Add(new SqlParameter("@Gender", gender));
             cmd.ExecuteNonQuery();
             cmd.Dispose();
             conn.Dispose();
             success = true;
         }
         catch (SqlException ex) {}
         return success;
     }




}