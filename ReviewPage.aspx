<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="ReviewPage.aspx.cs" Inherits="ReviewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container top-buffer">
        <div class="well bs-component">
            <div class="form-horizontal">
                <fieldset>
                    <legend>REVIEWS</legend>
                    
                    <asp:Table runat="server" CellPadding="5" GridLines ="Both" HorizontalAlign="Center">
                       <asp:TableRow>
                         <asp:TableCell>
                             <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/male.jpg" Height="150px" Width="150px" />
                         </asp:TableCell>
                         <asp:TableCell>2</asp:TableCell>
                       </asp:TableRow>
                       <asp:TableRow>
                         <asp:TableCell></asp:TableCell>
                         
                       </asp:TableRow>
                     </asp:Table>
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

