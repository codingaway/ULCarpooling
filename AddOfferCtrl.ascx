<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddOfferCtrl.ascx.cs" Inherits="AddOfferCtrl" %>
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>
<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" tagPrefix="ajax" %>

 <div class="container top-buffer">
        <div class="well bs-component">
            <div class="row">
            <div class="col-md-6">
            <div class="form-horizontal">
                <fieldset>
                    <legend>ADD AN OFFER</legend>
                    
         <div class="form-group">
             <div>
                  <label for="Depart">Depart Location :</label>
              </div>
                  <div class="col-md-5">
                     <label for="Depart">County :</label>
                     <asp:DropDownList ID="DDdepartCounty" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDdepartCounty_SelectedIndexChanged1">
                     </asp:DropDownList>
                  </div> 
                  <div class="col-md-5">
                     <label for="Depart">Place :</label>
                     <asp:DropDownList ID="DDdepartPlaces" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDdepartPlaces_SelectedIndexChanged1">
                     </asp:DropDownList>
                  </div>
                   &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DDdepartPlaces" ErrorMessage="!! Please Select Depart Location !!" ForeColor="Red" InitialValue="0" ValidationGroup="AddOffer"></asp:RequiredFieldValidator>
          </div> 

          <div class="form-group">
              <div>
                   <label for="Arrival">Arrival Location :</label>
              </div>    
              <div class="col-md-5">
                  <label for="Depart">County :</label>
                   <asp:DropDownList ID="DDarrivalCounty" CssClass="form-control" runat="server" OnSelectedIndexChanged="DDarrivalCounty_SelectedIndexChanged1" AutoPostBack="True">
                   </asp:DropDownList>
              </div>
              <div class="col-md-5">
                  <label for="Depart">Place :</label>
                   <asp:DropDownList ID="DDarrivalPlaces" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDarrivalPlaces_SelectedIndexChanged1">
                   </asp:DropDownList>
              </div>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DDarrivalPlaces" ErrorMessage="!! Please Select Arrival Location !!" ForeColor="Red" InitialValue="0" ValidationGroup="AddOffer"></asp:RequiredFieldValidator>
              </div>


                   <div class="form-group">
                      <label class="control-label col-md-2" for="Date">Date N Time</label>
                        <div class="col-md-10">
                            <div class='input-group date' id='datetimepicker1'>
                                <asp:TextBox ID="txtDate" CssClass="form-control date" runat="server"></asp:TextBox>                            
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                </span>
                                <asp:CustomValidator ID="valStartDate" runat="server" ControlToValidate="txtDate" ErrorMessage="Date-time is not valid." ClientValidationFunction="isValidDateValue" ValidationGroup="AddOffer" Display="Static">Error
                                </asp:CustomValidator>
                           </div>
                        </div>
                    </div>
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
                           
      </fieldset>
            </div>
             </div>
            <div class="col-md-6">
                <div>
               <asp:TextBox ID="tb_fromPoint" runat="server"></asp:TextBox>
               <input type="button" id="bt_Go" value="Let Go !" />
               <asp:TextBox ID="tb_endPoint" runat="server"></asp:TextBox>
               &nbsp;
               <cc1:GMap ID="GMap1" runat="server" />
               <div id="div_directions" style="height: 390px;overflow: auto"></div>
         </div>
                </div>
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

<script src="Scripts/dateValidation.js"></script>


