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

            string smoker = rblSmoker.SelectedIndex.ToString();
            string gender = rblGender.SelectedIndex.ToString();

            //Read form inputs and create a new user
            bool insertSuccess = DBHelper.addNewUser(txtFName.Text, txtSName.Text, txtEmail.Text, dob, txtPassword.Text, txtQuestion.Text, txtAnswer.Text, txtPhone.Text, rblUserType.SelectedIndex + 1, smoker, gender);

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
                //pnlFormInput.Visible = false;
            }
        }

    }
}