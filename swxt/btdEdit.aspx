<%@ Page Language="C#" AutoEventWireup="true" CodeFile="btdEdit.aspx.cs" Inherits="btdEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>采购单</title>
    <link rel="stylesheet" type="text/css" href="css/htpsb.css" />
    <style type="text/css">
       .ulSign {
         width:243px;  
         float:left;
       }
       .ulSign li {
         width:220px;
       }
     </style>

    <script type="text/javascript">
    
     
       
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
            AsyncPostBackTimeout="600" EnableScriptGlobalization="true" />
        <div id="divPage">
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">单号</span><span class="spanControl"><asp:TextBox ID="TextBox1"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">提出</span><span class="spanControl"><asp:TextBox ID="TextBox2"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">日期</span><span class="spanControl"><asp:TextBox ID="TextBox12"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">客户代码</span><span class="spanControl"><asp:TextBox ID="TextBox13"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li style="width: 474px;"><span class="spanLabel">订单号</span><span class="spanControl"><asp:TextBox
                        ID="TextBox3" runat="server" Width="368px"></asp:TextBox></span></li><li><span class="spanLabel">
                            缺货数量</span><span class="spanControl"><asp:TextBox ID="tbJhs" runat="server" Width="90%"></asp:TextBox></span></li><li>
                                <span class="spanLabel">评审投量</span><span class="spanControl"><asp:TextBox ID="tbScjhrq"
                                    runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">规格书型号</span><span class="spanControl"><asp:TextBox ID="TextBox4"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部电芯型号</span><span class="spanControl"><asp:TextBox ID="TextBox5"
                        runat="server" onchange="setPlpc();" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部包装型号</span><span class="spanControl"><asp:TextBox ID="TextBox6"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部PACK型号</span><span class="spanControl"><asp:TextBox
                        ID="TextBox7" runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">电芯预计补投</span><span class="spanControl"><asp:TextBox ID="TextBox8"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">正极预计补投</span><span class="spanControl"><asp:TextBox ID="TextBox9"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">负极预计补投</span><span class="spanControl"><asp:TextBox ID="TextBox10"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">PACK预计补投</span><span class="spanControl"><asp:TextBox
                        ID="TextBox11" runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">容量</span><span class="spanControl"><asp:TextBox ID="TextBox14"
                        runat="server" Width="58%"></asp:TextBox>
                        <asp:TextBox ID="TextBox15" runat="server" Width="23%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">评审交期</span><span class="spanControl"><asp:TextBox ID="TextBox16"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">交期延迟</span><span class="spanControl"><asp:TextBox ID="TextBox17"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">交期延迟</span><span class="spanControl"><asp:TextBox ID="TextBox18"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li style="width:95%; height:25px;"><span class="spanLabel">生产批号</span><asp:TextBox ID="TextBox19"
                        runat="server" Width="88%"></asp:TextBox></li>
                        <li style=" width:95%;"><span class="spanLabel">情况描述</span><asp:TextBox ID="TextBox20"
                            runat="server" Rows="5" TextMode="MultiLine" Width="88%"></asp:TextBox></li>
            </div>
            <div class="layout">
                 <ul class="ulSign" style="">
                   <li>1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                 </ul>
                  <ul class="ulSign">
                   <li>1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                 </ul>
                 <ul class="ulSign">
                   <li>1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                 </ul>
                 <ul class="ulSign">
                   <li>1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                 </ul>
            </div>
             <div class="layout" style="margin-top:20px;">
                 <ul class="ulSign" >
                   <li>1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                 </ul>
                  <ul class="ulSign">
                   <li>1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                 </ul>
                 <ul class="ulSign">
                   <li>1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                 </ul>
                 <ul class="ulSign">
                   <li>1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                 </ul>
            </div>
            <div>
                <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                    AutoGenerateColumns="false" BorderStyle="None" BorderWidth="1px" CellPadding="4"
                    ForeColor="Black" GridLines="Vertical" EmptyDataText="暂无计划" EmptyDataRowStyle-BackColor="#40e0d0"
                    Width="800" Style="margin: 0 auto; text-align: center;" OnRowDeleting="GridView1_RowDeleting"
                    OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="tczt" HeaderText="投产状态" ItemStyle-Width="15%" />
                        <asp:CommandField ShowDeleteButton="true" HeaderText="删除" ItemStyle-Width="5%" />
                        <asp:BoundField DataField="ph" HeaderText="批号" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="jhs" HeaderText="计划数" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="scjhrq" HeaderText="生产计划日期" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="plpc" HeaderText="配料批次" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="djlsh" ItemStyle-Width="20%">
                            <ControlStyle CssClass="hidden" />
                            <FooterStyle CssClass="hidden" />
                            <HeaderStyle CssClass="hidden" />
                            <ItemStyle CssClass="hidden" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" />
                    <FooterStyle BackColor="#CCCC99" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:LinkButton ID="lbAddtr" runat="server" Style="font-size: 15px; color: white;
                    line-height: 28px; background-color: #3385ff; text-align: center; text-decoration: none"
                    Width="150px" OnClick="lbAddtr_Click" OnClientClick="return checkTcsl()">添加到投产计划列表</asp:LinkButton>
            </div>
        </div>
    </form>
</body>
</html>
