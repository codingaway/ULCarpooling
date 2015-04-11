<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddOfferCtrl.ascx.cs" Inherits="AddOfferCtrl" %>
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>
<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" tagPrefix="ajax" %>

 <div class="container top-buffer">
        <div class="well bs-component">
            <div class="form-horizontal">
                <fieldset>
                    <legend>ADD AN OFFER</legend>
                    
<asp:Table runat="server" CellPadding="5" GridLines="vertical" HorizontalAlign="Center">
   <asp:TableRow>
     <asp:TableCell VerticalAlign="Top">
         <div class="form-group">
                        <label class="control-label col-md-2" for="Depart">Depart Location :</label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="DDdepartLoc" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDdepartLoc_SelectedIndexChanged1">
                            </asp:DropDownList>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DDdepartLoc" ErrorMessage="!! Please Select Depart Location !!" ForeColor="Red" InitialValue="0" ValidationGroup="AddOffer"></asp:RequiredFieldValidator>
                        </div>
                    </div> 
                        <div class="form-group">
                        <label class="control-label col-md-2" for="Arrival">Arrival Location :</label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="DDarrivalLoc" CssClass="form-control" runat="server" OnSelectedIndexChanged="DDarrivalLoc_SelectedIndexChanged" AutoPostBack="True">
                            </asp:DropDownList>
                            <input type="button" id="bt_Go" value="Let Go !" onclick="btnDirections_onclick()"/>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DDarrivalLoc" ErrorMessage="!! Please Select Arrival Location !!" ForeColor="Red" InitialValue="0" ValidationGroup="AddOffer"></asp:RequiredFieldValidator>
                        </div>
                    </div>


                 <div class="form-group">
                        <label class="control-label col-md-2" for="Date">Date N Time</label>
                        <div class="col-md-10">
                            <div class='input-group date' id='datetimepicker1'>
                                <asp:TextBox ID="txtDate" CssClass="form-control date" runat="server"></asp:TextBox>                            
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                            <asp:CustomValidator ID="CustomValidator1" ControlToValidate="txtDate" ClientValidationFunction="" runat="server" ErrorMessage="CustomValidator"></asp:CustomValidator>
                        </div>
                    </div>

                     <%--<div class="form-group">
                        <label class="control-label col-md-2" for="Date">Date N Time :</label>
                        <div class="col-md-10">
                                <asp:TextBox ID="txtDate" CssClass="form-control" runat="server" ></asp:TextBox>
                                <asp:ImageButton ID="CalendarImg" runat="server" Height="25px" Width="25px" ImageUrl="~/Images/Calendar ICON.png" />
                                <ajax:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="CalendarImg" PopupPosition="BottomRight" Format="dd/MM/yyyy" TargetControlID="txtDate" />
                       </div>
                         <div class="input-group clockpicker">
                           <input type="text" class="form-control" value="09:30">
                             <span class="input-group-addon">
                               <span class="glyphicon glyphicon-time"></span>
                             </span>
                       </div>
                        </div>--%>
                    

                        <div class="form-group">
                                <label class="control-label col-md-2" for="Spaces">Number Of Seats :</label>
                                <div class="col-md-10">
                                    <asp:TextBox ID="txtSeats" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSeats" ErrorMessage="!! Input Number Of Seats !!" ForeColor="Red" ValidationGroup="AddOffer"></asp:RequiredFieldValidator>
                                </div>
                            </div>     
                                                     
                           <div class="form-group">
                                <div class="col-md-4 col-md-offset-4">
                                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" ValidationGroup="AddOffer" OnClick="btnSubmit_Click" />
                                </div>
                           </div>
     </asp:TableCell>
     <asp:TableCell VerticalAlign="Top">
         <div>
               <asp:TextBox ID="tb_fromPoint" runat="server"></asp:TextBox>
               <asp:TextBox ID="tb_endPoint" runat="server"></asp:TextBox>
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
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script src="Scripts/bootstrap-datetimepicker.min.js"></script>

    <%--Scrpits for date time picker--%>
    <script type="text/javascript">
        $(function () {
            $('.date').datetimepicker();
        });

    </script>



<%--<script src="Scripts/clockpicker-gh-pages/src/clockpicker.js"></script>

<script type="text/javascript">
    $('.clockpicker').clockpicker();
</script--%>>

