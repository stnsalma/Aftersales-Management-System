<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServiceReplacementFromPlaza.ascx.cs" Inherits="WSMS.Module.ServiceReplacementFromPlaza" %>


<asp:Repeater runat="server" ID="rptrServicereplace">
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
               Old Model Price/Dealer Price
        </div>
        <div class="grid" style="width: 200px;bottom:0;height:30px; color: #000000;background-color: Silver;border-right: 1px solid #FFFFFF;">
               Total money receive by plaza
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
            <div id="dateforReg" style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                  <input id="mRegistrationDate" type="hidden" class="hfmRegistrationDate"  name="hfmRegistrationDate" value="<%# DataBinder.Eval(Container.DataItem, "RegistrationDate")%>" />
            

                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate", "{0:yyyy-MM-dd}")%>   
                           
             
            </div>
            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>
               
            </div>

            <div id="servicedate" style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ServicePlaceDate", "{0:yyyy-MM-dd}")%>
               
                <input type="hidden" class="hfServiceIDr" name="hfServiceIDr" value="<%# DataBinder.Eval(Container.DataItem, "ServiceID")%>" />
               <input type="hidden" class="hfIMEIr" name="hfIMEIr" value="<%# DataBinder.Eval(Container.DataItem, "IME")%>" />
               <input type="hidden" class="hfModelr" name="hfModelr" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />               
               <input type="hidden" class="hfRegistrationDater" name="hfRegistrationDater" value="<%# DataBinder.Eval(Container.DataItem, "RegistrationDate")%>" />
               <input type="hidden" class="hfDealerCoder" name="hfDealerCoder" value="<%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>" />

               <input type="hidden" class="hfServicePlaceDater" name="hfServicePlaceDater" value="<%# DataBinder.Eval(Container.DataItem, "ServicePlaceDate")%>" />
               <input type="hidden" class="hfWarrantyAvailabler" name="hfWarrantyAvailabler" value="<%# DataBinder.Eval(Container.DataItem, "WarrantyAvailable")%>" />
               <input type="hidden" class="hfServicePointName" name="hfServicePointName" value="<%# DataBinder.Eval(Container.DataItem, "ServicePointName")%>" />
               
                <input type="hidden" class="hfAfterServiceRepID" name="hfAfterServiceRepID" value="<%# DataBinder.Eval(Container.DataItem, "AfterServiceRepID")%>" />
               
            </div>
            <div id="warranty" style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "WarrantyAvailable")%>
               
            </div>

             <div id="invoice1" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="invoice1_input" placeholder="Please put Invoice Number" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />       
            </div>

          <div id="cellphone2" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
            
                 
                <input type="text" id="cellphone2_input" value="<%# DataBinder.Eval(Container.DataItem, "CustomerMobile")%>" style="width: 251px;border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />
                   
            </div>
             
             <div id="rep_imei_r" class="left-bottom"  style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
              
                <input type="text" id="insert_rep_imei_r" placeholder="Please put Replacement IMEI_1" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />
           
               
            </div>

              <div id="rep_model_r" class="left-bottom"  style="width: 260px; height:40px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
               
                <div id="rep_model_list_r" class="insert" style="width: 258px;color: #000000;background-color: #F2E0F7;">
                   <%=DDLModel%>
                </div>
                  
               
            </div>

            <div id="repuser_name" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="repuser_name_input" placeholder="Please put User Name and ID" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />       
            </div>
            
             <div id="new" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="new_value" placeholder="Ex: 7650.00" onchange="fill()" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />       
            </div>

             <div id="old" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="old_value"  value="<%# DataBinder.Eval(Container.DataItem, "FaultyHandetPrice")%>" onchange="fill()" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />       
            </div>

             <div id="total" class="left-bottom"  style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #C0C0C0;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="total_value" placeholder="Non Editable" disabled="disabled" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;border-bottom: 1px solid #C0C0C0;" />       
            </div>

            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;margin-left:0;">
                                           
               <div id="btn-replace-IMRI-plaza" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:80px;margin-top:4px;">
                  
                    Action
                </div>
               
            </div>
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>

