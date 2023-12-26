<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DayWiseDealerSalesEntryFromTSO.ascx.cs" Inherits="WSMS.Module.DayWiseDealerSalesEntryFromTSO" %>

<div class="table-responsive" id="rtpForDayWiseSalesC">
<asp:Repeater runat="server" ID="rptDayWiseC">
    <HeaderTemplate>
        <%--#F6F4E4--%>
      <div style="width: 400px;margin-top:20px;font-size:14px;color: white;font-weight: bold;"> 
      
           
        <div class="grid" style="width: 150px;height:30px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #CCCCCC">
             AddedDate
        </div>
       
    </div>
  
    </HeaderTemplate>
    
    <ItemTemplate> 
    
  <table id="dayWise-ListForSaveC" style="width: 400px;  float: left;font-size:9px;display:block">
         <tr class="dayWise_tr_forSaveC">
           <td id="add-date" style="width: 150px; height: 30px; line-height: 30px; float: left; border-left:1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: white;font-size:12px;font-weight: bold;border-right: 1px solid #CCCCCC;">
              
                <%# DataBinder.Eval(Container.DataItem, "AddedDate","{0:yyyy-MM-dd}")%>
               
           </td>
         
            
            
         </tr>  
             
        </table>
    </ItemTemplate>
    
</asp:Repeater>


</div>



<div class="table-scrollable table-responsive" id="rtpForDayWiseSalesA">
<asp:Repeater runat="server" ID="rptDayWise1">
    <HeaderTemplate>
        <%--#F6F4E4--%>
      <div style="width: 400px;margin-top:20px;font-size:14px;color: white;font-weight: bold;"> 
        <div class="grid" style="width: 140px;height:60px;color:#000000;background-color: #E6E6E6;">
            Model
        </div> 
           
        <div class="grid" style="width: 90px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #CCCCCC">
             Quantity
        </div>
      <%-- <br/><br/>--%>
    </div>
  
    </HeaderTemplate>
    
    <ItemTemplate> 
    
  <table id="dayWise-ListForSave1" style="width: 400px;  float: left;font-size:9px;display:block">
         <tr class="dayWise_tr_forSave1">
         <td id="mobileModel2" style="width: 140px; height: 30px; line-height: 30px; float: left; border-left:1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: white;font-size:12px;font-weight: bold;">
              
                <%# DataBinder.Eval(Container.DataItem, "Model1")%>
               
            </td>
         
            <td id="forQuantity" style="width: 90px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px; border-right: 1px solid #CCCCCC">
                &nbsp;
                <input type="text" id="input-Quantity" style="width: 75px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; color: #000000;font-size:14px;" />
           
                
            </td>
            
              </tr>  
             
        </table>
    </ItemTemplate>
    
</asp:Repeater>

</div>

<div class="table-scrollable table-responsive" id="rtpForDayWiseSalesB">
<asp:Repeater runat="server" ID="rptDayWise">
    <HeaderTemplate>
        <%--#F6F4E4--%>
      <div style="width: 400px;margin-top:20px;font-size:14px;color: white;font-weight: bold;"> 
        <div class="grid" style="width: 140px;height:60px;color:#000000;background-color: #E6E6E6;">
            Model
        </div> 
           
        <div class="grid" style="width: 90px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #CCCCCC">
             Quantity
        </div>
    <%--   <br/><br/>--%>
    </div>
  
    </HeaderTemplate>
    
    <ItemTemplate> 
    
  <table id="dayWise-ListForSave" style="width: 400px;  float: left;font-size:9px;display:block">
         <tr class="dayWise_tr_forSave">
           <td id="mobileModel3" style="width: 140px; height: 30px; line-height: 30px; float: left; border-left:1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: white;font-size:12px;font-weight: bold;">
              
                <%# DataBinder.Eval(Container.DataItem, "Model1")%>
               
           </td>
         
            <td id="forQuantity1" style="width: 90px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px; border-right: 1px solid #CCCCCC">
                &nbsp;
                <input type="text" value="<%# DataBinder.Eval(Container.DataItem, "Quantity")%>" id="input-Quantity1" style="width: 75px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; color: #000000;font-size:14px;" />
           
                
            </td>
            
         </tr>  
             
        </table>
    </ItemTemplate>
    
</asp:Repeater>


</div>

