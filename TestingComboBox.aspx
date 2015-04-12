<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestingComboBox.aspx.cs" Inherits="TestingComboBox" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div>
        <cc1:ComboBox ID="ComboBox1" runat="server"
          AutoCompleteMode="Suggest"  DropDownStyle="Simple" DataSourceID="SqlDataSource1" DataTextField="pname" DataValueField="place_id" MaxLength="0" style="display: inline;" AppendDataBoundItems="True"  >
        </cc1:ComboBox>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnString %>" SelectCommand="SELECT * FROM [vGetPlaceName]"></asp:SqlDataSource>

        <asp:Button ID="Button1" runat="server" Text="Button" />
    </div>
    </form>
</body>
</html>
