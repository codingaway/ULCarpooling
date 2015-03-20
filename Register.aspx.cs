using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RegisterPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ASP.login_ascx login = (ASP.login_ascx)LoadControl("~/Login.ascx");
        //plhLogin.Controls.Add(login);

        //string chkBoxScrpit = "function isChkTermsChecked(sender, e){e.IsValid = $('#<%=valSummary.ClientID%>').is(':checked');}";
        //ClientScript.RegisterOnSubmitStatement(this.GetType(), "isChkTermsChecked", chkBoxScrpit);

        if(IsPostBack)
        {

        }
    }

    //protected void CheckBoxRequired_ServerValidate(object sender, ServerValidateEventArgs e)
    //{
    //    e.IsValid = chkTerms.Checked;
    //}


    /* Server validation method to check if supplied email is unique to the database */
    protected void serverValIsUniqueEmail(object sender, ServerValidateEventArgs args)
    {
        args.IsValid = DBHelper.isEmailUnique(args.Value);
    }


    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if(IsValid)
        {
            //Read form inputs and create a new user

            //On success show message confirming that user is registered 
            lblPageHeader.Text = "Thank you";
            lblFormMessage.Text = "You have registered succefully.";
            pnlFormInput.Visible = false;
        }

    }
}