<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default5.aspx.cs" Inherits="Default5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix"></div>
   
    <div class="container">
         <div class="panel panel-success">
             <div class="panel-heading">
                 <h3 class="panel-title">Search</h3>
             </div>
             <div class="panel-body">
        <div class="row">
            <div class="col-md-4">
                <div>
                <div class="form-group">
                    <label class="control-label" for="DropDownList1">Looking for</label>
                    <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                        <asp:ListItem Value="1">Request</asp:ListItem>
                        <asp:ListItem Value="2">Offer</asp:ListItem>
                    </asp:DropDownList>
                </div>
                    </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label class="control-label" for="DropDownList4">From</label>
                    <asp:DropDownList ID="DropDownList4" CssClass="form-control" runat="server">
                        <asp:ListItem Value="1">UL</asp:ListItem>
                        <asp:ListItem Value="2">City</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label class="control-label" for="DropDownList2">To</label>
                    <asp:DropDownList ID="DropDownList2" CssClass="form-control" runat="server">
                        <asp:ListItem Value="1">Request</asp:ListItem>
                        <asp:ListItem Value="2">Offer</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label class="control-label" for="TextBox2">Between</label>
                    <div class='input-group date' id='datetimepicker1'>
                        <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>

                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label class="control-label" for="TextBox3">To</label>
                    <div class='input-group date' id='datetimepicker2'>
                        <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>

                </div>
            </div>
             <div class="col-md-4">
                <div class="form-group">
                    <label class="control-label" for="btnSearch"></label>
                    <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="Search" />
                </div>
            </div>
        </div>
                 </div>
               </div>
    </div>
      

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
    <script src="Scripts/moment.min.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#datetimepicker1').datetimepicker();
        });
        $(function () {
            $('#datetimepicker2').datetimepicker();
        });
    </script>
</asp:Content>

