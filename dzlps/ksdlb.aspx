<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="ksdlb.aspx.cs" Inherits="ksdlb" Title="���ߵ���Ϣ�б�" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >
<title>��ɫ��Դ����ϵͳ</title>
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
         <table width="800px" style="font-size:smaller" >
            <tr>
                <td style="height: 42px">
                  ��ǩ״̬<asp:DropDownList ID="ddlHqzt" runat="server" OnSelectedIndexChanged="btnCX_Click" AutoPostBack="True" >
                     <asp:ListItem Selected="True">��ǩ��</asp:ListItem>
                     <asp:ListItem>ȫ��</asp:ListItem>
                     <asp:ListItem>�ѻ�ǩ</asp:ListItem>                 
                    </asp:DropDownList> 
                </td> 
                <td style="height: 42px">��ǰ״̬��
                </td> 
                <td style="height: 42px"><asp:DropDownList ID="DD_Find_dqzt" runat="server"  AutoPostBack="True" >
                     <asp:ListItem>�������¼����</asp:ListItem>
                     <asp:ListItem>��������¼����</asp:ListItem>    
                     <asp:ListItem>�������������</asp:ListItem>
                     <asp:ListItem>����ĺ�ͳ����</asp:ListItem>
                     <asp:ListItem Selected="True"></asp:ListItem>             
                    </asp:DropDownList> 
                </td>  
                <td style="height: 42px">�ͻ����룺
                </td>  
                <td style="height: 42px"><asp:TextBox id="tb_Find_khdm" runat="server" Width="110px" onchange="this.value=this.value.split('|')[0];" ></asp:TextBox>
                </td> 
                <td style="height: 42px">��Ʒ�ͺţ�
                </td>  
                <td style="height: 42px"><asp:TextBox id="tb_Find_cpxh" runat="server" Width="110px"></asp:TextBox>
                </td>    
                <td style="height: 42px"><asp:Button ID="b_Find" runat="server" Text="��  ѯ" OnClick="b_Find_Click" />
                </td>            
             </tr>
         </table>
         <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td style="height: 30px">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                         <tr >
                             <td rowspan="2" align="center" style="height: 31px" bgcolor="#FEEDC9" >
                                 <div style="margin:10px 0px;"><asp:LinkButton ID="lbTjbd" runat="server" OnClick="tjbd_Click" style="background-color:#FEEDC9;display: block ;text-align: center;color: #d84700;  font-size: 14px; font-weight: bold; text-decoration: none; " Width="120px">����¿��ߵ�</asp:LinkButton></div>
                             <td width="94%" rowspan="2" align="center" style="height: 31px;font-size:15px;font-weight:bold;">����Ͷ�ߴ���</td>
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
                                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" style="text-align: center"
                                     Font-Names="Verdana" Font-Size="12px" AllowSorting="True" OnSorting="GridView1_Sorting"
                                     OnRowDeleting="GridView1_RowDeleting"  OnRowCreated="GridView1_RowCreated"   OnRowDataBound="GridView1_RowDataBound" 
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"  AllowPaging="true" PageSize="20"  OnPageIndexChanging ="GridView1_PageIndexChanging"  >
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                     <asp:HyperLinkField DataNavigateUrlFields="djlsh" DataNavigateUrlFormatString="ksdAjax.aspx?lb=Edite&hqzt='<%= ddlHqzt.text%>'&xh={0}"
                                             DataTextField="tsbh" HeaderText="Ͷ�߱��"  ItemStyle-Width="9%"/>
                                         <asp:BoundField DataField="dqzt" HeaderText="��ǰ״̬" ReadOnly="True"  >
                                             <ItemStyle Width="9%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="dyzt" HeaderText="��ӡ״̬">
                                             <ItemStyle Width="6%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="cpph" HeaderText="��Ʒ����">
                                             <ItemStyle Width="15%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="thsl" HeaderText="�˻�����" >
                                             <ItemStyle Width="5%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="sdthrq" HeaderText="�յ��˻�����" DataFormatString="{0:yyyy-MM-dd}"  >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="khdm" HeaderText="�ͻ�����">
                                             <ItemStyle Width="9%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="cpxh" HeaderText="��Ʒ�ͺ�">
                                             <ItemStyle Width="18%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="chsl" HeaderText="��������">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="chrq"  HeaderText="��������" DataFormatString="{0:yyyy-MM-dd}"  >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                          <asp:TemplateField >
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete"    OnClientClick='return confirm("��ɾ���������ɻָ�����ȷ��ɾ���˼�¼��")'>ɾ��</asp:LinkButton>
                                            </ItemTemplate>
                                                <HeaderTemplate  >ɾ��</HeaderTemplate>
                                           </asp:TemplateField>

                                     </Columns>
                                      <PagerTemplate>
                                           <table style="font-size :12px;">
                                           <tr>
                                        
                                             <td> �ܹ�<asp:Label ID="Label1" runat="server" Text="<%#((GridView)Container.NamingContainer).PageCount %>"></asp:Label>ҳ &nbsp; </td>
                                            
                                                <td> ��<asp:Label ID="Label2" runat="server" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"></asp:Label>ҳ &nbsp;</td>
                                             
                                                      <td> <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument ="1" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">��ҳ</asp:LinkButton> &nbsp;</td>
                                                      <td>
                                                          <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument ="Prev" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">��һҳ</asp:LinkButton> &nbsp;</td>
                                                          <td>
                                                              <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument ="Next" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">��һҳ </asp:LinkButton> &nbsp;</td>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton4" runat="server" CommandArgument ="Last" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">βҳ</asp:LinkButton> &nbsp;</td>
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

