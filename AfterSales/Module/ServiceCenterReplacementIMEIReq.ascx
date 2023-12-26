<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServiceCenterReplacementIMEIReq.ascx.cs" Inherits="WSMS.Module.ServiceCenterReplacementIMEIReq" %>

<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 300px;margin-top:20px;font-size:small">  
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Request ID
        </div>   
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
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;height:80px">
            Remarks
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Seen Physically(YES/NO)?
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Replacement IMEI_1
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Replacement IMEI_2
        </div>
         <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Replacement Model
        </div>
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
        <div  style="width: 300px;  float: left;height:555px; border:1px solid #CCCCCC ;display:block;margin-top:-525px;background-color: #F2E0F7;">
          <div style="width: 300px; height: 30px; line-height: 30px;  border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestID")%>
               
            </div>
          <div style="width: 300px; height: 30px; line-height: 30px;  border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
               
            </div>

            <div style="width: 300px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
              
                
            </div>
            <div style="width: 300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>
            <div id="regdate1" style="width: 300px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate","{0:yyyy-MM-dd}")%>
               
                <input type="hidden" class="hfRequestID1" name="hfRequestID1" value="<%# DataBinder.Eval(Container.DataItem, "RequestID")%>" />
               
            </div>
          <div style="width: 300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             

             <div style="width: 300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "PhoneNumber")%>
               
            </div>

               <div style="width: 300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Issues")%>
               
            </div>
            <div style="width: 300px; height: 83px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IssueDetails")%>
               
            </div>

             <div style="width: 300px; height: 32px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IsSeen")%>
               
            </div>

               <div id="rep_imei_1" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 
     <%--              
                <input type="text" id="cellphone2_input" value="<%# DataBinder.Eval(Container.DataItem, "CustomerMobile")%>" style="width: 251px;border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: #E6E6E6;color: #000000;" />--%>

                    <input type="text" id="insert_rep_imei_1" value="<%# DataBinder.Eval(Container.DataItem, "ReplaceIMEI_1")%>"  placeholder="Replacement IMEI_1" style="width: 298px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
              </div>
              <div id="rep_imei_2" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 
                    <input type="text" id="insert_rep_imei_2" value="<%# DataBinder.Eval(Container.DataItem, "ReplaceIMEI_2")%>"  placeholder="Replacement IMEI_2" style="width: 298px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
             </div>

              <div id="rep_model" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: #F2E0F7;">
                 <div id="rep_model_list" class="insert" style="width:298px;color: #000000;background-color: #F2E0F7;">
                   <%=DDLModel%>
                </div>
                  
            </div>
           
              <div id="scu" class="left-bottom" style="width: 300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7; border-top: 1px solid #CCCCCC;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ServiceCenterUserID")%>
               
            </div>
              <div id="dc" class="left-bottom" style="width: 300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerCode")%>
               
            </div>
            <div style="width:300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;background-color: #F2E0F7;">
                                           
               <div id="btn-servicecenter-submit" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;color: blue;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:55px;float:left;margin-top:4px;">                
                    Submit
               </div>
               <div id="btn-servicecenter-print" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;color: red;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:10px;float:left;margin-top:4px;">                
                    <%--Print--%>
                      <a href="RDLCReports/PrintedCopyOfReplacementIMEI.aspx?RequestID=<%# DataBinder.Eval(Container.DataItem, "RequestID")%>"  target="_blank" style="color:Red">Print</a>
 
               </div>
               
            </div>                  
        </div>
    </ItemTemplate>
</asp:Repeater>
