<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sldb.aspx.cs" Inherits="stcd_cdgl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

 <style type="text/css">

    .T_Sample1 {
        border-collapse: collapse;
        border: none;
        background: #DDF3FF;
        bgcolor:#DDF3FF;
        font-size:14px;
         
      
    }
    .T_Sample1 th {
        border: solid 1px #707070;
    }
    .T_Sample1 td {
        border: solid 1px #707070;
    }
    
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



    <title>菜单管理</title>
</head>
<body>
<script type="text/javascript">

    //提交前检查输入情况
    function IntoClick(){
        var rq=document.getElementById('<%= T_LX.ClientID %>').value
        if(rq==""){
            alert("用餐类型不能为空！");
            return false;
        }
        var rq=document.getElementById('<%= T_RQ.ClientID %>').value
            if(rq==""){
                alert("日期不能为空！");
                return false;
            }
        return true;
    }
        //获取当前日期
    function GetDateT()
    {
        var d,s;
        d = new Date();
        s = d.getFullYear() + "-";             //取年份
        s = s + (d.getMonth() + 1) + "-";//取月份
        s += d.getDate() + " ";         //取日期


        return(s);  

    } 
    function GetDate_rq(){
        if (document.getElementById('<%= T_RQ.ClientID %>').value=="")
        {
            document.getElementById('<%= T_RQ.ClientID %>').value=GetDateT();
        }
        
    }
    

    
    function clearNoNum(obj)
    {
        //先把非数字的都替换掉，除了数字和.
        obj.value = obj.value.replace(/[^\d.]/g,"");
        //必须保证第一个为数字而不是.
        obj.value = obj.value.replace(/^\./g,"");
        //保证只有出现一个.而没有多个.
        obj.value = obj.value.replace(/\.{2,}/g,".");
        //保证.只出现一次，而不能出现两次以上
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        
        GetDate_rq();
       
    }

</script>
    <form id="form1" runat="server">
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
        </ajaxToolkit:ToolkitScriptManager>
        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server"  TargetControlID="T_RQ" Format="yyyy-MM-dd"  />
    <div style="overflow:scroll; height:100%; width:100% ;overflow:auto; text-align :center;" >
    <table style="width:100%; height:100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td height="57" background="../images/main_03.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="378" height="57" background="../images/main_01.gif">&nbsp;</td>
        <td>&nbsp;</td>
        <td width="281" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="33" height="27"><img src="../images/main_05.gif" width="33" height="27" /></td>
            <td width="248" background="../images/main_06.gif"><table width="225" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td style="height: 17px"><div align="right"><a href="UserEdit.aspx" ><img src="../images/pass.gif" width="69" height="17" /></a></div></td>
                <td style="height: 17px"><div align="right"><a href="User.aspx"><img src="../images/user.gif" width="69" height="17" id="IMG1"  onclick="return IMG1_onclick()" /></a></div></td>
                <td style="height: 17px"><div align="right"><a href="" target="_parent"><asp:ImageButton Runat="Server" ID ="logout" src="../images/quit.gif"  width="69" height="17" OnClick="logout_Click"   /></a></div></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="40" background="../images/main_10.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="194" height="40" background="../images/main_07.gif">&nbsp;</td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="21"><img src="../images/main_13.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="../menu.aspx" >首页</a></div></td>
            <td width="21" class="STYLE7"><img src="../images/main_15.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="javascript:history.go(-1);">后退</a></div></td>
            <td width="21" class="STYLE7"><img src="../images/main_17.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="javascript:history.go(1);">前进</a></div></td>
            <td width="21" class="STYLE7"><img src="../images/main_19.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="javascript:window.parent.location.reload();">刷新</a></div></td>
            <td width="21" class="STYLE7"><img src="../images/main_21.gif" width="19" height="14" /></td>
            <td width="35" class="STYLE7"><div align="center"><a href="http://www.ftbattery.com" >帮助</a></div></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
        <td width="248" background="../images/main_11.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
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
    <td background="../images/main_31.gif" style="height: 30px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td style="height: 30px; width: 8px;"><img src="../images/main_28.gif" width="8" height="30" /></td>
                <td width="147" background="../images/main_29.gif" style="height: 30px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="24%" style="height: 20px">&nbsp;</td>
                            <td valign="bottom" class="STYLE1" style="width: 43%; height: 20px;"><a href ="ConfigMenu.aspx" >管理菜单</a></td>
                            <td width="33%" style="height: 20px">&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td width="39" style="height: 30px"><img src="../images/main_30.gif" width="39" height="30" /></td>
                <td style="height: 30px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="bottom" style="height: 20px"><span class="STYLE1"><asp:Label ID="L_user"   runat="server"></asp:Label></span></td>
                            <td valign="bottom" class="STYLE1" style="height: 20px"><div align="right"></div></td>
                        </tr>
                    </table>
                </td>
                <td width="17" style="height: 30px"><img src="../images/main_32.gif" width="17" height="30" /></td>
            </tr>
        </table>

    </td>
  </tr>
