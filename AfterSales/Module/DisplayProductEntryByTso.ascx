<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayProductEntryByTso.ascx.cs" Inherits="WSMS.Module.DisplayProductEntryByTso" %>

<asp:Repeater runat="server" ID="rptrDisplayEntry">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 300px;margin-top:30px;font-size:small">     
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
            Current Dealer Name
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
         Do u want to change Dealer?
        </div>
         <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Distribution Date(yyyy-mm-dd)
        </div>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Display Date
        </div>
       
        <%--<div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Is In Display?
        </div>--%>
        <div class="grid" style="width: 200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            Is ApprovedBy NSM?
        </div>
        <div class="grid" style="width: 200px;border-right: 1px solid #CCCCCC;bottom:0;color:#000000;background-color: #E6E6E6;">
            Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div  style="width: 260px;  float: left;height:284px; border:1px solid #CCCCCC ;display:block;margin-top:-255px;background-color: #F2E0F7;">
         
          <div id="displayBarcode" style="width: 260px; height: 30px; line-height: 30px;  border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: white;background-color: #AFBDD1;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "BarCode")%>
                 
               <input type="hidden" class="hfbarcode1" name="hfbarcode1" value="<%# DataBinder.Eval(Container.DataItem, "BarCode")%>" />
               <input type="hidden" class="hfbarcode2" name="hfbarcode2" value="<%# DataBinder.Eval(Container.DataItem, "BarCode2")%>" />
               <input type="hidden" class="hfModel" name="hfModel" value="<%# DataBinder.Eval(Container.DataItem, "Model")%>" />
               
                <input type="hidden" class="hfdName" name="hfdName" value="<%# DataBinder.Eval(Container.DataItem, "DealerName")%>" />
               
            </div>

            <div style="width: 260px; height: 30px; line-height: 30px; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "BarCode2")%>
              
                
            </div>
            <div style="width: 260px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: white;background-color: #AFBDD1;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>
            <div id="d_name" style="width: 260px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerName")%>
               
            </div>
             <div id="hfDealerName1" style="width: 260px; height: 30px; line-height: 30px;  border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
              <div id="dealer_lists1" class="insert" style="width: 253px;border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; background-color: Silver;color: #000000;">
                   <%=DDLDealerName%>
                </div>
                
           
            </div>
             <div id="distri_date" style="width: 260px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               
            </div>

            <div id="display_Date_Div" style="width: 260px; height: 30px; line-height: 30px; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7">
                &nbsp;
               <input type="date" id="displayDate" placeholder="YYYY-MM-DD" required pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}"  style="width:256px;margin-top:-30px; height: 30px;border:1px solid gray;float:left;margin-right:3px" />
        
            </div>
       
           
             <%--<div id="display-check" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color: white;height:30px;width:260px;border-left: 1px solid #CCCCCC;border-right: 1px solid #CCCCCC;">

                  <label><input id="displaycheckTick" type='checkbox' onchange='handleChange(this);' style="margin-left: -210px;height: 20px;width:20px;"></label>                    
                
            </div>--%>
             <div id="IsAprv" class="left-bottom" style="width: 260px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;border-right: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC; text-align: left;color: white;background-color:  #AFBDD1;">
                 &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IsDisplayApprovedByNSM")%>
               
            </div> 
               
            <div style="width:260px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;">
                                           
               <div id="btn-display-IMEI-save" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:60px;float:left;margin-top:4px;">                
                    SAVE
                </div>
               
            </div>                  
        </div>
    </ItemTemplate>
</asp:Repeater>
