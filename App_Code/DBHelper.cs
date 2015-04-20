using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration; /*Required for reading connection string from Web.config */
using System.Data;
using System.Data.SqlClient;
using System.Web.Helpers;

/// <summary>
/// Summary description for DBHelper
/// </summary>
public class DBHelper
{
    public const int OFFER_LIST = 0;
    public const int REQ_LIST = 1;

    

    //public const string connectionString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True";
	private DBHelper()
	{
        //This class contains static methods, do not want to instantiate new object from it
	}

    public static bool isEmailUnique(string email)
    {
        bool isUnique = false;
        try
        {
            string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = conString; //ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
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
         catch (SqlException ex) { return success; }
         return success;
     }


    public static void CreatePendingRequest(string userID, string offerID)
    {

    }

    public static void CreatePendingOffer(string userID, string requestID)
    {

    }

    public static string[] getUserReview(string userID)
    {
        string [] review = null;

        SqlConnection conn;
        SqlCommand cmd;

        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        conn = new SqlConnection();
        conn.ConnectionString = conString;
        cmd = new SqlCommand("select average, total from vReviewCountAvg where user_id =" + userID, conn);
        //SqlParameter param = new SqlParameter();
        //param.ParameterName = "@userID";
        //param.Value = userID;
        //cmd.Parameters.Add(param);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            conn.Open();
            da.Fill(dt);
            
            if(dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                review = new string[2];
                review[0] = row["average"].ToString();
                review[1] = row["total"].ToString();
            }
        }
        finally
        {
            da.Dispose();
            conn.Dispose();
        }
        return review;
    }

    public static bool verifyUser(string email, string pass)
    {
        bool varified = false;
        string hash = null;
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("Select user_pass from user_secret inner join users on " +
            "users.User_ID = user_secret.User_ID where users.Email = @email", conn);
        cmd.Parameters.AddWithValue("@email", email);
        try
        {
            conn.Open();
            hash = cmd.ExecuteScalar().ToString();
        }
        finally
        {
            conn.Dispose();
            cmd.Dispose();
        }

        if (hash != null && Crypto.VerifyHashedPassword(hash, pass))
            varified = true;
        return varified;
    }

    public static void changePassword(string email, string pass)
    {
        string hash = Crypto.HashPassword(pass);
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection(conString);

        string aQuery = "UPDATE user_secret SET user_pass = @hash WHERE User_ID IN " +
            "(Select user_secret.User_ID FROM user_secret INNER JOIN users on " +
            "users.User_ID = user_secret.User_ID WHERE users.Email = @email)";
        SqlCommand cmd = new SqlCommand(aQuery, conn);
        cmd.Parameters.AddWithValue("@hash", hash);
        cmd.Parameters.AddWithValue("@email", email);
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Dispose();
            cmd.Dispose();
        }
    }


}