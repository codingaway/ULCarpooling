<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="TestingPage.aspx.cs" Inherits="TestingPage" %>

<%@ Register Src="~/Controls/Search.ascx" TagPrefix="uc1" TagName="Search" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<uc1:Search runat="server" loggedIntUserId="<%#userID%>" ID="Search" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

