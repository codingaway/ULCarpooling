﻿<%@ Page Title="Welcome to UL Carpooling" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/uscCustomList.ascx" TagPrefix="uc1" TagName="uscCustomList" %>
<%@ Register Src="~/Controls/GraphCtrlBarOfferPick.ascx" TagPrefix="uc1" TagName="GraphCtrlBarOfferPick" %>
<%@ Register Src="~/Controls/GraphCtrlBarRequestDrop.ascx" TagPrefix="uc1" TagName="GraphCtrlBarRequestDrop" %>





<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="Content/tabStyles.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <img src="Images/bridge2.png" />
                <div class="carousel-caption page-header">
                    <h1>UL Carpooling <small>Commute smarter</small></h1>
                </div>
            </div>
            <!-- End Item -->
            <div class="item">
                <img src="Images/castle.png" />
                <%--<div class="carousel-caption">
                    <h3>Headline</h3>
                    <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                </div>--%>
            </div>
            <!-- End Item -->
            <div class="item">
                <img src="Images/irishworld.png" />
               <%-- <div class="carousel-caption">
                    <h3>Headline</h3>
                    <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                </div>--%>
            </div>
            <!-- End Item -->
            <div class="item">
                <img src="Images/schrodinger.png" />
              <%--  <div class="carousel-caption">
                    <h3>Headline</h3>
                    <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                </div>--%>
            </div>
            <!-- End Item -->
        </div>
        <!-- End Carousel Inner -->
<%--        <ul class="nav nav-pills nav-justified">
            <li data-target="#myCarousel" data-slide-to="0" class="active"><a href="#">About<small>Lorem ipsum dolor sit</small></a></li>
            <li data-target="#myCarousel" data-slide-to="1"><a href="#">Projects<small>Lorem ipsum dolor sit</small></a></li>
            <li data-target="#myCarousel" data-slide-to="2"><a href="#">Portfolio<small>Lorem ipsum dolor sit</small></a></li>
            <li data-target="#myCarousel" data-slide-to="3"><a href="#">Services<small>Lorem ipsum dolor sit</small></a></li>
        </ul>--%>


    </div>
    <!-- End Carousel -->
    <div class="container top-buffer">
        <div class="row">
            <div class="col-md-8">
                <div class="">
                    <div class="row">
                        <cc1:TabContainer ID="TabContainer1" runat="server" CssClass="mainTab">
                            <cc1:TabPanel runat="server" ID="tabOfferList">
                                <HeaderTemplate>
                                    Offers
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>

                                    <uc1:uscCustomList runat="server" ID="OfferList" />
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel runat="server" ID="tablRequest">
                                <HeaderTemplate>
                                    Request
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
                                    <uc1:uscCustomList runat="server" ID="RequestList" />
                                </ContentTemplate>
                            </cc1:TabPanel>
                        </cc1:TabContainer>


                    </div>

                </div>
            </div>
            <div class="col-md-4">
                
                <div class="well sidebar">

                    <h2>Welcome to UL Carpooling</h2>
                    <p>ULCarpooling is a website which offers reliable car sharing opportunities for the University of Limerick community that is fast, efficient and easy to access. You can use our service via the web currently, with a mobile version of the service to be launched soon. With just a few clicks, drivers can offer available seats and passengers can book a ride.</p>
                    <asp:HyperLink ID="linkStatistic" runat="server" NavigateUrl="~/SiteStatistic.aspx">View our site statistics</asp:HyperLink>
               </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
    <script src="Scripts/carouselControl.js"></script>
</asp:Content>
