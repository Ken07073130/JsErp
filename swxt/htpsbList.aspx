<%@ Page Language="C#" AutoEventWireup="true" CodeFile="htpsbList.aspx.cs" Inherits="htpsbList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>收料单</title>

    <script type="text/javascript">
        function showWorkFlow() {
            if (document.getElementById('aShowWorkFlow').innerText == '显示签单进度') {
                document.getElementById('divWorkFlow').style.display = "";
                document.getElementById('aShowWorkFlow').innerText = "隐藏签单进度";
            } else {
                document.getElementById('divWorkFlow').style.display = "none";
                document.getElementById('aShowWorkFlow').innerText = "显示签单进度";
            }
        }

        function showQuery() {
            if (document.getElementById('aShowQuery').innerText == '显示查询') {
                document.getElementById('divShowQuery').style.display = "";
                document.getElementById('aShowQuery').innerText = "隐藏查询";
            } else {
                document.getElementById('divShowQuery').style.display = "none";
                document.getElementById('aShowQuery').innerText = "显示查询";
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 0 auto; width: 100%; font-size: 12px;">
            <div style="text-align: center; font-size: 25px; font-weight: bold; background-color: #FFFFCC;">
                <span style="float: left; vertical-align: middle;">
                    <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline; width: 70px; height: 25px; font-size: 13px; line-height: 25px;"
                        OnClick="tjbd_Click">添加合同评审单</asp:LinkButton>
                </span><span>合同评审单列表</span>
            </div>
            <div style="height: 15px; margin-bottom: 15px;">
                会签状态<asp:DropDownList ID="ddlHqzt" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlHqzt_SelectedIndexChanged">
                    <asp:ListItem Selected="True">会签中</asp:ListItem>
                    <asp:ListItem>已会签</asp:ListItem>
                    <asp:ListItem>全部</asp:ListItem>
                </asp:DropDownList>
                <asp:LinkButton ID="lbPrint" runat="server" Style="font-size: 13px; color: white; line-height: 20px; background-color: #3385ff; text-align: center; text-decoration: none"
                    Width="71px" OnClick="lbPrint_Click">打印</asp:LinkButton>
                &nbsp;<label style="background-color: #FFFF99; width: 50px; display: inline-block; border: 1px solid;">&nbsp</label>
                变更单&nbsp;
               
                <label style="background-color: #CC3333; width: 50px; display: inline-block; border: 1px solid;">
                    &nbsp</label>
                不同意单&nbsp; <a id="aShowWorkFlow" runat="server" visible="false" href="javascript:void(0);"
                    onclick="showWorkFlow()" style="font-size: 13px; width: 120px; display: inline-block; color: white; line-height: 20px; height: 20px; background-color: #FF9999; text-align: center; text-decoration: none">显示签单进度</a>
                <a id="aShowQuery" runat="server" href="javascript:void(0);"
                    onclick="showQuery()" style="font-size: 13px; width: 120px; display: inline-block; color: white; line-height: 20px; height: 20px; background-color: #FF9999; text-align: center; text-decoration: none">显示查询</a>
            </div>
            <div style="height: 15px; margin-bottom: 15px;">
                选择显示列：<asp:CheckBoxList ID="cblTitleList" runat="server" RepeatDirection="Horizontal" Style="border: 1px solid;"
                    AutoPostBack="True" OnSelectedIndexChanged="cblTitleList_SelectedIndexChanged" RepeatLayout="Flow" Height="20px">
                    <asp:ListItem Value="BH" Selected="True">单号</asp:ListItem>
                    <asp:ListItem Selected="True" Value="BB">版本</asp:ListItem>
                    <asp:ListItem Selected="True" Value="JBRQ">建表日期</asp:ListItem>
                    <asp:ListItem Selected="True" Value="GGSXH">规格书型号</asp:ListItem>
                    <asp:ListItem Selected="True" Value="KHXH">客户型号</asp:ListItem>
                    <asp:ListItem Selected="True" Value="KHDM">客户代码</asp:ListItem>
                    <asp:ListItem Selected="True" Value="GGSBH">规格书编号</asp:ListItem>
                    <asp:ListItem Selected="True" Value="GGSBB">规格书版本</asp:ListItem>
                    <asp:ListItem Selected="True" Value="DDSL">订单数量</asp:ListItem>
                    <asp:ListItem Selected="True" Value="KHDDH">客户订单号</asp:ListItem>
                    <asp:ListItem Selected="True" Value="NBDXXH">内部电芯型号</asp:ListItem>
                    <asp:ListItem Selected="True" Value="NBPACKXH">PACK型号</asp:ListItem>
                </asp:CheckBoxList>
            </div>
            <div id="divWorkFlow" style="display: none; margin-bottom: 20px;">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="3"
                    Style="text-align: center" Font-Names="Verdana" Font-Size="12px" EmptyDataText="无记录"
                    Width="900px" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                    AllowPaging="True" AllowSorting="True" PageSize="20" EmptyDataRowStyle-BackColor="#40e0d0"
                    OnRowDataBound="GridView2_RowDataBound">
                    <RowStyle ForeColor="#000066" />
                    <Columns>
                        <asp:BoundField DataField="GGSXH" HeaderText="规格书型号">
                            <ItemStyle Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="KHDM" HeaderText="客户代码">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PMCHQZT" HeaderText="PMC">
                            <ItemStyle Width="5%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="GCHQZT" HeaderText="工程部">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SBHQZT" HeaderText="设备部">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ZLHQZT" HeaderText="质量部">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ZZHQZT" HeaderText="制造部">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PACKHQZT" HeaderText="PACK">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="GYLHQZT" HeaderText="供应链">
                            <ItemStyle Width="8%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SCZJHQZT" HeaderText="生产总监">
                            <ItemStyle Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ZGHQZT" HeaderText="总工">
                            <ItemStyle Width="5%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SWJLHQZT" HeaderText="商务经理">
                            <ItemStyle Width="10%" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <EmptyDataRowStyle BackColor="Turquoise" />
                </asp:GridView>
            </div>
            <div id="divShowQuery" style="display:none">
                <div style="margin-top: 5px;">
                    &nbsp; &nbsp; 单号&nbsp; &nbsp;
               
                    <asp:TextBox ID="tbBh" runat="server" Height="12px" Width="89px" Font-Size="12px" />&nbsp;
                客户订单号
               
                    <asp:TextBox ID="tbKhddh" runat="server" Height="12px" Width="89px" Font-Size="12px" />
                    &nbsp; 客户代码 &nbsp;<asp:TextBox ID="tbKhdm" runat="server" Height="12px" Width="89px"
                        Font-Size="12px" />&nbsp; 客户型号<asp:TextBox ID="tbKhxh" runat="server" Height="12px"
                            Width="89px" Font-Size="12px" />&nbsp;
               
                    <asp:LinkButton ID="lbQuery" runat="server" Width="71px" Style="text-align: center; background-color: #3385ff; color: white; font-size: 13px; line-height: 20px; text-decoration: none;"
                        OnClick="lbQuery_Click">查询</asp:LinkButton>
                </div>
                <div style="margin-bottom: 5px; margin-top: 5px;">
                    内部电芯型号<asp:TextBox ID="tbNbdxxh" runat="server" Height="12px" Width="89px" Font-Size="12px" />
                    内部包装型号<asp:TextBox ID="tbNbbzxh" runat="server" Height="12px" Width="89px" Font-Size="12px" />
                    内部PACK型号<asp:TextBox ID="tbNbpackxh" runat="server" Height="12px" Width="89px" Font-Size="12px" />
                    规格书编号<asp:TextBox ID="tbGgsbh" runat="server" Height="12px" Width="89px" Font-Size="12px" />
                    规格书版本号<asp:TextBox ID="tbGgsbb" runat="server" Height="12px" Width="89px" Font-Size="12px" />
                </div>
            </div>
            <div style="overflow: auto;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Style="text-align: center" Font-Names="Verdana" Font-Size="13px" OnRowDataBound="GridView1_RowDataBound"
                    OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" EmptyDataText="无记录"
                    Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
                    GridLines="Horizontal" AllowPaging="True" AllowSorting="True" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging"
                    EmptyDataRowStyle-BackColor="#40e0d0">
                    <RowStyle ForeColor="#333333" BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="LCHQZT" HeaderText="状态" />
                        <asp:HyperLinkField DataNavigateUrlFields="bh,bb" DataNavigateUrlFormatString="~/swxt/htpsbEdit.aspx?bh={0}&amp;lb=CHANGE&amp;editType=1&amp;bb={1}"
                            Target="main" Text="变更" />
                        <asp:CommandField HeaderText="修改" ShowEditButton="True" />
                        <asp:CommandField HeaderText="删除" ShowDeleteButton="True" />
                        <asp:TemplateField>
                            <HeaderTemplate>
                                打印
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="cbPrint" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BH" HeaderText="单号" />
                        <asp:BoundField DataField="BB" HeaderText="版本" />
                        <asp:BoundField DataField="JBRQ1" HeaderText="建表日期" />
                        <asp:BoundField DataField="GGSXH" HeaderText="规格书型号" />
                        <asp:BoundField DataField="KHXH" HeaderText="客户型号" />
                        <asp:BoundField DataField="KHDM" HeaderText="客户代码" />
                        <asp:BoundField DataField="GGSBH" HeaderText="规格书编号" />
                        <asp:BoundField DataField="GGSBB" HeaderText="规格书版本" />
                        <asp:BoundField DataField="DDSL1" HeaderText="订单数量" />
                        <asp:BoundField DataField="KHDDH" HeaderText="客户订单号" />
                        <asp:BoundField DataField="NBDXXH" HeaderText="内部电芯型号" />
                        <asp:BoundField DataField="NBPACKXH" HeaderText="PACK型号" />
                    </Columns>
                    <PagerTemplate>
                        <table style="font-size: 12px;">
                            <tr>
                                <td>总共<asp:Label ID="Label1" runat="server" Text="<%#((GridView)Container.NamingContainer).PageCount %>"></asp:Label>页
                                    &nbsp;
                                </td>
                                <td>第<asp:Label ID="Label2" runat="server" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"></asp:Label>页
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
                    <PagerStyle BackColor="#CCFFFF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#479AC7" Font-Bold="True" ForeColor="White" />
                    <EmptyDataRowStyle BackColor="Turquoise" />
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
