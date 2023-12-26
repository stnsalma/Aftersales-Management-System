<%@ Page Language="C#" AutoEventWireup="true" EnableViewState ="true" CodeBehind="Login.aspx.cs" Inherits="WSMS.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        /* HTML elements  */		

	h1, h2, h3, h4, h5, h6{
		font-weight:normal;
		margin:0;
		line-height:1.1em;
		color:red;
		-moz-border-radius:10px;
	-webkit-border-radius:10px;
	}	
	h1{font-size:2em;margin-bottom:.5em;}	
	h2{font-size:1.75em;margin-bottom:.5142em;padding-top:.2em;}	
	h3{font-size:1.5em;margin-bottom:.7em;padding-top:.3em;}
	h4{font-size:1.25em;margin-bottom:.6em;}
	h5,h6{font-size:1em;margin-bottom:.5em;font-weight:bold;}
	
	p, blockquote, ul, ol, dl, form, table, pre{line-height:inherit;margin:0 0 1.5em 0;}
	ul, ol, dl{padding:0;}
	ul ul, ul ol, ol ol, ol ul, dd{margin:0;}
	li{margin:0 0 0 2em;padding:0;display:list-item;list-style-position:outside;}	
	blockquote, dd{padding:0 0 0 2em;}
	pre, code, samp, kbd, var{font:100% mono-space,monospace;}
	pre{overflow:auto;}
	abbr, acronym{
		text-transform:uppercase;
		border-bottom:1px dotted #000;
		letter-spacing:1px;
	}
	abbr[title], acronym[title]{cursor:help;}
	small{font-size:.9em;}
	sup, sub{font-size:.8em;}
	em, cite, q{font-style:italic;}
	img{border:none;}			
	hr{display:none;}	
	table{width:100%;border-collapse:collapse;}
	th,caption{text-align:left;}
	form div{margin:.5em 0;clear:both;}
	label{display:block;}
	fieldset{margin:0;padding:0;border:none;}
	legend{font-weight:bold;}
	input[type="radio"],input[type="checkbox"], .radio, .checkbox{margin:0 .25em 0 0;}

/* //  HTML elements */	

/* base */

body, table, input, textarea, select, li, button{
	font:1em "Lucida Sans Unicode", "Lucida Grande", sans-serif;
	line-height:1.5em;
	color:#444;
	}	
body{
	font-size:12px;
	background:white;		
	text-align:center;
	
	}		

/* // base */

/* login form */	

#login{
	margin:20em auto;
	background:#fff;
	/*border:8px solid #eee;*/
	border: 4px solid #336600;
	width:500px;
	-moz-border-radius:10px;
	-webkit-border-radius:10px;
	-moz-box-shadow:0 0 10px #4e707c;
	-webkit-box-shadow:0 0 10px #4e707c;
	text-align:left;
	position:relative;
	}
#login a, #login a:visited{color:#0283b2;}
#login a:hover{color:#111;}
#login h1{
	background:White;
	color:#999900;
	text-shadow:#007dab 0 1px 0;
	font-size:14px;
	padding:18px 23px;
	margin:0 0 1.5em 0;
	border-bottom:1px solid #EEEEEE;
	}
#login .register{
	position:absolute;
	float:left;
	margin:0;
	line-height:30px;
	top:-40px;
	right:0;
	font-size:11px;
	}
#login p{margin:.5em 25px;}
#login > .loginpassword{
	margin:.5em 25px;
	background:#eee;
	padding:4px;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	text-align:right;
	position:relative;
    top: 0px;
    left: 0px;
    border: 1px solid #999900
    }	
#login label{
	float:left;
	line-height:30px;
	padding-left:10px;
	font-family: "Trebuchet MS";
	font-weight:bold;
	font-size:14px;
	}
#login .field{
	border:1px solid #ccc;
	width:250px;
	font-size:12px;
	line-height:1.5em;
	padding:4px;
	-moz-box-shadow:inset 0 0 5px #ccc;
	-webkit-box-shadow:inset 0 0 5px #ccc;
	box-shadow:inset 0 0 5px #ccc;
	}	
#login div.submit{background:none;margin:1em 25px;text-align:left;}	
#login div.submit label{float:none;display:inline;font-size:11px;}	
#login button{
	border:0;
	padding:0 30px;
	height:30px;
	line-height:30px;
	text-align:center;
	font-size:12px;
	color:#fff;
	text-shadow:#007dab 0 1px 0;
	background:#83AF45;
	-moz-border-radius:50px;
	-webkit-border-radius:50px;
	cursor:pointer;
	}
#login #btnLogin{
	border:0;
	padding:0 30px;
	height:30px;
	line-height:30px;
	text-align:center;
	font-size:12px;
	color:#fff;
	text-shadow:#007dab 0 1px 0;
	background:#83AF45;
	-moz-border-radius:10px;
	-webkit-border-radius:10px;
	cursor:pointer;
	}
#login .forgot{text-align:right;font-size:11px;}
#login .back{padding:1em 0;border-top:1px solid #eee;text-align:right;font-size:11px;}
#login .error{
	float:left;
	position:absolute;
	left:95%;
	top:-5px;
	background:#890000;
	padding:5px 10px;	
	font-size:11px;
	color:#fff;
	text-shadow:#500 0 1px 0;
	text-align:left;
	white-space:nowrap;
	border:1px solid #500;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	-moz-box-shadow:0 0 5px #700;
	-webkit-box-shadow:0 0 5px #700;
	}


