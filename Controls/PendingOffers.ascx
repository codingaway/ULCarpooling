<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PendingOffers.ascx.cs" Inherits="PendingOffers" %>

<asp:SqlDataSource ID="SqlDataSource2" runat="server"
    ConnectionString="<%$ ConnectionStrings:DbConnString%>">
    </asp:SqlDataSource>

<div class="row">
    <div class="col-md-12">
        <asp:ListView ID="ListView2" 
            runat="server" DataSourceID="SqlDataSource2" OnItemCommand="ListView2_ItemCommand" OnItemDataBound="ListView2_ItemDataBound" ViewStateMode="Inherit">
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
                      <%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %> <%#Eval("frm_place") %> to <%#Eval("to_place")%>
                      <asp:Button CssClass="btn btn-info pull-right" ID="btnCancelOffer" CommandName="CancelOffer" runat="server" Text="Cancel" />
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>
