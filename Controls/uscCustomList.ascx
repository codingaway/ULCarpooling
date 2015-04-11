<%@ Control Language="C#" ClassName="CustomList" AutoEventWireup="true" CodeFile="uscCustomList.ascx.cs" Inherits="uscCustomList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

 <div class="row">
            <div class="col-md-12">
                <h4>
                    <asp:Label ID="lblHeading" runat="server"></asp:Label></h4>
                <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand"  OnItemDataBound="ListView1_ItemDataBound" >
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
                                    <span class="glyphicon glyphicon-map-marker"></span> <span class="place-title"><%#Eval("frm_place") %></span> &nbsp;To&nbsp;<span class="place-title"><%#Eval("to_place")%></span>
                                        
                                      <br /><span class="glyphicon glyphicon-calendar"></span>
                                        <span class="date-time"><%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %></span>
                                    </span>
                                    <asp:Image ID="imgShowHide" runat="server" CssClass="arrow" ImageUrl="~/Images/down.png" />
                                </asp:Panel>
                            </div>
                            <asp:Panel ID="contentPanel" runat="server">
                                <div class="panel-body">
                                    
                            <asp:Panel ID="pnlAnonymous" runat="server">
                                <span>Please 
                                                <asp:LinkButton ID="lbtnLogin" PostBackUrl="~/login.aspx" runat="server" ViewStateMode="Enabled">Sign in</asp:LinkButton>
                                    to respond to any listing. Not registered yet? 
                                                <asp:LinkButton ID="lbtnRegister" PostBackUrl="~/Register.aspx" runat="server">Sign up</asp:LinkButton>
                                    for free.
                                </span>
                            </asp:Panel>
                            <asp:Panel ID="pnlLoggedIn" runat="server" Visible="False">
                                <img alt="user picture" height="40" width="40" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=") %>
                                                <%#Eval("User_ID")%>' />
                                <%#Eval("full_name") %>
                                <asp:Label ID="lblSeats" runat="server" Text="Number of seats:" Enabled="false" Visible="false"></asp:Label>
                                <asp:LinkButton ID="LinkButton1" runat="server">View Reviews</asp:LinkButton>
                                <asp:Button CssClass="btn btn-info pull-right" ID="btnCmd" CommandName="ItemCommand" runat="server" Text="Send request" />
                            </asp:Panel>
                                </div>
                            </asp:Panel>

                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>