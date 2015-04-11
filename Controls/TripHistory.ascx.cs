using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;


public partial class TripHistory : System.Web.UI.UserControl
{
    public string userID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        DataBind();
        string query = "SELECT trip_rec.date_time, a.place_name as place_from, b.place_name as place_to, trip_rec.trip_id FROM trip_rec Join places a on a.Place_id = trip_rec.place_from Join places b on b.Place_id = trip_rec.place_to WHERE trip_rec.driver =" + userID;
        SqlDataSource4.SelectCommand = query;
        ListView4.DataBind();
    }

    protected void ListView4_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }
}