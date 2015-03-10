<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Search.ascx.cs" Inherits="Search" %>
<div class="well bs-component">
    <div class="form-horizontal">
        <fieldset>
            <legend>Search</legend>
            <div class="form-group">
                <label class="control-label col-md-4" for="DropDownList1">Looking for</label>
                <div class=" col-md-8">
                    <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                        <asp:ListItem Value="1">Request</asp:ListItem>
                        <asp:ListItem Value="2">Offer</asp:ListItem>
                    </asp:DropDownList>
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-4" for="DropDownList4">From</label>
                <div class=" col-md-8">
                    <asp:DropDownList ID="DropDownList4" CssClass="form-control" runat="server">
                        <asp:ListItem Value="1">UL</asp:ListItem>
                        <asp:ListItem Value="2">City</asp:ListItem>
                    </asp:DropDownList>
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-4" for="DropDownList2">To</label>
                <div class=" col-md-8">
                    <asp:DropDownList ID="DropDownList2" CssClass="form-control" runat="server">
                        <asp:ListItem Value="1">Request</asp:ListItem>
                        <asp:ListItem Value="2">Offer</asp:ListItem>
                    </asp:DropDownList>
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-4" for="<%=TextBox2.ClientID%>">Between</label>
                <div class='input-group date  col-md-6' id='datetimepicker1'>
                    <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-4" for="<%=TextBox3.ClientID%>">To</label>
                <div class='input-group date col-md-6' id='datetimepicker2'>
                    <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

            </div>
            <div class="form-group">
                <div class="col-lg-10 col-lg-offset-2">
                    <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="Search" />
                    <asp:Button ID="btnReset" CssClass="btn btn-default" runat="server" Text="Reset" />
                </div>
            </div>
        </fieldset>
    </div>

</div>
