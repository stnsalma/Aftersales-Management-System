<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master"  CodeBehind="PrintActiveServiceIDFromPlaza.aspx.cs" Inherits="WSMS.RDLCReports.PrintActiveServiceIDFromPlaza" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register src="~/Module/PrintFaultySpareParts.ascx" tagname="PrintFaultySpareParts" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="../Styles/dashboard.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/glDatePicker.default.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui.css" rel="stylesheet" type="text/css" />


    <script src="../Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="../Scripts/glDatePicker.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.plugin.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.datepick.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui.min.js" type="text/javascript"></script>

    <%--<script src="../Scripts/downloadify.min.js" type="text/javascript"></script>
    <script src="../Scripts/html2canvas.js" type="text/javascript"></script>
    <script src="../Scripts/jspdf.debug.js" type="text/javascript"></script>
    <script src="../Scripts/jspdf.js" type="text/javascript"></script>
    <script src="../Scripts/jspdf.min.js" type="text/javascript"></script>
    <script src="../Scripts/jspdf.PLUGINTEMPLATE.js" type="text/javascript"></script>
    <script src="../Scripts/split_text_to_size.js" type="text/javascript"></script>
    <script src="../Scripts/standard_fonts_metrics.js" type="text/javascript"></script>
    <script src="../Scripts/from_html.js" type="text/javascript"></script>--%>
    

<%--    <style type="text/css">
   table { page-break-inside:auto }
   tr    { page-break-inside:avoid; page-break-after:auto }
   @media print {
            html, body {
                height: auto;    
            }
        }
       
    </style>--%>

<script type="text/javascript">
//////////////////running one////////////////
    function PrintPanel() {

        var panel = document.getElementById("<%=receiveMemo.ClientID %>");
        var printWindow = window.open('', 'receiveMemo', 'height=2000,width=3000');
        printWindow.document.write(panel.innerHTML);

        printWindow.document.close();
        setTimeout(function () {
            printWindow.print();
        }, 500);

        return false;
        }


