<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddRequest.aspx.cs" Inherits="AddRequest" %>

<%@ Register Src="~/Controls/AddRequestCtrl.ascx" TagPrefix="uc1" TagName="AddRequestCtrl" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="Content/chosen.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <%--Add Request control--%>
    <uc1:AddRequestCtrl runat="server" ID="AddRequestCtrl" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">

 <script src="Scripts/chosen.jquery.min.js"></script>
    <%--Datetime picker--%>
    <script>
        $(function () {
            $('.date').datetimepicker(
                {
                    format: "DD/MM/YYYY HH:mm",
                    stepping: 5,
                    showClear: true,
                    showClose: true,
                    inline: true
                });
        });
        </script>

</asp:Content>

