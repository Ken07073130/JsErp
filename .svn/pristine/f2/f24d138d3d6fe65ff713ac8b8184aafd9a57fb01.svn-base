<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="jxkh_khjg_lb.aspx.cs" Inherits="jxkh_khjg_lb" Title="考核结果" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
</head>
<body>
<form id="form1" runat="server" >
    &nbsp;&nbsp;
         <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td style="height: 30px">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                         <tr >

                             <td width="94%" rowspan="2" align="center" style="height: 31px;font-size:15px;font-weight:bold;">
                                 部门绩效考核表</td>
                         </tr>
                           <tr>
                           </tr>
                     </table>
                 </td>
             </tr>
             <tr>
                 <td>
                     <table border="0" cellpadding="0" cellspacing="0" class="STYLE10" width="100%">
                         <tr valign="top">
                             <td style="height: 199px; width: 1168px;">
                                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" style="text-align: center" EmptyDataText="无记录"
                                     Font-Names="Verdana" Font-Size="12px" AllowSorting="True" OnSorting="GridView1_Sorting"    OnRowUpdating="GridView1_RowUpdating"
                                     OnRowDeleting="GridView1_RowDeleting"  OnRowCreated="GridView1_RowCreated"   OnRowDataBound="GridView1_RowDataBound" 
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"  AllowPaging="true" PageSize="100"  OnPageIndexChanging ="GridView1_PageIndexChanging"  >
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                        <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="jxkh_khjg.aspx?kjny={0}"
                                             DataTextField="id" HeaderText="ID"  ItemStyle-Width="15%"/>
                                         <asp:BoundField DataField="kjny" HeaderText="会计年月">
                                             <ItemStyle Width="75%" />
                                         </asp:BoundField>
                                        <asp:TemplateField >
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete"    OnClientClick='return confirm("此删除操作不可恢复，您确认删除此记录吗？")'>删除</asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderTemplate>删除</HeaderTemplate>
                                        </asp:TemplateField>

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
    </form>
    </body>
    </html>

