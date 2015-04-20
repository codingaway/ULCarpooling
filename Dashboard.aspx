<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" EnableEventValidation="false"%> <%-- --%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="~/Controls/PendingOffers.ascx" TagPrefix="uc1" TagName="PendingOffers" %>
<%@ Register Src="~/Controls/PendingRequests.ascx" TagPrefix="uc2" TagName="PendingRequests" %>
<%@ Register Src="~/Controls/TripHistory.ascx" TagPrefix="uc3" TagName="TripHistory" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container top-buffer">
        <div class="row">
            <div class="col-md-4">
                <asp:Image ID="profileImage" runat="server" Height="150" Width="200" />
                <h2>My Details</h2>
                <div>
                    <p>Name: <asp:Label ID="lblName" runat="server" Text="John Doe" /></p>
                    <p>Email: <asp:Label ID="lblEmail" runat="server" Text="John.Doe@ul.ie" /></p>
                    <p>Phone: <asp:Label ID="lblPhone" runat="server" Text="0871111111" /></p>
                    <p>DOB: <asp:Label ID="lblDOB" runat="server" Text="01/01/2000" /></p>
                    <p>Gender: <asp:Label ID="lblGender" runat="server" Text="confused" /></p>
                    <p>Smoker: <asp:CheckBox ID="checkBoxSmoker" runat="server" checked="false" Enabled="false"/></p>
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
                                            <p>Smoker: </p>
                                            <p>Gender: </p>
                                            <p>Date of Birth: </p>
                                            <p>Old Password: </p>
                                            <p>New Password: </p>
                                            <p>Confirm Password: </p>
                                            <p>Change Image: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="txtName" runat="server" Text="" />
                                            <asp:TextBox ID="txtPhone" runat="server" Text="" /> <p></p>
                                            <asp:CheckBox ID="chkBoxSmoker" runat="server" checked="false"/> <p></p>
                                            <asp:DropDownList ID="genderDDL" runat="server" >
                                                <asp:ListItem>Male</asp:ListItem>
                                                <asp:ListItem>Female</asp:ListItem>
                                            </asp:DropDownList> <p></p>
                                            <asp:TextBox ID="txtDOB" runat="server" />
                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDOB" Format="dd/MM/yyyy"/>
                                            <asp:TextBox ID="txtOldPW" runat="server" Text="" />
                                            <asp:TextBox ID="txtNewPW" runat="server" Text="" />
                                            <asp:TextBox ID="txtConPW" runat="server" Text="" /> <p></p>
                                            <asp:FileUpload ID="imageUpload" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="editDetails" CssClass="btn btn-primary" runat="server" OnClick="saveDetails_Click" Text="Save Changes"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p></p>
                    <asp:Button ID="btnBlock" CssClass="btn btn-primary" runat="server" Text="Blocked users" data-toggle="modal" data-target="#blockUserModal"/>
                    <div class="modal fade" id="blockUserModal" tabindex="-1" role="dialog" aria-labelledby="blockUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="blockUserModalLabel">Block a User</h4>
                                </div>
                                <div class="modal-body">
                                    <%--<div class="row">
                                        <div class="col-md-4">
                                        
                                            <p>Name of user to block: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="TextBox1" runat="server" Text="" />
                                        </div>
                                    </div>--%>
                                    <div class="row">
                                        <div class="col-md-4"><p>Select and remove to unblock</p></div>
                                        <div class="col-md-4">
                                            <asp:ListBox ID="bannedUserLB" runat="server" SelectionMode="Single" Width="174"/>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <%--<asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" OnClick="btnBlock_Click" Text="Submit"></asp:Button>--%>
                                    <asp:Button ID="Button3" CssClass="btn btn-primary" runat="server" OnClick="btnUnBlock_Click" Text="Remove"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <h2>My Feedback</h2>
                <div>
                    <p>Average Rating:</p>
                    <div>
                        <asp:Label ID="lblRating" runat="server" Text="No Rating Found" CssClass="stars"/> (<asp:Label ID="lblRatingCount" runat="server" Text="0"/>)
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <h2><asp:Label ID="lblSiteManagement" runat="server" Text="Site Management" Visible="false"/></h2>
                 <asp:Button ID="btnAddPlace" CssClass="btn btn-primary" runat="server" Text="Add new place" data-toggle="modal" data-target="#addPlace" Visible="false"/>
                    <div class="modal fade" id="addPlace" tabindex="-1" role="dialog" aria-labelledby="addPlaceLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="addPlaceLabel">Add new place</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <p>County: </p>
                                            <p>Town/City: </p>
                                            <p>Area: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="txtCounty" runat="server" Text="" />
                                            <asp:TextBox ID="txtTown" runat="server" Text="" />
                                            <asp:TextBox ID="txtArea" runat="server" Text="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="Button4" CssClass="btn btn-primary" runat="server" OnClick="addPlace_Click" Text="Add"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p></p>
                <asp:Button ID="btnReviewComplaints" CssClass="btn btn-primary" runat="server" Text="Review complaints" data-toggle="modal" data-target="#reviewComplaints" Visible="false"/>
                    <div class="modal fade" id="reviewComplaints" tabindex="-1" role="dialog" aria-labelledby="reviewComplaintsLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="reviewComplaintsLabel">Review Complaints</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <p>Complaints: </p>
                                            <p>Remove: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="TextBox2" runat="server" Text="" />
                                            <asp:TextBox ID="TextBox3" runat="server" Text="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="Button5" CssClass="btn btn-primary" runat="server" OnClick="removeComp_Click" Text="Remove"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p></p>
                <asp:Button ID="btnBan" CssClass="btn btn-primary" runat="server" Text="Ban a user" data-toggle="modal" data-target="#banUserModal" Visible="false"/>
                    <div class="modal fade" id="banUserModal" tabindex="-1" role="dialog" aria-labelledby="banUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="banUserModalLabel">Ban a User</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                        
                                            <p>Name of user to ban: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="TextBox4" runat="server" Text="" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4"><p>Select and remove to unban</p></div>
                                        <div class="col-md-4">
                                            <asp:ListBox ID="ListBox1" runat="server" SelectionMode="Single" Width="174"/>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="Button6" CssClass="btn btn-primary" runat="server" OnClick="btnBan_Click" Text="Submit"></asp:Button>
                                    <asp:Button ID="Button7" CssClass="btn btn-primary" runat="server" OnClick="btnUnBan_Click" Text="Remove"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p></p>
                <asp:Button ID="btnRemoveUser" CssClass="btn btn-primary" runat="server" Text="Remove a user" data-toggle="modal" data-target="#removeUserModal" Visible="false"/>
                    <div class="modal fade" id="removeUserModal" tabindex="-1" role="dialog" aria-labelledby="removeUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="removeUserModalLabel">Remove a User</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                        
                                            <p>Name of user to remove: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="TextBox5" runat="server" Text="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="Button9" CssClass="btn btn-primary" runat="server" OnClick="btnRemoveUser_Click" Text="Remove"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p></p>
                <asp:Button ID="btnChangeUsersPW" CssClass="btn btn-primary" runat="server" Text="Change users password" data-toggle="modal" data-target="#changeUserPWModal" Visible="false"/>
                    <div class="modal fade" id="changeUserPWModal" tabindex="-1" role="dialog" aria-labelledby="changeUserPWModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="changeUserPWModalLabel">Change User Password</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <p>Name: </p>
                                            <p>New Password: </p>
                                            <p>Confrim Password: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="TextBox6" runat="server" Text="John Doe" />
                                            <asp:TextBox ID="TextBox7" runat="server" Text="" />
                                            <asp:TextBox ID="TextBox8" runat="server" Text="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="Button8" CssClass="btn btn-primary" runat="server" OnClick="changeUserPW_Click" Text="Save Changes"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p></p>
                <asp:Button ID="btnEditMod" CssClass="btn btn-primary" runat="server" Text="Edit Moderators" data-toggle="modal" data-target="#editModModal" Visible="false"/>
                    <div class="modal fade" id="editModModal" tabindex="-1" role="dialog" aria-labelledby="editModModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="editModModalLabel">Edit Moderators</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                        
                                            <p>Name of moderator: </p>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="TextBox9" runat="server" Text="" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4"><p>Select and remove to clear</p></div>
                                        <div class="col-md-4">
                                            <asp:ListBox ID="ListBox2" runat="server" SelectionMode="Single" Width="174"/>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="Button10" CssClass="btn btn-primary" runat="server" OnClick="btnBan_Click" Text="Submit"></asp:Button>
                                    <asp:Button ID="Button11" CssClass="btn btn-primary" runat="server" OnClick="btnUnBan_Click" Text="Remove"></asp:Button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p></p>
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


