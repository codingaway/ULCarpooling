<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EditProfileDetails.ascx.cs" Inherits="EditProfileDetails" %>
<div class="well bs-component">
    <div class="form-horizontal">
        <fieldset>
            <legend>Edit Details</legend>
            <div class="form-group">
                <label class="control-label col-md-2" for="txtName">Name</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtName" CssClass="form-control" runat="server" />
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-2" for="txtEmail">Email</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" />
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-2" for="txtPhone">Phone No.</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server" />
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-2" for="">Change Profile Picture</label>
                <asp:FileUpload ID="imageUpload" CssClass="form-control" runat="server" />

            </div>
            <div class="form-group">
                <div class="col-lg-10 col-lg-offset-2">
                    <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="Submit" />
                </div>
            </div>
        </fieldset>
    </div>

</div>