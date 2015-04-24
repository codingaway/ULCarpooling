<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddOffer.aspx.cs" Inherits="AddOffer" %>
<%@ Register Src="~/Controls/AddOfferCtrl.ascx" TagPrefix="uc1" TagName="AddOfferCtrl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="Content/chosen.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:AddOfferCtrl runat="server" ID="AddOfferCtrl" />

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

                    elements[i].value = "";break;

                case "radio":

                case "checkbox":

                    if (elements[i].checked) {
                        elements[i].checked = false;
                    } break;

                case "select-one":

                case "select-multi":
                    elements[i].selectedIndex = 0;break;

                default: break;
            }
        }
    }
</script>
</asp:Content>

