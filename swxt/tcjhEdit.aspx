<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tcjhEdit.aspx.cs" Inherits="tcjhEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>采购单</title>
    <link rel="stylesheet" type="text/css" href="css/htpsb.css" />
    <style type="text/css">
    /* CSS Document */
    .hover{
        cursor:pointer;
        background-color:#bcd4ec;  
       
    }   /*这里是鼠标经过时的颜色*/ 
    
     </style>

    <script type="text/javascript">
    
       //设置iframe页面属性
       function setIframeSrc(){
           if (document.getElementById('tbDjlx').value=="订单") {
               var bh = document.getElementById('tbPsdbh').value;
               var url = 'htpsbEdit.aspx?bh=' + bh + '&lb=EDIT&editType=查看';
               document.getElementById('ihtpsb').src = url;
               document.getElementById('ihtpsb').height = 400;
           } else if (document.getElementById('tbDjlx').value == "补投单") {
               var bh = document.getElementById('tbPsdbh').value;
               var url = 'btdEdit.aspx?xh=' + bh + '&lb=EDIT&editType=查看';
               document.getElementById('ihtpsb').src = url;
               document.getElementById('ihtpsb').height = 300;

           }

         
       }
       
       //设置配料批次
       function setPlpc(){
         //批号小写转大写
         var ph=document.getElementById('tbPh').value.toUpperCase();
         document.getElementById('tbPh').value=ph;
         if(ph.length>10){
           document.getElementById('tbPlpc').value=ph.substr(3,4)+'-'+ph.substr(8,1);
         } else {
           document.getElementById('tbPlpc').value=ph.substr(2,4)+'-'+ph.substr(7,1);
         }
       }
       
       window.onload=setIframeSrc;
       
       function checkTcsl(){
         /*7、当“计划总数”大于“投产数量”，且状态为“待投产”时，探出提示对话框，
             “计划总数已大于投产数量，单据状态仍为“待投产”，是否继续?”*/
         var htpsbTcsl=document.getElementById('ihtpsb').contentWindow.document.getElementById('tbTcsl').value;
         if( (parseInt(document.getElementById('lbTczs').innerHTML)>parseInt(htpsbTcsl)) && (document.getElementById('ddlZt').value=='待投产') ){
            if(confirm('计划总数已大于投产数量，单据状态仍为"待投产"，是否继续添加计划数')){
               
            } else {
               return false;
            }
         }
       }
       
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
            AsyncPostBackTimeout="600" EnableScriptGlobalization="true" />
        <div id="divPage">
            <div class="layout" style="margin-bottom: 8px; margin-top: -50px;">
                <iframe id="ihtpsb" name="htpsb" style="border: 2px solid #CC9999;" scrolling="no"
                    width="995px;" height="400px;"></iframe>
            </div>
            <div class="layout" style="margin-bottom: 10px; border: 2px solid #99CCFF;">
                <ul style="height: 28px; margin-bottom: 10px;">
                    <li><span class="spanLabel">状态</span><span class="spanControl"><asp:DropDownList
                        ID="ddlZt" runat="server">
                        <asp:ListItem>待投产</asp:ListItem>
                        <asp:ListItem>投产完成</asp:ListItem>
                    </asp:DropDownList>
                        <asp:LinkButton Style="font-size: 11px; color: white; line-height: 20px; background-color: #3385ff;
                            text-align: center; text-decoration: none" ID="lbSubmit" runat="server" Width="55px"
                            OnClick="lbSubmit_Click" CausesValidation="false">提交状态</asp:LinkButton></span></li>
                    <li><span class="spanLabel">合同编号</span><span class="spanControl"><asp:TextBox ID="tbPsdbh"
                        runat="server" Width="95%" Height="14px" ReadOnly="true"></asp:TextBox></span></li>
                    <li>投产总数：<asp:Label ID="lbTczs" runat="server" Font-Size="15" Text="0" ForeColor="Red"></asp:Label></li>
                    <li><asp:CheckBox ID="cbBgzt" runat="server" Text="变更内容已知悉，并已处理！" /></li>
                </ul>
                <ul>
                    <li><span class="spanLabel">投产状态</span><span class="spanControl"><asp:DropDownList
                        ID="ddlTczt" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>电芯</asp:ListItem>
                        <asp:ListItem>正极片</asp:ListItem>
                        <asp:ListItem>负极片</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlTczt"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择投产状态" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator></span></li>
                    <li><span class="spanLabel">批号</span><span class="spanControl"><asp:TextBox ID="tbPh"
                        runat="server" Width="90%" onchange="setPlpc();"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbPh"
                            Display="Dynamic" ErrorMessage="请填写批号" SetFocusOnError="true"></asp:RequiredFieldValidator></span></li>
                    <li><span class="spanLabel">计划数</span><span class="spanControl"><asp:TextBox ID="tbJhs"
                        runat="server" Width="90%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbJhs"
                            Display="Dynamic" ErrorMessage="请填写计划数" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbJhs"
                            Display="Dynamic" ErrorMessage="计划数只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator></span></li>
                    <li><span class="spanLabel">生产计划日期</span><span class="spanControl"><asp:TextBox ID="tbScjhrq"
                        runat="server" Width="90%"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd"
                            TargetControlID="tbScjhrq">
                        </ajaxToolkit:CalendarExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbScjhrq"
                            Display="Dynamic" ErrorMessage="请填写计划日期" SetFocusOnError="true"></asp:RequiredFieldValidator></span></li>
                    <li><span class="spanLabel">配料批次</span><span class="spanControl"><asp:TextBox ID="tbPlpc"
                        runat="server" Width="90%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbPlpc"
                            Display="Dynamic" ErrorMessage="请填写配料批次" SetFocusOnError="true"></asp:RequiredFieldValidator></span></li>
                    <li style="height: 28px; border: 0; margin-left: 20px;">
                        <asp:LinkButton ID="lbAddtr" runat="server" Style="font-size: 15px; color: white;
                            line-height: 28px; background-color: #3385ff; text-align: center; text-decoration: none"
                            Width="150px" OnClick="lbAddtr_Click"  OnClientClick="return checkTcsl()">添加到投产计划列表</asp:LinkButton></li></ul>
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
            </div>
            <div >
                <asp:TextBox ID="tbDjlx" runat="server"></asp:TextBox>
            </div>
        </div>
    </form>
</body>
</html>
