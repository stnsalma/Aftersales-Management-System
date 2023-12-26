<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RequestForStockFaulty.ascx.cs" Inherits="WSMS.Module.RequestForStockFaulty" %>

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
       <%-- <div class="grid" style="width: 200px;bottom:0">
               Replacement IMEI_1
        </div>
        <div class="grid" style="width: 200px;bottom:0">
               Replacement IMEI_2
        </div>
         <div class="grid" style="width: 200px;bottom:0">
               Replacement Model
        </div>--%>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
                SalesPoint Code
        </div>
        <div class="grid" style="width: 200px;bottom:0;border-right: 1px solid #CCCCCC;color:#000000;background-color: #E6E6E6;">
            Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>

 
        <div  style="width: 210px; float: left; border:1px solid #CCCCCC ;display:block;margin-top:-285px;height:315px;background-color: #F2E0F7;">
         
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
           
          <div id="distridate" style="width: 210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               

                <input type="hidden" class="hfBarCode3" name="hfBarCode3" value="<%# DataBinder.Eval(Container.DataItem, "BarCode")%>" />
                <input type="hidden" class="hfBarCode33" name="hfBarCode33" value="<%# DataBinder.Eval(Container.DataItem, "BarCode2")%>" />               
                <input type="hidden" class="hfModel3" name="hfModel3" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />
                <input type="hidden" class="hfDistributionDate3" name="hfDistributionDate3" value="<%# DataBinder.Eval(Container.DataItem, "DistributionDate")%>" />
                <input type="hidden" class="hfDealerCode3" name="hfDealerCode3" value="<%# DataBinder.Eval(Container.DataItem, "DealerCode")%>" />
               
            </div>
             
             <div id="cellphone1" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="input-cellnumber" style="width: 200px; height: 23px; line-height: 23px;word-break: break-word;
                        float: left; margin-left: 1px; margin-top: 2px; background-color: Silver;;color: #000000;" />
           
            </div>

             <div id="issues1" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 <div id="item-list" class="insert" style="color: #000000;background-color: #F2E0F7;">
                   <%=DDL%>
                </div>
                  
            </div>

             <div id="details1" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="input-details-issues1" style="width: 200px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
            </div>

              <div id="seen_or_not1" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                         <select id="seen-status1" class="insert" style="width:200px">
                                <option value="0" title="status">------- Select Status-------</option>
                                <option value="1" title="status">YES</option>
                                <option value="2" title="status">NO</option>
                         </select>
             </div>

             <%--  <div id="rep_imei_11" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;">
                 
                    <input type="text" id="insert_rep_imei_11" style="width: 200px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;" />
           
              </div>
              <div id="rep_imei_21" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;">
                 
                    <input type="text" id="insert_rep_imei_21" style="width: 200px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;" />
           
             </div>

              <div id="rep_model1" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;">
                 <div id="rep_model_list1" class="insert" style="width:208px">
                   <%=DDLModel%>
                </div>
                  
            </div>--%>

             <div style="width: 210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC; text-align: left;float:left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerCode")%>
               
            </div>

            <div style="width:210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;margin-left:0;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;">
                                           
               <div id="btn-request-stockfaulty" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:60px;margin-top:4px;">
                  
                    Request
                </div>
               
            </div>

           
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>
