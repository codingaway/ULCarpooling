<%@ Control Language="C#" ClassName="CustomList" AutoEventWireup="true" CodeFile="uscCustomList.ascx.cs" Inherits="uscCustomList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<div class="row">
    <div class="col-md-12">
        <h4>
            <asp:Label ID="lblHeading" runat="server"></asp:Label></h4>
        <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand" OnItemDataBound="ListView1_ItemDataBound">
            <LayoutTemplate>
                <div runat="server">
                    <div id="itemPlaceholder" runat="server" />
                    <asp:DataPager ID="pager1" PageSize="10" runat="server">
                        <Fields>
                            <asp:NumericPagerField />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                    TargetControlID="contentPanel"
                    ExpandControlID="titlePanel"
                    CollapseControlID="titlePanel"
                    Collapsed="true"
                    ImageControlID="imgShowHide"
                    TextLabelID="lblShowHideDetails"
                    CollapsedText=""
                    ExpandedText=""
                    ExpandedImage="~/Images/up.png"
                    CollapsedImage="~/Images/down.png" />

                <div class="panel panel-info list-item">
                    <div class="panel-heading">
                        <asp:Panel ID="titlePanel" runat="server" CssClass="collapsePanelHeader">


                            <asp:Label ID="lblShowHideDetails" runat="server" Text=""></asp:Label>
                            <span id="panel-title" class="panel-title">
                                <span class="glyphicon glyphicon-map-marker"></span><span class="place-title"><%#Eval("frm_place") %></span> &nbsp;To&nbsp;<span class="place-title"><%#Eval("to_place")%></span>

                                <br />
                                <span class="glyphicon glyphicon-calendar"></span>
                                <span class="date-time"><%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %></span>
                            </span>
                            <asp:Image ID="imgShowHide" runat="server" CssClass="arrow" ImageUrl="~/Images/down.png" />
                        </asp:Panel>
                    </div>
                    <asp:Panel ID="contentPanel" runat="server">
                        <div class="panel-body listing-item">

                            <asp:Panel ID="pnlAnonymous" runat="server">
                                <span>Please 
                                                <asp:HyperLink ID="lbtnLogin" NavigateUrl="~/login.aspx" runat="server">Sign in</asp:HyperLink>
                                    to respond to any listing. Not registered yet? 
                                                <asp:HyperLink ID="lbtnRegister" NavigateUrl="~/Register.aspx" runat="server">Sign up</asp:HyperLink>
                                    for free.
                                </span>
                            </asp:Panel>
                            <asp:Panel ID="pnlLoggedIn" runat="server" Visible="False">
                                <div class="col-md-1">
                                    <img alt="user picture" class="img-circle" height="40" width="40" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=")%><%#Eval("User_ID")%>' />
                                </div>
                                <div class="col-md-4">
                                    <asp:HyperLink ID="hlViewOverview" runat="server"><%#Eval("full_name") %></asp:HyperLink>
                                    <br />
                                    <asp:Label ID="lblStars" CssClass="stars" runat="server" Text=""></asp:Label>
                                    <span class="small text-muted">(<asp:Label ID="lblCount" runat="server" Text=""></asp:Label>)</span>
                                </div>
                                <div class="col-md-7">
                                    <asp:Label ID="lblSeats" runat="server" CssClass="small text-success pull-right" Text="Seats: " Enabled="false" Visible="false"></asp:Label><br />
                                    <asp:Button CssClass="btn btn-info pull-right" ID="btnCmd" CommandName="ItemCommand" runat="server" Text="Send request" />
                                    <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" Enabled="false" RepeatLayout="Flow">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblHeading" Text="People confirmed this trip:" runat="server" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <a href="/Overview.aspx?id=<%#Eval("user_id")%>"><%#Eval("uname") %></a>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>
                            </asp:Panel>
                        </div>
                    </asp:Panel>

                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>
