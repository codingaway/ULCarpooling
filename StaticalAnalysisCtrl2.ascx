<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StaticalAnalysisCtrl2.ascx.cs" Inherits="StaticalAnalysisCtrl2" %>
<asp:Chart ID="Chart1" runat="server">
    <Series>
        <asp:Series Name="Series1" ChartType="Pie"></asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
    </ChartAreas>
</asp:Chart>
