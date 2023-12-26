<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DealerHistory.ascx.cs" Inherits="WSMS.Module.DealerHistory" %>

<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
      
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
        
        <div class="grid" style="width:200px;bottom:0;color:#000000;background-color: #E6E6E6;">
             Organization Name Code
        </div>
         <div class="grid" style="width:200px;bottom:0;color:#000000;background-color: #E6E6E6;">
             DONumber
        </div>
           <div class="grid" style="width:200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Distribution Date(yyyy-mm-dd)
        </div>
        <div class="grid" style="width: 200px;border-right: 1px solid #CCCCCC;bottom:0;color:#000000;background-color: #E6E6E6;">
            Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div  style="width: 300px;  float: left;height:230px; border:1px solid #CCCCCC ;display:block;margin-top:-193px;background-color: white;">
         
          <div style="width: 300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;border-right: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: white;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "BarCode")%>
               
            </div>

            <div style="width: 300px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: white;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "BarCode2")%>
              
                
            </div>
            <div id="modelForDealer" style="width: 300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;border-right: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: white;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
                 <input type="hidden" class="hfBarCode" name="hfBarCode" value="<%# DataBinder.Eval(Container.DataItem, "BarCode")%>" />
                <input type="hidden" class="hfBarCode2" name="hfBarCode2" value="<%# DataBinder.Eval(Container.DataItem, "BarCode2")%>" />               
                <input type="hidden" class="hfModel" name="hfModel" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />

            </div>

             <div id="ddName" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color:white;width: 300px">
                 <div id="item-list-code" class="insert" style="color: #000000;background-color:white;width: 300px">
                   <%=DDLDealerName%>
                </div>
                  
            </div>
            <div id="doNumber" class="left-bottom"  style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: white;width: 300px">
                 
                    <input type="text" id="insert_doNumber" placeholder="Insert if necessary" style="width: 300px; height: 25px; line-height: 23px; word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;" />
           
             </div>
             <div id="distri_Date_Div" style="width: 300px; height: 30px; line-height: 30px; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7">
                &nbsp;
               <input type="date" class="datepicker" id="distributionDate" placeholder="YYYY-MM-DD" required pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" style="width:300px;margin-top:-30px; height: 30px;border:1px solid gray;float:left;margin-right:3px" />
        
            </div>
       
            <%-- <div id="monitorName" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;;color: #000000;background-color:white;width: 300px">
                 <div id="item-list-name" class="insert" style="color: #000000;background-color:white;width: 300px">
                   <%=MonitorName%>
                </div>
                  
            </div>--%>
            <div style="width:300px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;border-top: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color:white;">
                                           
               <div id="btn-save-distribution-record" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:60px;float:left;margin-top:4px;">                
                    SAVE
                </div>
               
            </div>                  
        </div>
    </ItemTemplate>
</asp:Repeater>
