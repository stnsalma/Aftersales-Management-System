<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WareHouseApproval.ascx.cs" Inherits="WSMS.Module.WareHouseApproval" %>
<%@ Register src="~/Module/ReplacementSubModuleMonitoring.ascx" tagname="ReplacementSubModuleMonitoring" tagprefix="uc2" %>


<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 2652px;margin-top:20px;"> 
        
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
            Request ID
        </div>  
            <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
            Appr._ID
        </div> 
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
            Appr._Date
        </div>  
        <div class="grid" style="width: 130px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
            IMEI_1
        </div>
        <div class="grid" style="width: 130px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             IMEI_2
        </div>
        <div class="grid" style="width: 180px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Model
        </div>

         <div class="grid" style="width: 260px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             SalesPoint Name
        </div>
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Activation Date
        </div>
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Distribution Date
        </div>
        <div class="grid" style="width: 160px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Status
        </div>
        <div class="grid" style="width: 150px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
              Issues
        </div>
      
        <div class="grid" style="width: 150px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
              Approved Status
        </div>
        <div class="grid" style="width: 100px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
              CellPhone Number
        </div>
         <div class="grid" style="width: 200px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
                Reason
        </div>
        <div class="grid" style="width: 220px;border-right: 1px solid #CCCCCC;height:60px;color:#000000;background-color: #E6E6E6;">
             Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>


        <div  style="width: 2110px;  float: left; border:1px solid #CCCCCC ;display:block">
         

         <div style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
              
                 <div style="width:14px;float:left;">
                    <img id="service-detail" src="images/minus-2.png" width="10px" height="10px" style="display:block;margin-top:8px;margin-left:5px" /> 
                    <img id="service-detail-hide" src="images/plus-2.png" width="10px" height="10px" style="display:none;margin-top:8px;margin-left:5px" /> 
                </div>

                <%# DataBinder.Eval(Container.DataItem, "RequestID")%>
               
            </div>
             <div style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
              
                

                <%# DataBinder.Eval(Container.DataItem, "ApprovalID")%>
               
            </div>
             <div style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
              
                
                <%# DataBinder.Eval(Container.DataItem, "ApprovedDate", "{0:yyyy-MM-dd}")%>
               
            </div>
           <div style="width: 130px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
              
                
            </div>
        

            <div style="width: 130px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
              
                
            </div>
            <div style="width: 180px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>

            <div style="width: 260px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>
               
            </div>
            <div id="regdate" style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate","{0:yyyy-MM-dd}")%>
               
               <input type="hidden" class="hfRequestID" name="hfRequestID" value="<%# DataBinder.Eval(Container.DataItem, "RequestID")%>" />
               <input type="hidden" class="hfBarCode1" name="hfBarCode1" value="<%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>" />
               <input type="hidden" class="hfBarCode2" name="hfBarCode2" value="<%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>" />               
               <input type="hidden" class="hfModel" name="hfModel" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />
               <input type="hidden" class="hfDealerName" name="hfDealerName" value="<%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>" />

               <input type="hidden" class="hfRegistrationDate" name="hfRegistrationDate" value="<%# DataBinder.Eval(Container.DataItem, "RegistrationDate")%>" />
               <input type="hidden" class="hfDistributionDate" name="hfDistributionDate" value="<%# DataBinder.Eval(Container.DataItem, "DistributionDate")%>" />
               <input type="hidden" class="hfRequestType" name="hfRequestType" value="<%# DataBinder.Eval(Container.DataItem, "RequestType")%>" />
               
            </div>
          <div style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             
             <div style="width: 160px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestType")%>
               
            </div>


             <div style="width: 150px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Issues")%>
               
            </div>
             
              <div style="width: 150px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestStatus")%>
               
            </div>
              <div style="width: 100px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "PhoneNumber")%>
               
            </div>

            <div id="reason" class="left-bottom" style="background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                 
                    <input type="text" id="input-reason" style="width: 194px; height: 23px; line-height: 23px;word-break: break-word;
                        float: left; margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
            </div>

            <div style="width:220px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;background-color: #F2E0F7;color: #000000">
                                           
               <div id="btn-receive" style="border:1px solid #83AF45;width:90px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:10px;margin-top:4px;">
                  
                    Receive
                </div>
               <div id="btn-decline" style="border:1px solid #83AF45;width:90px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:10px;margin-top:4px;">
                  
                    Decline
                </div>
            </div>

            <div style="clear:both"></div>
            <div id="replacement-IMEI-problem" style="width: 950px;  float: left;margin-left:50px;margin-top:20px ;margin-bottom:10px;display:none">
                <uc2:ReplacementSubModuleMonitoring ID="ReplacementSubModuleMonitoring" runat="server" RequestID='<%# DataBinder.Eval(Container.DataItem, "RequestID")%>'  />
            </div>
             
        </div>
    </ItemTemplate>
     <%--<FooterTemplate>
        <asp:Label ID="lblErrorMsg" runat="server" Text="Sorry, no item is there to show." Visible="false">
        </asp:Label>
    </FooterTemplate>--%>

    <%--<FooterTemplate>  
        <%if (rptrServicePending.Items.Count == 0)  
          { %>  
          **Your message**  
        <%} %>  
    </FooterTemplate>  --%>
</asp:Repeater>
