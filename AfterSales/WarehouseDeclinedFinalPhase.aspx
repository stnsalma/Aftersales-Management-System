<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WarehouseDeclinedFinalPhase.aspx.cs" Inherits="WSMS.WarehouseDeclinedFinalPhase" %>
<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>
<%@ Register Src="~/Module/DeclinedFinalPhase.ascx" TagName="DeclinedFinalPhase"  TagPrefix="uc2" %>

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
                LoadDeclinedIMEIRequest(UserID);
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


            $("#declined-request").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading declined data.....'
                });

                $('#parameter-declined-request-job').val('');
                $('#search-by-all').val('0');

                LoadDeclinedIMEIRequest(UserID);

            });

            $("#report").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-management-report-job').val('');
                $('#search-by-all-1').val('0');

                LoadManagementReport(UserID);
            });

            function HideAll() {
                $("#declined-request-list").css("display", "none");
                $("#search-declined-request-wrapper").css("display", "none");

                $("#management-report-list").css("display", "none");
                $("#search-management-report-wrapper").css("display", "none");
            }


            function LoadDeclinedIMEIRequest(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "WarehouseDeclinedFinalPhase.aspx/LoadDeclinedIMEIRequest",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {

                            HideAll();
                            $("#declined-request-list").html(msg.d);
                            $("#declined-request-list").css("display", "block");

                            $("#search-declined-request-wrapper").css("display", "block");

                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {
                                //alert("No Records Found or Please put Correct Parameter.");
                                 alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "No Records Found or Please put Correct Parameter.",                                                                       
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


            function LoadManagementReport(UserID, SearchBy) {
                $.ajax({
                    type: "POST",
                    url: "WarehouseDeclinedFinalPhase.aspx/LoadManagementReport",
                    data: "{ UserID: '" + UserID
                    + "' , SearchBy: '" + SearchBy
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            //alert(msg.d);
                            HideAll();
                            $("#management-report-list").html(msg.d);
                            $("#management-report-list").css("display", "block");

                            $("#search-management-report-wrapper").css("display", "block");

                            $.msg('unblock', 30, 1);


                            if (msg.d == 0) {
                                //alert("No Records Found or Please put Correct Parameter.");
                                  alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "No Records Found or Please put Correct Parameter.",                                                                       
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

            


            $(".btn-declined-request-search").live('click', function () {

                var searchby1 = $("#search-by-all").val();
                //alert(searchby1);
                var parameter1 = $("#parameter-declined-request-job").val().trim();
                //alert(parameter1);
                if (parameter1.length == 0) {
                   // alert("Please put currect parameter value");
                     alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();
                    $("#parameter-declined-request-job").focus();
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
                    url: "WarehouseDeclinedFinalPhase.aspx/InsertManagementApprovalLog",
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



            $(".btn-management-report-search").live('click', function () {

                var searchby1 = $("#search-by-all-1").val();
                
                var parameter1 = $("#parameter-management-report-job").val().trim();
               
                if (parameter1.length == 0) {
                   // alert("Please put currect parameter value");
                    alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please put currect parameter value",                                                                       
                                             }).show();
                    $("#parameter-management-report-job").focus();
                    return -1;
                }
                else {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading data .....'
                    });
                    LoadManagementReport(UserID, searchby1 + ";" + parameter1);
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
            <div class=" tab-item active-tab" id="declined-request" style="width:200px;">
                Declined Request
            </div>
             <div class="tab tab-item" id="report" style="width:150px;">
                Report
            </div>
        </div>


    <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;padding-top:20px;overflow:auto;padding-bottom:20px;">
        
          <div id="declined-request-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 20px; border: 0px solid red ;display:block;">
                <div id="search-declined-request-wrapper" style="margin-top:-60px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType1" style="float:left; margin-left:20px;">
                        <select name="search-by-all" id="search-by-all" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >-- Service Type --</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option>      
                            <option value="DealerCode">Party Code</option>                                         
                        </select>
                    </div>
                  
                     <div id="date-ime-code-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-declined-request-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-declined-request-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="declined-request-list" style="width:100%;float:left;display:block"></div>
            </div>  

             <div style="clear:both"></div>
             <div id="management-report-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                margin-top: 0px; border: 0px solid red ;display:block;">
                <div id="search-management-report-wrapper" style="margin-top:-100px;height:70px;display:none">
                    <div style="border:1px solid #CCCCCC;width:200px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">SEARCH BY</div>
                    <div id="div-requestType2" style="float:left; margin-left:20px;">
                        <select name="search-by-all-1" id="search-by-all-1" style="width:200px; height:28px ;border:1px solid #CCCCCC;color: #000000;background-color:#F2E0F7;">
                            <option value="0" >-- Service Type --</option>
                            <option value="Date" >Date(YYYY-MM-DD)</option>
                            <option value="IMEI">IMEI</option> 
                            <option value="requestID">Request ID</option>                                                
                        </select>
                    </div>
                  
                     <div id="requestID-ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #4F81BB;">PARAMETER : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-management-report-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #F2E0F7;" />
                    </div>            
                    </div> 

                    <div class="btn-management-report-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:50px;border-radius:5px;;color: #FFFFFF;background-color: #1BB287;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br />
                <div style="clear:both"></div>
                <div id="management-report-list" style="width:100%;display:block"></div>
            </div>   

  </div>
</div>
</asp:Content>
