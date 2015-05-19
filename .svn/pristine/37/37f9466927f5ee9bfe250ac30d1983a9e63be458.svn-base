<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jxkh_bmlr.aspx.cs" Inherits="jxkh_bmlr" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

<link rel="stylesheet" href="../jquery-ui/themes/base/jquery.ui.all.css">
<script src="../jquery-ui/jquery-1.10.2.js"></script>
<script src="../jquery-ui/ui/jquery.ui.core.js"></script>
<script src="../jquery-ui/ui/jquery.ui.widget.js"></script>
<script src="../jquery-ui/ui/jquery.ui.tabs.js"></script>
<link rel="stylesheet" href="../jquery-ui/demos.css">

<style type="text/css">
/* CSS Document */
body {
    font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    color: #4f6b72;
    background: #E6EAE9;
}
a {
    color: #c75f3e;
}
.mytable {
    padding: 0;
    margin: 0;
}
caption {
    padding: 0 0 5px 0;
    width: 700px; 
    font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    text-align: right;
}
th {
    font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    color: #333333;
    border-right: 1px solid #E6EAE9;
    border-bottom: 1px solid #E6EAE9;
    border-top: 1px solid #E6EAE9;
    letter-spacing: 2px;
    text-transform: uppercase;
    text-align: center;

    background: #E6EAE9;
}
th.nobg {
    border-top: 0;
    border-left: 0;
    border-right: 1px solid #E6EAE9;
    background: none;
}
td {
    border-right: 1px solid #E6EAE9;
    border-bottom: 1px solid #E6EAE9;
    border-top: 1px solid #E6EAE9;
    /*background: #fff;*/
    font-size:11px;
    text-align: center;
    color: #333333;
}

.hover{
    cursor:pointer;
    background-color:#bcd4ec;  
   
}   /*这里是鼠标经过时的颜色*/ 
</style>
    <title>极片生产日报</title>
</head>

<body style="text-align: center" >
<script type ="text/javascript"  >
 
        
    $(function() {
		$( "#tabs" ).tabs();
	});    
        

</script>
    <form id="form1" runat="server">
        <table style="width: 720px" align="center">
            <tr>
                <td style="width:33%">
                    <a href="jxkh_bmlr_lb.aspx">考核信息配置</a></td>
                <td style="width:33%">
                </td>
                <td style="width:33%"><a href="jxkh_khjg_lb.aspx">考核成绩</a>
                </td>
            </tr>
        </table>
        &nbsp; &nbsp;&nbsp;
        <br />

 <h1  style=" margin-top:10px">
                    考核信息录入<asp:DropDownList ID="DDL_KJYM" runat="server" Font-Size="25px"  OnTextChanged="DDL_KJYM_OnTextChanged"  AutoPostBack="true" >
     </asp:DropDownList></h1>
                    <div align="center"  style="width:100%;">
<div id="tabs" style="width:800px;" align="center">
	<ul>
	    <li id="#bq_sbb"><a href="#tabs-sbb">设备部</a></li>
		<li id="#bq_gcb"><a href="#tabs-gcb">工程部</a></li>
		<li id="#bq_zlb"><a href="#tabs-zlb">质量部</a></li>
		<li id="#bq_gyl"><a href="#tabs-gyl">供应链</a></li>
		<li id="#bq_jsb"><a href="#tabs-jsb">技术部</a></li>
		<li id="#bq_zzb"><a href="#tabs-zzb">制造部</a></li>
		<li id="#bq_swb"><a href="#tabs-swb">商务部</a></li>
		<li id="#bq_cwb"><a href="#tabs-cwb">财务部</a></li>
		<li id="#bq_xzb"><a href="#tabs-xzb">行政部</a></li>
		<li id="#bq_wab"><a href="#tabs-wab">网安部</a></li>
		<li id="#bq_zjlms"><a href="#tabs-zjlms">总经办</a></li>
		<li id="#bq_khxz"><a href="#tabs-khxz">考核小组</a></li>
	</ul>

    <div id="tabs-sbb">
	    <table id="tab_sbb" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_sbb"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
	<div id="tabs-gcb">
	    <table id="tab_gcb" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_gcb"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false" ></asp:TextBox>
	</div>
	<div id="tabs-zlb">
	    <table id="tab_zlb" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_zlb"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
    <div id="tabs-gyl">
        <table id="tab_gyl" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_gyl"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
	<div id="tabs-jsb">
	    <table id="tab_jsb" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_jsb"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
	<div id="tabs-zzb">
	    <table id="tab_zzb" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_zzb"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
	<div id="tabs-swb">
	    <table id="tab_swb" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_swb"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
	<div id="tabs-cwb">
	    <table id="tab_cwb" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_cwb"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
	<div id="tabs-xzb">
	    <table id="tab_xzb" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_xzb"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
    <div id="tabs-wab">
        <table id="tab_wab" runat="server" width="400" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_wab"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
	<div id="tabs-zjlms">
        <table id="tab_zjlms" runat="server" width="780" border="0" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <th style="width:80px"></th>
                <th style="width:80px">设备部</th>
                <th style="width:80px">工程部</th>
                <th style="width:80px">质量部</th>
                <th style="width:80px">供应链</th>
                <th style="width:80px">技术部</th>
                <th style="width:80px">制造部</th>
                <th style="width:80px">商务部</th>
                <th style="width:80px">财务部</th>
                <th style="width:80px">行政部</th>
                <th style="width:80px">网安部</th>
                <th style="width:80px">单位</th>
		    </tr>
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_zjlms"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
	<div id="tabs-khxz">
        <table id="tab_khxz" runat="server" width="780" border="0" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <th style="width:80px"></th>
                <th style="width:80px">设备部</th>
                <th style="width:80px">工程部</th>
                <th style="width:80px">质量部</th>
                <th style="width:80px">供应链</th>
                <th style="width:80px">技术部</th>
                <th style="width:80px">制造部</th>
                <th style="width:80px">商务部</th>
                <th style="width:80px">财务部</th>
                <th style="width:80px">行政部</th>
                <th style="width:80px">网安部</th>
                <th style="width:80px">单位</th>
		    </tr>
		    <tr>
		    </tr>
        </table>
        <asp:TextBox ID="TB_khxz"  runat="server" Width="760px" TextMode="MultiLine"  Rows="10" Visible="false"></asp:TextBox>
	</div>
