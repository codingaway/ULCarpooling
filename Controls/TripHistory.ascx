<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TripHistory.ascx.cs" Inherits="TripHistory" %>

<asp:SqlDataSource ID="SqlDataSource4" runat="server"
    ConnectionString="<%$ ConnectionStrings:DbConnString%>">
    </asp:SqlDataSource>

<div class="row">
    <div class="col-md-12">
        <asp:ListView ID="ListView4" 
            runat="server" DataSourceID="SqlDataSource4" OnItemCommand="ListView4_ItemCommand">
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
                    <span id="panel-title" class="panel-title">

                        <%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %> 
                                            <%#Eval("place_from") %> to <%#Eval("place_to")%>
                        <asp:Button CssClass="btn btn-info pull-right" ID="Button2" CommandArgument='<%#Eval("trip_id") %>' CommandName="ItemCommand" runat="server" Text="Report" />
                        <asp:Button CssClass="btn btn-info pull-right" ID="Button1" CommandArgument='<%#Eval("trip_id") %>' CommandName="ItemCommand" runat="server" Text="Review" />
                        
                        <%-- <a class="anchorjs-link" href="#panel-title"><span class="anchorjs-icon"></span></a>--%>

                    </span>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>