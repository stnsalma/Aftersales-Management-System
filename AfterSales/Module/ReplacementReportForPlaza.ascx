<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplacementReportForPlaza.ascx.cs" Inherits="WSMS.Module.ReplacementReportForPlaza" %>

<asp:Repeater runat="server" ID="rptrReplacementForPlaza">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 2000px;margin-top:20px;font-size:11px;"> 
        <div class="grid" style="width: 70px;height:60px; color:#000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            Repl.ID
        </div> 
        <div class="grid" style="width: 70px;height:60px; color:#000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            ServiceID
        </div>    
        <div class="grid" style="width: 100px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            IMEI
        </div>
        <div class="grid" style="width: 160px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            Model
        </div>
       <%-- <div class="grid" style="width: 170px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            ServicePoint Name
        </div>
        <div class="grid" style="width: 70px;height:60px; color: #000000;background-color:Silver;border-right: 1px solid #FFFFFF;">
             Activation Date
        </div>

         <div class="grid" style="width: 170px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
             SalesPoint Name
        </div>
        <div class="grid" style="width: 70px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
             Receive Date
        </div>
        <div class="grid" style="width: 60px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            Warranty
        </div>
          <div class="grid" style="width: 100px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
              Invoice Number
        </div>
        <div class="grid" style="width: 100px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
             Mobile Number
        </div>
--%>     
        <div class="grid" style="width: 100px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
              Repl. IMEI_1
        </div>
       
        <div class="grid" style="width: 160px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               Repl. Model
        </div>

         <div class="grid" style="width: 100px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               Replacement GivenBy
        </div>
       <%-- <div class="grid" style="width: 80px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               New Model Price
        </div>
        <div class="grid" style="width: 80px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               Old Model Price
        </div>
        <div class="grid" style="width: 80px;height:60px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               Total
        </div>--%>
       
    </div>
    </HeaderTemplate>
    <ItemTemplate>


        <div  style="width: 772px;  float: left; border:1px solid #CCCCCC ;display:block;background-color: #F2E0F7;font-size:11px;">
         
         <div style="width: 70px; height: 60px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
          
                <%# DataBinder.Eval(Container.DataItem, "AfterServiceRepID")%>
               
            </div>
         <div style="width: 70px; height: 60px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
          
                <%# DataBinder.Eval(Container.DataItem, "ServiceID")%>
               
            </div>
           <div style="width: 100px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IME")%>
              
                
            </div>
        
            <div style="width: 160px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>              
            </div>
          <%--  <div style="width: 170px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ServicePointName")%>              
            </div>
            <div style="width: 70px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate", "{0:yyyy-MM-dd}")%>              
                
            </div>
            <div style="width: 170px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerName")%>
               
            </div>

            <div id="servicedate2" style="width: 70px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ServicePlaceDate", "{0:yyyy-MM-dd}")%>
               
            </div>
            <div id="warranty2" style="width: 60px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "WarrantyAvailability")%>
               
            </div>

             <div id="invoice2" class="left-bottom" style="width: 100px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                   &nbsp;       
               <%# DataBinder.Eval(Container.DataItem, "Invoice")%>      
            </div>

          <div id="cellphone21" class="left-bottom" style="width: 100px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
             &nbsp;
                 
                 <%# DataBinder.Eval(Container.DataItem, "CustomerMobile")%>  
                   
            </div>
             --%>
             <div id="rep_imei_r2" class="left-bottom"  style="width: 100px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
               &nbsp;
                 <%# DataBinder.Eval(Container.DataItem, "NewHandsetIMEI")%>
           
              
                                    
            </div>

           
              <div id="rep_model_r2" class="left-bottom"  style="width: 160px; height:60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                  <%# DataBinder.Eval(Container.DataItem, "NewHandsetModel")%>
                  
               
            </div>

            <div id="repuser_name2" class="left-bottom" style="width: 100px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                    &nbsp;      
                   <%# DataBinder.Eval(Container.DataItem, "ReplacementGivenBy")%>       
            </div>
            
             <%--<div id="new2" class="left-bottom" style="width: 80px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                  &nbsp;        
               <%# DataBinder.Eval(Container.DataItem, "NewHandsetPrice")%>        
            </div>

             <div id="old2" class="left-bottom" style="width: 80px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                    &nbsp;      
                 <%# DataBinder.Eval(Container.DataItem, "FaultyHandsetPriceByPlaza")%>          
            </div>

             <div id="total2" class="left-bottom"  style="width: 80px; height: 60px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #C0C0C0;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                  &nbsp;
                  <%# DataBinder.Eval(Container.DataItem, "TotalReceiveFromCustomerByPlaza")%>   
            </div>--%>
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>

