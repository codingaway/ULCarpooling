<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Search2.aspx.cs" Inherits="Search2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <style>
        .droplist {
            position: absolute;
            z-index: 1000;
        }
       .hidden {
            visibility: hidden;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container top-buffer">
        <div class="row">

            <div class="well col-md-4">
                <h4 class="modal-title" id="myModalLabel">Search</h4>
                <div class="form-horizontal">
                    <fieldset>
                        <div class="form-group">
                            <div class="col-md-8">
                                <asp:CheckBox ID="chkSearchType" data-toggle="toggle" runat="server" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="ddlTripFrom">From</label>
                            <div class="col-md-8">
                                <asp:TextBox ID="TextBox1" runat="server" onkeyup="refreshFromList();"
                                    placeholder="Select a place"
                                    autocomplete="off"></asp:TextBox>
                                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:ListBox ID="ListBox1" runat="server" CssClass="droplist" DataSourceID="SqlDataSource2" onchange="updateFromText();"
                                            DataTextField="pname" DataValueField="place_id"></asp:ListBox>
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnString %>" SelectCommand="select * from vGetPlaceName"></asp:SqlDataSource>


                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnHidden" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <asp:Button ID="btnHidden" CssClass="sr-only" Text="Hidden Button" runat="server" OnClick="btnHidden_Click" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="ddlTripTo">To</label>
                            <div class="col-md-8">
                               <asp:TextBox ID="TextBox2" runat="server"
                                    placeholder="Destination"
                                   onkeyup="refreshToList();"
                                    autocomplete="off"></asp:TextBox>
                                <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:ListBox ID="ListBox2" runat="server" CssClass="droplist" DataSourceID="SqlDataSource3" onchange="updateToText();"
                                            DataTextField="pname" DataValueField="to_id"></asp:ListBox>
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnString %>" ></asp:SqlDataSource>


                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnHidden2" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <asp:Button ID="btnHidden2" CssClass="sr-only" Text="Hidden Button" runat="server" OnClick="btnHidden2_Click" />
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

            <div class="col-md-8">
                <div class="well">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ConnectionStrings:DbConnString%>"
                        SelectCommand="select * from vOfferDetails" />
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Offer List</h4>
                            <asp:ListView ID="ListView1"
                                DataSourceID="SqlDataSource1" runat="server" OnItemCommand="ListView1_ItemCommand" EnableViewState="False" OnItemDataBound="ListView1_ItemDataBound">
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
                                                    <span class="glyphicon glyphicon-map-marker"></span><span class="place-title"><%#Eval("frm_place") %></span> &nbsp;To&nbsp;<span class="place-title"><%#Eval("to_place")%></span><br />
                                                    <span class="glyphicon glyphicon-calendar"></span><span class="date-time"><%#((System.DateTime)Eval("date_time")).ToString("dd-MMM-yyyy HH:mm") %></span></span><asp:Image ID="imgShowHide" runat="server" CssClass="arrow" ImageUrl="~/Images/down.png" />


                                            </asp:Panel>
                                        </div>
                                        <asp:Panel ID="contentPanel" runat="server">
                                            <div class="panel-body">

                                                <%--  <asp:Panel ID="pnlAnonymous" runat="server">
                                                    <span>Please sign in</span>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlLoggedIn" runat="server" Visible="False">
                                                     <asp:Label ID="Label1" runat="server" Text='<%# Eval("full_name") %>'></asp:Label>
                                                </asp:Panel>--%>

                                                <asp:LoginView ID="LoginView1" runat="server">
                                                    <AnonymousTemplate>
                                                        <span>Please 
                                                <asp:LinkButton ID="lbtnLogin" PostBackUrl="~/login.aspx" runat="server" ViewStateMode="Enabled">Sign in</asp:LinkButton>
                                                            to resond to this offer. Not registered yet? 
                                                <asp:LinkButton ID="lbtnRegister" PostBackUrl="~/Register.aspx" runat="server">Sign up</asp:LinkButton>
                                                            for free.
                                                        </span>

                                                    </AnonymousTemplate>
                                                    <LoggedInTemplate>

                                                        <img alt="user picture" height="40" width="40" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=") %>
                                                <%#  Eval("User_ID")%>' />
                                                        <%# Eval("full_name") %> Number of seats: <%#Eval("seats") %>
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

                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
    <script type="text/javascript">
        
        $(document).ready(function () {
            $("#<%=ListBox1.ClientID%>").hide();
            $("#<%=ListBox2.ClientID%>").hide();

            $("#<%=TextBox1.ClientID%>").focusin(function () {
                $("#<%=ListBox2.ClientID%>").fadeOut();
                $("#<%=ListBox1.ClientID%>").fadeIn();
            });

            $("#<%=TextBox1.ClientID%>").focusout(function () {
                $("#<%=ListBox1.ClientID%>").fadeOut();
            });

            $("#<%=TextBox2.ClientID%>").focusin(function () {
                $("#<%=ListBox2.ClientID%>").toggleClass("hidden", false);
                $("#<%=ListBox2.ClientID%>").fadeIn();
            });

            $("#<%=TextBox2.ClientID%>").focusout(function () {
                $("#<%=ListBox2.ClientID%>").fadeOut();
            });
        });

        function updateToText() {
            $("#<%=TextBox2.ClientID%>").val($("#<%=ListBox2.ClientID%> option:selected").text());
            $("#<%=ListBox2.ClientID%>").fadeOut();
            
        }

        function updateFromText() {
            $("#<%=TextBox2.ClientID%>").val("");
            $("#<%=btnHidden2.ClientID%>").trigger('click');
            $("#<%=TextBox1.ClientID%>").val($("#<%=ListBox1.ClientID%> option:selected").text());
            $("#<%=ListBox1.ClientID%>").fadeOut();
            $("#<%=ListBox2.ClientID%>").toggleClass("hidden", true);

        }

        function refreshFromList()
        {
            var pretext = $("#<%=TextBox1.ClientID%>").val();

            if (pretext.length > 2 || pretext.length == 0)
                $("#<%=btnHidden.ClientID%>").trigger('click');
        }
        function refreshToList(textID, buttonID) {
            
            var pretext = $("#<%=TextBox2.ClientID%>").val();
            if (pretext.length > 2 || pretext.length == 0) {
                $("#<%=btnHidden2.ClientID%>").trigger('click');
            }
        }
    </script>
</asp:Content>
