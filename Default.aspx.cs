using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default : System.Web.UI.Page
{

    protected void Page_PreInit(object sender, EventArgs e)
    {
       
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }

    protected void Page_PreLoad(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

        }
        else //PostBack
        {

        }
    }
}