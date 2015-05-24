<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WelCome.aspx.cs" Inherits="SysManage_SubIndex_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>无标题页</title>
    <style type="text/css">
      .layout
      {
	    overflow:hidden;
	    width:400px;
	    margin: 0 auto;
	    border: 1px solid #e3e3e3;
        background-color: #f1fafa;
        display:inline-block;
      }

     .layout ul {
        list-style:none;
      }


     .layout li 
     {
        width:150px;
        float:left;
        background: #fef4e9; 
        text-align:center;
        margin-right:10px; 
        color:White;
        margin-bottom:10px;
        background: -webkit-gradient(linear, left top, left bottom, from(#b45b3e), to(#a45b3e));  
        background:#b45b3e;
     }
     
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
    .button a {
      text-decoration:none; 
      color:White;
    } 
    .button:hover {  
        text-decoration: none;  
    }  
    .button:active {  
        position: relative;  
        top: 1px;  
    }  
    
    h2 {
      background-color:#FFCCCC;
      font-size:13px;
      font-family: "微软雅黑", Verdana, Geneva, sans-serif;
      font-weight:700;
      border:1px solid #efefef;
      padding-left:15px;
      margin:0px;
    }
 
 
 

     
     
    
     
 

    </style>

    <script type="text/javascript">
       //设置文件管理是否可见
       function setVisible(){
         var qxgl=window.parent.document.getElementById('divSubDictionary').innerHTML;
         if(qxgl.indexOf('新加文件管理')>0){
            document.getElementById('liXwjgl').style.display="";
         }
         if(qxgl.indexOf('组权限管理')>0){
            document.getElementById('liZqxgl').style.display="";
         }
         if(qxgl.indexOf('用户权限管理')>0){
            document.getElementById('liYhqxgl').style.display="";
         }
       }
       
       function showCp(){
          document.getElementById('divShowCp').style.display="";
       }
       
       window.onload=setVisible;
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 1000px; height: 800px; margin: 0 auto;">
            <div class="layout" style="height: 720px; float: left; width: 500px; margin-right: 20px;">
                <h2>
                    待办事项</h2>
                <div>
                    <asp:GridView Style="text-align: center" ID="GridView1" runat="server" EmptyDataRowStyle-BackColor="#40e0d0"
                        PageSize="50" AllowSorting="True" AllowPaging="True" Width="100%" EmptyDataText="未有待办事项"
                        Font-Size="15px" Font-Names="Verdana" AutoGenerateColumns="False" CssClass="gridtable"
                        OnRowDataBound="GridView1_RowDataBound">
                        <EmptyDataRowStyle BackColor="Turquoise" />
                        <Columns>
                            <asp:BoundField DataField="NodeCaption" HeaderText="工作单">
                                <ItemStyle Width="40%" />
                            </asp:BoundField>
                            <asp:TemplateField ItemStyle-Width="45%">
                                <HeaderTemplate>
                                    待办内容</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbContent" runat="server"></asp:Label></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlURL" runat="server" CssClass="button" Style="width: 50px; background: #0099cc;
                                        text-decoration: none; color: White" Target="main">进入</asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="URL" Visible="false" />
                        </Columns>
                        <RowStyle BackColor="#F5FAFA" ForeColor="#797268" />
                        <AlternatingRowStyle BackColor="white" ForeColor="#4f6b72" />
                        <HeaderStyle BackColor="#CCCCCC" ForeColor="#4f6b72" />
                    </asp:GridView>
                </div>
                <div id="divCp" runat="server" visible="false">
                    路径<asp:TextBox ID="tbWjlj" runat="server" Text="C:\\Users\\Ken\\Desktop\\食堂菜单.xls"></asp:TextBox>Sheet页<asp:TextBox
                        ID="tbSheetName" runat="server" Text="[Sheet1$]"></asp:TextBox><asp:Button ID="btnImpCp"
                            runat="server" OnClick="btnImpCp_Click" Text="导入菜谱" /></div>
            </div>
            <div style="width: 450px; float: left;">
                <div class="layout" style="margin-bottom: 20px;">
                    <h2>
                        文控目录</h2>
                    <ul>
                        <li class="button"><a href="../../wkzt/zjgx.aspx"  >最近更新</a> </li>
                        <li class="button"><a href="../../wkzt/index_wk.aspx" >文件管理</a></li>
                        <li class="button" id="liXwjgl" style="display: none;"><a href="../../wkzt/tjwj.aspx"  >新加文件管理</a></li>
                        <li class="button" id="liZqxgl" style="display: none;"><a href="../../wkzt/yhz.aspx"  >组权限管理</a></li>
                        <li class="button" id="liYhqxgl" style="display: none;"><a href="../../wkzt/yhgl.aspx"  >用户权限管理</a></li>
                    </ul>
                </div>
                <div class="layout">
                    <h2>
                     <asp:HyperLink ID="hlShowCp" runat="server" CssClass="button" Style=" background: #0099cc;
                                        text-decoration: none; color: White" onclick="showCp()">显示今日菜单</asp:HyperLink>
                    </h2>
                    <div id="divShowCp" style="display:none">
                        <asp:GridView Style="text-align: center" ID="GridView2" runat="server" EmptyDataRowStyle-BackColor="#40e0d0"
                            PageSize="50" AllowSorting="True" AllowPaging="True" GridLines="Horizontal" BorderWidth="3px"
                            BorderStyle="Double" BorderColor="#336666" BackColor="White" Width="100%" EmptyDataText="未导入菜单"
                            Font-Size="20px" Font-Bold="true" Font-Names="Verdana" CellPadding="4" AutoGenerateColumns="False">
                            <RowStyle ForeColor="#333333" BackColor="#F1FAFA" />
                            <Columns>
                                <asp:BoundField DataField="CM" HeaderText="今日菜谱">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#333333" />
                            <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#CCCCCC" Font-Bold="True" />
                            <EmptyDataRowStyle BackColor="Turquoise" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
