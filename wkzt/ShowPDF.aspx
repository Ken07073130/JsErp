<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="ShowPDF.aspx.cs" Inherits="wkzt_ShowPDF" Title="金色能源文控系统" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
    <script src="../FlexPaper/js/jquery.js" type="text/javascript"></script>
    <script src="../FlexPaper/js/flexpaper_flash_debug.js" type="text/javascript"></script>
    <script src="../FlexPaper/js/flexpaper_flash.js" type="text/javascript"></script>
    <script type="text/javascript" src="../js/swfobject.js"></script>
    <script type="text/javascript">
		swfobject.registerObject("myId", "9.0.0", "expressInstall.swf");
    </script>

<style type="text/css">
<!--
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
	background:url(../images/main_44.gif) no-repeat scroll;
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
	background:url(../images/tab_bg.gif) repeat-x;
		border:solid 1px #adb9c2;
}

-->
</style>
<style type="text/css">
<!--
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




-->
</style>



</head>

<body >
     
     <form id="form1" runat="server" >

	    <table width="100%" style="height:580px" border="0" cellspacing="0" cellpadding="0">
          <tr >
            <td bgcolor="#353c44" style="width: 8px">&nbsp;</td>
            <td valign="top" align="center"  style="height:100%;" >
            <center >

                <a id="viewerPlaceHolder" style="height:600px;width: 800px;display: block;   text-align: center;"></a>
                <!--设置一个隐蔽控件来得到要显示的文件的名字-->
                
                <input type="hidden" id="file" value='<%=FileURL %>' />
             
                <script type="text/javascript">
                
                var fileURL=$("#file").val();
                    var fp = new FlexPaperViewer(
                '../wk/FlexPaper/FlexPaperViewer',
                'viewerPlaceHolder',
                { config: {
                    SwfFile: escape(fileURL) ,//escape(fileURL)
                    Scale: 1,
                    ZoomTransition: 'easeOut',
                    ZoomTime: 0.5,
                    ZoomInterval: 0.2,
                    FitPageOnLoad: false,
                    FitWidthOnLoad: true,
                    PrintEnabled: false,
                    PrintToolsVisible : false,
                    FullScreenAsMaxWindow: false,
                    ProgressiveLoading: false,
                    MinZoomSize: 0.2,
                    MaxZoomSize: 5,
                    SearchMatchAll: true,
                    InitViewMode: 'Portrait',
                    ViewModeToolsVisible: true,
                    ZoomToolsVisible: true,
                    NavToolsVisible: true,
                    CursorToolsVisible: true,
                    SearchToolsVisible: true,
                    localeChain: 'zh_CN'
                }
                }
                );
                </script>

            </center>
           
            
            
            </td>

            <td width="8" bgcolor="#353c44">&nbsp;</td>
          </tr>
        </table>
	


</form> 
</body>

</html>

<%--    <link href="../Style/style.css" rel="stylesheet" type="text/css" />--%>





   

        




