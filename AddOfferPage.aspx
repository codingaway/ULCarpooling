﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddOfferPage.aspx.cs" Inherits="AddOfferPage" %>
<%@ Register Src="~/Controls/AddOfferCtrl.ascx" TagPrefix="uc1" TagName="AddOfferCtrl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:AddOfferCtrl runat="server" ID="AddOfferCtrl" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

