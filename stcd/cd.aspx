<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cd.aspx.cs" Inherits="stcd_cd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>每日菜单</title>
</head>
<body>
    <form id="form1" runat="server">
    <div  style="overflow:scroll; height:100%; width:100% ;overflow:auto; text-align :center;"  >
    <a style="font-size:35px; font-weight:900;"><asp:Label id="rq" runat="server" />日菜单</a>
        <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" style="text-align: center"
         Font-Names="Verdana" Font-Size="25px"  HeaderStyle-Font-Size="25px" RowStyle-Font-Size="25px" FooterStyle-Font-Size="25px"
         emptydatatext="无菜单信息"   align="center" ShowFooter="True"  AllowPaging="true"
         OnRowDataBound="GridView1_RowDataBound" 
         Width="600px"  PageSize="20" ForeColor="#333333" GridLines="None"   >
         <RowStyle ForeColor="#333333" BackColor="#FFFBD6" Font-Size="25px" />
         <Columns >
             <asp:BoundField DataField="cm" HeaderText="菜名" ReadOnly="True" >
                 <ItemStyle Width="50%" />
             </asp:BoundField>
             <asp:BoundField DataField="dj" HeaderText="单价" ReadOnly="True" >
                 <ItemStyle Width="25%" />
             </asp:BoundField>
             <asp:BoundField DataField="sl" HeaderText="数量" ReadOnly="True" >
                 <ItemStyle Width="25%" />
             </asp:BoundField>
         </Columns>

         <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
         <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
         <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" Font-Size="25px" />
        <FooterStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" />
        <AlternatingRowStyle BackColor="White" />
     </asp:GridView>
    <table width="600px" align="center" >
        <tr>
            <td style="width:35%" align="center"><asp:Button ID="B_qyt"  runat="server" Text="前一天菜单" Height="30px" Font-Size="20px" f OnClick="B_qyt_Click"/></td>
            <td style="width:30%" align="center"><asp:Button ID="B_bz"  runat="server" Text="本周菜单" Height="30px" Font-Size="20px" OnClick="B_bz_Click"/></td>
            <td style="width:35%" align="center"><asp:Button ID="B_hyt"  runat="server" Text="后一天菜单" Height="30px" Font-Size="20px" OnClick="B_hyt_Click"/></td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
