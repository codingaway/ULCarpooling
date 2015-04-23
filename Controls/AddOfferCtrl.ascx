<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddOfferCtrl.ascx.cs" Inherits="AddOfferCtrl" %>
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>
<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" tagPrefix="ajax" %>

<style>
    .boxed {
             width: auto;
             border: 1px solid #c9cbcd;
             border-radius: 15px;
             padding: 2px;
             margin: 15px; 
           }
    .boxValidation {
                    width: auto;
                    margin: 15px;
                   }
</style>

 <div class="container top-buffer">
  <div class="well bs-component">
      <div class="row">
           <h3 class="text-center modal-header"><em><strong>Add An Offer</strong></em></h3>
          <div class="col-md-6">
              <div class="form-inline">
                  <div class="form-group">
                      <label for="Depart">Select Start Location</label> </h4>
       
                     <label for="Depart">County :</label>
                       <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDdepartCounty_SelectedIndexChanged1">
                       </asp:DropDownList>
                  </div>
                  <div class="form-group">

                  </div>
              </div>
            </div>
          </div>
          <div class="col-md-6">

          </div>
      </div>
     
   <div class="row">
    <div class="col-md-6">
     <div class="form-horizontal">
      <fieldset> 
                         
<div class="boxed">
      <h4> <label for="Depart">Select Start Location</label> </h4>
       <div class="row">
       <div class="col-md-5">
         <label for="Depart">County :</label>
           <asp:DropDownList ID="DDdepartCounty" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDdepartCounty_SelectedIndexChanged1">
           </asp:DropDownList>
       </div> 
       <div class="col-md-5">
         <label for="Depart">Place :</label>
           <asp:DropDownList ID="DDdepartPlaces" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDdepartPlaces_SelectedIndexChanged1" Enabled="False">
           </asp:DropDownList>
       </div>
       </div>
    <div class="row">
        <div class="boxValidation">
     <asp:RequiredFieldValidator ID="RFVdepartCounty" runat="server" ControlToValidate="DDdepartCounty" ErrorMessage="* Please Select County from Start Location *"  ValidationGroup="AddOffer" ForeColor="Red" ></asp:RequiredFieldValidator><br />
     <asp:RequiredFieldValidator ID="RFVdepartPlaces" runat="server" ControlToValidate="DDdepartPlaces" ErrorMessage="* Please Select Places from Start Location *"  ValidationGroup="AddOffer" ForeColor="Red" ></asp:RequiredFieldValidator>
        </div>
    </div> 
</div> 

<div class="boxed">
    <h4> <label for="Arrival">Select Stop Location</label> </h4> 
    <div class="row">
      <div class="col-md-5">
        <label for="Depart">County :</label>
          <asp:DropDownList ID="DDarrivalCounty" CssClass="form-control" runat="server" OnSelectedIndexChanged="DDarrivalCounty_SelectedIndexChanged1" AutoPostBack="True" Enabled="False">
          </asp:DropDownList>
      </div>
      <div class="col-md-5">
        <label for="Depart">Place :</label>
          <asp:DropDownList ID="DDarrivalPlaces" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDarrivalPlaces_SelectedIndexChanged1" Enabled="False">
          </asp:DropDownList>
      </div>
     </div>
    <div class="row">
     <div class="boxValidation">
      <asp:RequiredFieldValidator ID="RFVarrivalCounty" runat="server" ControlToValidate="DDarrivalCounty" ErrorMessage="* Please Select County from End Location *" ValidationGroup="AddOffer" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator><br />       
      <asp:RequiredFieldValidator ID="RFVarrivalPlaces" runat="server" ControlToValidate="DDarrivalPlaces" ErrorMessage="* Please Select Places from End Location *" ValidationGroup="AddOffer" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>
     </div>
    </div>
</div>
          
<div class="boxed">
<div class="form-group">
 <h4></h4>
  <div class="row">
   <label class="control-label col-md-3" for="Date">Date N Time :</label>
    <div class="col-md-8">
     <div class='input-group date'>
      <asp:TextBox ID="txtDate" CssClass="form-control date" runat="server" TextMode="DateTime"></asp:TextBox>                            
       <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar">
        </span>
      </span>
     </div>
    </div>
   </div>
</div>
 <div class="row">
  <div class="boxValidation">
   <asp:RequiredFieldValidator ID="RFVdate" runat="server" ControlToValidate="txtDate" ErrorMessage="* Please Select Date *"  ValidationGroup="AddOffer" ForeColor="Red"></asp:RequiredFieldValidator><br />          
   <asp:CustomValidator ID="valStartDate" runat="server" ControlToValidate="txtDate" ErrorMessage="* Date-time is not valid *" ClientValidationFunction="isValidDateValue" ValidationGroup="AddOffer" ForeColor="Red">
   </asp:CustomValidator>
  </div>     
</div>
</div>

<div class="boxed">
<div class="form-group">
 <h4></h4>
  <div class="row">
   <label class="control-label col-md-3" for="Spaces">No. Of seats :</label>
    <div class="col-md-8">
     <asp:TextBox ID="txtSeats" CssClass="form-control" runat="server"></asp:TextBox>
    </div>
  </div>
</div>
 <div class="row">
  <div class="boxValidation">
   <asp:RequiredFieldValidator ID="RFVseats" runat="server" ControlToValidate="txtSeats" ErrorMessage="* Please select number of seats offering *" ForeColor="Red" ValidationGroup="AddOffer"></asp:RequiredFieldValidator><br />
   <asp:RangeValidator ID="RangeValidatorSeats" runat="server" ErrorMessage="* Must be in range(0-4) *" ValidationGroup="AddOffer" ControlToValidate="txtSeats" ForeColor="Red" MinimumValue="0" MaximumValue="4" Type="Integer"></asp:RangeValidator>
  </div>
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
<div class="boxed">
 <div class="row">
  <div class="boxValidation">
   <asp:TextBox ID="tb_fromPoint" runat="server" CssClass="col-md-2"></asp:TextBox>
   <button type="button" class="btn btn-primary col-md-8" id="bt_Go" value="Let Go !">Check Distance & Time Here</button>
   <%--<input type="button" id="bt_Go" value="Let Go !" />--%>
   <asp:TextBox ID="tb_endPoint" runat="server" CssClass="col-md-1"></asp:TextBox>
  </div>
 </div>
 <div class="row">
  <div class="boxValidation">
   <cc1:GMap ID="GMap1" runat="server" style="height:auto; width:50%"/>
  </div>
 </div>
 <div class="row">
  <div class="boxValidation">
    <div id="div_directions" style="height: 390px;overflow: auto"></div>
  </div>
 </div>
 </div>
</div>
   </div>
  </div>
</div>

     <%--Scripts Start From here--%> 

