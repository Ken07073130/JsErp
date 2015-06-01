<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tldList.aspx.cs" Inherits="tldList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 0 auto; width: 100%; font-size: 12px;">
            <div style="text-align: center; font-size: 25px; font-weight: bold; background-color:#FFFFCC; ">
                <span style="float:left; vertical-align:middle;">
                     <asp:LinkButton ID="lbtnOK" runat="server" style="display:inline; width:70px; height:25px; font-size:13px; line-height:25px; " OnClick="tjbd_Click">添加套料单</asp:LinkButton>
                                
                  </span>
                <span >套料单列表</span></div>
             <div style="height:15px; margin-bottom:5px;">
                 <label style="background-color:#FFCCCC;width:50px;display:inline-block;">&nbsp</label> 
                 <label>已生成</label> 
                 <label style="background-color:#CC0033;width:50px;display:inline-block;">&nbsp</label> 
                 <label>需变更</label> 
             </div>
              <div style="margin-top: 5px;">
                    &nbsp; &nbsp; &nbsp; 评审单编号 
               
                    <asp:TextBox ID="tbPsdbh" runat="server" Height="12px" Width="151px" Font-Size="12px" />&nbsp;&nbsp;内部电芯型号
               
                    <asp:TextBox ID="tbDxxh" runat="server" Height="12px" Width="89px" Font-Size="12px" />
                    &nbsp; 客户代码 &nbsp;<asp:TextBox ID="tbKhdm" runat="server" Height="12px" Width="89px"
                        Font-Size="12px" />&nbsp; 
               
                    <asp:LinkButton ID="lbQuery" runat="server" Width="71px" Style="text-align: center; background-color: #3385ff; color: white; font-size: 13px; line-height: 20px; text-decoration: none;"
                        OnClick="lbQuery_Click" OnClientClick="queryClick()">查询</asp:LinkButton>
                </div>
            <div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Style="text-align: center" Font-Names="Verdana" Font-Size="12px" OnRowDataBound="GridView1_RowDataBound"
                    OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" EmptyDataText="无记录"
                    Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
                    GridLines="Horizontal" AllowPaging="true" AllowSorting="true" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging"
                    EmptyDataRowStyle-BackColor="#40e0d0">
                    <RowStyle ForeColor="#333333" BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="BH" HeaderText="单号" />
                        <asp:CommandField HeaderText="修改" ShowEditButton="True">
                            <ItemStyle Width="3%" />
                        </asp:CommandField>
                        <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                            <ItemStyle Width="3%" />
                        </asp:CommandField>
                        <asp:BoundField DataField="PSDBH" HeaderText="评审单号" />
                        <asp:BoundField DataField="JBRQ" HeaderText="建表日期" />
                        <asp:BoundField DataField="TLZT" HeaderText="套料状态" />
                        <asp:BoundField DataField="DXXH" HeaderText="电芯型号" />
                         <asp:BoundField DataField="PACKXH" HeaderText="PACK型号" />
                        <asp:BoundField DataField="DDH" HeaderText="合同订单号" />
                        <asp:BoundField DataField="KHDM" HeaderText="客户代码" />
                        <asp:BoundField DataField="DDL" HeaderText="合同投产量" />
                        <asp:BoundField DataField="TCL" HeaderText="投料量" />
                        <asp:HyperLinkField DataNavigateUrlFields="bh" DataNavigateUrlFormatString="tldEdit.aspx?xh={0}&lb=Change" Text="变更" ItemStyle-Width="3%"  />
                    </Columns>
                    <PagerTemplate>
                        <table style="font-size: 12px;">
                            <tr>
                                <td>
                                    总共<asp:Label ID="Label1" runat="server" Text="<%#((GridView)Container.NamingContainer).PageCount %>"></asp:Label>页
                                    &nbsp;
                                </td>
                                <td>
                                    第<asp:Label ID="Label2" runat="server" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"></asp:Label>页
                                    &nbsp;</td>
                                <td>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="1" CommandName="Page"
                                        Enabled="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">首页</asp:LinkButton>
                                    &nbsp;</td>
                                <td>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument="Prev" CommandName="Page"
                                        Enabled="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">上一页</asp:LinkButton>
                                    &nbsp;</td>
                                <td>
                                    <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="Next" CommandName="Page"
                                        Enabled="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">下一页 </asp:LinkButton>
                                    &nbsp;</td>
                                <td>
                                    <asp:LinkButton ID="LinkButton4" runat="server" CommandArgument="Last" CommandName="Page"
                                        Enabled="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">尾页</asp:LinkButton>
                                    &nbsp;</td>
                                <td>
                                    <asp:LinkButton ID="LinkButton5" runat="server" CommandArgument="-1" CommandName="Page"
                                        ValidationGroup="1">GO</asp:LinkButton>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNum" runat="server" Width="30px" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"
                                        ValidationGroup="1"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage=""
                                        ValidationExpression="^/d+$" ControlToValidate="txtNum" ValidationGroup="1"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                        </table>
                    </PagerTemplate>
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#479AC7" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
