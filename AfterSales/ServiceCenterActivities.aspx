<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ServiceCenterActivities.aspx.cs" Inherits="WSMS.ServiceCenterActivities" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/ServiceCenterReplacementIMEIReq.ascx" TagName="ServiceCenterReplacementIMEIReq"  TagPrefix="uc2" %>

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
                LoadIMEIRequestByServiceCenter(UserID);
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


            $("#servicecenter-request").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });

                $('#imeno').val('');
                $('#search-by-all').val('0');

                $("#img-verified").css('display', 'none');
                $("#img-verifying").css('display', 'none');
                $("#img-err").css('display', 'none');

                $("#img-verified1").css('display', 'none');
                $("#img-verifying1").css('display', 'none');
                $("#img-err1").css('display', 'none');

                LoadIMEIRequestByServiceCenter(UserID);
             
            });

             $("#servicereport-tab").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-servicecenter-report-job').val('');
                $('#search-by-all-1').val('0');

                LoadReportForServiceCenter(UserID);
            });


               ///////imei no search///
            var imePrev;
            var imereg = "";
            $(document).on("focusout", "#imeno", function () {
                var IMENo = $("#imeno").val().trim().toUpperCase();

                if (IMENo.length > 0) {
                    if (IMENo != imePrev) {
                        imePrev = IMENo;
                      
                        GetIMEReg(IMENo);


                    }


                }
                else if (!IMENo.match(/\S/))
                {
                    $("#img-verified").css('display', 'none');
                    $("#img-verifying").css('display', 'none');
                    $("#img-err").css('display', 'none');
                }
                else {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Enter IME to get data..",                                                                       
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
                    url: "ServiceCenterActivities.aspx/GetIMEReg",
                    data: "{ IMENo: '" + IMENo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "invalid") {
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
           
            function HideAll() {
                $("#request-IMEI-from-servicecenter").css("display", "none");
                $("#search-servicecenter-request-wrapper").css("display", "none");

                $("#servicecenter-report-list").css("display", "none");
                $("#search-servicecenter-report-wrapper").css("display", "none");
                $("#print-request-REPIMEI").css("display", "none");

            }

            function LoadIMEIRequestByServiceCenter(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "ServiceCenterActivities.aspx/LoadIMEIRequestByServiceCenter",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            HideAll();
                            $("#request-IMEI-from-servicecenter").html(msg.d);
                            $("#request-IMEI-from-servicecenter").css("display", "block");

                            $("#search-servicecenter-request-wrapper").css("display", "block");
                           
                            var searchvalue = $("#imeno").val();
                           // var requestedValue = $("#search-by-all").val();

                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {

                                GetRequestedIMEIInfo(searchvalue);

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
            
            function GetRequestedIMEIStatus(SearchBy, RequestedValue) {
                $.ajax({
                    type: "POST",
                    url: "ServiceCenterActivities.aspx/GetRequestedIMEIStatus",
                    data: "{ SearchBy: '" + SearchBy
                           + "' , RequestedValue: '" + RequestedValue
                        + "'}",

                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {

                        var res = msg.d;
                        var searchvalue = $("#search-by-all").val();

                        console.log(searchvalue);

                     

                        if (res != null && res.match(/ReRequestSuccess/g)) {

                            var lstValForRequestDate = res.substr(17, 10);

                            var lstValForRequestStatus = res.substr(27);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "IMEI already requested.<br> Previous Request Date :" + " " + lstValForRequestDate + ".<br> Request Status :" + " " + lstValForRequestStatus + ".",
                            }).show();

                        }
                        else if (res != null && res.match(/plazaAndRSM/g)) {

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "This IMEI Dealer record is not exists into our Aftersales Software. Please contact with System Administrator.",
                            }).show();

                        }
                        else if (res != null && res.match(/tblDealerDisDetails/g)) {
                            
                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "This IMEI Dealer record is not exists into our system. Please contact with System Administrator.",
                            }).show();

                        }
                        else if (res != null && res.match(/RegDateNull/g)) {

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "This is an Inactive IMEI. Please activate first & then try to give entry. ",
                            }).show();

                        }

                        else if (res != null && ((res.match(/RegDateSuccess/g) && searchvalue == "smart") || (res.match(/RegDateSuccess/g) && searchvalue == "walpad"))) {

                            var lstVal1 = res.substr(15);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "Activation Date is more than SmartPhone/Walpad 15 days Replacement Policy.<br> Activation Date :" + " " + lstVal1,
                            }).show();

                        }
                        else if (res != null && (res.match(/FeatureRegDateSuccess/g) && searchvalue == "feature")) {

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

             function GetRequestedIMEIInfo(SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "ServiceCenterActivities.aspx/GetRequestedIMEIInfo",
                    data: "{ SearchBy: '" + SearchBy + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#print-request-REPIMEI").html(msg.d);
                            $("#print-request-REPIMEI").css("display", "block");

                            $("#search-servicecenter-request-wrapper").css("display", "block");
                            
                            var searchvalue = $("#imeno").val();
                            var requestedValue = $("#search-by-all").val();
                            
                            $.msg('unblock', 30, 1);
                            if (msg.d == 0) {
                               
                                GetRequestedIMEIStatus(searchvalue, requestedValue);
                            
                            }


                            
                            var imei1=$("#rep_imei_1").children("#insert_rep_imei_1").val();
                            var imei2=$("#rep_imei_2").children("#insert_rep_imei_2").val();
                            
                            if (imei1.length > 0 ) {

                                       $("#insert_rep_imei_1").attr('disabled', 'disabled');
                                       $("#rep_imei_1").attr('disabled', 'disabled');

                                       $("#rep_imei_2").attr('disabled', 'disabled');
                                       $("#insert_rep_imei_2").attr('disabled', 'disabled');

                                       $("#rep_model_list").attr('disabled', 'disabled');
                                       $("#ddlmodel").attr('disabled', 'disabled');
                                       $("#rep_model").attr('disabled', 'disabled');
                                  
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

           $(".btn-servicecenter-request-search").live('click', function () {

                var SearchBy1 = $("#search-by-all").val();
                //alert(SearchBy1);
                var parameter = $("#imeno").val().trim();
                //alert(parameter);

                if (SearchBy1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select replacement request type.",                                                                                        
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

                    $("#imeno").focus();
                    return -1;
                }
                else {

                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading service .....'
                    });
                    LoadIMEIRequestByServiceCenter(UserID, SearchBy1 + ";" + parameter);


                }
            });

//              var repIMEI1; 
//              var repIMEI2;
//              var repModel; 
              $("#btn-servicecenter-request").live('click', function () {

                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                var dealercode = $(this).parent().parent().children("#regdate").children(".hfDealerCode").val();
                var requestType = $("#search-by-all").val();
                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();              
                var issue = $(this).parent().parent().children("#issues").children("#item-list").children("#ddlissue").find(":selected").text();
                var cellphoneNumber = $(this).parent().parent().children("#cellphone").children("#input-cellnumber").val();
                var issueDetails = $(this).parent().parent().children("#details").children("#input-details-issues").val();
                var seenStatus = $(this).parent().parent().children("#seen_or_not").children("#seen-status").find(":selected").text();
//                repIMEI1 = $(this).parent().parent().children("#rep_imei_1").children("#insert_rep_imei_1").val();
//                repIMEI2 = $(this).parent().parent().children("#rep_imei_2").children("#insert_rep_imei_2").val();
//                repModel = $(this).parent().parent().children("#rep_model").children("#rep_model_list").children("#ddlmodel").find(":selected").text();
//               
                var repGivenUsers = $(this).parent().parent().children("#repGivenBy").children("#insert_repGivenBy").val();
                var requestStatus = 'ServiceRequested';
                var addedBy = UserID;

                if (isNaN(cellphoneNumber) || cellphoneNumber.indexOf(" ") != -1) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Enter numeric value for Cellphone number",                                                                                        
                                              }).show();

                    return false;
                }
                else if (cellphoneNumber.length != 11) {

                   // alert("Enter 11 characters");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Enter 11 characters for Cellphone number",                                                                                        
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

                    return false
                }


                if (issue == "-- Select Problem --") {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Customer Issues required",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (issueDetails.length <= 20) {

                 
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Enter minimum 20 characters for Remarks",                                                                                        
                                              }).show();
                    return false;
                }

                if (seenStatus == "------- Select Status-------") {

                    //alert("Select Seen Status");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Select Seen Status",                                                                                        
                                              }).show();
                    return false;
                }

