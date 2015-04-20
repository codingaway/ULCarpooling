<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GraphCtrlDounutRequestPick.ascx.cs" Inherits="GraphCtrlDounutRequestPick" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Chart ID="Chart1" runat="server" Height="400px" Width="450px" BorderlineDashStyle="DashDotDot" BorderlineWidth="1" BorderlineColor="Crimson" Palette="EarthTones">
            <Titles>
                <asp:Title Text="Top Pick Up Points Analysis in Requesting" />
            </Titles>
            <Series>
                <asp:Series Name="PickUpRequesting" Color="Snow" ChartArea="ChartArea1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" BackColor="Peru">
                    <Area3DStyle Enable3D="true"></Area3DStyle>
                    <AxisY>
                        <LabelStyle Font="Trebuchet MS, 10pt, style=Bold" />
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisY>
                    <AxisX>
                        <LabelStyle Font="Trebuchet MS, 10pt, style=Bold" />
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
</asp:Chart>