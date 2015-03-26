<%@ Control Language="C#" AutoEventWireup="true" CodeFile="uscOfferList.ascx.cs" Inherits="uscOfferList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%--<asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:DbConnString%>" 
        SelectCommand="Select user_id, place_from, place_to, date_time, seats from offer_rec" />--%>
<asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:DbConnString%>"
        SelectCommand="select * from vUserInfo" />
 <div class="row">
            <div class="col-md-12">
                <h4>Offer List</h4>
                <asp:ListView ID="ListView1"
                    DataSourceID="SqlDataSource1" runat="server" OnItemCommand="ListView1_ItemCommand">
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
                                        <asp:Image ID="imgShowHide" runat="server" ImageUrl="~/Images/down.png" />
                                      <br /><span class="glyphicon glyphicon-calendar"></span>
                                        <span class="date-time"><%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %></span>
                                        
                                    </span>

                                
                                </asp:Panel>
                            </div>
                            <asp:Panel ID="contentPanel" runat="server">
                                <div class="panel-body">
                                    <asp:LoginView ID="LoginView1" runat="server">
                                        <AnonymousTemplate>
                                            <span> Please 
                                                <asp:LinkButton ID="lbtnLogin" PostBackUrl="~/login.aspx" runat="server" ViewStateMode="Enabled">Sign in</asp:LinkButton> 
                                                to resond to this offer. Not registered yet? 
                                                <asp:LinkButton ID="lbtnRegister" PostBackUrl="~/Register.aspx" runat="server">Sign up</asp:LinkButton> for free.
                                            </span>
                                            
                                        </AnonymousTemplate>
                                        <LoggedInTemplate>
                                            <img alt="user picture" height="40" width="40" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=") %>
                                                <%#Eval("User_ID")%>' />
                                    User: <%#Eval("full_name") %> Number of seats: <%#Eval("seats") %>
                                    <asp:LinkButton ID="LinkButton1" runat="server">View Reviews</asp:LinkButton>
                                    <asp:Button CssClass="btn btn-info pull-right" ID="Button1" CommandArgument='<%#Eval("offer_id") %>' CommandName="ItemCommand" runat="server" Text="Send request" />

                                        </LoggedInTemplate>
                                     </asp:LoginView>
                                    
                                </div>
                            </asp:Panel>

                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>