<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>
<%@ Register Src="~/AddOfferCtrl.ascx" TagPrefix="uc1" TagName="AddOfferCtrl" %>
<%@ Register Src="~/AddRequestCtrl.ascx" TagPrefix="uc1" TagName="AddRequestCtrl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<uc1:AddOfferCtrl runat="server" id="AddOfferCtrl" />
<%--<uc1:AddRequestCtrl runat="server" id="AddRequestCtrl" />--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

