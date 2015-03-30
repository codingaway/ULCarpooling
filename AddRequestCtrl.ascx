<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddRequestCtrl.ascx.cs" Inherits="AddRequestCtrl" %>
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>



<div class="container top-buffer">
        <div class="well bs-component">
            <div class="form-horizontal">
                <fieldset>
                    <legend>ADD A REQUEST</legend>

<asp:Table runat="server" CellPadding="5"
GridLines="vertical" HorizontalAlign="Center" Height="295px">
   <asp:TableRow>
     <asp:TableCell VerticalAlign="Top">
       
                       <div class="form-group">
                        <label class="control-label col-md-2" for="Depart">Depart Location :</label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="DDdepartLoc" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDdepartLoc_SelectedIndexChanged1">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DDdepartLoc" ErrorMessage="!! Please Select Depart Location !!" ForeColor="Red" InitialValue="0" ValidationGroup="AddRequest"></asp:RequiredFieldValidator>
                        </div>
                    </div> 
                        <div class="form-group">
                        <label class="control-label col-md-2" for="Arrival">Arrival Location :</label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="DDarrivalLoc" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDarrivalLoc_SelectedIndexChanged">
                            </asp:DropDownList>
                            <input type="button" id="bt_Go" value="Let Go !" onclick="btnDirections_onclick()"/>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DDarrivalLoc" ErrorMessage="!! Please Select Arrival Location !!" ForeColor="Red" InitialValue="0" ValidationGroup="AddRequest"></asp:RequiredFieldValidator>
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
                                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="AddRequest" />
                                </div>
                           </div>
                        
     </asp:TableCell>
     <asp:TableCell VerticalAlign="Top">
         <div>
               <asp:TextBox ID="tb_fromPoint" runat="server" Visible="False"></asp:TextBox>
               <asp:TextBox ID="tb_endPoint" runat="server" Visible="False"></asp:TextBox>
               &nbsp;
               <cc1:GMap ID="GMap1" runat="server" />
               <div id="div_directions" style="height: 390px;overflow: auto"></div>
          </div>
     </asp:TableCell>
   </asp:TableRow>
</asp:Table>                    
                    
                    
                </fieldset>
            </div>
        </div>
    </div>

<script src="Scripts/moment.min.js"></script>
     <script src="Scripts/bootstrap-datetimepicker.min.js"></script>

    <%--Scrpits for date time picker--%>
    <script type="text/javascript">
        $(function () {
            $('#datetimepicker1').datetimepicker();
        });
        
    </script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>