<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DealerHistoryIntoPlazaAndRSM.ascx.cs" Inherits="WSMS.Module.DealerHistoryIntoPlazaAndRSM" %>


<%--<asp:Repeater runat="server" ID="rptrServicePending1">
    <HeaderTemplate>--%>
      
      <div style="width: 300px;margin-top:20px;font-size:small">     
       
        
        <div class="grid" style="width:200px;bottom:0;color:#000000;background-color: #E6E6E6;">
             Organization Name 
        </div>
       
         <div class="grid" style="width:200px;bottom:0;color:#000000;background-color: #E6E6E6;">
            RSM/Monitor Name
        </div>
        <div class="grid" style="width: 200px;border-right: 1px solid #CCCCCC;bottom:0;color:#000000;background-color: #E6E6E6;">
            Action
        </div>
    </div>
    <%--</HeaderTemplate>
    <ItemTemplate>--%>
        <div  style="width: 300px;  float: left;height:97px; border:1px solid #CCCCCC ;display:block;margin-top:-67px;background-color: white;">
              
             <div id="ddName1" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color:white;width: 300px">
                 <div id="item-list-code" class="insert" style="color: #000000;background-color:white;width: 300px">
                   <%=DDLDealerName%>
                </div>
                  
            </div>
           <div id="ddRsmName" class="left-bottom" style="border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC;color: #000000;background-color:white;width: 300px">
                 <div id="item-list-Rsm" class="insert" style="color: #000000;background-color:white;width: 300px">
                   <%=DDLRSMName%>
                </div>
                  
            </div>
            <div style="width:302px; height: 30px; line-height: 30px;  border-left: 1px solid #CCCCCC;border-top: 1px solid #CCCCCC;
          border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color:white;">
                                           
               <div id="btn-save-plazaAndRsm-record" style="border:1px solid #83AF45;width:80px;height:20px;line-height:20px;text-align:center;
                    font-weight:bold;font-style:italic;cursor:pointer;margin-left:90px;float:left;margin-top:4px;">                
                    SAVE
                </div>
               
            </div>                  
        </div>
    <%--</ItemTemplate>
</asp:Repeater>--%>
