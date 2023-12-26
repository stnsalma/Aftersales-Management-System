<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IMEIPrimaryRecommend.aspx.cs" Inherits="WSMS.IMEIPrimaryRecommend" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/PrimaryRecommend.ascx" TagName="PrimaryRecommend"  TagPrefix="uc2" %>

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
    <script src="Scripts/alertifyjs/alertify.js"></script>

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
                    content: 'Please wait loading Primary Recommend job.....'
                });
                LoadIMEIPrimaryRecommend(UserID);
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


            $("#primary-recom").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#parameter-primary-recommend-job').val('');
                $('#search-by-all').val('0');
                LoadIMEIPrimaryRecommend(UserID);
            });

            $("#special-tab").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#imeno').val('');
                $('#search-by-all-special').val('0');
                LoadNewSpecialRequest(UserID);
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

                LoadMonitorReport(UserID);
            });


            function HideAll() {
                $("#primary-recommend-IMEI-service").css("display", "none");
                $("#search-IMEI-primary-recom-wrapper").css("display", "none");

                $("#plaza-report-list").css("display", "none");
                $("#search-plaza-report-wrapper").css("display", "none");

                $("#special-list").css("display", "none");

                $("#search-special-wrapper").css("display", "none");
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
            ///////imei no search///
            var imePrev;
            var imereg = "";
            $(document).on("focusout", "#imeno", function () {
                var IMENo = $("#imeno").val().trim().toUpperCase();

                if (IMENo.length > 0) {
                    if (IMENo != imePrev) {
                        imePrev = IMENo;
                        //  if (IMENo === "URIMEI") {

                        GetIMEReg(IMENo);

                    }

                }
                else {
                   // alert("Enter IME to get data..");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter IME to get data..",                                                                       
                                             }).show();
                    $("#img-verified").css('display', 'none');

                    $("#img-verifying").css('display', 'none');
                    $("#img-err").css('display', 'none');
                }

            });

            function GetIMEReg(IMENo) {


                //   $("#msg-invalid").css('display', 'none');
                //   $("#msg-notreg").css('display', 'none');

                $("#img-verified").css('display', 'none');
                $("#img-err").css('display', 'none');
                $('#img-verifying').css("display", "block");


                $.ajax({
                    type: "POST",
                    url: "IMEIPrimaryRecommend.aspx/GetIMEReg",
                    data: "{ IMENo: '" + IMENo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "invalid") {
                           // alert("Invalid IME .. Please put currect IME");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Invalid IME .. Please put currect IME",                                                                       
                                             }).show();

                            $("#msg").css("display", "block");
                            $("#img-verifying").css('display', 'none');
                            $("#img-err").css('display', 'block');
                            $("#msg-invalid").css('display', 'block');


                        }
                        else {

                            $("#img-verified").css('display', 'block');

                            $("#img-verifying").css('display', 'none');
                            $("#img-err").css('display', 'none');
                        }
                    }
                });

            }

            ///////////////////

            function LoadIMEIPrimaryRecommend(UserID, SearchByDate) {
                $.ajax({
                    type: "POST",
                    url: "IMEIPrimaryRecommend.aspx/LoadIMEIPrimaryRecommend",
                    data: "{ UserID: '" + UserID
                    + "' , SearchByDate: '" + SearchByDate
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#primary-recommend-IMEI-service").html(msg.d);
                            $("#primary-recommend-IMEI-service").css("display", "block");

                            $("#search-IMEI-primary-recom-wrapper").css("display", "block");
                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                                //alert("No Records Found.");
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

            function LoadNewSpecialRequest(UserID, SearchByDate) {
                $.ajax({
                    type: "POST",
                    url: "IMEIPrimaryRecommend.aspx/LoadNewSpecialRequest",
                    data: "{ UserID: '" + UserID
                    + "' , SearchByDate: '" + SearchByDate
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#special-list").html(msg.d);
                            $("#special-list").css("display", "block");

                            $("#search-special-wrapper").css("display", "block");
                            // $("#active-message").css("display", "none");

//                            $.msg('unblock', 30, 1);

//                            if (msg.d == 0) {
//                                //alert("No Records Found.");
//                                 alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Please search by correct IMEI.",                                                                       
//                                             }).show();
//                            }

                            var searchvalue= $("#imeno").val();
                            $.msg('unblock', 30, 1);


                             if (msg.d == 0) {
                                                              
                                 GetRequestedIMEIStatus(searchvalue);

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

             function GetRequestedIMEIStatus(SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIPrimaryRecommend.aspx/GetRequestedIMEIStatus",
                    data: "{ SearchBy: '" + SearchBy + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {

                        if (msg.d == "success") {
                           alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "IMEI already requested.",                                                                                        
                                              }).show();
                      
                               
                        }
                        else{
                          
                         alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI.",                                                                                        
                                              }).show();
                        }
                    }
                });
            }


            function LoadMonitorReport(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIPrimaryRecommend.aspx/LoadMonitorReport",
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
                            // $("#active-message").css("display", "none");

                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                                //alert("No Records Found or Please put Correct Parameter.");
                                alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please search by correct IMEI/Date/Dealer Code.",                                                                       
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

            $(".btn-plaza-report-search").live('click', function () {

                var SearchBy1 = $("#search-by-all-1").val();
                //alert(SearchBy1);
                var parameter = $("#parameter-plaza-report-job").val().trim();
                //alert(parameter);

                 if (SearchBy1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select service type.",                                                                                        
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
                    LoadMonitorReport(UserID, SearchBy1 + ";" + parameter);
                }
            });


            $(".btn-IMEI-primary-recommend-search").live('click', function () {

                var SearchByDate1 = $("#search-by-all").val();

                var parameter = $("#parameter-primary-recommend-job").val().trim();

                 if (SearchByDate1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (parameter.length == 0) {
                   // alert("Please put currect parameter value");
                    alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();

                    $("#parameter-primary-recommend-job").focus();
                    return -1;
                }
                else {

                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading Primary Recommended service .....'
                    });
                    LoadIMEIPrimaryRecommend(UserID, SearchByDate1 + ";" + parameter);
                }
            });

//            $(".btn-special-search").live('click', function () {


//                alert('hhhhhhhhhhhhhhhhh');

//                var searchbydate1 = $("#search-by-all-special").val();
//                alert(searchbydate1);
//                var parameter1 = $("#imeno").val().trim();

//                if (parameter1.length == 0) {
//                    alert("Please put currect parameter value");
//                    $("#imeno").focus();
//                    return -1;
//                }
//                else {
//                    //$("#ddlmodel option:selected").text().trim();
//                    $.msg({
//                        msgID: 1,
//                        autoUnblock: false,
//                        clickUnblock: false,
//                        content: 'Please wait loading data .....'
//                    });


//                    LoadNewSpecialRequest(UserID, searchbydate1 + ";" + parameter1);


//                }
//            });

            $(".btn-special-search").live('click', function () {

                var SearchByDate1 = $("#search-by-all-special").val();

                var parameter = $("#imeno").val().trim();

                 if (SearchByDate1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (parameter.length == 0) {
                   // alert("Please put currect parameter value");
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
                        content: 'Please wait loading data .....'
                    });
                    LoadNewSpecialRequest(UserID, SearchByDate1 + ";" + parameter);
                }
            });

            function InsertPrimaryRecomLogUpdateIMEIReplacementMaster(RequestID, IMEI_1, IMEI_2, Model, RegistrationDate, DistributionDate, AddedBy, PrimaryRecomStatus) {
                $.ajax({
                    type: "POST",
                    url: "IMEIPrimaryRecommend.aspx/InsertPrimaryRecomLogUpdateIMEIReplacementMaster",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', Model: '" + Model
                                + "', RegistrationDate: '" + RegistrationDate
                                + "', DistributionDate: '" + DistributionDate
                                + "', AddedBy: '" + AddedBy
                                + "', PrimaryRecomStatus: '" + PrimaryRecomStatus
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                            //alert("Data Primary Recommended Successfully");
                              alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Primary Recommended Successfully",                                                                       
                                             }).show();
                         
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading Primary Recommended data ...'
                            });

                            LoadIMEIPrimaryRecommend(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


            $("#btn-primary-recommend-IMRI").live('click', function () {


                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();
                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();

                var primaryRecomStatus = 'PrimaryRecommended';
                var addedBy = UserID;

                //                var val = confirm("Are you sure want to recommend the request ??");
                //                if (val)

                    InsertPrimaryRecomLogUpdateIMEIReplacementMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, primaryRecomStatus);
                

            });

            function InsertDeclinePrimaryRecomLogUpdateIMEIReplacementMaster(RequestID, IMEI_1, IMEI_2, Model, RegistrationDate, DistributionDate, AddedBy, PrimaryRecomStatus) {
                $.ajax({
                    type: "POST",
                    url: "IMEIPrimaryRecommend.aspx/InsertDeclinePrimaryRecomLogUpdateIMEIReplacementMaster",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', Model: '" + Model
                                + "', RegistrationDate: '" + RegistrationDate
                                + "', DistributionDate: '" + DistributionDate
                                + "', AddedBy: '" + AddedBy
                                + "', PrimaryRecomStatus: '" + PrimaryRecomStatus
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                           // alert("Data Decline Successfully");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Decline Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading Primary Recommended data ...'
                            });

                            LoadIMEIPrimaryRecommend(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }

            $("#btn-primary-declined-IMRI").live('click', function () {


                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();
                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();

                var primaryRecomStatus = 'PrimaryDecline';
                var addedBy = UserID;


                //                var val = confirm("Are you sure want to recommend the request ??");
                //                if (val)
                InsertDeclinePrimaryRecomLogUpdateIMEIReplacementMaster(requestId, barcode1, barcode2, model, registration, distribution, addedBy, primaryRecomStatus);



            });


            function InsertIMEIReplacementMasterTable(IMEI_1, IMEI_2, Model, DealerCode, RequestType, RegistrationDate, DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, ReplaceIMEI_1, ReplaceIMEI_2, ReplaceModel, RequestStatus, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIPrimaryRecommend.aspx/InsertIMEIReplacementMasterTable",
                    data: "{ IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', Model: '" + Model
                                + "', DealerCode: '" + DealerCode
                                + "', RequestType: '" + RequestType
                                + "', RegistrationDate: '" + RegistrationDate
                                + "', DistributionDate: '" + DistributionDate
                                + "', Issues: '" + Issues
                                + "', PhoneNumber: '" + PhoneNumber

                                + "', IssueDetails: '" + IssueDetails
                                + "', IsSeen: '" + IsSeen
                                + "', ReplaceIMEI_1: '" + ReplaceIMEI_1
                                + "', ReplaceIMEI_2: '" + ReplaceIMEI_2
                                + "', ReplaceModel: '" + ReplaceModel

                                + "', RequestStatus: '" + RequestStatus
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
                                                  'message': "Data Requested Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading Request data ...'
                            });

                            LoadNewSpecialRequest(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


            $("#btn-request-IMRI-1").live('click', function () {


                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                var dealercode = $(this).parent().parent().children("#regdate").children(".hfDealerCode").val();
                var requestType = $("#search-by-all-special").val();


                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();

                var issue = $(this).parent().parent().children("#issues").children("#item-list").children("#ddlissue").find(":selected").text();
                var cellphoneNumber = $(this).parent().parent().children("#cellphone").children("#input-cellnumber").val();
                var issueDetails = $(this).parent().parent().children("#details").children("#input-details-issues").val();

                var seenStatus = $(this).parent().parent().children("#seen_or_not").children("#seen-status").find(":selected").text();

                var repIMEI1 = $(this).parent().parent().children("#rep_imei_1").children("#insert_rep_imei_1").val();
                var repIMEI2 = $(this).parent().parent().children("#rep_imei_2").children("#insert_rep_imei_2").val();
                var repModel = $(this).parent().parent().children("#rep_model").children("#rep_model_list").children("#ddlmodel").find(":selected").text();



                var requestStatus = 'Requested';
                var addedBy = UserID;



                if (isNaN(cellphoneNumber) || cellphoneNumber.indexOf(" ") != -1) {
                   // alert("Enter numeric value");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter numeric value for Cellphone Number",                                                                       
                                             }).show();
                    return false;
                }
                else if (cellphoneNumber.length != 11) {
                   // alert("Enter 11 characters");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter 11 characters for Cellphone Number",                                                                       
                                             }).show();
                    return false;
                }
                else if (cellphoneNumber.charAt(0) != "0") {
                    //alert("Cellphone Number should start with 0 ");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Cellphone Number should start with 0",                                                                       
                                             }).show();
                    return false
                }


                if (issue == "-- Select Problem --") {
                    //alert("Customer Issues required");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Customer Issues required",                                                                       
                                             }).show();
                    IsValid = false;
                    return -1;
                }
                if (issueDetails.length <= 20) {
                   // alert("Enter minimum 20 characters");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter minimum 20 characters for Remarks",                                                                       
                                             }).show();
                    return false;
                }

                if (seenStatus == "------- Select Status-------") {
                    //alert("Select Seen Status");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Select Seen Status",                                                                       
                                             }).show();
                    return false;
                }
                //                if (repIMEI1.length == 0) {

                //                    alert("Enter Replacement IMEI_1");
                //                    return false;
                //                }
                //                if (repIMEI2.length == 0) {

                //                    alert("Enter Replacement IMEI_2");
                //                    return false;
                //                }
                //                if (repModel == "-------- Select Model --------") {

                //                    alert("Enter Replacement Model");
                //                    return false;
                //                }

                var isOK = false;

                if (requestType == "special") { // Special case

                    requestType = "Special Case";

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);

                    isOK = true;

                }

                else if (requestType == "RegisterednotRegisteredDisplay") { // Smart Phone

                    requestType = "Display";

                   
                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


                    isOK = true;

                }

            });





        });
        //////////////////////////////////////////
        function preventBack() { window.history.forward(1); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
        //////////////////////////////////////////////
</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div style="width:100%;border:0px solid red;float:left;">
        <div id="tab-content" style="width:100%;height:30px;border:0px solid red;float:left">
            <div class=" tab-item active-tab" id="primary-recom" style="width:200px;">
                Primary Recommend
            </div>
             <div class="tab tab-item" id="special-tab" style="width:200px;">
                Special Request
            </div>
           <div class="tab tab-item" id="report">
                Report
            </div>
        </div>
        
    <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;padding-top:20px;overflow:auto;padding-bottom:20px;">
        
          <div id="primary-recom-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-IMEI-primary-recom-wrapper" style="margin-top:-27px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType" style="float:left; margin-left:20px;">
                        <select name="search-by-all" id="search-by-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>
                            <option value="DealerCode">Party Code</option>
                                                     
                        </select>
                    </div>
                  
                     <div id="date-ime-code-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-primary-recommend-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-IMEI-primary-recommend-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                  <br /><br /><br />
                <div style="clear:both"></div>
                <div id="primary-recommend-IMEI-service" style="width:100%;float:left;display:none"></div>
            </div> 
            
            
             <div style="clear:both"></div>
             <div id="special-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-special-wrapper" style="margin-top:-40px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType3" style="float:left; margin-left:20px;">
                        <select name="search-by-all-special" id="search-by-all-special" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;"> 
                             <option value="0" >----------- Service Type -----------</option>
                             <option value="special" >Special Case</option>   
                             <option value="RegisterednotRegisteredDisplay">Display</option>                                                                
                        </select>
                    </div>
                  
                   

                     <div id="ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">IMEI Number : </div>
                        <div class="input" style="float:left;"> 
                            <input id="imeno" class="inputs" type="text"  style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                        </div>
                       <%-- <div style="width:100px;">--%>
                            <img id="img-err" src="Styles/image/close_pop.png" style="padding-top:45px; display:none;border:0px solid red" />
                            <img id="img-verifying" src="Styles/image/ajax-loader.gif" style="padding-top:45px; display:none;border:0px solid red">
                            <img id="img-verified" src="Styles/image/save.png" style="padding-top:45px; display:none;border:0px solid red">
                        <%--</div>--%>
                                       
                    </div> 


                   <%-- <div class="btn-special-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;">
                         SEARCH 
                    </div>--%>
                      <div class="btn-special-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                 <br />  <br />
                <div style="clear:both"></div>
                <div id="special-list" style="width:100%;margin-left:5px;display:none"></div>
            </div> 
            
            
              
             <div style="clear:both"></div>
             <div id="plaza-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top:0px; border: 0px solid red ;display:block;">
                <div id="search-plaza-report-wrapper" style="margin-top:-84px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType1" style="float:left; margin-left:20px;">
                        <select name="search-by-all-1" id="search-by-all-1" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option> 
                            <option value="DealerCode">Dealer Code</option>                                                
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
            <br /> <br /><br />
                <div style="clear:both"></div>
                <div id="plaza-report-list" style="width:100%;float:left;display:block"></div>
            </div>                   
   </div>
 </div>

</asp:Content>
