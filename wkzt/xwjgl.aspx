<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="xwjgl.aspx.cs" Inherits="wkzt_xwjgl" Title="�Ŀع���-���ļ����" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>��ɫ��Դ����ϵͳ</title>
</head>
<body>
<form id="form1" runat="server" >

 <div align="center">

 
<table width="800" border="0" cellpadding="0"   cellspacing="1" bgcolor="#000000"  height="302"  align="center" >
  <tr bgcolor="#ffffff">
    <td height="25" align="center" style="width: 200px"  ><strong>�ļ���Ŀ¼</strong></td>
    <td rowspan="4" align="center" >       
    
    <asp:Panel runat="server" ID="panel1"  Height ="100%" Width ="100%"  ScrollBars="Auto" BorderStyle="Solid" BorderWidth="1" BorderColor="CadetBlue">
        <asp:CheckBoxList  ID="ListBox1" DataTextField="Name" DataValueField="FullName"       
          runat="server"  Width ="600px" >
          </asp:CheckBoxList>
          </asp:Panel></td>
  </tr>

  <tr bgcolor="#ffffff">
    <td style="width: 200px" align="left"  >
    
        <asp:TreeView ID="TreeView1" runat="server" ImageSet="Arrows" Width="190px" Height="500px"     onselectednodechanged="TreeView1_SelectedNodeChanged">
            <ParentNodeStyle Font-Bold="False" />
            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"
                VerticalPadding="0px" />
            <NodeStyle Font-Names="Tahoma" Font-Size="10pt" ForeColor="Black" HorizontalPadding="5px"
                NodeSpacing="0px" VerticalPadding="0px" />
        </asp:TreeView>
    
    </td>
  </tr>
    <tr bgcolor="#ffffff">
        <td align="center" style="width: 200px">
        <asp:RadioButtonList   ID="RadioButton1" runat="server" RepeatDirection="Horizontal"  OnSelectedIndexChanged="RodioChange" AutoPostBack ="true" >
            <asp:ListItem  Value="�����¼��ļ�"  Selected ="True" >�¼��ļ�</asp:ListItem>
            <asp:ListItem Value="����ɾ���ļ�"  >ɾ���ļ�</asp:ListItem>
        </asp:RadioButtonList> 
        </td>
    </tr>
      <tr bgcolor="#ffffff">
        <td align="center" style="width: 200px">
            <asp:Button ID="B_JT" runat="server" Text="��  ��" OnClick="B_JT_Click" />
        </td>
    </tr>
  
</table>   
</div> 
</form>
</body>
</html>