//                 if (repIMEI1.length != 15) {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Please Enter Replacement IMEI_1",                                                                                        
//                                              }).show();

//                                    return false;
//                 }

//                  if (repModel == "-------- Select Model --------") {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Please Enter Replacement Model",                                                                                        
//                                              }).show();

//                                    return false;
//                 }

                  if (repGivenUsers.length == 0) {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Enter Replacement GivenBy UserID",                                                                                        
                                              }).show();

                                    return false;
                 }

                var isOK = false;
              
                if (requestType == "smart") { // Smart Phone
                  
                    requestType = "SmartPhone-15 Days";

                    InsertIntoIMEIReplacementMasterFromServiceCenter(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, requestStatus, addedBy,repGivenUsers);


                    isOK = true;
                 
                }
                else if (requestType == "walpad") { // Walpad

                    requestType = "Walpad-15 Days";

                    InsertIntoIMEIReplacementMasterFromServiceCenter(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, requestStatus, addedBy,repGivenUsers);

                    isOK = true;
                  
                }
                else if (requestType == "feature") { // feature

                    requestType = "FeaturePhone-30 Days";

                    InsertIntoIMEIReplacementMasterFromServiceCenter(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, requestStatus, addedBy,repGivenUsers);

                    isOK = true;
                 
                }
                else if (requestType == "localMade") { // localMade Phone

                    requestType = "Local Made SmartPhone-30 Days";

                    InsertIntoIMEIReplacementMasterFromServiceCenter(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, requestStatus, addedBy, repGivenUsers);


                    isOK = true;

                }
                else if (requestType == "localMadeFeature") { // localMade Phone

                    requestType = "Local Made FeaturePhone-30 Days";

                    InsertIntoIMEIReplacementMasterFromServiceCenter(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, requestStatus, addedBy, repGivenUsers);


                    isOK = true;

                }

            });

              var repIMEI1; 
              var repIMEI2;
              var repModel; 
              $("#btn-servicecenter-submit").live('click', function () {

                var reqid = $(this).parent().parent().children("#regdate1").children(".hfRequestID1").val();
                repIMEI1 = $(this).parent().parent().children("#rep_imei_1").children("#insert_rep_imei_1").val();
                repIMEI2 = $(this).parent().parent().children("#rep_imei_2").children("#insert_rep_imei_2").val();
                repModel = $(this).parent().parent().children("#rep_model").children("#rep_model_list").children("#ddlmodel").find(":selected").text();

                if (repIMEI1.length != 15) {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Enter Replacement IMEI_1",                                                                                        
                                              }).show();

                                    return false;
                 }

