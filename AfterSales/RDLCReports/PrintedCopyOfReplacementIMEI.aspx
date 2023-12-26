<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master"  CodeBehind="PrintedCopyOfReplacementIMEI.aspx.cs" Inherits="WSMS.RDLCReports.PrintedCopyOfReplacementIMEI" %>


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
            <div id="logo" style="width:200px;float:left;min-height:100px;margin-left:20px;border:0px solid red">
                <img src="../images/Logo.jpg" height="95px" 
                    style="margin-left:54px; width: 137px;" />
            </div>
            <div id="Caption" style="width:700px;float:left;min-height:100px;border:0px solid red">
                <div  style="width:500px;float:left;height:70px;position: relative;border:0px solid red">
                    <span style="position: absolute; bottom: 0;font-size:20px;font-weight:bold;color:#25469F;test-align:center;left: 10px;">WALTON SERVICE MANAGEMENT SYSTEM</span> 
                </div>
                <br />
                <div style="width:200px;height:30px;position: relative; border:0px solid red;margin-top:60px;margin-left:-45px;">
                    <span style="position: absolute; bottom: 0;font-size:20px;font-weight:bold;text-align:center;:#819830; left: 120px; width: 275px;color:red;test-align:center">Replacement Request Form</span> 
                </div>
            </div>
           
            <div style="clear:both"></div>

            
        </div >
        <div id="data" style="width:100%;float:left;">
            <asp:DataList runat="server" ID="dtListReceiveMemo">
            <ItemTemplate>
                <div id="reportBody" style="width: 100%; float: left;clear:both!important;page-break-after:always">
                     <div style="width:800px;">                 
                          <div style="width: 600px;text-align:center; height:25px;line-height:25px;font-weight:bold;color:black;font-size:16px;margin-left:130px">
                                     <%# DataBinder.Eval(Container.DataItem, "RepUserFullName")%>
                           </div>
                      </div>
                       <br /><br />
                   <%--   <div style="width:950px;float:left;border-top:2px solid black;margin-top:10px"> </div>--%>

                    <div style="width: 900px; float: left">
                     
                        <fieldset style="border-style: solid;border-color:#00A8E2;color:Black;border-radius:10px;border-width:1px;">
                            <legend style="color:green;font-weight:bold"></legend>
                            <div style="width: 300px; float: right">
                                    <div style="width:80px; float: left; height:25px;line-height:25px;font-size:17px;font-weight:bold">
                                       Date :
                                    </div>
                                    <div style="width: 200px; float: right; height:25px;line-height:25px;font-size:17px;font-weight:bold">
                                    
                                       <label id="todaydate" title="DateTime.Now.ToString()"></label>
                                        
                                    </div>
                                </div>
                             <div style="clear:both"></div>
                            <div style="width: 900px;">
                               
                                    <div style="width: 140px; float: left; height:25px;line-height:25px;margin-left:340px;font-size:17px;font-weight:bold">
                                        Request ID :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:10px">
                                        <%# DataBinder.Eval(Container.DataItem, "RequestID")%>
                                    </div>
                             

                            </div>

                             <div style="clear:both"></div>
                            <div style="width: 900px;">
                               
                                    <div style="width: 140px; float: left; height:25px;line-height:25px;margin-left:321px;font-size:17px;font-weight:bold">
                                         Request Type :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:30px">
                                        <%# DataBinder.Eval(Container.DataItem, "RequestType")%>
                                    </div>
                             

                            </div>
                              <div style="clear:both"></div>
                            <div style="width: 900px;">
                               
                                    <div style="width: 240px; float: left; height:25px;line-height:25px;margin-left:248px;font-size:17px;font-weight:bold">
                                          Faulty Handset IMEI_1 :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:2px;">
                                        <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
                                    </div>
                             

                            </div>
                              <div style="clear:both"></div>
                            <div style="width: 900px; ">
                               
                                    <div style="width: 240px; float: left; height:25px;line-height:25px;margin-left:248px;font-size:17px;font-weight:bold">
                                           Faulty Handset IMEI_2 :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:3px">
                                        <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
                                    </div>
                             

                            </div>
                            <div style="clear:both"></div>
                            <div style="width: 900px; ">
                               
                                    <div style="width: 240px; float: left; height:25px;line-height:25px;margin-left:258px;font-size:17px;font-weight:bold">
                                           Faulty Handset Model :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:-4px">
                                        <%# DataBinder.Eval(Container.DataItem, "Model")%>
                                    </div>
                             

                            </div>
                             <div style="clear:both"></div>
                            <div style="width: 900px; ">
                               
                                    <div style="width: 240px; float: left; height:25px;line-height:25px;margin-left:306px;font-size:17px;font-weight:bold">
                                           Activation Date :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:-53px">
                                        <%# DataBinder.Eval(Container.DataItem, "RegistrationDate")%>
                                    </div>
                             

                            </div>
                             <div style="clear:both"></div>
                            <div style="width: 900px; ">
                               
                                    <div style="width: 240px; float: left; height:25px;line-height:25px;margin-left:340px;font-size:17px;font-weight:bold">
                                           Sales Point :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:-88px">
                                        <%# DataBinder.Eval(Container.DataItem, "DealerName")%>
                                    </div>
                             

                            </div>
                         
                    
                             <div style="clear:both"></div>
                            <div style="width: 900px;margin-top:0px">
                               
                                    <div style="width: 140px; float: left; height:25px;line-height:25px;margin-left:312px;font-size:17px;font-weight:bold;">
                                        Phone Number :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:42px">
                                        <%# DataBinder.Eval(Container.DataItem, "PhoneNumber")%>
                                    </div>
                             

                            </div>
                           <div style="clear:both"></div>
                            <div style="width: 900px;">
                               
                                    <div style="width: 240px; float: left; height:25px;line-height:25px;margin-left:298px;font-size:17px;font-weight:bold">
                                        Pre-request Date :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:-47px">
                                        <%# DataBinder.Eval(Container.DataItem, "RequestDate")%>
                                    </div>
                             

                            </div>
                              <div style="clear:both"></div>
                            <div style="width: 900px;">
                               
                                    <div style="width: 140px; float: left; height:25px;line-height:25px;margin-left:380px;font-size:17px;font-weight:bold">
                                        Issues :
                                    </div>
                                    <div style="width: 300px; float: left; height:25px;line-height:25px;font-size:12px;font-size:17px;font-weight:bold;margin-left:-25px">
                                        <%# DataBinder.Eval(Container.DataItem, "Issues")%>
                                    </div>
                             

                            </div>
                             <div style="clear:both"></div>
                            <div style="width: 900px;">
                               
                                    <div style="width: 140px; float: left; height:120px;line-height:25px;margin-left:355px;font-size:17px;font-weight:bold">
                                        Remarks :
                                    </div>
                                    <div style="width: 300px; float: left; height:120px;line-height:25px;font-size:12px;font-size:14px;font-weight:bold;margin-left:-4px">
                                        <%# DataBinder.Eval(Container.DataItem, "IssueDetails")%>
                                    </div>
                             

                            </div>

                            <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
                             <div style="clear:both"></div>
                               <div style="width: 900px;">
                        
                                <div style="width:450px; float: left">
                                  
                                   <div style="width: 200px; float: left; height:25px;line-height:25px;margin-left:125px;margin-top:15px;text-align:center">
                                          <%# DataBinder.Eval(Container.DataItem, "ServiceCenterUserID")%>
                                    </div>
                                   <div style="width: 200px; float: left; height:25px;line-height:25px;margin-left:120px;text-align:center;margin-top:-12px;color:Black">
                                 
                                        ___________________________
                                          Requested By :
                                    </div>
                                    
                                   
                                    
                                </div>
                               
                                <div style="width:450px; float: left">
                                    <div style="width: 250px; float: left; height:25px;line-height:25px; margin-right:-20px">
                                        
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px;text-align:center;color:Black;margin-top:20px">
                                       ____________________________
                                        Customer Name & Signature :
                                    </div>
                                </div>
                                
                                <br /><br /><br /><br /><br /><br /><br /><br /><br />
                           </div>
                        </fieldset>
                          <div style="clear:both"></div>
                        
                      
                             <div style="clear:both"></div>
                          <div style="width: 900px; float: left;">
                          
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

<input type="button" value="Print Report" onclick="PrintPanel();" />

</asp:Content>





