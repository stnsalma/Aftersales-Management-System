<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayIMEIListApprovedByNSM.ascx.cs" Inherits="WSMS.Module.DisplayIMEIListApprovedByNSM" %>

<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 1970px;margin-top:20px;font-size:small"> 
        
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
            DisPro_ID
        </div>    
        <div class="grid" style="width: 130px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
            IMEI_1
        </div>
        <div class="grid" style="width: 130px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             IMEI_2
        </div>
        <div class="grid" style="width: 160px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Model
        </div>
         <div class="grid" style="width: 90px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             DealerCode
        </div>
       
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             Display Date
        </div>
         <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #FFFFFF;">
             TSO AddedDate
        </div>
        <div class="grid" style="width: 130px;border-right: 1px solid #CCCCCC;height:60px;color:#000000;background-color: #E6E6E6;">
             Action
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div  style="width:895px;  float: left; border:1px solid #CCCCCC ;display:block">  

         <div id="dis-approvId" style="width: 80px; line-height: 30px; float: left; border-left: 0px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;height:30px;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
              
                <%# DataBinder.Eval(Container.DataItem, "DisplayProductID")%>
               
                <input type="hidden" class="hfDisID" name="hfDisID" value="<%# DataBinder.Eval(Container.DataItem, "DisplayProductID")%>" />
              

            </div>
           <div style="width: 130px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
              
                
            </div>
        

            <div style="width: 130px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
              
                
            </div>
            <div style="width: 160px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>
             <div style="width: 90px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerCode")%>
               
            </div>
           
          <div style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DisplayDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             <div style="width: 80px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: center;color: #000000;background-color: #F2E0F7;border-right: 1px solid #FFFFFF;">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "AddedDate", "{0:yyyy-MM-dd}")%>
               
            </div>
          
            
            <div style="width:130px;line-height: 30px;height:30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;">
                                           
               <div id="btn-dis-Approv" style="border:1px solid #83AF45;width:100px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;float:left;margin-left:10px;margin-top:2px;">
                  
                    Approved
                </div>
               
            </div>
           
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>
