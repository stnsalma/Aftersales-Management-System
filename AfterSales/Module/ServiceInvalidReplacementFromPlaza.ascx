<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServiceInvalidReplacementFromPlaza.ascx.cs" Inherits="WSMS.Module.ServiceInvalidReplacementFromPlaza" %>


<asp:Repeater runat="server" ID="rptrinvalidServicereplace">
    <HeaderTemplate>
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
           
             <div id="registration3" style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                
                 
                   <input type="text" id="registration3_input" style="width: 258px;border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
             </div>

            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>
               
            </div>

            <div id="servicedate2" style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ServicePlaceDate", "{0:yyyy-MM-dd}")%>
               
                <input type="hidden" class="hfAfterServiceRepIDr24" name="hfAfterServiceRepIDr24" value="<%# DataBinder.Eval(Container.DataItem, "AfterServiceRepID")%>" />

                <input type="hidden" class="hfServiceIDr24" name="hfServiceIDr24" value="<%# DataBinder.Eval(Container.DataItem, "ServiceID")%>" />
               <input type="hidden" class="hfIMEIr24" name="hfIMEIr24" value="<%# DataBinder.Eval(Container.DataItem, "IME")%>" />
               <input type="hidden" class="hfModelr24" name="hfModelr24" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />               
               
               <input type="hidden" class="hfDealerCoder24" name="hfDealerCoder24" value="<%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>" />
                 <input type="hidden" class="hfServicePointName24" name="hfServicePointName24" value="<%# DataBinder.Eval(Container.DataItem, "ServicePointName")%>" />
               <input type="hidden" class="hfServicePlaceDater24" name="hfServicePlaceDater24" value="<%# DataBinder.Eval(Container.DataItem, "ServicePlaceDate")%>" />
               <input type="hidden" class="hfWarrantyAvailabler24" name="hfWarrantyAvailabler24" value="<%# DataBinder.Eval(Container.DataItem, "WarrantyAvailable")%>" />
               <input type="hidden" class="hfServicePointName24" name="hfServicePointName24" value="<%# DataBinder.Eval(Container.DataItem, "ServicePointName")%>" />
               
                <input type="hidden" class="hfAfterServiceRepID24" name="hfAfterServiceRepID24" value="<%# DataBinder.Eval(Container.DataItem, "AfterServiceRepID")%>" />
               
            </div>
            <div id="warranty" style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "WarrantyAvailable")%>
               
            </div>

             <div id="invoice2" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="invoice2_input" placeholder="Please put Invoice Number" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />       
            </div>

          <div id="cellphone3" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
            
                 
                <input type="text" id="cellphone3_input" value="<%# DataBinder.Eval(Container.DataItem, "CustomerMobile")%>" style="width: 251px;border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />
                   
            </div>
             
             <div id="rep_imei_r3" class="left-bottom"  style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
              
                <input type="text" id="insert_rep_imei_r3" placeholder="Please put Replacement IMEI_1" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />
           
               
            </div>

              <div id="rep_model_r3" class="left-bottom"  style="width: 260px; height:40px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
               
                <div id="rep_model_list_r3" class="insert" style="width: 258px;color: #000000;background-color: #F2E0F7;">
                   <%=DDLModel%>
                </div>
                  
               
            </div>

            <div id="repuser_name3" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="repuser_name_input3" placeholder="Please put User Name" onchange="fill()" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />       
            </div>
            
             <div id="new3" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="new_value3" placeholder="Ex: 7650.00" onchange="fill1()" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />       
            </div>

             <div id="old3" class="left-bottom" style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="old_value3" value="<%# DataBinder.Eval(Container.DataItem, "FaultyHandetPrice")%>" onchange="fill1()" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />       
            </div>

             <div id="total3" class="left-bottom"  style="width: 258px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #C0C0C0;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                         
               <input type="text" id="total_value3" placeholder="Non Editable" disabled="disabled" style="width: 252px; height: 25px; line-height: 23px; word-spacing:normal;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;border-bottom: 1px solid #C0C0C0;" />       
            </div>

            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;margin-left:0;">
                                           
               <div id="btn-replace-invalid-IMRI-plaza" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:80px;margin-top:4px;">
                  
                    Action
                </div>
               
            </div>
             
        </div>

       
    </ItemTemplate>
    
</asp:Repeater>


 