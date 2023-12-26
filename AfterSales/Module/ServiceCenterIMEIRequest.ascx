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
            Sales Date
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
        <%--<div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Replacement IMEI_1
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Replacement IMEI_2
        </div>
         <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Replacement Model
        </div>--%>
        <div class="grid" style="width:200px;bottom:0;color:#000000;background-color: #E6E6E6;">
             Replacement Given By(ID)?
        </div>
        <div class="grid" style="width:200px;bottom:0;color:#000000;background-color: #E6E6E6;">
             SalesPoint Code
        </div>
         
        <div class="grid" style="width: 200px;border-right: 1px solid #CCCCCC;bottom:0;color:#000000;background-color: #E6E6E6;">
            Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div  style="width: 210px;  float: left;height:380px; border:1px solid #CCCCCC ;display:block;margin-top:-350px;background-color: #F2E0F7;">
         
          <div style="width: 210px; height: 30px; line-height: 30px;  border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "BarCode")%>
               
            </div>

            <div style="width: 210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "BarCode2")%>
              
                
            </div>
            <div style="width: 210px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>
            <div id="regdate" style="width: 210px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate","{0:yyyy-MM-dd}")%>
               
                <input type="hidden" class="hfBarCode" name="hfBarCode" value="<%# DataBinder.Eval(Container.DataItem, "BarCode")%>" />
                <input type="hidden" class="hfBarCode2" name="hfBarCode2" value="<%# DataBinder.Eval(Container.DataItem, "BarCode2")%>" />               
                <input type="hidden" class="hfModel" name="hfModel" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />
                <input type="hidden" class="hfRegistrationDate" name="hfRegistrationDate" value="<%# DataBinder.Eval(Container.DataItem, "RegistrationDate")%>" />
                <input type="hidden" class="hfDistributionDate" name="hfDistributionDate" value="<%# DataBinder.Eval(Container.DataItem, "DistributionDate")%>" />
                <input type="hidden" class="hfDealerCode" name="hfDealerCode" value="<%# DataBinder.Eval(Container.DataItem, "DealerCode")%>" />
               
            </div>
          <div style="width: 210px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             
             <div id="cellphone" class="left-bottom">
                 
                    <input type="text" id="input-cellnumber" placeholder="Mobile number of customer" style="width: 200px;border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
            </div>

             <div id="issues" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;;color: #000000;background-color: #F2E0F7;">
                 <div id="item-list" class="insert" style="color: #000000;background-color: #F2E0F7;">
                   <%=DDL%>
                </div>
                  
            </div>
             <div id="details" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="input-details-issues" placeholder="Details problem of this Handset" style="width: 200px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
            </div>

              <div id="seen_or_not" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                         <select id="seen-status" class="insert" style="width:200px">
                                <option value="0" title="status">------- Select Status-------</option>
                                <option value="1" title="status">YES</option>
                                <option value="2" title="status">NO</option>
                         </select>
             </div>

              <%-- <div id="rep_imei_1" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="insert_rep_imei_1"  placeholder="Replacement IMEI_1" style="width: 200px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
              </div>
              <div id="rep_imei_2" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="insert_rep_imei_2" placeholder="Replacement IMEI_2" style="width: 200px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
             </div>

              <div id="rep_model" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 <div id="rep_model_list" class="insert" style="width:208px;color: #000000;background-color: #F2E0F7;">
                   <%=DDLModel%>
                </div>
                  
            </div>--%>
             <div id="repGivenBy" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="insert_repGivenBy" placeholder="Replacement given by (UserID)?" style="width: 200px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
              </div>
             <div style="width: 210px; height: 30px; line-height: 30px; border-right: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;float:left;border-top: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerCode")%>
               
            </div>
            <div style="width:210px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;">
                                           
               <div id="btn-servicecenter-request" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:60px;float:left;margin-top:4px;">                
                    Request
                </div>
               
            </div>                  
        </div>
    </ItemTemplate>
</asp:Repeater>
