<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="OtherUserReviews.aspx.cs" Inherits="OtherUserReviews" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    /* Rating */
.boxValidation {
                    width: auto;
                    margin: 15px;
                   }
.boxed {
             width: auto;
             border: 1px solid #42484d;
             padding: 4px;
             margin: 15px; 
           }

        .Star
        {
            background-image: url(images/Star.gif);
            height: 17px;
            width: 17px;
        }
        .WaitingStar
        {
            background-image: url(images/WaitingStar.gif);
            height: 17px;
            width: 17px;
        }
        .FilledStar
        {
            background-image: url(images/FilledStar.gif);
            height: 17px;
            width: 17px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container top-buffer">
        <div class="well bs-component">
            <div class="row">
            <div class="col-md-2">
            <div class="form-horizontal">
                <fieldset> 
                    
                    <div class ="row">
                        <div class="boxValidation">
                            <img alt="user picture" height="120" width="100" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=") %>
                            <%#Eval("User_ID")%>' />
                        </div>
                    </div>

                    <div class ="row">
                        <div class="boxValidation">
                         <asp:Label ID="userName" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    
                    <div class ="row">
                        <div class="boxValidation">
                         <cc1:Rating ID="Rating1" AutoPostBack="true" OnChanged="OnRatingChanged" runat="server" StarCssClass="Star" WaitingStarCssClass="WaitingStar" FilledStarCssClass="FilledStar" EmptyStarCssClass="Star">
                         </cc1:Rating>&nbsp;
                            <asp:Label ID="numberUserRating" runat="server" Text="" Font-Italic="True"></asp:Label>
                        </div>
                    </div>
                    
                    
                </fieldset>
            </div>
            </div>

         <div class="boxValidation">
          <div class="col-md-3">
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
           </asp:GridView> <br />
               <asp:Label CssClass="boxed" ID="lblGrdResult" runat="server" Text="" Font-Italic="True" Visible="False"></asp:Label>
          </div>
        </div>             
   </div>
  </div>
</div>
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

