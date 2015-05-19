<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="UserEdit.aspx.cs" Inherits="UserEdit" Title="用户信息修改" %>
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
                                     <span class="STYLE1">用户密码修改</span></td>
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
 <table align="center" border="0" cellpadding="0" cellspacing="0" height="200" width="400">
     <tr>
         <td align="center" colspan="2" style="font-weight: bold; font-size: 26px; font-family: 宋体, 微软雅黑;
             height: 14px">
         </td>
     </tr>
         <tr>
             <td colspan="2" style="height: 14px; font-weight: bold; font-size: 26px; font-family: 宋体, 微软雅黑;" align="center">
                 用户密码修改</td>
         </tr>
     <tr>
         <td align="right" width="200" style="height: 15px">
         </td>
         <td width="200">
         </td>
     </tr>
         <tr>
             <td width="200" align="right" style="height: 30px" >
                 ID &nbsp; &nbsp; &nbsp;&nbsp; ：
             </td>
             <td width="200">
                 &nbsp;<asp:Label ID="L_ID" runat="server" Text="Label"></asp:Label></td>
         </tr>
         <tr>
             <td  align="right" style="height: 30px">
                 姓 &nbsp;&nbsp; 名：
             </td>
             <td style="height: 30px">
                 &nbsp;<asp:Label ID="L_Name" runat="server" Text="Label"></asp:Label></td>
         </tr>
         <tr>
             <td  align="right" style="height: 30px" >
                     旧密码：
             </td>
             <td style="height: 30px">
                 &nbsp;<asp:TextBox ID="T_OldPwd" runat="server" TextMode="Password"  ></asp:TextBox></td>
         </tr>
         <tr>
             <td align="right" style="height: 30px" >
                     新密码：
             </td>
             <td>
                 &nbsp;<asp:TextBox ID="T_NewPwd" runat="server" TextMode="Password"  ></asp:TextBox></td>
         </tr>
         <tr>
             <td  align="right" style="height: 30px">
                     验证密码：
             </td>
             <td>
                 &nbsp;<asp:TextBox ID="T_CheckPwd" runat="server" TextMode="Password" ></asp:TextBox>
                 </td>
         </tr>
          <tr>
             <td  align="right" style="height: 30px">
                     手机号码：
             </td>
             <td>
                 &nbsp;<asp:TextBox ID="T_PhoneNo" runat="server" ></asp:TextBox>
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="请输入正确的手机号码"
                   Display="Dynamic" ValidationExpression="^[1]+[3,5,8]+\d{9}" ControlToValidate="T_PhoneNo"></asp:RegularExpressionValidator></td>
         </tr>
          <tr>
             <td  align="right" style="height: 29px">
                    
             </td>
             <td style="height: 29px">
                 <asp:Button ID="save" runat="server" Text="保存" Height="21px" Width="68px" OnClick="save_Click" /></td>
         </tr>
     </table>

 </form>
</body>
</html>

