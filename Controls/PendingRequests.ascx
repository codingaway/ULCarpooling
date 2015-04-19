<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PendingRequests.ascx.cs" Inherits="PendingRequests" %>

<asp:SqlDataSource ID="SqlDataSource3" runat="server"
    ConnectionString="<%$ ConnectionStrings:DbConnString%>">
    </asp:SqlDataSource>

<div class="row">
    <div class="col-md-12">
        
        <asp:ListView ID="ListView3" 
            runat="server" DataSourceID="SqlDataSource3" OnItemCommand="ListView3_ItemCommand" ViewStateMode="Inherit">
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
                    <asp:Button CssClass="btn btn-info pull-right" ID="Button1" CommandName="ItemCommand" runat="server" Text="Cancel" />
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>
