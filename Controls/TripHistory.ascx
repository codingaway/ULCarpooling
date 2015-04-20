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
                        <asp:Button CssClass="btn btn-info pull-right" ID="btnReportOffer" CommandArgument='<%#Eval("offer_id") %>' CommandName="ItemCommand" runat="server" Text="Report" data-toggle="modal" data-target="#ReportOfferModal"/>
                            <div class="modal fade" id="ReportOfferModal" tabindex="-1" role="dialog" aria-labelledby="ReportOfferModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="ReportOfferModalLabel">Report Offer</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <p>Select user to report</p>
                                                    <p>Reason for reporting</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <asp:ListBox ID="offerUsersLB" runat="server" SelectionMode="Single" Width="174"/>
                                                    <asp:TextBox ID="txtReportReason" runat="server" Text="" />
                                                </div>
                                                <div class="col-md-4"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <asp:Button ID="btnReportOff" CssClass="btn btn-primary" runat="server" OnClick="btnReport_Click" Text="Report"></asp:Button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <asp:Button CssClass="btn btn-info pull-right" ID="btnReviewOffer" CommandArgument='<%#Eval("offer_id") %>' CommandName="ItemCommand" runat="server" Text="Review" data-toggle="modal" data-target="#ReviewOfferModal"/>
                            <div class="modal fade" id="ReviewOfferModal" tabindex="-1" role="dialog" aria-labelledby="ReviewOfferModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="ReviewOfferModalLabel">Review Offer</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <p>Select user to review</p>
                                                    <p>Review comment</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <asp:ListBox ID="reviewUsersLB" runat="server" SelectionMode="Single" Width="174"/>
                                                    <asp:TextBox ID="txtReviewComment" runat="server" Text="" />
                                                </div>
                                                <div class="col-md-4"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <asp:Button ID="btnReviewOff" CssClass="btn btn-primary" runat="server" OnClick="btnReview_Click" Text="Review"></asp:Button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
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