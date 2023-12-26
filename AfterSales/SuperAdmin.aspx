<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SuperAdmin.aspx.cs" Inherits="WSMS.SuperAdmin" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/ServiceAssignControl.ascx" TagName="ServiceAssignControl"  TagPrefix="uc2" %>
<%@ Register Src="~/Module/UserListControl.ascx" TagName="UserListControl"  TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Styles/dashboard.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="Styles/modal-window.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery.msg.css" rel="stylesheet" type="text/css" />

    <script src="Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery.ui.core.js" type="text/javascript"></script>
    <script src="Scripts/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="Scripts/jquery.center.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.msg.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.blockUI.js" type="text/javascript"></script>

    <script type="text/javascript">

        var EmailExpression = "^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
        $(document).ready(function () {
            var UserID = '<%=UserID%>';
            if(UserID ==0)
                window.location("Login.aspx");
            //LoadServiceList(UserID);
            $(".tab-item").live('click', function () {
                if ($(this).hasClass("active-tab")) {
                    CurrentTabID = $(".active-tab").children("#hfTabID").val();
                    $("#hfCurrentTabID").attr("value", CurrentTabID);

                }
                else {
                    $(".tab-item").each(
							function () {
							    $(this).removeClass("active-tab").addClass("tab");
							}
						);
                    $(this).removeClass("tab").addClass("active-tab");

                    //CurrentTabID = $("#" + $(this).parent().attr('id') + " .active-tab > #hfTabID").val();
                    CurrentTabID = $(".active-tab").children("#hfTabID").val();
                    $("#hfCurrentTabID").attr("value", CurrentTabID);
                }
            });

            $("#dashboard").live('click', function () {
                $("#user-management-wrapper").css('display', 'none');
            });

            $("#deliverable").live('click', function () {
                $("#user-management-wrapper").css('display', 'none');
            });
            $("#deliverd").live('click', function () {
                $("#user-management-wrapper").css('display', 'none');
            });

            $("#user-management").live('click', function () {
                $("#user-management-wrapper").css('display', 'block');
//                var s =$("#user-management").hasClass('active-tab');
//                alert(s);
                if(!$("#user-management").hasClass('calcel-load'))
                {
                    LoadUserList("0", "0");
                }
            });

            function toAscii(strangeString) {
                return strangeString.replace(/./g, function (s) { return s.charCodeAt(0) });
            }
            function checkEqual(va1, va2) {
                alert(va1.value);
                alert(va2.value);
                if (va1.value != va2.value) {
                    return false;
                } else {
                    return true;
                }
            }
            $(".edit-user").live('click', function () {
                //$(this).parent().parent().parent().children(".item").css('display', 'none');
                $(".edit-item").css('display', 'none');
                $(this).parent().parent().parent().children(".edit-item").css('display', 'block');
                var role = $(this).parent().parent().children(".role").children(".hfRoleID").val();
                var usr = $(this).parent().parent().children(".user-id").text().trim();


                //alert(role);
                //alert("#" + usr);
                //$("#ddlrole").val(role);
                //$("." + usr).children(".edit-item").children("#ddlrole option:selected").prop("selected", false);
                //alert($("#" + usr).children(".edit-item").html());
                //$("#" + usr).children(".edit-item").children(".role-edit").children('select option[value="' + role + '"]').attr('selected', 'selected');
                //alert($("#" + usr).children(".edit-item").children(".role-edit").children("#ddlrole option[value=" + role + "]").val()); //prop("selected", true);
                //$("#ddlrole option:selected").prop("selected", false);
                //$("#ddlrole option[value=" + role + "]").prop("selected", true);
            });
            $(".update-user").live('click', function () {

                var UserID = $(this).parent().parent().children(".user-id-edit").children(".hfUserID").val();
                var ServicePointID = $(this).parent().parent().children(".service-point-edit").children(".ddl-sp").val();
                var RoleID = $(this).parent().parent().children(".role-edit").children(".ddl-role").val();
                var IsActive = $(this).parent().parent().children(".is-active-edit").children(".is-active").val();
                var Password = $(this).parent().parent().children(".password-edit").children(".password-input").val().trim();
                //alert(Password);
                var AddedBy = '<%=UserID%>';
                //alert(UserID + "  " + ServicePointID + "  " + RoleID + "  " + IsActive + "  " + AddedBy);
                var retVal = confirm("Do you want to update this user ?");
                if (retVal == true) {
                    UpdateUser(UserID, ServicePointID, RoleID, Password,IsActive, AddedBy)
                }
            });
            $(".cancel-user").live('click', function () {
                $(".edit-item").css('display', 'none');
            });

            $(".edit-item :input").change(function (event) {
                var el = $(this);
                if (el.is('input')) { //we are dealing with an input
                    var type = el.attr('type'); //will either be 'text', 'radio', or 'checkbox
                }
                else if (el.is('select')) { //we are dealing with a select
                    //alert("select");
                }
                else { //we are dealing with a textarea
                    //code here
                }
                //var id = $(this).attr('id');
            });

            $(".btn-search").live('click', function () {
                var spid = $("#sp").children(".ddl-sp").val();
                var roleid = $("#role").children(".ddl-role").val();
                //alert(spid + " " + roleid);
                LoadUserList(spid, roleid);
            });
            $(".btn-add-user").live('click', function () {
                $("#add-user").css('display', 'block');
                $("#save-user").css('display', 'block');
                $("#fieldset-add-user").css('display', 'block');

                $("#role-add").children(".ddl-role").css('width','205px');
                $("#sp-add").children(".ddl-sp").css('width','205px');


                $('#add-user').find('input:text').val('');

//                $("#" + id + " option").each(function () {
//                    $(this).removeAttr("selected");
//                });

                $("#level option[value='Select Level']").attr('selected', 'selected');
            });
            var isValid = true;
            var UserName ;
            var Email ;
            var Password ;
            var Address ;
            var RoleID ;
            var EmployeeCode ;
            var ServicePointID ;
            var AddedBy ;
            var UserFullName;
            var Level;
            $(".btn-save-user").live('click', function () {
                
//                $.msg({
//                    msgID: 1,
//                    autoUnblock: false,
//                    clickUnblock: false,
//                    content: 'Please wait saving your data.....'
//                });
                
                $.blockUI({ message: '<p> Please wait saving your data.....</p>' });

                UserName = $("#user-name").val().trim();
                UserFullName = $("#full-name").val().trim();
                Email = $("#email").val().trim();
                Password = $("#password").val().trim();
                Address = $("#address").val().trim();
                RoleID = $("#role-add").children(".ddl-role").val().trim();
                EmployeeCode = $("#emplyee-code").val().trim();
                ServicePointID = $("#sp-add").children(".ddl-sp").val().trim();
                Level = $("#level-add").children("#level").val().trim();
                alert(Level);
                AddedBy = <%=UserID %>;

                //alert( " user:" + UserName +  " Email:" +  Email +  " Password:" + Password + " Address:" + Address + " RoleID:" + RoleID +  " EmployeeCode:" + EmployeeCode + " ServicePointID:" + ServicePointID);

                var reg = new RegExp(EmailExpression);
                var IsEmailValid = reg.test(Email);
                //alert(IsEmailValid);
                isValid = true;
                if(UserName.length == 0)
                {
                    $.msg('unblock', 30, 1);

                    isValid = false;
                    alert("User Name can not be blank...")
                    $("#user-name").focus();
                }
                else if(UserFullName.length ==0)
                {
                    $.msg('unblock', 30, 1);

                    isValid = false;
                    alert("User Full Name can not be blank...")
                    $("#full-name").focus();
                }
                else if(Email.length ==0)
                {
                    $.msg('unblock', 30, 1);

                    isValid = false;
                    alert("Email can not be blank...")
                    $("#email").focus();
                }
                else if(Password.length ==0)
                {   
                    $.msg('unblock', 30, 1);

                    isValid = false;
                    alert("Password can not be blank...")
                    $("#password").focus();
                }
                else if(Address.length ==0)
                {
                    $.msg('unblock', 30, 1);

                    isValid = false;
                    alert("Address can not be blank...")
                    $("#address").focus();
                }
                else if(RoleID ==0)
                {
                    $.msg('unblock', 30, 1);

                    isValid = false;
                    alert("Please select user role...");                    
                }
                else if(EmployeeCode.length ==0)
                {
                    $.msg('unblock', 30, 1);

                    isValid = false;
                    alert("Employee Code can not be blank...")
                    $("#emplyee-code").focus();
                }
                else if(ServicePointID ==0)
                {
                    $.msg('unblock', 30, 1);

                   alert("Please select service point ..."); 
                   isValid = false;
                }
                else if(!IsEmailValid)
                {
                    $.msg('unblock', 30, 1);

                    alert("Invalid Email...Please put correct email.");
                    $("#email").focus();
                    isValid = false;
                }
                else if(isValid)
                {
                    ValidateEmail(Email,UserName,EmployeeCode);
                }
//                else if(isValid)
//                {
//                    ValidateUserName(UserName);
//                }
//                else if(isValid)
//                {                    
//                    ValidateEmployeeCode(EmployeeCode);
//                }

//                if(isValid)
//                {
//                    InsertUser(UserName,Email,Password,Address,RoleID,ServicePointID,AddedBy);
//                }
            });
            $(".btn-cancel").live('click', function () {
                $("#add-user").css('display', 'none');
                $("#save-user").css('display', 'none');
                $("#fieldset-add-user").css('display', 'none');
            });
            
            function ValidateEmail(Email,UserName,EmployeeCode)
            {
                 $.ajax({
                    type: "POST",
                    url: "SuperAdmin.aspx/ValidateEmail",
                    data: "{ Email: '" + Email
                            + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "err") {
                            
                            $.msg('unblock', 30, 1);

                            isValid = false;
                            alert("Eamil already exist..");
                            $("#email").focus();
                        }
                        else {
                            ValidateUserName(UserName,EmployeeCode);
                        }
                    }
                });
            }
            function ValidateEmployeeCode(EmployeeCode)
            {
                 $.ajax({
                    type: "POST",
                    url: "SuperAdmin.aspx/ValidateEmployeeCode",
                    data: "{ EmployeeCode: '" + EmployeeCode
                            + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "err") {
                            
                            $.msg('unblock', 30, 1);

                            isValid = false;
                            alert("Employee Code already exist..");
                            $("#emplyee-code").focus();
                        }
                        else {
                            //SHOW JGROWL
                             if(isValid)
                            {
                                InsertUser(UserName,UserFullName,Email,Password,Address,Level,RoleID,EmployeeCode,ServicePointID,AddedBy);
                            }
                        }
                    }
                });
            }
            function ValidateUserName(UserName,EmployeeCode)
            {
                 $.ajax({
                    type: "POST",
                    url: "SuperAdmin.aspx/ValidateUserName",
                    data: "{ UserName: '" + UserName
                            + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "err") {
                            
                            $.msg('unblock', 30, 1);
                                                        
                            isValid = false;
                            alert("User name already exist..");
                            $("#user-name").focus();
                        }
                        else {
                            //SHOW JGROWL
                            ValidateEmployeeCode(EmployeeCode);
                        }
                    }
                });
            }
            function LoadUserList(ServicePointID, RoleID) {
                
                //block-content
                //$.blockUI({ message: '<h1> Just a moment...</h1>' }); 
                $.msg({
                    msgID: 2,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading your data.....'
                });

                $.ajax({
                    type: "POST",
                    url: "SuperAdmin.aspx/LoadUserList",
                    data: "{ ServicePointID: '" + ServicePointID
                            + "', RoleID: '" + RoleID
                            + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        //alert("success er");
                        if (msg.hasOwnProperty("d"))
                        {
                            if (msg.d != "err") {
                                //alert("success");
                                
                                $.msg('unblock', 30, 2);

                                $("#user-list").html(msg.d);
                                $("#user-management").addClass("calcel-load");
                                
                            }
                            else {
                                //SHOW JGROWL
                            }
                        }
                        else
                        {
                            if (msg != "err") {
                                //alert("success");
                                $.msg('unblock', 30, 2);
                                //$.unblockUI();
                                
                                $("#user-list").html(msg);
                            }
                            else {
                                //SHOW JGROWL
                            }
                        }
                        
                    },
                    error: function (msg) {
                        $.msg('unblock', 0, 2);
                        //var ss = msg;
                        //alert(ss);
                        //$.unblockUI();
                    }
                });

                
            }
            function InsertUser(UserName,UserFullName, Email, Password, Address,Level,RoleID, EmployeeCode, ServicePointID, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "SuperAdmin.aspx/InsertUser",
                    data: "{ UserName: '" + UserName
                            + "', UserFullName: '" + UserFullName
                            + "', Email: '" + Email
                            + "', Password: '" + Password
                            + "', Address: '" + Address
                            + "', Level: '" + Level
                            + "', RoleID: '" + RoleID
                            + "', EmployeeCode: '" + EmployeeCode
                            + "', ServicePointID: '" + ServicePointID
                            + "', AddedBy: '" + UserID
                            + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {

                            //$.msg('unblock', 30, 1);
                            $.unblockUI();
                            

                            $("#add-user").css('display', 'none');
                            $("#save-user").css('display', 'none');
                            $("#fieldset-add-user").css('display', 'none');
                            alert("Data Saved Successfully");

                            LoadUserList("0", "0");


                        }
                        else {
                            //$("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                            //$.msg('unblock', 30, 1);
                            $.unblockUI();
                            alert(msg.d);
                        }
                    }
                });
            }

            function UpdateUser(UserID, ServicePointID, RoleID,Password, IsActive, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "SuperAdmin.aspx/UpdateUser",
                    data: "{ UserID: '" + UserID
                            + "', ServicePointID: '" + ServicePointID
                            + "', RoleID: '" + RoleID
                            + "', Password: '" + Password
                            + "', IsActive: '" + IsActive
                            + "', AddedBy: '" + AddedBy
                            + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                            alert("Data Saved Successfully");
                            $(".edit-item").css('display', 'none');
                            var spid = $("#sp").children(".ddl-sp").val();
                            var roleid = $("#role").children(".ddl-role").val();
                            //alert(spid + " " + roleid);
                            LoadUserList(spid, roleid);
                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="block-content" style="width:100%;border:0px solid red;float:left;">
        <div id="tab-content" style="width:100%;height:30px;border:0px solid red;float:left">
            
            <div class=" tab-item active-tab" id="dashboard">  Dashboard
            </div> 
            <%--<div class="tab tab-item " id="my-requisition">
                Receive Status
            </div>
            <div class="tab tab-item" id="Div3"> Pending Status
            </div>
            <div class="tab tab-item" id="others-service"> Technician Status
            </div>
            <div class="tab tab-item" id="Div1"> QC Status
            </div>--%>
            <div class="tab tab-item" id="deliverable"> Deliverable
            </div> 
            <div class="tab tab-item" id="deliverd"> Delivered
            </div>
            <div class="tab tab-item" id="user-management"> User Management
            </div> 
        </div>
        <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;padding-top:20px;overflow:auto;padding-bottom:20px;">
            <div id="user-management-wrapper" style ="width: 1180px; float: left; margin-left:50px;
                margin-top: 20px; border: 0px solid red ;display:none">
                <div id="user-search" style="width:100%;float:left;margin-bottom:10px">
                    <div id="sp" style="width:300px;float:left;margin-right:20px">
                        <div style="width:100px ;font-size:14px;font-weight:bold;float:left">Service Point: </div>
                        <%= DDLServicePoint %>
                    </div>
                    <div id="role" style="width:200px;float:left;margin-right:20px">
                        <div style="width:50px ;font-size:14px;font-weight:bold;float:left">Role: </div>
                        <%= DDLRole %>
                    </div>
                    <div id="search" style="width:100px;float:left;margin-right:20px">
                        <div class="btn-search" style="border: 1px solid #83AF45; width: 80px; height: 25px;
                            line-height: 25px; text-align: center; font-weight: bold; font-style: italic;
                            cursor: pointer; float: left; margin-left: 10px; ">
                            SHOW
                        </div>
                    </div>
                </div>
                <div id="user-list" style="width:100%;float:left;margin-bottom:10px">
                    <%--<uc3:UserListControl  ID="UserListControl" runat="server" />--%>
                </div>
                <div id="add-new-user" style ="width: 100%; float: left; margin-left:0px;
                    margin-top: 10px; border: 0px solid red ;display:block">
                    <div class="btn-add-user" style="border:1px solid #83AF45;width:150px;height:30px;line-height:30px;text-align:center;
                        font-weight:bold;font-style:italic;cursor:pointer;float:left">
                        ADD NEW USER
                    </div>
                </div>
                <fieldset id="fieldset-add-user" style="width:480px;display:none">
                    <legend >Add New User</legend>
                <div id="add-user" style="width: 100%; float: left;margin-top: 20px; margin-bottom: 10px;display:none">
                    
                        <div class="row">
                            <div class="label">
                                User Name :</div>
                            <div class="input">
                                <input type="text" id="user-name" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">
                                Password :</div>
                            <div class="input">
                                <input type="text" id="password" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">
                                User Full Name :</div>
                            <div class="input">
                                <input type="text" id="full-name" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">
                                Email :</div>
                            <div class="input">
                                <input type="text" id="email" />
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="label">
                                Address :</div>
                            <div class="input">
                                <input type="text" id="address" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">
                                Role :</div>
                            <div class="input" id="role-add">
                                <%=DDLRole %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">
                                Employee Code :</div>
                            <div class="input">
                                <input type="text" id="emplyee-code" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">
                                Level :</div>
                            <div class="input" id="level-add">
                                <select id="level">
                                    <option value="SelectLevel" selected="selected">-- Select Level --</option>
                                    <option value="Level-1">Level-1</option>
                                    <option value="Level-2">Level-2</option>
                                    <option value="Level-3">Level-3</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">
                                Service Point :</div>
                            <div class="input" id="sp-add">
                                <%=DDLServicePoint %>
                            </div>
                        </div>
                    

                </div>
                <div style="clear:both"></div>
                <div id="save-user" style ="width: 950px; float: left; margin-left:50px;
                    margin-top: 20px;margin-bottom:20px; border: 0px solid red ;display:none;">
                    <div class="btn-save-user" style="border:1px solid #83AF45;width:120px;height:30px;line-height:30px;text-align:center;
                        font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:300px;">
                        SAVE USER
                    </div>
                    <div class="btn-cancel" style="border:1px solid #83AF45;width:120px;height:30px;line-height:30px;text-align:center;
                        font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:20px;">
                        CANCEL
                    </div>
                </div>

                </fieldset>
            </div>
            <div style="clear:both"></div>
        </div>
    </div>

    <div id="popup_assign" class="popup_block" style="width: 900px; height: 100px;">
        <div id="6" style="width: 900px; height: 100px;">
            <div style="width: 180px; height: 30px; line-height: 30px; float: left; border: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center">

                <input type="hidden" value="6" name="hfSCServiceID" class="hfSCServiceID">
                <input type="hidden" value="Primo D4" name="hfSCModel" class="hfSCModel">
                
            </div>
            <div style="width: 200px; height: 30px; line-height: 30px; float: left; border: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left">
                
            </div>
            <div style="width: 100px; height: 30px; line-height: 30px; float: left; border: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left">
                
            </div>
            <div style="width: 50px; height: 30px; line-height: 30px; float: left; border: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left">

            </div>
            <div style="width: 100px; height: 30px; line-height: 30px; float: left; border: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left">
                <select id="approval">
                            <option value="" disabled="disabled" selected="selected">-- Assign Technician --</option>
                            <option value="1">Technician 1</option>
                            <option value="2">Technician 2</option>
                            <option value="3">Technician 3</option>
                            <option value="4">Technician 4</option>
                            <option value="5">Technician 5</option>
                            <option value="6">Technician 6</option>
                </select>
            </div>
            <div style="width: 50px; height: 30px; line-height: 30px; float: left; border: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left">
                Assign
                <%--<a style="height: 20px; line-height: 20px; width: 100px; font-weight: bold; text-decoration: none;
                    border: 1px solid #83AF45; color: #83AF45; display: block; text-align: center;font-weight:bold;font-style:italic;cursor:pointer;
                    float: left;" >Assign</a>--%>
            </div>
        </div>
        <%--<div class="download-controls" style="margin-top: 20px;">
            <div id="call-download-button" style="font-weight: bold; width: 100px; height: 30px;
                line-height: 30px; border: 1px solid #EEEEEE; float: left; text-align: center;
                margin-right: 10px; cursor: pointer;">
                Assign&nbsp;<img class="loading" src="Styles/Images/ajax-loader.gif" style="display: none;" /></div>
            <div style="clear: both">
            </div>
        </div>--%>
    </div>
    
</asp:Content>
