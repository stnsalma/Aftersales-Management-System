<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IMEIRequest.aspx.cs" Inherits="WSMS.IMEIRequest" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/IMEIRequestFromPlaza.ascx" TagName="IMEIRequestFromPlaza"  TagPrefix="uc2" %>

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
    <link href="Styles/jquery.datepick.css" rel="stylesheet" />
    <script src="Scripts/jquery.datepick.js" type="text/javascript"></script>
   <link href="Scripts/alertifyjs/css/alertify.css" rel="stylesheet" />
   <script src="Scripts/alertifyjs/alertify.js" type="text/javascript"></script>
    <script src="Scripts/glDatePicker.js" type="text/javascript"></script>
    <link href="Styles/glDatePicker.default.css" rel="stylesheet" />

   <script type="text/javascript">

       var tttotal = 0;

       function fill(newvalue)
       {
             var txt8 = newvalue - 0;           
             console.log(txt8);
          
             var txt9 = document.getElementById("old_value").value - 0;

             console.log("new_value :" + txt8);
             console.log("old_value  :" + txt9);

             document.getElementById("total_value").value = parseFloat(txt8) - parseFloat(txt9);

             tttotal = parseFloat(document.getElementById("total_value").value);

             console.log("tttotal :" + tttotal);

             if (parseFloat(tttotal) < 0) 
             {
                   document.getElementById("total_value").value = 0;
             }
        }

       function fillbyfaultyprice() {
         
           var secondDate = new Date();
           var currentMonth = secondDate.getMonth().toString();
           var currentDate = secondDate.getDate().toString();
           var currentYear = secondDate.getFullYear().toString();
           //  mRegistrationDate;children(".hfModel3")
           var cpreDate = $("#dateforReg").children("#mRegistrationDate").val();
           //  alert(cpreDate);
           var ctoday = currentYear + '-' + currentMonth + '-' + currentDate;
           // alert(ctoday);

           var firstDate = new Date(ctoday);
           var secondDate = new Date(cpreDate);

           // var diffMonths = Math.abs((firstDate.getFullYear() - secondDate.getFullYear()) * 12);

           //  var diffMonths = Math.abs((firstDate.getMonth() - secondDate.getMonth()));

           var diffMonths = Math.abs((firstDate.getFullYear() - secondDate.getFullYear()) * 12) + (firstDate.getMonth()+1 - secondDate.getMonth());

           //alert(diffMonths);
           if (diffMonths > 24) {

               var abc=  document.getElementById("old_value").value = 0;

               //  alert(abc);

           }

                  
       }  


     
       //$(document).ready(function () {
       //    $("#distributionDate").datepicker();
       //});

//       function fill1() {


//           var txt81 = document.getElementById("new_value3").value - 0;
//           var txt91 = document.getElementById("old_value3").value - 0;

//           document.getElementById("total_value3").value = txt81 - txt91;

//           if (document.getElementById("total_value3").value < 0) {
//               document.getElementById("total_value3").value = 0;
//           }

       //       }
       
       //var j = jQuery.noConflict();
       //j(function () {
       //    j("#datepicker").datepicker();
       //});

     

   </script>

       <%--<script type="text/javascript">

           $(function () {

               var date = new Date();
               var currentMonth = date.getMonth();
               var currentDate = date.getDate();
               var currentYear = date.getFullYear();

               $("#registration3_input").datepicker({
                   dateFormat: 'yy-mm-dd',
                   //showOn: "button",
                   buttonImage: "images/cal.gif",
                   buttonImageOnly: true,
                   buttonText: "Select date",
                   minDate: "2013-01-01"
                   //minDate: new Date(1, 01, 2013)
                   // maxDate: new Date(currentYear, currentMonth, currentDate)
               });
           });
          
       </script>--%>

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

            $("#replace-plaza").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-plaza-replacement').val('');
                $('#search-by-all-4').val('0');
                LoadServiceReplacementIMEI(UserID);
                LoadPrintActiveReplacementServiceID(SearchBy);
                
            });

