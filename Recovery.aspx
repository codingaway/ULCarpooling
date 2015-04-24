<%@ Page Title="UL Carpooling - Login recovery " Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Recovery.aspx.cs" Inherits="Recovery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container top-buffer">

        <div class="form-signin">
            <asp:Panel runat="server" ID="pnlEmail" Visible="true">
                <h4 class="form-signin-heading">Enter your email address</h4>
                <asp:Label ID="lblEmail" CssClass="sr-only" runat="server" Text="Email"></asp:Label>
                <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email address" runat="server"></asp:TextBox><br />

                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtEmail"
                    CssClass="text-warning"
                    ValidationGroup="Recovery" Display="Dynamic"
                    runat="server" ErrorMessage="Email address required"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="valRegExpEmail" runat="server"
                    CssClass="text-warning" Display="Dynamic"
                    ErrorMessage="Email must be a valid UL email address"
                    ValidationGroup="Recovery"
                    ControlToValidate="txtEmail" ValidationExpression="^([1-9]{1}\d{6,7}@studentmail.ul.ie)|([aA-zZ]+\w*([-+.']\w+)*@ul.ie)$">
                </asp:RegularExpressionValidator>
                <asp:Button ID="btnCheckEmail" CssClass="btn btn-primary pull-right" runat="server" Text="Check Email" ValidationGroup="Recovery" OnClick="btnCheckEmail_Click" />
            </asp:Panel>

            <asp:Panel runat="server" ID="pnlQuestion" Visible="true">
                <asp:Label ID="lblQuestion" CssClass="" runat="server" Text=""></asp:Label>
                <h4 class="">Answer</h4>

                <asp:TextBox ID="txtAnswer" CssClass="form-control" placeholder="Answer" runat="server" TextMode="SingleLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="valReqFieldPassword" runat="server"
                    ControlToValidate="txtAnswer"
                    CssClass="text-warning"
                    ValidationGroup="Recovery"
                    Display="Dynamic"
                    ErrorMessage="Answer required">
                </asp:RequiredFieldValidator>
                <br />
                <asp:Button ID="btnCheckAnswer" CssClass="btn btn-primary pull-right" runat="server" Text="Submit" ValidationGroup="Recovery" OnClick="btnCheckAnswer_Click" />
            </asp:Panel>
            <asp:Panel ID="pnlPassword" runat="server">
                <h4 class="">New password</h4>
                <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ControlToValidate="txtPassword"
                    CssClass="text-warning"
                    ValidationGroup="Recovery"
                    Display="Dynamic"
                    ErrorMessage="Password required">
                </asp:RequiredFieldValidator>

                <h4 class="">Confirm password</h4>
                <asp:TextBox ID="txtConfirmPass" CssClass="form-control" placeholder="Confirm password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                    ControlToValidate="txtConfirmPass"
                    CssClass="text-warning"
                    ValidationGroup="Recovery"
                    Display="Dynamic"
                    ErrorMessage="Password missmatch">
                </asp:RequiredFieldValidator>

                <asp:CompareValidator ID="CompareValidator2"
                    ValidationGroup="Recovery"
                    ControlToValidate="txtConfirmPass"
                    ControlToCompare="txtPassword"
                    Operator="Equal" runat="server" ErrorMessage="Passwords do not match">*</asp:CompareValidator>
                <br />

                <asp:Button ID="btnChangePassword" CssClass="btn btn-primary pull-right" runat="server" Text="Submit" ValidationGroup="Recovery" OnClick="btnChangePassword_Click" /><br />
                <asp:Label ID="lblMessage" runat="server" Text="" ></asp:Label>
            </asp:Panel>

            <asp:Label ID="lblProblemRecovery" runat="server" Text="Problem recovering password?"></asp:Label>
            <asp:HyperLink ID="linkConactUs" NavigateUrl="~/ConcactUs.aspx" runat="server">Concatct us</asp:HyperLink>

        </div>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>

