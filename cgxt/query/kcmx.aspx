<%@ Page Language="C#" AutoEventWireup="true" CodeFile="kcmx.aspx.cs" Inherits="kcmx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <div>会计年月<asp:DropDownList ID="ddlKjny" runat="server" DataSourceID="SqlDataSource1" DataTextField="VwXm0007" DataValueField="VwXm0007">
       </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatebaseConnection %>"
           SelectCommand="select VwXm0007 from View_0332 where View_0332.VwXm0005='是' or VwXm0006='是' order by VwXm0003 desc ;">
       </asp:SqlDataSource></div>
        <asp:Button ID="btnExcel" runat="server" Text="导出Excel" OnClick="btnExcel_Click" />
       
    </div>
    </form>
   
</body>
</html>
