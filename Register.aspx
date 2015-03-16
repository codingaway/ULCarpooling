<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Default6" %>

<%--<%@ Reference Control="~/Login.ascx" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <asp:PlaceHolder ID="plhLogin" runat="server"></asp:PlaceHolder>--%>
    <div class="container top-buffer">
        <div class="well bs-component">
            <div class="form-horizontal">
                <fieldset>
                    <legend>New User Sign up</legend>
                    <p>
                        Please fill in the form below.
                    </p>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtEmail">UL Email</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtEmailConfirm">Confirm Email</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtEmailConfirm" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtPassword">Password</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtPassWordConfirm">Confirm Password</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtPassWordConfirm" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtQuestion">Secret Question</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtQuestion" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtAnswer">Answer</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtAnswer" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtFName">First Name</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtFName" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtSName">Surname</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtSName" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtPhone">Mobile</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtDoB">Date of Birth</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtDoB" CssClass="form-control" placeholder="DD/MM/YYYY" runat="server" TextMode="DateTime"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="<%=rblGender.ClientID%>">Gender</label>
                                <div class="col-md-8">
                                    <div class="radioButtonList">
                                    <asp:RadioButtonList CssClass="form-control" ID="rblGender" runat="server" RepeatLayout="Flow" style="display:inline" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="0">Male</asp:ListItem>
                                        <asp:ListItem Value="1">Female</asp:ListItem>
                                    </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="<%=rblSmoker.ClientID%>">Smoking habit</label>
                                <div class="col-md-8">
                                    <div class="radioButtonList">
                                    <asp:RadioButtonList CssClass="form-control" ID="rblSmoker" runat="server" RepeatLayout="Flow" style="display:inline" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="0">Smoker</asp:ListItem>
                                        <asp:ListItem Value="1">Non-Smoker</asp:ListItem>
                                    </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-4 col-md-offset-4">
                                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" />
                                </div>
                                <div class="col-md-4">
                                    <asp:Button ID="btnReset" CssClass="btn btn-default" runat="server" Text="Reset" />
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>

