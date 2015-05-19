﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="main" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/History.js"></script>
<script type="text/javascript" src="js/chili-1.7.pack.js"></script>
<script type="text/javascript" src="js/jquery.easing.js"></script>
<script type="text/javascript" src="js/jquery.dimensions.js"></script>
<script type="text/javascript" src="js/jquery.accordion.js"></script>
<script language="javascript">
	jQuery().ready(function(){
		jQuery('#navigation').accordion({
			header: '.head',
			navigation1: true, 
			event: 'click',
			fillSpace: true,
			animated: 'bounceslide'
		});     
	});
	
	$(function() {
         $( document ).tooltip();
    });
    
    //点击收拢区域变色
    function setFoucs(){
       document.getElementById('divExpend').style.backgroundColor="#7F7F7F";
    }
    //点击收拢区域恢复颜色
    function setOut(){
       document.getElementById('divExpend').style.backgroundColor="#dddada";
    }
    
    function hideTreeView(){
      //已经被隐藏了 需要打开
      if( document.getElementById('tdTreeView').style.display == "none" ){
        document.getElementById('tdTreeView').style.display="";
        document.getElementById('divExpend').title="点击收拢";
        document.getElementById('divExpend').style.backgroundImage="url(images/hideTreeView.jpg)";
      } 
      //已经打开了 需要隐藏
      else {
        document.getElementById('tdTreeView').style.display="none";
        document.getElementById('divExpend').title="点击展开";
        document.getElementById('divExpend').style.backgroundImage="url(images/showTreeView.jpg)";
      }
      
    }
    	



</script>
	
	

<style type="text/css">
body {
	margin:0px;
	padding:0px;
	font-size: 12px;
}
#navigation {
	margin:0px;
	padding:0px;
	width:200px;
}
#navigation a.head {
	cursor:pointer;
	background:url(images/main_44.gif) no-repeat scroll;
	display:block;
	font-weight:bold;
	margin:0px;
	padding:5px 0 5px;
	text-align:center;
	font-size:12px;
	text-decoration:none;
}
#navigation ul {
	border-width:0px;
	margin:0px;
	padding:0px;
	text-indent:0px;
}
#navigation li {
	list-style:none; display:inline;
}
#navigation li li a {
	display:block;
	font-size:12px;
	text-decoration: none;
	text-align:center;
	padding:3px;
}
#navigation li li a:hover {
	background:url(images/tab_bg.gif) repeat-x;
		border:solid 1px #adb9c2;
}


#divDjshMessage{
   display:block;
}
</style>


<style type="text/css">

