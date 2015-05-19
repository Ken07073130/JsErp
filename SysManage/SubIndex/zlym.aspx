<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zlym.aspx.cs" Inherits="zlym" Title="金色能源ERP-质量模块" %>


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
		float:left;
		
		}  		 
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
<div  class="wrap">

    <div id="div1" class="div2" align="center" >
        <div style=" height:5px;"></div>
        <div class="div4" >品质追踪录入</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink  CssClass="button orange" id ="B_1164"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text ="配料录入" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1165"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="涂布录入" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1166"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="卷绕录入" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1167"  runat="server"  N NavigateUrl="~/wzjsz.aspx"  text="封装录入" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1168"  runat="server"   NavigateUrl="~/wzjsz.aspx"  text="注液录入" /> 
        <div style=" height:5px;"></div>
         <asp:HyperLink CssClass="button orange" id ="B_1163"  runat="server"   NavigateUrl="~/wzjsz.aspx"  text="二封录入" /> 
        <div style=" height:5px;"></div>
    </div>

    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div class="div4">IQC录入</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1169"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="物料入库报检申请单" /> 
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4">OQC录入</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="BHyperLink1"  runat="server"   NavigateUrl="~/wzjsz.aspx"  text="出货检验录入" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="BHyperLink2"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="出货台帐录入" /> 
        <div style=" height:5px;"></div>
    </div>

    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div class="div4" >质量日报录入</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1225"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="质量部QC检查日报表" /> 
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1178"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="QC日报查询" /> 
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
    </div>

    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div class="div4">环保管控录入</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_748"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="均质物质管理" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_747"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="环保物料有效期管理" /> 
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4">OQC录入</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="BHyperLink3"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="均质物质查询" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="BHyperLink4"  runat="server"  NavigateUrl="~/wzjsz.aspx" text="环保物料查询" /> 
        <div style=" height:5px;"></div>
    </div>
    <div  align="center" class="div3" >
        <div style=" height:5px;"></div>
        <div class="div4">计量管理</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1263"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="计量管理台帐" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1264"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="计量校准计划录入" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1265"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="计量器具台帐查询" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1266"  runat="server"  NavigateUrl="~/wzjsz.aspx"  text="计量器具履历查询" /> 
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
    </div>
    <div  align="center" class="div2" >
        <div style=" height:5px;"></div>
        <div  class="div4">DOWNLOAD</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1177"  runat="server"   NavigateUrl="~/wzjsz.aspx"   text="浆料质量控制查询" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1171"  runat="server"   NavigateUrl="~/wzjsz.aspx"   text="涂布质量控制查询1" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1172"  runat="server"   NavigateUrl="~/wzjsz.aspx"  text="涂布质量控制查询2" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1222"  runat="server"   NavigateUrl="~/wzjsz.aspx"   text="卷绕质量控制查询" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1176"  runat="server"   NavigateUrl="~/wzjsz.aspx"   text="封装质量控制查询" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1174"  runat="server"   NavigateUrl="~/wzjsz.aspx"   text="注液质量控制查询" /> 
        <div style=" height:5px;"></div>
        <asp:HyperLink CssClass="button orange" id ="B_1175"  runat="server"   NavigateUrl="~/wzjsz.aspx"   text="二封质量控制查询" /> 
        <div style=" height:5px;"></div>
    </div>



</div>
</form>
</body>
</html>
