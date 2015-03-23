<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Register.ascx.cs" Inherits="Register" %>
<h3>Sign up</h3>
<br />
<asp:Label ID="lblEmail" runat="server" Text="UL Email"></asp:Label>
&nbsp;
<asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
<br />
<br />
<asp:Label ID="lblEmailConfirm" runat="server" Text="Confirm Email"></asp:Label>
&nbsp;
<asp:TextBox ID="txtEmailConfirm" runat="server" TextMode="Email"></asp:TextBox>
<br />
<p>
    <br />
    <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
&nbsp;
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
</p>
<p>
    <br />
    <asp:Label ID="lbPassConfirm" runat="server" Text="Confirm Password"></asp:Label>
&nbsp;
    <asp:TextBox ID="txtPassConfirm" runat="server" TextMode="Password"></asp:TextBox>
</p>
<p>
    <br />
    <asp:Label ID="lblFname" runat="server" Text="First Name"></asp:Label>
&nbsp;
    <asp:TextBox ID="txtFName" runat="server"></asp:TextBox>
</p>
<p>
    <br />
    <asp:Label ID="lblSName" runat="server" Text="Surname"></asp:Label>
&nbsp;
    <asp:TextBox ID="txtSName" runat="server"></asp:TextBox>
</p>
<p>
    <br />
    <asp:Label ID="lblMobile" runat="server" Text="Mobile"></asp:Label>
&nbsp;
    <asp:TextBox ID="txtMobile" runat="server"></asp:TextBox>
</p>
<p>
    <br />
    <asp:Label ID="lblDOB" runat="server" Text="Date of Birth"></asp:Label>
&nbsp;
    <asp:TextBox ID="txtDOB" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
</p>
<p>
    <asp:Label ID="lblGender" runat="server" Text="Gender"></asp:Label>
&nbsp;
    <asp:RadioButtonList ID="rblGender" runat="server">
        <asp:ListItem Value="0">Male</asp:ListItem>
        <asp:ListItem Value="1">Female</asp:ListItem>
    </asp:RadioButtonList>
</p>
<p>
    <asp:Label ID="lblSmoker" runat="server" Text="Smoker"></asp:Label>
&nbsp;
    <asp:RadioButtonList ID="rblSmoker" runat="server">
        <asp:ListItem Value="1">Yes</asp:ListItem>
        <asp:ListItem Value="0">No</asp:ListItem>
    </asp:RadioButtonList>
</p>
<p>
    <asp:CheckBox ID="chkAccept" runat="server" Text="By clicking here I am confirmng that all information above are true and I accepting the terms and condition of ULCArpooling.ie" />
</p>
<asp:Button ID="btnRegister" runat="server" Text="Register" />
&nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" />
&nbsp;
<asp:Button ID="btnReset" runat="server" Text="Reset" />

