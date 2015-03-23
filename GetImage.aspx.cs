using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class GetImage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ImageID"] != null)
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DbConnString"].ConnectionString;
            string strQuery = "select image_name, content_type, data from profile_image where User_ID=@id";
            SqlCommand cmd = new SqlCommand(strQuery);
            SqlDataAdapter da = new SqlDataAdapter();
            cmd.Parameters.Add("@id", SqlDbType.Int).Value
            = Convert.ToInt32(Request.QueryString["ImageID"]);
            cmd.Connection = conn;
            da.SelectCommand = cmd;
            conn.Open();
            
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt != null && dt.Rows.Count > 0)
            {
                Byte[] bytes = (Byte[])dt.Rows[0]["data"];
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = dt.Rows[0]["content_type"].ToString();
                Response.AddHeader("content-disposition", "attachment;filename="
                + dt.Rows[0]["image_name"].ToString());
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();
            }
        }
    }
}