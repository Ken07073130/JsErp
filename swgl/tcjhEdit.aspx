<%@ Page Language="C#" MasterPageFile="~/swgl/main.master" AutoEventWireup="true" CodeFile="tcjhEdit.aspx.cs" Inherits="swgl_tcjhEdit" Title="投产计划" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<head id="Head1" >

<title>投产计划</title>
<style type="text/css">
table.gridtable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#333333;
    border-width: 1px;
    border-color: #666666;
    border-collapse: collapse;
}

table.gridtable td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #666666;
    background-color: #ffffff;
}
</style>

<script type="text/javascript">
    //选中所有行
    function SelectAll(chkAll)
    {
        var gridview = document.getElementById("GV_BT");
        if (gridview)
        {
           //获取到GridView1中的所有input标签
           var inputs = gridview.getElementsByTagName("input");
           for(var i=0;i<inputs.length;i++)
           {
              if (inputs[i].type=="checkbox")
              {
                 //设置所有checkbox的选中状态与chkAll一致
                 inputs[i].checked = chkAll.checked;
              }
           }
        }
   }
  
   //给选中行换背景色
   function checkRow(chkRow)
   {
      var row = chkRow.parentNode.parentNode;
      if(row)
      { 
           if (chkRow.checked)
               row.style.backgroundColor="#7799CC";
            else
               row.style.backgroundColor="#FFFFFF";
       }
   } 
</script>





</head>

<table width="800" border="0" cellspacing="0" cellpadding="0" align="center"   class="gridtable" >
      <tr>
        <td style="height: 14px; width:80px" >电芯型号</td>
        <td style="height: 14px; width:120px"><asp:TextBox ID="T_DXXH" runat="server" Width="110px"></asp:TextBox></td>
        <td style="height: 14px; width:80px">型号代码</td>
        <td style="height: 14px; width:120px"><asp:TextBox ID="T_XHDM" runat="server" Width="110px"></asp:TextBox></td>
        <td style="height: 14px; width:80px">PACK型号</td>
        <td style="height: 14px; width:120px"><asp:TextBox ID="T_packXH" runat="server" Width="110px"></asp:TextBox></td>
        <td style="height: 14px; width:80px"></td>
        <td style="height: 14px; width:120px"></td>

      </tr>
        <tr>
            <td style="width: 88px; height: 14px">
                客户代码</td>
            <td style="height: 14px">
                <asp:TextBox ID="T_KHDM" runat="server" Width="110px"></asp:TextBox></td>
            <td style="height: 14px">
                客户型号</td>
            <td style="width: 111px; height: 14px">
                <asp:TextBox ID="T_KHXH" runat="server" Width="110px"></asp:TextBox></td>
            <td style="height: 14px">
                订单总数量</td>
            <td style="height: 14px">
                <asp:TextBox ID="T_DDZSL" runat="server" Width="110px"></asp:TextBox></td>
            <td style="width: 60px; height: 14px;">
                批次总数量</td>
            <td style="height: 14px">
                <asp:TextBox ID="T_PCZSL" runat="server" Width="110px"></asp:TextBox></td>

        </tr>
      <tr>
        <td style="height: 14px; width: 88px;">录入日期</td>
        <td style="height: 14px"><asp:TextBox ID="T_LRRQ" runat="server" Width="110px" ></asp:TextBox></td>
        <td style="height: 14px">录入人</td>
        <td style="height: 14px; width: 111px;"><asp:TextBox ID="T_LRR" runat="server" Width="110px"></asp:TextBox></td>
        <td style="height: 14px">订单流水号</td>
        <td style="height: 14px"><asp:TextBox ID="T_DDLSH" runat="server" Width="110px"></asp:TextBox></td>
        <td style="width: 60px; height: 14px">&nbsp;</td>
        <td style="height: 14px">&nbsp;</td>

      </tr>
      <tr>
        <td  colspan="8">
        <div>
            <asp:LinkButton ID="lbtnAddRow" runat="server" Width="80px" OnClick="lbtnAddRow_Click">添加行</asp:LinkButton>
            <asp:LinkButton ID="btnDeleteRow" runat="server" OnClick="btnDeleteRow_Click" OnClientClick="return confirm('确定要删除选中行吗？');">删除选中行</asp:LinkButton> 
        </div> 
            <asp:GridView ID="GV_BT" runat="server" AllowPaging="true" AutoGenerateColumns="False"
                BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
                CellPadding="4" EmptyDataRowStyle-BackColor="#40e0d0" EmptyDataText="无记录" Font-Names="Verdana"
                Font-Size="12px" GridLines="Horizontal" OnPageIndexChanging="GridView1_PageIndexChanging"
                OnRowDataBound="GridView1_RowDataBound" OnRowDeleting="GridView1_RowDeleting"
                OnRowEditing="GridView1_RowEditing" PageSize="20" Style="text-align: center"
                Width="100%">
                <RowStyle BackColor="White" ForeColor="#333333" />
                <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                       <input id="chkAll" type="checkbox" onclick="SelectAll(this)" />
                    </HeaderTemplate> 
                    <ItemTemplate>
                        <input id="chkRow" type="checkbox" onclick="checkRow(this);" runat="server" />
                    </ItemTemplate>
                    <ItemStyle Width="3%" HorizontalAlign="Center" BorderColor="#507CD1" BorderWidth="1px" />
                </asp:TemplateField>
                
                    <asp:BoundField DataField="DjBth" HeaderText="编号">
                        <ItemStyle Width="5%" />
                    </asp:BoundField>
              <asp:TemplateField HeaderText="单据类型">
                    <ItemTemplate>
                    
                        <asp:TextBox ID="DJXH" runat="server" Text='<%# Bind("DJXH") %>' BorderStyle="None"  Width="100px"></asp:TextBox>
                    </ItemTemplate>
                    <ItemStyle Width="10%" />
                </asp:TemplateField>
