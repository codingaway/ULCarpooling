<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="SiteStatistic.aspx.cs" Inherits="Default2" %>

<%@ Register Src="~/Controls/GraphCtrlBarOfferPick.ascx" TagPrefix="uc1" TagName="GraphCtrlBarOfferPick" %>
<%@ Register Src="~/Controls/GraphCtrlBarRequestDrop.ascx" TagPrefix="uc1" TagName="GraphCtrlBarRequestDrop" %>
<%@ Register Src="~/Controls/GraphCtrlDounutOfferDrop.ascx" TagPrefix="uc1" TagName="GraphCtrlDounutOfferDrop" %>
<%@ Register Src="~/Controls/GraphCtrlDounutRequestPick.ascx" TagPrefix="uc1" TagName="GraphCtrlDounutRequestPick" %>





<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container top-buffer">
        <h2 class="modal-header" style="text-align:center"><strong><em>Statical Analysis For Trips</em></strong></h2>
        <div class="row">
            <div class="col-md-6">
                <h4>Top Pick Up Points in Offering Trips</h4>
              <uc1:GraphCtrlBarOfferPick runat="server" ID="GraphCtrlBarOfferPick" />
            </div>
            <div class="col-md-6">
              <h4>Top Pick Up Points in Requesting Trips</h4>
               <uc1:GraphCtrlDounutRequestPick runat="server" id="GraphCtrlDounutRequestPick" />
            </div>
        </div>
           <br /><br />
        <div class="row">
            <div class="col-md-6">
                <h4>Top Drop Off Points in Offering Trips</h4>
              <uc1:GraphCtrlDounutOfferDrop runat="server" ID="GraphCtrlDounutOfferDrop" />
            </div>
            <div class="col-md-6">
                <h4>Top Drop off Points in Requesting Trips</h4>
              <uc1:GraphCtrlBarRequestDrop runat="server" ID="GraphCtrlBarRequestDrop" />
            </div>
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
    
</asp:Content>

