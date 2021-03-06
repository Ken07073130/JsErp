﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="thdList.aspx.cs" Inherits="thdList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>退货单列表</title>
    <link href="../cgxt/css/common.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 0 auto; width: 100%; font-size: 12px;">
            <div>会签状态<asp:DropDownList ID="ddlHqzt" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlHqzt_SelectedIndexChanged">
                <asp:ListItem>会签中</asp:ListItem>
                <asp:ListItem>已会签</asp:ListItem>
                <asp:ListItem>全部</asp:ListItem>
                </asp:DropDownList></div>
            <div style="text-align: center; font-size: 25px; font-weight: bold; background-color: #FFFFCC;">
                <span style="float: left; vertical-align: middle;">
                    <asp:LinkButton ID="lbtnAdd" runat="server" Style="display: inline; width: 70px; height: 25px;
                        font-size: 13px; line-height: 25px;" OnClick="tjbd_Click" Text="新增退货单"></asp:LinkButton>
                </span>
                <span>
                    <asp:Label ID="lblTitle" runat="server" Text="退货单列表"></asp:Label></span></div>
            <div>
         

              

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Style="text-align: center" Font-Names="Verdana" Font-Size="12px" OnRowDataBound="GridView1_RowDataBound"
                    OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" EmptyDataText="无记录"
                    Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
                    GridLines="Horizontal" AllowPaging="true" AllowSorting="true" PageSize="100"
                    OnPageIndexChanging="GridView1_PageIndexChanging" EmptyDataRowStyle-BackColor="#40e0d0">
                    <RowStyle ForeColor="#333333" BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="BH" HeaderText="编号">
                            <ItemStyle Width="6%" />
                        </asp:BoundField>
                        <asp:CommandField HeaderText="修改" ShowEditButton="True">
                            <ItemStyle Width="3%" />
                        </asp:CommandField>
                         <asp:BoundField DataField="WLMC" HeaderText="物料名称">
                            <ItemStyle Width="5%" />
                        </asp:BoundField>
                         <asp:BoundField DataField="GC" HeaderText="工厂">
                            <ItemStyle Width="5%" />
                        </asp:BoundField>
                        
                        <asp:BoundField DataField="GYSMC" HeaderText="供应商名称">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PH" HeaderText="批号">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="GG" HeaderText="规格">
                            <ItemStyle Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SL" HeaderText="数量">
                            <ItemStyle Width="5%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="djlsh" >
                            <ControlStyle CssClass="hidden" />
                            <FooterStyle CssClass="hidden" />
                            <HeaderStyle CssClass="hidden" />
                            <ItemStyle CssClass="hidden" />
                        </asp:BoundField>
                        <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                            <ItemStyle Width="3%" />
                        </asp:CommandField>
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
