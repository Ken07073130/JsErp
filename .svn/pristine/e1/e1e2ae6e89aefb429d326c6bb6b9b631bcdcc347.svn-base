<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jxkh_khjg.aspx.cs" Inherits="jxkh_pz" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

<link rel="stylesheet" href="../jquery-ui/themes/base/jquery.ui.all.css">
<script src="../jquery-ui/jquery-1.10.2.js"></script>
<script src="../jquery-ui/ui/jquery.ui.core.js"></script>
<script src="../jquery-ui/ui/jquery.ui.widget.js"></script>
<script src="../jquery-ui/ui/jquery.ui.mouse.js"></script>
<script src="../jquery-ui/ui/jquery.ui.button.js"></script>
<script src="../jquery-ui/ui/jquery.ui.draggable.js"></script>
<script src="../jquery-ui/ui/jquery.ui.position.js"></script>
<script src="../jquery-ui/ui/jquery.ui.resizable.js"></script>
<script src="../jquery-ui/ui/jquery.ui.button.js"></script>
<script src="../jquery-ui/ui/jquery.ui.dialog.js"></script>
<script src="../jquery-ui/ui/jquery.ui.effect.js"></script>
<link rel="stylesheet" href="../jquery-ui/demos.css">

<style type="text/css">
/* CSS Document */
body {
    font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    color: #4f6b72;
    background: #E6EAE9;
}
a {
    color: #c75f3e;
}
.mytable {
    padding: 0;
    margin: 0;
}
caption {
    padding: 0 0 5px 0;
    width: 700px; 
    font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    text-align: right;
}
th {
    font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    color: #4f6b72;
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    border-top: 1px solid #C1DAD7;
    letter-spacing: 2px;
    text-transform: uppercase;
    text-align: center;

    background: #CAE8EA;
}
th.nobg {
    border-top: 0;
    border-left: 0;
    border-right: 1px solid #C1DAD7;
    background: none;
}
td {
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    border-top: 1px solid #C1DAD7;
    /*background: #fff;*/
    font-size:11px;
    text-align: center;
    color: #4f6b72;
}

.hover{
    cursor:pointer;
    background-color:#bcd4ec;  
   
}   /*这里是鼠标经过时的颜色*/ 
</style>
    <title>绩效考核成绩</title>
</head>

<body style="text-align: center" >
<script type ="text/javascript"  >
 
</script>
    <form id="form1" runat="server">
        &nbsp; &nbsp;&nbsp;
        <br />

    <div id ="tablename" runat="server" >
    
<table width="830" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
        <th  colspan ="10" style=" height: auto"> <h1  style=" margin-top:10px">
            绩效考核各部门得分</h1></th>
    </tr>
     <tr>
        <th  colspan ="10" style=" height: auto"><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" style="text-align: center" EmptyDataText="无记录"
                                     Font-Names="Verdana" Font-Size="12px" AllowSorting="True"   OnRowDataBound="GridView1_RowDataBound" ShowFooter="true"
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"  AllowPaging="true" PageSize="100"  OnPageIndexChanging ="GridView1_PageIndexChanging"  >
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                         <asp:BoundField DataField="kjny" HeaderText="会计年月">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="khxm" HeaderText="考核项目">
                                             <ItemStyle Width="12%" />
                                         </asp:BoundField>
                                        <asp:BoundField DataField="khfw" HeaderText="指标级别">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="sbb" HeaderText="设备部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="gcb" HeaderText="工程部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="zlb" HeaderText="质量部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="gyl" HeaderText="供应链">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="jsb" HeaderText="技术部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="zzb" HeaderText="制造部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="swb" HeaderText="商务部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="cwb" HeaderText="财务部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="xzb" HeaderText="行政部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>
                                        <asp:BoundField DataField="wab" HeaderText="网安部">
                                             <ItemStyle Width="7%" />
                                         </asp:BoundField>

                                     </Columns>
                                      <PagerTemplate>
                                           <table style="font-size :12px;">
                                           <tr>
                                        
                                             <td> 总共<asp:Label ID="Label1" runat="server" Text="<%#((GridView)Container.NamingContainer).PageCount %>"></asp:Label>页 &nbsp; </td>
                                            
                                                <td> 第<asp:Label ID="Label2" runat="server" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"></asp:Label>页 &nbsp;</td>
                                             
                                                      <td> <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument ="1" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">首页</asp:LinkButton> &nbsp;</td>
                                                      <td>
                                                          <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument ="Prev" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">上一页</asp:LinkButton> &nbsp;</td>
                                                          <td>
                                                              <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument ="Next" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">下一页 </asp:LinkButton> &nbsp;</td>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton4" runat="server" CommandArgument ="Last" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">尾页</asp:LinkButton> &nbsp;</td>
                                                            <td>
                                                                <asp:LinkButton ID="LinkButton5" runat="server" CommandArgument ="-1" CommandName ="Page" ValidationGroup="1" >GO</asp:LinkButton> </td>
                                                                <td>
                                                        <asp:TextBox ID="txtNum" runat="server" Width="30px" Text ="<%#((GridView)Container.NamingContainer).PageIndex+1 %>" ValidationGroup="1"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="" ValidationExpression ="^/d+$" ControlToValidate ="txtNum" ValidationGroup="1"></asp:RegularExpressionValidator>
                                               </td>
                                           </tr>
                                           </table>
                                        </PagerTemplate>
                                     <FooterStyle BackColor="White" ForeColor="#333333" />
                                     <PagerStyle BackColor="#479AC7" ForeColor="White" HorizontalAlign="Center" />
                                     <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                                     <HeaderStyle BackColor="#479AC7" Font-Bold="True" ForeColor="White" />
                                 </asp:GridView>
                                 
                                   </th>
    </tr>
</table>
    
         
 </div>

<div id="dialog-form" title="物料信息">
    &nbsp;</div>
        &nbsp; &nbsp; &nbsp;&nbsp;
        <input id="Button2" type="button" value="返回列表" style="width:80px" onclick="window.location.href('jxkh_khjg_lb.aspx');" />
        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:HiddenField ID="HF_kjny" runat="server" />
 </form>

<input type="hidden" name="prevTrIndex" id="prevTrIndex" value="-1" /> 
<script type ="text/javascript"  >
    gzchange($("#DDL_khgz").val());
    showta();
</script>

   
</body>
</html>
