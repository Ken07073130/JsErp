<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cpkftaList.aspx.cs" Inherits="cpkftaList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>产品开发提案列表</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="font-size:12px;">
      <table ><tr>
             <td>
             
                   &nbsp;
                  会签状态<asp:DropDownList ID="ddlHqzt" runat="server" OnSelectedIndexChanged="btnCX_Click" AutoPostBack="True" >
                     <asp:ListItem Selected="True">会签中</asp:ListItem>
                     <asp:ListItem>全部</asp:ListItem>
                     <asp:ListItem>已会签</asp:ListItem>                 
                 </asp:DropDownList> 
                 <label style="background-color:#FFCCCC;width:50px;display:inline-block;">&nbsp</label> 
                 <label>已完成</label> 
                 <label style="background-color:#FF0000;width:50px;display:inline-block;" runat="server" id="lblTdys" visible="false">&nbsp</label> 
                 <label runat="server" id="lblTdysTitle" visible="false">被退单需处理</label> 
                 <label style="background-color:#CCFFFF;width:50px;display:inline-block;" runat="server" id="lblYwyyxg" visible="false">&nbsp</label> 
                 <label runat="server" id="lblYwyyxgTitle" visible="false">业务员已修改</label>
             </td>             
             </tr></table>
         <table align="Center" border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td style="height: 30px">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                         <tr >
                             <td rowspan="2" align="center" style="height: 31px" valign="middle" >
                             <asp:LinkButton ID="lbTjbd" runat="server" OnClick="tjbd_Click" style="background-color:#FEEDC9;display: block ;text-align: center;color: #d84700;  font-size: 14px; font-weight: bold; text-decoration: none; " Width="120px">添加开发提案</asp:LinkButton>
                             </td>
                             <td width="94%" rowspan="2" align="center" style="height: 31px;font-size:15px;font-weight:bold;" runat="server" id="tdTitle">
                                 产品开发提案书&nbsp;</td>
                         </tr>
                               <tr >                                     </tr>
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
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"   AllowPaging="true" PageSize="20"  OnPageIndexChanging ="GridView1_PageIndexChanging" EmptyDataRowStyle-BackColor="#40e0d0">
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                         <asp:BoundField DataField="bh" HeaderText="编号" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:CommandField HeaderText="修改" ShowEditButton="True">
                                             <ItemStyle Width="5%" />
                                         </asp:CommandField>
                                         <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                                             <ItemStyle Width="5%" />
                                         </asp:CommandField>
                                         <asp:BoundField DataField="jbrq" HeaderText="建表日期">
                                             <ItemStyle Width="10%" />
                                         
                                         </asp:BoundField>
                                         <asp:BoundField DataField="LCHQZT" HeaderText="流程会签状态" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="CPZT" HeaderText="成品状态" >
                                             <ItemStyle Width="8%"  />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="khdm" HeaderText="客户代码" >
                                             <ItemStyle Width="6%"  />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="KHXH" HeaderText="客户型号" >
                                             <ItemStyle Width="6%"  />
                                         </asp:BoundField>
                                         
                                          <asp:BoundField DataField="nbxh" HeaderText="内部型号" >
                                             <ItemStyle Width="6%"  />
                                         </asp:BoundField>
                                         
                                         <asp:BoundField DataField="BCRL" HeaderText="标称容量" >
                                             <ItemStyle Width="8%"  />
                                         </asp:BoundField>
                                        <asp:BoundField DataField="xsry" HeaderText="销售人员" >
                                             <ItemStyle Width="8%"  />
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
    </form>
</body>
</html>
