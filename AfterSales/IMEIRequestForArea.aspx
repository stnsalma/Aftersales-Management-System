<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IMEIRequestForArea.aspx.cs" Inherits="WSMS.IMEIRequestForArea" %>

<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/AreaIMEIRequest.ascx" TagName="AreaIMEIRequest"  TagPrefix="uc2" %>

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

   <%--for  alert--%>
    <link href="Scripts/alertifyjs/css/alertify.css" rel="stylesheet" />
   <script src="Scripts/alertifyjs/alertify.js"></script>
  
    <%--new new--%>

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
                LoadNewIMEIRequest(UserID);
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


            $("#new-request").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#imeno').val('');

                $('#search-by-all').val('0');
                LoadNewIMEIRequest(UserID);
              
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

                LoadPlazaReport(UserID);
            });



            $("#stockfaulty-tab").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-stockfaulty-job').val('');
                $('#search-by-all-2').val('0');
                LoadNewStockFaultyRequest(UserID);
            });
            $("#stock-recon").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-area-stockRecon-job').val('');
                $('#search-by-stockRecon').val('0');

                LoadAreaStockReconciliation(UserID);
            });
            
            $("#display-entry").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-display-entry-job').val('');

                LoadDisplayEntry(UserID);
            });

            function HideAll() {
                $("#request-IMEI-service").css("display", "none");
                $("#search-IMEI-request-wrapper").css("display", "none");

                $("#stock-faulty-list").css("display", "none");
                $("#search-stock-faulty-wrapper").css("display", "none");

                $("#plaza-report-list").css("display", "none");
                $("#search-plaza-report-wrapper").css("display", "none");
                $("#search-stockRecon-IMEI-wrapper").css("display", "none");
                $("#area-stockRecon-list").css("display", "none");
                
                $("#display-entry-list").css("display", "none");
                $("#search-display-IMEI-wrapper").css("display", "none");
            }


            function LoadNewIMEIRequest(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadNewIMEIRequest",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#request-IMEI-service").html(msg.d);
                            $("#request-IMEI-service").css("display", "block");
                            $("#search-IMEI-request-wrapper").css("display", "block");
                            $("#saveId_0").css("display", "none");
                            //var requestType = $("#search-by-all").val();
                            //if (requestType == "stock") { // Stock faulty

                                                

                            //    $("#insert_rep_imei_1").attr('disabled', 'disabled');
                            //    $("#insert_rep_imei_2").attr('disabled', 'disabled');
                            //    $("#rep_model_list").attr('disabled', 'disabled');
                            //    $("#ddlmodel").attr('disabled', 'disabled');


                            //}

                            //var searchvalue= $("#imeno").val();
                            //$.msg('unblock', 30, 1);


                            // if (msg.d == 0) {
                                                              
                            //     GetRequestedIMEIStatus(searchvalue);

                            //}
                            
                            var searchvalue = $("#imeno").val();

                            var requestedValue = $("#search-by-all").val();
                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {

                                GetRequestedIMEIStatus(searchvalue, requestedValue);

                            }

                        }
                        else {
                        
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


            function LoadNewStockFaultyRequest(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadNewStockFaultyRequest",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#stock-faulty-list").html(msg.d);
                            $("#stock-faulty-list").css("display", "block");
                            $("#saveId_0").css("display", "none");
                            $("#search-stock-faulty-wrapper").css("display", "block");
                            // $("#active-message").css("display", "none");

                            //var searchvalue= $("#parameter-stockfaulty-job").val();
                            //$.msg('unblock', 30, 1);


                            // if (msg.d == 0) {
                                                              
                            //     GetRequestedIMEIStatus(searchvalue);

                            //}

                            var searchvalue = $("#parameter-stockfaulty-job").val();

                            var requestedValue = $("#search-by-all-2").val();
                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {

                                GetRequestedIMEIStatusforStockfaulty(searchvalue, requestedValue);

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

                            //  $("#active-message").css("display", "block");
                        }
                    },
                    error: function (msg) {
                        $.msg('unblock', 30, 1);
                    }
                });
            }

            function LoadPlazaReport(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadPlazaReport",
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
                            $("#saveId_0").css("display", "none");
                            $("#search-plaza-report-wrapper").css("display", "block");
                            // $("#active-message").css("display", "none");

                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                               // alert("No Records Found.");

                                alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date/DealerCode.",
                                                 
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
            function LoadAreaStockReconciliation(UserID, SearchBy1) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadAreaStockReconciliation",
                    data: "{ UserID: '" + UserID
                      + "' , SearchBy1: '" + SearchBy1
                     + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {

                            HideAll();
                            $("#area-stockRecon-list").html(msg.d);
                            $("#area-stockRecon-list").css("display", "block");
                            $("#search-stockRecon-IMEI-wrapper").css("display", "block");
                           
                            //$("#saveId_1").css("display", "none");
                            $.msg('unblock', 30, 1);


                        }

                    },
                    error: function (msg) {
                        $.msg('unblock', 30, 1);
                    }
                });
            }
            
            function LoadDisplayEntry(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadDisplayEntry",
                    data: "{ UserID: '" + UserID
                     + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (msg) {
                        if (msg.d != "err") {

                            HideAll();
                            $("#display-entry-list").html(msg.d);
                            $("#display-entry-list").css("display", "block");
                            $("#search-display-IMEI-wrapper").css("display", "block");
                            //$("#saveId_1").css("display", "none");
                            $("#saveId_0").css("display", "none");
                            $.msg('unblock', 30, 1);
                            if (msg.d == 0) {

                                alertify.dialog('alert').set({
                                    'title': '   ',
                                    'transition': 'zoom',
                                    'message': "Please Search by correct IMEI.",
                                }).show();
                            }

                            var dName = $("#d_name").text().trim();
                          
                            var isdisplayChk;
                            isdisplayChk = $('input:checkbox:checked').map(function () {
                                return this.value;
                            }).get();

                          
                            if (dName.length == 0) {
                              
                                $("#displaycheckTick").attr("checked", false);
                            }
                            else {
                           
                                $("#displaycheckTick").attr("checked", true);
                            }
                            
                            var searchvalue = $("#parameter-display-entry-job").val();
                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {

                                GetRequestedIMEIStatusIntblDisplayProduct(searchvalue);

                            }

                        }
                        else {

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

            $(document).on("focusout", "#parameter-stockfaulty-job", function () {
                var IMENo = $("#parameter-stockfaulty-job").val().trim().toUpperCase();

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

                $("#img-verified").css('display', 'none');
                $("#img-err").css('display', 'none');
                $('#img-verifying').css("display", "block");

                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/GetIMEReg",
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

            $(".btn-IMEI-request-search").live('click', function () {

                var searchby1 = $("#search-by-all").val();
                //alert(searchby1);
                var parameter1 = $("#imeno").val().trim();
                //alert(parameter1);

                if (searchby1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select service type.",                                                                                        
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

                    $("#imeno").focus();
                    return -1;
                }
                else {
                    //$("#ddlmodel option:selected").text().trim();
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading new requisition service .....'
                    });
                    LoadNewIMEIRequest(UserID, searchby1 + ";" + parameter1);

                    /////////////////
                }
            });

             var repIMEI1; 
             var repIMEI2;
              var repModel; 
            // $("#btn-request-IMRI").live('click', function () {
            $("#btn-request-IMRI").live('click', function () {

                // alert(requestType);
                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                var dealercode = $(this).parent().parent().children("#regdate").children(".hfDealerCode").val();
                var requestType = $("#search-by-all").val();


                ///request type

                // var actionVal = $(this).parent().parent().children(".div-action-notify").children(".action-notify").find(":selected").val();
                //  var request = $(this).parent().parent().children("#div-requestType").children("#search-by-all").find(":selected").text();
                // var requestType;
                //  var requestType = $(this).parent().parent().children("#IMEI-request-wrapper").children("#search-IMEI-request-wrapper").children("#div-requestType").children("#search-by-all").find(":selected").text();
                //var requestType;
                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();
                ////request date
                // var issue = $(this).parent().parent().children("#issue-list").children("#ddlissue").find(":selected").text();
                // var issue = $(this).parent().parent().children("#issue-list").children("#ddlissue").find(":selected").text();

                var issue = $(this).parent().parent().children("#issues").children("#item-list").children("#ddlissue").find(":selected").text();
                var cellphoneNumber = $(this).parent().parent().children("#cellphone").children("#input-cellnumber").val();
                var issueDetails = $(this).parent().parent().children("#details").children("#input-details-issues").val();

                var seenStatus = $(this).parent().parent().children("#seen_or_not").children("#seen-status").find(":selected").text();

                 repIMEI1 = $(this).parent().parent().children("#rep_imei_1").children("#insert_rep_imei_1").val();
                 repIMEI2 = $(this).parent().parent().children("#rep_imei_2").children("#insert_rep_imei_2").val();
                 repModel = $(this).parent().parent().children("#rep_model").children("#rep_model_list").children("#ddlmodel").find(":selected").text();

                

                var requestStatus = 'Requested';
                var addedBy = UserID;



                //  if (cellphoneNumber.length == 0) {
                //$.msg('unblock', 30, 1);
                // alert("Customer Mobile required");       
                //  IsValid = false;
                //  return -1;
                // }

                if (isNaN(cellphoneNumber) || cellphoneNumber.indexOf(" ") != -1) {
                    //alert("Enter numeric value");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter numeric value for Cellphone number",                                                                                        
                                              }).show();

                    return false;
                }
                else if (cellphoneNumber.length != 11) {

                   // alert("Enter 11 characters");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter 11 characters for Cellphone number",                                                                                        
                                              }).show();
                    return false;
                }
                else if (cellphoneNumber.charAt(0) != "0") {
                  //  alert("It should start with 0 ");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Cellphone number should start with 0",                                                                                        
                                              }).show();

                    return false;
                }


                if (issue == "-- Select Problem --") {
                    //$.msg('unblock', 30, 1);
                   // alert("Customer Issues required");
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
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter Replacement IMEI_1",                                                                                        
//                                              }).show();

//                                    return false;
//                 }

//                  if (repModel == "-------- Select Model --------") {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter Replacement Model",                                                                                        
//                                              }).show();

//                                    return false;
//                 }

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
                // if (request > 0) {

                if (requestType == "smart") { // Smart Phone
                    // alert("hiiiiiii");
                    // if (issue > 0) {

                    //requestType = "SmartPhone-20Days";
                    requestType = "SmartPhone-15 Days";

                    //                    var val = confirm("Are you sure want to submit the request ??");
                    //                    if (val)

                     if (repIMEI1.length == 0) {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement IMEI_1",                                                                                        
                                              }).show();

                                    return false;
                 }

                  if (repModel == "-------- Select Model --------") {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement Model",                                                                                        
                                              }).show();

                                    return false;
                 }

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


                    isOK = true;
                    //                        }
                    //                        else
                    //                            alert("Please select Issue first..");
                }
                else if (requestType == "walpad") { // Walpad


                    //                        if (issue > 0) {

                    requestType = "Walpad-15 Days";
                    // requestType = "Walpad-20Days";

                    //                    var val = confirm("Are you sure want to submit the request ??");
                    //                    if (val)

                     if (repIMEI1.length == 0) {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement IMEI_1",                                                                                        
                                              }).show();

                                    return false;
                 }

                  if (repModel == "-------- Select Model --------") {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement Model",                                                                                        
                                              }).show();

                                    return false;
                 }

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


                    isOK = true;
                    //                        }
                    //                        else
                    //                            alert("Please select Issue first..");


                }
                else if (requestType == "feature") { // feature


                    // if (issue > 0) {

                    //requestType = "FeaturePhone-35Days";
                    requestType = "FeaturePhone-30 Days";

                    //                    var val = confirm("Are you sure want to submit the request ??");
                    //                    if (val)


                     if (repIMEI1.length == 0) {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement IMEI_1",                                                                                        
                                              }).show();

                                    return false;
                 }

                  if (repModel == "-------- Select Model --------") {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement Model",                                                                                        
                                              }).show();

                                    return false;
                 }

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


                    isOK = true;
                    //                        }
                    //                        else
                    //                            alert("Please select Issue first..");




                }
