using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Recovery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.IsAuthenticated)
        {
            Response.Redirect("Default.aspx");
        }
        else if(!IsPostBack)
        {
            pnlQuestion.Enabled = false;
            pnlQuestion.Visible = false;
            pnlPassword.Enabled = false;
            pnlPassword.Visible = false;
        }
    }
    protected void btnCheckEmail_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text;
        bool isRegistered = !DBHelper.isEmailUnique(email);
        if(isRegistered && !(DBHelper.isUserBanned(email)))
        {
            pnlQuestion.Enabled = true;
            pnlQuestion.Visible = true;
            string [] qAndA = DBHelper.getQandA(email);
            lblQuestion.Enabled = true;
            
            lblQuestion.Text = qAndA[0];
            lblQuestion.Visible = true;
        }
        

    }
    protected void btnCheckAnswer_Click(object sender, EventArgs e)
    {
        string answer = txtAnswer.Text;
        string email = txtEmail.Text;
        if(DBHelper.verifySecreteAns(email, answer))
        {
            pnlPassword.Enabled = true;
            pnlPassword.Visible = true;
        }
    }
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if(Page.IsValid)
        {
            string email = txtEmail.Text;
            string newPassword = txtConfirmPass.Text;
            DBHelper.changePassword(email, newPassword);
        }
    }
}