</script>


    <script type="text/javascript">
        $(document).ready(function () {
            var UserID = '<%=UserID%>';
            //alert(UserID)
            if (UserID == 0)
                window.location("Login.aspx");

            //$('#todaydate').val('<%=(System.DateTime.Now).ToString()%>');

            // todaydate.Text = DateTime.Now.ToString();

            document.getElementById("todaydate").innerHTML = new Date().toDateString();


        });
    </script>
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
    <div id="receiveMemo" style="width:842;border: 0px solid white;" runat="server">
        <div id="header" style="width:100%;float:left">
            <div id="logo" style="width:220px;float:left;min-height:100px;margin-left:80px;border:0px solid red">
                <img src="../images/Logo.jpg" height="95px" 
                    style="margin-left:54px; width: 137px;" />
            </div>
            <div id="Caption" style="width:500px;float:left;min-height:100px;border:0px solid red">
                <div  style="width:100%;float:left;height:70px;position: relative;border:0px solid red">
                    <span style="position: absolute; bottom: 0;font-size:26px;font-weight:bold;color:#25469F;test-align:center;left: 60px;">Aftersales Management System</span> 
                </div>
                <div style="width:100%;float:left;height:30px;position: relative; border:0px solid red">
                    <span style="position: absolute; bottom: 0;font-size:20px;font-weight:bold;text-align:center;:#819830; left: 100px; width: 275px;color:red;test-align:center">Handset Replacement Form</span> 
                </div>
            </div>
           
            <div style="clear:both"></div>

            <div style="width:950px;float:left;border-top:2px solid black;margin-top:10px"> </div>
        </div >
        <div id="data" style="width:100%;float:left;">
            <asp:DataList runat="server" ID="dtListReceiveMemo">
            <ItemTemplate>
                <div id="reportBody" style="width: 100%; float: left;clear:both!important;page-break-after:always">
                     <div style="width:500px;">
                                    <div style="width: 360px; float: left; height:25px;line-height:25px;font-weight:bold;color:black;font-size:16px">
                                       AFTER SERVICE REPLACEMENT FORM NO:
                                    </div>
                                    <div style="width: 140px; float: left; height:25px;line-height:25px;font-weight:bold;color:black;font-size:16px">
                                        <%# DataBinder.Eval(Container.DataItem, "AfterServiceRepID")%>
                                    </div>
                                </div>
                    <div style="width: 900px; float: left">
                     <p style="font-size:14px;font-weight:bold;color:#25469F;width: 200px; float: left;">
                        Fill up by Service Incharge :
                        
                     </p>
                     <%-- <div style="width: 500px; float: left; height:25px;line-height:25px;margin-top:12px">
                           <%# DataBinder.Eval(Container.DataItem, "CreatedBy")%>
                       </div>--%>
                        <fieldset style="border-style: solid;border-color:#00A8E2;color:Black;border-radius:10px;border-width:1px;">
                            <legend style="color:green;font-weight:bold">Service Point & Customer Details</legend>
                            <div style="width: 900px; float: left">
                                <div style="width:600px; float: left">
                                    <div style="width: 140px; float: left; height:25px;line-height:25px;margin-left:20px;">
                                        Service Point Name :
                                    </div>
                                    <div style="width: 420px; float: left; height:25px;line-height:25px;font-size:12px">
                                        <%# DataBinder.Eval(Container.DataItem, "ServicePointName")%>
                                    </div>
                                </div>
                                <div style="width: 300px; float: left">
                                    <div style="width:80px; float: left; height:25px;line-height:25px ">
                                       Date :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                       <%-- <%# DataBinder.Eval(Container.DataItem, "ServicePlaceDate")%>--%>
                                       <label id="todaydate" title="DateTime.Now.ToString()"></label>
                                        
                                    </div>
                                </div>
                            </div>
                            <div style="width: 900px; float: left">
                                <div style="width:500px; float: left">
                                    <div style="width: 125px; float: left; height:25px;line-height:25px;margin-left:20px">
                                        Customer Name :
                                    </div>
                                    <div style="width: 355px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "CustomerName")%>
                                    </div>
                                </div>
                                <div style="width: 400px; float: left">
                                    <div style="width: 130px; float: left; height:25px;line-height:25px ">
                                        Customer Address :
                                    </div>
                                    <div style="width: 270px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "CustomerAddress")%>
                                    </div>
                                </div>
                            </div>
                             <div style="width: 900px; float: left">
                                <div style="width:500px; float: left">
                                    <div style="width: 125px; float: left; height:25px;line-height:25px;margin-left:20px">
                                       Customer Mobile :
                                    </div>
                                    <div style="width: 350px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "CustomerMobile")%>
                                    </div>
                                </div>
                                <div style="width: 400px; float: left">
                                    <div style="width: 130px; float: left; height:25px;line-height:25px ">
                                       Plaza/Dealer Code :
                                    </div>
                                    <div style="width: 270px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "DealerCode")%>
                                    </div>
                                </div>
                            </div>
                                 <div style="width: 900px; float: left">
                                <div style="width:800px; float: left">
                                    <div style="width: 140px; float: left; height:25px;line-height:25px;margin-left:20px">
                                       Replacement Cause :
                                    </div>
                                    <div style="width: 450px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "RepalcementCause")%>
                                    </div>
                                </div>
                                
                            </div>
                        </fieldset>
                          <div style="clear:both"></div>
                         <fieldset style="border-style: solid;border-color:#00A8E2;color:Black;border-radius:10px;border-width:1px;margin-top:0.5px">
                           
                            <legend style="color:green;font-weight:bold">Handset related info</legend>
                            <div style="width: 900px; float: left">
                                <div style="width:450px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                        Service ID :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "ServiceID")%>
                                    </div>
                                </div>
                                <div style="width: 450px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                       Model :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "FaultyhandsetModel")%>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 900px; float: left">
                                <div style="width:450px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                       IMEI_1 :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "IME")%>
                                    </div>
                                </div>
                                <div style="width: 450px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                        Sales Date :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "RegistrationDate", "{0:yyyy-MM-dd}")%>
                                    </div>
                                </div>
                            </div>
                             <div style="width: 900px; float: left">
                                <div style="width:450px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                      IMEI_2 :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "Barcode2")%>
                                    </div>
                                </div>
                                <div style="width: 450px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                       Receive Date :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "ServicePlaceDate", "{0:yyyy-MM-dd}")%>
                                    </div>
                                </div>
                            </div>
                             <div style="width: 900px; float: left">
                                <div style="width:400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                       Warranty Status :
                                    </div>
                                    <div style="width: 150px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "WarrantyAvailability1")%>
                                    </div>
                                </div>
                                 <div style="width:400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:45px">
                                        Co-ordinator Permission? :
                                    </div>
                                    <div style="width: 100px; float: left; height:25px;line-height:25px;margin-left:28px">
                                        <%# DataBinder.Eval(Container.DataItem, "PermissionFromCoOrdinator1")%>
                                    </div>
                                </div>
                                
                           </div>
                            <div style="width: 900px; float: left">
                                <div style="width:450px; float: left">
                                    <div style="width: 100px; float: left; height:120px;line-height:25px;margin-left:20px">
                                      Technician Comments :
                                    </div>
                                    <div style="width: 350px; float: left; height:120px;line-height:25px;margin-left:-20px">
                                        <%# DataBinder.Eval(Container.DataItem, "tech_comm")%>
                                    </div>
                                </div>
                                <div style="width: 450px;float:left;">
                                    <div style="width: 100px; float: left; height:120px;line-height:25px;">
                                       Incharge Comments :
                                    </div>
                                    <div style="width: 350px; float: left; height:120px;line-height:25px;margin-left:-20px">
                                        <%# DataBinder.Eval(Container.DataItem, "ServiceInchargeComment")%>
                                    </div>
                                </div>
                            </div>
                        </fieldset>

                         <fieldset style="border-style: solid;color:Black;border-radius:10px;border-width:1px;">
                            <legend style="color:Green;font-weight:bold">Faulty Spareparts & New Handset bill related info</legend>
                            <div style="width: 900px; float: left">
                                <div style="width:400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                        Faulty Handset Model:
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "FaultyhandsetModel")%>
                                    </div>
                                </div>
                                <div style="width: 400px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                       Faulty Handset Price :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "FaultyHandetPrice")%>
                                    </div>
                                </div>
                            </div>
                               <div style="clear:both"></div>
                            <fieldset style="border-style: solid;border-radius:10px;border-width:1px;width: 850px;">
                                 <legend style="color:green;font-weight:bold"> SpareParts Name & Price :</legend>
                                    <div style="width: 700px; float: left;">
                                     
                                           <uc1:PrintFaultySpareParts ID="PrintFaultySpareParts" runat="server" ServiceID='<%# DataBinder.Eval(Container.DataItem, "ServiceID")%>'  />
                            
                                    </div>
                            </fieldset>
                             <div style="width: 900px; float: left">
                                <div style="width:600px; float: left">
                                    <div style="width: 190px; float: left; height:25px;line-height:25px;margin-left:20px">
                                      Standard Depreciation Price :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "DepricationRate")%>
                                    </div>
                                </div>
                                
                            </div>
                            <div style="width: 900px; float: left">
                                <div style="width:600px; float: left">
                                    <div style="width: 280px; float: left; height:25px;line-height:25px;margin-left:20px">
                                      Total money received by Service Incharge :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "AcceptFromCustomer")%>
                                    </div>
                                </div>
                                
                            </div>
                             
                            <p style="font-size:14px;font-weight:bold;color:#25469F;width:180px;float: left;">
                                 Fill up by Plaza :
                                 
                            </p>
                            <div style="width: 500px; float: left; height:25px;line-height:25px;margin-top:10px;margin-left:-30px">
                                        <%# DataBinder.Eval(Container.DataItem, "RepUserFullName")%>
                                    </div>
                            <div style="width: 900px; float: left">
                                <div style="width:400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                        New Handset Model:
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "NewHandsetModel")%>
                                    </div>
                                </div>
                                <div style="width: 400px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                       New Handset Price :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "NewHandsetPrice")%>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 900px; float: left">
                                <div style="width:400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                        Faulty Handset Model:
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "FaultyhandsetModel")%>
                                    </div>
                                </div>
                                <div style="width: 400px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                       Faulty Handset Price :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "FaultyHandsetPriceByPlaza")%>
                                    </div>
                                </div>
                            </div>
                            
                              <div style="width: 900px; float: left">
                                <div style="width:340px; float: left">
                                   <div style="width: 100px; float: left; height:25px;line-height:25px;margin-left:20px">
                                       
                                    </div>
                                    <div style="width: 100px; float: left; height:25px;line-height:25px;">
                                        
                                    </div>
                                </div>
                                <div style="width:500px; float: left">
                                    <div style="width: 240px; float: left; height:25px;line-height:25px; margin-right:20px;margin-top:-14px;">
                                      _____________________________________________________
                                         Extra money Received by Plaza:
                                    </div>
                                    <div style="width: 100px; float: left; height:25px;line-height:25px;margin-top:-14px;">
                                    _______________
                                        <%# DataBinder.Eval(Container.DataItem, "ReceiveByPlazaTotal")%>
                                    </div>
                                </div>
                              
                            </div>
                            
                        </fieldset>

                         <div style="width: 900px; float: left">
                        
                                <div style="width:450px; float: left">
                                  
                                   <div style="width: 200px; float: left; height:25px;line-height:25px;margin-left:125px;margin-top:15px;text-align:center">
                                          <%# DataBinder.Eval(Container.DataItem, "ReplacementGivenBy")%>
                                    </div>
                                   <div style="width: 200px; float: left; height:25px;line-height:25px;margin-left:120px;text-align:center;margin-top:-12px;color:Black">
                                 
                                        ___________________________________
                                          Plaza Manager Signature :
                                    </div>
                                    
                                   
                                    
                                </div>
                               
                                <div style="width:450px; float: left">
                                    <div style="width: 250px; float: left; height:25px;line-height:25px; margin-right:-20px">
                                        
                                    </div>
                                    <div style="width: 150px; float: left; height:25px;line-height:25px;text-align:center;color:Black;margin-top:20px">
                                       _______________________
                                        Customer Signature :
                                    </div>
                                </div>
                                
                           </div>
                             <div style="clear:both"></div>
                          <div style="width: 900px; float: left;">
                           <fieldset style="border-style: solid;border-color:#00A8E2;color:black;border-radius:10px;border-width:1px;margin-top:15px;">
                            <legend style="color:red;font-weight:bold">Only for official use :</legend>
                            <div style="width: 800px; float: left">
                                <div style="width:800px; float: left">
                                    <p style="width:250px;margin-left:48px;float:left">___________________________</p>
                                    <p style="width:150px;margin-left:25px;float:left">__________________________</p>
                                        <p style="width:150px;margin-left:94px;float:left">__________________________</p>
                                    <div style="width: 250px; float: left; height:25px;line-height:25px;margin-left:20px;text-align:center;">
                                        SCM  Division Signature :
                                        
                                    </div>
                                     
                                    <div style="width: 250px; float: left; height:25px;line-height:25px;margin-left:20px;text-align:center">
                                        Wastage Division Signature :
                                        
                                    </div>
                                    
                                    <div style="width: 250px; float: left; height:25px;line-height:25px;margin-left:10px;text-align:center">
                                    
                                        Store Incharge Signature :
                                    </div>
                                </div>
                            </div>  
                              
                            <div style="width:900px; float: left;">
                                <h6 style="color:black;text-decoration:underline">Attachment</h6>
                                <p style="color:red">1. Job Sheet copy. 2. Approval copy of SCM division(Mail approval copy). 3. The approval affiliates(Mail approval copy).</p>
                             
                            </div>
                        </fieldset>
                        </div>
                         <div style="clear:both!important;page-break-after:always"></div> 
                    </div>
                    <div style="clear:both!important;page-break-after:always"></div>
                </div>
               
            </ItemTemplate>
            </asp:DataList>
         
        </div>
   </div>

  <div style="clear:both!important;page-break-after:always"></div>
<%--<button type="button"  onclick="PrintPanel()">Print report</button>--%>
<input type="button" value="Print Report" onclick="PrintPanel();" />

</asp:Content>





