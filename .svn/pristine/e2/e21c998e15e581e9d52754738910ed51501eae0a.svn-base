<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tjbqx.aspx.cs"  Inherits="tjbqx"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统登录</title>
</head>
<body>
<form id="form1" runat="server" >
        <div style="text-align: center">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr valign="top">
                    <td>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                            BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4"
                            Font-Names="Verdana" Font-Size="12px" GridLines="Horizontal" OnRowDataBound="GridView1_RowDataBound"
                            OnRowDeleting="GridView1_RowDeleting" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" 
                            AllowPaging="true" PageSize="20"  OnPageIndexChanging ="GridView1_PageIndexChanging" 
                            Width="100%">
                            <RowStyle BackColor="White" ForeColor="#333333" />
                            <Columns>
                                <asp:BoundField DataField="XH" HeaderText="序号" ReadOnly="True">
                                    <ItemStyle Width="5%" />
                                </asp:BoundField>
                                <asp:HyperLinkField DataNavigateUrlFields="xh" DataNavigateUrlFormatString="tjnr.aspx?xh={0}"
                                    DataTextField="LCMC" HeaderText="流程名称" />
                                <asp:BoundField DataField="LCS" HeaderText="流程数">
                                    <ItemStyle Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DYBM" HeaderText="对应表名">
                                    <ItemStyle Width="20%" />
                                </asp:BoundField>
                                <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                                    <ItemStyle Width="8%" />
                                </asp:CommandField>
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
                            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
 </form>
</body>
</html>