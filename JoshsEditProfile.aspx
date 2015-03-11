<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JoshsEditProfile.aspx.cs" Inherits="JoshsEditProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblPhone" runat="server" Text="Phone"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblPW" runat="server" Text="Password"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="txtConfirmPW" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblConfirmPW" runat="server" Text="Confirm Password"></asp:Label>
        <br />
        <br />
        <asp:FileUpload ID="imageUpload" runat="server" />
&nbsp;&nbsp;
        <br />
        <br />
       <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
    
    </div>
    </form>
</body>
</html>
