﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="btdList.aspx.cs" Inherits="btdList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <title>采购单</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 0 auto; width: 100%; overflow: auto; font-size: 12px;">
            <div style="text-align: center; font-size: 25px; font-weight: bold; background-color: #FFFFCC;">
                <span style="float: left; vertical-align: middle;">
                    <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline; width: 70px; height: 25px;
                        font-size: 13px; line-height: 25px;" OnClick="tjbd_Click">新增补投单</asp:LinkButton>
                </span><span runat="server" id="spanTitle"></span>补投单列表
            </div>
            <div style="margin-bottom: 5px;">
                会签中<asp:DropDownList ID="ddlHqzt" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlHqzt_SelectedIndexChanged">
                    <asp:ListItem>会签中</asp:ListItem>
                    <asp:ListItem>已会签</asp:ListItem>
                    <asp:ListItem>全部</asp:ListItem>
                </asp:DropDownList>
                <span style="border: 1px solid; background-color: #FFFF99; display: inline-block;
                    width: 50px;">&nbsp</span> 变更中
                <asp:LinkButton ID="lbPrint" runat="server" OnClick="lbPrint_Click" Style="font-size: 13px;
                    color: white; line-height: 20px; background-color: #3385ff; text-align: center;
                    text-decoration: none" Width="71px">打印</asp:LinkButton></div>
            <div style="margin-bottom: 5px;">
                客户代码<asp:TextBox ID="tbKhdm" runat="server" Width="100px"></asp:TextBox>
                电芯型号<asp:TextBox ID="tbNbdxxh" runat="server" Width="100px"></asp:TextBox>
                PACK型号<asp:TextBox ID="tbNbpackxh" runat="server" Width="100px"></asp:TextBox>
                <asp:LinkButton ID="lbQuery" runat="server" Style="font-size: 13px; color: white;
                    line-height: 20px; background-color: #3385ff; text-align: center; text-decoration: none"
                    Width="71px" OnClick="lbQuery_Click">查询</asp:LinkButton>
            </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                Style="text-align: center; table-layout: fixed; word-wrap: break-word;" Font-Names="Verdana"
                Font-Size="12px" OnRowDataBound="GridView1_RowDataBound" OnRowEditing="GridView1_RowEditing"
                EmptyDataText="无记录" Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double"
                BorderWidth="3px" GridLines="Horizontal" AllowPaging="true" AllowSorting="true"
                PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging" EmptyDataRowStyle-BackColor="#40e0d0"
                OnRowDeleting="GridView1_RowDeleting">
                <RowStyle ForeColor="#333333" BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="lchqzt" HeaderText="状态" ItemStyle-Width="50px" HeaderStyle-Width="50px" />
                    <asp:CommandField ShowEditButton="true" HeaderText="编辑" ItemStyle-Width="50px" HeaderStyle-Width="50px" />
                    <asp:TemplateField HeaderStyle-Width="50px" ItemStyle-Width="50px">
                            <HeaderTemplate>
                                打印
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="cbPrint" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    <asp:BoundField DataField="bh" HeaderText="编号">
                        <ControlStyle CssClass="hidden" />
                        <FooterStyle CssClass="hidden" />
                        <HeaderStyle CssClass="hidden" />
                        <ItemStyle CssClass="hidden" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ddh" HeaderText="单号" ItemStyle-Width="150px" HeaderStyle-Width="150px"  />
                    <asp:BoundField DataField="jbrq" HeaderText="日期" ItemStyle-Width="80px" HeaderStyle-Width="80px" />
                    <asp:BoundField DataField="KHDM" HeaderText="客户代码" ItemStyle-Width="60px" HeaderStyle-Width="60px" />
                    <asp:BoundField DataField="GGSXH" HeaderText="规格书型号" />
                    <asp:BoundField DataField="nbdxxh" HeaderText="内部电芯" />
                    <asp:BoundField DataField="nbpackxh" HeaderText="PACK型号"  />
                    <asp:BoundField DataField="DXYJBT" HeaderText="电芯" ItemStyle-Width="50px" HeaderStyle-Width="50px" />
                    <asp:BoundField DataField="ZJYJBT" HeaderText="正极" ItemStyle-Width="50px" HeaderStyle-Width="50px" />
                    <asp:BoundField DataField="FJYJBT" HeaderText="负极" ItemStyle-Width="50px" HeaderStyle-Width="50px" />
                    <asp:BoundField DataField="PACKYJBT" HeaderText="PACK" ItemStyle-Width="50px" HeaderStyle-Width="50px" />
                    <asp:CommandField ShowDeleteButton="true" HeaderText="删除" ItemStyle-Width="50px"
                        DeleteText="&lt;span onclick=&quot;JavaScript:return confirm('确定删除吗？')&quot;&gt;删除&lt;/span&gt;" />
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
    </form>
</body>
</html>
