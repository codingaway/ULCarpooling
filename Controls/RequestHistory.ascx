<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RequestHistory.ascx.cs" Inherits="Controls_RequestHistory" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<div class="row">
    <div class="col-md-12">
        <h4>
            <asp:Label ID="lblHeading" runat="server" Text="Requests Completed"></asp:Label></h4>
        <asp:ListView ID="completedRequestsLV" runat="server" OnItemCommand="completedRequestsLV_ItemCommand" OnItemDataBound="completedRequestsLV_ItemDataBound">
            <LayoutTemplate>
                <div runat="server">
                    <div id="itemPlaceholder" runat="server" />
                    <%--<asp:DataPager ID="pager1" PageSize="2" runat="server">
                        <Fields>
                            <asp:NumericPagerField />
                        </Fields>
                    </asp:DataPager>--%>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="panel panel-info list-item">
                    <div class="panel-heading">
                        <asp:Panel ID="titlePanel2" runat="server">
                            <asp:Label ID="lblShowHideDetails" runat="server" Text=""></asp:Label>
                            <span id="panel-title" class="panel-title">
                                <span class="glyphicon glyphicon-map-marker"></span><span class="place-title"><%#Eval("frm_place") %></span> &nbsp;to&nbsp;<span class="place-title"><%#Eval("to_place")%></span><br /><span class="glyphicon glyphicon-calendar"></span><span class="date-time"><%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %></span></span>
                            <asp:Button CssClass="btn btn-info pull-right btn-sm" ID="btnReview2" CommandName="Review" runat="server" Text="Review" />
                            <asp:Button CssClass="btn btn-info pull-right btn-sm" ID="btnReport2" CommandName="Report" runat="server" Text="Report" />
                        </asp:Panel>
                    </div>
                    <asp:Panel ID="contentPanel2" runat="server" Visible="false">
                        <div class="panel-body listing-item">
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label ID="lblListBox2" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <asp:ListBox ID="tripUsersLB2" runat="server" SelectionMode="Single" Width="174"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label ID="lblTextBox2" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtComment2" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label ID="lblRating2" runat="server" />
                                    <asp:Label ID="lblBlock2" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ratingDDL2" runat="server">
                                        <asp:ListItem>1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                        <asp:ListItem>4</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CheckBox ID="blockCB2" runat="server" Checked="false" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label ID="lblError2" runat="server" Text="" Visible="false" ForeColor="Red" />
                                </div>
                                <div class="col-md-8">
                                    <asp:Button ID="btnClose" runat="server" CommandName="Close" CssClass="btn btn-default pull-right btn-sm" Text="Close"/>
                                    <asp:Button ID="btnSubmit2" runat="server" CommandName="Submit" CssClass="btn btn-info pull-right btn-sm" Text="Submit"/>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>