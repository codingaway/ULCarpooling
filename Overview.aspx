<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Overview.aspx.cs" Inherits="Overview" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    /* Rating */
.boxed {
             width: 50%;
             border: 1px solid #42484d;
             padding: 4px;
             margin-top: -50px;
             position: fixed;
             top: 50%;
             left: 50%;
             transform: translate(-50%, -50%);
              
           }
        .boxed1 {
             width: auto;
             border: 1px solid #c9cbcd;
             border-radius: 5px;
             padding: 2px;
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
                    
                    <asp:Panel ID="Panel1" runat="server">
                        
                        <div class="row boxed">
                        <div class="col-md-3">
                        <div class="row form-group">
                            <asp:Image ID="imUserPic" runat="server" Height="150" Width="150" />
                            <%--<img alt="user picture" class="img-circle" height="150" width="130" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=")%><%#Eval("User_ID")%>' />--%>
                        </div>
                        <div class="row form-group">
                            <asp:Label ID="userName" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="row form-group">
                            <%--<cc1:Rating ID="Rating1" AutoPostBack="true" runat="server" StarCssClass="Star" WaitingStarCssClass="WaitingStar" FilledStarCssClass="FilledStar" EmptyStarCssClass="Star">
                         </cc1:Rating>&nbsp;
                            <asp:Label ID="numberUserRating" runat="server" Text="" Font-Italic="True"></asp:Label>--%>
                            <asp:Label ID="lblStars" CssClass="stars" runat="server" Text=""></asp:Label>
                                    <span class="small text-muted">(<asp:Label ID="lblCount" runat="server" Text=""></asp:Label>)</span>
                        </div>
                        <div class="row form-group">
                            <asp:Label ID="lblUserAge" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="row form-group">
                            <asp:Label ID="lblisSmoker" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="row form-group">
                            <asp:Label ID="lblGender" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="row form-group">
                            <asp:Label ID="lblUserCat" runat="server" Text=""></asp:Label>
                        </div>
                        </div>

                        <div class="col-md-5">
                            <div class="row">
                                <div class="col-md-12">
                                <h3 class="text-center"><em><strong>REVIEWS</strong></em></h3>
                                </div>
                            </div>
                            <div class="row">
                                <asp:ListView ID="ListView1" runat="server">
                                <LayoutTemplate>
                                 <div style="border:solid 2px #4d85b6; width:150%; padding:4px; margin:10px">
                                     <th><h4 class="modal-header" style="text-align:center"><em>Recent Five Comments of this User</em></h4></th>
                                  <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                                 </div>
                                </LayoutTemplate>
                                 <ItemTemplate>
                                  <div class="boxed1" style="text-align:center">
                                  <%# Eval("comment")%>
                                  </div>
                               </ItemTemplate>
                               <AlternatingItemTemplate>
                                 <div class="boxed1" style="text-align:center">
                                 <%# Eval("comment")%>
                                 </div>
                               </AlternatingItemTemplate>
                               <EmptyDataTemplate>
                                   <div class="boxed">
                                       <asp:Label ID="Label1" runat="server" Text="No records found" Font-Italic="True" Font-Bold="True" Font-Size="Medium" ForeColor="#333333"></asp:Label>
                                   </div>
                               </EmptyDataTemplate>
                                </asp:ListView>
                            </div>

                        </div>
                            </div>
                    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

