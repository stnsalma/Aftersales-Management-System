<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PrintFaultySpareParts.ascx.cs" Inherits="WSMS.Module.PrintFaultySpareParts" %>

<asp:Repeater runat="server" ID="rptrfaultyspare">
        <HeaderTemplate>
            <div id="faulty-header" style="width: 100%; float: left;">
                <div class="left-bottom" style="width: 200px;color:black;background-color: #A4A820;float: left;font-weight:bold;font-size:13px;">
                    FaultySpareCode
                </div>
                <div class="left-bottom" style="width: 200px;color:black;background-color: #A4A820;float: left;font-weight:bold;font-size:13px">
                    Faulty Spare Name
                </div>
                
                <div class="left-bottom" style="width: 100px;border-right: 1px solid #CCCCCC;color:black;background-color: #A4A820;float: left;font-weight:bold;font-size:13px">
                    Spare Price
                </div>
                
            </div>
        </HeaderTemplate>
        <ItemTemplate>
            <div id="<%# DataBinder.Eval(Container.DataItem, "FaultySparePartsDetailsID")%>" class="faulty-item" style="width:100%;float:left;">
                <div id="faulty-id" class="left-bottom" style="width:200px;float: left;">
                    <%# DataBinder.Eval(Container.DataItem, "FaultySpareCode")%>
                </div>
                <div class="left-bottom" style="width:200px;float: left;">
                    <%# DataBinder.Eval(Container.DataItem, "FaultySpareName")%>
                </div>
                
                <div id="fprice" class="left-bottom" style="width:100px;border-right: 1px solid #CCCCCC;float: left;"  >
                    <%# DataBinder.Eval(Container.DataItem, "SparePrice")%>
                </div>

            </div>
        </ItemTemplate>
    </asp:Repeater>