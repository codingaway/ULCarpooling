<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JoshsTemp.aspx.cs" Inherits="JoshsTemp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Image ID="profileImage" runat="server" Height="100px" Width="113px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="activeOffers" runat="server" Font-Size="X-Large" style="position: absolute; z-index: 1; left: 295px; top: 19px; height: 27px; right: 498px;" Text="My Active Offers"></asp:Label>
        <asp:TextBox ID="txtOffer" runat="server" style="z-index: 1; left: 294px; top: 68px; position: absolute; height: 15px; right: 559px;"></asp:TextBox>
        <asp:TextBox ID="txtOffer2" runat="server" style="z-index: 1; left: 292px; top: 98px; position: absolute"></asp:TextBox>
        <asp:Button ID="btnCancel" runat="server" BackColor="#00CC00" ForeColor="White" style="z-index: 1; left: 465px; top: 65px; position: absolute; height: 24px; width: 78px" Text="Cancel" />
        <asp:Button ID="btnCancel2" runat="server" BackColor="#00CC00" ForeColor="White" style="z-index: 1; top: 95px; position: absolute; width: 78px; left: 465px" Text="Cancel" />
        <asp:Label ID="Label7" runat="server" Font-Size="X-Large" style="z-index: 1; left: 589px; top: 20px; position: absolute; width: 140px; height: 27px" Text="Notifications"></asp:Label>
        <asp:Label ID="lblRequestNotification" runat="server" style="z-index: 1; top: 58px; position: absolute; width: 137px; height: 18px; right: 178px; left: 679px;" Text="Requested for a trip to"></asp:Label>
        <br />
        <br />
        <asp:Label ID="userDetails" runat="server" Text="My Details" Font-Size="X-Large"></asp:Label>
        <asp:Label ID="lblActiveRequests" runat="server" Font-Size="X-Large" style="z-index: 1; left: 297px; top: 178px; position: absolute; height: 29px; width: 196px" Text="My Active Requests"></asp:Label>
        <asp:TextBox ID="txtDestination" runat="server" style="z-index: 1; left: 849px; top: 57px; position: absolute; width: 114px; height: 15px"></asp:TextBox>
        <asp:Button ID="btnDecline" runat="server" BackColor="#663300" ForeColor="White" style="z-index: 1; left: 842px; top: 95px; position: absolute; width: 97px; height: 25px" Text="Decline" />
        <asp:Button ID="btnConfim" runat="server" BackColor="#00CC00" ForeColor="White" style="z-index: 1; left: 746px; top: 96px; position: absolute; width: 81px; height: 25px" Text="Confirm" />
        <asp:TextBox ID="txtDestination2" runat="server" style="z-index: 1; left: 813px; top: 138px; position: absolute; width: 117px"></asp:TextBox>
        <asp:Label ID="Label8" runat="server" style="z-index: 1; left: 670px; top: 139px; position: absolute; width: 138px; height: 17px" Text="Offered a trip to"></asp:Label>
        <asp:TextBox ID="txtUsername2" runat="server" style="z-index: 1; left: 579px; top: 138px; position: absolute; width: 74px"></asp:TextBox>
        <br />
        <asp:TextBox ID="txtUsername" runat="server" style="z-index: 1; left: 47px; top: 57px; position: absolute; height: 15px; width: 74px; margin-left: 534px"></asp:TextBox>
        <br />
        <asp:Label ID="lblName" runat="server" Text="Name:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtName" runat="server" Width="180px"></asp:TextBox>
        <br />
        <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtEmail" runat="server" Width="179px"></asp:TextBox>
        <asp:Button ID="btnCancel3" runat="server" BackColor="#00CC00" ForeColor="White" style="z-index: 1; left: 482px; top: 228px; position: absolute; width: 78px; height: 21px; right: 434px" Text="Cancel" />
        <br />
        <asp:Label ID="lblPhone" runat="server" Text="Phone:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtPhone" runat="server" style="margin-left: 0px" Width="174px"></asp:TextBox>
        <asp:TextBox ID="txtRequest" runat="server" style="z-index: 1; left: 296px; top: 227px; position: absolute; height: 15px"></asp:TextBox>
        <br />
        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
        &nbsp;<asp:TextBox ID="txtPassword" runat="server" Width="175px"></asp:TextBox>
        <br />
        <asp:Button ID="Button5" runat="server" BackColor="#00CC00" ForeColor="White" style="z-index: 1; left: 734px; top: 179px; position: absolute; width: 81px; height: 25px; right: 179px;" Text="Confirm" />
        <asp:Label ID="Label9" runat="server" Font-Size="X-Large" style="z-index: 1; left: 580px; top: 288px; position: absolute; width: 132px" Text="Trip History"></asp:Label>
        <br />
        <asp:Button ID="btnChangePW" runat="server" BackColor="#00CC00" ForeColor="White" Text="Change Password" OnClick="btnChangePW_Click" />
        <asp:Button ID="Button4" runat="server" BackColor="#663300" ForeColor="White" style="z-index: 1; left: 838px; top: 176px; position: absolute; width: 97px; height: 26px" Text="Decline" />
        <br />
        <asp:TextBox ID="txtTrip" runat="server" style="z-index: 1; left: 582px; top: 332px; position: absolute; width: 337px"></asp:TextBox>
        <br />
        <asp:Button ID="editDetails" runat="server" BackColor="#00CC00" ForeColor="White" Text="Edit My Details" OnClick="editDetails_Click" />
        <asp:Button ID="btnReviewTrip" runat="server" BackColor="#00CC00" ForeColor="White" style="z-index: 1; left: 832px; top: 363px; position: absolute; width: 94px; height: 25px" Text="Review" />
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Font-Size="X-Large" Text="My Feedback"></asp:Label>
        <br />
        <br />
        <asp:Image ID="feedbackImage" runat="server" Height="26px" Width="158px" />
        <br />
        
    
    </div>
    </form>
</body>
</html>