//            $("#invalid-replace-plaza").live('click', function () {
//                $.msg({
//                    msgID: 1,
//                    autoUnblock: false,
//                    clickUnblock: false,
//                    content: 'Please wait loading data.....'
//                });
//                $('#parameter-invalid-plaza-replacement').val('');
//                $('#search-by-all-5').val('0');
//                LoadServiceInvalidReplacementIMEI(UserID);
//                LoadPrintInActiveReplacementServiceID(SearchBy);
//            });

            $("#replacement-report").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-replacement-report-plaza').val('');
                $('#search-replacement-report-all').val('0');

                LoadReplacementReportForPlaza(UserID);
               
            });
            function HideAll() {
                $("#request-IMEI-service").css("display", "none");
                $("#search-IMEI-request-wrapper").css("display", "none");

                $("#stock-faulty-list").css("display", "none");
                $("#search-stock-faulty-wrapper").css("display", "none");

                $("#plaza-report-list").css("display", "none");
                $("#search-plaza-report-wrapper").css("display", "none");

                $("#plaza-replacement-list").css("display", "none");
                $("#search-plaza-replace-wrapper").css("display", "none");

                $("#print-active-replacement-list").css("display", "none");
                $("#plaza-replacement-report-list").css("display", "none");
                $("#search-plaza-replacement-report-wrapper").css("display", "none");
                $("#action_note").css("display", "none");
            }


            function LoadNewIMEIRequest(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/LoadNewIMEIRequest",
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

                            var searchvalue = $("#imeno").val();
                            
                            var requestedValue = $("#search-by-all").val();
                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {
                                                              
                                GetRequestedIMEIStatus(searchvalue, requestedValue);

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


            function LoadDealerDistributionDetails(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/LoadDealerDistributionDetails",
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
                    url: "IMEIRequest.aspx/LoadDealerDistributionDetailsForStockFaulty",
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
                    url: "IMEIRequest.aspx/GetRequestedIMEIStatus",
                    data: "{ SearchBy: '" + SearchBy 
                           + "' , RequestedValue: '" + RequestedValue
                        + "'}",
                   
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {

                        var res = msg.d;
                        var searchvalue = $("#search-by-all").val();

                        console.log(searchvalue);

                       // alert(searchvalue);
                       
                        if (res != null && res.match(/ReRequestSuccess/g)) {
                         
                            var lstValForRequestDate = res.substr(17, 10);
                                                  
                            var lstValForRequestStatus = res.substr(27);

                            alertify.dialog('alert').set({
                                'title': '   ',
                                'transition': 'zoom',
                                'message': "IMEI already requested.<br> Previous Request Date :" + " " + lstValForRequestDate + ".<br> Request Status :" + " " + lstValForRequestStatus + ".<br> According to management decision, Request Status("+ lstValForRequestStatus +") IMEI will not be re-requested by this Aftersales Software.",
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
                                    
                                    LoadDealerDistributionDetails(UserID, SearchBy);

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
                        else{
                          
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
                    url: "IMEIRequest.aspx/GetRequestedIMEIStatusforStockfaulty",
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
                               'message': "IMEI already requested.<br> Previous Request Date :" + " " + lstValForRequestDate + ".<br> Request Status :" + " " + lstValForRequestStatus ,
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
                        else if (res != null && res.match(/RegDateNull/g)) {

                            var lastForActive= res.substr(12);

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

            function LoadNewStockFaultyRequest(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/LoadNewStockFaultyRequest",
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
                            $("#search-stock-faulty-wrapper").css("display", "block");


                            var searchvalue = $("#parameter-stockfaulty-job").val();

                            var requestedValue = $("#search-by-all-2").val();
                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {

                                GetRequestedIMEIStatusforStockfaulty(searchvalue, requestedValue);

                            }

                        }
                        else {
                            //  alert("err");
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
                    url: "IMEIRequest.aspx/LoadPlazaReport",
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
                                //alert("No Records Found.");
                                alertify.dialog('alert').set({
                                    'title': '   ',
                                    'transition': 'zoom',
                                    'message': "Please Search by correct IMEI/Date.",                                                                       
                                }).show();
                            }
                        }
                        else {
                            //  alert("err");
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

//              function fillbyfaultyprice() {
//         
//               var secondDate = new Date();
//               var currentMonth = secondDate.getMonth().toString();
//               var currentDate = secondDate.getDate().toString();
//               var currentYear = secondDate.getFullYear().toString();

//               var cpreDate = $("#dateforReg").val();
//              // alert(cpreDate);
//               var ctoday = currentYear + '-' + currentMonth + '-' + currentDate;
//             //  alert(ctoday);

//               var firstDate = new Date(ctoday);
//               var secondDate = new Date(cpreDate);

//               var diffMonths = Math.abs((firstDate.getFullYear() - secondDate.getFullYear()));

//             //  alert(diffMonths);
//               if (diffMonths > 2) {

//                 var abc=  document.getElementById("old_value").value = 0;

//                alert(abc);

//               }

//                  
//          }  

            function LoadServiceReplacementIMEI(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/LoadServiceReplacementIMEI",
                    data: "{ UserID: '" + UserID
                        + "' , SearchBy: '" + SearchBy
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {                       
                            HideAll();
                            $("#plaza-replacement-list").html(msg.d);
                            $("#plaza-replacement-list").css("display", "block");

                            $("#search-plaza-replace-wrapper").css("display", "block");
                            $("#action_note").css("display","block");

                            fillbyfaultyprice(); 

                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                              

                                LoadPrintActiveReplacementServiceID(SearchBy);
                            }
                            else{
                            
                                $("#plaza-replacement-list").css("display", "block");
                            
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

//             function LoadServiceInvalidReplacementIMEI(UserID, SearchBy) {
//                $.ajax({
//                    type: "POST",
//                    url: "IMEIRequest.aspx/LoadServiceInvalidReplacementIMEI",
//                    data: "{ UserID: '" + UserID
//                    + "' , SearchBy: '" + SearchBy
//                    + "'}",
//                    contentType: "application/json; charset=utf-8",
//                    dataType: "json",
//                    success: function (msg) {
//                        if (msg.d != "err") {                       
//                            HideAll();
//                            $("#plaza-invalid-replacement-list").html(msg.d);
//                            $("#plaza-invalid-replacement-list").css("display", "block");

//                            $("#search-plaza-invalid-replace-wrapper").css("display", "block");  

//                            $.msg('unblock', 30, 1);

//                            if (msg.d == 0) {
//                           // alert("No Records Found.");
//                              
////                                 alertify.dialog('alert').set({
////                                                  'title': '   ',
////                                                  'transition': 'zoom',
////                                                  'message': "No Records Found.",                                                                       
////                                              }).show();


//                                    LoadPrintInActiveReplacementServiceID(SearchBy);
//                            }

//                            else{
//                                   $("#plaza-invalid-replacement-list").css("display", "block");
//                            }
//                        }
//                        else {
//                        // alert("err");
//                             alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "err",                                                                       
//                                              }).show();
//                            $.msg('unblock', 30, 1);

//                          
//                        }
//                    },
//                    error: function (msg) {
//                        $.msg('unblock', 30, 1);
//                    }
//                });
//            }



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
                    url: "IMEIRequest.aspx/GetIMEReg",
                    data: "{ IMENo: '" + IMENo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "invalid") {
                            //alert("Invalid IME .. Please put currect IME");
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
            
            //rep_imei_r2
            ///////replacement imei no search///
            var imePrev1;
            var imereg1 = "";
            
            $(document).on("focusout", "#insert_rep_imei_r", function () {
                //   var RepIMENo = $("#insert_rep_imei_r").val().trim().toUpperCase();
               
                var RepIMENo = $(this).parent().parent().children("#rep_imei_r").children("#insert_rep_imei_r").val();

                console.log("RepIMENo   :"+RepIMENo);
                if (RepIMENo.length > 0) {
                    if (RepIMENo != imePrev1) {
                        imePrev1 = RepIMENo;

                        GetIMERegForReplacement(RepIMENo);

                    }


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
                    url: "IMEIRequest.aspx/GetIMERegForReplacement",
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
                        'message': "Please select request type.",                                                                                        
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

                    //                    $("#rep_imei_1").css('display', 'none');
                    //                    $("#rep_imei_2").css('display', 'none');
                    //                    $("#rep_model").css('display', 'none');
                   

                    LoadNewIMEIRequest(UserID, searchby1 + ";" + parameter1);
                 
                }
            });

            //btn-save-distribution-record
            
            function InsertDistributionRecord(IMEI_1, IMEI_2, Model, DealerCode,DONumber, DistributionDate) {
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
                    url: "IMEIRequest.aspx/InsertDistributionRecord",
                    data: jsonData,
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

                var repIMEI1 = $(this).parent().parent().children("#rep_imei_1").children("#insert_rep_imei_1").val();
                var repIMEI2 = $(this).parent().parent().children("#rep_imei_2").children("#insert_rep_imei_2").val();
                var repModel = $(this).parent().parent().children("#rep_model").children("#rep_model_list").children("#ddlmodel").find(":selected").text();



                var requestStatus = 'Requested';
                var addedBy = UserID;



                //  if (cellphoneNumber.length == 0) {
                //$.msg('unblock', 30, 1);
                // alert("Customer Mobile required");       
                //  IsValid = false;
                //  return -1;
                // }

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
                    //alert("It should start with 0 ");
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Cellphone number should start with 0",                                                                                        
                    }).show();
                    return false;
                }

                // var requestType = $("#search-by-all").val();
                if (issue == "-- Select Problem --") {
                    //$.msg('unblock', 30, 1);
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
                        'message': "Please Enter minimum 20 characters for Remarks",                                                                                        
                    }).show();
                    return false;
                }

                if (seenStatus == "------- Select Status-------") {

                    // alert("Select Seen Status");
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Select Seen Status",                                                                                        
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
                            'message': "Please Enter Replacement IMEI_1",                                                                                        
                        }).show();

                        return false;
                    }

                    if (repModel == "-------- Select Model --------") {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement Model",                                                                                        
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
                            'message': "Please Enter Replacement IMEI_1",                                                                                        
                        }).show();

                        return false;
                    }

                    if (repModel == "-------- Select Model --------") {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement Model",                                                                                        
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
                            'message': "Please Enter Replacement IMEI_1",                                                                                        
                        }).show();

                        return false;
                    }

                    if (repModel == "-------- Select Model --------") {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement Model",                                                                                        
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
//                else if (requestType == "special") { // Special case


//                    //                        if (issue > 0) {

//                    //                          //  requestType = "SpecialCase";
//                    requestType = "Special Case";

//                    //                    var val = confirm("Are you sure want to submit the request ??");
//                    //                    if (val)
//                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


//                    isOK = true;
//                    //                        }
//                    //                        else
//                    //                            alert("Please select Issue first..");


//                }

                else if (requestType == "reRequest") { // reRequest



                    requestType = "Re-Request";


                    //                    var val = confirm("Are you sure want to submit the request ??");
                    //                    if (val)


                    if (repIMEI1.length == 0) {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement IMEI_1",                                                                                        
                        }).show();

                        return false;
                    }

                    if (repModel == "-------- Select Model --------") {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement Model",                                                                                        
                        }).show();

                        return false;
                    }


                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);


                    isOK = true;


                }

                else if (requestType == "localMade") { // localMade Phone
                    
                    requestType = "Local Made SmartPhone-30 Days";
                    if (repIMEI1.length == 0) {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement IMEI_1",
                        }).show();

                        return false;
                    }
                   
                    if (repModel == "-------- Select Model --------") {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement Model",
                        }).show();

                        return false;
                    }

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);
                    isOK = true;               
                }
                else if (requestType == "localMadeFeature") { // localMade Phone

                    requestType = "Local Made FeaturePhone-30 Days";
                    if (repIMEI1.length == 0) {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement IMEI_1",
                        }).show();

                        return false;
                    }

                    if (repModel == "-------- Select Model --------") {
                        alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Enter Replacement Model",
                        }).show();

                        return false;
                    }

                    InsertIMEIReplacementMasterTable(barcode1, barcode2, model, dealercode, requestType, registration, distribution, issue, cellphoneNumber, issueDetails, seenStatus, repIMEI1, repIMEI2, repModel, requestStatus, addedBy);
                    isOK = true;
                }


            });

           

            //            function Validate() {
            //                var x = $(this).parent().parent().children("#cellphone").children("#input-cellnumber").val();
            //                //  var y = document.form1.txtMobile.value;
            //                if (isNaN(x) || x.indexOf(" ") != -1) {
            //                    alert("Enter numeric value")
            //                    return false;
            //                }
            //                if (x.length > 11) {
            //                    alert("enter 11 characters");
            //                    return false;
            //                }
            //                if (x.charAt(0) != "0") {
            //                    alert("it should start with 0 ");
            //                    return false
            //                }

            //            }


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
                    // alert("It should start with 0 ");
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Cellphone number should start with 0",                                                                                        
                    }).show();
                    return false;
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
                var parameter1 = $("#parameter-stockfaulty-job").val().trim();
                
                if (searchby1 == 0) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please select request type.",                                                                                        
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

            $(".btn-plaza-replacement-search").live('click', function () {

                var SearchBy1 = $("#search-by-all-4").val();
                var parameter = $("#parameter-plaza-replacement").val().trim();
                console.log(SearchBy1);
                console.log(parameter);

                if (parameter.length == 0) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please put currect parameter value",                                                                                        
                    }).show();
                    $("#parameter-plaza-replacement").focus();
                    return -1;


                
                }
                else  {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading service .....'
                    });
                
                    LoadServiceReplacementIMEI(UserID, SearchBy1 + ";" + parameter);
                    //fillbyfaultyprice();
                }

                //  LoadPrintActiveReplacementServiceID(SearchBy1 + ";" + parameter);  
            });

