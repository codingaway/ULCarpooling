<%@ Page Title="Search Results" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/uscCustomList.ascx" TagPrefix="uc1" TagName="uscCustomList" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                                <label class="control-label" for="txtEndDate">To</label>
                                <div class="">
                                    <div class='input-group date'>
                                        <asp:TextBox ID="txtEndDate" CssClass="form-control" runat="server" placeholder="dd/mm/yyy hh:mm"></asp:TextBox>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <asp:CustomValidator
                                        ID="valEndDate" runat="server"
                                        ControlToValidate="txtEndDate"
                                        ErrorMessage="End Date-time is not valid."
                                        ClientValidationFunction="isValidDateValue"
                                        ValidationGroup="searchPage" Display="Dynamic">X
                                    </asp:CustomValidator>
                                    <asp:CustomValidator
                                        ID="valCompareEndDate" runat="server"
                                        ControlToValidate="txtEndDate"
                                        ErrorMessage="End Date-time must be after start date."
                                        ClientValidationFunction="compareDateValues"
                                        ValidationGroup="searchPage" Display="Dynamic">X
                                    </asp:CustomValidator>
                                </div>
                            </div>
                             <div class="form-group">

                                <div class="col-md-8 pull-right">
                                    <asp:Button ID="btnReset" type="reset" runat="server" CssClass="btn btn-default" Text="Reset" OnClick="btnReset_Click" />
                                    <asp:Button ID="btnSearch" CausesValidation="true" CssClass="btn btn-primary" ValidationGroup="searchPage" runat="server" Text="Search" OnClick="btnSearch_Click" />

                                </div>
                            </div>
                            </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="rblSearchOption" EventName="SelectedIndexChanged" />
                             <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                           
                        

                </fieldset>
            </div>
            <asp:Panel ID="Panel1" runat="server" Visible="false">
                <div class="col-md-8">
                    <h4>
                        <asp:Label ID="Label1" runat="server" Text="Search Results"></asp:Label>
                    </h4>
                    <uc1:uscCustomList runat="server" ID="ResultList" />
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
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
   <%--   <script type="text/javascript">
          $.fn.stars = function () {
              return $(this).each(function () {
                  // Get the value
                  var val = parseFloat($(this).html());
                  //val = Math.round(val * 4) / 4; /* To round to nearest quarter */
                  // Make sure that the value is in 0 - 5 range, multiply to get width
                  var size = Math.max(0, (Math.min(5, val))) * 16;
                  // Create stars holder
                  var $span = $('<span />').width(size);
                  // Replace the numerical value with stars
                  $(this).html($span);
              });
          }

          $(function () {
              $('span.stars').stars();
          });
    </script>--%>
</asp:Content>

