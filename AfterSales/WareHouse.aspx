<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WareHouse.aspx.cs" Inherits="WSMS.WareHouse" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/WareHouseApproval.ascx" TagName="WareHouseApproval"  TagPrefix="uc2" %>


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
                    content: 'Please wait loading new request job.....'
                });
                LoadWareHouseRequest(UserID);
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

             $("#wareHouse-request").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#parameter-wareHouse-request-job').val('');
                $('#search-by-all').val('0');
                LoadWareHouseRequest(UserID);
            });
             $("#report-warehouse").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#parameter-warehouse-report5').val('');
                $('#search-by-all-25').val('0');
                LoadWarehouseReport(UserID);
            });
             $("#handset-wastage").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#parameter-wastage-request').val('');
                $('#search-by-all-1').val('0');
                LoadHandsetFromWastageMgt(UserID);
            });

             $("#report-wastage").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading request data.....'
                });
                $('#parameter-wastage-report').val('');
                $('#search-by-all-2').val('0');
                LoadWastageReport(UserID);
            });

             function HideAll()
            {
                $("#wareHouse-IMEI-request").css("display","none");
                $("#search-IMEI-wareHouse-request-wrapper").css("display","none");

                $("#warehouse-IMEI-report").css("display", "none");
                $("#search-warehouse-report-wrapper").css("display", "none");

                $("#wastage-IMEI-request").css("display","none");
                $("#search-wastage-request-wrapper").css("display","none");

                $("#wastage-IMEI-report").css("display", "none");
                $("#search-wastage-report-wrapper").css("display", "none");
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

            function LoadWareHouseRequest(UserID, SearchByDate) {
                $.ajax({
                    type: "POST",
                    url: "WareHouse.aspx/LoadWareHouseRequest",
                    data: "{ UserID: '" + UserID
                    + "' , SearchByDate: '" + SearchByDate
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            HideAll()

                            $("#wareHouse-IMEI-request").html(msg.d);
                            $("#wareHouse-IMEI-request").css("display", "block");
                            $("#search-IMEI-wareHouse-request-wrapper").css("display", "block");
                            $.msg('unblock', 30, 1);

                            if (msg.d == 0)
                            {
                                //alert("No Records Found."); 
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

                        }
                    },
                    error: function (msg) {
                        $.msg('unblock', 30, 1);
                    }
                });
            }

            $(".btn-IMEI-wareHouse-request-search").live('click', function () {

                var SearchByDate1 = $("#search-by-all").val();

                var parameter = $("#parameter-wareHouse-request-job").val().trim();

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
                    //alert("Please put currect parameter value");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();
                    $("#parameter-wareHouse-request-job").focus();
                    return -1;
                }
                else {

                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading Approved service .....'
                    });
                    LoadWareHouseRequest(UserID, SearchByDate1 + ";" + parameter);
                }
            });

            function ReceiveInsertWareHouseApproval(RequestID, IMEI_1, IMEI_2, WAppStatus, Reason, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "WareHouse.aspx/ReceiveInsertWareHouseApproval",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', WAppStatus: '" + WAppStatus
                                + "', Reason: '" + Reason
                                + "', AddedBy: '" + AddedBy
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                            //alert("Data Received Successfully");
                             alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Data Received Successfully",                                                                       
                                             }).show();
                            $.msg({
                                msgID: 1,
                                autoUnblock: false,
                                clickUnblock: false,
                                content: 'Please wait loading Approved data ...'
                            });

                            LoadWareHouseRequest(UserID);

                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }

            function DeclineInsertWareHouseApproval(RequestID, WAppStatus, Reason, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "WareHouse.aspx/DeclineInsertWareHouseApproval",
                    data: "{ RequestID: '" + RequestID
                                + "', WAppStatus: '" + WAppStatus
                                + "', Reason: '" + Reason
                                + "', AddedBy: '" + AddedBy
                                + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "success") {
                           // alert("Data Declined Successfully");
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

                            LoadWareHouseRequest(UserID);

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

                var wappStatus = 'WareHouse Received';
                var reason = $(this).parent().parent().children("#reason").children("#input-reason").val();
                var addedBy = UserID;



                // if (reason.length == 0) {
                //                $.msg('unblock', 30, 1);
                //                 alert("Customer Reason required");       
                //                  IsValid = false;
                //                  return -1;
                //                 }
//                var val = confirm("Are you sure want to receive the request ??");
//                if (val)

                ReceiveInsertWareHouseApproval(requestId, barcode1, barcode2, wappStatus, reason, addedBy);

            });

            $("#btn-decline").live('click', function () {


                var requestId = $(this).parent().parent().children("#regdate").children(".hfRequestID").val();
                var wappStatus = 'WareHouse Declined';
                var reason = $(this).parent().parent().children("#reason").children("#input-reason").val();
                var addedBy = UserID;


                if (reason.length == 0) {
                    $.msg('unblock', 30, 1);
                   // alert("Reason required");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Reason required",                                                                       
                                             }).show();
                    IsValid = false;
                    return -1;
                }

