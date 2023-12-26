<%@ Page Language="C#" AutoEventWireup="true" EnableViewState ="true" CodeBehind="Login.aspx.cs" Inherits="WSMS.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
    <link href="Styles/Login.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        jQuery(function ($) {

            // simple jQuery validation script
            $('#btnLogin').live('click', function () {
                var valid = true;
                var errormsg = 'This field is required!';
                var errorcn = 'error';

                $('.' + errorcn, this).remove();

                $('.required').each(function () {
                    var parent = $(this).parent();
                    if ($(this).val() == '') {
                        var msg = $(this).attr('title');
                        msg = (msg != '') ? msg : errormsg;
                        $('<span class="' + errorcn + '">' + msg + '</span>')
					    .appendTo(parent)
					    .fadeIn('fast')
					    .click(function () { $(this).remove(); })
                        valid = false;
                    };
                });
                if (valid) {

                    var UserName = $("#login_username").val();
                    var Password = $("#login_password").val();
                    //alert(UserName + Password);
                    $.ajax({
                        type: "POST",
                        url: "Login.aspx/DoLogin",
                        data: "{ UserName: '" + UserName
                        + "', Password: '" + Password + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            if (msg.d != "err") {
                                //                                var URL = '<%=URL%>';
                                //                                window.location = URL;
                                if (msg.d == "IU")
                                    alert("Invalid User... Either user deactivated or no exists.");
                                else if (msg.d == "IP")
                                    alert("Invalid Password...");
                                else
                                    window.location = msg.d;
                            }
                            else {
                                //$("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                                alert(msg.d);
                            }
                        }
                    });
                }
            });
            var clicked = true;
            $("#login_password").keyup(function (event) {
                if (event.keyCode == 13) {
                    if (clicked) {
                        $("#btnLogin").click();
                        clicked = false;
                    }
                }
                else {
                    clicked = true;
                    $('#login_password').parent().children(".error").remove();
                    $('#login_username').parent().children(".error").remove();
                }
            });
            $('#login_password').live('click', function () {
                $(this).parent().children(".error").remove();
            });
            $('#login_username').live('click', function () {
                $(this).parent().children(".error").remove();
            });

            /////////////////////////

        });



        function preventBack() { window.history.forward(1); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>

     <%--<script type = "text/javascript" >
         function preventBack() { window.history.forward(); }
         setTimeout("preventBack()", 0);
         window.onunload = function () { null };
</script>--%>
</head>
<body>
    <form id="login"  runat="server" style="border-color:Blue">
        <h1 style="color: blue">
            Log in to <strong>After Sales Management System</strong></h1>
        <div class="loginpassword">
            <label for="login_username">
                Login ID</label>
            <input type="text  name="username" id="login_username" class="field required" title="Please provide your username" />
        </div>
        <div class="loginpassword">
            <label for="login_password">
                Password</label>
            <input type="password" name="password" id="login_password" class="field required"
                title="Password is required" />
        </div>
        
        
        <span style="float: right; padding-right: 30px">
            <%--<input type="checkbox" name="remember" id="login_remember" value="yes" />
            Remember me--%> 
        </span>
        <br />
        <br />
        <span style="float: right; padding-right: 30px;">
            <%--<button id="btnLogin" type="submit">Log in</button>--%>
            <input id="btnLogin" type="button" name="Login" value="Log in" style="background-color:Blue" />
            <%--<asp:Button ID="btnLogin" runat="server" Text="Login"
                    style="border:1px solid #83AF45;height:25px; line-height:25px;background:#83AF45;font-family:'Trebuchet MS';
                        cursor:pointer;width:100px; font-weight:bold; text-align:center;" />--%>
        </span>
        <p class="forgot" style="float: left">
            <%--<a href="#">Forgot your password?</a>--%>
        </p>
        <br />
        <br />
        <p class="back">
            <%--Not a member? <a href="#">Register here!</a>--%>
            <a href="#">Forgot your password?</a>
        </p>
    </form>
</body>
</html>