html{ width:100%; height:100%;}
body {
    height:100%;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;

	background-color: #FFFFFF;
}
.STYLE1 {
	font-size: 12px;
	color: #000000;
}
.STYLE5 {font-size: 12}
.STYLE7 {font-size: 12px; color: #FFFFFF; }
.STYLE7 a{font-size: 12px; color: #FFFFFF; }
a img {
	border:none;
}

</style>



</head>

<body >
     
     <form id="form1" runat="server" >
<table style="width:100%; height:100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td height="57" background="images/main_03.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="378" height="57" background="images/main_01.gif">&nbsp;</td>
        <td>&nbsp;</td>
        <td width="281" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="33" height="27"><img src="images/main_05.gif" width="33" height="27" /></td>
            <td width="248" background="images/main_06.gif"><table width="225" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td style="height: 17px"><div align="right"><a href="UserEdit.aspx" ><img src="images/pass.gif" width="69" height="17" /></a></div></td>
                <td style="height: 17px"><div align="right"><a href="User.aspx"><img src="images/user.gif" width="69" height="17" id="IMG1"  onclick="return IMG1_onclick()" /></a></div></td>
                <td style="height: 17px"><div align="right"><a href="" target="_parent"><asp:ImageButton Runat="Server" ID ="logout" src="images/quit.gif"  width="69" height="17" OnClick="logout_Click"   /></a></div></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="40" background="images/main_10.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="194" height="40" background="images/main_07.gif">&nbsp;</td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="21"><img src="images/main_13.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="menu_iframe.aspx" target="main">首页</a></div></td>
            <td width="21" class="STYLE7"><img src="images/main_15.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="javascript:history.go(-1);">后退</a></div></td>
            <td width="21" class="STYLE7"><img src="images/main_17.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="javascript:history.go(1);">前进</a></div></td>
            <td width="21" class="STYLE7"><img src="images/main_19.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="javascript:window.parent.location.reload();">刷新</a></div></td>
            <td width="21" class="STYLE7"><img src="images/main_21.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="index.aspx" >新入口</a></div></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
        <td width="248" background="images/main_11.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="16%"><span class="STYLE5"></span></td>
            <td width="75%"><div align="center"><span class="STYLE7"><a href="http://www.ftbattery.com/index.php" target="_blank">杭州金色能源科技有限公司</a></span></div></td>
            <td width="9%">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td background="images/main_31.gif" style="height: 30px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td style="height: 30px; width: 8px;"><img src="images/main_28.gif" width="8" height="30" /></td>
                <td width="147" background="images/main_29.gif" style="height: 30px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="24%" style="height: 20px">&nbsp;</td>
                            <td valign="bottom" class="STYLE1" style="width: 43%; height: 20px;"><a href ="ConfigMenu.aspx" >管理菜单</a></td>
                            <td width="33%" style="height: 20px">&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td width="39" style="height: 30px"><img src="images/main_30.gif" width="39" height="30" /></td>
                <td style="height: 30px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="bottom" style="height: 20px"><span class="STYLE1"><asp:Label ID="L_user"   runat="server"></asp:Label></span></td>
                            <td valign="bottom" class="STYLE1" style="height: 20px"><div align="right"></div></td>
                        </tr>
                    </table>
                </td>
                <td width="17" style="height: 30px"><img src="images/main_32.gif" width="17" height="30" /></td>
            </tr>
        </table>

    </td>
  </tr>
</table>

	</td>
  </tr>
  <tr  >
    <td style="height:100%">
	    <table width="100%" style="height:595px; " border="0" cellspacing="0" cellpadding="0">
          <tr  >
            <td bgcolor="#353c44" style="width: 8px;">&nbsp;</td>
            <td valign="top" id="tdTreeView" align="center"  style="height:100%; width: 200px; " >

            <div  style="height:100%;width:200px;"     >
              <ul id="navigation">
                <li > <a class="head"  onclick="getV()">金色能源ERP</a>
                  <ul>
                    <li >
                        <asp:TreeView ID="TreeView1" runat="server" Width="198px" LineImagesFolder="~/TreeLineImages"  ImageSet="Arrows" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged"  align="left">
                            <ParentNodeStyle Font-Bold="False"  />
                            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"  VerticalPadding="0px" />

                            <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                        </asp:TreeView>

                   </li>

                  </ul>
                </li>
             
                <li> <a class="head">文控中心</a>
                  <ul><li >
                        <asp:TreeView ID="TreeView2" runat="server" Width="198px" LineImagesFolder="~/TreeLineImages"  ImageSet="Arrows" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged"  align="left">
                            <ParentNodeStyle Font-Bold="False" />
                            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"  VerticalPadding="0px" />
                            <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                            <Nodes >
                            </Nodes>
                        </asp:TreeView>
                     </li>
                  </ul>
                </li>
                <li> <a class="head">教学文档</a>
                  <ul>
                    <li><a href="xxymAjax.aspx" >出货计划教学文档</a></li>
                  </ul>
                </li>
                <li> <a class="head">帮助信息</a>
                  <ul>
                    <li><a href="http://www.ftbattery.com/index.php" target="_blank">杭州金色能源科技有限公司</a></li>
                    <li><a href="SysManage/controlRefList.aspx"target="main">对照</a></li>
                    <li><a href="cgxt/tldList.aspx" target="main">套料单</a></li>
                    <li><a href="cgxt/sldList.aspx" target="main">收料单</a></li>
                    <li><a href="cgxt/lltldList.aspx?djlx=LLD" target="main">领料单</a></li>
                    <li><a href="cgxt/lltldList.aspx?djlx=TLD" target="main">退料单</a></li>
                    <li><a href="cgxt/wlReplaceList.aspx" target="main">物料替代</a></li>
                    <li><a href="cgxt/cgdList.aspx" target="main">采购单</a></li>
                    <li><a href="sclr/jpscrb.aspx" target="main">王滔的单子</a></li>
                    <li><a href="yp/khtsdList.aspx" target="main">客户投诉单</a></li>
                    <li><a href="yp/cpkftaEdit.aspx?lb=EDIT&xh=JSGGS-201404001&editType=会签中&djlx=GGS" target="main">规格书编辑</a></li>
                    <li><a href="yp/cpkftaEdit.aspx?lb=ADD&djlx=GGS" target="main">规格书添加</a></li>
                    <li><a href="cgxt/lltldEdit.aspx?lb=ADD&djlx=LLD" >领料新</a></li>
                    <li><a href="yp/ypzhpsdEdit.aspx?lb=ADD" >新建</a></li>
                    <li><a href="yp/ypzhpsdEdit.aspx?lb=EDIT&xh=JSGGS-201405007&editType=会签中" >编辑</a></li>
                    <li><a href="yp/ypzhpsdList.aspx" target="main">样品综合评审单</a></li>
                    <li><a href="cgxt/nonProductList.aspx?djlx=SLD" target="main">收料单(非原材料)</a></li>
                    <li><a href="cgxt/nonProductList.aspx?djlx=LLD" target="main">领料单(非原材料)</a></li>
                    <li><a href="cgxt/nonProductList.aspx?djlx=TLD" target="main">退料单(非原材料)</a></li>
                    <li><a href="cgxt/thdList.aspx" target="main">退货单</a></li>
                    <li><a href="cgxt/wzflEdit.aspx" target="main">物资分类</a></li>
                    <li><a href="swxt/ddfhList.aspx" target="main">订单发货录入表</a></li>
                    <li><a href="jsERP/pzfkbList.aspx"target="main">品质反馈表</a></li>
                  </ul>
                </li>
              </ul>
            </div>
            
            
            </td>
           <td style="width: 2px" bgcolor="#add2da"></td>
            <td id="tdExpand" style="width: 15px" onclick="hideTreeView()">
               <div id="divExpend" title="点击收拢"
                   style="height:270px; line-height:270px; background-color:#dddada; background-position:center; 
                    background-image  : url(images/hideTreeView.jpg);  background-repeat:no-repeat;"
                    onmouseover="setFoucs()" onmouseout="setOut()">
               </div> </td>
            <td valign="top" style="height:100%">
                <iframe  name="main" style=" border:0px;"   height="100%" width="100%" src="menu_iframe.aspx" >
                </iframe>
            </td>
            <td width="8" bgcolor="#353c44">&nbsp;</td>
          </tr>
        </table>
	
	</td>
  </tr>
  <tr>
    <td>
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="images/main_71_1.gif"  style="line-height:11px; table-layout:fixed" width="218">&nbsp;</td>
    <td background="images/main_72.gif"  style="line-height:11px; table-layout:fixed">&nbsp;</td>
    <td background="images/main_74.gif"  style="line-height:11px; table-layout:fixed" width="17">&nbsp;</td>
  </tr>
</table></td>
  </tr>
</table>



</form> 
</body>

</html>
