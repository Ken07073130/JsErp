<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zxwtfkList.aspx.cs" Inherits="zxwtfkList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>专项问题反馈列表</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table ><tr>
             <td>
             
                   &nbsp;
                  会签状态<asp:DropDownList ID="ddlHqzt" runat="server" OnSelectedIndexChanged="btnCX_Click" AutoPostBack="True" >
                     <asp:ListItem Selected="True">会签中</asp:ListItem>
                     <asp:ListItem>全部</asp:ListItem>
                     <asp:ListItem>已会签</asp:ListItem>                 
                 </asp:DropDownList>
                 <label style="background-color:#FFCCCC;width:50px;display:inline-block;">&nbsp</label> 
                 <label>已完成</label> 
             </td>             
             </tr></table>
         <table align="Center" border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td style="height: 30px">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                         <tr >
                             <td rowspan="2" align="left" style="height: 23px;font-size:15px;font-weight:bold; width: 20%;">
                                 &nbsp;
                                 <asp:ImageButton ID="tjbd" runat="Server" Height="10"  src="../images/add.gif" Width="10" OnClick="tjbd_Click" />
                                                     
                                 <asp:LinkButton ID="lbtnOK" runat="server" style="display:inline; width:70px; height:20px; font-size:13px; line-height:20px;   color:Black;" OnClick="tjbd_Click">添加专项问题反馈</asp:LinkButton>
                                 <td width="80%" rowspan="2" align="center" style="height: 23px;font-size:15px;font-weight:bold;">
                                 &nbsp;专项问题反馈 </td>
                         </tr>
                               <tr >                                     </tr>
                     </table>
                 </td>
             </tr>
             <tr>
                 <td>
                     <table border="0" cellpadding="0" cellspacing="0" class="STYLE10" width="100%">
                         <tr valign="top">
                             <td style="height: 199px">
                                 <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
                                     Font-Names="Verdana" Font-Size="12px" OnRowDataBound="GridView1_RowDataBound"
                                     OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing"  
                                     emptydatatext="无记录"  
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"   AllowPaging="true" AllowSorting="true" PageSize="50"  OnPageIndexChanging ="GridView1_PageIndexChanging" EmptyDataRowStyle-BackColor="#40e0d0">
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                         <asp:BoundField DataField="BH" HeaderText="单号" >
                                             <ItemStyle Width="5%" />
                                         </asp:BoundField>
                                         <asp:CommandField HeaderText="修改" ShowEditButton="True">
                                             <ItemStyle Width="3%" />
                                         </asp:CommandField>
                                         <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                                             <ItemStyle Width="3%" />
                                         </asp:CommandField>
                                         <asp:BoundField DataField="RQ" HeaderText="建表日期">
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="LCHQZT" HeaderText="当前会签状态" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         
                                         <asp:BoundField DataField="XH" HeaderText="型号" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                       <asp:BoundField DataField="FQR" HeaderText="发起人" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="ZT" HeaderText="主题" >
                                             <ItemStyle Width="10%"  />
                                         </asp:BoundField>

                                          <asp:BoundField DataField="FZR" HeaderText="负责人" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="FSGX" HeaderText="发生工序" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         
                                        <asp:BoundField DataField="XGSFYX" HeaderText="最终结论" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
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
