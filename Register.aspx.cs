using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class RegisterPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.IsAuthenticated) //If user already has logged in then redirect from this page
        {
            Response.Redirect("~/Default.aspx");
        }

        if(IsPostBack)
        {

        }
    }

    /* Server validation method to check if supplied email is unique to the database */
    protected void serverValIsUniqueEmail(object sender, ServerValidateEventArgs args)
    {
        args.IsValid = DBHelper.isEmailUnique(args.Value);
    }


    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if(IsValid)
        {
            //Localized the date format
            DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime dob = Convert.ToDateTime(txtDoB.Text, dateInfo);

            string smoker = rblSmoker.SelectedIndex == 1 ? "y" : "n";
            string gender = rblGender.SelectedIndex == 1? "m" : "f";

            //Read form inputs and create a new user
            bool insertSuccess = DBHelper.addNewUser(txtFName.Text, txtSName.Text, txtEmail.Text, dob, 
                txtPassword.Text, txtQuestion.Text, txtAnswer.Text, txtPhone.Text,
                rblUserType.SelectedValue, rblSmoker.SelectedValue, rblGender.SelectedValue);

            //On success show message confirming that user is registered 
            if (insertSuccess)
            {
                lblPageHeader.Text = "Thank you";
                lblFormMessage.Text = "You have registered succefully.";
                pnlFormInput.Visible = false;
            }
            else
            {
                lblPageHeader.Text = "Error processing";
                lblFormMessage.Text = "Registration is not complete.";
                lblFormMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
        //clearFormFields(Page.Controls);
    }

    private void clearFormFields(ControlCollection controls)
    {

        foreach (Control c in controls)
        {
            foreach (Control childc in c.Controls)
            {
                if (childc is TextBox)
                {
                    ((TextBox)childc).Text = string.Empty;
                }

                if (childc is RadioButtonList)
                {
                    ((RadioButtonList)childc).ClearSelection();
                }
                clearFormFields(childc.Controls); //Recursive calls for any child controls
            }
        }
    }
}