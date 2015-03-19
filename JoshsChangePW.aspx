<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JoshsChangePW.aspx.cs" Inherits="JoshsChangePW" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:TextBox ID="txtOldPW" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblOldPw" runat="server" Text="Old Password"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="txtNewPW" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblNewPw" runat="server" Text="New Password"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="txtConfirmPW" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblConfirmPW" runat="server" Text="Confirm Password"></asp:Label>
    
        <br />
        <br />
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
    
    </div>
    </form>
</body>
</html>