//            $(".btn-plaza-invalid-replacement-search").live('click', function () {

//                var SearchBy1 = $("#search-by-all-5").val();
//                var parameter = $("#parameter-invalid-plaza-replacement").val().trim();

//                if (parameter.length == 0) {
//                    alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Please put currect parameter value",                                                                                        
//                                              }).show();
//                    $("#parameter-plaza-replacement").focus();
//                    return -1;

//                 
//                }
//                else {
//                    $.msg({
//                        msgID: 1,
//                        autoUnblock: false,
//                        clickUnblock: false,
//                        content: 'Please wait loading service .....'
//                    });
//                    LoadServiceInvalidReplacementIMEI(UserID, SearchBy1 + ";" + parameter);

//                  
//                }
//                
//            });

            function InsertIMEIReplacementMasterTable(IMEI_1, IMEI_2, Model, DealerCode, RequestType, RegistrationDate, DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, ReplaceIMEI_1, ReplaceIMEI_2, ReplaceModel, RequestStatus, AddedBy) {
                var jsonData="{ IMEI_1: '" + IMEI_1
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
                    + "'}";
                console.log(jsonData);
                               
                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/InsertIMEIReplacementMasterTable",
                    data: jsonData,
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
                    url: "IMEIRequest.aspx/InsertIMEIReplacementMasterTable1",
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


            function InsertAfterServiceIMEIReplacement(AfterServiceRepID,ServiceID, IME, Model, RegistrationDate, ServicePlaceDate, DealerName, CustomerMobile, WarrantyAvailability, Invoice, ReplacementIMEI, ReplacementModel,ServicePointName,ReplacementGivenBy,NewHandsetPrice,FaultyHandsetPriceByPlaza, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/InsertAfterServiceIMEIReplacement",
                    data: "{ AfterServiceRepID: '" + AfterServiceRepID
                        + "', ServiceID: '" + ServiceID
                        + "', IME: '" + IME
                        + "', Model: '" + Model
                        + "', RegistrationDate: '" + RegistrationDate
                        + "', ServicePlaceDate: '" + ServicePlaceDate
                        + "', DealerName: '" + DealerName
                        + "', CustomerMobile: '" + CustomerMobile
                        + "', WarrantyAvailability: '" + WarrantyAvailability
                        + "', Invoice: '" + Invoice
                        + "', ReplacementIMEI: '" + ReplacementIMEI
                        + "', ReplacementModel:'"+ ReplacementModel
                        + "', ServicePointName: '" + ServicePointName
                        + "', ReplacementGivenBy: '" + ReplacementGivenBy
                        + "', NewHandsetPrice:'"+ NewHandsetPrice
                        + "', FaultyHandsetPriceByPlaza: '" + FaultyHandsetPriceByPlaza
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
                            LoadServiceReplacementIMEI(UserID);
                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


//             function InsertAfterServiceInvalidIMEIReplacement(AfterServiceRepID,ServiceID, IME, Model, RegistrationDate,  ServicePlaceDate, DealerName, CustomerMobile, WarrantyAvailability,Invoice,ReplacementIMEI, ReplacementModel,ServicePointName,ReplacementGivenBy,NewHandsetPrice,FaultyHandsetPriceByPlaza, AddedBy) {
//                $.ajax({
//                    type: "POST",
//                    url: "IMEIRequest.aspx/InsertAfterServiceInvalidIMEIReplacement",
//                     data: "{ AfterServiceRepID: '" + AfterServiceRepID
//                                + "', ServiceID: '" + ServiceID
//                                + "', IME: '" + IME
//                                + "', Model: '" + Model
//                                + "', RegistrationDate: '" + RegistrationDate
//                                + "', ServicePlaceDate: '" + ServicePlaceDate
//                                + "', DealerName: '" + DealerName
//                                + "', CustomerMobile: '" + CustomerMobile
//                                + "', WarrantyAvailability: '" + WarrantyAvailability
//                                + "', Invoice: '" + Invoice
//                                + "', ReplacementIMEI: '" + ReplacementIMEI
//                                + "', ReplacementModel:'"+ ReplacementModel
//                                + "', ServicePointName: '" + ServicePointName
//                                + "', ReplacementGivenBy: '" + ReplacementGivenBy
//                                + "', NewHandsetPrice:'"+ NewHandsetPrice
//                                + "', FaultyHandsetPriceByPlaza: '" + FaultyHandsetPriceByPlaza
////                                + "', Total: '" + Total
//                                + "', AddedBy: '" + AddedBy
//                                + "'}",
//                    contentType: "application/json; charset=utf-8",
//                    dataType: "json",
//                    success: function (msg) {
//                        if (msg.d == "success") {
//                           // alert("Data Requested Successfully");
//                           alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Data Requested Successfully",                                                                                        
//                                              }).show();
//                            $.msg({
//                                msgID: 1,
//                                autoUnblock: false,
//                                clickUnblock: false,
//                                content: 'Please wait loading Request data ...'
//                            });
//                            LoadServiceInvalidReplacementIMEI(UserID);
//                        }
//                        else {
//                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
//                        }
//                    }
//                });
//            }


            $("#btn-replace-IMRI-plaza").live('click', function () {
                var afterserviceid = $(this).parent().parent().children("#servicedate").children(".hfAfterServiceRepID").val();
                var serviceid = $(this).parent().parent().children("#servicedate").children(".hfServiceIDr").val();
                var ime = $(this).parent().parent().children("#servicedate").children(".hfIMEIr").val();
                var servicemodel = $(this).parent().parent().children("#servicedate").children(".hfModelr").val();
                var activedate = $(this).parent().parent().children("#servicedate").children(".hfRegistrationDater").val();
                var servicedate = $(this).parent().parent().children("#servicedate").children(".hfServicePlaceDater").val();
                var salescode = $(this).parent().parent().children("#servicedate").children(".hfDealerCoder").val();
                var cellNumber = $(this).parent().parent().children("#cellphone2").children("#cellphone2_input").val();
                var warranty = $(this).parent().parent().children("#servicedate").children(".hfWarrantyAvailabler").val();
                var invoice1 = $(this).parent().parent().children("#invoice1").children("#invoice1_input").val();                
                var replaceIMEI1 = $(this).parent().parent().children("#rep_imei_r").children("#insert_rep_imei_r").val();           
                var replaceModel =$(this).parent().parent().children("#rep_model_r").children("#rep_model_list_r").children("#ddlmodel").find(":selected").text();
                var repusername1 = $(this).parent().parent().children("#repuser_name").children("#repuser_name_input").val();
                var servicepoint =$(this).parent().parent().children("#servicedate").children(".hfServicePointName").val();
                var newmodelprice = $(this).parent().parent().children("#new").children("#new_value").val();
                var oldmodelprice = $(this).parent().parent().children("#old").children("#old_value").val();
                var total1 = $(this).parent().parent().children("#total").children("#total_value").val();

                var addedByr = UserID;



                if (invoice1.length == 0) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Enter Invoice Number",                                                                                        
                    }).show();

                    return false;
                }
                if (isNaN(cellNumber) || cellNumber.indexOf(" ") != -1) {         
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Enter numeric value for Mobile number",                                                                                        
                    }).show();

                   
                    return false;
                }
                else if (cellNumber.length != 11) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Enter 11 characters for Mobile number",                                                                                        
                    }).show();
                    return false;
                }
                else if (cellNumber.charAt(0) != "0") {            
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Mobile number should start with 0",                                                                                        
                    }).show();
                    return false;
                }

                

                if (replaceIMEI1.length == 0) {
                               alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Enter Replacement IMEI_1",                                                                                        
                                              }).show();

                                    return false;
                 }


