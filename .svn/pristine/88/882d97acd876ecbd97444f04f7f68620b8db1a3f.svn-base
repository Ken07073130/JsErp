<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tjnr.aspx.cs"   Inherits="tjnr" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >

<head id="Head1" runat="server">
    <title>添加表权限</title>
    <link href="Images/CSS/Manage.css" rel="stylesheet" type="text/css" />
</head>
<body style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">
    <form id="form1" runat="server">
        <div style="text-align: center">
           <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr valign="top">
                    <td>
                     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" Font-Names="Verdana" OnRowDeleting="GridView1_RowDeleting" 
                                    Font-Size="12px" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanging="GridView1_SelectedIndexChanging"
                                    BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4"  GridLines="Horizontal" 
                                     AllowPaging="true" PageSize="20"  OnPageIndexChanging ="GridView1_PageIndexChanging"  >
                         <Columns>
                            <asp:BoundField DataField="XH"    HeaderText="序号"      ItemStyle-Width="5%" ReadOnly="True"/>
                            <asp:BoundField DataField="bzxh"  HeaderText="步骤序号"  ItemStyle-Width="5%"  />
                            <asp:BoundField DataField="yhz"   HeaderText="用户组"    ItemStyle-Width="5%"  />
                            <asp:BoundField DataField="zdmC"  HeaderText="字段名"    />

                            <asp:BoundField DataField="xsfs"  HeaderText="显示"      ItemStyle-Width="5%"  />
                            <asp:BoundField DataField="dxfs"  HeaderText="读写"      ItemStyle-Width="15%"  />
                            <asp:BoundField DataField="shqx"  HeaderText="审核权限"  ItemStyle-Width="5%"  />
                            <asp:BoundField DataField="ys"    HeaderText="颜色"      ItemStyle-Width="10%" />
                            <asp:BoundField DataField="groupid"    HeaderText="组"        ItemStyle-Width="5%"  />

                             <asp:CommandField HeaderText="添加" SelectText="添加行" ShowSelectButton="True" />

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
                <tr>
                <td>
                    </td> 
                </tr>
            </table>

        </div>

      
    </form>
</body>
</html>
