<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="ReviewPage.aspx.cs" Inherits="ReviewPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    /* Rating */
.blankstar
{
background-image: url(images/blank_star.png);
width: 16px;
height: 16px;
}
.waitingstar
{
background-image: url(images/half_star.png);
width: 16px;
height: 16px;
}
.shiningstar
{
background-image: url(images/shining_star.png);
width: 16px;
height: 16px;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container top-buffer">
        <div class="well bs-component">
            <div class="form-horizontal">
                <fieldset>
                  <asp:Table runat="server" CellPadding="5" GridLines="Both" HorizontalAlign="Center" Height="500px" Width="700px" CssClass="table">
   <asp:TableRow>
     <asp:TableCell Height="100" Width="150" HorizontalAlign="Center">
         <asp:Image ID="profilePic" runat="server" ImageUrl="~/Images/male.jpg" Height="95" /></asp:TableCell>
     <asp:TableCell HorizontalAlign="Center"><h2>Reviews</h2></asp:TableCell>
   </asp:TableRow>
   <asp:TableRow>
     <asp:TableCell>
         <cc1:Rating ID="Rating1" AutoPostBack="true" OnChanged="OnRatingChanged" runat="server" StarCssClass="blankstar" WaitingStarCssClass="waitingstar" FilledStarCssClass="shiningstar" EmptyStarCssClass="blankstar">
         </cc1:Rating>
     </asp:TableCell>
    <asp:TableCell VerticalAlign="Top">
         <asp:GridView ID="grdResult" runat="server" Width="550px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" onrowdatabound="grdResult_RowDataBound">
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
        <RowStyle BackColor="White" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>
     </asp:TableCell> 
   </asp:TableRow>
</asp:Table>  
                </fieldset>
            </div>
        </div>
    </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

