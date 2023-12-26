<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IMEISpecialAndSoockFaulty.aspx.cs" Inherits="WSMS.IMEISpecialAndSoockFaulty" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/IMEIApprovedMarketting.ascx" TagName="IMEIApprovedMarketting" TagPrefix="uc2" %>


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
                    content: 'Please wait loading  job for Approved.....'
                });
                LoadIMEIApproved(UserID);
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


            $("#approved-request").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading Approved data.....'
                });
                $('#parameter-approved-job').val('');
                $('#search-by-all').val('0');
                LoadIMEIApproved(UserID);
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
            
            $("#dis-approv").live('click', function() {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                
                $('#parameter-display-imei').val('');
                $('#search-by-all-3').val('0');

                LoadDisplayIMEIListByTSO(UserID);
            });
            function HideAll() {
                $("#approved-IMEI-service").css("display", "none");
                $("#search-IMEI-approved-wrapper").css("display", "none");

                $("#plaza-report-list").css("display", "none");
                $("#search-plaza-report-wrapper").css("display", "none");

                $("#display-imei-list").css("display","none");
                $("#search-display-imei-wrapper").css("display","none");
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


            function LoadIMEIApproved(UserID, SearchByDate) {
                $.ajax({
                    type: "POST",
                    url: "IMEISpecialAndSoockFaulty.aspx/LoadIMEIApproved",
                    data: "{ UserID: '" + UserID
                    + "' , SearchByDate: '" + SearchByDate
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#approved-IMEI-service").html(msg.d);
                            $("#approved-IMEI-service").css("display", "block");

                            $("#search-IMEI-approved-wrapper").css("display", "block");


                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {
                                // alert("No Records Found or Please put Correct Parameter.");
                                 alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date",                                                                       
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

            function LoadMonitoringAndMarkettingReport(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEISpecialAndSoockFaulty.aspx/LoadMonitoringAndMarkettingReport",
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
                               // alert("No Records Found or Please put Correct Parameter.");
                                 alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date.",                                                                       
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

              function LoadDisplayIMEIListByTSO(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEISpecialAndSoockFaulty.aspx/LoadDisplayIMEIListByTSO",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#display-imei-list").html(msg.d);
                            $("#display-imei-list").css("display", "block");

                            $("#search-display-imei-wrapper").css("display", "block");
                            // $("#active-message").css("display", "none");

                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {
                               
                                 alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct Date/IMEI/DealerCode.",                                                                       
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


            $(".btn-IMEI-approved-search").live('click', function () {

                var SearchByDate1 = $("#search-by-all").val();

                var parameter = $("#parameter-approved-job").val().trim();

                if (SearchByDate1 == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select Service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (parameter.length == 0) {
                  //  alert("Please put currect parameter value");
                      alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();
                    $("#parameter-approved-job").focus();
                    return -1;
                }
                else {

                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading Approved service .....'
                    });
                    LoadIMEIApproved(UserID, SearchByDate1 + ";" + parameter);
                }
            });
            
            $(".btn-display-imei-searchForApprov").live('click', function () {

                var SearchBy = $("#search-by-all-2").val();
               
                var parameter = $("#parameter-display-imei").val().trim();
                  // alert(SearchBy);
                    // alert(parameter);
                if (SearchBy == 0) {
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please select Service type.",                                                                                        
                                              }).show();
                    IsValid = false;
                    return -1;
                }
                if (parameter.length == 0) {
                  //  alert("Please put currect parameter value");
                      alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();
                    $("#parameter-display-imei").focus();
                    return -1;
                }
                else {

                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading Approved service .....'
                    });
                    LoadDisplayIMEIListByTSO(UserID, SearchBy + ";" + parameter);
                }
            });


            function UpdateApprovelMasterUpdateIMEIReplacementMaster(RequestID, IMEI_1, IMEI_2, AddedBy, RequestStatus, Model, RegistrationDate, DistributionDate, RequestType) {
                $.ajax({
                    type: "POST",
                    url: "IMEISpecialAndSoockFaulty.aspx/UpdateApprovelMasterUpdateIMEIReplacementMaster",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2                       
                                + "', AddedBy: '" + AddedBy
                                + "', RequestStatus: '" + RequestStatus
                                + "', Model: '" + Model
                                + "', RegistrationDate: '" + RegistrationDate
                                + "', DistributionDate: '" + DistributionDate
                                 + "', RequestType: '" + RequestType
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                            //alert("Data Recommended Successfully");
                            alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Recommended Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading data ...'
                            });

                            LoadIMEIApproved(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }

            $("#btn-approved-IMRI").live('click', function () {
         
               
                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();               
                // var issue = $(this).parent().parent().children("#issues").children("#item-list").children("#ddlissue").find(":selected").text();
                // var cellphoneNumber = $(this).parent().parent().children("#cellphone").children("#input-cellnumber").val();

                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();
                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var requesttype = $(this).parent().parent().children("#regdate").children(".hfRequestType").val();
                var requestStatus = 'Recommended';
                var addedBy = UserID;


//                var val = confirm("Are you sure want to recommend the request ??");
//                if (val)
                UpdateApprovelMasterUpdateIMEIReplacementMaster(requestId, barcode1, barcode2, addedBy, requestStatus, model, registration, distribution, requesttype);

            });

             $("#btn-dis-Approv").live('click', function () {               
              
                var ds_id = $(this).parent().parent().children("#dis-approvId").children(".hfDisID").val();             
                var addedBy = UserID;

                UpdatetblDisplayProductFromNSM(ds_id, addedBy);

            });
            
             function UpdatetblDisplayProductFromNSM(DisplayProductID, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEISpecialAndSoockFaulty.aspx/UpdatetblDisplayProductFromNSM",
                    data: "{ DisplayProductID: '" + DisplayProductID
                                + "', AddedBy: '" + AddedBy
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                            //alert("Data Declined Successfully");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Approved Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading Approved data ...'
                            });

                            LoadDisplayIMEIListByTSO(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }


            function UpdateIMEIReplacementMasterForApprovedDecline(RequestID, IMEI_1, IMEI_2, Model, RegistrationDate, DistributionDate, RequestStatus, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "IMEISpecialAndSoockFaulty.aspx/UpdateIMEIReplacementMasterForApprovedDecline",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2                               
                                + "', Model: '" + Model
                                + "', RegistrationDate: '" + RegistrationDate
                                + "', DistributionDate: '" + DistributionDate
                                + "', RequestStatus: '" + RequestStatus
                                + "', AddedBy: '" + AddedBy
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
                                content: 'Please wait loading Approved data ...'
                            });

                            LoadIMEIApproved(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }

            $("#btn-approved-declined-IMRI").live('click', function () {


                var model = $(this).parent().parent().children("#regdate").children(".hfModel").val();
                var registration = $(this).parent().parent().children("#regdate").children(".hfRegistrationDate").val();
                var distribution = $(this).parent().parent().children("#regdate").children(".hfDistributionDate").val();               
                // var issue = $(this).parent().parent().children("#issues").children("#item-list").children("#ddlissue").find(":selected").text();
                // var cellphoneNumber = $(this).parent().parent().children("#cellphone").children("#input-cellnumber").val();

                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();
                var barcode1 = $(this).parent().parent().children("#regdate").children(".hfBarCode").val();
                var barcode2 = $(this).parent().parent().children("#regdate").children(".hfBarCode2").val();
                var requestStatus = 'RecommendDeclined';
                var addedBy = UserID;

//                var val = confirm("Are you sure want to decline the request ??");
//                if (val)

                UpdateIMEIReplacementMasterForApprovedDecline(requestId, barcode1, barcode2, model, registration, distribution, requestStatus, addedBy);



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


        });


        function preventBack() { window.history.forward(1); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <div style="width:100%;border:0px solid red;float:left;">
      
        <div id="content" class="col-lg-12" style="width:100%;float:left;border:1px solid #CCCCCC;overflow:auto;">
            
         <div id="tab-content"  style="width:100%;height:30px;border:0px solid red;float:left;margin-top: 0px;">
            <div class=" tab-item active-tab" id="approved-request" style="width:200px;">
                Recommend Request
            </div>
           <div class="tab tab-item" id="report">
                Report
            </div>
             <div class="tab tab-item" id="dis-approv">
                Display Approved
            </div>
        </div>
       
         <br/><br/><br/><br/>
 
          <div id="IMEI-approved-wrapper" class="col-lg-12  table-responsive table-scrollable" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-IMEI-approved-wrapper" style="margin-bottom:20px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: white;background-color: #1BA39C;">SEARCH BY</div>
                    <div id="div-requestType" style="float:left; margin-left:20px;">
                        <select name="search-by-all" id="search-by-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#DADADA;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>
                            <%--<option value="Top">Top 100</option>--%>
                        </select>
                    </div>
                  
                     <div id="ime-date-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: white;background-color: #1BA39C;">PARAMETER : </div>
                       
                           <div style="float:left">
                        <input type="text" id="parameter-approved-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #DADADA;" />
                    </div>            
                    </div> 

                    <div class="btn-IMEI-approved-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="approved-IMEI-service" style="width:100%;float:left;display:block"></div>
                 <br />
            </div>   
             
             <div style="clear:both"></div>
             <div id="plaza-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-plaza-report-wrapper" style="margin-top:-60px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: white;background-color: #1BA39C;">SEARCH BY</div>
                    <div id="div-requestType1" style="float:left; margin-left:20px;">
                        <select name="search-by-all-1" id="search-by-all-1" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#DADADA;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>                                               
                        </select>
                    </div>
                  
                     <div id="date-ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: white;background-color: #1BA39C;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-plaza-report-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #DADADA;" />
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
                <br /> <br />
            </div>  
             <div style="clear:both"></div>
             <div id="display-approv-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: -100px; border: 0px solid red ;display:block;">
                <div id="search-display-imei-wrapper" style="margin-top:-60px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: white;background-color: #1BA39C;">SEARCH BY</div>
                    <div id="div-requestTypeForDisplay" style="float:left; margin-left:20px;">
                        <select name="search-by-all-2" id="search-by-all-2" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#DADADA;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option> 
                            <option value="DealerCode">DealerCode</option>                                              
                        </select>
                    </div>
                  
                     <div id="date-ime-search3" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: white;background-color: #1BA39C;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-display-imei" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #DADADA;" />
                    </div>            
                    </div> 

                    <div class="btn-display-imei-searchForApprov" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="display-imei-list" style="width:100%;float:left;display:block"></div>
                <br /> <br />
            </div>      
   </div>
</div>

</asp:Content>
