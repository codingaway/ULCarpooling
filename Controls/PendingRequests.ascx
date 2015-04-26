<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PendingRequests.ascx.cs" Inherits="PendingRequests" %>


<div class="row">
    <div class="col-md-12">
        
        <asp:ListView ID="pendingRequestsLV" runat="server" OnItemCommand="pendingRequestsLV_ItemCommand" OnItemDataBound="pendingRequestsLV_ItemDataBound">
            <LayoutTemplate>
                <div runat="server">
                    <div id="itemPlaceholder" runat="server" />
                    <asp:DataPager ID="pager1" PageSize="3" runat="server">
                        <Fields>
                            <asp:NumericPagerField />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="well">
                   <%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %> <%#Eval("frm_place") %> to <%#Eval("to_place")%> <br />
                    <asp:Button CssClass="btn btn-xs btn-info" ID="btnCancelRequest" CommandName="ItemCommand" runat="server" Text="Cancel" />
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>
