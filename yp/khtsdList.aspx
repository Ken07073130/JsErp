﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="khtsdList.aspx.cs" Inherits="khtsdList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>客户投诉录入及处理表</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-size: 12px;">
            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tbQsrq"
                Format="yyyy-MM-dd">
            </ajaxToolkit:CalendarExtender>
            <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tbJsrq"
                Format="yyyy-MM-dd">
            </ajaxToolkit:CalendarExtender>
            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tbKhdm"
                ServicePath="~/GetContent.asmx" ServiceMethod="GetKhdmList" MinimumPrefixLength="1"
                EnableCaching="true" CompletionInterval="200" />
            <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="true"
                EnableScriptLocalization="true">
                <Services>
                    <asp:ServiceReference Path="~/AutoCompleteService.svc" />
                </Services>
            </ajaxToolkit:ToolkitScriptManager>
            <table>
                <tr>
                    <td>
                        &nbsp; 会签状态<asp:DropDownList ID="ddlHqzt" runat="server" OnSelectedIndexChanged="btnCX_Click"
                            AutoPostBack="True">
                            <asp:ListItem Selected="True">会签中</asp:ListItem>
                            <asp:ListItem>全部</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList>
                        <label style="background-color: #FFCCCC; width: 50px; display: inline-block;">
                            &nbsp</label>
                        <label>
                            已完成</label>
                    </td>
                </tr>
            </table>
            <div style="background-color: #CCCCCC">
                起始日期<asp:TextBox ID="tbQsrq" runat="server" Width="89px" Height="15px"></asp:TextBox>结束日期<asp:TextBox
                    ID="tbJsrq" runat="server" Width="102px" Height="15px"></asp:TextBox>客户代码<asp:TextBox
                        ID="tbKhdm" runat="server" Width="104px" Height="15px"></asp:TextBox>型号<asp:TextBox
                            ID="tbXh" runat="server" Width="102px" Height="15px"></asp:TextBox>
                <asp:Button ID="btnExcel" runat="server" Text="查询并导出EXCEL" OnClick="btnExcel_Click" /></div>
            <table align="Center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="height: 30px">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                            <tr>
                                <td>
                                    <div style="text-align: center; font-size: 25px; font-weight: bold; background-color: #FFFFCC;">
                                        <span style="float: left; vertical-align: middle;">
                                            <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline; width: 70px; height: 25px;
                                                font-size: 13px; line-height: 25px;" OnClick="tjbd_Click">添加客诉单</asp:LinkButton>
                                        </span><span runat="server" id="spanTitle">客户投诉录入及处理表</span></div>
                                </td>
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
                                <td style="height: 199px">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        Style="text-align: center" Font-Names="Verdana" Font-Size="12px" OnRowDataBound="GridView1_RowDataBound"
                                        OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" EmptyDataText="无记录"
                                        Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
                                        GridLines="Horizontal" AllowPaging="true" AllowSorting="true" PageSize="20" OnPageIndexChanging="GridView1_PageIndexChanging"
                                        EmptyDataRowStyle-BackColor="#40e0d0">
                                        <RowStyle ForeColor="#333333" BackColor="White" />
                                        <Columns>
                                            <asp:BoundField DataField="bh" HeaderText="编号">
                                                <ItemStyle Width="10%" />
                                            </asp:BoundField>
                                            <asp:CommandField HeaderText="修改" ShowEditButton="True">
                                                <ItemStyle Width="3%" />
                                            </asp:CommandField>
                                            <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                                                <ItemStyle Width="3%" />
                                            </asp:CommandField>
                                            <asp:BoundField DataField="tsrq" HeaderText="投诉日期">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="lchqzt" HeaderText="当前会签状态">
                                                <ItemStyle Width="6%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="tszt" HeaderText="投诉主题">
                                                <ItemStyle Width="10%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="khdm" HeaderText="客户代码">
                                                <ItemStyle Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="xh" HeaderText="型号">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="khdm" HeaderText="客户代码">
                                                <ItemStyle Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SL" HeaderText="数量">
                                                <ItemStyle Width="7%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LLR" HeaderText="录入人">
                                                <ItemStyle Width="6%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CLR" HeaderText="处理人">
                                                <ItemStyle Width="6%" />
                                            </asp:BoundField>
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
