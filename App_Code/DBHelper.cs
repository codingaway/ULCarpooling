/*
 * Static Class contains Public static methods that can be used system wide database manipulation
 * 
 *    @Author: Abdul Halim
 * 
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration; /*Required for reading connection string from Web.config */
using System.Data;
using System.Data.SqlClient;
using System.Web.Helpers;

public class DBHelper
{
    public const int OFFER_LIST = 0;
    public const int REQ_LIST = 1;

    private DBHelper()
    {
        //Disable instantiation of new object from it
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

         string passHash = Crypto.HashPassword(password); //Encrypt password
         string answerHash = Crypto.HashPassword(answer); //Encrypt secret question's answer

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        conn.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "uspCreateNewUser";
        cmd.Parameters.Add(new SqlParameter("@FName", fName));
        cmd.Parameters.Add(new SqlParameter("@SName", sName));
        cmd.Parameters.Add(new SqlParameter("@Email", email));
        cmd.Parameters.Add(new SqlParameter("@DoB", dob));
        cmd.Parameters.Add(new SqlParameter("@Password", passHash));
        cmd.Parameters.Add(new SqlParameter("@Question", question));
        cmd.Parameters.Add(new SqlParameter("@Answer", answerHash));
        cmd.Parameters.Add(new SqlParameter("@Mobile", mobile));
        cmd.Parameters.Add(new SqlParameter("@Smoker", smoker));
        cmd.Parameters.Add(new SqlParameter("@Category", category));
        cmd.Parameters.Add(new SqlParameter("@Gender", gender));

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery(); 
            success = true;
        }
        finally
        {
            cmd.Dispose();
            conn.Dispose();
        }
        return success;
     }

    public static bool processResponse(string userID, string listID, int listingType)
    {
        bool success = false;

        string responseTbl = listingType == DBHelper.OFFER_LIST ? "offer_response" : "req_response";

        

        return success;
    }



    public static string[] getUserReview(string userID)
    {
        string[] review = null;

        SqlConnection conn;
        SqlCommand cmd;

        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        conn = new SqlConnection();
        conn.ConnectionString = conString;
        cmd = new SqlCommand("select average, total from vReviewCountAvg where user_id =" + userID, conn);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            conn.Open();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
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