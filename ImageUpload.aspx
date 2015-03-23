<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImageUpload.aspx.cs" Inherits="ImageUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="User_ID"></asp:Label>
        <br />
        <asp:TextBox ID="txtUserID" runat="server"></asp:TextBox>
        <br />
        s
        

<asp:FileUpload ID="FileUpload1" runat="server" />

<asp:Button ID="btnUpload" runat="server" Text="Upload"

OnClick="btnUpload_Click" />

<br />

<asp:Label ID="lblMessage" runat="server" Text=""

Font-Names = "Arial"></asp:Label>

    
    </div>
    </form>
</body>
</html>
