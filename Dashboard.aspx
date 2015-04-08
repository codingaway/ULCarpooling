<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<%@ Register Src="~/Controls/PendingOffers.ascx" TagPrefix="uc1" TagName="PendingOffers" %>
<%@ Register Src="~/Controls/PendingRequests.ascx" TagPrefix="uc2" TagName="PendingRequests" %>
<%@ Register Src="~/Controls/TripHistory.ascx" TagPrefix="uc3" TagName="TripHistory" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container top-buffer">
        <div class="row">
            <div class="col-md-4">
                <!--<img src="Images/emptyProfileImage.png" class="img-thumbnail" alt="Profile Picture" width="200" height="150" id="profileImage" />!-->
                <%--<img id="user picture" src='<%=ResolveClientUrl("~/GetImage.aspx?ImageID=") %><%=userID%>' runat="server"/>--%>
                <asp:Image ID="profileImage" runat="server" Height="150" Width="200" />
                <h2>My Details</h2>
                <div>
                    <p>
                        Name:<asp:Label ID="lblName" runat="server" Text="John Doe" />
                    </p>
                    <p>
                        Email:<asp:Label ID="lblEmail" runat="server" Text="John.Doe@ul.ie" />
                    </p>
                    <p>
                        Phone:<asp:Label ID="lblPhone" runat="server" Text="0871111111" />
                    </p>
                    <p>
                        Password:<asp:Label ID="lblPW" runat="server" Text="password" />
                    </p>
                    <asp:Button ID="btnEditDetails" CssClass="btn btn-primary" runat="server" Text="Edit Details" data-toggle="modal" data-target="#editDetailsModal" />
                    <div class="modal fade" id="editDetailsModal" tabindex="-1" role="dialog" aria-labelledby="editDetailsModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="editDetailsModalLabel">Edit Details</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <p>Name: </p>
                                            <p>Phone: </p>
                                            <p>Old Password: </p>
                                            <p>New Password: </p>
                                            <p>Confrim Password: </p>
                                            <p>Change Image: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="txtName" runat="server" Text="John Doe" />
                                            <asp:TextBox ID="txtPhone" runat="server" Text="0871111111" />
                                            <asp:TextBox ID="txtOldPW" runat="server" Text="old password" />
                                            <asp:TextBox ID="txtNewPW" runat="server" Text="" />
                                            <asp:TextBox ID="txtConPW" runat="server" Text="" /> <p></p>
                                            <asp:FileUpload ID="imageUpload" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="editDetails" CssClass="btn btn-primary" runat="server" OnClick="editDetails_Click" Text="Save Changes"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p></p>
                    <asp:Button ID="btnBan" CssClass="btn btn-primary" runat="server" Text="Block a user" data-toggle="modal" data-target="#banUserModal" />
                    <div class="modal fade" id="banUserModal" tabindex="-1" role="dialog" aria-labelledby="banUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="banUserModalLabel">Block a User</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                        
                                            <p>Name of user to block: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="TextBox1" runat="server" Text="" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4"><p>Highlight and click remove to unblock</p></div>
                                        <div class="col-md-4">
                                            <asp:ListBox ID="bannedUserLB" runat="server" SelectionMode="Single" Width="174"/>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" OnClick="btnBan_Click" Text="Submit"></asp:Button>
                                    <asp:Button ID="Button3" CssClass="btn btn-primary" runat="server" OnClick="btnUnBan_Click" Text="Remove"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <h2>My Feedback</h2>
                <span class="glyphicon glyphicon-star"></span>
                <span class="glyphicon glyphicon-star"></span>
                <span class="glyphicon glyphicon-star"></span>
                <span class="glyphicon glyphicon-star"></span>
                <span class="glyphicon glyphicon-star"></span>
                <p>Average Rating:<asp:Label ID="lblRating" runat="server" Text="No Rating Found" /></p>
            </div>
            <div class="col-md-4">
                <h2>My Active Offers</h2>
                <uc1:PendingOffers runat="server" ID="PendingOffers" userID="<%#userID%>"/>
                <h2>My Active Requests</h2>
                <uc2:PendingRequests runat="server" ID="PendingRequests" userID="<%#userID%>"/>
            </div>
            <div class="col-md-4">
                <h2>Notifications</h2>
                <p>Notifications to go in here with Decline or Confirm buttons</p>

                <h2>Trip History</h2>
                <uc3:TripHistory runat="server" id="TripHistory" userID="<%#userID%>"/>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphScripts" runat="Server">
</asp:Content>


