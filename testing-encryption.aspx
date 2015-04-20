<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testing-encryption.aspx.cs" Inherits="testing_encryption" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <asp:Label ID="Label1" runat="server" Text="Create new user"></asp:Label>
        <br />
        <br />
        <br />
        <asp:Label ID="lblID" runat="server" Text="ID"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtID" runat="server" Height="16px" Width="228px"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Email"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtAddEmail" runat="server" Height="16px" Width="228px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtAddPassword" runat="server" Height="16px" Width="228px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnAddUser" runat="server" OnClick="btnAddUser_Click" Text="Add user" />
        <br />
        <br />
        <asp:Label ID="Label9" runat="server" Text="Password"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblPassword" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label7" runat="server" Text="SHA256 hash:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblHashOutput" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="Hash Length:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblHashLength" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Verify user"></asp:Label>
        <br />
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Email"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtVerifyEmail" runat="server" Height="16px" Width="228px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="Password"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtVerifyPassword" runat="server" Height="16px" Width="228px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnVerify" runat="server" OnClick="btnVerify_Click" Text="Change Password" />
        <br />
        <br />
        <asp:Label ID="lblVerfiedResult" runat="server"></asp:Label>
&nbsp;
        <br />
        <br />
        <asp:Label ID="lblShowHash2" runat="server">HASH2:</asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblNewHash" runat="server"></asp:Label>
        <br />
        <br />
        <br />
        
    </div>
    </form>
</body>
</html>
