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
                            <img alt="user picture" class="img-circle" height="150" width="130" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=")%><%#Eval("User_ID")%>' />
                        </div>
                        <div class="row form-group">
                            <asp:Label ID="userName" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="row form-group">
                            <cc1:Rating ID="Rating1" AutoPostBack="true" OnChanged="OnRatingChanged" runat="server" StarCssClass="Star" WaitingStarCssClass="WaitingStar" FilledStarCssClass="FilledStar" EmptyStarCssClass="Star">
                         </cc1:Rating>&nbsp;
                            <asp:Label ID="numberUserRating" runat="server" Text="" Font-Italic="True"></asp:Label>
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
                                <h3 class="text-center"><em><strong>REVIEWS</strong></em></h3>
                            </div>

                        </div>
                            </div>
                        
                       
                    </asp:Panel>
                    <%--<div class ="row">
                        <div class="boxValidation">
                            <img alt="user picture" class="img-circle" height="40" width="40" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=")%><%#Eval("User_ID")%>' />
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
                    </div>--%>
                    
                    

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

