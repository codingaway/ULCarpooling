﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GraphCtrlBarRequestDrop.ascx.cs" Inherits="GraphCtrlBarRequestDrop" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Chart ID="Chart1" runat="server" Height="400px" Width="450px" BorderlineDashStyle="Solid" BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2px" BorderColor="#1A3B69">
            <Titles>
                <asp:Title Text="Top Drop Off Points Analysis in Requesting" />
            </Titles>
            <Series>
                <asp:Series Name="DropOffRequesting" BorderColor="180, 26, 59, 105">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisY LineColor="64, 64, 64, 64">
                        <%--<LabelStyle Font="Trebuchet MS, 10pt, style=Bold" />--%>
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisY>
                    <AxisX LineColor="64, 64, 64, 64">
                        <%--<LabelStyle Font="Trebuchet MS, 10pt, style=Bold" />--%>
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
</asp:Chart>
