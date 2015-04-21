﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddRequest.aspx.cs" Inherits="AddRequest" %>

<%@ Register Src="~/Controls/AddRequestCtrl.ascx" TagPrefix="uc1" TagName="AddRequestCtrl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:AddRequestCtrl runat="server" ID="AddRequestCtrl" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
    
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

        <script type="text/javascript">
            //Datetime picker
            $(function () {
                $('.date').datetimepicker(
                    {
                        format: "DD/MM/YYYY HH:mm",
                        stepping: 5,
                        showClear: true,
                        showClose: true,
                        inline: true
                    });
            });
    </script>
</asp:Content>