<%--                    <asp:BoundField DataField="DJXH" HeaderText="单据类型">
                        <ItemStyle Width="10%" />
                    </asp:BoundField>--%>
                    <asp:BoundField DataField="DDH" HeaderText="单号">
                        <ItemStyle Width="15%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DDSL" HeaderText="数量">
                        <ItemStyle Width="10%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DJSJ" HeaderText="登记时间" HtmlEncode="false" DataFormatString="{0:yyyy-MM-dd}">
                        <ItemStyle Width="10%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PSDH" HeaderText="评审单号">
                        <ItemStyle Width="10%" />
                    </asp:BoundField>
                    <asp:CommandField HeaderText="修改" ShowEditButton="True">
                        <ItemStyle Width="5%" />
                    </asp:CommandField>
                    <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                        <ItemStyle Width="5%" />
                    </asp:CommandField>
                </Columns>
                <PagerTemplate>
                    <table style="font-size: 12px;">
                        <tr>
                            <td>
                                总共<asp:Label ID="Label1" runat="server" Text="<%#((GridView)Container.NamingContainer).PageCount %>"></asp:Label>页
                                &nbsp;
                            </td>
                            <td>
                                第<asp:Label ID="Label2" runat="server" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"></asp:Label>页
                                &nbsp;</td>
                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="1" CommandName="Page"
                                    Enabled="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">首页</asp:LinkButton>
                                &nbsp;</td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument="Prev" CommandName="Page"
                                    Enabled="<%#((GridView)Container.NamingContainer).PageIndex!=0 %>">上一页</asp:LinkButton>
                                &nbsp;</td>
                            <td>
                                <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="Next" CommandName="Page"
                                    Enabled="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">下一页 </asp:LinkButton>
                                &nbsp;</td>
                            <td>
                                <asp:LinkButton ID="LinkButton4" runat="server" CommandArgument="Last" CommandName="Page"
                                    Enabled="<%#((GridView)Container.NamingContainer).PageIndex!=((GridView)Container.NamingContainer).PageCount-1 %>">尾页</asp:LinkButton>
                                &nbsp;</td>
                            <td>
                                <asp:LinkButton ID="LinkButton5" runat="server" CommandArgument="-1" CommandName="Page"
                                    ValidationGroup="1">GO</asp:LinkButton>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNum" runat="server" Text="<%#((GridView)Container.NamingContainer).PageIndex+1 %>"
                                    ValidationGroup="1" Width="30px"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNum"
                                    ErrorMessage="" ValidationExpression="^/d+$" ValidationGroup="1"></asp:RegularExpressionValidator>
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
      <tr>
        <td  colspan="8">

        <asp:GridView ID="GV_FT" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
                                     Font-Names="Verdana" Font-Size="12px" OnRowDataBound="GridView1_RowDataBound"
                                     OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing"  
                                     emptydatatext="无记录"  
                                     Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal"   AllowPaging="true" PageSize="20"  OnPageIndexChanging ="GridView1_PageIndexChanging" EmptyDataRowStyle-BackColor="#40e0d0">
                                     <RowStyle ForeColor="#333333" BackColor="White" />
                                     <Columns >
                                         <asp:BoundField DataField="DjFth" HeaderText="编号" >
                                             <ItemStyle Width="5%" />
                                         </asp:BoundField>

                                         <asp:BoundField DataField="TCZT" HeaderText="投产状态">
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="PH" HeaderText="批号" >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="JHSL" HeaderText="计划数量" >
                                             <ItemStyle Width="10%"  />
                                         </asp:BoundField>
                                        <asp:BoundField DataField="SCJHRQ" HeaderText="生产计划日期" HtmlEncode="false" DataFormatString="{0:yyyy-MM-dd}">
                                             <ItemStyle Width="10%"  />
                                         </asp:BoundField>
                                          <asp:BoundField DataField="PLPC" HeaderText="配料批次"  >
                                             <ItemStyle Width="10%" />
                                         </asp:BoundField>
                                         <asp:BoundField DataField="PCBZ" HeaderText="批次备注" >
                                             <ItemStyle Width="10%"  />
                                         </asp:BoundField>
                                         <asp:CommandField HeaderText="修改" ShowEditButton="True">
                                             <ItemStyle Width="5%" />
                                         </asp:CommandField>
                                         <asp:CommandField HeaderText="删除" ShowDeleteButton="True">
                                             <ItemStyle Width="5%" />
                                         </asp:CommandField>
                                       
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
</asp:Content>

