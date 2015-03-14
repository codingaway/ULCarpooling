<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Default6" %>

<%--<%@ Reference Control="~/Login.ascx" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <asp:PlaceHolder ID="plhLogin" runat="server"></asp:PlaceHolder>--%>
    <div class="container">
        <div class="form-signin">
            <h2 class="form-signin-heading">Please sign in</h2>
            <asp:Label ID="lblEmail" CssClass="sr-only" runat="server" Text="Email"></asp:Label>
            <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email address" runat="server"></asp:TextBox>

            <asp:Label ID="lblPassword" CssClass="sr-only" runat="server" Text="Password"></asp:Label>

            <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" runat="server"></asp:TextBox>
            <asp:CheckBox ID="chkRemember" CssClass="checkbox" runat="server" Text="Remember me" />

            <asp:Button ID="btnLogin" CssClass="btn btn-lg btn-primary btn-block" runat="server" Text="Sign in" OnClick="btnLogin_Click" />
            <p>
                <span>Not registered? </span>
                <asp:LinkButton ID="btnSignup" runat="server">Sign in</asp:LinkButton>
            </p>
            <asp:LinkButton ID="btnForgotPass" runat="server">Forgot Password</asp:LinkButton>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>

