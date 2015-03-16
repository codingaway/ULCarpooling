using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class JoshsChangePW : System.Web.UI.Page
{
    protected string strConnection = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Loaner\\ULCarpooling\\App_Data\\carpooling_db.mdf;Integrated Security=True;";
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Validate Old Password with one stored in DB, query
        string query = "SELECT password FROM secret WHERE user_id = 3";
        SqlConnection sql = new SqlConnection(strConnection);
        
        string pw = "";

        using (SqlCommand cmd = new SqlCommand(query, sql))
        {
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = sql;

            sql.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            if(reader.Read()){
                pw = reader["password"].ToString();
            }
            else{
                Response.Write("Error");
            }
            reader.Close();
            sql.Close();
        }

        string input = txtOldPW.Text.ToLower();
        if (pw.Equals(input))
        {
            //Validate the New Password and Confirm Password to make sure they match (client side/server side?)
            if (txtNewPW.Text.ToLower().Equals(txtConfirmPW.Text.ToLower()))
            {
                //If the above is done then store New Password in DB
                string update = "UPDATE secret SET password = @password WHERE user_id = 3";
                using (SqlCommand cmd = new SqlCommand(update, sql))
                {
                    cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = txtNewPW.Text.ToLower();
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = sql;
                    try
                    {
                        sql.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }
                    finally
                    {
                        sql.Close();
                        sql.Dispose();
                        Response.Redirect("JoshsTemp.aspx");
                    }
                }
            }
            else
                Response.Write("New and confirmed passwords do not match");
        }
        else
            Response.Write("Your Old password entered does not match the password in the database");

        //reader.Close();
        sql.Close();
    }
}