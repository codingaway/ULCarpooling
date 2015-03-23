using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Get Login link button from master page
        //MasterPage mstr = (MasterPage)this.Parent.Page.Master;
        //LinkButton loginLink = mstr.FindControl("lbtnLogin") as LinkButton;



    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        //string[] UserNameCollection = { "JoeStagner", "ScottGu", "SimonMu" };
        //string[] PasswordCollection = { "password", "password", "password" };

        //for (int Iterator = 0; Iterator <= UserNameCollection.Length - 1; Iterator++)
        //{
        //    bool UserNameIsValid = (string.Compare(UserName.Text, UserNameCollection[Iterator], true) == 0);
        //    bool PasswordIsValid = (string.Compare(Password.Text, PasswordCollection[Iterator], false) == 0);

        //    if (UserNameIsValid && PasswordIsValid)
        //    {
        //        Parent.FormsAuthentication.RedirectFromLoginPage(UserName.Text, false);
        //    }
        //}
    }
}