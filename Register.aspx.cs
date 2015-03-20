using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration; /*Required for reading connection string from Web.config */
using System.Data;
using System.Data.SqlClient;

public partial class Default6 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ASP.login_ascx login = (ASP.login_ascx)LoadControl("~/Login.ascx");
        //plhLogin.Controls.Add(login);

        //string chkBoxScrpit = "function isChkTermsChecked(sender, e){e.IsValid = $('#<%=valSummary.ClientID%>').is(':checked');}";
        //ClientScript.RegisterOnSubmitStatement(this.GetType(), "isChkTermsChecked", chkBoxScrpit);
    }

    //protected void CheckBoxRequired_ServerValidate(object sender, ServerValidateEventArgs e)
    //{
    //    e.IsValid = chkTerms.Checked;
    //}

}