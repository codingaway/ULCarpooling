<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="JoshsTemplateAttempt.aspx.cs" Inherits="JoshsTemplateAttempt" %>
<%@ Reference Control="~/Search.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container top-buffer">
        <div class="row">
        <div class="col-md-4">
            <img src="Images/emptyProfileImage.png" class="img-thumbnail" alt="Profile Picture" width="200" height="150" id="profileImage" />
            <h2>My Details</h2>
            <div>
                <p>Name:<asp:Label ID="lblName" runat="server" Text="John Doe" /> </p>
                <p>Email:<asp:Label ID="lblEmail" runat="server" Text="John.Doe@ul.ie" /> </p>
                <p>Phone:<asp:Label ID="lblPhone" runat="server" Text="0871111111" /> </p>
                <p>Password:<asp:Label ID="lblPW" runat="server" Text="password" /> </p>
                <asp:Button ID="btnEditDetails" CssClass="btn btn-primary" runat="server" Text="Edit Details" />
                <p> </p>
                <asp:Button ID="btnChangePW" CssClass="btn btn-primary" runat="server" Text="Change Password" />
            </div>
            <h2>My feedback</h2>
            <p>Feedback Star image to go in here</p>
        </div>
            <div class="col-md-4">
            <h2>My Active Offers</h2>
            <p>
                <asp:Label ID="lblPendingOffer1" runat="server" Text="No Pending Offers" Visible="False" />
                <asp:Button ID="btnCancel" CssClass="btn btn-primary" runat="server" Text="Cancel" Visible="False"/>
            </p>
            <p>
                <asp:Label ID="lblPendingOffer2" runat="server" Text="" Visible="False" />
                <asp:Button ID="btnCancel2" CssClass="btn btn-primary" runat="server" Text="Cancel" Visible="False"/>
            </p>
            <h2>My Active Requests</h2>
            <p>
                <asp:Label ID="lblPendingRequests1" runat="server" Text="No Pending Requests" Visible="False" />
                <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Cancel" Visible="False"/>
            </p>
            <p>
                <asp:Label ID="lblPendingRequests2" runat="server" Text="" Visible="False" />
                <asp:Button ID="Button2" CssClass="btn btn-primary" runat="server" Text="Cancel" Visible="False"/>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Notifications</h2>
            <p>Notifications to go in here with Decline or Confirm buttons</p>
            <h2>Trip History</h2>
            <p>Trip histories to go in here with Review button</p>
        </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>


