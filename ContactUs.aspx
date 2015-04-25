<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="ContactUs" %>
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container top-buffer">
        <div class="well bs-component">
            <div class="form-horizontal">
                <fieldset>
                    <legend>Contact Us</legend>
         <div class="modal-header">
             <p>If you have any queries or simply want to send us your valuable feedback regarding this site you can forward your message using the form below. Thank you.</p>
         </div>
                       <div class="form-group">
                        <label class="control-label col-md-3" for="Name">Name :</label>
                        <div class="col-md-8">
                         <asp:TextBox ID="txtName" CssClass="form-control" runat="server" TextMode="SingleLine"></asp:TextBox>   
                            <asp:RequiredFieldValidator ID="ValidationName" runat="server" ErrorMessage="* Please Enter Name *" ControlToValidate="txtName" ValidationGroup="Contact"></asp:RequiredFieldValidator>
                        </div>
                    </div> 
                        <div class="form-group">
                        <label class="control-label col-md-3" for="Email">E-Mail :</label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="SingleLine"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ValidationEmail" runat="server" ErrorMessage="* Please Enter Email Address *" ValidationGroup="Contact" ControlToValidate="txtEmail" EnableTheming="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ErrorMessage="Valid Email Address" ValidationGroup="Contact" ControlToValidate="txtEmail" ID="EmailValidate" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                     <div class="form-group">
                        <label class="control-label col-md-3" for="Subject">Subject :</label>
                        <div class="col-md-8">
                                <asp:TextBox ID="txtSubject" CssClass="form-control" runat="server" TextMode="SingleLine"></asp:TextBox>            
                                <asp:RequiredFieldValidator ID="ValidationSubject" runat="server" ControlToValidate="txtSubject" ValidationGroup="Contact" ErrorMessage="* Please Enter Subject *"></asp:RequiredFieldValidator>
                             </div>
                        </div>

                     <div class="form-group">
                        <label class="control-label col-md-3" for="Message">Message :</label>
                        <div class="col-md-8">
                                <asp:TextBox ID="txtMessage" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>            
                            <asp:RequiredFieldValidator ID="ValidationMessage" runat="server" ErrorMessage="* Please Enter Message *" ValidationGroup="Contact" ControlToValidate="txtMessage"></asp:RequiredFieldValidator>
                             </div>
                        </div>
                                                 
                           <div class="form-group">
                                <div class="col-md-4 col-md-offset-4">
                                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" ValidationGroup="Contact" OnClick="btnSend_Click" />
                                </div>
                           </div>
                </fieldset>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

