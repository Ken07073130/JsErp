<%@ Page Language="C#" AutoEventWireup="true" CodeFile="yhgl.aspx.cs" Inherits="wkzt_yhgl" Title="�Ŀع���-�û�Ȩ�޹���" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>��ɫ��Դ����ϵͳ</title>
</head>
<body>
<form id="form1" runat="server" >
 <div align="center">
 <p style=" font-size :large; font-weight :bold  ">�û�Ȩ�޹���</p> 
    <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
         Font-Names="Verdana" Font-Size="12px"    emptydatatext="�޼�¼"  
         Width="800px" GridLines="Horizontal" 
          OnRowEditing="GridView1_RowEditing" 
         AllowPaging="True"  PageSize="35"     EmptyDataRowStyle-BackColor="#40e0d0" OnPageIndexChanging ="GridView1_PageIndexChanging"  
         BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
         >
         <Columns >
            <asp:BoundField DataField="OID" HeaderText="ID" >
                 <ItemStyle Width="5%" />
             </asp:BoundField>
             <asp:BoundField DataField="UserID" HeaderText="�û���" >
                 <ItemStyle Width="15%"   />
             </asp:BoundField>
             <asp:BoundField DataField="UserName" HeaderText="����" >
                 <ItemStyle Width="20" />
             </asp:BoundField>
             <asp:BoundField DataField="wkqx" HeaderText="Ȩ��" >
                 <ItemStyle Width="45%"  />
             </asp:BoundField>
            <asp:CommandField HeaderText="�޸�" ShowEditButton="True">
                 <ItemStyle Width="5%" />
             </asp:CommandField>

           
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
