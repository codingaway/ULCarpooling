<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>
<%@ Register Src="~/AddOfferCtrl.ascx" TagPrefix="uc1" TagName="AddOfferCtrl" %>
<%@ Register Src="~/AddRequestCtrl.ascx" TagPrefix="uc1" TagName="AddRequestCtrl" %>
<%@ Register Src="~/StaticalAnalysisCtrl1.ascx" TagPrefix="uc1" TagName="StaticalAnalysisCtrl1" %>
<%@ Register Src="~/StaticalAnalysisCtrl2.ascx" TagPrefix="uc1" TagName="StaticalAnalysisCtrl2" %>
<%@ Register Src="~/Controls/AddOfferCtrl.ascx" TagPrefix="uc2" TagName="AddOfferCtrl" %>
<%@ Register Src="~/Controls/AddRequestCtrl.ascx" TagPrefix="uc2" TagName="AddRequestCtrl" %>





<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<%--<uc1:StaticalAnalysisCtrl2 runat="server" id="StaticalAnalysisCtrl2" />--%>
<%--<uc1:StaticalAnalysisCtr11 runat="server" ID="StaticalAnalysisCtrl1" />--%>
<uc2:AddOfferCtrl runat="server" ID="AddOfferCtrl" />
<%--<uc2:AddRequestCtrl runat="server" ID="AddRequestCtrl" />--%>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
    
</asp:Content>

