<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchFile.aspx.cs" Inherits="wkzt_SearchFile" Title="文控管理—搜索结果" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >

<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
</head>
<body>
<form id="form1" runat="server" >
     <div align="center">
        <asp:HiddenField ID="OldID" runat ="server" />
        <asp:HiddenField ID="WJCC" runat ="server" />
        <asp:HiddenField ID="UserID" runat ="server" />
        <table width="800px">
            <tr>
                <td style=" text-align:center; " >

                    
                </td>
                 <td valign="bottom" class="STYLE1" style="height: 20px">
                <div align="right">  <asp:TextBox runat="server" ID ="SearchName"></asp:TextBox><asp:Button ID="SearchButton"  runat="server" OnClick="SearchClick" Text="搜 索"/>&nbsp;&nbsp;&nbsp;</div></td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
             Font-Names="Verdana" Font-Size="12px" 
             emptydatatext="无记录"  
             Width="800px" GridLines="Horizontal"  EmptyDataRowStyle-BackColor="#40e0d0" OnRowCommand="GridView1_RowCommand"  
             BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" 
              >
             <Columns >
                 <asp:TemplateField HeaderText="名称" >
                    <ItemTemplate  >
                         <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("ImgURL") %>' />
                         <asp:LinkButton  ID="LinkButton1" runat="server"  CommandName="wjlj"   CommandArgument='<%# Eval("FullName") %>' Text='<%# Eval("mc") %>' ></asp:LinkButton> 
                    </ItemTemplate>
                    <ItemStyle Width="60%"  HorizontalAlign ="Left" />
                </asp:TemplateField>
                
                 <asp:BoundField DataField="xz" HeaderText="下载" >
                     <ItemStyle Width="5%"   />
                 </asp:BoundField>
                 <asp:BoundField DataField="gxrq" HeaderText="更新日期" >
                     <ItemStyle Width="20%" />
                 </asp:BoundField>
                 <asp:BoundField DataField="dx" HeaderText="大小" >
                     <ItemStyle Width="5%"  />
                 </asp:BoundField>

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

