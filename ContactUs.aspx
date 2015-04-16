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
             <label for="Heading" style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: medium; font-style: normal; color: #000000">Talk to me about anything. If you’d like to give any feedback send it or if you have any question ask me, I’ll get back to you shortly.</label>
         </div>
                       <div class="form-group">
                        <label class="control-label col-md-3" for="Name">Name :</label>
                        <div class="col-md-8">
                         <asp:TextBox ID="txtName" CssClass="form-control" runat="server" TextMode="SingleLine"></asp:TextBox>   
                        </div>
                    </div> 
                        <div class="form-group">
                        <label class="control-label col-md-3" for="Email">E-Mail :</label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="SingleLine"></asp:TextBox>
                        </div>
                    </div>

                     <div class="form-group">
                        <label class="control-label col-md-3" for="Subject">Subject :</label>
                        <div class="col-md-8">
                                <asp:TextBox ID="txtSubject" CssClass="form-control" runat="server" TextMode="SingleLine"></asp:TextBox>            
                            </div>
                        </div>

                     <div class="form-group">
                        <label class="control-label col-md-3" for="Message">Message :</label>
                        <div class="col-md-8">
                                <asp:TextBox ID="txtMessage" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>            
                            </div>
                        </div>
                                                 
                           <div class="form-group">
                                <div class="col-md-4 col-md-offset-4">
                                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" />
                                </div>
                           </div>
                </fieldset>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

