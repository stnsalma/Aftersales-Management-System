<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="IMEIRecommendMonitoring.ascx.cs" Inherits="WSMS.Module.IMEIRecommendMonitoring" %>
<%@ Register src="~/Module/ReplacementSubModuleMonitoring.ascx" tagname="ReplacementSubModuleMonitoring" tagprefix="uc2" %>


<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
      <div style="width: 2600px;margin-top:20px;height:60px;font-size:11px"> 
        
        <div class="grid" style="width: 70px;height:60px; color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
            Request ID
        </div>    
        <div class="grid" style="width: 110px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
            IMEI_1
        </div>
        <div class="grid" style="width: 110px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             IMEI_2
        </div>
        <div class="grid" style="width: 150px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Model
        </div>
          <div class="grid" style="width: 200px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Replacement Given By?
        </div>
         <div class="grid" style="width: 200px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             SalesPoint Name
        </div>
        <div class="grid" style="width: 70px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Activation Date
        </div>
        <div class="grid" style="width: 70px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Distribution Date
        </div>
         <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Request Date
        </div>
        <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Recom. Date
        </div>
        <div class="grid" style="width: 70px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Pri.Recom. Date
        </div>
        <div class="grid" style="width: 120px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Request Type
        </div>
         <div class="grid" style="width: 120px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
             Request Status
        </div>
        <div class="grid" style="width: 120px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
              Issues
        </div>      
        <div class="grid" style="width: 100px;height:60px; color: #000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
              CellPhone Number
        </div>
        <div class="grid" style="width: 200px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;height:60px">
                Decline Reason
        </div>
        <div class="grid" style="width: 200px;border-right: 1px solid #CCCCCC;height:60px; color: #000000;background-color: #E6E6E6;height:60px">
             Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div  style="width: 2083px;  float: left; border:1px solid #CCCCCC ;display:block;font-size:11px">
         <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
              
               <div style="width:14px;float:left;">
                    <img id="service-detail" src="images/minus-2.png"" width="10px" height="10px" style="display:block;margin-top:8px;margin-left:5px" /> 
                    <img id="service-detail-hide" src="images/plus-2.png" width="10px" height="10px" style="display:none;margin-top:8px;margin-left:5px" /> 
                </div>

                <%# DataBinder.Eval(Container.DataItem, "IMRequestID")%>
               
            </div>
           <div style="width: 110px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
                           
            </div>
       
            <div style="width: 110px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
              
                
            </div>
            <div style="width: 150px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>
             <div style="width: 200px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RepUserFullName")%>
               
            </div>
            <div style="width: 200px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>
               
            </div>
            <div id="regdate" style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate","{0:yyyy-MM-dd}")%>
               
               <input type="hidden" class="hfRequestID" name="hfRequestID" value="<%# DataBinder.Eval(Container.DataItem, "IMRequestID")%>" />
               <input type="hidden" class="hfBarCode" name="hfBarCode" value="<%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>" />
               <input type="hidden" class="hfBarCode2" name="hfBarCode2" value="<%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>" />               
               <input type="hidden" class="hfModel" name="hfModel" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />
               <input type="hidden" class="hfDealerName" name="hfDealerName" value="<%# DataBinder.Eval(Container.DataItem, "Organaization_Name")%>" />

               <input type="hidden" class="hfRegistrationDate" name="hfRegistrationDate" value="<%# DataBinder.Eval(Container.DataItem, "RegistrationDate")%>" />
               <input type="hidden" class="hfDistributionDate" name="hfDistributionDate" value="<%# DataBinder.Eval(Container.DataItem, "DistributionDate")%>" />
               <input type="hidden" class="hfRequestType" name="hfRequestType" value="<%# DataBinder.Eval(Container.DataItem, "RequestType")%>" />
               <input type="hidden" class="hfRequestStatus" name="hfRequestStatus" value="<%# DataBinder.Eval(Container.DataItem, "RequestStatus")%>" />
               
            </div>
          <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               
            </div>
            <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RecommendedDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             <div style="width: 70px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "PrimaryRecomDate", "{0:yyyy-MM-dd}")%>
            </div>
             <div style="width: 120px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestType")%>
               
            </div>
             <div style="width: 120px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestStatus")%>
               
            </div>
             <div style="width: 120px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Issues")%>
               
            </div>
              <div style="width: 100px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "PhoneNumber")%>
               
            </div>
             <div id="decline-reason" class="left-bottom" style="background-color: #F2E0F7;border-right: 1px solid #FFFFFF;color: #000000">
                 
                    <input type="text" id="decline-reason-input" style="width: 194px; height: 23px; line-height: 23px;word-break: break-word;
                        float: left; margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
            </div>
            <div style="width:200px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;">
                                           
               <div id="btn-recommend-IMRI" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:10px;margin-top:4px;">
                    Approve
                </div>
               <div id="btn-declined-IMRI" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
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
    
</asp:Repeater>