//                var val = confirm("Are you sure want to decline the request ??");
//                if (val)
                DeclineInsertWareHouseApproval(requestId, wappStatus, reason, addedBy);

            });

             function LoadHandsetFromWastageMgt(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "WareHouse.aspx/LoadHandsetFromWastageMgt",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                             HideAll()
                            $("#wastage-IMEI-request").html(msg.d);
                            $("#wastage-IMEI-request").css("display", "block");
                            $("#search-wastage-request-wrapper").css("display", "block");
                            $.msg('unblock', 30, 1);

                            if (msg.d == 0)
                            {
                                //alert("No Records Found."); 
                                 alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI/Date/RequestID.",                                                                       
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

            $(".btn-wastage-request-search").live('click', function () {

                var Searchby = $("#search-by-all-1").val();

                var parameter = $("#parameter-wastage-request").val().trim();

                 if (Searchby == 0) {
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
                    $("#parameter-wastage-request").focus();
                    return -1;
                }
                else {

                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading services .....'
                    });
                    LoadHandsetFromWastageMgt(UserID, Searchby + ";" + parameter);
                }
            });

              $("#btn-warehouse-receive-wastage").live('click', function () {
                var requestid = $(this).parent().parent().children("#requestdate2").children(".hfRequestID").val();
                var ime1 = $(this).parent().parent().children("#requestdate2").children(".hfIMEI_1").val();
                var ime2 = $(this).parent().parent().children("#requestdate2").children(".hfIMEI_2").val();

                var addedBy = UserID;
                var warehouseStatus="WareHouseDelivered";

                InsertCorporateStoreLogFromWarehouse(requestid, ime1,ime2, warehouseStatus, addedBy);

            });

            function InsertCorporateStoreLogFromWarehouse(RequestID, IMEI_1, IMEI_2, WareHouseStatus, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "WareHouse.aspx/InsertCorporateStoreLogFromWarehouse",
                    data: "{ RequestID: '" + RequestID
                                + "', IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', WareHouseStatus: '" + WareHouseStatus
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

                            LoadHandsetFromWastageMgt(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }

            function LoadWastageReport(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "WareHouse.aspx/LoadWastageReport",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#wastage-IMEI-report").html(msg.d);
                            $("#wastage-IMEI-report").css("display", "block");

                            $("#search-wastage-report-wrapper").css("display", "block");
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
            

           $(".btn-wastage-report-search").live('click', function () {

                var searchby1 = $("#search-by-all-2").val();
                var parameter1 = $("#parameter-wastage-report").val().trim();
                
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
                    $("#parameter-wastage-report").focus();
                    return -1;
                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading services .....'
                    });

                        LoadWastageReport(UserID, searchby1 + ";" + parameter1);
                 
                }
            });

                 function LoadWarehouseReport(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "WareHouse.aspx/LoadWarehouseReport",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#warehouse-IMEI-report").html(msg.d);
                            $("#warehouse-IMEI-report").css("display", "block");

                            $("#search-warehouse-report-wrapper").css("display", "block");
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
            
           $(".btn-warehouse-report-search").live('click', function () {

                var searchby1 = $("#search-by-all-25").val();
                var parameter1 = $("#parameter-warehouse-report5").val().trim();
                
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
                    $("#parameter-warehouse-report5").focus();
                    return -1;
                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading services .....'
                    });

                        LoadWarehouseReport(UserID, searchby1 + ";" + parameter1);
                 
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
            <div class=" tab-item active-tab" id="wareHouse-request" style="width:200px">
               WareHouse Approval
            </div>
             <div class="tab tab-item" id="report-warehouse" style="width:180px">
               WareHouse Report
           </div>
             <div class="tab tab-item" id="handset-wastage" style="width:210px">
               Handset From WastageMgt
           </div>  
            <div class="tab tab-item" id="report-wastage" style="width:180px">
               WastageMgt Report
           </div>
        </div>
    <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;overflow:auto;padding-bottom:20px;">
        
          <div id="wareHouse-request-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-IMEI-wareHouse-request-wrapper" style="margin-top:-27px;height:70px;display:none">
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
                        <input type="text" id="parameter-wareHouse-request-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-IMEI-wareHouse-request-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="wareHouse-IMEI-request" style="width:100%;float:left;display:block"></div>
            </div>   
            
             <div id="warehouse-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-warehouse-report-wrapper" style="margin-top:-70px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType25" style="float:left; margin-left:20px;">
                        <select name="search-by-all-25" id="search-by-all-25" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date25" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI25">IMEI</option>
                            <option value="RequestID25">Request ID</option>
                                                     
                        </select>
                    </div>
                  
                     <div id="date-ime-code-search25" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-warehouse-report5" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-warehouse-report-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="warehouse-IMEI-report" style="width:100%;float:left;display:block"></div>
            </div> 

             <div id="wastage-request-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-wastage-request-wrapper" style="margin-top:-120px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType1" style="float:left; margin-left:20px;">
                        <select name="search-by-all-1" id="search-by-all-1" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date1" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI1">IMEI</option>
                            <option value="RequestID1">Request ID</option>
                                                     
                        </select>
                    </div>
                  
                     <div id="date-ime-code-search1" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-wastage-request" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-wastage-request-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="wastage-IMEI-request" style="width:100%;float:left;display:block"></div>
            </div>   

             <div id="wastage-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block">
                <div id="search-wastage-report-wrapper" style="margin-top:-150px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType21" style="float:left; margin-left:20px;">
                        <select name="search-by-all-2" id="search-by-all-2" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >----------- Service Type -----------</option>
                            <option value="Date2" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI2">IMEI</option>
                            <option value="RequestID2">Request ID</option>
                                                     
                        </select>
                    </div>
                  
                     <div id="date-ime-code-search2" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-wastage-report" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-wastage-report-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="wastage-IMEI-report" style="width:100%;float:left;display:block"></div>
            </div>   


 </div> </div>
</asp:Content>
