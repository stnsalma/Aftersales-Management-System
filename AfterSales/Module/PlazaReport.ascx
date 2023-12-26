<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PlazaReport.ascx.cs" Inherits="WSMS.Module.PlazaReport" %>

<asp:Repeater runat="server" ID="rptrServicePending">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div style="width: 1900px;margin-top:20px;font-size:9px;"> 
         <div class="grid" style="width: 40px;height:60px;color:#000000;background-color: #E6E6E6;">
            Request ID
        </div> 
          
        <div class="grid" style="width:80px;height:60px;color:#000000;background-color: #E6E6E6;">
            IMEI_1
        </div>
        <div class="grid" style="width: 80px;height:60px;color:#000000;background-color: #E6E6E6;">
             IMEI_2
        </div>
        <div class="grid" style="width: 63px;height:60px;color:#000000;background-color: #E6E6E6;">
             Model
        </div>
        <div class="grid" style="width: 32px;height:60px;color:#000000;background-color: #E6E6E6;">
             Party Code
        </div>
        <div class="grid" style="width: 53px;height:60px;color:#000000;background-color: #E6E6E6;">
             Activation Date
        </div>
        <div class="grid" style="width: 54px;height:60px;color:#000000;background-color: #E6E6E6;">
             Distribution Date
        </div>
        <div class="grid" style="width: 70px;height:60px;color:#000000;background-color: #E6E6E6;">
              Request Type
        </div>
        <div class="grid" style="width: 52px;height:60px;color:#000000;background-color: #E6E6E6;">
              Issues
        </div>
         <div class="grid" style="width: 70px;height:60px;color:#000000;background-color: #E6E6E6;">
              App.Decline Reason
        </div>
        <div class="grid" style="width: 92px;border-right: 1px solid #CCCCCC;height:60px;color:#000000;background-color: #E6E6E6; ">
             Status
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>
   <%-- border:1px solid #CCCCCC ;--%>

        <div  style="width: 1161px;  float: left; font-size:;font-size:9px;display:block">
         
         <div style="width: 40px; height: 90px; line-height: 30px; float: left; border-left:1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: center;color: #000000;background-color: #F2E0F7;font-size:9px">
              
                <%# DataBinder.Eval(Container.DataItem, "RequestID")%>
               
            </div>
           <div style="width: 80px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_1")%>
              
                
            </div>

            <div style="width: 80px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IMEI_2")%>
              
                
            </div>
            <div style="width: 63px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Model")%>
               
            </div>
            <div style="width: 32px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DealerCode")%>
               
            </div>
            <div style="width: 53px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RegistrationDate", "{0:yyyy-MM-dd}")%>
               
            </div>
              <div style="width: 54px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "DistributionDate", "{0:yyyy-MM-dd}")%>
               
            </div>
             <div style="width: 70px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "RequestType")%>
               
            </div>
              <div style="width: 52px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "Issues")%>
               
            </div>
            <div style="width: 70px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC;  text-align: left;color: #000000;background-color: #F2E0F7;;font-size:9px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "AppDeclinedRemarks")%>
               
            </div>
            <div style="width:92px; height: 90px; line-height: 30px; float: left; border-left: 1px solid #CCCCCC;
                border-bottom: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; text-align: center;vertical-align:middle;color: #000000;background-color: #F2E0F7;font-size:9px">
                                           
                <%# DataBinder.Eval(Container.DataItem, "RequestStatus")%>
            </div>

           
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>

<%--<div id="doexcelpage">

<input type="button" onclick="window.open('data:application/vnd.ms-excel,'+$('[id$=divTableDataHolder]').html());" value="bbbb" />
           

</div>--%>
<%--
<input type="button" id="btnExport" value=" Export Table data into Excel " />
<script type="text/javascript">
//    $(function () {
//        $('#bd').click(function () {
//            var url = 'data:application/vnd.ms-excel,' + encodeURIComponent($('#rptrServicePending').html());
//            location.href = url;
//            return false;
//        })
    //    })

$("#btnExport").click(function(e) {
    window.open('data:application/vnd.ms-excel,' + $('#rptrServicePending').html());
    e.preventDefault();
});​

  
</script>
--%>