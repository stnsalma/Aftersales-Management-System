<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplacementSubModuleMonitoring.ascx.cs" Inherits="WSMS.Module.ReplacementSubModuleMonitoring" %>


<asp:Repeater runat="server" ID="rptrReplacementReport">
    <HeaderTemplate>
        <%--#F6F4E4--%>
        <div id="issue-header" style="width: 1050px;">         
         
        <div class="grid" style="width: 120px;color:#FFFFFF;background-color: #4F81BB;border-right: 1px solid #FFFFFF;">
            ReplaceIMEI_1
        </div>
        <div class="grid" style="width: 120px;color:#FFFFFF;background-color: #4F81BB;border-right: 1px solid #FFFFFF;">
             ReplaceIMEI_2
        </div>
        <div class="grid" style="width: 180px;color:#FFFFFF;background-color: #4F81BB;border-right: 1px solid #FFFFFF;">
             ReplaceModel
        </div>
        
        <div class="grid" style="width: 110px;color:#FFFFFF;background-color: #4F81BB;border-right: 1px solid #FFFFFF;">
             Seen Physically?
        </div>

        <div class="grid" style="width: 500px;border-right: 1px solid #CCCCCC;color:#FFFFFF;background-color: #4F81BB;">
             Remarks
        </div>
    </div>
    </HeaderTemplate>
    <ItemTemplate>


        <div style="width: 1050px;  float: left;">
         

           <div class="left-bottom" style="width: 120px;color: #000000;background-color: #D8CEF6;border-right: 1px solid #FFFFFF;height:60px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ReplaceIMEI_1")%>
              
                
            </div>
        

            <div class="left-bottom" style="width: 120px;color: #000000;background-color: #D8CEF6;border-right: 1px solid #FFFFFF;height:60px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ReplaceIMEI_2")%>
              
                
            </div>
            <div class="left-bottom" style="width: 180px;color: #000000;background-color: #D8CEF6;border-right: 1px solid #FFFFFF;height:60px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "ReplaceModel")%>
               
            </div>

            <div class="left-bottom" style="width: 110px;color: #000000;background-color: #D8CEF6;border-right: 1px solid #FFFFFF;height:60px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IsSeen")%>
               
            </div>
            
         
              <div class="left-bottom" style="width: 500px;border-right: 1px solid #CCCCCC;color: #000000;background-color: #D8CEF6;height:60px">
                &nbsp;
                <%# DataBinder.Eval(Container.DataItem, "IssueDetails")%>
               
            </div>
   
             
        </div>
    </ItemTemplate>
    
</asp:Repeater>
