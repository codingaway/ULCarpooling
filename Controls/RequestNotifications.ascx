<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RequestNotifications.ascx.cs" Inherits="RequestNotifications" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<div class="row">
    <div class="col-md-12">
        <asp:ListView ID="requestNotifcationsLV" runat="server" OnItemCommand="requestNotifcationsLV_ItemCommand" OnItemDataBound="requestNotifcationsLV_ItemDataBound">
            <LayoutTemplate>
                <div runat="server">
                    <div id="itemPlaceholder" runat="server" />
                    <asp:DataPager ID="pager1" PageSize="1" runat="server">
                        <Fields>
                            <asp:NumericPagerField />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="panel panel-info list-item">
                    <div class="panel-heading">
                        <asp:Panel ID="titlePanel" runat="server">
                            <asp:Label ID="lblShowHideDetails" runat="server" Text=""></asp:Label>
                            <span id="panel-title" class="panel-title">
                                <span class="glyphicon glyphicon-map-marker"></span><span class="place-title"><%#Eval("driver_name") %></span>&nbsp;is offering you a lift from&nbsp;<span class="place-title"><%#Eval("frm_place") %></span> &nbsp;to&nbsp;<span class="place-title"><%#Eval("to_place")%></span><br /><span class="glyphicon glyphicon-calendar"></span><span class="date-time"><%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %></span></span>          
                            <asp:Button CssClass="btn btn-info pull-right btn-sm" ID="btnDecline" CommandName="Decline" runat="server" Text="Declined" />
                            <asp:Button CssClass="btn btn-info pull-right btn-sm" ID="btnConfirm" CommandName="Confirm" runat="server" Text="Confirm" />
                        </asp:Panel>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>