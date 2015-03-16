using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;

public partial class JoshsEditProfile : System.Web.UI.Page
{
    protected string strConnection = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Loaner\\ULCarpooling\\App_Data\\carpooling_db.mdf;Integrated Security=True;";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // Read the file and convert it to Byte Array
        string filePath = imageUpload.PostedFile.FileName;
        string filename = Path.GetFileName(filePath);
        string ext = Path.GetExtension(filename);
        string contenttype = String.Empty;

        //Set the contenttype based on File Extension
        switch (ext)
        {
            case ".jpg":
                contenttype = "image/jpg";
                break;
            case ".png":
                contenttype = "image/png";
                break;
            case ".gif":
                contenttype = "image/gif";
                break;
            case ".pdf":
                contenttype = "application/pdf";
                break;
        }

        if (contenttype != String.Empty)
        {

            Stream fs = imageUpload.PostedFile.InputStream;
            BinaryReader br = new BinaryReader(fs);
            Byte[] bytes = br.ReadBytes((Int32)fs.Length);

            HttpPostedFile File = imageUpload.PostedFile;

            fs.Close();
            br.Close();

            string[] name = (txtName.Text).Split(new Char [] {' '});
            string email = txtEmail.Text;
            string mobile = txtPhone.Text;

            //insert the file into database 
            string strQuery = "UPDATE users SET FName = @FName, SName = @Sname, Email = @Email, Mobile = @Mobile, profile_pic = @profile_pic WHERE User_ID = 3";
            SqlCommand cmd = new SqlCommand(strQuery);
            cmd.Parameters.Add("@profile_pic", SqlDbType.Binary).Value = bytes;
            cmd.Parameters.Add("@FName", SqlDbType.VarChar).Value = name[0];
            cmd.Parameters.Add("@SName", SqlDbType.VarChar).Value = name[1];
            cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = email;
            cmd.Parameters.Add("@Mobile", SqlDbType.Char).Value = mobile;
            InsertUpdateData(cmd);
        }
    }

    private Boolean InsertUpdateData(SqlCommand cmd)
    {
        //String strConnString = System.Configuration.ConfigurationManager
        //.ConnectionStrings["conString"].ConnectionString;
        SqlConnection con = new SqlConnection(strConnection);
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            return true;
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            return false;
        }
        finally
        {
            con.Close();
            con.Dispose();
            Response.Redirect("JoshsTemp.aspx");
        }
    }
}