</table>

	</td>
  </tr>
  <tr  >
    <td style="height:100%">
	    <table width="100%" style="height:580px" border="0" cellspacing="0" cellpadding="0">
          <tr >
            <td bgcolor="#353c44" style="width: 8px">&nbsp;</td>
            <td valign="top" align="center"  style="height:100%; width: 1125px;" >
                <strong><span style="font-size: 20pt">
                                每日食堂计划量和实际用餐人数统计</span></strong><br />
            
            
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="5" style="text-align: center" Font-Names="Verdana" Font-Size="12px"
                 HeaderStyle-Font-Size="15px" RowStyle-Font-Size="15px" ShowFooter ="True" OnRowDeleting="GridView1_RowDeleting" align="center"
                 OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating" OnRowEditing="GridView1_RowEditing" Width="800px"  AllowPaging="True"
                 PageSize="12"  OnPageIndexChanging ="GridView1_PageIndexChanging" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"  >
                 <RowStyle ForeColor="#000066" Font-Size="15px" />
                 <Columns >
                    <asp:TemplateField  HeaderText ="类型">
                        <ItemTemplate  >
                             <asp:Label ID ="lx"    runat="server" Text ='<%#  Eval("lx") %>'/>
                        </ItemTemplate>
                        <EditItemTemplate>  
                            <asp:DropDownList ID="T_lxEdit" runat="server" Text='<%# Eval("lx") %>' >
                                <asp:ListItem>计划用餐人数</asp:ListItem>
                                <asp:ListItem>实际用餐人数</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>  
                        <ItemStyle Width="30%"   />
                    </asp:TemplateField>
                    <asp:TemplateField  HeaderText ="数量">
                        <ItemTemplate  >
                             <asp:Label ID ="sl"    runat="server" Text ='<%#  Eval("sl") %>'/>
                        </ItemTemplate>
                        <EditItemTemplate>  
                            <asp:TextBox ID="T_slEdit" runat="server" Text='<%# Eval("sl") %>' Width="100px" ></asp:TextBox>  
                        </EditItemTemplate>  
                        <ItemStyle Width="30%"   />
                    </asp:TemplateField>
                    <asp:TemplateField  HeaderText ="日期">
                        <ItemTemplate  >
                             <asp:Label ID ="rq"    runat="server" Text ='<%#  Eval("rq") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>  
                            <asp:TextBox ID="T_rqEdit" runat="server" Text='<%# Eval("rq") %>' Width="100px" ></asp:TextBox>  
                        </EditItemTemplate>  
                        <ItemStyle Width="20%"   />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="编辑" >
                        <ItemTemplate  >
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit">编辑</asp:LinkButton>
                        </ItemTemplate >
                        <EditItemTemplate>  
                            <asp:LinkButton ID="Button1" runat="server" Text="更新" CommandName="Update" />  
                        </EditItemTemplate>  
                        <ItemStyle Width="5%"   />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="删除" >
                        <ItemTemplate  >
                            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete"    OnClientClick='return confirm("此删除操作不可恢复，您确认删除此记录吗？")'>删除</asp:LinkButton>
                        </ItemTemplate >
                        <EditItemTemplate>  
                            <asp:LinkButton ID="Button3" runat="server" Text="取消" CommandName="Cancel" />  
                        </EditItemTemplate>  
                    <ItemStyle Width="5%"   />
                    </asp:TemplateField>

                 </Columns>
                 <PagerTemplate>
                    <table style="font-size :12px; text-align :center;">
                        <tr>
                            <td> 总共<asp:Label ID="Label1" runat="server" Text="<%#((GridView)Container.NamingContainer).PageCount %>"></asp:Label>页 &nbsp; </td>
                            <td> 第<asp:Label ID="Label2" runat="server" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"></asp:Label>页 &nbsp;</td>
                            <td><asp:LinkButton ID="LinkButton1" runat="server" CommandArgument ="1" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">首页</asp:LinkButton> &nbsp;</td>
                            <td><asp:LinkButton ID="LinkButton2" runat="server" CommandArgument ="Prev" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">上一页</asp:LinkButton> &nbsp;</td>
                            <td><asp:LinkButton ID="LinkButton3" runat="server" CommandArgument ="Next" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">下一页 </asp:LinkButton> &nbsp;</td>
                            <td><asp:LinkButton ID="LinkButton4" runat="server" CommandArgument ="Last" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">尾页</asp:LinkButton> &nbsp;</td>
                            <td><asp:LinkButton ID="LinkButton5" runat="server" CommandArgument ="-1" CommandName ="Page" ValidationGroup="1" >GO</asp:LinkButton> </td>
                            <td><asp:TextBox ID="txtNum" runat="server" Width="30px" Text ="<%#((GridView)Container.NamingContainer).PageIndex+1 %>" ValidationGroup="1"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="" ValidationExpression ="^/d+$" ControlToValidate ="txtNum" ValidationGroup="1"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                   </table>
                </PagerTemplate>
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" Font-Size="15px" />
                <FooterStyle BackColor="White" ForeColor="#000066" />
            </asp:GridView>
            <table width="800px" class ="T_Sample1"  align="center">
                <tr>
                    <td style="width:30%; height: 28px;"  align="center">
                        <asp:DropDownList ID="T_LX" runat="server"  >
                            <asp:ListItem Selected="True">计划用餐人数</asp:ListItem>
                            <asp:ListItem>实际用餐人数</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width:30%; height: 28px;" align="center"><asp:TextBox  ID ="T_SL" runat="server" Width="100px" onkeyup="clearNoNum(this)"  /></td>
                    <td style="width:20%; height: 28px;" align="center"><asp:TextBox  ID ="T_RQ" runat="server" Width="100px" /></td>
                    <td style="width:10%; height: 28px;" align="center"><asp:Button ID="B_TJ" runat="server" Text="添 加"  OnClick="B_TJ_Click" OnClientClick=" javaScript:return IntoClick()"/></td>
                </tr>
            </table>

            
            
            

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
    <td background="../images/main_71_1.gif"  style="line-height:11px; table-layout:fixed" width="218">&nbsp;</td>
    <td background="../images/main_72.gif"  style="line-height:11px; table-layout:fixed">&nbsp;</td>
    <td background="../images/main_74.gif"  style="line-height:11px; table-layout:fixed" width="17">&nbsp;</td>
  </tr>
</table></td>
  </tr>
</table>
    
    
    
    
    
        
    </div>
    </form>
</body>
</html>
