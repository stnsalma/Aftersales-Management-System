﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManagementReport.ascx.cs" Inherits="WSMS.Module.ManagementReport" %>

<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 1970px;margin-top:20px;font-size:small"> 
        
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
            Request ID
        </div>    
        <div class="grid" style="width: 130px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
            IMEI_1
        </div>
        <div class="grid" style="width: 130px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             IMEI_2
        </div>
        <div class="grid" style="width: 160px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Model
        </div>
         <div class="grid" style="width: 200px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             SalesPoint Name
        </div>
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Activation Date
        </div>
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Distribution Date
        </div>
        <div class="grid" style="width: 150px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Status
        </div>
        <div class="grid" style="width: 100px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
              Issues
        </div>
       <div class="grid" style="width: 170px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
              Issue Details
        </div>
        <div class="grid" style="width: 100px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
              CellPhone Number
        </div>
         <div class="grid" style="width: 200px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
               Warehouse Declined Reason
        </div>
         <div class="grid" style="width: 100px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Warehouse Declined Date
        </div>
        <div class="grid" style="width: 150px;border-right: 1px solid #CCCCCC;height:60px;color:#000000;background-color: #E6E6E6;">
             Management Status
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div  style="width: 1857px;  float: left; border:1px solid #CCCCCC ;display:block">  

         <div style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
              
                <%# DataBinder.Eval(Container.DataItem, "RequestID")%>
               
            </div>
           <div style="width: 130px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
              
                
            </div>
        

            <div style="width: 130px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
              
                
            </div>
            <div style="width: 160px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>

            <div style="width: 200px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>
               
            </div>
            <div id="regdate" style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate","{0:yyyy-MM-dd}")%>
               
               <input type="hidden" class="hfRequestID" name="hfRequestID" value="<%# DataBinder.Eval(Container.DataItem, "RequestID")%>" />
               <input type="hidden" class="hfBarCode1" name="hfBarCode1" value="<%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>" />
               <input type="hidden" class="hfBarCode2" name="hfBarCode2" value="<%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>" />               
               <input type="hidden" class="hfModel" name="hfModel" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />
               <input type="hidden" class="hfRegistrationDate" name="hfRegistrationDate" value="<%# DataBinder.Eval(Container.DataItem, "RegistrationDate")%>" />
               <input type="hidden" class="hfDistributionDate" name="hfDistributionDate" value="<%# DataBinder.Eval(Container.DataItem, "DistributionDate")%>" />
               <input type="hidden" class="hfwhDeclineDate" name="hfwhDeclineDate" value="<%# DataBinder.Eval(Container.DataItem, "UpdatedDate")%>" />
               
            </div>
          <div style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             
             <div style="width: 150px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestType")%>
               
            </div>


             <div style="width: 100px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Issues")%>
               
            </div>
              <div style="width: 170px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IssueDetails")%>
               
            </div>
              <div style="width: 100px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "PhoneNumber")%>
               
            </div>

             <div style="width: 200px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Reason")%>
               
            </div>
               <div style="width: 100px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;height:60px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "UpdatedDate", "{0:yyyy-MM-dd}")%>
               
            </div>
            <div style="width:150px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;height:60px;color: #000000;background-color: #F2E0F7;">
                                           
                <%# DataBinder.Eval(Container.DataItem, "RequestStatus")%>
            </div>

           
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>
