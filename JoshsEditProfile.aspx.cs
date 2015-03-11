using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;

public partial class JoshsEditProfile : System.Web.UI.Page
{
    string strConnection = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Loaner\\ULCarpooling\\App_Data\\carpooling_db.mdf;Integrated Security=True;";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection sql = null;

        /*string saveDir = @"Images\";
        string appPath = Request.PhysicalApplicationPath;
        string savePath;*/
        try
        {
            Byte[] imgByte = null;
            FileUpload img = (FileUpload)imageUpload;

            if (img.HasFile)
            {
                if (checkFileType(img.FileName) == true)
                {
                    HttpPostedFile File = imageUpload.PostedFile;
                    imgByte = new Byte[File.ContentLength];
                    File.InputStream.Read(imgByte, 0, File.ContentLength);
                }
                else
                    Response.Write("Incorrect file type.");
            }

            sql = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Loaner\\ULCarpooling\\App_Data\\carpooling_db.mdf;Integrated Security=True;");
            sql.Open();

            string sqlComm = "INSERT INTO users(FName, SName, Email, Mobile, profile_pic) VALUES(@)";

            SqlCommand cmd = new SqlCommand(sqlComm, sql);

            
        }
        catch
        {
            
        }
        finally
        {

        }
    }

    protected bool checkFileType(string f)
    {
        string ext = Path.GetExtension(f);
        ext = ext.ToLower();
        switch(ext)
        {
            case ".gif": case ".png": case ".jpg": case ".jpeg": return true;
            default: return false;
        }
    }
}