<%@ Page Language="C#" validateRequest="false"  AutoEventWireup="true" CodeFile="tgxx.aspx.cs" Inherits="tgxx" Title="系统通知管理" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统登录</title>
</head>
<body>
<form id="form1" runat="server" >


    ` <div align="center" style="text-align: center">
        <asp:HiddenField ID="HF_glxx" runat="server" />
        <br />
        <table border="0" cellpadding="0" cellspacing="0" style="width: 800px; text-align: center;">
            <tr>
                <td style="width: 100px; text-align: left; height: 14px;">
                    <asp:HyperLink ID="HL_fbxgg" NavigateUrl="~/AddGGL.aspx"   runat="server">发布新公告</asp:HyperLink></td>
                <td style="width: 100px; height: 14px; text-align: center;">
                </td>
                <td style="width: 100px; height: 14px;">
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
             Font-Names="Verdana" Font-Size="12px" 
             emptydatatext="没有新的通告"  OnRowDeleting="GridView1_RowDeleting"  OnRowCreated ="GridView1_RowCreated" 
             Width="800px" GridLines="Horizontal"  EmptyDataRowStyle-BackColor="#40e0d0" OnRowCommand="GridView1_RowCommand"  
             BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px">
             <Columns >
                 <asp:TemplateField HeaderText="标题" >
                    <ItemTemplate  >
                         <asp:LinkButton  ID="LinkButton1" runat="server"  CommandName="wjlj"   CommandArgument='<%# Eval("id") %>' Text='<%# Eval("bt") %>' ></asp:LinkButton> 
                    </ItemTemplate>
                    <ItemStyle Width="65%"  HorizontalAlign ="Left" />
                </asp:TemplateField>
                
                <asp:BoundField DataField="sry" HeaderText="发布人" >
                     <ItemStyle Width="10%"   />
                </asp:BoundField>
                <asp:BoundField DataField="rq" HeaderText="发布日期" >
                     <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                    <ItemStyle Width="5%" />
                </asp:CommandField>

            </Columns>
            <EmptyDataRowStyle BackColor="Turquoise" />
            <FooterStyle BackColor="White" ForeColor="#006699" />
            <RowStyle ForeColor="#333333" BackColor="White" />
            <PagerStyle BackColor="#006699" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
         </asp:GridView>
     </div>

 </form>
</body>
</html>

