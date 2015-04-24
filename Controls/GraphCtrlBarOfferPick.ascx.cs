using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;

public partial class GraphCtrlBarOfferPick : System.Web.UI.UserControl
{
    SqlConnection con1 = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\carpooling_db.mdf;Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        Chart1.Series["Series1"].ChartType = SeriesChartType.Column;
        
        Chart1.Series["Series1"].IsValueShownAsLabel = true;

        SqlCommand cmd1 = new SqlCommand("Select TOP 7 offer_rec.place_from As Place, places.place_name As PickUp, Count(*) As Occurence FROM offer_rec JOIN places on offer_rec.place_from = places.Place_id GROUP BY offer_rec.place_from,places.place_name ORDER BY Count(*) DESC", con1);
        cmd1.CommandType = CommandType.Text;

        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = cmd1;

        DataTable dt = new DataTable();

        da.Fill(dt);

        Chart1.DataSource = dt;
        Chart1.Series["Series1"].XValueMember = "PickUp";
        Chart1.Series["Series1"].YValueMembers = "Occurence";
        Chart1.DataBind();

        int noRows = dt.Rows.Count;

        switch (noRows)
        {
            case 1: Chart1.Series["Series1"].Points[1].Color = Color.FromArgb(168, 216, 240); break;
            case 2: Chart1.Series["Series1"].Points[0].Color = Color.FromArgb(72, 120, 168);
                Chart1.Series["Series1"].Points[1].Color = Color.FromArgb(168, 216, 240); break;
            case 3: Chart1.Series["Series1"].Points[0].Color = Color.FromArgb(72, 120, 168);
                Chart1.Series["Series1"].Points[1].Color = Color.FromArgb(168, 216, 240);
                Chart1.Series["Series1"].Points[2].Color = Color.FromArgb(240, 120, 48); break;
            case 4: Chart1.Series["Series1"].Points[0].Color = Color.FromArgb(72, 120, 168);
                Chart1.Series["Series1"].Points[1].Color = Color.FromArgb(168, 216, 240);
                Chart1.Series["Series1"].Points[2].Color = Color.FromArgb(240, 120, 48);
                Chart1.Series["Series1"].Points[3].Color = Color.FromArgb(120, 24, 0); break;
            case 5: Chart1.Series["Series1"].Points[0].Color = Color.FromArgb(72, 120, 168);
                Chart1.Series["Series1"].Points[1].Color = Color.FromArgb(168, 216, 240);
                Chart1.Series["Series1"].Points[2].Color = Color.FromArgb(240, 120, 48);
                Chart1.Series["Series1"].Points[3].Color = Color.FromArgb(120, 24, 0);
                Chart1.Series["Series1"].Points[4].Color = Color.FromArgb(72, 120, 144); break;
            case 6: Chart1.Series["Series1"].Points[0].Color = Color.FromArgb(72, 120, 168);
                Chart1.Series["Series1"].Points[1].Color = Color.FromArgb(168, 216, 240);
                Chart1.Series["Series1"].Points[2].Color = Color.FromArgb(240, 120, 48);
                Chart1.Series["Series1"].Points[3].Color = Color.FromArgb(120, 24, 0);
                Chart1.Series["Series1"].Points[4].Color = Color.FromArgb(72, 120, 144);
                Chart1.Series["Series1"].Points[5].Color = Color.FromArgb(102, 102, 102); break;
            case 7: Chart1.Series["Series1"].Points[0].Color = Color.FromArgb(72, 120, 168);
                Chart1.Series["Series1"].Points[1].Color = Color.FromArgb(168, 216, 240);
                Chart1.Series["Series1"].Points[2].Color = Color.FromArgb(240, 120, 48);
                Chart1.Series["Series1"].Points[3].Color = Color.FromArgb(120, 24, 0);
                Chart1.Series["Series1"].Points[4].Color = Color.FromArgb(72, 120, 144);
                Chart1.Series["Series1"].Points[5].Color = Color.FromArgb(102, 102, 102);
                Chart1.Series["Series1"].Points[6].Color = Color.FromArgb(87, 34, 0); break;
        }
    }
}