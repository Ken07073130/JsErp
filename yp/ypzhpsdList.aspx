﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ypzhpsdList.aspx.cs" Inherits="ypzhpsdList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <title>样品建议书列表</title>
 <style type="text/css">
   .hidden {
     display:none; 
   }
 </style>
 <script src="../jquery-ui/jquery-1.10.2.js" type="text/javascript"></script>
 <script src="../js/layer.js" type="text/javascript"></script>
 <script type="text/javascript" >
     //第一次加载特别慢，因此需要有加载提示，放在body onload(页面加载完毕)执行
     function firstClick() {
         if (document.getElementById("GridView1") == null) {
             document.getElementById("lbQuery").click();
             //document.getElementById("cblTitleList").onchange();
         }
     }

     function queryClick() {
         layer.msg('数据加载中，请稍后', {
             offset: 200,
             time: 10000
         });
     }
 </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style=" font-size:12px;">
    <ajaxToolkit:CalendarExtender id="CalendarExtender1" runat="server" TargetControlID="tbQsrq" Format="yyyy-MM-dd"></ajaxToolkit:CalendarExtender>
    <ajaxToolkit:CalendarExtender id="CalendarExtender2" runat="server" TargetControlID="tbJsrq" Format="yyyy-MM-dd"></ajaxToolkit:CalendarExtender>
    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="tbYwy" ServicePath="~/GetContent.asmx" ServiceMethod="GetUserNameList" MinimumPrefixLength="1"  EnableCaching="true" CompletionInterval="200" />
   <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tbKhdm" ServicePath="~/GetContent.asmx" ServiceMethod="GetKhdmList" MinimumPrefixLength="1"  EnableCaching="true" CompletionInterval="200" />
   <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="tbKhdmGl" ServicePath="~/GetContent.asmx" ServiceMethod="GetKhdmList" MinimumPrefixLength="1"  EnableCaching="true" CompletionInterval="200" />
 
   
    <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
         </ajaxToolkit:ToolkitScriptManager>
         <table ><tr>
             <td>
                 单据<asp:DropDownList ID="ddlDjlx" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDjlx_SelectedIndexChanged">
                     <asp:ListItem>全部</asp:ListItem>
                     <asp:ListItem>样品建议书</asp:ListItem>
                     <asp:ListItem>产品开发提案</asp:ListItem>
                     <asp:ListItem>规格书申请单</asp:ListItem>
                 </asp:DropDownList>
             
                   &nbsp;
                  会签状态<asp:DropDownList ID="ddlHqzt" runat="server" OnSelectedIndexChanged="btnCX_Click" AutoPostBack="True" >
                     <asp:ListItem Selected="True">会签中</asp:ListItem>
                     <asp:ListItem>全部</asp:ListItem>
                     <asp:ListItem>已会签</asp:ListItem>                 
                 </asp:DropDownList>&nbsp; 客户代码<asp:TextBox ID="tbKhdmGl" runat="server" Height="15px"
                      Width="84px" AutoPostBack="True" OnTextChanged="ddlDjlx_SelectedIndexChanged"></asp:TextBox>&nbsp; 业务员<asp:DropDownList ID="ddlYwy" runat="server" OnSelectedIndexChanged="ddlDjlx_SelectedIndexChanged" AutoPostBack="True" >
                          <asp:ListItem Selected="True">会签中</asp:ListItem>
                          <asp:ListItem>全部</asp:ListItem>
                          <asp:ListItem>已会签</asp:ListItem>
                      </asp:DropDownList>
                 <label style="background-color:#FFCCCC;width:50px;display:inline-block;">&nbsp</label> 
                 <label>已完成</label>
                 <label style="background-color:#FF0033;width:50px;display:inline-block;">&nbsp</label> 
                 <label>退回的单据</label>  
                 <a href="ywydyList.aspx" target="_blank" runat="server" id="aYwyLink">业务员与技术部人员关系维护</a>
                 
             </td>             
             </tr></table>
             <div id="divXh" runat="server" style="background-color:#99CCFF;">
                 厚度(mm)<asp:TextBox ID="tbHd" runat="server" 
                     Width="48px" ></asp:TextBox>
                 宽度(mm)<asp:TextBox ID="tbKd" runat="server"
                     Width="48px"></asp:TextBox>
                 &nbsp;高度(mm)<asp:TextBox ID="tbGd" runat="server" 
                     Width="48px"></asp:TextBox>
                 &nbsp;<asp:Button ID="btnXhcx" runat="server" Text="型号查询" OnClick="btnXhcx_Click" />
                 &nbsp; （&nbsp; 厚度范围(mm)
                 <asp:TextBox ID="tbHdwc" runat="server" Text="0.5" Width="48px"></asp:TextBox>
                 &nbsp; 宽度范围(mm)<asp:TextBox ID="tbKdwc" runat="server"
                     Width="54px" Text="5" ></asp:TextBox>
                 &nbsp; 高度范围(mm)<asp:TextBox ID="tbGdwc" runat="server"
                     Width="45px" Text="5"></asp:TextBox>&nbsp; ）</div>
             
             <div style="background-color:#CCCCCC">
                 起始日期<asp:TextBox ID="tbQsrq" runat="server" Width="89px" Height="15px"></asp:TextBox>结束日期<asp:TextBox ID="tbJsrq"
                     runat="server" Width="102px" Height="15px"></asp:TextBox>客户代码<asp:TextBox ID="tbKhdm" runat="server" Width="104px" Height="15px"></asp:TextBox>业务员<asp:TextBox
                         ID="tbYwy" runat="server" Width="102px" Height="15px"></asp:TextBox>
                 <asp:Button ID="btnExcel" runat="server" Text="查询并导出EXCEL" OnClick="btnExcel_Click"   />
                <div style="display:none;"> <asp:Button ID="lbQuery" runat="server" Text="查询" OnClick="lbQuery_Click"  OnClientClick="queryClick()" /></div>
        </div>
         <table align="Center" border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td style="height: 30px">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                         <tr >
                             <td width="6%" align="center" 
                                 style="height: 23px;font-size:15px;font-weight:bold;">
                 <asp:LinkButton ID="tjbd" runat="server" OnClick="tjbd_Click" style="background-color:#FEEDC9;display: block ;text-align: center;color: #d84700;  font-size: 14px; font-weight: bold; text-decoration: none; " Width="120px">添加单据</asp:LinkButton>
                         
                             <td width="94%" align="center" 
                                 style="height: 23px;font-size:15px;font-weight:bold;">样品综合评审                         <tr >                                     </tr>
                     </table>
                 </td>
             </tr>
             <tr>
                 <td>
                     <table border="0" cellpadding="0" cellspacing="0" class="STYLE10" width="100%">
                         <tr valign="top">
                             <td style="height: 199px">
                                 <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
                                     Font-Names="Verdana" Font-Size="12px" OnRowDataBound="GridView1_RowDataBound"
                                     OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing"  
                                     emptydatatext="无记录"  
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"   AllowPaging="True" AllowSorting="True" PageSize="50"  OnPageIndexChanging ="GridView1_PageIndexChanging" EmptyDataRowStyle-BackColor="#40e0d0">
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                         <asp:BoundField DataField="bh" HeaderText="编号" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:CommandField HeaderText="修改" ShowEditButton="True">
                                             <ItemStyle Width="3%" />
                                         </asp:CommandField>
                                         
                                          <asp:BoundField DataField="djlx" HeaderText="单据类型">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="jbrq" HeaderText="建表日期">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                           <asp:BoundField DataField="ypjys" HeaderText="样品数量">
                                         <ItemStyle Width="6%" />
                                         </asp:BoundField>
                                           <asp:BoundField DataField="ggsxq" HeaderText="规格书需求">
                                             <ItemStyle Width="3%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="lchqzt" HeaderText="当前会签状态" >
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="khdm" HeaderText="客户代码" >
                                             <ItemStyle Width="5%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="XSRY" HeaderText="发起人" >
                                             <ItemStyle Width="5%"  />
                                         </asp:BoundField>
                                          <asp:BoundField DataField="nbxh" HeaderText="内部型号" >
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                          <asp:BoundField DataField="khxh" HeaderText="客户型号" >
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                       <asp:BoundField DataField="zzqk" HeaderText="制作情况" >
                                             <ItemStyle Width="3%" />
                                         </asp:BoundField>
                                         
                                        <asp:HyperLinkField 
                                            DataNavigateUrlFields="bh" 
                                            DataNavigateUrlFormatString="ypzhpsdEdit.aspx?xh={0}&lb=COPY&editType=会签中"
                                            Text="复制单据"  
                                            ItemStyle-Width="3%" />
                                       
                                        <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                                             <ItemStyle Width="3%" />
                                         </asp:CommandField>
                                         <asp:BoundField DataField="SWJLHQZT" Visible="false" >
                                            <ControlStyle CssClass="hidden" />
                                            <FooterStyle CssClass="hidden" />
                                            <HeaderStyle CssClass="hidden" />
                                            <ItemStyle CssClass="hidden" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="aszz" HeaderText="按时制作" >
                                             <ItemStyle Width="3%" />
                                         </asp:BoundField>
                                          <asp:BoundField DataField="tdcs" HeaderText="退单次数" >
                                             <ItemStyle Width="3%" />
                                         </asp:BoundField>
                                          <asp:BoundField DataField="swyjjq" HeaderText="实验室评审交期" >
                                             <ItemStyle Width="3%" />
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
                                     <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                                     <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                                     <HeaderStyle BackColor="#479AC7" Font-Bold="True" ForeColor="White" />
                                     <EmptyDataRowStyle BackColor="Turquoise" />
                                 </asp:GridView>
                             </td>
                         </tr>
                     </table>
                 </td>
             </tr>
             <tr>
                 <td height="30">
               
                 </td>
             </tr>
         </table>
    </div>
    <script type="text/javascript">firstClick()</script>
    </form>
</body>
</html>
