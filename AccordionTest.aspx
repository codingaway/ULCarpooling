<%@ Page Title="Accordion Test" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AccordionTest.aspx.cs" Inherits="AccordionTest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Accordion ID="Accordion1" runat="server"
      HeaderCssClass="panel-heading" ContentCssClass="panel-body"
        Font-Names="Verdana" Font-Size="10"
       BorderColor="#000000" BorderStyle="Solid" BorderWidth="1"
       FramesPerSecond="100" FadeTransitions="true"
       TransitionDuration="500"
        >
        <Panes>
            <asp:AccordionPane runat="server" ID="AccordionPane1" CssClass="panel-info">
                <Header>
                    <h3>Books</h3>
                </Header>
                <Content>
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
               <asp:ListItem>HTML</asp:ListItem>
               <asp:ListItem>PHP</asp:ListItem>
               <asp:ListItem>XML</asp:ListItem>
            </asp:RadioButtonList> 
                </Content>
            </asp:AccordionPane>

                        <asp:AccordionPane runat="server" ID="AccordionPane2" CssClass="panel-info">
                <Header>
                    <h3>Sports</h3>
                </Header>
                <Content>
<asp:RadioButtonList ID="RadioButtonList2" runat="server">
               <asp:ListItem>Football</asp:ListItem>
               <asp:ListItem>Cricket</asp:ListItem>
               <asp:ListItem>Snooker</asp:ListItem>
            </asp:RadioButtonList> 
                </Content>
            </asp:AccordionPane>

                        <asp:AccordionPane runat="server" ID="AccordionPane3" CssClass="panel-info">
                <Header>
                    <h3>Movies</h3>
                </Header>
                <Content>
                    <asp:RadioButtonList ID="RadioButtonList3" runat="server">
               <asp:ListItem>Titanic</asp:ListItem>
               <asp:ListItem>Speed</asp:ListItem>
               <asp:ListItem>Shooter</asp:ListItem>
            </asp:RadioButtonList> 
                </Content>
            </asp:AccordionPane>
        </Panes>
        
    </asp:Accordion>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" Runat="Server">
</asp:Content>

