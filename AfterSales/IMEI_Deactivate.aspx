<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IMEI_Deactivate.aspx.cs" Inherits="WSMS.IMEI_Deactivate" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/IMEIRecommendMonitoring.ascx" TagName="IMEIRecommendMonitoring" TagPrefix="uc2" %>
<%@ Register Src="~/Module/DeclinedFinalPhase.ascx" TagName="DeclinedFinalPhase"  TagPrefix="uc3" %>

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
                    content: 'Please wait loading  job for Recommend.....'
                });
                LoadIMEIRecommend(UserID);
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

                    //CurrentTabID = $("#" + $(this).parent().attr('id') + " .active-tab > #hfTabID").val();
                    CurrentTabID = $(".active-tab").children("#hfTabID").val();
                    $("#hfCurrentTabID").attr("value", CurrentTabID);
                }
            });


            $("#recommend-request").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#parameter-recommend-job').val('');
                $('#search-by-all').val('0');
                LoadIMEIRecommend(UserID);
            });

            $("#report").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-plaza-report-job').val('');
                $('#search-by-all-1').val('0');

                LoadMonitoringAndMarkettingReport(UserID);
            });

              $("#declined-request").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading declined data.....'
                });

                $('#parameter-declined-request-job9').val('');
                $('#search-by-all9').val('0');

                LoadDeclinedIMEIRequest(UserID);

            });


            function HideAll() {
                $("#recommend-IMEI-service").css("display", "none");
                $("#search-IMEI-recommend-wrapper").css("display", "none");

                $("#plaza-report-list").css("display", "none");
                $("#search-plaza-report-wrapper").css("display", "none");

                 $("#declined-request-list9").css("display", "none");
                $("#search-declined-request-wrapper9").css("display", "none");
            }

            $("#service-detail").live('click', function () {
                $(this).parent().children("#service-detail-hide").css("display", "block");
                $(this).css("display", "none");


                $(this).parent().parent().parent().children("#replacement-IMEI-problem").css("display", "block");
                //$(this).parent().parent().parent().children("#notified-service-requisition").css("display", "block");
             

            });

            $("#service-detail-hide").live('click', function () {
                $(this).parent().children("#service-detail").css("display", "block");
                $(this).css("display", "none");

                $(this).parent().parent().parent().children("#replacement-IMEI-problem").css("display", "none");
                //$(this).parent().parent().parent().children("#notified-service-requisition").css("display", "none");

                
            });


            function LoadIMEIRecommend(UserID, SearchByDate) {
                $.ajax({
                    type: "POST",
                    url: "IMEI_Deactivate.aspx/LoadIMEIRecommend",
                    data: "{ UserID: '" + UserID
                    + "' , SearchByDate: '" + SearchByDate
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#recommend-IMEI-service").html(msg.d);
                            $("#recommend-IMEI-service").css("display", "block");
                            $("#search-IMEI-recommend-wrapper").css("display", "block");

                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                                //alert("No Records Found or Please put Correct Parameter.");
                                alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date",                                                                       
                                             }).show();
                            }

                        }
                        else {
                            //alert("err");
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

            function LoadMonitoringAndMarkettingReport(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEI_Deactivate.aspx/LoadMonitoringAndMarkettingReport",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#plaza-report-list").html(msg.d);
                            $("#plaza-report-list").css("display", "block");
                            $("#search-plaza-report-wrapper").css("display", "block");
                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                                //alert("No Records Found or Please put Correct Parameter.");
                                alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date/Party Code.",                                                                       
                                             }).show();
                            }

                        }
                        else {
                            //alert("err");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "err",                                                                       
                                             }).show();
                            $.msg('unblock', 30, 1);

                            //  $("#active-message").css("display", "block");
                        }
                    },
                    error: function (msg) {
                        $.msg('unblock', 30, 1);
                    }
                });
            }


            $(".btn-IMEI-recommend-search").live('click', function () {

                var SearchByDate1 = $("#search-by-all").val();

                var parameter1 = $("#parameter-recommend-job").val().trim();
                // alert(parameter1);
                 if (SearchByDate1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select Service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (parameter1.length == 0) {
                    //alert("Please put currect parameter value");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();
                    $("#parameter-recommend-job").focus();
                    return -1;
                }
                else {

                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading Recommended service .....'
                    });
                    LoadIMEIRecommend(UserID, SearchByDate1 + ";" + parameter1);
                }
            });



            function InsertReplacementLogInsertApprovelMasterUpdateMaster(RequestID, IMEI_1, IMEI_2, Model, RegistrationDate, DistributionDate, AddedBy, RequestStatus, RequestType) {
                $.ajax({
                    type: "POST",
                    url: "IMEI_Deactivate.aspx/InsertReplacementLogInsertApprovelMasterUpdateMaster",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', Model: '" + Model
                                + "', RegistrationDate: '" + RegistrationDate
                                + "', DistributionDate: '" + DistributionDate
                                + "', AddedBy: '" + AddedBy
                                + "', RequestStatus: '" + RequestStatus
                                + "', RequestType: '" + RequestType
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                           // alert("Data Approved Successfully");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Approved Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading data ...'
                            });

                            LoadIMEIRecommend(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


            $("#btn-recommend-IMRI").live('click', function () {

                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();
                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                //var dealername = $(this).parent().parent().children("#regdate").children(".DealerName").val();


                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();
                var requesttype = $(this).parent().parent().children("#regdate").children(".hfRequestType").val();
                var requestStatus = $(this).parent().parent().children("#regdate").children(".hfRequestStatus").val();
                
                //alert(requestStatus);

                var addedBy = UserID;
                // var issue = $(this).parent().parent().children("#issues").children("#item-list").children("#ddlissue").find(":selected").text();
                // var cellphoneNumber = $(this).parent().parent().children("#cellphone").children("#input-cellnumber").val();

//                var requestStatus = 'Approved';
                

//                InsertReplacementLogInsertApprovelMasterUpdateMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, requestStatus, requesttype);

//                LoadIMEIRecommend(UserID);

                if (requestStatus == "PrimaryRecommended") {
                    requestStatus = "Approved";
                    InsertReplacementLogInsertApprovelMasterUpdateMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, requestStatus, requesttype);

                    LoadIMEIRecommend(UserID);
                }
                else if (requestStatus == "Recommended") { // Smart Phone
                    requestStatus = "Approved";
                    InsertReplacementLogInsertApprovelMasterUpdateMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, requestStatus, requesttype);

                    LoadIMEIRecommend(UserID);
                }
                else if (requestStatus == "ServiceRequested") { // Smart Phone
                    requestStatus = "ServiceApproved";
                    InsertReplacementLogInsertApprovelMasterUpdateMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, requestStatus, requesttype);

                    LoadIMEIRecommend(UserID);
                }


            });

            ///////////////////////////////


            function InsertDeclineReplacementLogUpdateMaster(RequestID, IMEI_1, IMEI_2, Model, RegistrationDate, DistributionDate, AddedBy, RequestStatus, AppDeclinedRemarks) {
                $.ajax({
                    type: "POST",
                    url: "IMEI_Deactivate.aspx/InsertDeclineReplacementLogUpdateMaster",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', Model: '" + Model
                                + "', RegistrationDate: '" + RegistrationDate
                                + "', DistributionDate: '" + DistributionDate
                                + "', AddedBy: '" + AddedBy
                                + "', RequestStatus: '" + RequestStatus
                                + "', AppDeclinedRemarks: '" + AppDeclinedRemarks
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                            //alert("Data Declined Successfully");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Declined Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading data ...'
                            });

                            LoadIMEIRecommend(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


            $("#btn-declined-IMRI").live('click', function () {



                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();
                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                //var dealername = $(this).parent().parent().children("#regdate").children(".DealerName").val();


                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();
                // var requesttype = $(this).parent().parent().children("#regdate").children(".hfRequestType").val();

                // var issue = $(this).parent().parent().children("#issues").children("#item-list").children("#ddlissue").find(":selected").text();
                var appDeclinedRemarks = $(this).parent().parent().children("#decline-reason").children("#decline-reason-input").val();
                var addedBy = UserID;
                var requestStatus = $(this).parent().parent().children("#regdate").children(".hfRequestStatus").val(); 
               // alert(requestStatus);

                 if (appDeclinedRemarks.length == 0) {
                    $.msg('unblock', 30, 1);
                   // alert("Reason required");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please mention decline reason.",                                                                       
                                             }).show();
                    IsValid = false;
                    return -1;
                }


                if (requestStatus == "PrimaryRecommended") {
                    requestStatus = "Approved Declined";
                    InsertDeclineReplacementLogUpdateMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, requestStatus, appDeclinedRemarks);
                    LoadIMEIRecommend(UserID);
                }
                else if (requestStatus == "Recommended") { // Smart Phone
                    requestStatus = "Approved Declined";
                    InsertDeclineReplacementLogUpdateMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, requestStatus, appDeclinedRemarks);
                    LoadIMEIRecommend(UserID);
                }
                else if (requestStatus == "ServiceRequested") { // Smart Phone
                    requestStatus = "ServiceDeclined";
                    InsertDeclineReplacementLogUpdateMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, requestStatus, appDeclinedRemarks);
                    LoadIMEIRecommend(UserID);
                }



//                InsertDeclineReplacementLogUpdateMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, requestStatus, appDeclinedRemarks);

//                LoadIMEIRecommend(UserID);

            });
            $(".btn-plaza-report-search").live('click', function () {

                var SearchBy1 = $("#search-by-all-1").val();
                //alert(SearchBy1);
                var parameter = $("#parameter-plaza-report-job").val().trim();
                //alert(parameter);
                 if (SearchBy1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select Service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (parameter.length == 0) {
                    //alert("Please put currect parameter value");
                    alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();
                    $("#parameter-plaza-report-job").focus();
                    return -1;
                }
                else {

                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading service .....'
                    });
                    LoadMonitoringAndMarkettingReport(UserID, SearchBy1 + ";" + parameter);
                }
            });


             function LoadDeclinedIMEIRequest(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEI_Deactivate.aspx/LoadDeclinedIMEIRequest",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {

                            HideAll();
                            $("#declined-request-list9").html(msg.d);
                            $("#declined-request-list9").css("display", "block");

                            $("#search-declined-request-wrapper9").css("display", "block");

                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {
                                //alert("No Records Found or Please put Correct Parameter.");
                                 alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date/Party Code.",                                                                       
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

             $(".btn-declined-request-search9").live('click', function () {

                var searchby1 = $("#search-by-all9").val();
                //alert(searchby1);
                var parameter1 = $("#parameter-declined-request-job9").val().trim();
                //alert(parameter1);

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
                   // alert("Please put currect parameter value");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();
                    $("#parameter-declined-request-job9").focus();
                    return -1;
                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading declined list .....'
                    });
                    LoadDeclinedIMEIRequest(UserID, searchby1 + ";" + parameter1);
                }
            });
                 function InsertManagementApprovalLog(RequestID, IMEI_1, IMEI_2, Model, RegistrationDate, DistributionDate, WarehouseDeclinedDate, ManagementStatus, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEI_Deactivate.aspx/InsertManagementApprovalLog",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', Model: '" + Model
                                + "', RegistrationDate: '" + RegistrationDate
                                + "', DistributionDate: '" + DistributionDate
                                + "', WarehouseDeclinedDate: '" + WarehouseDeclinedDate
                                + "', ManagementStatus: '" + ManagementStatus
                                + "', AddedBy: '" + AddedBy
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                           // alert("Data Save Successfully");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Saved Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading data ...'
                            });

                            LoadDeclinedIMEIRequest(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }
            $("#btn-receive").live('click', function () {

                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();
                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode1").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();

                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();
                var whdeclineDate = $(this).parent().parent().children("#regdate").children(".hfwhDeclineDate").val();

                var managementStatus = 'ManagementApproved';
                var addedBy = UserID;

//                var val = confirm("Are you sure want to Approve the request ??");
//                if (val)
                InsertManagementApprovalLog(requestId, barcode1, barcode2, model, registration, distribution, whdeclineDate, managementStatus, addedBy);



            });

            $("#btn-decline").live('click', function () {

                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();
                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode1").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();

                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();
                var whdeclineDate = $(this).parent().parent().children("#regdate").children(".hfwhDeclineDate").val();

                var managementStatus = 'ManagementDeclined';
                var addedBy = UserID;

//                var val = confirm("Are you sure want to decline the request ??");
//                if (val)
                InsertManagementApprovalLog(requestId, barcode1, barcode2, model, registration, distribution, whdeclineDate, managementStatus, addedBy);



            });


        });

        function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

 <div style="width:100%;border:0px solid red;float:left;">
        <div id="tab-content" style="width:100%;height:30px;border:0px solid red;float:left">
            <div class=" tab-item active-tab" id="recommend-request" style="width:200px">
                Approve Request
            </div>
            <div class="tab tab-item" id="report">
                Report
            </div>
             <div class="tab tab-item" id="declined-request" style="width:200px;">
               W.Declined Request
            </div>
        </div>
    <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;padding-top:20px;overflow:auto;padding-bottom:20px;">
          <div id="IMEI-recommend-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-IMEI-recommend-wrapper" style="margin-bottom:20px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType" style="float:left; margin-left:20px;">
                        <select name="search-by-all" id="search-by-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>
                            <%--<option value="Top">Top 100</option>--%>
                           
                           
                        </select>
                    </div>
                  
                     <div id="ime-date-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                        <%--<div class="input" style="float:left;"> 
                            <input id="imeno" class="inputs" type="text"  style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase" />
                        </div>--%>
                      
                           <div style="float:left">
                        <input type="text" id="parameter-recommend-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-IMEI-recommend-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="recommend-IMEI-service" style="width:100%;float:left;display:block"></div>
            </div>   
            
            <div style="clear:both"></div>
             <div id="plaza-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-plaza-report-wrapper" style="margin-top:-60px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType1" style="float:left; margin-left:20px;">
                        <select name="search-by-all-1" id="search-by-all-1" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>      
                            <option value="DealerCode">Party Code</option>                                         
                        </select>
                    </div>
                  
                     <div id="date-ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-plaza-report-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-plaza-report-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="plaza-report-list" style="width:100%;float:left;display:block"></div>
            </div>    
            
            <div style="clear:both"></div>
            <div id="declined-request-wrapper9" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 20px; border: 0px solid red ;display:block;">
                <div id="search-declined-request-wrapper9" style="margin-top:-150px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType19" style="float:left; margin-left:20px;">
                        <select name="search-by-all9" id="search-by-all9" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>      
                            <option value="DealerCode">Party Code</option>                                         
                        </select>
                    </div>
                     <div id="date-ime-code-search9" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-declined-request-job9" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-declined-request-search9" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="declined-request-list9" style="width:100%;float:left;display:block"></div>
            </div>       
               
   </div>
</div>

</asp:Content>
