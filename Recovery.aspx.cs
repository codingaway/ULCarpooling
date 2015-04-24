using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Recovery : System.Web.UI.Page
{
    protected int countAttempt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.IsAuthenticated)
        {
            Response.Redirect("Default.aspx");
        }
        else if(!IsPostBack)
        {
            countAttempt = 0;
            pnlQuestion.Enabled = false;
            pnlQuestion.Visible = false;
            pnlPassword.Enabled = false;
            pnlPassword.Visible = false;
        }
        else
        {
            countAttempt = Convert.ToInt32(ViewState["countAttempt"].ToString());
        }
    }
    protected void btnCheckEmail_Click(object sender, EventArgs e)
    {
        if (countAttempt < 3)
        {
            string email = txtEmail.Text;
            bool isRegistered = !DBHelper.isEmailUnique(email);
            if (isRegistered && !(DBHelper.isUserBanned(email)))
            {
                pnlQuestion.Enabled = true;
                pnlQuestion.Visible = true;
                string[] qAndA = DBHelper.getQandA(email);
                lblQuestion.Enabled = true;

                lblQuestion.Text = qAndA[0];
                lblQuestion.Visible = true;
                countAttempt = 0;
            }
            else
                countAttempt++;
        }
        else
        {
            Response.Redirect("Default.aspx");
        }

    }
    protected void btnCheckAnswer_Click(object sender, EventArgs e)
    {
        if (countAttempt < 3)
        {
            string answer = txtAnswer.Text;
            string email = txtEmail.Text;
            if (DBHelper.verifySecreteAns(email, answer))
            {
                pnlPassword.Enabled = true;
                pnlPassword.Visible = true;
                countAttempt = 0;
            }
            else
                countAttempt++;
        }
        else
        {
            Response.Redirect("Default.aspx");
        }

    }
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if(Page.IsValid)
        {
            string email = txtEmail.Text;
            string newPassword = txtConfirmPass.Text;
            DBHelper.changePassword(email, newPassword);

            txtPassword.Enabled = false;
            txtConfirmPass.Enabled = false;
            btnChangePassword.Enabled = false;
            lblMessage.Text = "Password Changed";
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["countAttempt"] = Convert.ToString(countAttempt);
    }
}