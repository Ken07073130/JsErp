﻿<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="tjwj.aspx.cs" Inherits="wkzt_tjwj" Title="文控管理-新文件添加" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
</head>
<body>
<form id="form1" runat="server" >

<asp:ScriptManager ID="ScriptManager1" runat="server" />
 <div align="center">
    <table width="800" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="110" style="height: 12px">
            <span style="display: inline! important; float: none; word-spacing: 0px; font: 12px Verdana;
                text-transform: none; color: rgb(51,51,51); text-indent: 0px; white-space: normal;
                letter-spacing: normal; background-color: rgb(255,255,255); text-align: left;
                orphans: auto; widows: auto; webkit-text-stroke-width: 0px">新加文件提醒：</span>&nbsp;</td>
        <td width="230" style="height: 12px">       
            <asp:RadioButtonList   ID="RadioButton1" runat="server" RepeatDirection="Horizontal"  OnSelectedIndexChanged="RodioChange" AutoPostBack ="true" >
            <asp:ListItem  Value="今日新加文件"  Selected ="True" >新加文件</asp:ListItem>
            <asp:ListItem Value="今日删除文件"  >删除文件</asp:ListItem>
            </asp:RadioButtonList> 
        </td>
        <td width="230" style="height: 12px">&nbsp;</td>
        <td width="230" style="height: 12px">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td style="height: 12px"><asp:ListBox ID="LB_cs1" runat="server"  Height="200" Width="110" AutoPostBack="true" OnSelectedIndexChanged="LB_cs1_SelectedIndexChanged" ></asp:ListBox></td>
        <td style="height: 12px"><asp:ListBox ID="LB_cs2" runat="server"  Height="200" Width="231" AutoPostBack="true" OnSelectedIndexChanged="LB_cs2_SelectedIndexChanged" ></asp:ListBox></td>
        <td style="height: 12px"><asp:ListBox ID="LB_cs3" runat="server"  Height="200" Width="231" AutoPostBack="true" OnSelectedIndexChanged="LB_cs3_SelectedIndexChanged" ></asp:ListBox></td>
        <td style="height: 12px"><asp:ListBox ID="LB_cs4" runat="server"  Height="200" Width="231" AutoPostBack="true" OnSelectedIndexChanged="LB_cs4_SelectedIndexChanged" ></asp:ListBox></td>
      </tr>
      <tr>
        <td colspan="4">       
            <asp:Panel runat="server" ID="panel1"  Height ="200" Width ="800"  ScrollBars="Auto" BorderStyle="Solid" BorderWidth="1" BorderColor="CadetBlue" HorizontalAlign="Left">
                <asp:CheckBoxList  ID="CLB_Files" DataTextField="Name" DataValueField="FullName"  runat="server"  Width ="780" >
                </asp:CheckBoxList>
            </asp:Panel>
        </td>
      </tr>
      <tr>
    <td  colspan="4" >
        <asp:Button ID="Button1" runat="server" Text="提  交" OnClick="Button1_Click" />
            <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="Button1" ConfirmText="确定要提交吗？" ConfirmOnFormSubmit="true"  />
        <br />
        BOM导入提醒添加：<br />
        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 型号<asp:TextBox ID="tbXh" runat="server"></asp:TextBox><ajaxToolkit:AutoCompleteExtender id="AutoCompleteExtender1" runat="server" TargetControlID="tbXh" ServicePath="~/GetContent.asmx" ServiceMethod="GetDxxhList" MinimumPrefixLength="1" CompletionInterval="200">
                        </ajaxToolkit:AutoCompleteExtender>&nbsp;
        定额版本<asp:TextBox ID="tbDebb" runat="server"></asp:TextBox>
        提醒人<asp:DropDownList ID="ddlTxr" runat="server" DataSourceID="SqlDataSource1"
            DataTextField="UserName" DataValueField="UserID">
        </asp:DropDownList>&nbsp;<asp:Button ID="Button2" runat="server" OnClick="Button2_Click"
            Text="添加提醒" />&nbsp;<br />
        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:Label ID="lblLog" runat="server" Font-Size="10pt" Width="640px"></asp:Label><br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatebaseConnection %>"
            SelectCommand="SELECT [UserName], [UserID] FROM [STUsers]  where OID in (select convert(varchar(50),UserID) from dbo.STUserGroup where GroupID=643)"></asp:SqlDataSource>
       
    </td>

      </tr>
    </table>
</div> 
</form>
</body>
</html>

