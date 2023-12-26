<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HandsetFromWastageMgtToWarehouse.ascx.cs" Inherits="WSMS.Module.HandsetFromWastageMgtToWarehouse" %>
<%@ Register src="~/Module/ReplacementSubModuleMonitoring.ascx" tagname="ReplacementSubModuleMonitoring" tagprefix="uc2" %>


<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
      <div style="width: 2220px;margin-top:20px;font-size:11px">         
        <div class="grid" style="width: 70px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Request ID
        </div>  
        <div class="grid" style="width: 100px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Wastage ReceiveDate
        </div>  
         <div class="grid" style="width: 100px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             WastageMgt DeliveryDate
        </div>     
        <div class="grid" style="width: 120px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             IMEI_1
        </div>
        <div class="grid" style="width: 120px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             IMEI_2
        </div>
        <div class="grid" style="width: 200px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Model
        </div>
        
        <div class="grid" style="width: 150px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Status
        </div>
        <div class="grid" style="width: 130px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Problem Issue
        </div>
       
        <div class="grid" style="width: 120px;border-right: 1px solid #CCCCCC;height:60px; color:#000000;background-color: #E6E6E6;">
             Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>
       <div  style="width:1127px;  float: left; border:1px solid #CCCCCC ;display:block;font-size:11px">
         <div style="width: 70px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
              
               <div style="width:14px;float:left;">
                    <img id="service-detail" src="images/minus-2.png"" width="10px" height="10px" style="display:block;margin-top:8px;margin-left:5px" /> 
                    <img id="service-detail-hide" src="images/plus-2.png" width="10px" height="10px" style="display:none;margin-top:8px;margin-left:5px" /> 
                </div>

                <%# DataBinder.Eval(Container.DataItem, "RequestID")%>
               
            </div>
             <div style="width:100px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "WastageReceiveDate", "{0:yyyy-MM-dd}")%>
                 
            </div>
            <div id="requestdate2"  style="width:100px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "WastageMgtDeliveryDate", "{0:yyyy-MM-dd}")%>
               
               <input type="hidden" class="hfRequestID" name="hfRequestID" value="<%# DataBinder.Eval(Container.DataItem, "RequestID")%>" />
               <input type="hidden" class="hfIMEI_1" name="hfIMEI_1" value="<%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>" />
               <input type="hidden" class="hfIMEI_2" name="hfIMEI_2" value="<%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>" />
               
                
            </div>
           <div style="width: 120px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
            </div>
            <div style="width: 120px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>

            </div>
            <div style="width: 200px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>
             
            <div style="width: 150px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestStatus")%>
               
            </div>

             <div style="width: 130px;line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Issues")%>
               
            </div>
             
            <div style="width:120px;line-height: 30px;height:30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;">
                                           
               <div id="btn-warehouse-receive-wastage" style="border:1px solid #83AF45;width:100px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:10px;margin-top:4px;">
                  
                    Receive
                </div>
               
            </div>

            <div style="clear:both"></div>
            <div id="replacement-IMEI-problem" style="width: 950px;  float: left;margin-left:50px;margin-top:20px ;margin-bottom:10px;display:none">
                <uc2:ReplacementSubModuleMonitoring ID="ReplacementSubModuleMonitoring" runat="server" RequestID='<%# DataBinder.Eval(Container.DataItem, "RequestID")%>'  />
            </div>
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>
