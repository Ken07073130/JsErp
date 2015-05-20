<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Css/Article.css" rel="stylesheet" type="text/css" />

    <script src="jquery-ui/jquery-1.10.2.js"></script>

    <script src="Js/Article.js"></script>

    <style type="text/css">
      .NavButton {
        display: inline-block;  
        zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */  
        *display: inline;  
        vertical-align: baseline;  
        margin: 0 2px;  
        outline: none;  
        cursor: pointer;  
        text-align: center;   
        font: 13px/10px Arial, Helvetica, sans-serif;  
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
    </style>

    <script type="text/javascript">
     
       function showtime(){
         var x=new Date();
         var now,week,n,y,r,h,m,s; 
         now=new Date(); 
         n = now.getFullYear(); 
         y = now.getMonth()+1; 
         r = now.getDate(); 
         h = now.getHours(); 
         m = now.getMinutes(); 
         s = now.getSeconds(); 
         week='星期'+'日一二三四五六'.charAt(new Date().getDay());
         document.getElementById("showtime").innerText=n+"-"+y+"-"+r+""+" "+week+" "+h+":"+m+":"+s;//改变 showtime  里面的文字
      }
       
      function SetWinHeight(obj) 
        { 
            var win=obj; 
            if (document.getElementById) 
            { 
                if (win && !window.opera) 
                { 
                if (win.contentDocument && win.contentDocument.body.offsetHeight) 
                win.height = win.contentDocument.body.offsetHeight+10; 
                else if(win.Document && win.Document.body.scrollHeight) 
                win.height = win.Document.body.scrollHeight+10; 
                } 
            } 
            scroll(0,0);
        } 
   
    </script>

    <title></title>
</head>
<body>
    <form id="form1" runat="server" style="overflow: hidden;">
        <div id="Top">
            <div class="Toolbar1">
                <div class="CentreBox">
                    <div class="Logo">
                    </div>
                    <div class="Menu">
                        <asp:BulletedList ID="blDictionary" runat="server" CssClass="List1" DisplayMode="HyperLink"
                            Target="main">
                        </asp:BulletedList>
                    </div>
                    <div class="UserInfo">
                        <p>
                            <asp:Label ID="lbWelCome" runat="server" Text="你好" Font-Size="12px" Font-Bold="true"></asp:Label>&nbsp;&nbsp;|&nbsp;&nbsp;
                            <a href="SysManage/UserManage/UserEdit.aspx" target="_self">密码修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
                                href="SysManage/UserManage/User.aspx">个人信息</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                            <asp:LinkButton ID="lbLoginOout" runat="server" OnClick="lbLoginOout_Click">退出系统</asp:LinkButton></p>
                        <p style="margin-left: -335px; margin-bottom:10px;">
                            <a href="javascript:history.go(-1);" target="_self" class="NavButton" style="width: 50px; background: #CDCAB9;
                                        text-decoration: none; color: White">后退</a> 
                            <a href="javascript:history.go(1);" target="_self" class="NavButton" style="width: 50px; background: #C7D0D5;
                                        text-decoration: none; color: White">前进</a> 
                            <a href="SysManage/SubIndex/WelCome.aspx" target="main" class="NavButton" style="width: 50px; background: #5E93A0;
                                        text-decoration: none; color: White">主页</a>
                            <a onclick="main.window.location.reload()" target="main" class="NavButton" style="width: 50px; background: #6699CC;
                                        text-decoration: none; color: White">刷新</a>
                                        
                            <span id="showtime" style="font-size: 12px; margin-left: 150px;">

                                <script>
                                 setInterval("showtime()",1000);// 重复执行 showtime()函数  间隔  1秒
                                </script>

                            </span><a href="main.aspx" target="_self" style="margin-left: 20px;">使用旧版主页</a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="Toolbar2">
                <div class="CentreBox" id="divSubDictionary" runat="server">
                </div>
            </div>
        </div>
        <div>
            <iframe name="main" style="border: 0px" scrolling="no" onload="Javascript:SetWinHeight(this)"
                width="100%" src="SysManage/SubIndex/WelCome.aspx"></iframe>
        </div>
    </form>
</body>
</html>
