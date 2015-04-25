<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddRequest.aspx.cs" Inherits="AddRequest" %>
<%@ Register Src="~/Controls/AddRequestCtrl.ascx" TagPrefix="uc1" TagName="AddRequestCtrl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <%--Add Request control--%>
    <uc1:AddRequestCtrl runat="server" ID="AddRequestCtrl" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
    <script src="Scripts/moment.min.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
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

<%--Reset Button JavaScript--%>
<script>
    function clearForm(oForm) {
        var elements = oForm.elements;
        oForm.reset();
        for (i = 0; i < elements.length; i++) {
            field_type = elements[i].type.toLowerCase();
            switch (field_type) {
                case "text":

                case "password":

                case "textarea":

                    elements[i].value = ""; break;

                case "radio":

                case "checkbox":

                    if (elements[i].checked) {
                        elements[i].checked = false;
                    } break;

                case "select-one":

                case "select-multi":
                    elements[i].selectedIndex = 0; break;

                default: break;
            }
        }
    }
</script>
</asp:Content>

