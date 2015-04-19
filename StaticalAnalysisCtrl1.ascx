<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StaticalAnalysisCtrl1.ascx.cs" Inherits="StaticalAnalysisCtrl1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<%--<asp:PieChart ID="PieChart1" runat="server" ChartTitleColor="#0E426C" ChartWidth="300" ChartHeight="300"></asp:PieChart>--%>
<asp:Chart ID="Chart1" runat="server" Height="296px" Width="412px" BorderlineDashStyle="Solid" BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2px" BackColor="211, 223, 240" BorderColor="#1A3B69">
            <Titles>
                <asp:Title Text="Title of the Graph comes here" />
            </Titles>
            <Series>
                <asp:Series Name="Series1" BorderColor="180, 26, 59, 105">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid"
                    BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent"
                    BackGradientStyle="TopBottom">
                    <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                        WallWidth="0" IsClustered="False"></Area3DStyle>
                    <AxisY LineColor="64, 64, 64, 64">
                        <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisY>
                    <AxisX LineColor="64, 64, 64, 64">
                        <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
</asp:Chart>
