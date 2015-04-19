<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="ReviewPage.aspx.cs" Inherits="ReviewPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    /* Rating */
.boxValidation {
                    width: auto;
                    margin: 15px;
                   }

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
                         <cc1:Rating ID="Rating1" AutoPostBack="true" OnChanged="OnRatingChanged" runat="server" StarCssClass="blankstar" WaitingStarCssClass="waitingstar" FilledStarCssClass="shiningstar" EmptyStarCssClass="blankstar">
                         </cc1:Rating>&nbsp;
                            <asp:Label ID="numberUserRating" runat="server" Text=""></asp:Label>
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
              <asp:Label ID="lblGrdResult" runat="server" Text="Label"></asp:Label>         
          </div>
        </div> 
            
   </div>
  </div>
</div>

  

  
         
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

