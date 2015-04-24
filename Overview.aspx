<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Overview.aspx.cs" Inherits="Overview" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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

        .Star {
            background-image: url(images/Star.gif);
            height: 17px;
            width: 17px;
        }

        .WaitingStar {
            background-image: url(images/WaitingStar.gif);
            height: 17px;
            width: 17px;
        }

        .FilledStar {
            background-image: url(images/FilledStar.gif);
            height: 17px;
            width: 17px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:Panel ID="Panel1" runat="server">

        <div class="row boxed">
            <div class="col-md-3">
                <div class="row form-group">
                    <asp:Image runat="server" ID="userImage" Height="150" Width="130" AlternateText="User image" />
                </div>
                <div class="row form-group">
                    <asp:Label ID="userName" runat="server" Text=""></asp:Label>
                </div>
                <div class="row form-group">
                    <cc1:Rating ID="Rating1" AutoPostBack="true" OnChanged="OnRatingChanged" runat="server" StarCssClass="Star" WaitingStarCssClass="WaitingStar" FilledStarCssClass="FilledStar" EmptyStarCssClass="Star">
                    </cc1:Rating>
                    &nbsp;
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
                    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
                        <HeaderTemplate>
                            comment header
                        </HeaderTemplate>
                        <ItemTemplate>
                            submit_date:
                            <asp:Label ID="submit_dateLabel" runat="server" Text='<%# Eval("submit_date") %>' />
                            <br />
                            rating:
                            <asp:Label ID="ratingLabel" runat="server" Text='<%# Eval("rating") %>' />
                            <br />
                            reviewed_by:
                            <asp:Label ID="reviewed_byLabel" runat="server" Text='<%# Eval("reviewed_by") %>' />
                            <br />
                            <br />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnString %>" SelectCommand="SELECT [submit_date], [rating], [reviewed_by] FROM [Reviews] WHERE ([user_id] = @user_id)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="user_id" QueryStringField="@id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
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
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>

