using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class TestDateTimeValidation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //string dateString = txtDateTime.Text;
        //string format = "dd/MM/yyyy HH:mm";
        //DateTime datetime;

        //if (DateTime.TryParseExact(dateString, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out datetime))
        //{
        //    CustomValidator1.IsValid = true;
        //    lblMessage.Text = "Valid date: ";
        //}
        //else
        //{
        //    CustomValidator1.IsValid = false;
        //    lblMessage.Text = "Invalid date: ";
        //}
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        LoadScript();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
    }

    private void LoadScript()
    {

        String scriptName = "DateValidator";
        String scriptUrl = "~/Scripts/dateValidation.js";
        Type scriptType = this.GetType();

        ClientScriptManager clientScriptManager = Page.ClientScript;

        if (!clientScriptManager.IsClientScriptIncludeRegistered(scriptType, scriptName))
        {
            clientScriptManager.RegisterClientScriptInclude(scriptType, scriptName, ResolveClientUrl(scriptUrl));
        }

    }
}