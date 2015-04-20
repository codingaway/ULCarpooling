<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>
<%@ Register Src="~/Controls/AddOfferCtrl.ascx" TagPrefix="uc2" TagName="AddOfferCtrl" %>
<%@ Register Src="~/Controls/AddRequestCtrl.ascx" TagPrefix="uc2" TagName="AddRequestCtrl" %>
<%@ Register Src="~/Controls/GraphCtrlBarOfferPick.ascx" TagPrefix="uc2" TagName="GraphCtrlBarOfferPick" %>
<%@ Register Src="~/Controls/GraphCtrlDounutOfferDrop.ascx" TagPrefix="uc2" TagName="GraphCtrlDounutOfferDrop" %>
<%@ Register Src="~/Controls/GraphCtrlBarRequestDrop.ascx" TagPrefix="uc2" TagName="GraphCtrlBarRequestDrop" %>
<%@ Register Src="~/Controls/GraphCtrlDounutRequestPick.ascx" TagPrefix="uc2" TagName="GraphCtrlDounutRequestPick" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%--<uc2:AddOfferCtrl runat="server" ID="AddOfferCtrl" />--%>
    <%--<uc2:AddRequestCtrl runat="server" ID="AddRequestCtrl" />--%>
<uc2:GraphCtrlBarOfferPick runat="server" ID="GraphCtrlBarOfferPick" />
    <uc2:GraphCtrlDounutOfferDrop runat="server" ID="GraphCtrlDounutOfferDrop" />
    <uc2:GraphCtrlDounutRequestPick runat="server" ID="GraphCtrlDounutRequestPick" />
    <uc2:GraphCtrlBarRequestDrop runat="server" ID="GraphCtrlBarRequestDrop" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
    
</asp:Content>

