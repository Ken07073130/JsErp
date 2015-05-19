<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cgdPrint.aspx.cs" Inherits="cgdPrint" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>



<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>采购单打印</title>
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
       <div style="width:800px; margin:0 auto; text-align:center; background-color:#FFFFCC;border:1px solid;">选择收货工厂 <asp:DropDownList ID="ddlGc" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlGc_SelectedIndexChanged">
        </asp:DropDownList></div>
    
    <div>
        <cr:crystalreportviewer id="CrystalReportViewer1" runat="server" autodatabind="true"></cr:crystalreportviewer>
    
    </div>
    </form>
</body>
</html>
