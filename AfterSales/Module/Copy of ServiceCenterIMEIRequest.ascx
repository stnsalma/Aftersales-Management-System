<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServiceCenterIMEIRequest.ascx.cs" Inherits="WSMS.Module.ServiceCenterIMEIRequest" %>

<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 300px;margin-top:20px;font-size:small">     
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            IMEI_1
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            IMEI_2
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Model
        </div>
       <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Activation Date
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Distribution Date
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
                CellPhone Number
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
                Issue
        </div>
         <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
                Remarks
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
                Seen Physically(YES/NO)?
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
                SalesPoint Code
        </div>
        <div class="grid" style="width: 200px;bottom:0;border-right: 1px solid #CCCCCC;color:#000000;background-color: #E6E6E6;">
            Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>

 
        <div  style="width: 210px; float: left; border:1px solid #CCCCCC ;display:block;margin-top:-318px;height:315px;background-color: #F2E0F7;">
         
          <div style="width: 210px; height: 30px; line-height: 30px; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
               &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "BarCode")%>
               
            </div>
        

            <div style="width: 210px; height: 30px; line-height: 30px;border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "BarCode2")%>
              
                
            </div>
            <div style="width: 210px; height: 30px; line-height: 30px;border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>

             <div  style="width: 210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate", "{0:yyyy-MM-dd}")%>
              </div>
           
          <div id="distridates" style="width: 210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               

                <input type="hidden" class="hfBarCodes" name="hfBarCodes" value="<%# DataBinder.Eval(Container.DataItem, "BarCode")%>" />
                <input type="hidden" class="hfBarCode2s" name="hfBarCode2s" value="<%# DataBinder.Eval(Container.DataItem, "BarCode2")%>" />               
                <input type="hidden" class="hfModels" name="hfModels" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />
                <input type="hidden" class="hfRegistrationnDates" name="hfRegistrationnDates" value="<%# DataBinder.Eval(Container.DataItem, "RegistrationDate")%>" /> 
                <input type="hidden" class="hfDistributionDates" name="hfDistributionDates" value="<%# DataBinder.Eval(Container.DataItem, "DistributionDate")%>" />
                <input type="hidden" class="hfDealerCodes" name="hfDealerCodes" value="<%# DataBinder.Eval(Container.DataItem, "DealerCode")%>" />
               
            </div>
             
             <div id="cellphone" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="input-cellnumber" style="width: 194px; height: 23px; line-height: 23px;word-break: break-word;
                        float: left; margin-left: 1px; margin-top: 2px; background-color: Silver;" />
           
            </div>

             <div id="issues" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 <div id="item-list" class="insert" style="color: #000000;background-color: #F2E0F7;">
                   <%=DDL%>
                </div>
                  
            </div>

             <div id="details" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="input-details-issues" style="width: 200px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;" />
           
            </div>

              <div id="seen_or_not" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                         <select id="seen-status" class="insert" style="width:200px">
                                <option value="0" title="status">------- Select Status-------</option>
                                <option value="1" title="status">YES</option>
                                <option value="2" title="status">NO</option>
                         </select>
             </div>

             <div style="width: 210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC; text-align: left;float:left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerCode")%>
               
            </div>

            <div style="width:210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;float:left;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;">
                                           
               <div id="btn-servicecenter-approved" style="border:1px solid #83AF45;width:150px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:30px;margin-top:4px;">
                  
                    ServiceCenterApproval
                </div>
               
            </div>

           
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>
