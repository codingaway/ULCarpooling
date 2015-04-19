<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StaticalAnalysisCtrl.ascx.cs" Inherits="StaticalAnalysisCtrl" %>

<asp:Chart ID="Chart1" runat="server" Width="515" Height="328">
    <Series>
        <asp:Series Name="Series1"></asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
    </ChartAreas>
</asp:Chart>
