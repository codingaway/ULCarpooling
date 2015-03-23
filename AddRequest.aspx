<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddRequest.aspx.cs" Inherits="AddRequest" %>

<script runat="server">
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container top-buffer">
        <div class="well bs-component">
            <div class="form-horizontal">
                <fieldset>
                    <legend>ADD A REQUEST</legend>
                    
                    <div class="row">
                       <div class="form-group">
                        <label class="control-label col-md-2" for="Depart">Depart Location :</label>
  
                        <div class="col-md-10">
                            <asp:DropDownList ID="DDdepartLoc" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDdepartLoc_SelectedIndexChanged1">
                            </asp:DropDownList>
                        </div>
                    </div> 
                        <div class="form-group">
                        <label class="control-label col-md-2" for="Arrival">Arrival Location :</label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="DDarrivalLoc" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>
                    </div>

                     <div class="form-group">
                        <label class="control-label col-md-2" for="Date">Date N Time</label>
                        <div class="col-md-10">
                            <div class='input-group date' id='datetimepicker1'>
                                <asp:TextBox ID="txtDate" CssClass="form-control" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>                             
                           <div class="form-group">
                                <div class="col-md-4 col-md-offset-4">
                                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                                </div>
                                
                            </div>
                        </div>
                    
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
<script src="Scripts/moment.min.js"></script>
     <script src="Scripts/bootstrap-datetimepicker.min.js"></script>

    <%--Scrpits for date time picker--%>
    <script type="text/javascript">
        $(function () {
            $('#datetimepicker1').datetimepicker();
        });
        
    </script>
</asp:Content>