//                if (isNaN(replaceIMEI1) || cellNumber.indexOf(" ") != -1) {         
//                    alertify.dialog('alert').set({
//                        'title': '   ',
//                        'transition': 'zoom',
//                        'message': "Please Enter numeric value for Replacement IMEI",                                                                                        
//                    }).show();

//                   
//                    return false;
//                }

//                if (isNaN(replaceIMEI1) || cellNumber.indexOf(" ") != -1) {         
//                    alertify.dialog('alert').set({
//                        'title': '   ',
//                        'transition': 'zoom',
//                        'message': "Please Enter numeric value for Replacement IMEI",                                                                                        
//                    }).show();

//                   
//                    return false;
//                }
//                else if (replaceIMEI1.length != 15) {
//                     alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Please Enter 15 number for Mobile Replacement IMEI",                                                                                        
//                                              }).show();
//                    return false;
//                }

                if (replaceModel == "-------- Select Model --------") {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Enter Replacement Model",                                                                                        
                    }).show();

                    return false;
                }
                if (repusername1.length == 0) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Enter Replacement Given Person Name",                                                                                        
                    }).show();

                    return false;
                }

                if (newmodelprice.length == 0) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Enter New model price",                                                                                        
                    }).show();

                    return false;
                }
                if (total1.length == 0) {
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please Enter total price",                                                                                        
                    }).show();

                    return false;
                }
      
                InsertAfterServiceIMEIReplacement(afterserviceid,serviceid, ime, servicemodel, activedate,  servicedate, salescode, '+88'+cellNumber, warranty, invoice1, replaceIMEI1, replaceModel,servicepoint,repusername1,newmodelprice,oldmodelprice,addedByr);
                //LoadPrintActiveReplacementServiceID(UserID);  
                    
            });

