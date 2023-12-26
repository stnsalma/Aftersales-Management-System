<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WSMS.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <%--<link href="Styles/glDatePicker.default.css" rel="stylesheet" type="text/css" />--%>
    <link href="Styles/jquery.datepick.css" rel="stylesheet" type="text/css" />

    <script src="Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery.ui.core.js" type="text/javascript"></script>
    <script src="Scripts/jquery.ui.widget.js" type="text/javascript"></script>
    <%--<script src="Scripts/glDatePicker.js" type="text/javascript"></script>--%>
    <script src="Scripts/jquery.plugin.js" type="text/javascript"></script>
    <script src="Scripts/jquery.datepick.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(function () {
                $('#date').datepick();
            });
        });
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <input type="text" id="date"  size="10"/>
    <asp:Button runat="server" ID="btn"/>
    <textarea id="issue-comment" rows="3"  style="width: 194px;  float: left;margin-left:1px;margin-top:2px;background-color:Silver;resize:none;"></textarea>
</asp:Content>
