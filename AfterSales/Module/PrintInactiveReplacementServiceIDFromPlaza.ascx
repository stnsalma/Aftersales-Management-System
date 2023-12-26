<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PrintInactiveReplacementServiceIDFromPlaza.ascx.cs" Inherits="WSMS.Module.PrintInactiveReplacementServiceIDFromPlaza" %>

<asp:Repeater runat="server" ID="rptrInactiveServiceIDfromPlaza">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 300px;margin-top:20px;height:60px;font-size:small;"> 
        <div class="grid" style="width: 200px;bottom:0;height:30px; color:#000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            AfterService ReplacementID
        </div> 
        <div class="grid" style="width: 200px;bottom:0;height:30px; color:#000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            Service ID
        </div>    
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            IMEI
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            Model
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
            ServicePoint Name
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color:Silver;border-right: 1px solid #FFFFFF;">
             Activation Date
        </div>

         <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
             SalesPoint Name
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
             Receive Date
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
             IsWarrantyAvailable?
        </div>
          <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
              Invoice Number
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
             Mobile Number (+88)
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
              ReplacementIMEI_1
        </div>
       
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               ReplacementModel
        </div>

         <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               Replacement Given by?
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               New Model Price
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               Old Model Price
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               Total
        </div>
        <div class="grid" style="width: 200px;bottom:0;border-right: 1px solid #CCCCCC;height:30px; color: #000000;background-color: Silver; ">
             Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>


        <div  style="width: 260px;  float: left;height:537px; border:1px solid #CCCCCC ;display:block;margin-top:-541px;background-color: #F2E0F7;">
         
         <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
          
                <%# DataBinder.Eval(Container.DataItem, "AfterServiceRepID")%>
               
            </div>
         <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
          
                <%# DataBinder.Eval(Container.DataItem, "ServiceID")%>
               
            </div>
           <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IME")%>
              
                
            </div>
        
            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>              
            </div>
            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ServicePointName")%>              
            </div>
            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate", "{0:yyyy-MM-dd}")%>              
                
            </div>
            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerName")%>
               
            </div>

            <div id="servicedate9" style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ServicePlaceDate", "{0:yyyy-MM-dd}")%>
           
               
            </div>
            <div id="warranty9" style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "WarrantyAvailability")%>
               
            </div>

             <div id="invoice9" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                   &nbsp;       
               <%# DataBinder.Eval(Container.DataItem, "Invoice")%>      
            </div>

          <div id="cellphone9" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
             &nbsp;
                 
                 <%# DataBinder.Eval(Container.DataItem, "CustomerMobile")%>  
                   
            </div>
             
             <div id="rep_imei_r9" class="left-bottom"  style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
               &nbsp;
                 <%# DataBinder.Eval(Container.DataItem, "NewHandsetIMEI")%>
           
               
            </div>

              <div id="rep_model_r9" class="left-bottom"  style="width: 260px; height:40px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                  <%# DataBinder.Eval(Container.DataItem, "NewHandsetModel")%>
                  
               
            </div>

            <div id="repuser_name9" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                    &nbsp;      
                   <%# DataBinder.Eval(Container.DataItem, "ReplacementGivenBy")%>       
            </div>
            
             <div id="new9" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                  &nbsp;        
               <%# DataBinder.Eval(Container.DataItem, "NewHandsetPrice")%>        
            </div>

             <div id="old9" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                    &nbsp;      
                 <%# DataBinder.Eval(Container.DataItem, "FaultyHandsetPriceByPlaza")%>          
            </div>

             <div id="total9" class="left-bottom"  style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #C0C0C0;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                  &nbsp;
                  <%# DataBinder.Eval(Container.DataItem, "Total")%>   
            </div>

            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;margin-left:0;">
                                           
               <div id="print-btn-inactivereplacement" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:80px;margin-top:4px;">

                   <a href="../RDLCReports/PrintActiveServiceIDFromPlaza.aspx?ServiceID=<%# DataBinder.Eval(Container.DataItem, "ServiceID")%>"  target="_blank">Print</a>
                </div>
               
            </div>
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>

