<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="zjgx.aspx.cs" Inherits="wkzt_zjgx" Title="�Ŀع���-��������ļ�" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>��ɫ��Դ����ϵͳ</title>
</head>
<body>
<form id="form1" runat="server" >

 <div align="center">
     <table >
    <tr style="height :30px"  >
    <td align ="left" >
    <strong>���5�췢���ļ�</strong> 
    </td>
    </tr>
    </table>
        <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
             Font-Names="Verdana" Font-Size="12px" 
             emptydatatext="�޼�¼"  
             Width="800px" GridLines="Horizontal"   AllowPaging="True"  EmptyDataRowStyle-BackColor="#40e0d0" OnPageIndexChanging ="GridView1_PageIndexChanging" 
             BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"  >
             <Columns >
                    <asp:TemplateField  HeaderText= "���" >
                    <ItemTemplate  >
                        <%#   Container.DataItemIndex   +   1%>
                   </ItemTemplate>
                    <ItemStyle Width="5%" Wrap="False" HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="����" >
                    <ItemTemplate  >
                         <asp:LinkButton  ID="LinkButton1" runat="server"   CommandArgument='<%# Eval("FullName") %>' Text='<%# Eval("FileName") %>' OnClick ="LinkButton1_Click"></asp:LinkButton> 
                    </ItemTemplate>
                    <ItemStyle Width="75%"  HorizontalAlign ="Left" />
                </asp:TemplateField>
                 

                 <asp:BoundField DataField="InDate" HeaderText="����ʱ��"  >
                     <ItemStyle Width="20%" />
                 </asp:BoundField>

               
             </Columns>
              
            <EmptyDataRowStyle BackColor="Turquoise" />
            <FooterStyle BackColor="White" ForeColor="#006699" />
            <RowStyle ForeColor="#333333" BackColor="White" />
            <PagerStyle BackColor="#006699" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
         </asp:GridView>
    <table >
        <tr style="height :30px" >
        <td align ="left" >
        <strong>���5�������ļ�</strong> 
        </td>
    </tr>
    </table>
     <asp:GridView ID="GridView2" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
             Font-Names="Verdana" Font-Size="12px" 
             emptydatatext="�޼�¼"  OnPageIndexChanging ="GridView2_PageIndexChanging"  
             Width="800px" GridLines="Horizontal"   AllowPaging="True"  EmptyDataRowStyle-BackColor="#40e0d0" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" >
             <RowStyle BackColor="White" ForeColor="#333333" />
             <Columns >
                    <asp:TemplateField  HeaderText= "���" >
                    <ItemTemplate  >
                        <%#   Container.DataItemIndex   +   1%>
                   </ItemTemplate>
                    <ItemStyle Width="5%" Wrap="False" HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="����" >
                    <ItemTemplate  >
                         <asp:LinkButton  ID="LinkButton1" runat="server"   CommandArgument='<%# Eval("FullName") %>' Text='<%# Eval("FileName") %>' OnClick ="LinkButton1_Click"></asp:LinkButton> 
                    </ItemTemplate>
                    <ItemStyle Width="75%"  HorizontalAlign ="Left" />
                </asp:TemplateField>
                 

                 <asp:BoundField DataField="InDate" HeaderText="����ʱ��"  >
                     <ItemStyle Width="20%" />
                 </asp:BoundField>

               
             </Columns>
              
             <FooterStyle BackColor="White" ForeColor="#006699" />
             <PagerStyle BackColor="#006699" ForeColor="White" HorizontalAlign="Center" />
             <SelectedRowStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
             <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <EmptyDataRowStyle BackColor="Turquoise" />
         </asp:GridView>
</div>
</form>
</body>
</html>

