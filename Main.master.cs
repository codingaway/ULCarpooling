using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;

public partial class Main : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //protected override void OnPreRender(EventArgs e)
    //{
    //    base.OnPreRender(e);
    //    LoadScript();
    //}

    protected void lbtnLogin_Click(object sender, EventArgs e)
    {
        //ASP.login_ascx searchControl = (ASP.login_ascx)LoadControl("~/Login.ascx");
        //ContentPlaceHolder1.Controls.Clear();
        //ContentPlaceHolder1.Controls.Add(searchControl);
    }

    private void LoadScript()
    {

        String scriptName = "DateValidation";
        String scriptUrl = "~/Scripts/dateValidation.js";
        Type scriptType = this.GetType();

        
        ClientScriptManager clientScriptManager = Page.ClientScript;

        if (!clientScriptManager.IsClientScriptIncludeRegistered(scriptType, scriptName))
        {
            clientScriptManager.RegisterClientScriptInclude(scriptType, scriptName, ResolveClientUrl(scriptUrl));
        }

    }
}