//               $("#btn-replace-invalid-IMRI-plaza").live('click', function () {
//                var afterserviceid2 = $(this).parent().parent().children("#servicedate2").children(".hfAfterServiceRepIDr24").val();
//                var serviceid1 = $(this).parent().parent().children("#servicedate2").children(".hfServiceIDr24").val();
//                var ime1 = $(this).parent().parent().children("#servicedate2").children(".hfIMEIr24").val();
//                var servicemodel1 = $(this).parent().parent().children("#servicedate2").children(".hfModelr24").val();
//                var activedate1 = $(this).parent().parent().children("#registration3").children("#registration3_input").val(); 
//                var servicedate1 = $(this).parent().parent().children("#servicedate2").children(".hfServicePlaceDater24").val();
//                var salescode1 = $(this).parent().parent().children("#servicedate2").children(".hfDealerCoder24").val();
//                var cellNumber1 = $(this).parent().parent().children("#cellphone3").children("#cellphone3_input").val();
//                var warranty1 = $(this).parent().parent().children("#servicedate2").children(".hfWarrantyAvailabler24").val();
//                var invoice2= $(this).parent().parent().children("#invoice2").children("#invoice2_input").val();                
//                var replaceIMEI24 = $(this).parent().parent().children("#rep_imei_r3").children("#insert_rep_imei_r3").val(); 
//               // alert(replaceIMEI24);
//                          
//                var replaceMode24 =$(this).parent().parent().children("#rep_model_r3").children("#rep_model_list_r3").children("#ddlmodel").find(":selected").text();
//                var addedByr1 = UserID;
//                
//                var repusername2 = $(this).parent().parent().children("#repuser_name3").children("#repuser_name_input3").val();
//                var servicepoint2 =$(this).parent().parent().children("#servicedate2").children(".hfServicePointName24").val();
//                var newmodelprice2 = $(this).parent().parent().children("#new3").children("#new_value3").val();
//                var oldmodelprice2= $(this).parent().parent().children("#old3").children("#old_value3").val();
//                 var total22 = $(this).parent().parent().children("#total3").children("#total_value3").val();


