<%@ Page Language="C#" AutoEventWireup="true" CodeFile="btdList.aspx.cs" Inherits="btdList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <title>采购单</title>

    <script type="text/javascript">

        function showDiv(divName){
            var x,y; 
            x = event.clientX; 
            y = event.clientY;
           // alert(document.getElementById(divName).innerHTML);
            document.getElementById(divName).style.left = x; 
            document.getElementById(divName).style.top = y; 
            document.getElementById(divName).style.display = "block"; 
        }
        
        function hideDiv(divName){
            document.getElementById(divName).style.display = "none"; 
        }
        
        function printCgd(bh){
           var url="rpt/cgdPrint.aspx?bh="+bh;
           window.open(url);
        }
        
    </script>

    <style type="text/css">
       

</style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 0 auto; width: 100%; font-size: 12px;">
            <div style="text-align: center; font-size: 25px; font-weight: bold; background-color: #FFFFCC;">
                <span style="float: left; vertical-align: middle;">
                    <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline; width: 70px; height: 25px;
                        font-size: 13px; line-height: 25px;" Visible="false">新增采购单</asp:LinkButton>
                </span><span runat="server" id="spanTitle"></span>投产计划列表</div>
          
          
            <div style="margin:0 auto; width:1100px;  overflow:auto;">
               <div style="margin-bottom:5px;"><span style="border:1px solid ; background-color:#FFFF99; display:inline-block; width:50px;">&nbsp</span> 变更中</div>
                <div style="margin-bottom:5px;">客户代码<asp:TextBox ID="tbKhdm" runat="server" Height="13px" Width="100px"></asp:TextBox>
                    电芯型号<asp:TextBox ID="tbNbdxxh"
                        runat="server" Height="13px" Width="100px"></asp:TextBox>
                    PACK型号<asp:TextBox ID="tbNbpackxh" runat="server" Height="13px" Width="100px"></asp:TextBox>
                    订单号<asp:TextBox ID="tbKhddh"
                        runat="server" Height="13px" Width="100px"></asp:TextBox>
                    <asp:LinkButton ID="lbQuery" runat="server" Style="font-size: 13px;
                        color: white; line-height: 20px; background-color: #3385ff; text-align: center;
                        text-decoration: none" Width="71px" OnClick="lbQuery_Click">查询</asp:LinkButton></div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Style="text-align: center" Font-Names="Verdana" Font-Size="12px" OnRowDataBound="GridView1_RowDataBound"
                    OnRowEditing="GridView1_RowEditing" EmptyDataText="无记录" Width="1100" BackColor="White"
                    BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"
                    AllowPaging="true" AllowSorting="true" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging"
                    EmptyDataRowStyle-BackColor="#40e0d0">
                    <RowStyle ForeColor="#333333" BackColor="White"  />
                    <Columns>
                        <asp:BoundField DataField="zt" HeaderText="状态" ItemStyle-Width="70px" />
                        <asp:CommandField ShowEditButton="true" HeaderText="编辑" ItemStyle-Width="30" />
                        <asp:BoundField DataField="psdbh" HeaderText="单号" ItemStyle-Width="150" />
                       <asp:BoundField DataField="khddh" HeaderText="订单号" ItemStyle-Width="120" />
                        <asp:BoundField DataField="jbrq" HeaderText="合同日期" ItemStyle-Width="80" />
                        <asp:BoundField DataField="khxh" HeaderText="客户型号" ItemStyle-Width="80" />
                        <asp:BoundField DataField="khdm" HeaderText="客户代码" ItemStyle-Width="80" />
                        
                        <asp:BoundField DataField="nbdxxh" HeaderText="电芯型号" ItemStyle-Width="90" />
                        <asp:BoundField DataField="nbpackxh" HeaderText="PACK型号" ItemStyle-Width="150" />
                        <asp:BoundField DataField="ddsl" HeaderText="投产数量" ItemStyle-Width="100" />
                        <asp:BoundField DataField="tczs" HeaderText="已投数量" ItemStyle-Width="100" />
                        <asp:BoundField DataField="djlsh" HeaderText="" >
                            <ControlStyle CssClass="hidden" />
                            <FooterStyle CssClass="hidden" />
                            <HeaderStyle CssClass="hidden" />
                            <ItemStyle CssClass="hidden" />
                        </asp:BoundField>
                        <asp:BoundField DataField="bgzt" HeaderText="">
                            <ControlStyle CssClass="hidden" />
                            <FooterStyle CssClass="hidden" />
                            <HeaderStyle CssClass="hidden" />
                            <ItemStyle CssClass="hidden" />
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
            </div>
        </div>
    </form>
</body>
</html>
