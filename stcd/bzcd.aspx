<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bzcd.aspx.cs" Inherits="stcd_bzcd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>每日菜单</title>
</head>
<body>
    <form id="form1" runat="server">
    <div  style="overflow:scroll; height:100%; width:100% ;overflow:auto; text-align :center;"  >
    <a style="font-size:35px; font-weight:900;">本周日菜单</a>
        <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" style="text-align: center"
         Font-Names="Verdana" Font-Size="20px"  HeaderStyle-Font-Size="15px" RowStyle-Font-Size="15px" FooterStyle-Font-Size="15px"
         emptydatatext="无菜单信息"   align="center" ShowFooter="false"  AllowPaging="true"
         OnRowDataBound="GridView1_RowDataBound" 
         Width="1000px"  PageSize="20" ForeColor="#333333" GridLines="None"   >
         <RowStyle ForeColor="#333333" BackColor="#FFFBD6" Font-Size="15px" />
         <Columns >
            <asp:TemplateField  >
            <ItemStyle Width="5%" />
            </asp:TemplateField>
             <asp:BoundField DataField="z1" HeaderText="周一" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px" />
             </asp:BoundField>
             <asp:BoundField DataField="z2" HeaderText="周二" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px"  />
             </asp:BoundField>
             <asp:BoundField DataField="z3" HeaderText="周三" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px"  />
             </asp:BoundField>
             <asp:BoundField DataField="z4" HeaderText="周四" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px"  />
             </asp:BoundField>
             <asp:BoundField DataField="z5" HeaderText="周五" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px" />
             </asp:BoundField>
             <asp:BoundField DataField="z6" HeaderText="周六" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px"  />
             </asp:BoundField>
         </Columns>

         <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
         <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
         <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" Font-Size="20px" />
        <FooterStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" />
        <AlternatingRowStyle BackColor="White" />
     </asp:GridView>
     <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" style="text-align: center"
         Font-Names="Verdana" Font-Size="20px"  HeaderStyle-Font-Size="15px" RowStyle-Font-Size="15px" FooterStyle-Font-Size="15px"
         emptydatatext="无菜单信息"   align="center" ShowFooter="false"  AllowPaging="true" ShowHeader="false"
         OnRowDataBound="GridView1_RowDataBound" 
         Width="1000px"  PageSize="20" ForeColor="#333333" GridLines="None"   >
         <RowStyle ForeColor="#333333" BackColor="#FFFBD6" Font-Size="15px" />
         <Columns >
             <asp:BoundField DataField="lx"  ReadOnly="True" >
                 <ItemStyle Width="5%" Height="30px" />
             </asp:BoundField>
             <asp:BoundField DataField="z1" HeaderText="周一" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px" />
             </asp:BoundField>
             <asp:BoundField DataField="z2" HeaderText="周二" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px"  />
             </asp:BoundField>
             <asp:BoundField DataField="z3" HeaderText="周三" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px"  />
             </asp:BoundField>
             <asp:BoundField DataField="z4" HeaderText="周四" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px"  />
             </asp:BoundField>
             <asp:BoundField DataField="z5" HeaderText="周五" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px" />
             </asp:BoundField>
             <asp:BoundField DataField="z6" HeaderText="周六" ReadOnly="True" >
                 <ItemStyle Width="15%" Height="30px"  />
             </asp:BoundField>
         </Columns>

         <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
         <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
         <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" Font-Size="20px" />
        <FooterStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" />
        <AlternatingRowStyle BackColor="White" />
     </asp:GridView>
    </div>
    </form>
</body>
</html>
