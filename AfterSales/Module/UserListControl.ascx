<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserListControl.ascx.cs" Inherits="WSMS.Module.UserListControl" %>
<%@ Register Src="~/Module/ServiceIssuesControl.ascx" TagName="ServiceIssuesControl" TagPrefix="uc1" %>

<asp:Repeater runat="server" ID="rptrUserList">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div class="grid" style="width: 50px">
            UserID
        </div>
        <div class="grid" style="width: 200px">
            User Name
        </div>
        <div class="grid" style="width: 200px">
            Email
        </div>
        <div class="grid" style="width: 200px;">
            Service Point
        </div>
        <div class="grid" style="width: 170px;">
            Role
        </div>
        <div class="grid" style="width: 100px;">
            Password
        </div>
        <div class="grid" style="width: 80px;">
            Status
        </div>
        <div class="grid" style="width: 100px; border-right: 1px solid #CCCCCC">
            Action
        </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div id='<%# DataBinder.Eval(Container.DataItem, "UserID")%>' style="width: 100%;
            float: left">
            <div class="item" style="width: 100%; float: left">
                <div class="user-id" style="width: 50px; height: 30px; line-height: 30px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: center">
                    &nbsp;
                    <%# DataBinder.Eval(Container.DataItem, "UserID")%>
                    <%--<input type="hidden" class="hfSCWarranty" name="hfSCWarranty" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />--%>
                </div>
                <div class="user-name" style="width: 200px; height: 30px; line-height: 30px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: left">
                    &nbsp;
                    <%# DataBinder.Eval(Container.DataItem, "UserName")%>
                </div>
                <div class="email" style="width: 200px; height: 30px; line-height: 30px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: left">
                    &nbsp;
                    <%# DataBinder.Eval(Container.DataItem, "Email")%>
                </div>
                <div class="service-point" style="width: 200px; height: 30px; line-height: 30px;
                    float: left; border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC;
                    text-align: left">
                    &nbsp;
                    <%# DataBinder.Eval(Container.DataItem, "ServicePointName")%>
                </div>
                <div class="role" style="width: 170px; height: 30px; line-height: 30px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: left">
                    &nbsp;
                    <%# DataBinder.Eval(Container.DataItem, "RoleName")%>
                    <input type="hidden" style="width: 100px" class="hfRole" value="<%# DataBinder.Eval(Container.DataItem, "RoleName")%>" />
                    <input type="hidden" style="width: 100px" class="hfRoleID" value="<%# DataBinder.Eval(Container.DataItem, "RoleID")%>" />
                </div>
                <div class="password" style="width: 100px; height: 30px; line-height: 30px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: center">
                    &nbsp;
                    
                </div>
                <div class="is-active" style="width: 80px; height: 30px; line-height: 30px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: center">
                    &nbsp;
                    <%# DataBinder.Eval(Container.DataItem, "IsActive")%>
                </div>
                <div class="action" style="width: 100px; height: 30px; line-height: 30px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC;
                    text-align: center; vertical-align: middle">
                    <div class="edit-user" style="border: 1px solid #83AF45; width: 80px; height: 20px;
                        line-height: 20px; text-align: center; font-weight: bold; font-style: italic;
                        cursor: pointer; float: left; margin-left: 10px; margin-top: 4px;">
                        EDIT
                    </div>
                    <%-- &nbsp;
                                    <div class="delete-service" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                                        font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:10px;margin-top:4px;">
                                        DELETE
                                    </div>--%>
                </div>
            </div>
            <div class="edit-item" style="width: 100%; float: left; display: none">
                <div class="user-id-edit" style="width: 50px; height: 60px; line-height: 60px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: center;
                    background-color: #EBDFE1">
                    &nbsp;
                    <%--<%# DataBinder.Eval(Container.DataItem, "UserID")%>--%>
                    <input type="hidden" class="hfUserID" name="hfUserID" value="<%# DataBinder.Eval(Container.DataItem, "UserID")%>" />
                </div>
                <div class="user-name-edit" style="width: 200px; height: 60px; line-height: 60px;
                    float: left; border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC;
                    text-align: left; background-color: #EBDFE1">
                    &nbsp;
                    <%# DataBinder.Eval(Container.DataItem, "UserName")%>
                </div>
                <div class="email-edit" style="width: 200px; height: 60px; line-height: 60px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: left;
                    background-color: #EBDFE1">
                    &nbsp;
                    <%# DataBinder.Eval(Container.DataItem, "Email")%>
                </div>
                <div class="service-point-edit" style="width: 200px; height: 60px; line-height: 60px;
                    float: left; border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC;
                    text-align: left; background-color: #EBDFE1">
                    &nbsp;
                    <%= DDLServicePoint %>
                </div>
                <div class="role-edit" style="width: 170px; height: 60px; line-height: 60px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: left;
                    background-color: #EBDFE1">
                    &nbsp;
                   <%= DDLRole %>
                </div>
                <div class="password-edit" style="width: 100px; height: 60px; line-height: 60px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; text-align: left;
                    background-color: #EBDFE1">
                    &nbsp;
                    <input type="text" class="password-input" style="width:80px" />
                </div>
                <div class="is-active-edit" style="width: 80px; height: 60px; line-height: 60px;
                    float: left; border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC;
                    text-align: left; background-color: #EBDFE1">
                    &nbsp;
                    <select class="is-active" name="is-active" style="width: 70px">
                        <option value="1">Active</option>
                        <option value="0">InActive</option>
                    </select>
                </div>
                <div class="action-edit" style="width: 100px; height: 60px; line-height: 60px; float: left;
                    border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC;
                    text-align: center; vertical-align: middle">
                    <div class="update-user" style="border: 1px solid #83AF45; width: 80px; height: 20px;
                        line-height: 20px; text-align: center; font-weight: bold; font-style: italic;
                        cursor: pointer; float: left; margin-left: 10px; margin-top: 4px;">
                        UPDATE
                    </div>
                    <div class="cancel-user" style="border: 1px solid #83AF45; width: 80px; height: 20px;
                        line-height: 20px; text-align: center; font-weight: bold; font-style: italic;
                        cursor: pointer; float: left; margin-left: 10px; margin-top: 4px;">
                        CANCEL
                    </div>
                    <%-- &nbsp;
                                    <div class="delete-service" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                                        font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:10px;margin-top:4px;">
                                        DELETE
                                    </div>--%>
                </div>
            </div>
        </div>
        <%--<div style="width: 950px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;display:none">
                                <uc1:ServiceIssuesControl ID="ServiceIssuesControl" runat="server" ServiceID='<%# DataBinder.Eval(Container.DataItem, "ServiceID")%>'  />
                            </div>--%>
    </ItemTemplate>
</asp:Repeater>
