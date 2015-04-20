<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TripHistory.ascx.cs" Inherits="TripHistory" %>

<asp:SqlDataSource ID="SqlDataSource4" runat="server"
    ConnectionString="<%$ ConnectionStrings:DbConnString%>">
    </asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource5" runat="server"
    ConnectionString="<%$ ConnectionStrings:DbConnString%>">
    </asp:SqlDataSource>


<div class="row">
    <div class="col-md-12">
        <asp:ListView ID="ListView4" 
            runat="server" DataSourceID="SqlDataSource4" OnItemCommand="ListView4_ItemCommand">
            <LayoutTemplate>
                <div runat="server">
                    <h3>Offers Completed</h3>
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
                    <div class="row">
                        <%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %> <%#Eval("frm_place") %> to <%#Eval("to_place")%>
                    </div>
                    <div class="row">
                        <asp:Button CssClass="btn btn-info pull-right" ID="btnReportOffer" CommandArgument='<%#Eval("offer_id") %>' CommandName="ItemCommand" runat="server" Text="Report" />
                        <asp:Button CssClass="btn btn-info pull-right" ID="btnReviewOffer" CommandArgument='<%#Eval("offer_id") %>' CommandName="ItemCommand" runat="server" Text="Review" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <asp:ListView ID="ListView5" 
            runat="server" DataSourceID="SqlDataSource5" OnItemCommand="ListView5_ItemCommand">
            <LayoutTemplate>
                <div runat="server">
                    <h3>Requests Completed</h3>
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
                    <div class="row">
                        <%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %> <%#Eval("frm_place") %> to <%#Eval("to_place")%>
                    </div>
                    <div class="row">
                        <asp:Button CssClass="btn btn-info pull-right" ID="btnReportRequest" CommandArgument='<%#Eval("Request_id") %>' CommandName="ItemCommand" runat="server" Text="Report" />
                        <asp:Button CssClass="btn btn-info pull-right" ID="btnReviewRequest" CommandArgument='<%#Eval("Request_id") %>' CommandName="ItemCommand" runat="server" Text="Review" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>