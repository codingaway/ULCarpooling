<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddRequest.aspx.cs" Inherits="AddRequest" %>

<%@ Register Src="~/Controls/AddRequestCtrl.ascx" TagPrefix="uc1" TagName="AddRequestCtrl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:AddRequestCtrl runat="server" ID="AddRequestCtrl" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

