<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OfferNotificationResponse.ascx.cs" Inherits="OfferNotificationResponse" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<div class="row">
    <div class="col-md-12">
        <asp:ListView ID="OfferNotificationResponseLV" runat="server" OnItemCommand="OfferNotificationResponseLV_ItemCommand" OnItemDataBound="OfferNotificationResponseLV_ItemDataBound">
            <LayoutTemplate>
                <div runat="server">
                    <div id="itemPlaceholder" runat="server" />
                    <%--<asp:DataPager ID="pager1" PageSize="1" runat="server">
                        <Fields>
                            <asp:NumericPagerField />
                        </Fields>
                    </asp:DataPager>--%>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="panel panel-info list-item">
                    <div class="panel-heading">
                        <asp:Panel ID="titlePanel" runat="server">
                            <asp:Label ID="lblShowHideDetails" runat="server" Text=""></asp:Label>
                            <span id="panel-title" class="panel-title">
                                <span class="glyphicon glyphicon-map-marker"></span><asp:Label ID="lblResponse" runat="server" /></span>&nbsp;<span class="place-title"><asp:HyperLink ID="hlViewOverview" runat="server"></asp:HyperLink></span>
                        </asp:Panel>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>