using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Helpers;
using System.Configuration;
using System.Data.SqlClient;

public partial class testing_encryption : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        string id = txtID.Text;
        string email = txtAddEmail.Text;
        string pass = txtAddPassword.Text;
        string hash = Crypto.HashPassword(pass);
        lblPassword.Text = pass;
        lblHashOutput.Text = hash;
        lblHashLength.Text = hash.Length.ToString();

        //Add user info to the database
        addUserToDatabase(id, email, hash);
    }

    private void addUserToDatabase(string id, string email, string hash)
    {
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;

        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("insert into Test_login VALUES(@id, @email, @hash)");
        cmd.Connection = conn;
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@hash", hash);

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
    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string email = txtVerifyEmail.Text;
        string pass = txtVerifyPassword.Text;
        //string hash2 = Crypto.HashPassword(pass);

        //lblVerfiedResult.Text = verifyUser(email, pass) ? "true" : "false";
        //lblNewHash.Text = hash2;
        changePassword(email, pass);
    }

    private bool verifyUser(string email, string pass)
    {
        bool varified = false;
        string hash = null;
        string conString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
        SqlConnection conn = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("Select password from Test_login where email = @email", conn);
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

        if(hash == null)
            varified = false;
        else if(!Crypto.VerifyHashedPassword(hash, pass))
            varified = false;
        return varified;
    }

    private void changePassword(string email, string pass)
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