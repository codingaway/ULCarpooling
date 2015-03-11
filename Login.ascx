<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Login.ascx.cs" Inherits="Login" %>
<div class="form-signin">
    <h2 class="form-signin-heading">Please sign in</h2>
    <asp:Label ID="lblEmail" CssClass="sr-only" runat="server" Text="Email"></asp:Label>
    <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email address" runat="server"></asp:TextBox>

    <asp:Label ID="lblPassword" CssClass="sr-only" runat="server" Text="Password"></asp:Label>

    <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" runat="server"></asp:TextBox>

    <asp:Button ID="btnLogin" CssClass="btn btn-lg btn-primary btn-block" runat="server" Text="Sign in" />
    <p>
      <span> Not registered? </span>
    <asp:LinkButton ID="btnSignup"  runat="server">Sign in</asp:LinkButton>
    </p>
     <asp:LinkButton ID="btnForgotPass" runat="server">Forgot Password</asp:LinkButton>



<%--    <label for="inputPassword" class="sr-only">Password</label>
    <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
    <div class="checkbox">
        <label>
            <input type="checkbox" value="remember-me">
            Remember me
        </label>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>--%>
</div>
