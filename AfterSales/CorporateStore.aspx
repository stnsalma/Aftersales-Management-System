<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CorporateStore.aspx.cs" Inherits="WSMS.CorporateStore" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>

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

    <link href="Scripts/alertifyjs/css/alertify.css" rel="stylesheet" />
    <script src="Scripts/alertifyjs/alertify.js" type="text/javascript"></script>

     <script type="text/javascript">
        $(document).ready(function () {
            var UserID = '<%=UserID%>';
            if (UserID == 0)
                window.location("Login.aspx");

            else {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading new request job.....'
                });
                LoadHandsetForCorporate(UserID);
            }

            $(".tab-item").live('click', function () {
                if ($(this).hasClass("active-tab")) {
                    CurrentTabID = $(".active-tab").children("#hfTabID").val();
                    $("#hfCurrentTabID").attr("value", CurrentTabID);
                }
                else {
                    $(".tab-item").each(function () {
                        $(this).removeClass("active-tab").addClass("tab");
                    });
                    $(this).removeClass("tab").addClass("active-tab");
                    CurrentTabID = $(".active-tab").children("#hfTabID").val();
                    $("#hfCurrentTabID").attr("value", CurrentTabID);
                }
            });

            $("#handset-receive").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#parameter-handset-receive-job').val('');
                $('#search-by-all').val('0');
                LoadHandsetForCorporate(UserID);
            });
            $("#store-report").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#imeno').val('');
                $('#search-by-all-2').val('0');
                LoadHandsetReport(UserID);
            });

            function HideAll()
            {
                $("#handset-receive-byCorStore-list").css("display","none");
                $("#search-handset-receive-wrapper").css("display","none");

                $("#handset-report-list").css("display","none");
                $("#search-handset-report-wrapper").css("display","none");
            }

            $("#service-detail").live('click', function () {
                $(this).parent().children("#service-detail-hide").css("display", "block");
                $(this).css("display", "none");
                $(this).parent().parent().parent().children("#replacement-IMEI-problem").css("display", "block");       
            });

            $("#service-detail-hide").live('click', function () {
                $(this).parent().children("#service-detail").css("display", "block");
                $(this).css("display", "none");
                $(this).parent().parent().parent().children("#replacement-IMEI-problem").css("display", "none");           
            });

           function LoadHandsetForCorporate(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "CorporateStore.aspx/LoadHandsetForCorporate",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#handset-receive-byCorStore-list").html(msg.d);
                            $("#handset-receive-byCorStore-list").css("display", "block");

                            $("#search-handset-receive-wrapper").css("display", "block");
                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                                //alert("No Records Found.");
                                alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date/RequestID.",                                                                       
                                             }).show();
                            }

                        }
                        else {
                           // alert("err");
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "err",                                                                       
                                             }).show();
                            $.msg('unblock', 30, 1);
                        }
                    },
                    error: function (msg) {
                        $.msg('unblock', 30, 1);
                    }
                });
            }

             $(".btn-handset-receive-bystore").live('click', function () {

                var searchby1 = $("#search-by-all").val();
                var parameter1 = $("#parameter-handset-receive-job").val().trim();
                
                if (searchby1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select Service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (parameter1.length == 0) {
                    alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                              }).show();
                    $("#imeno").focus();
                    return -1;
                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading services .....'
                    });

                        LoadHandsetForCorporate(UserID, searchby1 + ";" + parameter1);
                 
                }
            });
          
             $("#btn-corporate-receive").live('click', function () {
                var requestid = $(this).parent().parent().children("#requestdate1").children(".hfRequestID").val();
                var addedBy = UserID;
                var corporateStatus="CorporateStoreDelivered";

                InsertWareHouseCorporateStoreLog(requestid, corporateStatus, addedBy);

            });

             function InsertWareHouseCorporateStoreLog(RequestID, CorporateStatus, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "CorporateStore.aspx/InsertWareHouseCorporateStoreLog",
                    data: "{ RequestID: '" + RequestID
                                + "', CorporateStatus: '" + CorporateStatus
                                + "', AddedBy: '" + AddedBy
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                            //alert("Data Requested Successfully");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Received Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading Request data ...'
                            });

                            LoadHandsetForCorporate(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


            function LoadHandsetReport(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "CorporateStore.aspx/LoadHandsetReport",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#handset-report-list").html(msg.d);
                            $("#handset-report-list").css("display", "block");

                            $("#search-handset-report-wrapper").css("display", "block");
                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                                //alert("No Records Found.");
                                alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date/RequestID.",                                                                       
                                             }).show();
                            }

                        }
                        else {
                           // alert("err");
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "err",                                                                       
                                             }).show();
                            $.msg('unblock', 30, 1);
                        }
                    },
                    error: function (msg) {
                        $.msg('unblock', 30, 1);
                    }
                });
            }
           $(".btn-handset-report-search").live('click', function () {

                var searchby1 = $("#search-by-all-2").val();
                var parameter1 = $("#imeno").val().trim();
                
                if (searchby1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select Service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (parameter1.length == 0) {
                    alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                              }).show();
                    $("#imeno").focus();
                    return -1;
                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading services .....'
                    });

                        LoadHandsetReport(UserID, searchby1 + ";" + parameter1);
                 
                }
            });

           


        });

        function preventBack() { window.history.forward(1); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
  
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div style="width:100%;border:0px solid red;float:left;">
        <div id="tab-content" style="width:100%;height:30px;border:0px solid red;float:left">
            <div class=" tab-item active-tab" id="handset-receive" style="width:200px">
                Handset ReceiveBy Store
            </div>
            <div class="tab tab-item" id="store-report">
               Report
           </div>
        </div>

        <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;padding-top:20px;overflow:auto;padding-bottom:20px;">      
          <div id="handset-receive-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-handset-receive-wrapper" style="margin-top:-27px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType" style="float:left; margin-left:20px;">
                        <select name="search-by-all" id="search-by-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>
                            <option value="RequestID">Request ID</option>
                                                     
                        </select>
                    </div>
                  
                     <div id="date-ime-code-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-handset-receive-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-handset-receive-bystore" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                  <br /><br /><br />
                <div style="clear:both"></div>
                <div id="handset-receive-byCorStore-list" style="width:100%;float:left;display:none"></div>
            </div> 
            
            
             <div style="clear:both"></div>
             <div id="store-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-handset-report-wrapper" style="margin-top:-80px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType2" style="float:left; margin-left:20px;">
                        <select name="search-by-all-2" id="search-by-all-2" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date1" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI1">IMEI</option>
                            <option value="RequestID1">Request ID</option>
                                                     
                        </select>
                    </div> 

                     <div id="ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                        <div class="input" style="float:left;"> 
                            <input id="imeno" class="inputs" type="text"  style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                        </div>
                  
                    </div> 
                      <div class="btn-handset-report-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                 <br />  <br />
                <div style="clear:both"></div>
                <div id="handset-report-list" style="width:100%;margin-left:5px;display:none"></div>
            </div> 
            
    </div>
</div>
</asp:Content>