//                else if (requestType == "stock") { // Stock faulty

//                    requestType = "StockFaulty";

//                    //                    var val = confirm("Are you sure want to submit the request ??");
//                    //                    if (val)
//                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


//                    isOK = true;



//                }
//                else if (requestType == "registereddisplay") { // Stock faulty

//                    requestType = "Display";

//                    //                    var val = confirm("Are you sure want to submit the request ??");
//                    //                    if (val)
//                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


//                    isOK = true;



//                }

                else if (requestType == "reRequest") { // reRequest



                    requestType = "Re-Request";


                    //                    var val = confirm("Are you sure want to submit the request ??");
                    //                    if (val)


                     if (repIMEI1.length == 0) {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement IMEI_1",                                                                                        
                                              }).show();

                                    return false;
                 }

                  if (repModel == "-------- Select Model --------") {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement Model",                                                                                        
                                              }).show();

                                    return false;
                 }

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


                    isOK = true;


                }
                else if (requestType == "localMade") { // Local Made SmartPhone-30 Days
                   
                    requestType = "Local Made SmartPhone-30 Days";

                    if (repIMEI1.length == 0) {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Enter Replacement IMEI_1",
                        }).show();

                        return false;
                    }

                    if (repModel == "-------- Select Model --------") {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Enter Replacement Model",
                        }).show();

                        return false;
                    }

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);
                    isOK = true;

                }

                else if (requestType == "localMadeFeature") { // Local Made FeaturePhone-30 Days

                    requestType = "Local Made FeaturePhone-30 Days";

                    if (repIMEI1.length == 0) {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Enter Replacement IMEI_1",
                        }).show();

                        return false;
                    }

                    if (repModel == "-------- Select Model --------") {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Enter Replacement Model",
                        }).show();

                        return false;
                    }

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);
                    isOK = true;

                }

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
                    LoadPlazaReport(UserID, SearchBy1 + ";" + parameter);


                }
            });

            function InsertIMEIReplacementMasterTable(IMEI_1, IMEI_2, Model, DealerCode, RequestType, RegistrationDate, DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, ReplaceIMEI_1, ReplaceIMEI_2, ReplaceModel, RequestStatus, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/InsertIMEIReplacementMasterTable",
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

                            LoadNewIMEIRequest(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }

            function InsertIMEIReplacementMasterTable1(IMEI_1, IMEI_2, Model, DealerCode, RequestType, DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, RequestStatus, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/InsertIMEIReplacementMasterTable1",
                    data: "{ IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', Model: '" + Model
                                + "', DealerCode: '" + DealerCode
                                + "', RequestType: '" + RequestType
                                + "', DistributionDate: '" + DistributionDate
                                + "', Issues: '" + Issues
                                + "', PhoneNumber: '" + PhoneNumber

                                + "', IssueDetails: '" + IssueDetails
                                + "', IsSeen: '" + IsSeen
                    //                                + "', ReplaceIMEI_1: '" + ReplaceIMEI_1
                    //                                + "', ReplaceIMEI_2: '" + ReplaceIMEI_2
                    //                                + "', ReplaceModel: '" + ReplaceModel

                                + "', RequestStatus: '" + RequestStatus
                                + "', AddedBy: '" + AddedBy
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                           // alert("Data Requested Successfully");
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

                            LoadNewStockFaultyRequest(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


            $("#btn-request-stockfaulty").live('click', function () {

                var barcode1 = $(this).parent().parent().children("#distridate").children(".hfBarCode3").val();
                var barcode2 = $(this).parent().parent().children("#distridate").children(".hfBarCode33").val();
                var model = $(this).parent().parent().children("#distridate").children(".hfModel3").val();
                var dealercode = $(this).parent().parent().children("#distridate").children(".hfDealerCode3").val();
                var requestType = $("#search-by-all-2").val();



                var distribution = $(this).parent().parent().children("#distridate").children(".hfDistributionDate3").val();
                var issue = $(this).parent().parent().children("#issues1").children("#item-list").children("#ddlissue").find(":selected").text();
                var cellphoneNumber = $(this).parent().parent().children("#cellphone1").children("#input-cellnumber").val();

                var issueDetails = $(this).parent().parent().children("#details1").children("#input-details-issues1").val();
                var seenStatus = $(this).parent().parent().children("#seen_or_not1").children("#seen-status1").find(":selected").text();
                //                var repIMEI1 = $(this).parent().parent().children("#rep_imei_11").children("#insert_rep_imei_11").val();
                //                var repIMEI2 = $(this).parent().parent().children("#rep_imei_21").children("#insert_rep_imei_21").val();
                //                var repModel = $(this).parent().parent().children("#rep_model1").children("#rep_model_list1").children("#ddlmodel").find(":selected").text();


                var requestStatus = 'Requested';
                var addedBy = UserID;



                if (isNaN(cellphoneNumber) || cellphoneNumber.indexOf(" ") != -1) {
//                    alert("Enter numeric value")
                       alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter numeric value for Cellphone number",                                                                                        
                                              }).show();
                    return false;
                }
                else if (cellphoneNumber.length != 11) {

                   // alert("Enter 11 characters");
                       alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter 11 characters for Cellphone number",                                                                                        
                                              }).show();
                    return false;
                }
                else if (cellphoneNumber.charAt(0) != "0") {
                   // alert("It should start with 0 ");
                       alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Cellphone number should start with 0",                                                                                        
                                              }).show();
                    return false
                }


                if (issue == "-- Select Problem --") {

                   // alert("Customer Issues required");
                       alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Customer Issues required",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }

                if (issueDetails.length <= 20) {

                    //alert("Enter minimum 20 characters");
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


                if (requestType == "stockfaulty1") { // Smart Phone

                    requestType = "StockFaulty";

                    //                    var val = confirm("Are you sure want to submit the request ??");
                    //                    if (val)
                    InsertIMEIReplacementMasterTable1(barcode1, barcode2, model, dealercode, requestType, distribution, issue, cellphoneNumber, issueDetails, seenStatus, requestStatus, addedBy);


                    isOK = true;

                }
//                else if (requestType == "notRegisteredDisplay") { // Smart Phone

//                    requestType = "Display";

//                    //                    var val = confirm("Are you sure want to submit the request ??");
//                    //                    if (val)
//                    InsertIMEIReplacementMasterTable1(barcode1, barcode2, model, dealercode, requestType, distribution, issue, cellphoneNumber, issueDetails, seenStatus, requestStatus, addedBy);


//                    isOK = true;

//                }



            });



            $(".btn-stock-faulty-search").live('click', function () {

                var searchby1 = $("#search-by-all-2").val();
                //alert(searchby1);
                var parameter1 = $("#parameter-stockfaulty-job").val().trim();
                //alert(parameter1);

                if (searchby1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select service type.",                                                                                        
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
                    $("#parameter-stockfaulty-job").focus();
                    return -1;
                }
                else {
                    //$("#ddlmodel option:selected").text().trim();
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading new requisition service .....'
                    });
                    LoadNewStockFaultyRequest(UserID, searchby1 + ";" + parameter1);
                }
            });

            $(".btn-stockRecon-search").live('click', function () {

                var searchby = $("#parameter-stockRecon-job").children("#ddldealer").find(":selected").text().trim();
                var searchby1 = $("#parameter-stockRecon-job").children("#ddldealer").find(":selected").val().trim();
                //alert(searchby);
                //alert(searchby1);

                if (searchby == "---- Select Dealer Name ----") {

                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please select Dealer Name",
                    }).show();
                    $("#parameter-stockRecon-job").focus();
                    return -1;

                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading service .....'
                    });

                    LoadAreaStockReconciliation(UserID, searchby1);

                    $("#saveId_0").css("display", "block");

                }
                $("#saveId_0").css("display", "block");

            });
            
             //function GetRequestedIMEIStatus(SearchBy) {
             //   $.ajax({
             //       type: "POST",
             //       url: "IMEIRequestForArea.aspx/GetRequestedIMEIStatus",
             //       data: "{ SearchBy: '" + SearchBy + "'}",
             //       contentType: "application/json; charset=utf-8",
             //       dataType: "json",
             //       success: function (msg) {

             //           if (msg.d == "success") {
             //              alertify.dialog('alert').set({
             //                                     'title': '   ',
             //                                     'transition': 'zoom',
             //                                     'message': "IMEI already requested.",                                                                                        
             //                                 }).show();
                      
                               
             //           }
             //           else{
                          
             //            alertify.dialog('alert').set({
             //                                     'title': '   ',
             //                                     'transition': 'zoom',
             //                                     'message': "Please Search by correct IMEI.",                                                                                        
             //                                 }).show();
             //           }
             //       }
             //   });
            //}
            

            function LoadPlazaAndRSMTable(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadPlazaAndRSMTable",
                    data: "{ UserID: '" + UserID
                        + "' , SearchBy: '" + SearchBy
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            HideAll();
                            $("#request-IMEI-service").html(msg.d);
                            $("#request-IMEI-service").css("display", "block");
                            $("#search-IMEI-request-wrapper").css("display", "block");
                            $("#saveId_0").css("display", "none");

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
            
            function LoadDealerDistributionDetails1(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadDealerDistributionDetails1",
                    data: "{ UserID: '" + UserID
                        + "' , SearchBy: '" + SearchBy
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            HideAll();
                            $("#request-IMEI-service").html(msg.d);
                            $("#request-IMEI-service").css("display", "block");
                            $("#search-IMEI-request-wrapper").css("display", "block");
                            $("#saveId_0").css("display", "none");

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
            function LoadDealerDistributionDetailsForStockFaulty(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadDealerDistributionDetailsForStockFaulty",
                    data: "{ UserID: '" + UserID
                        + "' , SearchBy: '" + SearchBy
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            HideAll();
                            $("#stock-faulty-list").html(msg.d);
                            $("#stock-faulty-list").css("display", "block");
                            $("#saveId_0").css("display", "none");
                            $("#search-stock-faulty-wrapper").css("display", "block");

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
            
            function LoadPlazaAndRSMTableForStockfaulty(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/LoadPlazaAndRSMTableForStockfaulty",
                    data: "{ UserID: '" + UserID
                        + "' , SearchBy: '" + SearchBy
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            HideAll();
                            $("#stock-faulty-list").html(msg.d);
                            $("#stock-faulty-list").css("display", "block");
                            $("#saveId_0").css("display", "none");
                            $("#search-stock-faulty-wrapper").css("display", "block");

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


            function GetRequestedIMEIStatus(SearchBy, RequestedValue) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/GetRequestedIMEIStatus",
                    data: "{ SearchBy: '" + SearchBy                  
                           + "' , RequestedValue: '" + RequestedValue
                           + "'}",

                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {

                        var res = msg.d;
                        var searchvalue = $("#search-by-all").val();

                        console.log(searchvalue);

                                            
                        if (res !=null && res.match(/ReRequestSuccess/g)) {

                            var lstValForRequestDate = res.substr(17, 10);

                            var lstValForRequestStatus = res.substr(27);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "IMEI already requested.<br> Previous Request Date :" + " " + lstValForRequestDate + ".<br> Request Status :" + " " + lstValForRequestStatus + ".<br> According to management decision, Request Status(" + lstValForRequestStatus + ") IMEI will not be re-requested by this Aftersales Software.",
                            }).show();

                        }
                        else if (res != null && res.match(/success/g)) {

                            var lstVal = res.substr(8);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "IMEI already requested.<br> Previous Request Date :" + " " + lstVal,
                            }).show();

                        }
                        else if (res != null && res.match(/tblDealerDisDetails/g)) {

                            alertify.confirm('Dealer Record', 'This IMEI Dealer record is not exists into our system. Do you want to input Dealer history?', function () {
                                alertify.success('Ok');

                                LoadDealerDistributionDetails1(UserID, SearchBy);

                            }
                              , function () {
                                  alertify.error('Cancel');

                              });

                        }
                        else if (res != null && res.match(/plazaAndRSM/g)) {

                            alertify.confirm('Dealer Record into Aftersales', 'This IMEI Dealer record is not exists into our Aftersales Software. Do you want to input Dealer history?', function () {
                                alertify.success('Ok');

                                LoadPlazaAndRSMTable(UserID, SearchBy);

                            }
                                , function () {
                                    alertify.error('Cancel');

                                });

                        }
                        else if (res != null && res.match(/RegDateNull/g)) {

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "This is an Inactive IMEI. Activate first or give entry as a Stock Faulty/Display Product. ",
                            }).show();

                        }

                        else if (res != null && ((res.match(/RegDateSuccess/g) && searchvalue == "smart") || (res.match(/RegDateSuccess/g) && searchvalue == "walpad") || (res.match(/RegDateSuccess/g) && searchvalue == "reRequest"))) {

                            var lstVal1 = res.substr(15);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Activation Date is more than SmartPhone/Walpad 15 days Replacement Policy.<br> Activation Date :" + " " + lstVal1,
                            }).show();

                        }
                        else if (res != null && ((res.match(/FeatureRegDateSuccess/g) && searchvalue == "feature") || (res.match(/FeatureRegDateSuccess/g) && searchvalue == "reRequest"))) {

                            var lstVal11 = res.substr(22);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Activation Date is more than Feature phone 30 days Replacement Policy.<br> Activation Date :" + " " + lstVal11,
                            }).show();

                        }
                        else if (res != null && res.match(/DisDateSuccess/g)) {

                            var lstVal2 = res.substr(15);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Distribution Date is more than 1 year. According to management policy, you are not able to give entry into Aftersales software.<br> Distribution Date :" + " " + lstVal2,
                            }).show();

                        }
                        else {

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Please Search by correct IMEI/Request Type.",
                            }).show();
                        }
                    }
                });
            }
            

            function GetRequestedIMEIStatusforStockfaulty(SearchBy, RequestedValue) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/GetRequestedIMEIStatusforStockfaulty",
                    data: "{ SearchBy: '" + SearchBy
                           + "' , RequestedValue: '" + RequestedValue
                           + "'}",

                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {

                        var res = msg.d;
                        var searchvalue = $("#search-by-all-2").val();

                        console.log(searchvalue);


                        if (res != null && res.match(/success/g)) {

                            var lstValForRequestDate = res.substr(7, 11);

                            var lstValForRequestStatus = res.substr(19);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "IMEI already requested.<br> Previous Request Date :" + " " + lstValForRequestDate + ".<br> Request Status :" + " " + lstValForRequestStatus,
                            }).show();

                        }
                        else if (res != null && res.match(/tblDealerDisDetails/g)) {

                            alertify.confirm('Dealer Record', 'This IMEI Dealer record is not exists into our system. Do you want to input Dealer history?', function () {
                                alertify.success('Ok');

                                LoadDealerDistributionDetailsForStockFaulty(UserID, SearchBy);

                            }
                              , function () {
                                  alertify.error('Cancel');

                              });

                        }
                        else if (res != null && res.match(/plazaAndRSM/g)) {

                            alertify.confirm('Dealer Record into Aftersales', 'This IMEI Dealer record is not exists into our Aftersales Software. Do you want to input Dealer history?', function () {
                                alertify.success('Ok');

                                LoadPlazaAndRSMTableForStockfaulty(UserID, SearchBy);

                            }
                                , function () {
                                    alertify.error('Cancel');

                                });

                        }
                        else if (res != null && res.match(/RegDateNull/g)) {

                            var lastForActive = res.substr(12);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "This IMEI is already activated. You are unable to give entry as a Stock Faulty.<br> Activation Date :" + " " + lastForActive,
                            }).show();

                        }
                        else if (res != null && res.match(/DisDateSuccess/g)) {

                            var lstVal2 = res.substr(15);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Distribution Date is more than 80 days. According to management policy, you are not able to give entry into Aftersales software.<br> Distribution Date :" + " " + lstVal2,
                            }).show();

                        }
                        else {

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Please Search by correct IMEI/Request Type.",
                            }).show();
                        }
                    }
                });
            }

            $("#btn-save-distribution-record").live('click', function () {
                var barcode1 = $(this).parent().parent().children("#modelForDealer").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#modelForDealer").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#modelForDealer").children(".hfModel").val();
                var dealerCode = $(this).parent().parent().children("#ddName").children("#item-list-code").children("#ddldealer").find(":selected").val();
                var dealerName = $(this).parent().parent().children("#ddName").children("#item-list-code").children("#ddldealer").find(":selected").text();
                var doNumber = $("#insert_doNumber").val();
                var disDate = $("#distributionDate").val();
                //  alert(disDate);
                console.log(barcode1 + "---" + barcode2 + "-----" + model + "----" + dealerCode + "-------" + dealerName + "-----" + doNumber + "----" + disDate);


                if (dealerName == "------------- Select Dealer Name -------------") {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Select Dealer Name.",
                    }).show();

                    return -1;
                }

                if (disDate == "undefined" || disDate == null || disDate == " " || disDate.length == 0) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Select Distribution Date.",
                    }).show();

                    return -1;
                }

                var secondDate = new Date();
                var currentMonth = secondDate.getMonth() + 1;
                var currentDate = secondDate.getDate();
                var currentYear = secondDate.getFullYear();

                var disDate1 = $("#distributionDate").val();

                var currenttodayDate = currentYear + '-' + currentMonth + '-' + currentDate;

                var firstDate1 = new Date(currenttodayDate);
                var secondDate1 = new Date(disDate1);

                console.log("disDate1 :" + secondDate1);
                console.log("currenttodayDate :" + firstDate1);

                var timeDiff = Math.abs(firstDate1.getTime() - secondDate1.getTime());
                var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));

                console.log("diff :" + diffDays);

                if (secondDate1 > firstDate1) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Distribution Date must be less than or Equal to Current Date.",
                    }).show();

                    return -1;
                }

                if (diffDays > 14) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Date Difference must be within 14 Days From Distribution Date To Current Date.",
                    }).show();

                    return -1;
                }

                InsertDistributionRecord(barcode1, barcode2, model, dealerCode, doNumber, disDate);

            });
            function InsertDistributionRecord(IMEI_1, IMEI_2, Model, DealerCode, DONumber, DistributionDate) {
                var jsonData = "{ IMEI_1: '" + IMEI_1
                    + "', IMEI_2: '" + IMEI_2
                    + "', Model: '" + Model
                    + "', DealerCode: '" + DealerCode
                    + "', DONumber: '" + DONumber
                    + "', DistributionDate: '" + DistributionDate
                    + "'}";
                console.log(jsonData);

                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/InsertDistributionRecord",
                    data: jsonData,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                          
                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Data Saved Successfully.",
                            }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading Request data ...'
                            });

                            var tabIdssForNew = $(".active-tab").text().trim();

                            console.log(tabIdssForNew);

                            if (tabIdssForNew == "New Request") {
                                LoadNewIMEIRequest(UserID);

                            } else if (tabIdssForNew == "Stockfaulty Request") {
                                LoadNewStockFaultyRequest(UserID);

                            }

                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }
            
            function InsertPlazaAndRsmRecord(DealerCode, DealerName, ZoneID) {
                var jsonData = "{ DealerCode: '" + DealerCode
                    + "', DealerName: '" + DealerName
                    + "', ZoneID: '" + ZoneID
                    + "'}";
                console.log(jsonData);

                $.ajax({
                    type: "POST",
                    url: "IMEIRequestForArea.aspx/InsertPlazaAndRsmRecord",
                    data: jsonData,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Data Saved Successfully",
                            }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading Request data ...'
                            });

                           // LoadNewIMEIRequest(UserID);
                            var tabIdssForNew = $(".active-tab").text().trim();

                            console.log(tabIdssForNew);

                            if (tabIdssForNew == "New Request") {
                                LoadNewIMEIRequest(UserID);

                            } else if (tabIdssForNew == "Stockfaulty Request") {
                                LoadNewStockFaultyRequest(UserID);

                            }

                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }
            $("#btn-save-plazaAndRsm-record").live('click', function () {

                var dealerCode = $(this).parent().parent().children("#ddName1").children("#item-list-code").children("#ddldealer").find(":selected").val();
                var dealerName = $(this).parent().parent().children("#ddName1").children("#item-list-code").children("#ddldealer").find(":selected").text();

                var rsmName = $(this).parent().parent().children("#ddRsmName").children("#item-list-Rsm").children("#ddlRsm").find(":selected").text();
                var rsmCode = $(this).parent().parent().children("#ddRsmName").children("#item-list-Rsm").children("#ddlRsm").find(":selected").val();

                console.log(dealerCode + "-------" + dealerName + "-----" + rsmName + "-----" + rsmCode);


                if (dealerName == "--------- Select Organaization Name ---------") {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Select Organaization Name.",
                    }).show();

                    return -1;
                }

                if (rsmName == "--------- Select RSM/Monitor Name ---------") {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Select RSM/Monitor Name.",
                    }).show();

                    return -1;
                }

                InsertPlazaAndRsmRecord(dealerCode, dealerName, rsmCode);

            });


             function GetRequestedIMEIStatusIntblDisplayProduct(SearchBy) {
                 $.ajax({
                     type: "POST",
                     url: "IMEIRequestForArea.aspx/GetRequestedIMEIStatusIntblDisplayProduct",
                     data: "{ SearchBy: '" + SearchBy + "'}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (msg) {

                         if (msg.d == "success") {
                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "IMEI already Registered as a Display Product.",
                             }).show();


                         }
                         else {

                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "Please Search by correct IMEI.",
                             }).show();
                         }
                     }
                 });
             }

             function InserttblStockReconciliation(DealerCode, Model, InHouseStock, MarketStock, AddedBy) {
                 $.ajax({
                     type: "POST",
                     url: "IMEIRequestForArea.aspx/InserttblStockReconciliation",
                     data: "{ DealerCode: '" + DealerCode
                                 + "', Model: '" + Model
                                 + "', InHouseStock: '" + InHouseStock
                                 + "', MarketStock: '" + MarketStock
                                 + "', AddedBy: '" + AddedBy
                                 + "'}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (msg) {
                         if (msg.d == "success") {
                             // alert("Data Requested Successfully");
                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "Data Saved Successfully",
                             }).show();
                             $.msg({
                                 msgID: 1,
                                 autoUnblock: false,
                                 clickUnblock: false,
                                 content: 'Please wait loading Request data ...'
                             });

                             LoadAreaStockReconciliation(UserID);


                         }
                         else {
                             $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                         }
                     }
                 });
             }

             $("#btn-add-stockDealer").live('click', function () {

                 var inHouse;
                 var marketStock;
                 var dealerCode = $(this).parent().parent().children("#hfDealerName").children("#dealer_lists").children("#ddldealer").find(":selected").val();
                 var dealerName = $(this).parent().parent().children("#hfDealerName").children("#dealer_lists").children("#ddldealer").find(":selected").text();
                 var model = $(this).parent().parent().children("#mobileModel").children("#model_lists").children("#ddlmodel").find(":selected").text();
                 inHouse = $('#input-inHouse').val();
                 marketStock = $('#input-marketStock').val();
                 var addedBy = UserID;


                 if (dealerName == "------------- Select Dealer Name -------------") {

                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Please select Dealer Name",
                     }).show();
                     return false;

                 }
                 if (model == "------------------ Select Model ------------------") {

                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Please select Model",
                     }).show();
                     return false;

                 }
                 if (isNaN(inHouse) || inHouse.indexOf(" ") != -1) {

                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Enter numeric value for Inhouse Stock",
                     }).show();
                     return false;
                 }
                 if (isNaN(marketStock) || marketStock.indexOf(" ") != -1) {

                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Enter numeric value for Market Stock",
                     }).show();
                     return false;
                 }

                 if (inHouse == false && marketStock == false) {
                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Please put value into at least one field(In house/Market Stock)",
                     }).show();
                     return false;
                 }

                 InserttblStockReconciliation(dealerCode, model, inHouse, marketStock, addedBy);

             });

             function InserttblStockReconciliation(DealerName, DealerCode, itemArray, AddedBy) {
                 $.ajax({
                     type: "POST",
                     url: "IMEIRequestForArea.aspx/InserttblStockReconciliation",
                     data: "{ DealerName: '" + DealerName
                                 + "', DealerCode: '" + DealerCode
                                 + "', itemArray: '" + itemArray
                                 + "', AddedBy: '" + AddedBy
                                 + "'}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (msg) {
                         if (msg.d == "success") {


                             $.msg({
                                 msgID: 1,
                                 autoUnblock: false,
                                 clickUnblock: false,
                                 content: 'Please wait loading Request data ...'
                             });

                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "Data Saved Successfully",
                             }).show();
                             LoadAreaStockReconciliation(UserID);


                         }
                         else {
                             $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                         }
                     }
                 });
             }

             $("#btn-stock-recon").live('click', function () {

                 var divOne = document.getElementById('stock-reconListForSave');
                 var divTwo = document.getElementById('stock-reconListForSave1');
                 if (divOne) {
                     // alert("divvvv 111111111");
                     var dealerName = $("#parameter-stockRecon-job").children("#ddldealer").find(":selected").text().trim();
                     var dealerCode = $("#parameter-stockRecon-job").children("#ddldealer").find(":selected").val().trim();
                     console.log(dealerName);
                     console.log(dealerCode);
                     var addedBy = UserID;

                     if (dealerName == "---- Select Dealer Name ----") {

                         alertify.dialog('alert').set({
                             'title': '   ',
                             'transition': 'zoom',
                             'message': "Please select Dealer Name",
                         }).show();
                         return false;

                     }

                     var itemArray = new Array();
                     $("#area-stockRecon-list tr.stock-recontrForSave").each(function (i) {

                         var mModel = $.trim($(this).children("#mobileModel2").text());
                         var inHouses = $.trim($(this).children("#forInhouse").children("#input-inHouse").val());
                         var mStock = $.trim($(this).children("#forMarkets").children("#input-marketStock").val());


                         console.log(mModel);
                         console.log(inHouses);
                         console.log(mStock);

                         itemArray[i] = new Array(4);
                         itemArray[i][0] = mModel;
                         itemArray[i][1] = inHouses;
                         itemArray[i][2] = mStock;
                         itemArray[i][3] = ";";

                     });
                     for (var i = 0; i < itemArray.length; i++) {
                         if (isNaN(itemArray[i][1]) || itemArray[i][1].indexOf(" ") != -1) {

                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "Enter numeric value for Inhouse Stock",
                             }).show();
                             return false;
                         }
                         if (isNaN(itemArray[i][2]) || itemArray[i][2].indexOf(" ") != -1) {

                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "Enter numeric value for Market Stock",
                             }).show();
                             return false;
                         }
                     }
                     console.log("final : " + itemArray);

                     InserttblStockReconciliation(dealerName, dealerCode, itemArray, addedBy);
                 }
                 else if (divTwo) {
                     // alert("divvvv 2222222");
                     var dealerName1 = $("#parameter-stockRecon-job").children("#ddldealer").find(":selected").text().trim();
                     var dealerCode1 = $("#parameter-stockRecon-job").children("#ddldealer").find(":selected").val().trim();
                     console.log(dealerName1);
                     console.log(dealerCode1);
                     var addedBy1 = UserID;

                     if (dealerName1 == "---- Select Dealer Name ----") {

                         alertify.dialog('alert').set({
                             'title': '   ',
                             'transition': 'zoom',
                             'message': "Please select Dealer Name",
                         }).show();
                         return false;

                     }

                     var itemArray1 = new Array();
                     $("#area-stockRecon-list tr.stock-recontrForSave1").each(function (i) {

                         var mModel1 = $.trim($(this).children("#mobileModel3").text());
                         var inHouses1 = $.trim($(this).children("#forInhouse1").children("#input-inHouse1").val());
                         var mStock1 = $.trim($(this).children("#forMarkets1").children("#input-marketStock1").val());


                         console.log(mModel1);
                         console.log(inHouses1);
                         console.log(mStock1);

                         itemArray1[i] = new Array(4);
                         itemArray1[i][0] = mModel1;
                         itemArray1[i][1] = inHouses1;
                         itemArray1[i][2] = mStock1;
                         itemArray1[i][3] = ";";



                     });
                     for (var i = 0; i < itemArray1.length; i++) {
                         if (isNaN(itemArray1[i][1]) || itemArray1[i][1].indexOf(" ") != -1) {

                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "Enter numeric value for Inhouse Stock",
                             }).show();
                             return false;
                         }
                         if (isNaN(itemArray1[i][2]) || itemArray1[i][2].indexOf(" ") != -1) {

                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "Enter numeric value for Market Stock",
                             }).show();
                             return false;
                         }
                     }
                     console.log("final : " + itemArray1);


                     InserttblStockReconciliation(dealerName1, dealerCode1, itemArray1, addedBy1);
                 }
                 console.log(divOne);
                 console.log(divTwo);


             });
            
             $(".btn-display-entry-search").live('click', function () {

                 var searchby = $("#parameter-display-entry-job").val().trim();

                 if (searchby.length == 0) {
                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Please put currect parameter value",
                     }).show();
                     $("#parameter-display-entry-job").focus();
                     return -1;

                 }
                 else {
                     $.msg({
                         msgID: 1,
                         autoUnblock: false,
                         clickUnblock: false,
                         content: 'Please wait loading service .....'
                     });

                     LoadDisplayEntry(UserID, searchby);

                 }


             });

             function InsertIntotblDisplayProduct(IMEI_1, IMEI_2, Model, DealerCode, DisplayDate, AddedBy) {
                 $.ajax({
                     type: "POST",
                     url: "IMEIRequestForArea.aspx/InsertIntotblDisplayProduct",
                     data: "{ IMEI_1: '" + IMEI_1
                                 + "', IMEI_2: '" + IMEI_2
                                 + "', Model: '" + Model
                                 + "', DealerCode: '" + DealerCode
                                 + "', DisplayDate: '" + DisplayDate
                                 + "', AddedBy: '" + AddedBy
                                 + "'}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (msg) {
                         if (msg.d == "success") {

                             alertify.dialog('alert').set({
                                 'title': '   ',
                                 'transition': 'zoom',
                                 'message': "Data Saved Successfully",
                             }).show();
                             $.msg({
                                 msgID: 1,
                                 autoUnblock: false,
                                 clickUnblock: false,
                                 content: 'Please wait loading Request data ...'
                             });

                             LoadDisplayEntry(UserID);


                         }
                         else {
                             $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                         }
                     }
                 });
             }
            
             $("#btn-display-IMEI-save").live('click', function () {
                
                 var imei_1 = $(this).parent().parent().children("#displayBarcode").children(".hfbarcode1").val();
                 var imei_2 = $(this).parent().parent().children("#displayBarcode").children(".hfbarcode2").val();
                 var model = $(this).parent().parent().children("#displayBarcode").children(".hfModel").val();
                 var dealerCode = $(this).parent().parent().children("#hfDealerName1").children("#dealer_lists1").children("#ddldealer").find(":selected").val();
                 var dealerName = $(this).parent().parent().children("#hfDealerName1").children("#dealer_lists1").children("#ddldealer").find(":selected").text();
                 var isNSMApro = $("#IsAprv").text().trim();
                 var addedBy = UserID;

                 var distributionDate = $("#distri_date").text().trim();
                 var disDate = $("#displayDate").val();

               
                 var d1 = Date.parse(distributionDate);
                 var d2 = Date.parse(disDate);

             
                 if (d2 < d1) {
                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Display Date will not be less than Distribution Date.",
                     }).show();
                     return false;
                 }

                 if (dealerName == "------------- Select Dealer Name -------------") {
                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Please Select Dealer Name...",
                     }).show();
                     return false;
                 }

                 if (disDate.length == 0) {
                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Please Select Display Date...",
                     }).show();
                     return false;
                 }
                 if (isNSMApro == "YES") {
                     alertify.dialog('alert').set({
                         'title': '   ',
                         'transition': 'zoom',
                         'message': "Already approved by NSM",
                     }).show();
                     return false;
                 }

                 InsertIntotblDisplayProduct(imei_1, imei_2, model, dealerCode, disDate, addedBy);
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
            <div class=" tab-item active-tab" id="new-request">
                New Request
            </div>
            <div class="tab tab-item" id="stockfaulty-tab" style="width:200px;">
                Stockfaulty Request
            </div>
           <div class="tab tab-item" id="report">
                Report
            </div>
            <div class="tab tab-item" id="stock-recon" style="width:200px;">
                Stock Reconciliation
            </div>
            <div class="tab tab-item" id="display-entry">
                Display Reg.
            </div>
        </div>

    <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;padding-top:20px;overflow:auto;padding-bottom:20px;">
          <div id="IMEI-request-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-IMEI-request-wrapper" style="margin-bottom:20px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">Request Type :</div>
                    <div id="div-requestType" style="float:left; margin-left:20px;">
                        <select name="search-by-all" id="search-by-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="smart" >SmartPhone-15 Days</option>
                            <option value="walpad" >Walpad-15 Days</option>
                            <option value="feature">FeaturePhone-30 Days</option>
                            <%--<option value="stock">StockFaulty</option>--%>
                           <%-- <option value="registereddisplay">Display</option>   --%>             
                            <option value="reRequest">Re-Request</option>  
                            <option value="localMade">Local Made SmartPhone-30 Days</option>
                            <option value="localMadeFeature">Local Made FeaturePhone-30 Days</option>
                        </select>
                    </div>
                   <%-- <div style="clear:both"></div>
                    <div style="border:1px solid #CCCCCC;border-radius:5px;width:200px; 
                        height:25px ;line-height:25px;margin-right:10px;margin-top:10px;float:left;text-align:center">IMEI Number</div>
                    <div style="float:left">
                        <input type="text" id="parameter-IMEI-number" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;" />
                    </div>--%>
                     <div id="ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">IMEI Number : </div>
                        <div class="input" style="float:left;"> 
                            <input id="imeno" class="inputs" type="text"  style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                        </div>
                       <%-- <div style="width:100px;">--%>
                            <img id="img-err" src="Styles/image/close_pop.png" style="padding-top:45px; display:none;border:0px solid red" />
                            <img id="img-verifying" src="Styles/image/ajax-loader.gif" style="padding-top:45px; display:none;border:0px solid red" />
                            <img id="img-verified" src="Styles/image/save.png" style="padding-top:45px; display:none;border:0px solid red" />
                       <%-- </div>--%>
                                       
                    </div> 

                    <div class="btn-IMEI-request-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="request-IMEI-service" style="width:100%;float:left;margin-left:5px;display:none"></div>

          <%-- <div id="active-message" style ="width: 950px; float: left; margin-left:50px;font-size:14px;font-weight:bold;color:#374f6e;
                margin-top: 20px; border: 0px solid red ;display:block">
                 You have no Request in Dashboard.. Please Search for New Request.
            </div>--%>

            </div> 
        
             
               
             <div style="clear:both"></div>
             <div id="stockfaulty-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-stock-faulty-wrapper" style="margin-top:-60px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType3" style="float:left; margin-left:20px;">
                        <select name="search-by-all-2" id="search-by-all-2" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;"> 
                             <option value="0" >----------- Service Type -----------</option>
                            <option value="stockfaulty1" >StockFaulty</option>   
                            <%-- <option value="notRegisteredDisplay" >Display</option>    --%>                                                                
                        </select>
                    </div>
                  
                     <div id="stockfaulty-ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">IMEI : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-stockfaulty-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>   
                    
                      
                                          
                    </div> 

                    <div class="btn-stock-faulty-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="stock-faulty-list" style="width:100%;margin-left:5px;display:block"></div>
            </div> 
            
             <div style="clear:both"></div>
             <div id="plaza-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-plaza-report-wrapper" style="margin-top:-100px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType1" style="float:left; margin-left:20px;">
                        <select name="search-by-all-1" id="search-by-all-1" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>  
                             <option value="DealerCode">DealerCode</option>                                                        
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
                <div id="plaza-report-list" style="width:100%;margin-left:-30px;display:block"></div>
            </div>   
                        
           <div style="clear:both"></div>
             <div id="area-stockRecon-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-stockRecon-IMEI-wrapper" style="margin-top:-100px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;margin-top:-20px">SEARCH BY</div>
                    
                    <div class="input" id="parameter-stockRecon-job" style="width:200px; height:23px ;border:1px solid #CCCCCC;margin-top:-20px;float:left; margin-left:20px; text-transform:uppercase;color: #000000;">
                                        <%=DDLDealerName%>
                     </div>  
                  <br/><br/>
                     <div class="btn-stockRecon-search" style="border:1px solid #83AF45;width:150px;line-height:25px;text-align:center; 
                            font-weight:bold;font-style:italic;cursor:pointer;left:0;border-radius:5px;color: #FFFFFF;background-color: #26C281;margin-top: 20px;">
                             SEARCH 
                        </div>   
                </div>
                <br /><br /><br />
                 <div style="clear:both"></div>
                  
                <div id="area-stockRecon-list" style="width:1000px;float:left;display:none;margin-left: 0px;">
                        
                </div>
               <div style="clear:both"></div>
               <br/><br/>
                   <div id="saveId_0" style="display: none;width:210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;margin-left:70px;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: white;background-color:#cccccc;">
                                           
                   <div id="btn-stock-recon" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                        font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:60px;margin-top:4px;background: red">
                  
                        SAVE
                    </div>
               
               </div>
            </div> 
        
          <div id="display-entry-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-display-IMEI-wrapper" style="margin-top:-150px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY IMEI : </div>
                    <input type="text" id="parameter-display-entry-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;float: left;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #DADADA;" />
                     <br /><br />
                    <div class="btn-display-entry-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:10px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="display-entry-list" style="width:100%;float:left;margin-left:5px;display:none"></div>

            </div> 
   </div>
</div>

</asp:Content>


