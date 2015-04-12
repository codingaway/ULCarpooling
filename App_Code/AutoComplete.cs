using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for AutoComplete
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class AutoComplete : System.Web.Services.WebService {

    public AutoComplete () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public string[] GetLocationList(string prefixText, int count)
    {
        SqlConnection cn = new SqlConnection();
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();

        String aQuery = "data source=.;Initial Catalog=MyDB;Integrated Security=True";
        cn.ConnectionString = aQuery;
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.Text;
        //Compare String From Textbox(prefixText) AND String From Database
        cmd.CommandText = "select * from vGetPlaceName WHERE pname like @myParameter";
        cmd.Parameters.AddWithValue("@myParameter", "%" + prefixText + "%");

        try
        {
            cn.Open();
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        finally
        {
            cmd.Dispose();
            cn.Dispose();
        }
        dt = ds.Tables[0];

        List<string> txtItems = new List<string>();
        String dbValues;
        foreach (DataRow row in dt.Rows)
        {
            //String From DataBase(dbValues)
            dbValues = row["pname"].ToString();
            dbValues = dbValues.ToLower();
            txtItems.Add(dbValues);
        }

        return txtItems.ToArray();
    }
}
