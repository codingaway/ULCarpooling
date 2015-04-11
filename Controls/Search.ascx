<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Search.ascx.cs" Inherits="Search" %>

<div class="well bs-component searchbar">
    <div class="form-horizontal">
        <fieldset>
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
                    <asp:Label ID="lblMessage" runat="server" Text="Message" />
                    <label class="control-label col-md-2" for="TextBox2">Between</label>
                    <div class="col-md-10">
                        <div class='input-group date'>
                            <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" placeholder="Start Date-Time"></asp:TextBox>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-2" for="TextBox3">To</label>
                    <div class="col-md-10">
                        <div class='input-group date'>
                            <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" placeholder="Finish Date-Time"></asp:TextBox>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <asp:Button ID="btnReset" CssClass="btn btn-default" runat="server" Text="Reset" />
                <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="Search" />
            </div>
        </fieldset>
    </div>
</div>
