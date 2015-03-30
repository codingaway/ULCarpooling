<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestDateTimeValidation.aspx.cs" Inherits="TestDateTimeValidation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Enter Date-time"></asp:Label>
        <br />
      <%--  <input type="text" id="dateinput" />--%>
        <asp:TextBox ID="txtDateTime" runat="server"></asp:TextBox> 
        <asp:CustomValidator ID="CustomValidator1" runat="server"
             ErrorMessage="Date is invalid" 
            ControlToValidate="txtDateTime"
             ClientValidationFunction="checkDate" OnServerValidate="CustomValidator1_ServerValidate">
        </asp:CustomValidator>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Button" CausesValidation="true" OnClick="Button1_Click" />
        <%--<input type="button" onclick="checkDate(document.getElementById('dateinput').value)" value="Check date" name="Check date"/>--%>
        <br />
        <asp:Label ID="lblMessage" Text="" runat="server" />
    </div>
    </form>
</body>
</html>
