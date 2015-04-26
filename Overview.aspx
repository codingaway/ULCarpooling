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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnString %>" ></asp:SqlDataSource>                                     
    <div class="well top-buffer">
        <h3 class="text-center">User Overview</h3>
           <div class="row">           
                        <div class="col-md-3 col-md-offset-2">
                            
                            <asp:Image ID="imUserPic" runat="server" Height="150" Width="150" /><br />
                            <h2><asp:Label ID="userName" runat="server" Text=""></asp:Label></h2>
                            <asp:Label ID="lblStars" CssClass="stars" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblTotalComments" runat="server" Text="Total rating: " />
                            <span class="small text-muted">(<asp:Label ID="lblCount" runat="server" Text=""></asp:Label>)</span>
                            <br />
                            <asp:Label ID="lblUserAge" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="lblisSmoker" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="lblGender" runat="server" Text=""></asp:Label> <br />
                            <asp:Label ID="lblUserCat" runat="server" Text=""></asp:Label> <br />
                        </div>

                        <div class="col-md-5">
                                <h5 class="text-primary"><em>Recent Comments of this User</em></h5>
                                <asp:ListView ID="ListView1" runat="server" OnItemDataBound="ListView1_ItemDataBound">
                                <LayoutTemplate>
                                 <div>
                                     
                                  <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                                 </div>
                                </LayoutTemplate>
                                 <ItemTemplate>
                                     <div class="panel panel-default">
                                         <div class="panel-body">
                                            <em>"<%# Eval("comment")%>"</em>
                                          </div>
                                          <div class="panel-heading">
                                                <span><%# Eval("submit_date")%></span> <span class="text-info pull-right"> <%# Eval("Name")%></span>
                                              </div>
                                          
                                        </div>
                               </ItemTemplate>
<%--                               <AlternatingItemTemplate>
                                 <div class="panel panel-warning">
                                          <div class="panel-heading">
                                                <span class="panel-title"> <%# Eval("Name")%></span>
                                              </div>
                                          <div class="panel-body">
                                            <em>"<%# Eval("comment")%>"</em>
                                          </div>
                                          <div class="panel-footer pull-right"><%# Eval("submit_date")%></div>
                                        </div>
                               </AlternatingItemTemplate>--%> 
                               <EmptyDataTemplate>
                                   <div class="well">
                                       <asp:Label ID="Label1" runat="server" Text="There are no comments for this user"></asp:Label>
                                   </div>
                               </EmptyDataTemplate>
                                </asp:ListView>
                        </div>
           </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

