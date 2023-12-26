<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CorporateStoreReport.ascx.cs" Inherits="WSMS.Module.CorporateStoreReport" %>

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
         <div class="grid" style="width: 100px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             CorporateStore ReceiveDate
        </div>      
        <div class="grid" style="width: 110px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             IMEI_1
        </div>
        <div class="grid" style="width: 110px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             IMEI_2
        </div>
        <div class="grid" style="width: 180px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Model
        </div>
        <div class="grid" style="width: 150px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Status
        </div>
        <div class="grid" style="width: 130px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #CCCCCC;">
              Issue
        </div>
     
    </div>
    </HeaderTemplate>
    <ItemTemplate>


        <div  style="width:1067px;  float: left; border:1px solid #CCCCCC ;display:block;font-size:11px">
         

         <div style="width: 70px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
              
                <%# DataBinder.Eval(Container.DataItem, "RequestID")%>
               
            </div>
             <div style="width:100px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "WastageReceiveDate", "{0:yyyy-MM-dd}")%>
                 
            </div>
            <div  style="width:100px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "WastageMgtDeliveryDate", "{0:yyyy-MM-dd}")%>

            </div>
             <div  style="width:100px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "CorporateStoreReceive", "{0:yyyy-MM-dd}")%>

            </div>
           <div style="width: 110px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
              
                
            </div>

            <div style="width: 110px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
              
                
            </div>
            <div style="width: 180px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
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
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #CCCCCC;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Issues")%>
               
            </div>

        </div>
    </ItemTemplate>
    
</asp:Repeater>
