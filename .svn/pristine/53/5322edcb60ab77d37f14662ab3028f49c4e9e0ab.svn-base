<%@ Page Language="C#" validateRequest="false"  AutoEventWireup="true" CodeFile="AddGGL.aspx.cs" Inherits="AddGGL" Title="系统通知管理" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
<script charset="utf-8" src="editor/kindeditor.js"></script>
<script charset="utf-8" src="editor/lang/zh_CN.js"></script>
    <script>
        KindEditor.ready(function(K) {
                window.editor = K.create('#'+'<%= editor_id.ClientID %>');
         });
    </script>
    <style type="text/css">
    <!--
    .T_Sample {
      border-collapse: collapse;
      border: none;
      background: #FFFFFF;
    }
    .T_Sample th {
      border: solid 1px #707070;
    }
    .T_Sample td {
      border: solid 1px #707070;
    }
    -->
    </style>
</head>
<body>
<form id="form1" runat="server" >
<div style="overflow:scroll; height:100%; width:100% ;overflow:auto;" align="center">
    <asp:HiddenField ID="HF_ID" runat="server" />
<table width="700" style="text-align:center; font-size:18px; " border="1" cellpadding="2" cellspacing="0" class="T_Sample">
  <tr>
    <td colspan="2">通知管理</td>
  </tr>
  <tr>
    <td width="100">通知标题：</td>
    <td>
        <asp:TextBox ID="TB_tzbt" runat="server" Width="600px"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td colspan="2">
        <asp:TextBox  id="editor_id"  runat="server"   name="content" style="width:700px;height:400px;">
        </asp:TextBox >
    </td>
  </tr>
  <tr>
    <td colspan="2"><asp:Button ID="B_TJ" runat="server" Text="提  交" OnClick="B_TJ_Click" /></td>
  </tr>
</table>
</div>
    </form>
    </body>
    </html>

