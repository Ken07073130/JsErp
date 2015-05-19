<%@ Page Language="C#" AutoEventWireup="true" CodeFile="controlRefEdit.aspx.cs" Inherits="controlRefEdit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
         <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
         </ajaxToolkit:ToolkitScriptManager>
         <div>
<div style="height:40px; width:800px;text-align:center; font-size:20px; font-weight:bold;line-height:40px;">字段对照设置</div>  
<div style="height:40px; width:800px;"><label style="float:left;width:125px;text-align:right;font-size:14px;"> 单据名称：</label>
    <asp:TextBox ID="tbDjmc" runat="server" Width="50%"></asp:TextBox></div>
<div style="height:40px; width:800px;"><label style="float:left;width:125px;text-align:right;font-size:14px;">类型：</label>
    <asp:DropDownList ID="ddlLx"
        runat="server" Width="50%">
        <asp:ListItem>TEXTBOX</asp:ListItem>
        <asp:ListItem>CHECKBOX</asp:ListItem>
        <asp:ListItem>DROPDOWNLIST</asp:ListItem>
        <asp:ListItem>CHECKBOXLIST</asp:ListItem>
    </asp:DropDownList></div>
<div style="height:40px; width:800px;"><label style="float:left;width:125px;text-align:right;font-size:14px;">控件名称：</label>
    <asp:TextBox ID="tbMc" runat="server" Width="50%"></asp:TextBox></div>
<div style="height:40px; width:800px;"><label style="float:left;width:125px;text-align:right;font-size:14px;">权限：</label> 
    <asp:TextBox ID="tbQx" runat="server" Width="50%"></asp:TextBox></div>
<div style="height:40px; width:800px;">
    <label style="float:left;width:125px;text-align:right;font-size:14px;">字段：</label> 
    <asp:TextBox ID="tbZd" runat="server" Width="50%"></asp:TextBox></div>
             <br />
             <div>
             <label style="float:left;width:125px;text-align:right;font-size:14px;">&nbsp</label> 
             <asp:ImageButton  ImageUrl ="~/images/btnSubmit.jpg"  Id="iBtnOK" Onclick="btnTj_Click" Runat="Server"   />
             </div>
             <br />
             <asp:HiddenField ID="fileName" runat="server" />
             <br />

             &nbsp;&nbsp;
             </div>
        
    </div>
    </form>
</body>
</html>
