<%@ Page Title="UL Carpooling - Search for trip" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

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
    <script type="text/javascript">
        /* Date validator -- @Authour: Abdul Halim */

        //This funtion called from custome validation control that passes two arguments, sender and args
        //It validates a control by comparing date values from calling control with value from other control that has an ID 'txtStartDate'
        function compareDateValues(sender, args)
        {
            console.log("Running comparison method");
            var date1, date2, now;
            now = new Date();
            date1 = stringToDate(document.getElementById('ContentPlaceHolder1_txtStartDate').value);
            date2 = stringToDate(args.Value);
            if (date1 == null)
            {
                console.log("Date is null");
                date1 = now;
            }
            else
            {
                console.log("Date is not null");
            }
            if (date2 < date1)
                 args.IsValid = false;
             else
                 args.IsValid = true;
        }

        function isValidDate(dateString) {

            console.log("Running isVAlidDate method");
            var dateVal = dateString;
            if (dateVal == "") //Check if empty string
                return false;

            //define a regex matching date pattern "dd/MM/yyyy HH:mm"
            var datePatern = /^((0?[1-9])|([1-2]\d)|(3[0-1]))\/((0?[1-9])|(1[0-2]))\/(\d{2}|\d{4})[\s]{1}(((0|1){1}\d)|2[0-3])\:([0-5]{1}\d)$/;

            if (!datePatern.test(dateVal))
                return false;

            //split the string for each section
            var delimiter = /\/|\:|\s/;
            var dtArray = dateVal.split(delimiter);

            //Checks for dd/mm/yyyy format.
            var day = dtArray[0];
            var month = dtArray[1];
            var year = dtArray[2];
            //hour and minutes should be valid after regex match

            if (month < 1 || month > 12)
                return false;
            else if (day < 1 || day > 31)
                return false;
            else if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31)
                return false;
            else if (month == 2) {
                var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
                if (day > 29 || (day == 29 && !isleap))
                    return false;
            }
            return true;
        }


        //A function that returns date object from a validated date string as 'dd/MM/yyyy HH:mm' format
        function stringToDate(dateString) {
            var date = null;
            if (dateString != null) {
                var delimiter = /\/|\:|\s/;
                var dtArray = dateString.split(delimiter);
                var date = new Date();
                //Date string is  "dd/mm/yyyy HH:mm" format.
                var day = dtArray[0];
                var month = dtArray[1];
                var year = dtArray[2];
                var hours = dtArray[3];
                var minutes = dtArray[4];
                date.setFullYear(year, month - 1, day);
                date.setHours(hours);
                date.setMinutes(minutes);
            }
            return date;
        }


        //Method for checking a single date input from customvalidation parameters
        function isValidDateValue(sender, args) {
            var inputDate;
            var dateString = args.Value;
            if (isValidDate(dateString)) {
                inputDate = stringToDate(dateString);
                now = new Date();
                if (inputDate < now)
                    args.IsValid = false;
                else
                    args.IsValid = true;
            }
            else
                args.IsValid = false;
        }
    </script>
</asp:Content>

