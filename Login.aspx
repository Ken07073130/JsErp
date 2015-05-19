<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统登录</title>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<%--<Script language="Javascript">resizeTo(1292,800);</script> --%>
<script type="text/javascript" src="js/js.js"></script>
<style type="text/css">
<!--
body {
	background-image: url(images/login_03.gif);
}
a:link {color: ButtonShadow}               
a:visited {color: ButtonShadow}           
a:hover {color: ButtonShadow}            
a:active {color: ButtonShadow} 
-->
</style></head>
<body>
<form id="form1" runat="server"  >
<table width="847" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td  height="318" colspan="5" background="images/login_04.gif">&nbsp;</td>
  </tr>
  <tr>
    <td width="381" background="images/login_06.gif" align="center" style="height: 84px"></td>
    <td width="162" background="images/login_07.gif" style="height: 84px">    
	<table width="160"  border="0" cellspacing="0" cellpadding="0">
	<tr>
    <td height="8" >        </td>
  </tr>
  <tr>
    <td height="30" >  <label>用户名：
        <asp:TextBox   ID="txt_username"  runat="server" />
        </label>
	</td>
  </tr>
  <tr>
    <td style="height: 30px" > <label>密　码：
       <asp:TextBox    ID="txt_pwd"  runat="server" TextMode="Password" />
        </label></td>
  </tr>
  <tr>
    <td height="15" >        <asp:Label ID="msg" runat="server" Font-Bold="True" Font-Size="8pt"/></td>
  </tr>
</table>

	
	

      </td>
    <td width="26" background="images/login_08.gif" style="height: 84px">&nbsp;</td>
    <td width="67" background="images/login_09.gif" style="height: 84px">
	<table width="60" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><asp:ImageButton  ImageUrl ="images/dl.gif" width="57" height="20" Id="Button1" Onclick="Login_Click" Runat="Server"    /> </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img src="images/cz.gif" width="57" height="20" onclick="form_reset()"> </td>
  </tr>
</table>

	
</td>
    <td width="211" background="images/login_10.gif" style="text-align: left; height: 84px;">&nbsp; &nbsp;&nbsp; &nbsp;<asp:HyperLink  target="_blank" ImageUrl="images/cd.png"  ID="HL_stcd" runat="server"  Text="今日菜单" NavigateUrl="stcd/cd.aspx" Font-Size="30px" BorderColor="white"></asp:HyperLink></td>
  </tr>
  <tr>
    <td height="206" colspan="5" background="images/login_11.gif" style="text-align: center; vertical-align:top">
    <br />
    <br />
    <br />
    <br />
    <a href="http://192.186.10.6" style =" font-size:x-large; font-weight:900; color:ButtonShadow;">富通集团OA</a>
        
    </td>
  </tr>
</table>
</form>
</body>
</html>


