<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="RegisterPage" %>

<%--<%@ Reference Control="~/Login.ascx" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <asp:PlaceHolder ID="plhLogin" runat="server"></asp:PlaceHolder>--%>
    <div class="container top-buffer">
        <div class="well bs-component">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblPageHeader" runat="server" Text="New user Sign up"></asp:Label>
                    </legend>
                    <p>
                        <asp:Label ID="lblFormMessage" runat="server" Text="Please fill in the form below."></asp:Label></p>
                    <asp:Panel ID="pnlFormInput" runat="server">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtEmail">UL Email</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="Email"></asp:TextBox>

                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server"
                                        ControlToValidate="txtEmail" ErrorMessage="Email address required">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                        ControlToValidate="txtEmail"
                                        Display="None"
                                        ValidationExpression="^([1-9]{1}\d{6,7}@studentmail.ul.ie)|([aA-zZ]+\w*([-+.']\w+)*@ul.ie)$"
                                        ErrorMessage="Not a valid UL email address">*</asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtEmailConfirm">Confirm Email</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtEmailConfirm" CssClass="form-control" runat="server" TextMode="Email"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="txtEmailConfirm"
                                        runat="server" ErrorMessage="You must confirm email address">*
                                    </asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server"
                                        ControlToCompare="txtEmail" ControlToValidate="txtEmailConfirm"
                                        ErrorMessage="Emails do not match">
                                        *
                                    </asp:CompareValidator>
                                    <asp:CustomValidator ID="CustomValidator1" runat="server"
                                        ControlToValidate="txtEmailConfirm"
                                        OnServerValidate="serverValIsUniqueEmail"
                                        Display="None"
                                        ErrorMessage="Email is already registered">*</asp:CustomValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtPassword">Password</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtPassword" runat="server" ErrorMessage="Password required">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtPassWordConfirm">Confirm Password</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtPassWordConfirm" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:CompareValidator ID="CompareValidator2"
                                        ControlToValidate="txtPasswordConfirm"
                                        ControlToCompare="txtPassword"
                                        Operator="Equal" runat="server" ErrorMessage="Passwords do not match">*</asp:CompareValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtQuestion">Secret Question</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtQuestion" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="txtQuestion" ErrorMessage="Secret question required">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtAnswer">Answer</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtAnswer" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4"
                                        ControlToValidate="txtAnswer" runat="server" ErrorMessage="Answer to secret question required">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtFName">First Name</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtFName" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                                        ControlToValidate="txtFName" runat="server" ErrorMessage="First name required">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtSName">Surname</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtSName" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6"
                                        ControlToValidate="txtSName" runat="server" ErrorMessage="Surname required">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtPhone">Mobile</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server" TextMode="Phone"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7"
                                        ControlToValidate="txtPhone" runat="server" ErrorMessage="Phone number required">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="txtDoB">Date of Birth</label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtDoB" CssClass="form-control" placeholder="DD/MM/YYYY" runat="server" TextMode="DateTime"></asp:TextBox>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8"
                                        ControlToValidate="txtDoB" runat="server" ErrorMessage="Date of birth required">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="<%=rblGender.ClientID%>">Gender</label>
                                <div class="col-md-7">
                                    <div class="radioButtonList">
                                        <asp:RadioButtonList CssClass="form-control" ID="rblGender" runat="server" RepeatLayout="Flow" Style="display: inline" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="0">Male</asp:ListItem>
                                            <asp:ListItem Value="1">Female</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9"
                                        ControlToValidate="rblGender" runat="server" ErrorMessage="Please select your gender">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4" for="<%=rblSmoker.ClientID%>">Smoking habit</label>
                                <div class="col-md-7">
                                    <div class="radioButtonList">
                                        <asp:RadioButtonList CssClass="form-control" ID="rblSmoker" runat="server" RepeatLayout="Flow" Style="display: inline" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="0">Smoker</asp:ListItem>
                                            <asp:ListItem Value="1">Non-Smoker</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                                <div class="col-md-1 error-marker">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10"
                                        ControlToValidate="rblSmoker" runat="server" ErrorMessage="Specify smoking habit">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-7 col-md-offset-4">
                                    <asp:CheckBox ID="chkTerms" CssClass="checkbox" runat="server" Text="Accept terms and conditions" />
                                </div>
                                <div class="col-md-1 error-marker">
                                    <%-- <asp:CustomValidator runat="server" ID="CheckBoxRequired" EnableClientScript="true"
    OnServerValidate="ChkCheckedRequired"
    ClientValidationFunction="isChkTermsChecked"
                                        ErrorMessage="You must accept our terms and condition" >*

                                    </asp:CustomValidator>--%>
                                </div>

                            </div>
                            <div class="form-group">
                                <div class="col-md-4 col-md-offset-4">
                                    <asp:Button ID="btnRegister" CssClass="btn btn-primary" runat="server" Text="Register" OnClick="btnRegister_Click" />
                                </div>
                                <div class="col-md-4">
                                   <%-- <asp:Button ID="btnReset" CssClass="btn btn-default" runat="server" Text="Reset" />--%>
                                    <input type="reset" class="btn btn-default" runat="server" label="Reset" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 val-summary">
                            <asp:ValidationSummary ID="valSummary" CssClass="alert-danger"
                                DisplayMode="BulletList"
                                HeaderText="Error processing information" runat="server" />
                        </div>
                    </div>
                    </asp:Panel>
                </fieldset>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>

