﻿<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="xzglym.aspx.cs" Inherits="xzglym" Title="金色能源ERP-供应链模块" %>


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
  
 
  

/* white   
.white {  
    color: #606060;  
    border: solid 1px #b7b7b7;  
    background: #fff;  
    background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));  
    background: -moz-linear-gradient(top,  #fff,  #ededed);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');  
}  
.white:hover {  
    background: #ededed;  
    background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#dcdcdc));  
    background: -moz-linear-gradient(top,  #fff,  #dcdcdc);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#dcdcdc');  
}  
.white:active {  
    color: #999;  
    background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#fff));  
    background: -moz-linear-gradient(top,  #ededed,  #fff);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#ffffff');  
}  
  
/* orange 
.orange {  
    color: #fef4e9;  
    border: solid 1px #da7c0c;  
    background: #f78d1d;  
    background: -webkit-gradient(linear, left top, left bottom, from(#faa51a), to(#f47a20));  
    background: -moz-linear-gradient(top,  #faa51a,  #f47a20);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');  
}  
.orange:hover {  
    background: #f47c20;  
    background: -webkit-gradient(linear, left top, left bottom, from(#f88e11), to(#f06015));  
    background: -moz-linear-gradient(top,  #f88e11,  #f06015);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f88e11', endColorstr='#f06015');  
}  
.orange:active {  
    color: #fcd3a5;  
    background: -webkit-gradient(linear, left top, left bottom, from(#f47a20), to(#faa51a));  
    background: -moz-linear-gradient(top,  #f47a20,  #faa51a);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f47a20', endColorstr='#faa51a');  
}  
*/

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
<div  class="wrap">
    <div id="div1" class="div2" align="center" >
        <div style=" height:5px;"></div>
        <div class="div4" >
            行政管理</div>
        <div style=" height:5px;"></div>
        <asp:HyperLink  CssClass="button orange" id ="B_1292"  runat="server"  NavigateUrl="~/wzjsz.aspx" text ="部门绩效考核" /> 
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
        <div class="div4"></div>
        <div style=" height:5px;"></div>
         <div class="div4"></div>
        <div style=" height:5px;"></div>
    </div>

    
    
   

   
    
</div>
</form>
</body>
</html>
