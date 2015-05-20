<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="yhz.aspx.cs" Inherits="wkzt_yhz" Title="文控管理-用户组权限管理" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
</head>
<body>
<form id="form1" runat="server" >
  <div align="center">
   <p style=" font-size :large; font-weight :bold  ">组权限管理</p> 
    <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
         Font-Names="Verdana" Font-Size="12px"  ShowFooter ="True" 
         emptydatatext="无记录"  
         Width="800px" GridLines="Horizontal" 
         OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" 
         AllowPaging="True" PageSize="30"  EmptyDataRowStyle-BackColor="#40e0d0" 
         BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
          >
         <Columns >
             <asp:TemplateField  HeaderText ="ID">
                <ItemTemplate  >
                     <asp:Label ID ="ID"    runat="server" Text ='<%#  Eval("ID") %>'/>
                </ItemTemplate>
            
                <FooterTemplate>
                    <asp:Button ID="B_TJ" runat="server" Text="添加"  OnClick="Button_Click"/>
                </FooterTemplate>
            
                <ItemStyle Width="5%"   />
            </asp:TemplateField>
            <asp:TemplateField  HeaderText ="组名">
                <ItemTemplate  >
                     <asp:Label ID ="zm"    runat="server" Text ='<%# Eval("GroupName") %>'/>
                </ItemTemplate>
            
                <FooterTemplate>
                    <asp:TextBox  ID ="T_ZM" runat="server" Width="100px" ></asp:TextBox>
                </FooterTemplate>
            
                <ItemStyle Width="15%"   />
            </asp:TemplateField>
             <asp:BoundField DataField="GradationID" HeaderText="所属权限" >
                 <ItemStyle Width="30%" />
             </asp:BoundField>
             <asp:BoundField DataField="IsDownload" HeaderText="下载" >
                 <ItemStyle Width="30%"  />
             </asp:BoundField>
            <asp:CommandField HeaderText="修改" ShowEditButton="True">
                 <ItemStyle Width="5%" />
             </asp:CommandField>
             <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                 <ItemStyle Width="5%" />
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

