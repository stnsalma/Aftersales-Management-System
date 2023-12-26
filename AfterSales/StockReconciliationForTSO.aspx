<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StockReconciliationForTSO.aspx.cs" Inherits="WSMS.StockReconciliationForTSO" %>

<%@ Register Src="~/Module/TabControl.ascx" TagName="TabContol"  TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="Styles/dashboard.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="Styles/modal-window.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery.msg.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/alertifyjs/css/alertify.css" rel="stylesheet" />
    
    <link href="Styles/glDatePicker.default.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.datepick.js" type="text/javascript"></script>

    <script src="Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery.ui.core.js" type="text/javascript"></script>
    <script src="Scripts/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="Scripts/jquery.center.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.msg.min.js" type="text/javascript"></script>
    <script src="Scripts/alertifyjs/alertify.js"></script>
    <script src="Scripts/bootstrap.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
    <link href="Styles/bootstrap.min.css" rel="stylesheet" type="text/css" />

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
                LoadAreaStockReconciliation(UserID);
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
            
             $("#daywise_DealerSales").live('click', function () {
                $.msg({
                    msgID: 1,
                    autoUnblock: false,
                    clickUnblock: false,
                    content: 'Please wait loading data.....'
                });
                $('#parameter-dayWise-sale').val('');
                 $('#salesDate').val('');
                LoadDayWiseDealerSales(UserID);
            });
           
            function HideAll() {
                $("#area-stockRecon-list").css("display","none");
                $("#display-entry-list").css("display","none");
                $("#search-display-IMEI-wrapper").css("display", "none");
                $("#tso-dayWise-entry-list").css("display","none");
                $("#search-stockRecon-IMEI-wrapper").css("display","none");
                $("#search-dayWise-model-wrapper").css("display","none");
            }

             function LoadAreaStockReconciliation(UserID,SearchBy1) {
                $.ajax({
                    type: "POST",
                    url: "StockReconciliationForTSO.aspx/LoadAreaStockReconciliation",
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
                            $("#search-stockRecon-IMEI-wrapper").css("display","block");
                            //$("#saveId_0").css("display","none");   
                            $("#saveId_1").css("display","none");
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
                    url: "StockReconciliationForTSO.aspx/LoadDisplayEntry",
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
                            $("#saveId_1").css("display","none");
                            $("#saveId_0").css("display","none");
                            $.msg('unblock', 30, 1);
                            if (msg.d == 0) {
                              
                                 alertify.dialog('alert').set({
                                                  'title': '   ',
                                                  'transition': 'zoom',
                                                  'message': "Please Search by correct IMEI.",                                                                       
                                              }).show();
                            }
                            
                            var dName = $("#d_name").text().trim();
                            //alert(dName);
                             var isdisplayChk;
                   
                           isdisplayChk = $('input:checkbox:checked').map(function() {
                            return this.value;
                          }).get();
                            
                             //alert(isdisplayChk);
                            
                            if (dName.length == 0) {
                               // alert("value nai");
                               $("#displaycheckTick").attr("checked", false);
                              
                            } 
                            else {
                                // alert("value aceee");
                               
                                $("#displaycheckTick").attr("checked", true);
                            }

                        }
                    },
                    error: function (msg) {
                        $.msg('unblock', 30, 1);
                    }
                });
            }
            
             function LoadDayWiseDealerSales(UserID,SearchByDealer,SearchBySalesDate) {
                $.ajax({
                    type: "POST",
                    url: "StockReconciliationForTSO.aspx/LoadDayWiseDealerSales",
                    data: "{ UserID: '" + UserID
                      + "' , SearchByDealer: '" + SearchByDealer
                      + "' , SearchBySalesDate: '" + SearchBySalesDate
                    + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "err") {
                            
                            HideAll();
                            $("#tso-dayWise-entry-list").html(msg.d);
                            $("#tso-dayWise-entry-list").css("display", "block");                            
                            $("#search-dayWise-model-wrapper").css("display", "block");
                            $("#saveId_0").css("display","none");
                            //$("#saveId_1").css("display","block");
                            
                            $.msg('unblock', 30, 1);
                            
                        }
                    },
                    error: function (msg) {
                        $.msg('unblock', 30, 1);
                    }
                });
            }
        
             function InserttblStockReconciliation(DealerName, DealerCode, itemArray, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "StockReconciliationForTSO.aspx/InserttblStockReconciliation",
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
             function InsertIntotblDisplayProduct(IMEI_1,IMEI_2, Model, DealerCode,DisplayDate, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "StockReconciliationForTSO.aspx/InsertIntotblDisplayProduct",
                    data: "{ IMEI_1: '" + IMEI_1
                                + "', IMEI_2: '" + IMEI_2
                                + "', Model: '" + Model
                                + "', DealerCode: '" + DealerCode
//                                + "', IsDisplay: '" + IsDisplay
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
            //  InsertIntotblDealerSales(dealerCode, salesDate, itemArray, addedBy);
            function InsertIntotblDealerSales( DealerCode, SalesDate, itemArray, AddedBy) {
                $.ajax({
                    type: "POST",
                    url: "StockReconciliationForTSO.aspx/InsertIntotblDealerSales",
                    data: "{ DealerCode: '" + DealerCode
                                + "', SalesDate: '" + SalesDate
                                + "', SalesDate: '" + SalesDate
                                + "', itemArray: '" + itemArray
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

                            LoadDayWiseDealerSales(UserID);


                        }
                        else {
                            $("#err-message").text("System can not process your request at this moment. Please try again later.").fadeIn(1500).fadeOut(1500);
                        }
                    }
                });
            }
            $(".btn-stockRecon-search").live('click', function () {
                        
                 var searchby =$("#parameter-stockRecon-job").children("#ddldealer").find(":selected").text().trim();
                 var searchby1 =$("#parameter-stockRecon-job").children("#ddldealer").find(":selected").val().trim();
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
                else  {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading service .....'
                    });
                
                LoadAreaStockReconciliation(UserID,searchby1);
                      
                $("#saveId_0").css("display","block");
                      
               }
                 $("#saveId_0").css("display","block");
              
            });
            
            $("#btn-stock-recon").live('click', function() {

                var divOne = document.getElementById('stock-reconListForSave');
                var divTwo = document.getElementById('stock-reconListForSave1'); 
                if (divOne) 
                {
                   // alert("divvvv 111111111");
                    var dealerName =$("#parameter-stockRecon-job").children("#ddldealer").find(":selected").text().trim();
                    var dealerCode =$("#parameter-stockRecon-job").children("#ddldealer").find(":selected").val().trim();
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
                         var inHouses =$.trim($(this).children("#forInhouse").children("#input-inHouse").val());
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
                    console.log("final : " +itemArray);
                
                   InserttblStockReconciliation(dealerName, dealerCode,itemArray, addedBy);
                }
                else if(divTwo) 
                {
                   // alert("divvvv 2222222");
                    var dealerName1 =$("#parameter-stockRecon-job").children("#ddldealer").find(":selected").text().trim();
                    var dealerCode1 =$("#parameter-stockRecon-job").children("#ddldealer").find(":selected").val().trim();
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
                         var inHouses1 =$.trim($(this).children("#forInhouse1").children("#input-inHouse1").val());
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
                    console.log("final : " +itemArray1);
                

                    InserttblStockReconciliation(dealerName1, dealerCode1,itemArray1, addedBy1);
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
                else  {
                    $.msg({
                        msgID: 1,
                        autoUnblock: false,
                        clickUnblock: false,
                        content: 'Please wait loading service .....'
                    });
                
                LoadDisplayEntry(UserID,searchby);
               
                }

              
            });
            
            $(".btn-dayWise-sales-search").live('click', function () {
                        
                 var searchbyDealerName =$("#parameter-dayWise-sale").children("#ddldealer").find(":selected").text().trim();
                 var searchbyDealerCode =$("#parameter-dayWise-sale").children("#ddldealer").find(":selected").val().trim();
                 var salesDate = $("#salesDate").val();
                
                  if (searchbyDealerName == "---- Select Dealer Name ----") {

                       alertify.dialog('alert').set({
                                                      'title': '   ',
                                                      'transition': 'zoom',
                                                      'message': "Please select Dealer Name",                                                                                        
                                                  }).show();
                      $("#parameter-stockRecon-job").focus();
                        return -1;
                  
                    }
                  else if (salesDate.length == 0) {
                       alertify.dialog('alert').set({
                                                      'title': '   ',
                                                      'transition': 'zoom',
                                                      'message': "Please select Sales Date",                                                                                        
                                                  }).show();
                      $("#salesDate").focus();
                        return -1;
                  }
                 else  {
                        $.msg({
                            msgID: 1,
                            autoUnblock: false,
                            clickUnblock: false,
                            content: 'Please wait loading service .....'
                        });
                  
                    LoadDayWiseDealerSales(UserID,searchbyDealerCode,salesDate);
                    $("#saveId_1").css("display","block");
                }

                $("#saveId_1").css("display","block");
            });

            $("#btn-display-IMEI-save").live('click', function () {
                  // alert("hiii");
                   var imei_1 = $(this).parent().parent().children("#displayBarcode").children(".hfbarcode1").val();
                   var imei_2 = $(this).parent().parent().children("#displayBarcode").children(".hfbarcode2").val();
                   var model = $(this).parent().parent().children("#displayBarcode").children(".hfModel").val();
                   var dealerCode = $(this).parent().parent().children("#hfDealerName1").children("#dealer_lists1").children("#ddldealer").find(":selected").val();
                   var dealerName = $(this).parent().parent().children("#hfDealerName1").children("#dealer_lists1").children("#ddldealer").find(":selected").text();        
                   var isNSMApro = $("#IsAprv").text().trim();
                   var addedBy = UserID;
                   
                   var distributionDate = $("#distri_date").text().trim();
                   var disDate = $("#displayDate").val();
                    
//                   alert(distributionDate);
//                   alert(disDate);
                   
                   var d1=Date.parse(distributionDate);
                   var d2=Date.parse(disDate);

//                   alert("d1 :" + d1);
//                    alert("d2 :" + d2);
                   
                   if (d2 < d1) {
                       alertify.dialog('alert').set({
                           'title': '   ',
                           'transition': 'zoom',
                           'message': "Display Date will not be less than Distribution Date.",
                       }).show();
                       return false;
                   } 

                   ////necessary comment////
                 //  alert(isNSMApro);
//                 //  var isdisplayChk;                 
//                   isdisplayChk = $('input:checkbox:checked').map(function() {
//                    return this.value;
//                  }).get();
//                   
//                   if (displaycheckTick.checked == true) {
//                       isdisplayChk = true;

//                      // alert(isdisplayChk);
//                   } else {
//                        isdisplayChk = false;
//                        //alert(isdisplayChk);
//                   }
                   
                   if (dealerName == "------------- Select Dealer Name -------------") {
                       alertify.dialog('alert').set({
                            'title': '   ',
                            'transition': 'zoom',
                            'message': "Please Select Dealer Name...",                                                                       
                        }).show();
                       return false;
                   }
                   
                   if (disDate.length == 0 ) {
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
                   

                   InsertIntotblDisplayProduct(imei_1,imei_2,model,dealerCode,disDate,addedBy);
               });

               
            $("#btn-dayWise-salesSave1").live('click', function () {

                var divOne = document.getElementById('dayWise-ListForSave1');
                var divTwo = document.getElementById('dayWise-ListForSave'); 
                if (divOne) 
                {
                   // alert("divvvv 111111111");
                    var dealerName =$("#parameter-dayWise-sale").children("#ddldealer").find(":selected").text().trim();
                    var dealerCode =$("#parameter-dayWise-sale").children("#ddldealer").find(":selected").val().trim();
                    var salesDate = $("#salesDate").val();
                    console.log(dealerName);
                    console.log(dealerCode);     
                    console.log(salesDate);     
                    var addedBy = UserID;
                                 
                    if (dealerName == "---- Select Dealer Name ----") {

                       alertify.dialog('alert').set({
                                                      'title': '   ',
                                                      'transition': 'zoom',
                                                      'message': "Please select Dealer Name",                                                                                        
                                                  }).show();
                        return false;
                  
                    }
                     if (salesDate.length == 0) {

                       alertify.dialog('alert').set({
                                                      'title': '   ',
                                                      'transition': 'zoom',
                                                      'message': "Please select Dealer Name",                                                                                        
                                                  }).show();
                        return false;
                  
                    }
                     
                    var quantityA =$("#input-Quantity").val();
                    if (isNaN(quantityA) || quantityA.indexOf(" ") != -1) {

                                alertify.dialog('alert').set({
                                                            'title': '   ',
                                                            'transition': 'zoom',
                                                            'message': "Enter numeric value for Quantity",                                                                                        
                                                        }).show();
                            return false;
                     }
                            

                    var itemArray = new Array();
                    $("#tso-dayWise-entry-list tr.dayWise_tr_forSave1").each(function (i) {
                    
                         var mModel = $.trim($(this).children("#mobileModel2").text());                    
                         var quantity =$.trim($(this).children("#forQuantity").children("#input-Quantity").val());
          
                        console.log(mModel);
                        console.log(quantity);
                       
                    
                        itemArray[i] = new Array(3);
                        itemArray[i][0] = mModel;
                        itemArray[i][1] = quantity;
                       
                        itemArray[i][2] = ";";
                    });
                    for (var i = 0; i < itemArray.length; i++) {
                      if (isNaN(itemArray[i][1]) || itemArray[i][1].indexOf(" ") != -1) {

                        alertify.dialog('alert').set({
                                                    'title': '   ',
                                                    'transition': 'zoom',
                                                    'message': "Enter numeric value for Quantity",                                                                                        
                                                }).show();
                            return false;
                         }
                       
                    }
                    console.log("final : " +itemArray);
                    
          
                    InsertIntotblDealerSales(dealerCode, salesDate, itemArray, addedBy);
                }
                else if(divTwo) 
                {
                    //alert("divvvv 2222222");
                    var dealerName1 =$("#parameter-dayWise-sale").children("#ddldealer").find(":selected").text().trim();
                    var dealerCode1 =$("#parameter-dayWise-sale").children("#ddldealer").find(":selected").val().trim();
                    var salesDate1 = $("#salesDate").val();
                    console.log(dealerName1);
                    console.log(dealerCode1);     
                    console.log(salesDate1);     
                    var addedBy1 = UserID;
              
                    if (dealerName1 == "---- Select Dealer Name ----") {

                       alertify.dialog('alert').set({
                                                      'title': '   ',
                                                      'transition': 'zoom',
                                                      'message': "Please select Dealer Name",                                                                                        
                                                  }).show();
                        return false;
                  
                    }
                     if (salesDate1.length == 0) {

                       alertify.dialog('alert').set({
                                                      'title': '   ',
                                                      'transition': 'zoom',
                                                      'message': "Please select Dealer Name",                                                                                        
                                                  }).show();
                        return false;
                  
                    }

                    var itemArray1 = new Array();
                    $("#tso-dayWise-entry-list tr.dayWise_tr_forSave").each(function (i) {
                    
                         var mModel1 = $.trim($(this).children("#mobileModel3").text());                    
                         var quantity1 =$.trim($(this).children("#forQuantity1").children("#input-Quantity1").val());
                                                 
                    
                        console.log(mModel1);
                        console.log(quantity1);
                       
                    
                        itemArray1[i] = new Array(3);
                        itemArray1[i][0] = mModel1;
                        itemArray1[i][1] = quantity1;
                       
                        itemArray1[i][2] = ";";
                    });
                    for (var i = 0; i < itemArray1.length; i++) {
                      if (isNaN(itemArray1[i][1]) || itemArray1[i][1].indexOf(" ") != -1) {

                        alertify.dialog('alert').set({
                                                    'title': '   ',
                                                    'transition': 'zoom',
                                                    'message': "Enter numeric value for Quantity",                                                                                        
                                                }).show();
                            return false;
                         }
                       
                    }
                    console.log("final : " +itemArray1);
                
                    InsertIntotblDealerSales(dealerCode1, salesDate1, itemArray1, addedBy1);
                }
                console.log(divOne);
                console.log(divTwo);

            });
        });
          

        function preventBack() { window.history.forward(1); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
  
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="width:100%;border:0px solid red;float:left;">
      
        <div id="content" style="width:100%;float:left;border:1px solid #CCCCCC;overflow:auto;">
         <div class="class="col-lg-12">
         <div id="tab-content"  style="width:100%;height:30px;border:0px solid red;float:left;margin-top: 0px;">
           
            <div class="tab-item active-tab" id="stock-recon" style="width:200px;">
                Stock Reconciliation
            </div>
             <div class="tab tab-item" id="display-entry">
                Display Entry
            </div>
            <div class="tab tab-item" id="daywise_DealerSales">
                Day wise Sales
            </div>  </div>
        </div><br/><br/><br/><br/>
      
               <div id="area-stockRecon-wrapper" class="col-lg-12  table-responsive table-scrollable" style ="width: 1370px; margin-top:5px ;
                 border: 0px solid red ;display:block;">
                <div id="search-stockRecon-IMEI-wrapper" class="table-responsive" style="height:100px;display:none">
                           
                      <div id="ime-searchOf-stock"  style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; ">
                            <div class="label" style="border:1px solid #CCCCCC;width:200px; font-weight: bold;
                            height:30px ;line-height:25px;margin-left:0px;float:left;text-align:center;color: #FFFFFF;background-color: #1BA39C;">SEARCH BY DEALER : </div>
                                        
                      
                            <div class="input" id="parameter-stockRecon-job" style="width:200px; height:23px ;border:1px solid #CCCCCC;margin-top:2px;margin-left:10px;text-transform:uppercase;color: #000000;">
                                        <%=DDLDealerName%>
                            </div> 
                          
                               
                        </div>   
                         <div class="btn-stockRecon-search" style="border:1px solid #83AF45;width:150px;line-height:25px;text-align:center; 
                            font-weight:bold;font-style:italic;cursor:pointer;left:0;border-radius:5px;color: #FFFFFF;background-color: #26C281;margin-top: 10px;">
                             SEARCH 
                        </div>         
                    </div> 
                   
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
               
              
             <div style="clear:both"></div>
             <div id="display-entry-wrapper" style ="width: 1370px; float: left; margin-left:30px;
                 border: 0px solid red ;display:block;">
                <div id="search-display-IMEI-wrapper" style="margin-top:-60px;height:70px;display:none">
                           
                     <div id="ime-search" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:40px">
                        <div class="label" style="border:1px solid #CCCCCC;width:200px; 
                        height:25px ;line-height:25px;margin-left:-15px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #1BA39C;">SEARCH BY IMEI : </div>
                                        
                           <div style="float:left">
                        <input type="text" id="parameter-display-entry-job" style="width:195px; height:23px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;background-color: #DADADA;" />
                    </div>            
                    </div> 

                    <div class="btn-display-entry-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;margin-left:-15px;cursor:pointer;left:0;margin-top:20px;border-radius:5px;color: #FFFFFF;background-color: #26C281;">
                         SEARCH 
                    </div>
                </div>
                <br /><br /><br /><br />
                <div style="clear:both"></div>
                <div id="display-entry-list" style="margin-top: 10px;width:100%;float:left;display:block"></div>
            </div> 
           
             <div style="clear:both"></div>   
             <div id="tso-dayWise-entry-wrapper" style ="width: 1370px; float: left; margin-left:7px;
                     border: 0px solid red ;display:block;margin-top: -65px">
        
                 <div id="search-dayWise-model-wrapper" class="table-responsive" style="margin-top:0px;height:150px;display:none">
                    <div style="border:1px solid #CCCCCC; width:180px; height:25px ;
                        line-height:25px;float:left;text-align:center;color: #FFFFFF;background-color: #1BA39C;">SEARCH BY DEALER</div>
                   
                   <div class="input" id="parameter-dayWise-sale" style="width:200px; height:23px ;border:1px solid #CCCCCC;float: left;margin-left: 10px;text-transform:uppercase;color: #000000;">
                                        <%=DDLDealerName%>
                     </div> <br />
                     <div id="sales_Date_Div" style="width:520px;height:30px; line-height:30px;border:0px solid red;left:0px; margin-top:30px">
                        <div class="label" style="border:1px solid #CCCCCC;width:170px; 
                        height:26px ;line-height:26px;margin-left:0px;margin-top:10px;float:left;text-align:center;color: #FFFFFF;background-color: #1BA39C;">SALES DATE </div>
                                        
                           <div style="float:left">
                        <input type="date" id="salesDate" placeholder="YYYY-MM-DD" required pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}"  style="width:200px; height:25px ;border:1px solid #CCCCCC;margin-top:10px;margin-left:10px;text-transform:uppercase;color: #000000;" />
                    </div>            
                                          
                    </div> 

                    <div class="btn-dayWise-sales-search" style="border:1px solid #83AF45;width:150px;height:25px;line-height:25px;text-align:center; 
                        font-weight:bold;font-style:italic;cursor:pointer;left:0;margin-top:30px;border-radius:5px;color: #FFFFFF;background-color: #26C281;">
                         SEARCH 
                    </div>
                </div>
                 <div style="clear:both"></div>                      
                    <div id="tso-dayWise-entry-list" style="width:400px;display:none">                  
                    </div>
                    
               <div style="clear:both"></div>
               <br/><br/>
               <div id="saveId_1" style="width:210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;margin-left:10px;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: white;background-color:#cccccc;">
                                           
                   <div id="btn-dayWise-salesSave1" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                        font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:60px;margin-top:4px;background: red">
                  
                        SAVE
                    </div>
               
               </div>
             </div>            
       </div>
 </div>

</asp:Content>


