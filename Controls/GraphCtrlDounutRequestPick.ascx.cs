using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.DataVisualization.Charting;

public partial class GraphCtrlDounutRequestPick : System.Web.UI.UserControl
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        Chart1.Series["PickUpRequesting"].ChartType = SeriesChartType.Doughnut;

        SqlCommand cmd1 = new SqlCommand("Select req_rec.place_to As Place, places.place_name As PickUp, Count(*) As Occurence FROM req_rec JOIN places on req_rec.place_to = places.Place_id GROUP BY req_rec.place_to,places.place_name", con1);
        cmd1.CommandType = CommandType.Text;

        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = cmd1;

        DataTable dt = new DataTable();

        da.Fill(dt);

        Chart1.DataSource = dt;
        Chart1.Series["PickUpRequesting"].XValueMember = "PickUp";
        Chart1.Series["PickUpRequesting"].YValueMembers = "Occurence";
        Chart1.Series["PickUpRequesting"].AxisLabel = "PickUp";
        Chart1.DataBind();
    }

}