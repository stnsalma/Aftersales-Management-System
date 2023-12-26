﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MonitoringAndMarkettingReport.ascx.cs" Inherits="WSMS.Module.MonitoringAndMarkettingReport" %>

<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 2000px;margin-top:20px;font-size:11px"> 
         <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
            Request ID
        </div> 
          
        <div class="grid" style="width: 100px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
            IMEI_1
        </div>
        <div class="grid" style="width: 100px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             IMEI_2
        </div>
        <div class="grid" style="width: 160px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Model
        </div>
        <div class="grid" style="width: 200px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Party Name
        </div>
        <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Activation Date
        </div>
        <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Distribution Date
        </div>
        <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Request Date
        </div>
        <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Recom. Date
        </div>
        <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Pri.Recom. Date
        </div>
        <div class="grid" style="width: 130px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
              Request Type
        </div>
        <div class="grid" style="width: 140px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
              Issues
        </div>
        <div class="grid" style="width: 110px;border-right: 1px solid #CCCCCC;color:#000000;background-color: #E6E6E6;height:60px">
             Status
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>


        <div  style="width: 1386px;  float: left; border:1px solid #CCCCCC ;display:block;font-size:11px">
         

         <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
              
                <%# DataBinder.Eval(Container.DataItem, "RequestID")%>
               
            </div>
           <div style="width: 100px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
              
                
            </div>

            <div style="width: 100px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
              
                
            </div>
            <div style="width: 160px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>
            <div style="width: 200px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>
               
            </div>
            <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate", "{0:yyyy-MM-dd}")%>
               
            </div>
              <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RecommendedDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "PrimaryRecomDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             <div style="width: 130px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestType")%>
               
            </div>
             <div style="width: 140px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Issues")%>
               
            </div>
            <div style="width:110px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;">
                                           
                <%# DataBinder.Eval(Container.DataItem, "RequestStatus")%>
            </div>

           
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>
