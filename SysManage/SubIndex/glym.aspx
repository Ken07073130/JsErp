﻿<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="glym.aspx.cs" Inherits="jsERP_glym" Title="金色能源ERP-生产模块" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
<style type="text/css">
<!--
/* button   
---------------------------------------------- */  
.button {  
    display: inline-block;  
    zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */  
    *display: inline;  
    vertical-align: baseline;  
    margin: 0 2px;  
    outline: none;  
    cursor: pointer;  
    text-align: center;  
    text-decoration: none;  
    font: 14px/10px Arial, Helvetica, sans-serif;  
    width:135px;
    padding: .5em 0em .55em;  
    text-shadow: 0 1px 1px rgba(0,0,0,.3);  
    -webkit-border-radius: .5em;   
    -moz-border-radius: .5em;  
    border-radius: .5em;  
    -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);  
    -moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);  
    box-shadow: 0 1px 2px rgba(0,0,0,.2);  
}  
.button:hover {  
    text-decoration: none;  
}  
.button:active {  
    position: relative;  
    top: 1px;  
}  
  
.bigrounded {  
    -webkit-border-radius: 2em;  
    -moz-border-radius: 2em;  
    border-radius: 2em;  
}  
.medium {  
    font-size: 12px;  
    padding: .4em 1.5em .42em;  
}  
.small {  
    font-size: 11px;  
    padding: .2em 1em .275em;  
}  
  
/* color styles   
---------------------------------------------- */  
  
 
  

/* white */  
.white {  
    color: #FFFFFF;  
    border: solid 1px #999999;  
    background: #999999;  
    background: -webkit-gradient(linear, left top, left bottom, from(#999999), to(#888888));  
    background: -moz-linear-gradient(top,  #999999,  #888888);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#999999', endColorstr='#888888');  
}  
.white:hover {  
    background: #ededed;  
    background: -webkit-gradient(linear, left top, left bottom, from(#999999), to(#888888));  
    background: -moz-linear-gradient(top,  #999999,  #888888);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#999999', endColorstr='#888888');  
}  
.white:active {  
    color: #999999;  
    background: -webkit-gradient(linear, left top, left bottom, from(#888888), to(#999999));  
    background: -moz-linear-gradient(top,  #888888,  #999999);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#888888', endColorstr='#999999');  
}  
  
/* orange */  
.orange {  
    color: #fef4e9;  
    border: solid 1px #b45b3e;  
    background: #b45b3e;  
    background: -webkit-gradient(linear, left top, left bottom, from(#b45b3e), to(#a45b3e));  
    background: -moz-linear-gradient(top,  #b45b3e,  #a45b3e);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#b45b3e', endColorstr='#a45b3e');  
}  
.orange:hover {  
    background: #FF8040;  
    background: -webkit-gradient(linear, left top, left bottom, from(#FF8040), to(#EF8040));  
    background: -moz-linear-gradient(top,  #FF8040,  #EF8040);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#FF8040', endColorstr='#EF8040');  
}  
.orange:active {  
    color: #b45b3e;  
    background: -webkit-gradient(linear, left top, left bottom, from(#b45b3e), to(#a45b3e));  
    background: -moz-linear-gradient(top,  #b45b3e,  #a45b3e);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#b45b3e', endColorstr='#a45b3e');  
}  



.div1 {font-size:12px;
		background :#ffffcc;
		width:135px; 
		height:25px;
		line-height:25px;
		over-flow: hidden; }
.div4 {font-size:12px;
		width:135px; 
		height:25px;
		line-height:42px;
		over-flow: hidden; }
.div2{  width:150px; 
		height:250px;
		size:12px; 
		float:left;}  		 
.div3{ width:150px; 
		height:200px;
		size:12px;
		clear:left;
		float:left;} 
.wrap{  margin:0 auto;
        width:600px;
        height:550px; 
        border:solid 1px #e3e3e3;
        background: #f1fafa;  
        
        } 



-->
</style>
</head>
<body>
<form id="form1" runat="server" >
<div  class="wrap" align="center" >
    <div id="div1" class="div2" align="center" >
        <div style=" height:5px;"></div>
        <div class="div4" >日常录入</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink  CssClass="button orange" id ="B_1144"  runat="server" NavigateUrl="~/sclr/jpscrblb.aspx" text ="批次生产信息统计表" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1145"  runat="server" NavigateUrl="~/wzjsz.aspx"  text="出货录入表" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1151"  runat="server" NavigateUrl="~/wzjsz.aspx"  text="成品入库单" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1150"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="物料转移单" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1234"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="物料加工单" /> 
        <div style=" height:5px;"></div>

    </div>

    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div class="div4">稼动率录入</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1148"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="设备稼动率" /> 
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4">------------------------------</div>
        <div style=" height:5px;"></div>
        <div class="div4">维护</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1133"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="设备信息" /> 
        <div style=" height:5px;"></div>
    </div>

    
    
    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div class="div4" >重要事项</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1247"  runat="server"   NavigateUrl="~/wzjsz.aspx" text="制造重要事项" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1146"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="浆料跟踪记录表" /> 
        <div style=" height:5px;"></div>
        <div class="div4">------------------------------</div>
        <div style=" height:5px;"></div>
        <div class="div4">维护</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1152"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="项目属性" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1153"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="班组分类" /> 
        <div style=" height:5px;"></div>
    </div>
    
    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div class="div4">盘点</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1142"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="盘点录入表" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1149"  runat="server"   NavigateUrl="~/wzjsz.aspx" text="期初数据" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_HyperLink2"  runat="server"   NavigateUrl="~/chaxun/pcsj_p.aspx" text="结存品查询" /> 
        <div style=" height:5px;"></div>
    </div>



    <div  align="center" class="div3" >
        <div style=" height:5px;"></div>
        <div  class="div4">DOWNLOAD</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1221"  runat="server"  NavigateUrl="~/zlrb.aspx"   text="批次数据1（按日）" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1241"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="批次数据2（按日）" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="BHyperLink1"  runat="server"   NavigateUrl="~/wzjsz.aspx" text="批次数据（按批）" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1158"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="原料消耗汇总表" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1159"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="原料汇总表（搅拌）" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1160"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="型号合格率" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="BHyperLink2"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="批次进度查询" /> 
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
    </div>
    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1155"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="浆料利用率查询" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1232"  runat="server" NavigateUrl="~/wzjsz.aspx" text="制造重要事项汇总" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1156"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="设备稼动率汇总" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1157"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="库存月报" /> 
        <div style=" height:5px;"></div>


    </div>
    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <asp:HyperLink  CssClass="button orange" id ="HyperLink1"  runat="server" NavigateUrl="~/sclr/jpscrblb.aspx" text ="生产日报录入" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink  CssClass="button orange" id ="HyperLink2"  runat="server" NavigateUrl="~/sclr/jsscrbcx.aspx" text ="生产日报查询" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink  CssClass="button orange" id ="HyperLink3"  runat="server" NavigateUrl="~/sclr/jgdlb.aspx" text ="物料加工单" /> 
        <div style=" height:5px;"></div>



    </div>
    
</div>
</form>
</body>
</html>