//              
//                  

//               if (activedate1.length == 0) {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter Active Date of Mobile",                                                                                        
//                                              }).show();

//                                    return false;
//                 }
//                  if (invoice2.length == 0) {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter Invoice Number",                                                                                        
//                                              }).show();

//                                    return false;
//                 }
//                if (isNaN(cellNumber1) || cellNumber1.indexOf(" ") != -1) {         
//                     alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter numeric value for Mobile number",                                                                                        
//                                              }).show();

//                   
//                    return false;
//                }
//                else if (cellNumber1.length != 11) {
//                     alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter 11 characters for Mobile number",                                                                                        
//                                              }).show();
//                    return false;
//                }
//                else if (cellNumber1.charAt(0) != "0") {            
//                     alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Mobile number should start with 0",                                                                                        
//                                              }).show();
//                    return false;
//                }

//               

//                if (replaceIMEI24.length == 0) {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter Replacement IMEI_1",                                                                                        
//                                              }).show();

//                                    return false;
//                 }

//                 if (replaceMode24 == "-------- Select Model --------") {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter Replacement Model",                                                                                        
//                                              }).show();

//                                    return false;
//                 }
//                  if (repusername2.length == 0) {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter Replacement Given Person Name",                                                                                        
//                                              }).show();

//                                    return false;
//                 }

//                 if (newmodelprice2.length == 0) {
//                               alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "Enter New model price",                                                                                        
//                                              }).show();

