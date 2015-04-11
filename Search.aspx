<%@ Page Title="Search Results" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ConnectionStrings:DbConnString%>" />
    <div class="container top-buffer">
        <div class="row">
            <div class="well col-md-4">
                <h4 class="modal-title" id="myModalLabel">Search</h4>
                <div class="form-horizontal">
                    <fieldset>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="chkSearchType">Looking for</label>
                            <div class="col-md-8">
                                <asp:CheckBox ID="chkSearchType" runat="server"  AutoPostBack="true" OnCheckedChanged="CheckBox_CheckedChanged" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="ddlTripFrom">From</label>
                            <div class="col-md-8">
                                <asp:DropDownList ID="ddlTripFrom" CssClass="form-control" runat="server" AutoPostBack ="true" 
                                    EnableViewState="true"
                                    AppendDataBoundItems="true"
                                    OnSelectedIndexChanged="ddlTripFrom_SelectedIndexChanged">
                                    <asp:ListItem Value="0" Text="From">From</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="ddlTripTo">To</label>
                            <div class="col-md-8">
                                <asp:DropDownList ID="ddlTripTo" CssClass="form-control" AppendDataBoundItems="true"  runat="server">
                                    <asp:ListItem Value="0" Text="To">To</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="txtStartDate">Between</label>
                            <div class="col-md-8">
                                <div class='input-group date'>
                                    <asp:TextBox ID="txtStartDate" CssClass="form-control" runat="server" placeholder="dd/mm/yyy hh:mm"></asp:TextBox>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                                <asp:CustomValidator
                                    ID="valStartDate" runat="server"
                                    ControlToValidate="txtStartDate"
                                    ErrorMessage="Start Date-time is not valid."
                                    ClientValidationFunction="isValidDateValue"
                                    ValidationGroup="searchPage" Display="Dynamic">X
                                </asp:CustomValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="txtEndDate">To</label>
                            <div class="col-md-8">
                                <div class='input-group date'>
                                    <asp:TextBox ID="txtEndDate" CssClass="form-control" runat="server" placeholder="dd/mm/yyy hh:mm"></asp:TextBox>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                                <asp:CustomValidator
                                    ID="CustomValidator1" runat="server"
                                    ControlToValidate="txtEndDate"
                                    ErrorMessage="End Date-time is not valid."
                                    ClientValidationFunction="compareDateValues"
                                    ValidationGroup="searchPage" Display="Dynamic">X
                                </asp:CustomValidator>
                            </div>
                        </div>

                        <div class="form-group">

                            <div class="col-md-8 pull-right">
                                <input type="reset" name="reset" value="Reset" class="btn btn-default" />
                                <asp:Button ID="btnSearch" CssClass="btn btn-primary" ValidationGroup="searchPage" runat="server" Text="Search" OnClick="btnSearch_Click" />

                            </div>
                        </div>

                    </fieldset>
                </div>
            </div>
            <asp:Panel ID="Panel1" runat="server" Visible ="false">
                <div class="well col-md-8">
                    <div class="row">
                        <div class="col-md-12">
                            <h4>
                                <asp:Label ID="lblHeading" runat="server" Text="Label">Offer List</asp:Label></h4>
                            <asp:ListView ID="ListView1"
                                DataSourceID="SqlDataSource1" runat="server" OnItemCommand="ListView1_ItemCommand" EnableViewState="true" OnItemDataBound="ListView1_ItemDataBound">
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
                                                    <span class="glyphicon glyphicon-map-marker"></span><span class="place-title"><%#Eval("frm_place") %></span> &nbsp;To&nbsp;<span class="place-title"><%#Eval("to_place")%></span><br /><span class="glyphicon glyphicon-calendar"></span><span class="date-time"><%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %></span></span><asp:Image ID="imgShowHide" runat="server" CssClass="arrow" ImageUrl="~/Images/down.png" />
                                                

                                            </asp:Panel>
                                        </div>
                                        <asp:Panel ID="contentPanel" runat="server">
                                            <div class="panel-body">
                                               <asp:Panel ID="pnlAnonymous" runat="server">
                                <span>Please 
                                                <asp:LinkButton ID="lbtnLogin" PostBackUrl="~/login.aspx" runat="server" ViewStateMode="Enabled">Sign in</asp:LinkButton>
                                    to resond to this offer. Not registered yet? 
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
                                <asp:Button CssClass="btn btn-info pull-right" ID="btnCmd" CommandArgument='<%#Eval("id") %>' CommandName="ItemCommand" runat="server" Text="Send request" />

                            </asp:Panel>
                                            </div>
                                        </asp:Panel>

                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>
                    </div>
                
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
    <script type="text/javascript">
        $(function () {
            $('#<%=chkSearchType.ClientID%>').bootstrapToggle({
                on: 'Requests',
                off: 'Offers',
                onstyle: 'warning',
                offstyle: 'info'
            });
        });
    //pass on autopostback correctly
        $(function () {
            $('#<%=chkSearchType.ClientID%>').change(function () {
                $('form').submit();
            });
        });
    </script>
</asp:Content>

