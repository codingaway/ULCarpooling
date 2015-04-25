<%@ Page Title="UL Carpooling - Search for trip" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/uscCustomList.ascx" TagPrefix="uc1" TagName="uscCustomList" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="Content/chosen.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ConnectionStrings:DbConnString%>" />
    <div class="container top-buffer">
        <div class="row">
            <div class="well col-md-4">
                <h4 class="modal-title" id="myModalLabel">Search for</h4>
                <fieldset>

                    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <div class="search-type">
                                    <asp:RadioButtonList ID="rblSearchOption"
                                        CssClass="radio"
                                        runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="rblSearchOption_SelectedIndexChanged"
                                        RepeatLayout="Flow" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Offers" Text="Offers" />
                                        <asp:ListItem Value="Request" Text="Request" />
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="ddlTripFrom">From</label>
                                <div class="">
                                    <asp:DropDownList ID="ddlTripFrom" CssClass="form-control chosen-select"
                                        dataplaceholder="Select starting place"
                                        runat="server" DataSourceID="SqlDataSource2"
                                        AutoPostBack="true"
                                        DataTextField="pname" DataValueField="place_id" OnSelectedIndexChanged="ddlTripFrom_SelectedIndexChanged">
                                       
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnString %>" SelectCommand="select * from vOfferFromPlace"></asp:SqlDataSource>
                                    <asp:Button ID="btnFrmHidden" CssClass="sr-only" Text="" runat="server" OnClick="btnFrmHidden_Click" />
                                </div>

                            </div>

                            <div class="form-group">
                                <label class="control-label" for="ddlTripTo">To</label>
                                <div class="">

                                    <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlTripTo"
                                                CssClass="form-control chosen-place-to" runat="server"
                                                dataplaceholder="Select destination"
                                                AutoPostBack="true"
                                                DataSourceID="SqlDataSource3"
                                                DataTextField="pname" DataValueField="place_id">
                                               
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnString %>"></asp:SqlDataSource>
                                         
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlTripFrom" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="txtStartDate">Time range</label>
                                <div class="">
                                    <div class='input-group date'>
                                        <asp:TextBox ID="txtStartDate" CssClass="form-control" runat="server" 
                                            ValidationGroup="searchPage" placeholder="dd/mm/yyy hh:mm"></asp:TextBox>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <asp:CustomValidator
                                        ID="valStartDate" runat="server"
                                        ControlToValidate="txtStartDate"
                                        ErrorMessage="Start Date-time is not valid."
                                        ClientValidationFunction="isValidDateValue"
                                        ValidationGroup="searchPage" Display="Dynamic">
                                    </asp:CustomValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="txtEndDate">To</label>
                                <div class="">
                                    <div class='input-group date'>
                                        <asp:TextBox ID="txtEndDate" CssClass="form-control" runat="server" 
                                            ValidationGroup="searchPage" placeholder="dd/mm/yyy hh:mm"></asp:TextBox>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    
                                    <asp:CustomValidator
                                        ID="CustomValidator1" runat="server"
                                        ControlToValidate="txtEndDate"
                                        ErrorMessage="End Date-time is not valid."
                                        ClientValidationFunction="compareDateValues"
                                        ValidationGroup="searchPage" Display="Dynamic">
                                    </asp:CustomValidator>
                                  
                                </div>
                            </div>

                            </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="rblSearchOption" EventName="SelectedIndexChanged" />
                             <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div class="form-group">
                                <div class="col-md-8 pull-right">
                                    <asp:Button ID="btnReset" CausesValidation="false" type="reset" runat="server" CssClass="btn btn-default" Text="Reset" OnClick="btnReset_Click" />
                                    <asp:Button ID="btnSearch" CausesValidation="true" ValidationGroup="searchPage" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnSearch_Click" />

                                </div>
                            </div>
                </fieldset>
            </div>
            <asp:Panel ID="Panel1" runat="server">
                <div class="col-md-8">
                    <h4>
                        <asp:Label ID="lblHeading" runat="server"></asp:Label>
                    </h4>
                   <%-- <uc1:uscCustomList runat="server" ID="ResultList" />--%>


                     <asp:ListView ID="ListView1" DataSourceID="SqlDataSource1" runat="server" OnItemCommand="ListView1_ItemCommand" OnItemDataBound="ListView1_ItemDataBound">
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
            </asp:Panel>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
    <script src="Scripts/moment.min.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/chosen.jquery.min.js"></script>
    <script type="text/javascript">
        function BindControlEvents() {
            var config = {
                '.chosen-select': {
                    placeholder_text_single: "Select starting place",
                    allow_single_deselect: true
                },
                '.chosen-place-to': {
                placeholder_text_single: "Select destination place",
                allow_single_deselect: true
            }
            }
            for (var selector in config) {
                $(selector).chosen(config[selector]);
            }
            //Datetime picker
            $(function () {
                $('.date').datetimepicker(
                    {
                        format: "DD/MM/YYYY HH:mm",
                        stepping: 5,
                        showClear: true,
                        showClose: true,
                        inline: true
                    });
            });
        }
        //Initial bind
        $(document).ready(function () {
            BindControlEvents();
        });

        //Re-bind for callbacks
        var prm = Sys.WebForms.PageRequestManager.getInstance();

        prm.add_endRequest(function () {
            BindControlEvents();
        });
    </script>
</asp:Content>

