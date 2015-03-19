<%@ Page Title="Sign in" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<%--<%@ Reference Control="~/Login.ascx" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <asp:PlaceHolder ID="plhLogin" runat="server"></asp:PlaceHolder>--%>
    <div class="container">
        <div class="form-signin">
            <h3 class="form-signin-heading">Please sign in</h3>
            <asp:Label ID="lblEmail" CssClass="sr-only" runat="server" Text="Email"></asp:Label>
            <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email address" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="valRegExpEmail" runat="server"
                 CssClass="text-warning"
                ErrorMessage="Email must be a valid UL email address"
                ValidationGroup="Login"
                ControlToValidate="txtEmail" ValidationExpression="^([1-9]{1}\d{6,7}@studentmail.ul.ie)|([aA-zZ]+\w*([-+.']\w+)*@ul.ie)$" >
            </asp:RegularExpressionValidator>
            <asp:Label ID="lblPassword" CssClass="sr-only" runat="server" Text="Password"></asp:Label>
            
            <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="valReqFieldPassword" runat="server"
                 ControlToValidate ="txtPassword" 
                CssClass="text-warning"
                ValidationGroup="Login"
                ErrorMessage="Password required">
            </asp:RequiredFieldValidator>
            <asp:CheckBox ID="chkRemember" CssClass="checkbox" runat="server" Text="Remember me" />

            <asp:Button ID="btnLogin" CssClass="btn btn-lg btn-primary btn-block" runat="server" Text="Sign in" ValidationGroup="Login" OnClick="btnLogin_Click" />
            <p>
                <span>Not registered? </span>
                <asp:LinkButton ID="btnSignup" runat="server">Sign up</asp:LinkButton>
            </p>
            <asp:LinkButton ID="btnForgotPass" runat="server">Forgot Password</asp:LinkButton>
            <br />
            <asp:Label ID="lblErrorMsg" CssClass="text-danger text-right" runat="server" Text="Label" Visible="false"></asp:Label>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>

