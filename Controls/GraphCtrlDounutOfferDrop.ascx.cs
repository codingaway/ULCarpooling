using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.DataVisualization.Charting;

public partial class GraphCtrlDounutOfferDrop : System.Web.UI.UserControl
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        Chart1.Series["DropOffOffering"].ChartType = SeriesChartType.Doughnut;

        SqlCommand cmd1 = new SqlCommand("Select TOP 7 offer_rec.place_to As Place, places.place_name As PickUp, Count(*) As Occurence FROM offer_rec JOIN places on offer_rec.place_to = places.Place_id GROUP BY offer_rec.place_to,places.place_name ORDER BY Count(*) DESC", con1);
        cmd1.CommandType = CommandType.Text;

        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = cmd1;

        DataTable dt = new DataTable();

        da.Fill(dt);

        Chart1.DataSource = dt;
        Chart1.Series["DropOffOffering"].XValueMember = "PickUp";
        Chart1.Series["DropOffOffering"].YValueMembers = "Occurence";
        Chart1.Series["DropOffOffering"].AxisLabel = "PickUp";
        Chart1.DataBind();
    }
}