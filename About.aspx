<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" EnableEventValidation="false"%> <%-- --%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="~/Controls/PendingOffers.ascx" TagPrefix="uc1" TagName="PendingOffers" %>
<%@ Register Src="~/Controls/PendingRequests.ascx" TagPrefix="uc2" TagName="PendingRequests" %>
<%@ Register Src="~/Controls/TripHistory.ascx" TagPrefix="uc3" TagName="TripHistory" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>ABOUT</h2>
    <p>ULCarpooling is a website which offers reliable car sharing opportunities for the University of Limerick community that is fast, efficient and easy to access. You can use our service via the web currently, with a mobile version of the service to be launched soon. With just a few clicks, drivers can offer available seats and passengers can book a ride.</p>

    <p>For staff, there are a number of designated car-pooling parking spaces at various locations on campus, though it is not a requirement to use these spaces for car sharing. Any parking space will do. For students, life at university can be financially draining and car sharing is one great way to offset some of those costly transportation expenses.</p>

    <p>Using suggested meeting points and locations in Limerick city and beyond, driver and passenger meet up at a convenient location to share the ride. Car sharing not only gets you quickly and affordably from A to B, it’s also a great way to get to know interesting people and learn about new things.</p>

    <p>At ULCarpooling, we believe that everyone should have access to affordable transport. By sharing a ride, people can save both fuel and money, help reduce carbon emissions and meet new friends.</p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>


