﻿/*
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

    public static bool isUserBanned(string email)
    {
        bool isBlocked = true;

        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("select Access_level from login_info where email = @Email", conn);
        cmd.Parameters.AddWithValue("@Email", email);
       
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            conn.Open();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                string output = row["Access_level"].ToString();
                if(output != null)
                {
                    int accLevel = Convert.ToInt32(output);
                    if (accLevel > 0)
                        isBlocked = false;
                }              
            }
        }
        catch (SqlException ex){}
        finally
        {
            da.Dispose();
            conn.Dispose();
        }
        return isBlocked;
    }



    public static bool addNewUser(string fName, string sName, string email, DateTime dob, string password, string question, string answer, string mobile, string category, string smoker, string gender)
     {
         //bool success = false;
         int result = 0;

         string passHash = Crypto.HashPassword(password); //Encrypt password
         string answerHash = Crypto.HashPassword(answer); //Encrypt secret question's answer

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlCommand cmd = new SqlCommand("uspCreateNewUser", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@FName", fName);
        cmd.Parameters.AddWithValue("@SName", sName);
        cmd.Parameters.AddWithValue("@Email", email);
        cmd.Parameters.AddWithValue("@DoB", dob);
        cmd.Parameters.AddWithValue("@Password", passHash);
        cmd.Parameters.AddWithValue("@Question", question);
        cmd.Parameters.AddWithValue("@Answer", answerHash);
        cmd.Parameters.AddWithValue("@Mobile", mobile);
        cmd.Parameters.AddWithValue("@Smoker", smoker);
        cmd.Parameters.AddWithValue("@Category", category);
        cmd.Parameters.AddWithValue("@Gender", gender);

        var returnParameter = cmd.Parameters.Add("@success", SqlDbType.Int);
        returnParameter.Direction = ParameterDirection.ReturnValue;

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            result = Convert.ToInt32(returnParameter.Value);
        }
        finally
        {
            conn.Dispose();
            cmd.Dispose();
        }
        return (result == 1);
     }

    public static bool processResponse(string userID, string listID, int listingType)
    {
        SqlConnection conn;
        SqlCommand cmd;
        int result = 0;

        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        conn = new SqlConnection();
        conn.ConnectionString = conString;
        cmd = new SqlCommand("spCreateResponse", conn);
        cmd.Parameters.AddWithValue("@userID", userID);
        cmd.Parameters.AddWithValue("@listID", listID);
        cmd.Parameters.AddWithValue("@listType", listingType);
        cmd.CommandType = CommandType.StoredProcedure;

        var returnParameter = cmd.Parameters.Add("@success", SqlDbType.Int);
        returnParameter.Direction = ParameterDirection.ReturnValue;

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            result = Convert.ToInt32(returnParameter.Value);
        }
        finally
        {
            conn.Close();
            cmd.Dispose();
        }

        return (result == 1);
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
            var returnValue = cmd.ExecuteScalar();
            if(returnValue != null )
            hash = returnValue.ToString();
        }
        catch(NullReferenceException ex)
        {
            varified = false;
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



    public static string [] getQandA(string email)
    {
        string[] qAndA = null;

        SqlConnection conn;
        SqlCommand cmd;

        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        conn = new SqlConnection();
        conn.ConnectionString = conString;
        cmd = new SqlCommand("select user_secret.Question, user_secret.Answer" + 
            " from users join user_secret on users.User_ID = user_secret.User_ID" 
            + " where users.Email= @Email", conn);
        cmd.Parameters.AddWithValue("@Email", email);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            conn.Open();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                qAndA = new string[2];
                qAndA[0] = row["Question"].ToString();
                qAndA[1] = row["Answer"].ToString();
            }
        }
        finally
        {
            da.Dispose();
            conn.Dispose();
        }
        return qAndA;
    }


    public static bool verifySecreteAns(string email, string answer)
    {
        bool varified = false;
        string hash = null;
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("Select user_secret.Answer from user_secret inner join users on " +
            "users.User_ID = user_secret.User_ID where users.Email = @email", conn);
        cmd.Parameters.AddWithValue("@email", email);
        try
        {
            conn.Open();
            var returnValue = cmd.ExecuteScalar();
            if (returnValue != null)
                hash = returnValue.ToString();
        }
        catch (NullReferenceException ex)
        {
            varified = false;
        }
        finally
        {
            conn.Dispose();
            cmd.Dispose();
        }

        if (hash != null && Crypto.VerifyHashedPassword(hash, answer))
            varified = true;
        return varified;
    }


    public static bool awaitingConfirm(string id, string listingID, int listType)
    {
        int row = 0;
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ToString();

        string aQuery;
        if (listType == DBHelper.OFFER_LIST)
        {
            aQuery = "SELECT count(*) FROM offer_response"
                + " WHERE offer_id = @list_id"
                + " AND user_id = @userID";
        }
        else
        {
            aQuery = "SELECT count(*) FROM req_response"
                + " WHERE req_id = @list_id"
                + " AND user_id = @userID";
        }
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(aQuery, conn);
        cmd.Parameters.AddWithValue("@list_id", listingID);
        cmd.Parameters.AddWithValue("@userID", id);

        try
        {
            conn.Open();
            row = Convert.ToInt32(cmd.ExecuteScalar());
        }
        finally
        {
            conn.Dispose();
            cmd.Dispose();
        }
        if (row > 0)
            return true;
        else
            return false;
    }

    public static bool isOwnListing(string id, string listingID, int listType)
    {
        int row = 0;
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ToString();

        string aQuery;
        if (listType == DBHelper.OFFER_LIST)
        {
            aQuery = "SELECT count(*) FROM offer_rec"
                + " WHERE offer_id = @list_id"
                + " AND user_id = @userID";
        }
        else
        {
            aQuery = "SELECT count(*) FROM req_rec"
                + " WHERE Request_id = @list_id"
                + " AND user_id = @userID";
        }
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(aQuery, conn);
        cmd.Parameters.AddWithValue("@list_id", listingID);
        cmd.Parameters.AddWithValue("@userID", id);

        try
        {
            conn.Open();
            row = Convert.ToInt32(cmd.ExecuteScalar());
        }
        finally
        {
            conn.Dispose();
            cmd.Dispose();
        }
        if (row > 0)
            return true;
        else
            return false;
    }

    /* Medhods that returns a dataset of confiremd user given an offer_id*/
    public static int getConfirmedPassengers(string offer_id, DataSet dataset)
    {
        int rowCount = 0;
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ToString();
        string aQuery = "SELECT offer_response.user_id, users.FName + ' ' + users.SName AS uname FROM users"
            + " JOIN offer_response ON users.User_ID = offer_response.user_id"
            + " WHERE offer_response.offer_id = @list_id"
            + " AND offer_response.status = 'Confirmed'";
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(aQuery, conn);
        cmd.Parameters.AddWithValue("@list_id", offer_id);

        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = cmd;
        try
        {
            conn.Open();
            rowCount = da.Fill(dataset);
        }
        finally
        {
            da.Dispose();
            cmd.Dispose();
        }
        return rowCount;
    }

}

