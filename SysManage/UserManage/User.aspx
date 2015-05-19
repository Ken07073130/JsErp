<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="User.aspx.cs" Inherits="User" Title="用户权限查看" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
</head>
<body>
<form id="form1" runat="server" >
  <table border="0" cellpadding="0" cellspacing="0" width="100%" >
     <tr>
         <td bgcolor="#353c44" style="height: 24px">
             <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                     <td>
                         <table border="0" cellpadding="0" cellspacing="0" width="100%">
                             <tr>
                                 <td height="19" valign="bottom" width="6%">
                                     <div align="center">
                                         <img height="14" src="images/tb.gif" width="14" /></div>
                                 </td>
                                 <td valign="bottom" width="94%">
                                     <span class="STYLE1">用户信息</span></td>
                             </tr>
                         </table>
                     </td>
                     <td>
                         <div align="right">
                             <span class="STYLE1">&nbsp;<asp:ImageButton ID="tjbd" runat="Server" Height="10" OnClick="tjbd_Click"
                                     src="images/add.gif" Width="10" />
                                 添加 &nbsp;
                                 <img height="10" src="images/del.gif" width="10" />
                                 删除 &nbsp;
                                 <img height="10" src="images/edit.gif" width="10" />
                                 编辑 &nbsp;</span><span class="STYLE1"> &nbsp;</span></div>
                     </td>
                 </tr>
             </table>
         </td>
     </tr>
 </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" 
        width="400">
        
        
        
        <tr>
            <td style="width: 200px; height: 15px">
            </td>
            <td width="200">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-weight: bold; font-size: 26px; height: 30px; text-align: center">
                用户信息</td>
        </tr>
        <tr>
            <td style="width: 200px; height: 15px">
            </td>
            <td width="200">
            </td>
        </tr>
        <tr>
            <td style="height: 30px; width: 200px;">
                <div align="right">
                    ID &nbsp; &nbsp;&nbsp; &nbsp;：
                </div>
            </td>
            <td width="200" style="height: 30px">
                <asp:Label ID="L_ID" runat="server" Text=""></asp:Label></td>
        </tr>
        <tr>
            <td style="height: 30px; width: 200px;">
                <div align="right">
                    用户名：</div>
            </td>
            <td>
                <asp:Label ID="L_Name" runat="server" Text=""></asp:Label></td>
        </tr>
        <tr>
            <td style="height: 30px; width: 200px;">
                <div align="right" >
                    描 &nbsp;&nbsp; 述：</div>
            </td>
            <td style="height: 30px">
                <asp:Label ID="L_ms" runat="server" Text=""></asp:Label></td>
        </tr>
        <tr>
            <td style="height: 30px; width: 200px;">
                <div align="right">
                    所属角色：</div>
            </td>
            <td>
                <asp:CheckBoxList ID="C_Group" runat="server" >
                </asp:CheckBoxList>
            </td>
        </tr>
        &nbsp;
                &nbsp;
    </table>
  
 </form>
</body>
</html>

