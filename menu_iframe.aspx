<%@ Page Language="C#"   AutoEventWireup="true" CodeFile="menu_iframe.aspx.cs"  Inherits="menu_iframe" Title="主菜单" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
<script type="text/javascript" src="js/tinybox.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript">
$(function(){
	var json = eval("("+$.cookie("lsjl")+")");
	var newRow = "";
	for(var i=0; i<json.length;i++){
		newRow = "<tr style='color:#333333;background-color:#F7F6F3;'><td Width='58%' ><a href='"+json[i].url+"' target='_blank'> "+json[i].title+" </td><td Width='42%' > "+ json[i].newtime +" </td></tr>";
		$("#tb_lsjl tr:last").after(newRow);
	}

});

</script>


<style type="text/css">
/* 弹出层的样式 */
.divcss5_list_title{background:#eeeeee; border:1px solid #cccccc; padding:1em;}
.divcss5_list_content{padding:1em;}
#tinybox{position:absolute; display:none; padding:10px; background:#ffffff url(image/preload.gif) no-repeat 50% 50%; border:10px solid #e3e3e3; z-index:2000;}
#tinymask{position:absolute; display:none; top:0; left:0; height:100%; width:100%; background:#000000; z-index:1500;}
#tinycontent{background:#ffffff; font-size:1.1em;}

#n{margin:10px auto; width:920px; border:1px solid #CCC;font-size:12px; line-height:30px;}
#n a{ padding:0 4px; color:#333}


.a{float:left; border-width:1px 0; border-color:#bbbbbb; border-style:solid;}
.b{height:15px; border-width:0 1px; border-color:#bbbbbb; border-style:solid; margin:0 -1px; background:#e3e3e3; position:relative; float:left;}
.c{line-height:10px; color:#f9f9f9; background:#f9f9f9; border-bottom:2px solid #eeeeee;}
.d{padding:0 8px; line-height:22px; font-size:12px; color:#000000; clear:both; margin-top:-12px; cursor:pointer;}

/* white */  
.white {  
    color: #000000;  
    border: solid 1px #999999;  
    background: #add2da;  
    background: -webkit-gradient(linear, left top, left bottom, from(#add2da), to(#add2da));  
    background: -moz-linear-gradient(top,  #add2da,  #add2da);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#add2da', endColorstr='#add2da');  
     
    display: inline-block;  
    zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */  
    *display: inline;  
    vertical-align: baseline;  
    margin: 0 2px;  
    outline: none;  
    background-color:#add2da;
    text-align: center;  
    text-decoration: none;  
    font: 14px/20px Arial, Helvetica, sans-serif;  
    width:800px;
    height:150px;
    padding: .5em 0em .55em;  
    text-shadow: 0 1px 1px rgba(0,0,0,.3);  
    -webkit-border-radius: .3em;   
    -moz-border-radius: .3em;  
    border-radius: .3em;  
    -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);  
    -moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);  
    box-shadow: 0 1px 2px rgba(0,0,0,.2);  
}  
/* white */  
.white_in {  
    color: #000000;  
    border: solid 1px #999999;  
    background: #FFFFFF;  
    background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ededed));  
    background: -moz-linear-gradient(top,  #ededed,  #ededed);  
    filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#ededed');  
    
    display: inline-block;  
    zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */  
    *display: inline;  
    vertical-align: baseline;  
    margin: 0 2px;  
    outline: none;  

    text-align: left;  
    text-decoration: none;  
    float:left;
    font: 0px/10px Arial, Helvetica, sans-serif; 
    width:394px;
    height:133px;
    padding: .5em 0em .55em;  
    text-shadow: 0 1px 1px rgba(0,0,0,.3);  
    -webkit-border-radius: .2em;   
    -moz-border-radius: .2em;  
    border-radius: .2em;  
    -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);  
    -moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);  
    box-shadow: 0 1px 2px rgba(0,0,0,.2);  
    
}  




</style> 
</head>
<body>
<form id="form1" runat="server" >


<div class="white" style="height:170px;" >
 <div  style="width:750;text-align: left; ">  
 &nbsp;&nbsp; 文控最近更新 
 </div> 
 <div class="white_in" style="height:153px;"> 
    <asp:GridView ID="GridView3" emptydatatext="没有更新文件"    align="right" runat="server"  AutoGenerateColumns="False"  
        Width="100%"  Font-Names="Verdana" Font-Size="12px"   CellPadding="4" ForeColor="#333333" GridLines="None">
        <Columns>
            <asp:TemplateField HeaderText="最近更新文件" >
                <ItemTemplate  >
                     <asp:LinkButton ToolTip='<%# Eval("TipShow") %>'   ID="LinkButton1" runat="server"   CommandArgument='<%# Eval("FullName") %>' Text='<%# Eval("FileName") %>' OnClick ="LinkButton1_Click"></asp:LinkButton> 
                </ItemTemplate>
                <ItemStyle Width="75%"  HorizontalAlign ="Left" />
            </asp:TemplateField>
             

             <asp:BoundField DataField="InDate" HeaderText="发行时间" HtmlEncode="false" DataFormatString="{0:yyyy-MM-dd}"  >
                 <ItemStyle Width="25%" />
             </asp:BoundField>
        </Columns> 
        <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
        <RowStyle ForeColor="#333333" BackColor="#F7F6F3" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView> 
</div>

<div class="white_in" style="height:153px;" >
    <table cellspacing="0" cellpadding="4" align="right" border="0" id="tb_lsjl" style="color:#333333;font-family:Verdana;font-size:12px;width:100%;border-collapse:collapse;">
		<tr style="color:White;background-color:#5D7B9D;font-weight:bold;">
			<th scope="col">最近访问内容</th><th scope="col">访问时间</th>

		</tr>
	</table>

</div>



</div>
<div style=" height:3px;"></div>
 
<div class="white" style="height:200px;" >
    <div style="width:750;text-align: left;"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td >&nbsp;&nbsp; 通知中心</td>
        <td>&nbsp;</td>
        <td style="text-align:right;">   <asp:HyperLink ID="HL_TZLJ" runat="server" ></asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp; </td>
      </tr>
    </table> 
    </div>
        <div class="white_in" style="height:182px; width:574px" >
        
            <asp:GridView ShowHeader="false" ID="GridView2"  emptydatatext="没有新的公告"    align="right" runat="server"  AutoGenerateColumns="False"  
        Width="100%"  Font-Names="Verdana" Font-Size="13px"   CellPadding="5"  BorderWidth="7"  BorderColor="white" ForeColor="#333333" GridLines="None">
                <Columns>
                 <asp:TemplateField>
                    <ItemTemplate>
                        <%--<asp:HyperLink  NavigateUrl='<%# Eval("sid") %>'     runat="server" Text='<%# Eval("bt") %>'   /> --%>
                         ● &nbsp;&nbsp;<a  href='<%# Eval("sid") %>'  onclick="click_1(this)"  > <%# Eval("bt") %></a>
                    </ItemTemplate>
                    <ItemStyle Width="60%"  HorizontalAlign ="Left" />
                </asp:TemplateField> 

                 <asp:BoundField DataField="rq"  HtmlEncode="false" DataFormatString="{0:yyyy-MM-dd}" >
                     <ItemStyle Width="40%"  HorizontalAlign="Left"  /> 
                 </asp:BoundField> 

                 
                </Columns> 
                <RowStyle ForeColor="#333333" BackColor="#F7F6F3" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            </asp:GridView> 

        </div>
    <div style=" width:220px; text-align:center; float:left;" >
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White"    BorderColor="#3366CC" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="181px" Width="218px" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest">
            <SelectedDayStyle BackColor="#009999" ForeColor="#CCFF99" Font-Bold="True" />
            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
            <DayHeaderStyle ForeColor="#336666" Height="1px" BackColor="#99CCCC" />
            <TitleStyle BackColor="#003399" Font-Bold="True" Font-Size="10pt"
                ForeColor="#CCCCFF" Height="25px" BorderColor="#3366CC" BorderWidth="1px" />
            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
            <WeekendDayStyle BackColor="#CCCCFF" />
        </asp:Calendar>
    </div>

</div>
<div style=" height:3px;"></div>
<div class="white"  >

    <div  style="width:750;text-align:left;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td >&nbsp;&nbsp; 待评审内容</td>
        <td>&nbsp;</td>
        <td style="text-align:right;">   <asp:HyperLink ID="HL_stcd" runat="server" ></asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp; </td>
      </tr>
    </table>

    </div>
    <div class="white_in" >
    <asp:GridView ID="GridView1" emptydatatext="没有待评审内容"    align="right" runat="server"  AutoGenerateColumns="False"  
        Width="100%"  Font-Names="Verdana" Font-Size="12px"   CellPadding="4" ForeColor="#333333" GridLines="None">
        <Columns>
            <asp:BoundField DataField="psd" HeaderText="评审单" >
                <ItemStyle Width="75%" />
            </asp:BoundField>
            <asp:BoundField DataField="ts" HeaderText="未评审条数">
                 <ItemStyle Width="25%" />
            </asp:BoundField>
        </Columns> 
        <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
        <RowStyle ForeColor="#333333" BackColor="#F7F6F3" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView> 
    </div>
    <div class="white_in"   style="background:url(images/xpic.jpg)">
        <img src="images/xpic.jpg" />
    </div>
</div>



	<script type="text/javascript">
//弹出层自动消失
        //T$('click_1').onclick = function(){TINY.box.show('ggl.aspx',1,400,250,1)}
//        $(document).ready(function(){
//            var m=$('#<%= GridView2.ClientID %> a');
//            var _sid="";
//            for(i=0;i<m.length;i++){
//                _sid=m[i].href;
//                alert(m[i].href);
//                m[i].setAttribute("onclick",click_1(_sid.substring(_sid.lastIndexOf("#")+1,_sid.length)));
//    
////                m[i].onclick=function(){
////                    
////                    TINY.box.show('ggl.aspx?id='+ _sid.substring(_sid.lastIndexOf("#")+1,_sid.length),1,400,250,1);
////                }
//            }
//         });
       
        
        function click_1(sid) 
        {
            var _sid=sid.href;
            TINY.box.show('ggl.aspx?id='+_sid.substring(_sid.lastIndexOf("#")+1,_sid.length) ,1,400,270,1);
        }
        
    </script>
    </form>
    </body>
    </html>


