<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TabControl.ascx.cs" Inherits="WSMS.Module.TabControl" %>
<div id="tab-left-content">    
    <asp:Repeater ID="rptrTab" runat="server">
        <ItemTemplate>           
            <div class="tab tab-item" display="Value"> My Receive
                <%--<input type="hidden" name="hfTabID" id="hfTabID" value='<%#(DataBinder.Eval(Container.DataItem, "TabId"))%>' />                  
                <input type="hidden" name="hfTabFolderID" id="hfTabFolderID" value="<%#GetFolderByTabID(DataBinder.Eval(Container.DataItem, "TabId"))%>" />--%>
            </div>
            <div class="tab tab-item" display="Value"> Pending Receive
                <%--<input type="hidden" name="hfTabID" id="hfTabID" value='<%#(DataBinder.Eval(Container.DataItem, "TabId"))%>' />                  
                <input type="hidden" name="hfTabFolderID" id="hfTabFolderID" value="<%#GetFolderByTabID(DataBinder.Eval(Container.DataItem, "TabId"))%>" />--%>
            </div> 
            <div class="tab tab-item" display="Value"> Other's Receive
                <%--<input type="hidden" name="hfTabID" id="hfTabID" value='<%#(DataBinder.Eval(Container.DataItem, "TabId"))%>' />                  
                <input type="hidden" name="hfTabFolderID" id="hfTabFolderID" value="<%#GetFolderByTabID(DataBinder.Eval(Container.DataItem, "TabId"))%>" />--%>
            </div>  
                       
       </ItemTemplate>  
            
    </asp:Repeater>
</div>