</div>
</div>
<div id="dialog-form" title="物料信息">
    &nbsp;</div>
        <asp:button text=" 保  存 " runat="server" style="width:80px" id="B_save" OnClick="B_save_Click" OnClientClick="return SaveClick();" TabIndex="42"/>
        &nbsp; &nbsp;&nbsp;
        <asp:Button ID="B_sh" runat="server" Text=" 审  核 " OnClick="B_sh_Click" style="width:80px" />
        &nbsp;
        <asp:HiddenField ID="l" runat="server"  Value="0" />
        <asp:HiddenField ID="H_sbb" runat="server" />
        <asp:HiddenField ID="H_gcb" runat="server" />
        <asp:HiddenField ID="H_zlb" runat="server" />
        <asp:HiddenField ID="H_gyl" runat="server" />
        <asp:HiddenField ID="H_jsb" runat="server" />
        <asp:HiddenField ID="H_zzb" runat="server" />
        <asp:HiddenField ID="H_swb" runat="server" />
        <asp:HiddenField ID="H_cwb" runat="server" />
        <asp:HiddenField ID="H_xzb" runat="server" />
        <asp:HiddenField ID="H_wab" runat="server" />
        <asp:HiddenField ID="H_zjlms" runat="server" />
        <asp:HiddenField ID="H_khxz" runat="server" />
 </form>

<input type="hidden" name="prevTrIndex" id="prevTrIndex" value="-1" /> 


<script type ="text/javascript"  >
    if ($("#H_sbb").val()=="1"){
        $("#bq_sbb").show();
    }else{
        $("#bq_sbb").hide();
    }
    if ($("#H_gcb").val()=="1"){
        $("#bq_gcb").show();
    }else{
        $("#bq_gcb").hide();
    }
    if ($("#H_zlb").val()=="1"){
        $("#bq_zlb").show();
    }else{
        $("#bq_zlb").hide();
    }
    if ($("#H_gyl").val()=="1"){
        $("#bq_gyl").show();
    }else{
        $("#bq_gyl").hide();
    }
    if ($("#H_jsb").val()=="1"){
        $("#bq_jsb").show();
    }else{
        $("#bq_jsb").hide();
    }
    if ($("#H_zzb").val()=="1"){
        $("#bq_zzb").show();
    }else{
        $("#bq_zzb").hide();
    }
    if ($("#H_swb").val()=="1"){
        $("#bq_swb").show();
    }else{
        $("#bq_swb").hide();
    }
    if ($("#H_xzb").val()=="1"){
        $("#bq_xzb").show();
    }else{
        $("#bq_xzb").hide();
    }
    if ($("#H_wab").val()=="1"){
        $("#bq_wab").show();
    }else{
        $("#bq_wab").hide();
    }
    if ($("#H_zjlms").val()=="1"){
        $("#bq_zjlms").show();
    }else{
        $("#bq_zjlms").hide();
    }
    if ($("#H_khxz").val()=="1"){
        $("#bq_khxz").show();
    }else{
        $("#bq_khxz").hide();
    }
    
    
</script>

   
</body>
</html>