/* //  login form */	



    </style>
    <link href="Styles/Login.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.min.js" type="text/javascript"></script>
    
    <link href="Scripts/alertifyjs/css/alertify.css" rel="stylesheet" />
    <script src="Scripts/alertifyjs/alertify.js"></script>


<%--  <script src="Scripts/bowser.js" type="text/javascript"></script>--%>
   <script type="text/javascript">
       window.onload = function () {

           var isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;

           // Firefox 1.0+
           var isFirefox = typeof InstallTrigger !== 'undefined';
           var isCometBird = navigator.userAgent.match(/CometBird/g);
           // Safari 3.0+ "[object HTMLElementConstructor]" 
           var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || safari.pushNotification);

           // Internet Explorer 6-11
           var isIE = /*@cc_on!@*/false || !!document.documentMode;

           // Edge 20+
           var isEdge = !isIE && !!window.StyleMedia;

           // Chrome 1+
           var isChrome = !!window.chrome && !!window.chrome.webstore;

           console.log("isOpera :" + isOpera);
           console.log("isFirefox :" + isFirefox);
           console.log("isSafari :" + isSafari);
           console.log("isIE  :" + isIE);
           console.log("isEdge :" + isEdge);
           console.log("isChrome :" + isChrome);



           if (isOpera == true || isSafari == true || isIE == true || isEdge == true || isCometBird) {
               document.getElementById("txtUserName").disabled = true;
               document.getElementById("txtPassword").disabled = true;
               // document.getElementById("btnSubmit").disabled = true;
               // alert('Only Chrome and Mozilla fire Fox is supported');
               alertify.dialog('alert').set({
                   'title': '   ',
                   'transition': 'zoom',
                   'message': "Only Chrome and Mozilla fire Fox is supported."
               }).show();
           }


           //var output = 'Detecting browsers by ducktyping:<hr>';
           //output += 'isFirefox: ' + isFirefox + '<br>';
           //output += 'isChrome: ' + isChrome + '<br>';
           //output += 'isSafari: ' + isSafari + '<br>';
           //output += 'isOpera: ' + isOpera + '<br>';
           //output += 'isIE: ' + isIE + '<br>';
           //output += 'isEdge: ' + isEdge + '<br>';         
           //document.body.innerHTML = output;


       };

    </script>

 <%--   <script type="text/javascript">
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
                                  //  alert("Invalid User... Either user deactivated or no exists.");
                                alertify.dialog('alert').set({
                                    'title': '   ',
                                    'transition': 'zoom',
                                    'message': "Invalid User... Either user deactivated or no exists."
                                }).show();                               
                                else if (msg.d == "IP")
                                    //alert("Invalid Password...");
                                alertify.dialog('alert').set({
                                    'title': '   ',
                                    'transition': 'zoom',
                                    'message': "Invalid Password..."
                                }).show();                                 
                                else
                                    window.location = msg.d;
                            }
                            else {
                                //$("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                              //  alert(msg.d);
                                alertify.dialog('alert').set({
                                    'title': '   ',
                                    'transition': 'zoom',
                                    'message': msg.d
                                }).show();
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
    </script>--%>

</head>
<body>
    <form id="login"  runat="server" style="border-color:Blue">
          <div>
          <asp:Label ID="lblError" runat="server" Text="" style="color:red;" ClientIDMode="Static"></asp:Label>
        </div>
        <h1 style="color: blue">
           
            <strong>
             <div id="mq3" style="width: 400px; background-color: white;margin-left:70px;margin-top:-14px">
                             <img src="/images/Logo.jpg" style="width:100px;height:70px; align:center; marging-top:-50px;margin-left:105px;" /> 
                           
                            <%-- <marquee direction="left"><strong>After Sales Management System</strong></marquee>--%>
                           </div></strong>
                            <div style="width: 290px;margin-left:80px;margin-top:-24px"> <marquee direction="left"> <p style="align:center;margin-left:15px;font-size:18px;font-family:Comic Sans MS;color:#E04343;font-weight:bold">
                            After Sales Management System
                            </p>
                          </marquee></div>
                           </h1>
                          

        <div class="loginpassword">
            <label for="login_username">
                Login ID</label>
            <input  name="username" id="txtUserName" class="field required" title="Please provide your username"  runat="server" />
        </div>
        <div class="loginpassword">
            <label for="login_password">
                Password</label>
           <input type="password" name="password" id="txtPassword" class="field required"
                title="Password is required" runat="server" />
        </div>       
        <span style="float: right; padding-right: 30px">
            
        </span>
        <br />
        <br />
        <span style="float: right; padding-right: 30px;">
            
           <%-- <input id="btnLogin" type="button" name="Login" value="Log in" style="background-color:Blue" />--%>
           <input type="submit" id="btnLogin" value="Log in" class="btn btn-success"  runat="server" OnServerClick="btnLogin_Click" />
        </span>
        <p class="forgot" style="float: left">

        </p>
        <br />
        <br />
        <p class="back">
           
            <a href="#">Forgot your password?</a>
        </p>
    </form>
</body>
</html>


