<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Search.ascx.cs" Inherits="Search" %>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Search</h3>
    </div>
    <div class="panel-body">
        <div class="form-horizontal">
            <div class="form-group">
                <label class="control-label col-sm-2" for="DropDownList1">Looking for</label>
                <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                    <asp:ListItem Value="1">Request</asp:ListItem>
                    <asp:ListItem Value="2">Offer</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="DropDownList4">From</label>
                <asp:DropDownList ID="DropDownList4" CssClass="form-control" runat="server">
                    <asp:ListItem Value="1">UL</asp:ListItem>
                    <asp:ListItem Value="2">City</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="DropDownList2">To</label>
                <asp:DropDownList ID="DropDownList2" CssClass="form-control" runat="server">
                    <asp:ListItem Value="1">Request</asp:ListItem>
                    <asp:ListItem Value="2">Offer</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="TextBox2">Between</label>
                <div class='input-group date' id='datetimepicker1'>
                    <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="TextBox3">To</label>
                <div class='input-group date' id='datetimepicker2'>
                    <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

            </div>
            <div class="form-group">
                <label class="control-label " for="btnSearch"></label>
                <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="Search" />
            </div>
        </div>
    </div>
</div>