//                                    return false;
//                 }
//      
//      
//                  //InsertAfterServiceInvalidIMEIReplacement(serviceid1, ime1, servicemodel1, activedate1, servicedate1, salescode1, '+88'+cellNumber1, warranty1, invoice2, replaceIMEI11, replaceModel1, addedByr1);
//                InsertAfterServiceInvalidIMEIReplacement(afterserviceid2,serviceid1, ime1, servicemodel1, activedate1,  servicedate1, salescode1, '+88'+cellNumber1, warranty1, invoice2,replaceIMEI24, replaceMode24,servicepoint2,repusername2,newmodelprice2,oldmodelprice2,addedByr1);
//               //LoadPrintActiveReplacementServiceID(UserID); 
//           
//            });


            function LoadPrintActiveReplacementServiceID(SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/LoadPrintActiveReplacementServiceID",
                    data: "{ SearchBy: '" + SearchBy
//                    + "' , SearchBy: '" + SearchBy
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {                       
                            HideAll();
                            $("#print-active-replacement-list").html(msg.d);
                            $("#print-active-replacement-list").css("display", "block");
                            $("#action_note").css("display", "block");
                            $("#search-plaza-replace-wrapper").css("display", "block");  

                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                              
                                alertify.dialog('alert').set({
                                    'title': '   ',
                                    'transition': 'zoom',
                                    'message': "Please Search by correct ServiceID",                                                                       
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


//             function LoadPrintInActiveReplacementServiceID(SearchBy) {
//                $.ajax({
//                    type: "POST",
//                    url: "IMEIRequest.aspx/LoadPrintInActiveReplacementServiceID",
//                    data: "{ SearchBy: '" + SearchBy
////                    + "' , SearchBy: '" + SearchBy
//                    + "'}",
//                    contentType: "application/json; charset=utf-8",
//                    dataType: "json",
//                    success: function (msg) {
//                        if (msg.d != "err") {                       
//                            HideAll();
//                            $("#print-inactive-replacement-list").html(msg.d);
//                            $("#print-inactive-replacement-list").css("display", "block");

//                           $("#search-plaza-invalid-replace-wrapper").css("display", "block");  

//                            $.msg('unblock', 30, 1);

//                            if (msg.d == 0) {
//                              
//                                 alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "No Records Found.",                                                                       
//                                              }).show();
//                            }
//                        }
//                        else {
//                         
//                             alertify.dialog('alert').set({
//                                                  'title': '   ',
//                                                  'transition': 'zoom',
//                                                  'message': "err",                                                                       
//                                              }).show();
//                            $.msg('unblock', 30, 1);

//                          
//                        }
//                    },
//                    error: function (msg) {
//                        $.msg('unblock', 30, 1);
//                    }
//                });
//            }

            
            function LoadReplacementReportForPlaza(UserID,SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEIRequest.aspx/LoadReplacementReportForPlaza",
                    data: "{ UserID: '" + UserID
                        + "' , SearchBy: '" + SearchBy
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {                       
                            HideAll();
                            $("#plaza-replacement-report-list").html(msg.d);
                            $("#plaza-replacement-report-list").css("display", "block");

                            $("#search-plaza-replacement-report-wrapper").css("display", "block");  

                            $.msg('unblock', 30, 1);

                            if (msg.d == 0) {
                              
                                alertify.dialog('alert').set({
                                    'title': '   ',
                                    'transition': 'zoom',
                                    'message': "Please Search by correct ServiceID/Date.",                                                                       
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

            $(".btn-plaza-replacement-report-search").live('click', function () {

                var SearchBy1 = $("#search-replacement-report-all").val();
                var parameter = $("#parameter-replacement-report-plaza").val().trim();

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
                    alertify.dialog('alert').set({
                        'title': '   ',
                        'transition': 'zoom',
                        'message': "Please put currect parameter value",                                                                                        
                    }).show();
                    $("#parameter-replacement-report-plaza").focus();
                    return -1;

                 
                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading service .....'
                    });
                    LoadReplacementReportForPlaza(UserID, SearchBy1 + ";" + parameter);
                 
                  
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
            <div class=" tab-item active-tab" id="new-request">
                New Request
            </div>
            <div class="tab tab-item" id="stockfaulty-tab" style="width:200px;">
                Stockfaulty Request
            </div>
           <div class="tab tab-item" id="report">
                Report
            </div>
            <div class="tab tab-item" id="replace-plaza" style="width:230px;">
                ServicePending Replacement
            </div>
           <%-- <div class="tab tab-item" id="invalid-replace-plaza" style="width:200px;">
               InvalidIMEIReplacement
            </div>--%>
            <div class="tab tab-item" id="replacement-report" style="width:220px;">
              ServicePending Report
            </div>
        </div>

    <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;padding-top:20px;overflow:auto;padding-bottom:20px;">      
          <div id="IMEI-request-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-IMEI-request-wrapper" style="margin-bottom:20px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC; width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">Request Type :</div>
                    <div id="div-requestType" style="float:left; margin-left:20px;">
                        <select name="search-by-all" id="search-by-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="smart" >SmartPhone-15 Days</option>
                            <option value="walpad" >Walpad-15 Days</option>
                            <option value="feature">FeaturePhone-30 Days</option>
                            <%--<option value="stock">StockFaulty</option>--%>
                        <%--    <option value="registereddisplay">Display</option>--%>
                          
                            <option value="reRequest">Re-Request</option>  
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
                      <%--  <div style="width:100px;">--%>
                            <img id="img-err" src="Styles/image/close_pop.png" style="padding-top:45px; display:none;border:0px solid red" />
                            <img id="img-verifying" src="Styles/image/ajax-loader.gif" style="padding-top:45px; display:none;border:0px solid red">
                            <img id="img-verified" src="Styles/image/save.png" style="padding-top:45px; display:none;border:0px solid red">
                       <%-- </div>--%>
                                       
                    </div> 

                    <div class="btn-IMEI-request-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="request-IMEI-service" style="width:100%;margin-left:5px;float:left;display:none"></div>

            </div> 
        
             
               
             <div style="clear:both"></div>
             <div id="stockfaulty-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 5px; border: 0px solid red ;display:block;">
                <div id="search-stock-faulty-wrapper" style="margin-top:-60px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC; width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType3" style="float:left; margin-left:20px;">
                        <select name="search-by-all-2" id="search-by-all-2" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;"> 
                             <option value="0" >----------- Service Type -----------</option>
                            <option value="stockfaulty1" >StockFaulty</option>   
                          <%--   <option value="notRegisteredDisplay" >Display</option>     --%>                                                               
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
                margin-top: 5px; border: 0px solid red ;display:block;">
                <div id="search-plaza-report-wrapper" style="margin-top:-100px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC; width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType1" style="float:left; margin-left:20px;">
                        <select name="search-by-all-1" id="search-by-all-1" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>                                               
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
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px; border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="plaza-report-list" style="width:100%;margin-left:-30px;display:block"></div>
            </div> 
                     
             <div style="clear:both"></div>
             
             <div id="plaza-replace-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 5px; border: 0px solid red ;display:block;">
                <div id="search-plaza-replace-wrapper" style="margin-top:-200px;height:70px;display:none">              

                    <div style="border:1px solid #CCCCCC; width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType5" style="float:left; margin-left:20px;">
                        <select name="search-by-all-4" id="search-by-all-4" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="ServiceID" >Service ID</option>                                                                 
                        </select>
                    </div>
                  
                     <div id="serviceid-ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-plaza-replacement" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 
                   
                    <div class="btn-plaza-replacement-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px; border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br/><br/>  <br/><br/>
                <div style="clear:both"></div>
                <div id="action_note" style="color:red;font-weight:bold;">In case of Service Pending Replacement, first you must need to give entry into After sales software after searching by ServiceID.
                     Then you need to handover handset to Customer or Service Center. If Replacement IMEI is activated before giving entry into Aftersales, then 'Action' button does not work.
                     Because activated IMEI is not activated for second time. It takes 1 to 1.5 minute to give entry into Aftersales. So, please give entry first and then handover the handset. </div>
                <div style="clear:both"></div>

                <div id="plaza-replacement-list" style="width:100%;float:left;display:block;margin-top:30px">
                
                
                    
                               <%-- <img id="img-err1" src="Styles/image/close_pop.png" style="padding-top:45px; display:none;border:0px solid red" />
                                <img id="img-verifying1" src="Styles/image/ajax-loader.gif" style="padding-top:45px; display:none;border:0px solid red">
                                <img id="img-verified1" src="Styles/image/save.png" style="padding-top:45px; display:none;border:0px solid red">
             --%>     
         
                               
                   
                </div>
                <div style="margin-left:20px;float:left;margin-top:-225px">
                 <img id="img-err1" src="Styles/image/close_pop.png" style="display:none;border:0px solid red;margin-left:500px;float:left" />
                 <img id="img-verifying1" src="Styles/image/ajax-loader.gif" style=" display:none;border:0px solid red;float:left;margin-left:500px">
                 <img id="img-verified1" src="Styles/image/save.png" style=" display:none;border:0px solid red;float:left;margin-left:500px">
                 
                  </div>
                <div id="print-active-replacement-list" style="width:100%;float:left;display:block;margin-top:30px"></div>
            </div>       
            
           <%-- <div style="clear:both"></div>
             <div id="plaza-invalid-replace-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 25px; border: 0px solid red ;display:block;">
                <div id="search-plaza-invalid-replace-wrapper" style="margin-top:-190px;height:70px;display:none">              

                    <div style="border:1px solid #CCCCCC; width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType6" style="float:left; margin-left:20px;">
                        <select name="search-by-all-5" id="search-by-all-5" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >-- Service Type --</option>
                            <option value="ServiceID1" >Service ID</option>
                                                               
                        </select>
                    </div>
                  
                     <div id="serviceid-invalid-ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-invalid-plaza-replacement" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-plaza-invalid-replacement-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px; border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                
                <div style="clear:both"></div>
                <div id="plaza-invalid-replacement-list" style="width:100%;float:left;display:block;margin-top:30px"></div>
                <div id="print-inactive-replacement-list" style="width:100%;float:left;display:block;margin-top:30px"></div>
            </div>  --%>       
                     
                     
             <div style="clear:both"></div>
             <div id="plaza-replacement-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-plaza-replacement-report-wrapper" style="margin-top:-190px;height:70px;display:none">              

                    <div style="border:1px solid #CCCCCC; width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType8" style="float:left; margin-left:20px;">
                        <select name="search-replacement-report-all" id="search-replacement-report-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="repdate" >Date(YYYY-MM-DD)</option>   
                            <option value="ServiceID2" >ServiceID</option>                                       
                        </select>
                    </div>
                  
                    <div id="replacement-serviceid-searchReport" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                        <div style="float:left">
                           <input type="text" id="parameter-replacement-report-plaza" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                       </div>            
                    </div> 

                    <div class="btn-plaza-replacement-report-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px; border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                
                <div style="clear:both"></div>
                <div id="plaza-replacement-report-list" style="width:100%;float:left;display:block;margin-top:50px"></div>
            </div>   
                     
                                 
   </div>
</div>

</asp:Content>

