<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ServiceLoan.aspx.cs" Inherits="WSMS.ServiceLoan" %>
<%@ Register src="~/Module/NotifiedServiceRequisitionControl.ascx" tagname="NotifiedServiceRequisitionControl" tagprefix="uc1" %>

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
         $(document).ready(function () {
            var UserID = '<%=UserID%>';
            //alert(UserID)
            if (UserID == 0)
                window.location("Login.aspx");
        });
    </script>
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="receiveMemo" style="width:842;border:0px solid red" runat="server">
        <div id="header" style="width:100%;float:left">
            <div id="logo" style="width:220px;float:left;min-height:100px;border:0px solid red">
                <img src="../images/Logo.jpg" width="100px" height="95px" style="margin-left:100px" />
            </div>
            <div id="Caption" style="width:500px;float:left;min-height:100px;border:0px solid red">
                <div  style="width:100%;float:left;height:70px;position: relative;border:0px solid red">
                    <span style="position: absolute; bottom: 0;font-size:26px;font-weight:bold">Walton Service Management Syatem</span> 
                </div>
                <div style="width:100%;float:left;height:30px;position: relative; border:0px solid red">
                    <span style="position: absolute; bottom: 0;font-size:20px;font-weight:bold;font-style:italic;color:Maroon">Loan/Requisition slip</span> 
                </div>
            </div>
            <div style="clear:both"></div>
            <div style="width:850px;float:left;border-top:2px solid black;margin-top:10px"> </div>
            <div style="clear:both"></div>
        </div >
        <div id="data" style="width:100%;float:left;min-height:750px">
            <asp:DataList runat="server" ID="dtListReceiveMemo">
            <ItemTemplate>
                <div id="reportBody" style="width: 100%; float: left">
                    
                    <div style="width: 800px; float: left">
                        <fieldset>
                            <legend>Service Details</legend>
                            <div style="width: 800px; float: left">
                                <div style="width:400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                        Service ID :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "ServiceID")%>
                                    </div>
                                </div>
                                <div style="width: 400px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                        Service Stattus :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "ServiceStatus")%>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 800px; float: left">
                                <div style="width: 400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px ;margin-left:20px">
                                        Warranty Available:
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# GetWarranty(DataBinder.Eval(Container.DataItem, "WarrantyAvailable"))%>
                                    </div>
                                </div>
                                <%--<div style="width: 400px; float: left">
                                    <div style="width: 200px; float: left;; height:25px;line-height:25px ">
                                        Customer Address :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "CustomerAddress")%>
                                    </div>
                                </div>--%>
                            </div>
                        </fieldset>
                    </div>
                    <div style="clear: both">
                    </div>
                    <div style="width: 800px; float: left">
                        <fieldset>
                            <legend>Customer Details</legend>
                            <div style="width: 800px; float: left">
                                <div style="width:400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px">
                                        Customer Name :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "CustomerName")%>
                                    </div>
                                </div>
                                <div style="width: 400px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                        Customer Email :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "CustomerEmail")%>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 800px; float: left">
                                <div style="width: 400px; float: left">
                                    <div style="width: 180px; float: left; height:25px;line-height:25px ;margin-left:20px">
                                        Customer Mobile :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "CustomerMobile")%>
                                    </div>
                                </div>
                                <div style="width: 400px; float: left">
                                    <div style="width: 200px; float: left; height:25px;line-height:25px ">
                                        Customer Address :
                                    </div>
                                    <div style="width: 200px; float: left; height:25px;line-height:25px">
                                        <%# DataBinder.Eval(Container.DataItem, "CustomerAddress")%>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div style="clear: both">
                    </div>
                    <div style="width: 800px; float: left">
                        <fieldset>
                            <legend>Handset Details</legend>
                            <div style="width: 800px; float: left">
                                <div style="width: 180px; float: left; height:25px;line-height:25px ;margin-left:20px">
                                    IME Number :
                                </div>
                                <div style="width: 600px; float: left; height:25px;line-height:25px">
                                    <%# DataBinder.Eval(Container.DataItem, "IME")%>
                                </div>
                            </div>
                            <div style="width: 800px; float: left">
                                <div style="width: 180px; float: left; height:25px;line-height:25px;margin-left:20px ">
                                    Model Number :
                                </div>
                                <div style="width: 600px; float: left; height:25px;line-height:25px">
                                    <%# DataBinder.Eval(Container.DataItem, "Model")%>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div style="clear: both">
                    </div>

                    
                    <div style="width: 800px; float: left">
                        <div style="width: 180px; float: left; height:25px;line-height:25px ;margin-left:20px;font-weight:bold;font-size:16px">
                            Service Problems :
                        </div>
                        <div style="width: 600px; float: left; height:25px;line-height:25px">
                            <%# DataBinder.Eval(Container.DataItem, "ServiceProblem")%>
                        </div>
                            
                    </div>

                    <div style="clear: both">
                    </div>
                    <div style="width: 800px; float: left">
                        <div style="width: 180px; float: left; height:25px;line-height:25px ;margin-left:20px;font-weight:bold;font-size:16px">
                            Technician Comments :
                        </div>
                        <div style="width: 600px; float: left; height:25px;line-height:25px">
                            <%# DataBinder.Eval(Container.DataItem, "ProblemComment")%>
                        </div>
                            
                    </div>
                    <div style="clear: both">
                    </div>
                    <div style="width: 800px; float: left;">
                        <%--<div style="width: 770px; float: left;; height:25px;line-height:25px ;margin-left:30px">
                           Service Billing Information :
                        </div>--%>
                        <fieldset>
                            <legend> Spair Parts Details :</legend>
                            <div style="width: 800px; float: left;">
                                <uc1:NotifiedServiceRequisitionControl ID="NotifiedServiceRequisitionControl" runat="server" ServiceID='<%# DataBinder.Eval(Container.DataItem, "ServiceID")%>'  />
                            </div>
                        </fieldset>
                        
                            
                    </div>
                </div>
            </ItemTemplate>
            </asp:DataList>
        </div>
        <div style="clear:both"></div>
        <div style="width:100%;border:0px solid red ; height:25px;line-height:25px;margin-left:300px">
            <asp:Button ID="btnExportToPDF" runat="server" Text="Export To PDF" Height="30px"
                onclick="btnExportToPDF_Click" />
        </div>
    </div>
    
</asp:Content>
