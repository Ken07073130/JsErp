<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="jpscrblb.aspx.cs" Inherits="jpscrblb" Title="生产日报" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >
<link rel="stylesheet" href="../jquery-ui/themes/base/jquery.ui.all.css">
<script src="../jquery-ui/jquery-1.10.2.js"></script>
<script src="../jquery-ui/ui/jquery.ui.core.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>金色能源数据系统</title>
</head>
<body>
<form id="form1" runat="server" >
<script type ="text/javascript"  >
function SelectAll() {
    //获取GridView中全部input对象集合，“GridView.ClientID”是获得经服务器处理后经过更改的id
    
    
    var obj = document.getElementById("GridView1").getElementsByTagName("input");  //注意此处代码在本博文发布时，新浪博客会自动更改，请自行更改
 
    //遍历input对象，因为input对象类型type只有checkbox所以不用判断。i=1是要去掉表头的input对象
    for (var i = 1; i < obj.length; i++) {
        if (obj[i].checked == false) {
            obj[i].checked = true;
        }
        else {
            obj[i].checked = false;
        }
    }

}
</script>
          <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
         </ajaxToolkit:ToolkitScriptManager>
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tb_Find_pc" ServicePath="../GetContent.asmx" ServiceMethod="GetKSDcpxhList"  MinimumPrefixLength="1" CompletionInterval="500" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"  TargetControlID="tb_Find_xh" ServicePath="../GetContent.asmx" ServiceMethod="GetkhdmList" MinimumPrefixLength="1"  CompletionInterval="500" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server"  TargetControlID="TB_scrq" Format="yyyy-MM-dd"  />
         <table width="100%" style="font-size:smaller"  >
            <tr>
                <td style="height: 60px" >
                  审核状态<asp:DropDownList ID="ddlHqzt" runat="server" OnSelectedIndexChanged="btnCX_Click" AutoPostBack="True" >
                     <asp:ListItem Selected="True" >未审核</asp:ListItem>
                     <asp:ListItem >全部</asp:ListItem>
                     <asp:ListItem >已审核</asp:ListItem>                 
                    </asp:DropDownList> 
                </td> 
                <td style="height: 60px">工序：
                </td> 
                <td style="height: 60px">
                <asp:DropDownList ID="DD_Find_gx" runat="server"  AutoPostBack="True" OnSelectedIndexChanged="DD_Find_gx_SelectedIndexChanged"  >
                    <asp:ListItem Value="25">正极搅拌</asp:ListItem >
                    <asp:ListItem Value="10">负极搅拌</asp:ListItem>
                    <asp:ListItem Value="26">正极涂布</asp:ListItem >
                    <asp:ListItem Value="11">负极涂布</asp:ListItem>
                    <asp:ListItem Value="27">正极分切</asp:ListItem>
                    <asp:ListItem Value="12">负极分切</asp:ListItem>
                    <asp:ListItem Value="28">正极分小片</asp:ListItem>
                    <asp:ListItem Value="13">负极分小片</asp:ListItem>
                    <asp:ListItem Value="30">正极铆接</asp:ListItem>
                    <asp:ListItem Value="15">负极铆接</asp:ListItem>
                    <asp:ListItem Value="40">卷绕</asp:ListItem>
                    <asp:ListItem Value="50">封装</asp:ListItem>
                    <asp:ListItem Value="55">注液</asp:ListItem>
                    <asp:ListItem Value="60">化成</asp:ListItem>
                    <asp:ListItem Value="65">二封</asp:ListItem>
                    <asp:ListItem Value="70">分选</asp:ListItem>
                    <asp:ListItem Value="75">包装</asp:ListItem>
                    <asp:ListItem Value="80">PACK</asp:ListItem>
                    <asp:ListItem Value="85">出货</asp:ListItem>
                    <asp:ListItem Selected="True"></asp:ListItem>             
                </asp:DropDownList> 
                </td>  
                <td style="height: 60px">
                    批次：
                </td>  
                <td style="height: 60px"><asp:TextBox id="tb_Find_pc" runat="server" Width="110px" onchange="this.value=this.value.split('|')[0];" ></asp:TextBox>
                </td> 
                <td style="height: 60px">型号：
                </td>  
                <td style="height: 60px"><asp:TextBox id="tb_Find_xh" runat="server" Width="110px"></asp:TextBox>
                </td>    
                <td style="height: 60px; width: 77px;"><asp:Button ID="b_Find" runat="server" Text="查  询" OnClick="b_Find_Click" />
                </td>     
                <td style="width: 323px; height: 60px;">
                 <table id="Table1" cellspacing="0" style="width: 302px"  >
                    <tr style="height: 42px">
                        <th style="width:28%"> 生成日期</th>
                        <td style="width:59%">
                            &nbsp;<asp:TextBox ID="TB_scrq" runat="server"></asp:TextBox> 
                           </td>
                        <td style="width:25%"><asp:Button ID="Button1" runat="server" Text="生成" OnClick="B_sc_Click" /></td>
                    </tr>
                </table>
                </td> 
             </tr>
         </table>
         <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td style="height: 30px; width: 1121px;">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFE0">
                         <tr >
                             <td rowspan="2" align="center" style="height: 31px" bgcolor="#FEEDC9" >
                                 <div style="margin:10px 0px;"><asp:LinkButton ID="lbTjbd" runat="server" OnClick="tjbd_Click" style="background-color:#FEEDC9;display: block ;text-align: center;color: #d84700;  font-size: 14px; font-weight: bold; text-decoration: none; " Width="120px">添加生产日报</asp:LinkButton></div>
                             <td rowspan="2" align="center" style="height: 31px;font-size:15px;font-weight:bold; width: 94%;">
                                 生产日报</td>

                         </tr>
                           <tr>
                           </tr>
                     </table>
                 </td>
             </tr>
             <tr>
                 <td style="width: 1121px">
                     <table border="0" cellpadding="0" cellspacing="0" class="STYLE10" width="100%">
                         <tr valign="top">
                             <td style="height: 199px; width: 1168px;">
                                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" style="text-align: center"
                                     Font-Names="Verdana" Font-Size="12px" AllowSorting="True" OnSorting="GridView1_Sorting"    OnRowUpdating="GridView1_RowUpdating" 
                                     OnRowDeleting="GridView1_RowDeleting"  OnRowCreated="GridView1_RowCreated"  
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"  AllowPaging="true" PageSize="100"  OnPageIndexChanging ="GridView1_PageIndexChanging"  >
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                        
                                        <asp:TemplateField  HeaderStyle-Width="7%">
                                            <ItemTemplate >
                                                <asp:CheckBox ID="chkItem" runat="server"  />
                <%--                                <asp:LinkButton ID="LinkButton3"  runat="server" CommandName ="Update" Text='<%# Eval("zt") %>'     ></asp:LinkButton>--%>
                                            </ItemTemplate>
                                            <HeaderTemplate >
                                                <input id="chkHeader" type="checkbox" onclick="SelectAll();"  />
                                                <asp:Button  id="B_SH" runat="server"   Text="审核"  OnClick="B_SH_Click" OnClientClick='return confirm("确认要审核选中的记录吗？")' />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="jpscrb.aspx?id={0}"
                                             DataTextField="id" HeaderText="ID"  ItemStyle-Width="5%"/>
                                         <asp:BoundField DataField="gxmc" HeaderText="工序名称" ReadOnly="True"  >
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="scrq" HeaderText="生产日期" DataFormatString="{0:yyyy-MM-dd}"  >
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="xh" HeaderText="型号">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="rl" HeaderText="容量">
                                             <ItemStyle Width="5%" />
                                         </asp:BoundField>
                                        <asp:BoundField DataField="pc" HeaderText="批次">
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="drsc" HeaderText="当日生产">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="drzc" HeaderText="当日转出">
                                             <ItemStyle Width="8%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="bz" HeaderText="备注">
                                             <ItemStyle Width="22%" />
                                         </asp:BoundField>
                                        <asp:TemplateField >
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton3"  runat="server" CommandName ="Update" Text='<%# Eval("zt") %>'     ></asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderTemplate>审核</HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField >
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete"    OnClientClick='return confirm("此删除操作不可恢复，您确认删除此记录吗？")'>删除</asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderTemplate>删除</HeaderTemplate>
                                        </asp:TemplateField>

                                     </Columns>
                                      <PagerTemplate>
                                           <table style="font-size :12px;">
                                           <tr>
                                        
                                             <td> 总共<asp:Label ID="Label1" runat="server" Text="<%#((GridView)Container.NamingContainer).PageCount %>"></asp:Label>页 &nbsp; </td>
                                            
                                                <td> 第<asp:Label ID="Label2" runat="server" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"></asp:Label>页 &nbsp;</td>
                                             
                                                      <td> <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument ="1" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">首页</asp:LinkButton> &nbsp;</td>
                                                      <td>
                                                          <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument ="Prev" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">上一页</asp:LinkButton> &nbsp;</td>
                                                          <td>
                                                              <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument ="Next" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">下一页 </asp:LinkButton> &nbsp;</td>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton4" runat="server" CommandArgument ="Last" CommandName ="Page" Enabled ="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">尾页</asp:LinkButton> &nbsp;</td>
                                                            <td>
                                                                <asp:LinkButton ID="LinkButton5" runat="server" CommandArgument ="-1" CommandName ="Page" ValidationGroup="1" >GO</asp:LinkButton> </td>
                                                                <td>
                                                        <asp:TextBox ID="txtNum" runat="server" Width="30px" Text ="<%#((GridView)Container.NamingContainer).PageIndex+1 %>" ValidationGroup="1"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="" ValidationExpression ="^/d+$" ControlToValidate ="txtNum" ValidationGroup="1"></asp:RegularExpressionValidator>
                                               </td>
                                           </tr>
                                           </table>
                                        </PagerTemplate>
                                     <FooterStyle BackColor="White" ForeColor="#333333" />
                                     <PagerStyle BackColor="#479AC7" ForeColor="White" HorizontalAlign="Center" />
                                     <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                                     <HeaderStyle BackColor="#479AC7" Font-Bold="True" ForeColor="White" />
                                 </asp:GridView>
                             </td>
                         </tr>
                     </table>
                 </td>
             </tr>
             <tr>
                 <td height="30" style="width: 1121px">
               
                 </td>
             </tr>
         </table>
        <div id="dialog-form" title="选择生成日期">

        </div>     
         
         
    </form>
    </body>
    </html>

