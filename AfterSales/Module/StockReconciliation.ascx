<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StockReconciliation.ascx.cs" Inherits="WSMS.Module.StockReconciliation" %>

<div class="table-scrollable table-responsive" id="rtpC">
<asp:Repeater runat="server" ID="rptrStockRecon2">
    <HeaderTemplate>
        <%--#F6F4E4--%>
      <div style="width: 800px;margin-top:20px;font-size:14px;color: white;font-weight: bold;"> 
        <div class="grid" style="width: 200px;height:30px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #CCCCCC">
            AddedDate
        </div> 
          
       
    </div>

    </HeaderTemplate>
    
    <ItemTemplate> 
  <table id="stock-reconListForSave2" style="width: 950px;  float: left;font-size:9px;display:block">
         <tr class="stock-recontrForSave2">
         <td id="add-date" style="width: 200px; height: 30px; line-height: 30px; float: left; border-left:1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: white;font-size:12px;font-weight: bold;border-right: 1px solid #CCCCCC">
              
                <%# DataBinder.Eval(Container.DataItem, "AddedDate","{0:yyyy-MM-dd}")%>
               
            </td>
          
          </tr>  
             
        </table>
    </ItemTemplate>   
</asp:Repeater>
</div>


<div class="table-scrollable table-responsive" id="rtpA">
<asp:Repeater runat="server" ID="rptrStockRecon">
    <HeaderTemplate>
        <%--#F6F4E4--%>
      <div style="width: 800px;margin-top:20px;font-size:14px;color: white;font-weight: bold;"> 
        <div class="grid" style="width: 140px;height:60px;color:#000000;background-color: #E6E6E6;">
            Model
        </div> 
          
        <div class="grid" style="width:90px;height:60px;color:#000000;background-color: #E6E6E6;;font-size:14px">
            In House Stock
        </div>
        <div class="grid" style="width: 90px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #CCCCCC">
             Market Stock
        </div>
       <%-- <br/>--%>
    </div>
   <%-- <br/> <br/> <br/>--%>
    </HeaderTemplate>
    
    <ItemTemplate> 
  <table id="stock-reconListForSave" style="width: 950px;  float: left;font-size:9px;display:block">
         <tr class="stock-recontrForSave">
         <td id="mobileModel2" style="width: 140px; height: 30px; line-height: 30px; float: left; border-left:1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: white;font-size:12px;font-weight: bold;">
              
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </td>
           <td id="forInhouse" style="width: 85px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7">
                &nbsp;
                 <input type="text" id="input-inHouse"  style="width: 75px;border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC; height: 25px; line-height: 23px;word-break: break-word;
                  margin-left: 1px; margin-top: 2px; color: #000000;font-size:14px" />
                
                
            </td>

            <td id="forMarkets" style="width: 85px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px; border-right: 1px solid #CCCCCC">
                &nbsp;
                <input type="text" id="input-marketStock" style="width: 75px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; color: #000000;font-size:14px;" />
           
                
            </td>
            
              </tr>  
             
        </table>
    </ItemTemplate>
    
</asp:Repeater>
</div>

<div class="table-scrollable table-responsive" id="rtpB">
<asp:Repeater runat="server" ID="rptrStockRecon1">
    <HeaderTemplate>
        <%--#F6F4E4--%>
      <div style="width: 800px;margin-top:20px;font-size:14px;color: white;font-weight: bold;"> 
        <div class="grid" style="width: 140px;height:60px;color:#000000;background-color: #E6E6E6;">
            Model
        </div> 
          
        <div class="grid" style="width:90px;height:60px;color:#000000;background-color: #E6E6E6;;font-size:14px">
            In House Stock
        </div>
        <div class="grid" style="width: 90px;height:60px;color:#000000;background-color: #E6E6E6;border-right: 1px solid #CCCCCC">
             Market Stock
        </div>
    </div>

    </HeaderTemplate>
    
    <ItemTemplate> 
  <table id="stock-reconListForSave1" style="width: 950px;  float: left;font-size:9px;display:block">
         <tr class="stock-recontrForSave1">
         <td id="mobileModel3" style="width: 140px; height: 30px; line-height: 30px; float: left; border-left:1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: white;font-size:12px;font-weight: bold;">
              
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </td>
           <td id="forInhouse1" style="width: 85px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7">
                &nbsp;
                  <input type="text" id="input-inHouse1" value="<%# DataBinder.Eval(Container.DataItem, "InHouseStock")%>"  style="width: 75px;border-top: 1px solid #CCCCCC;border-bottom: 1px solid #CCCCCC; height: 25px; line-height: 23px;word-break: break-word;
                  margin-left: 1px; margin-top: 2px; color: #000000;font-size:14px;" />

             
                
                
            </td>

            <td id="forMarkets1" style="width: 85px; height: 30px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px; border-right: 1px solid #CCCCCC">
                &nbsp;
                  <input type="text" value="<%# DataBinder.Eval(Container.DataItem, "MarketStock")%>"  id="input-marketStock1" style="width: 75px; height: 25px; line-height: 23px;word-break: break-word;
                        margin-left: 1px; margin-top: 2px; color: #000000;font-size:14px;" />
                
            </td>
            
              </tr>  
             
        </table>
    </ItemTemplate>
    
</asp:Repeater>
</div>