<%@ Page Title="Search Results" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

<%@ Register Src="~/Controls/uscOfferList.ascx" TagPrefix="uc1" TagName="uscOfferList" %>
<%@ Register Src="~/Controls/uscRequestList.ascx" TagPrefix="uc1" TagName="uscRequestList" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container top-buffer">
        <div class="row">
            <div class="well col-md-4">
                <h4 class="modal-title" id="myModalLabel">Search</h4>
                <div class="form-horizontal">
                    <fieldset>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="chkSearchType">Looking for</label>
                            <div class="col-md-8">
                                <asp:CheckBox ID="chkSearchType" data-toggle="toggle" runat="server" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="ddlTripFrom">From</label>
                            <div class="col-md-8">
                                <asp:DropDownList ID="ddlTripFrom" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="0" Selected="True">From</asp:ListItem>
                                    <asp:ListItem Value="1">UL</asp:ListItem>
                                    <asp:ListItem Value="2">City</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4" for="ddlTripTo">To</label>
                            <div class="col-md-8">
                                <asp:DropDownList ID="ddlTripTo" CssClass="form-control" runat="server">
                                    <asp:ListItem Selected="True">To</asp:ListItem>
                                    <asp:ListItem Value="1">Request</asp:ListItem>
                                    <asp:ListItem Value="2">Offer</asp:ListItem>
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
            <div class="well col-md-8">
                <h4>Search results</h4>
                <asp:PlaceHolder ID="PlaceHolder1" runat="server">
                </asp:PlaceHolder>
            </div>
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
    </script>
</asp:Content>

