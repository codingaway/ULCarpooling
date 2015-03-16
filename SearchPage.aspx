<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="SearchPage.aspx.cs" Inherits="Default5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-toggle.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="well bs-component searchbar">
        <div class="form-horizontal">
            <fieldset>
                <legend>Search</legend>
                <div class="row">
                    <div class="form-group">
                        <label class="control-label col-md-2" for="chkSearchType">Looking for</label>
                        <div class="col-md-10">
                            <asp:CheckBox ID="chkSearchType" data-toggle="toggle" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <label class="control-label col-md-2" for="DropDownList4">From</label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="DropDownList4" CssClass="form-control" runat="server">
                                <asp:ListItem Value="1">UL</asp:ListItem>
                                <asp:ListItem Value="2">City</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-2" for="DropDownList2">To</label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="DropDownList2" CssClass="form-control" runat="server">
                                <asp:ListItem Selected="True">Searching for</asp:ListItem>
                                <asp:ListItem Value="1">Request</asp:ListItem>
                                <asp:ListItem Value="2">Offer</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <label class="control-label col-md-2" for="TextBox2">Between</label>
                        <div class="col-md-10">
                            <div class='input-group date' id='datetimepicker1'>
                                <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" placeholder="Finish Date-Time" TextMode="DateTimeLocal"></asp:TextBox>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-2" for="TextBox3">To</label>
                        <div class="col-md-10">
                            <div class='input-group date' id='datetimepicker2'>
                                <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="form-group">
                        <div class="col-md-3 col-md-offset-2">
                            <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="Search" />
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnReset" CssClass="btn btn-default" runat="server" Text="Reset" />
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
    <script src="Scripts/moment.min.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/bootstrap-toggle.min.js"></script>

    <%--Scrpits for date time picker--%>
    <script type="text/javascript">
        $(function () {
            $('#datetimepicker1').datetimepicker();
        });
        $(function () {
            $('#datetimepicker2').datetimepicker();
        });

    </script>

    <%--  Scripts for searchtype toggle button--%>
    <script>
        $(function () {
            $('#<%=chkSearchType.ClientID%>').bootstrapToggle(
                {
                    on: 'Requests',
                    off: 'Offers'
                });
        });
    </script>

</asp:Content>

