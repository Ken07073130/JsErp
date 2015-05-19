<%@ Page Language="C#" MasterPageFile="~/swgl/main.master" AutoEventWireup="true" CodeFile="tcjhList.aspx.cs" Inherits="swgl_tcjhList" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div style="overflow:scroll; height:100%; width:100% ;overflow:auto;"> 

         <table align="Center" border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td style="height: 30px">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                         <tr >
                             <td width="6%" rowspan="2" align="center" style="height: 23px;font-size:15px;font-weight:bold;">
             
                   <asp:ImageButton ID="tjbd" runat="Server"  OnClick="tjbd_Click"  ImageUrl ="../images/btnAddYp.jpg"  />
                             <td width="94%" rowspan="2" align="center" style="height: 23px;font-size:15px;font-weight:bold;">投产计划 </td>
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
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"   AllowPaging="true" PageSize="20"  OnPageIndexChanging ="GridView1_PageIndexChanging" EmptyDataRowStyle-BackColor="#40e0d0">
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                         <asp:BoundField DataField="ddlsh" HeaderText="订单流水号" >
                                             <ItemStyle Width="5%" />
                                         </asp:BoundField>
                                         <asp:CommandField HeaderText="修改" ShowEditButton="True">
                                             <ItemStyle Width="5%" />
                                         </asp:CommandField>
                                         <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                                             <ItemStyle Width="5%" />
                                         </asp:CommandField>
                                         <asp:BoundField DataField="DXXH" HeaderText="电芯型号">
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="XHDM" HeaderText="型号代码" >
                                             <ItemStyle Width="6%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="PACKXH" HeaderText="PACK型号" >
                                             <ItemStyle Width="10%"  />
                                         </asp:BoundField>
                                        <asp:BoundField DataField="khdm" HeaderText="客户代码" >
                                             <ItemStyle Width="10%"  />
                                         </asp:BoundField>
                                          <asp:BoundField DataField="KHXH" HeaderText="客户型号"  >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="DDZSL" HeaderText="电芯总数量" >
                                             <ItemStyle Width="10%"  />
                                         </asp:BoundField>
                                        <asp:BoundField DataField="PCZSL" HeaderText="批次总数量" >
                                             <ItemStyle Width="10%"  />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="LLR" HeaderText="录入人" >
                                             <ItemStyle Width="6%"  />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="LRRQ" HeaderText="录入日期"  HtmlEncode=false DataFormatString="{0:yyyy-MM-dd}" >
                                             <ItemStyle Width="10%"  />
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
                                     <PagerStyle BackColor="#479AC7" ForeColor="White" HorizontalAlign="Center" />
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
</asp:Content>

