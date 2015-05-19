<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="jgdlb.aspx.cs" Inherits="jgdlb" Title="生产日报" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
</head>
<body>
<form id="form1" runat="server" >

          <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
         </ajaxToolkit:ToolkitScriptManager>
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tb_Find_cpxh" ServicePath="../GetContent.asmx" ServiceMethod="GetKSDcpxhList"  MinimumPrefixLength="1" CompletionInterval="500" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"  TargetControlID="tb_Find_khdm" ServicePath="../GetContent.asmx" ServiceMethod="GetkhdmList" MinimumPrefixLength="1"  CompletionInterval="500" />
         <table width="800px" >
            <tr>
                <td style="height: 42px">
                  审核状态<asp:DropDownList ID="ddlHqzt" runat="server" OnSelectedIndexChanged="btnCX_Click" AutoPostBack="True" >
                     <asp:ListItem Selected="True" >未审核</asp:ListItem>
                     <asp:ListItem >全部</asp:ListItem>
                     <asp:ListItem >已审核</asp:ListItem>                 
                    </asp:DropDownList> 
                </td> 
                <td style="height: 42px">当前状态：
                </td> 
                <td style="height: 42px"><asp:DropDownList ID="DD_Find_dqzt" runat="server"  AutoPostBack="True" >
                     <asp:ListItem>商务客诉录入中</asp:ListItem>
                     <asp:ListItem>质量分析录入中</asp:ListItem>    
                     <asp:ListItem>质量经理审核中</asp:ListItem>
                     <asp:ListItem>商务材耗统计中</asp:ListItem>
                     <asp:ListItem Selected="True"></asp:ListItem>             
                    </asp:DropDownList> 
                </td>  
                <td style="height: 42px">
                    生产批次：
                </td>  
                <td style="height: 42px"><asp:TextBox id="tb_Find_khdm" runat="server" Width="110px" onchange="this.value=this.value.split('|')[0];" ></asp:TextBox>
                </td> 
                <td style="height: 42px">产品型号：
                </td>  
                <td style="height: 42px"><asp:TextBox id="tb_Find_cpxh" runat="server" Width="110px"></asp:TextBox>
                </td>    
                <td style="height: 42px; width: 63px;"><asp:Button ID="b_Find" runat="server" Text="查  询" OnClick="b_Find_Click" />
                </td>            
             </tr>
         </table>
         <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td style="height: 30px">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                         <tr >
                             <td rowspan="2" align="center" style="height: 31px" bgcolor="#FEEDC9" >
                                 <div style="margin:10px 0px;"><asp:LinkButton ID="lbTjbd" runat="server" OnClick="tjbd_Click" style="background-color:#FEEDC9;display: block ;text-align: center;color: #d84700;  font-size: 14px; font-weight: bold; text-decoration: none; " Width="120px">添加物料加工单</asp:LinkButton></div>
                             <td width="94%" rowspan="2" align="center" style="height: 31px;font-size:15px;font-weight:bold;">
                                 物料加工记录</td>
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
                             <td style="height: 199px; width: 1168px;">
                                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" style="text-align: center" EmptyDataText="无记录"
                                     Font-Names="Verdana" Font-Size="12px" AllowSorting="True" OnSorting="GridView1_Sorting"    OnRowUpdating="GridView1_RowUpdating"
                                     OnRowDeleting="GridView1_RowDeleting"  OnRowCreated="GridView1_RowCreated"   OnRowDataBound="GridView1_RowDataBound" 
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"  AllowPaging="true" PageSize="100"  OnPageIndexChanging ="GridView1_PageIndexChanging"  >
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                        <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="jgd.aspx?id={0}"
                                             DataTextField="id" HeaderText="ID"  ItemStyle-Width="5%"/>
                                         <asp:BoundField DataField="scrq" HeaderText="生产日期" DataFormatString="{0:yyyy-MM-dd}"  >
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="wlbh" HeaderText="物料编号">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="wlmc" HeaderText="物料名称">
                                             <ItemStyle Width="5%" />
                                         </asp:BoundField>
                                        <asp:BoundField DataField="pc" HeaderText="批次">
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="gys" HeaderText="供应商">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="gc" HeaderText="工厂">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="gg" HeaderText="规格">
                                             <ItemStyle Width="32%" />
                                         </asp:BoundField>
                                        <asp:TemplateField >
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton3" runat="server" CommandName ="Update"   OnClientClick='return confirm("此删除操作不可恢复，您确认删除此记录吗？")'>审核</asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderTemplate>审核</HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField >
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete"    OnClientClick='return confirm("此删除操作不可恢复，您确认删除此记录吗？")'>删除</asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderTemplate>删除</HeaderTemplate>
                                        </asp:TemplateField>

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
    </form>
    </body>
    </html>