//                 if (repIMEI2.length != 15) {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Please Enter Replacement IMEI_2",                                                                                        
//                                              }).show();

//                                    return false;
//                 }

                  if (repModel == "-------- Select Model --------") {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Enter Replacement Model",                                                                                        
                                              }).show();

                                    return false;
                 }           

                 var isOK = false;


                 InsertRepIMEIIntoIMEIReplacementMasterFromServiceCenter(reqid, repIMEI1,repIMEI2,repModel);


                 isOK = true;

            });

            function InsertRepIMEIIntoIMEIReplacementMasterFromServiceCenter(RequestID, ReplaceIMEI_1, ReplaceIMEI_2, ReplaceModel) {
                $.ajax({
                    type: "POST",
                    url: "ServiceCenterActivities.aspx/InsertRepIMEIIntoIMEIReplacementMasterFromServiceCenter",
                     data: "{ RequestID: '" + RequestID
                                + "', ReplaceIMEI_1: '" + ReplaceIMEI_1
                                + "', ReplaceIMEI_2: '" + ReplaceIMEI_2
                                + "', ReplaceModel: '" + ReplaceModel
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

                             LoadIMEIRequestByServiceCenter(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


             function InsertIntoIMEIReplacementMasterFromServiceCenter(IMEI_1, IMEI_2, Model, DealerCode, RequestType, RegistrationDate, DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, RequestStatus, AddedBy, ReplacementGivenBy) {
                $.ajax({
                    type: "POST",
                    url: "ServiceCenterActivities.aspx/InsertIntoIMEIReplacementMasterFromServiceCenter",
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

//                                + "', ReplaceIMEI_1: '" + ReplaceIMEI_1
//                                + "', ReplaceIMEI_2: '" + ReplaceIMEI_2
//                                + "', ReplaceModel: '" + ReplaceModel

                                + "', RequestStatus: '" + RequestStatus
                                + "', AddedBy: '" + AddedBy
                                + "', ReplacementGivenBy: '" + ReplacementGivenBy
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

                            LoadIMEIRequestByServiceCenter(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }

             //rep_imei_r2
            ///////replacement imei no search///
            var imePrev1;
            var imereg1 = "";
            $(document).on("focusout", "#insert_rep_imei_1", function () {
                var RepIMENo = $("#insert_rep_imei_1").val().trim().toUpperCase();

                if (RepIMENo.length > 0) {
                    if (RepIMENo != imePrev1) {
                        imePrev1 = RepIMENo;

                        GetIMERegForReplacement(RepIMENo);

                    }


                }
                 else if (!RepIMENo.match(/\S/))
                {
                    $("#img-verified1").css('display', 'none');
                    $("#img-verifying1").css('display', 'none');
                    $("#img-err1").css('display', 'none');
                }
                else {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please enter correct Replacement IME to get data..",                                                                       
                                              }).show();
                    $("#img-verified1").css('display', 'none');

                    $("#img-verifying1").css('display', 'none');
                    $("#img-err1").css('display', 'none');
                }

            });

            
            function GetIMERegForReplacement(RepIMENo) {

                $("#img-verified1").css('display', 'none');
                $("#img-err1").css('display', 'none');
                $('#img-verifying1').css("display", "block");


                $.ajax({
                    type: "POST",
                    url: "ServiceCenterActivities.aspx/GetIMERegForReplacement",
                    data: "{ RepIMENo: '" + RepIMENo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "invalid") {
                            //alert("Invalid IME .. Please put currect IME");
                            alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Invalid ReplacementIMEI .. Please put currect IME",                                                                       
                                              }).show();

                            $("#msg").css("display", "block");
                            $("#img-verifying1").css('display', 'none');
                            $("#img-err1").css('display', 'block');
                            $("#msg-invalid1").css('display', 'block');


                        }
                        else {

                            $("#img-verified1").css('display', 'block');
                            $("#img-verifying1").css('display', 'none');
                            $("#img-err1").css('display', 'none');
                        }
                    }
                });

            }    
           
        function LoadReportForServiceCenter(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "ServiceCenterActivities.aspx/LoadReportForServiceCenter",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            HideAll();
                            $("#servicecenter-report-list").html(msg.d);
                            $("#servicecenter-report-list").css("display", "block");

                            $("#search-servicecenter-report-wrapper").css("display", "block");
                           
                             $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                              
                                 alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date/DealerCode.",                                                                       
                                              }).show();
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
             $(".btn-servicecenter-report-search").live('click', function () {

                var SearchBy1 = $("#search-by-all-1").val();
                var parameter = $("#parameter-servicecenter-report-job").val().trim();

                if (SearchBy1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please  select service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }


                if (parameter.length == 0) {
                    alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                                        
                                              }).show();
                    $("#parameter-servicecenter-report-job").focus();
                    return -1;

                 
                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading service .....'
                    });
                    LoadReportForServiceCenter(UserID, SearchBy1 + ";" + parameter);
                 
                  
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
            <div class=" tab-item active-tab" id="servicecenter-request">
                IMEI Request
            </div>
            <div class="tab tab-item" id="servicereport-tab">
                Report
            </div>
        </div>
        <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;padding-top:20px;overflow:auto;padding-bottom:20px;">  
         <div id="servicecenter-request-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-servicecenter-request-wrapper" style="margin-top:-30px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC; width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">Request Type :</div>
                    <div id="div-requestType" style="float:left; margin-left:20px;">
                        <select name="search-by-all" id="search-by-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="smart" >SmartPhone-15 Days</option>
                            <option value="walpad" >Walpad-15 Days</option>
                            <option value="feature">FeaturePhone-30 Days</option>
                            <option value="localMade">Local Made SmartPhone-30 Days</option>
                            <option value="localMadeFeature">Local Made FeaturePhone-30 Days</option>
                        </select>
                    </div>
                
                     <div id="ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">IMEI Number : </div>
                        <div class="input" style="float:left;"> 
                            <input id="imeno" class="inputs" type="text"  style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                        </div>
                    
                            <img id="img-err" src="Styles/image/close_pop.png" style="padding-top:45px; display:none;border:0px solid red" />
                            <img id="img-verifying" src="Styles/image/ajax-loader.gif" style="padding-top:45px; display:none;border:0px solid red">
                            <img id="img-verified" src="Styles/image/save.png" style="padding-top:45px; display:none;border:0px solid red">
                                
                    </div> 

                    <div class="btn-servicecenter-request-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="request-IMEI-from-servicecenter" style="width:100%;margin-left:5px;float:left;display:none"></div>
               
                <div id="print-request-REPIMEI" style="width:100%;float:left;display:block;margin-top:30px"></div>
                 <div style="margin-left:20px;float:left;margin-top:-180px">
                     <img id="img-err1" src="Styles/image/close_pop.png" style="display:none;border:0px solid red;margin-left:495px;float:left" />
                     <img id="img-verifying1" src="Styles/image/ajax-loader.gif" style=" display:none;border:0px solid red;float:left;margin-left:495px">
                     <img id="img-verified1" src="Styles/image/save.png" style=" display:none;border:0px solid red;float:left;margin-left:495px">
                 
               </div>
            </div> 
            
             <div id="servicecenter-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top:0px; border: 0px solid red ;display:block;">
                <div id="search-servicecenter-report-wrapper" style="margin-top:-40px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC; width:200px; height:25px ;
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
                        <input type="text" id="parameter-servicecenter-report-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-servicecenter-report-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px; border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="servicecenter-report-list" style="width:100%;margin-left:-30px;display:block"></div>
            </div> 
        </div>

</div>
</asp:Content>
