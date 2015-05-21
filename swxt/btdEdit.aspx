<%@ Page Language="C#" AutoEventWireup="true" CodeFile="btdEdit.aspx.cs" Inherits="btdEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>采购单</title>
    <link rel="stylesheet" type="text/css" href="css/htpsb.css" />
    <style type="text/css">
        .ulSign {
            width: 243px;
            float: left;
        }

            .ulSign li {
                width: 220px;
            }

        .spanText {
            width: 80px;
            text-align: center;
            display: inline-block;
            margin: 3px 0px;
        }
    </style>

    <script type="text/javascript">
      
        
    
        //签名通用 生成签名人+签名时间
        function qm(controlName) {
            //签名者
            var bm = controlName.replace('ddl', '').replace('psjg', '');
            var hqr = 'tb' + bm + 'hqr';
            document.getElementById(hqr).value = document.getElementById('tbUserName').value;
            var hqsj = 'tb' + bm + 'hqsj';
            var date = new Date();
            //签名日期
            var hours = date.getHours() > 9 ? date.getHours().toString() : '0' + date.getHours().toString();
            var minutes = date.getMinutes() > 9 ? date.getMinutes().toString() : '0' + date.getMinutes().toString();
            var seconds = date.getSeconds() > 9 ? date.getSeconds().toString() : '0' + date.getSeconds().toString();
            var sj = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate() + ' ' + hours + ':' + minutes + ':' + seconds;
            document.getElementById(hqsj).value = sj;
        }

        /*会签流程*/
        function lc(control) {
            qm(control.name);
            var bm = control.name.replace('ddl', '').replace('psjg', '');
            //同意生产或者有条件通过的，流程进行流转
            if (control.value == '同意补投') {
                //PMC评审
                if (control.name == 'ddlPMCpsjg') {
                    if (document.getElementById('ddlZlhqzt').value == '-') {
                        document.getElementById('ddlZlhqzt').value = '会签中';
                    }
                    document.getElementById('tbLchqzt').value = '质量会签';
                }

                //质量评审
                if (control.name == 'ddlZlpsjg') {
                    if (document.getElementById('ddlGchqzt').value == '-') {
                        document.getElementById('ddlGchqzt').value = '会签中';
                    }
                    document.getElementById('tbLchqzt').value = '工程会签';
                }

                //工程评审
                if (control.name == 'ddlGcpsjg') {
                    if (document.getElementById('ddlZzhqzt').value == '-') {
                        document.getElementById('ddlZzhqzt').value = '会签中';
                    }
                    if (document.getElementById('ddlSbhqzt').value == '-') {
                        document.getElementById('ddlSbhqzt').value = '会签中';
                    }
                    document.getElementById('tbLchqzt').value = '制造、设备会签';
                }


                //设备部+制造
                if (control.name == 'ddlSbpsjg' || control.name == 'ddlZzpsjg') {
                    if ((document.getElementById('ddlSbpsjg').value == '同意补投') &&
                         (document.getElementById('ddlZzpsjg').value == '同意补投')
                    ) {
                        if (document.getElementById('ddlSczjhqzt').value == '-') {
                            document.getElementById('ddlSczjhqzt').value = '会签中';
                        }
                        document.getElementById('tbLchqzt').value = '生产总监会签';
                    }
                }
                //设备部+制造结束

                //生产总监
                if (control.name == 'ddlSczjpsjg') {
                    if (document.getElementById('ddlZghqzt').value == '-') {
                        document.getElementById('ddlZghqzt').value = '会签中';
                    }
                    document.getElementById('tbLchqzt').value = '总工会签';
                }

                //总工总监
                if (control.name == 'ddlZgpsjg') {
                    if (document.getElementById('ddlGylhqzt').value == '-') {
                        document.getElementById('ddlGylhqzt').value = '会签中';
                    }
                    document.getElementById('tbLchqzt').value = '供应链会签';
                }

                //供应链
                if (control.name == 'ddlGylpsjg') {
                    if (document.getElementById('ddlSwjlhqzt').value == '-') {
                        document.getElementById('ddlSwjlhqzt').value = '会签中';
                    }
                    document.getElementById('tbLchqzt').value = '商务经理会签';
                }

                //商务经理
                if (control.name == 'ddlSwjlpsjg') {
                    if (document.getElementById('ddlZjlzlhqzt').value == '-') {
                        document.getElementById('ddlZjlzlhqzt').value = '会签中';
                    }
                    document.getElementById('tbLchqzt').value = '总助会签';
                }

                //总助经理
                if (control.name == "ddlZjlzlpsjg") {
                    document.getElementById('tbLchqzt').value = "已完成";
                }

            }

            //同意补投.变成已会签
            if (control.value == '同意补投') {
                var controlHqzt = 'ddl' + bm + 'hqzt';
                document.getElementById(controlHqzt).value = '已会签';
            }
        }
        
        
        function upperCase(control){
           var x=document.getElementById(control.id).value;
           document.getElementById(control.id).value=x.toUpperCase();
        }
        
        //提交时，判断退回部门是否为空
        function thbm(){
           if(document.getElementById('ddlThbm').value!='请选择'){
             var selectIndex=document.getElementById('ddlThbm').selectedIndex;
             var selectText=document.getElementById('ddlThbm').options[selectIndex].text;
             if(confirm("是否确认将单据退回到部门："+selectText)){
                var bmhqzt='ddl'+document.getElementById('ddlThbm').value+'hqzt';
                document.getElementById(bmhqzt).value='会签中';
                document.getElementById('tbLchqzt').value='退回'+selectText+'处理';
             } else { return false;}
           }
        }
        
        
      


    </script>

</head>
<body>
    <form id="form1" runat="server">
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="200"
            EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetkhdmList" ServicePath="~/GetContent.asmx"
            TargetControlID="tbKhdm" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="200"
            EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetHtDxxhList" ServicePath="~/GetContent.asmx"
            TargetControlID="tbNbdxxh" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="tbNbpackxh"
            ServicePath="~/GetContent.asmx" ServiceMethod="GetgGgsxhList" MinimumPrefixLength="1"
            EnableCaching="true" CompletionInterval="200" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="tbGgsxh"
            ServicePath="~/GetContent.asmx" ServiceMethod="GetgGgsxhList" MinimumPrefixLength="1"
            EnableCaching="true" CompletionInterval="200" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" TargetControlID="tbNbbzxh"
            ServicePath="~/GetContent.asmx" ServiceMethod="GetHtDxxhList" MinimumPrefixLength="1"
            EnableCaching="true" CompletionInterval="200" />

        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="true"
            EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
        </ajaxToolkit:ToolkitScriptManager>
        <div id="divPage">
            <div class="layout" style="text-align: center; font-weight: bold; font-size: 25px;">生产补投单<asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="CustomValidator" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator></div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">单号</span><span class="spanControl"><asp:TextBox ID="tbBh"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">提出</span><span class="spanControl"><asp:TextBox ID="tbTc"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">日期</span><span class="spanControl"><asp:TextBox ID="tbJbrq"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">客户代码</span><span class="spanControl"><asp:TextBox ID="tbKhdm"
                        runat="server" Width="90%" onchange="upperCase(this)"></asp:TextBox></span></li>
                    <li style="width: 474px;"><span class="spanLabel">订单号</span><span class="spanControl"><asp:TextBox
                        ID="tbDdh" runat="server" Width="363px"></asp:TextBox></span></li>
                    <li><span class="spanLabel">缺货数量</span><span class="spanControl"><asp:TextBox ID="tbQhsl" runat="server" Width="50%"></asp:TextBox>&nbsp;<asp:DropDownList ID="ddlDw3" runat="server">
                        <asp:ListItem>PCS</asp:ListItem>
                        <asp:ListItem>组</asp:ListItem>
                    </asp:DropDownList>
                    </span></li>
                    <li>
                        <span class="spanLabel">订单总数量</span><span class="spanControl"><asp:TextBox ID="tbDdzsl"
                            runat="server" Width="51%"></asp:TextBox>
                            <asp:DropDownList ID="ddlDw4" runat="server">
                                <asp:ListItem>PCS</asp:ListItem>
                                <asp:ListItem>组</asp:ListItem>
                            </asp:DropDownList></span></li>
                    <li><span class="spanLabel">评审单投量</span><span class="spanControl"><asp:TextBox ID="tbPsdzl"
                        runat="server" Width="50%"></asp:TextBox>&nbsp;<asp:DropDownList ID="ddlDw2" runat="server">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                    </span></li>
                    <li><span class="spanLabel">评审交期</span><span class="spanControl"><asp:TextBox ID="tbPsjq"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">交期延迟</span><span class="spanControl"><asp:TextBox ID="tbJqyc"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">容量</span><span class="spanControl"><asp:TextBox ID="tbRl"
                        runat="server" Width="90%"></asp:TextBox>
                    </span></li>
                    <li><span class="spanLabel">规格书型号</span><span class="spanControl"><asp:TextBox ID="tbGgsxh"
                        runat="server" Width="90%" onchange="upperCase(this)"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部电芯型号</span><span class="spanControl"><asp:TextBox ID="tbNbdxxh"
                        runat="server" onblur="upperCase(this)" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部包装型号</span><span class="spanControl"><asp:TextBox ID="tbNbbzxh"
                        runat="server" Width="90%" onblur="upperCase(this)"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部PACK型号</span><span class="spanControl"><asp:TextBox
                        ID="tbNbpackxh" runat="server" Width="90%" onblur="upperCase(this)"></asp:TextBox></span></li>
                    <li><span class="spanLabel">电芯预计补投</span><span class="spanControl"><asp:TextBox ID="tbDxyjbt"
                        runat="server" Width="50%"></asp:TextBox>
                        <asp:DropDownList ID="ddlDw6" runat="server">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="tbDxyjbt" Display="Dynamic" ErrorMessage="数量只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
                        </span></li><li><span class="spanLabel">正极预计补投</span><span class="spanControl"><asp:TextBox ID="tbZjyjbt"
                        runat="server" Width="50%"></asp:TextBox>
                        <asp:DropDownList ID="ddlDw7" runat="server">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbZjyjbt" Display="Dynamic" ErrorMessage="数量只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
                    </span></li>
                    <li><span class="spanLabel">负极预计补投</span><span class="spanControl"><asp:TextBox ID="tbFjyjbt"
                        runat="server" Width="50%"></asp:TextBox>
                        <asp:DropDownList ID="ddlDw8" runat="server">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="tbFjyjbt" Display="Dynamic" ErrorMessage="数量只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
                    </span></li>
                    <li><span class="spanLabel">PACK预计补投</span><span class="spanControl"><asp:TextBox
                        ID="tbPackyjbt" runat="server" Width="50%"></asp:TextBox>
                        <asp:DropDownList ID="ddlDw5" runat="server">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="tbPackyjbt" Display="Dynamic" ErrorMessage="数量只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
                    </span></li>

                    <li style="width: 95%; height: 25px;"><span class="spanLabel">生产批号</span><asp:TextBox ID="tbScph"
                        runat="server" Width="88%"></asp:TextBox></li>
                    <li style="width: 95%;"><span class="spanLabel">情况描述</span><asp:TextBox ID="tbQkms"
                        runat="server" Rows="5" TextMode="MultiLine" Width="88%"></asp:TextBox></li>
                </ul>
            </div>
            <div style="margin-top: 10px;" class="layout">
                <ul>
                    <li><span class="spanLabel">不良项目</span><span class="spanControl"><asp:TextBox ID="tbBlxm"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">数量(PCS)</span><span class="spanControl"><asp:TextBox ID="tbSl"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li style="width: 30%"><span class="spanLabel">问题描述</span><asp:TextBox ID="tbWtms"
                        runat="server" Width="66%" Rows="3" TextMode="MultiLine"></asp:TextBox></li>
                    <li style="width: 19%; border: 0;">
                        <asp:LinkButton ID="lbAddtr" runat="server" Style="margin-left: 14px; font-size: 15px; color: white; line-height: 25px; background-color: #3385ff; text-align: center; text-decoration: none"
                            Width="150px" OnClick="lbAddtr_Click" OnClientClick="return checkTcsl()">添加到分析列表</asp:LinkButton></li>
                </ul>
                <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                    AutoGenerateColumns="false" BorderStyle="None" BorderWidth="1px" CellPadding="4"
                    ForeColor="Black" GridLines="Vertical" EmptyDataText="暂无分析" EmptyDataRowStyle-BackColor="#40e0d0"
                    Width="100%" Style="margin: 0 auto; text-align: center;" OnRowDeleting="GridView1_RowDeleting"
                    OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="blxm" HeaderText="不良项目" />
                        <asp:CommandField ShowDeleteButton="true" HeaderText="删除"  />
                        <asp:BoundField DataField="sl" HeaderText="数量(PCS)" ItemStyle-Width="5%" />
                        <asp:BoundField DataField="wtms" HeaderText="问题描述"  />
                        <asp:TemplateField HeaderText="发生原因" >
                            <ItemTemplate>
                                <asp:TextBox ID="tbFsyy" runat="server" TextMode="MultiLine" Rows="3" Width="95%"></asp:TextBox>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="对策">
                            <ItemTemplate>
                                <asp:TextBox ID="tbDc" runat="server" TextMode="MultiLine" Rows="3" Width="95%"></asp:TextBox>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:BoundField DataField="djlsh" >
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
            <div class="layout" style="margin-top: 10px;">
                <ul class="ulSign">
                    <li><span class="spanText">PMC评审结果</span><asp:DropDownList ID="ddlPMCpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">PMC会签人</span><span class="spanControl"><asp:TextBox ID="tbPMChqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">PMC会签时间</span><span class="spanControl"><asp:TextBox ID="tbPMChqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbPMCbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">质量评审结果</span><asp:DropDownList ID="ddlZlpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">质量会签人</span><span class="spanControl"><asp:TextBox ID="tbZlhqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">质量会签时间</span><span class="spanControl"><asp:TextBox ID="tbZlhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbZlbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">工程评审结果</span><asp:DropDownList ID="ddlGcpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">工程会签人</span><span class="spanControl"><asp:TextBox ID="tbGchqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">工程会签时间</span><span class="spanControl"><asp:TextBox ID="tbGchqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbGcbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">制造评审结果</span><asp:DropDownList ID="ddlZzpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">制造会签人</span><span class="spanControl"><asp:TextBox ID="tbZzhqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">制造会签时间</span><span class="spanControl"><asp:TextBox ID="tbZzhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbZzbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
            </div>
            <div class="layout" style="margin-top: 10px;">
                <ul class="ulSign">
                    <li><span class="spanText">设备评审结果</span><asp:DropDownList ID="ddlSbpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">设备会签人</span><span class="spanControl"><asp:TextBox ID="tbSbhqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">设备会签时间</span><span class="spanControl"><asp:TextBox ID="tbSbhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbSbbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">生产总监评审</span><asp:DropDownList ID="ddlSczjpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">生产总监</span><span class="spanControl"><asp:TextBox ID="tbSczjhqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">时间</span><span class="spanControl"><asp:TextBox ID="tbSczjhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbSczjbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">总工评审</span><asp:DropDownList ID="ddlZgpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">总工</span><span class="spanControl"><asp:TextBox ID="tbZghqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">时间</span><span class="spanControl"><asp:TextBox ID="tbZghqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbZgbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">供应链评审</span><asp:DropDownList ID="ddlGylpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">供应链会签人</span><span class="spanControl"><asp:TextBox ID="tbGylhqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">供应链时间</span><span class="spanControl"><asp:TextBox ID="tbGylhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbGylbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
            </div>
            <div class="layout" style="margin-top: 10px;">
                <ul class="ulSign">
                    <li><span class="spanText">商务经理评审</span><asp:DropDownList ID="ddlSwjlpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">商务经理</span><span class="spanControl"><asp:TextBox ID="tbSwjlhqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">时间</span><span class="spanControl"><asp:TextBox ID="tbSwjlhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbSwjlbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">总助评审</span><asp:DropDownList ID="ddlZjlzlpsjg" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">总助</span><span class="spanControl"><asp:TextBox ID="tbZjlzlhqr"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">时间</span><span class="spanControl"><asp:TextBox ID="tbZjlzlhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbZjlzlbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li style="background-color: Silver;"><span class="spanText">退回部门</span><asp:DropDownList ID="ddlThbm" runat="server" onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem Value="fqr">商务补投</asp:ListItem>
                        <asp:ListItem Value="Zl">质量部</asp:ListItem>
                        <asp:ListItem Value="Gc">工程部</asp:ListItem>
                        <asp:ListItem Value="Zz">制造部</asp:ListItem>
                        <asp:ListItem Value="Sb">设备部</asp:ListItem>
                        <asp:ListItem Value="Sczj">生产总监</asp:ListItem>
                        <asp:ListItem Value="Zg">总工</asp:ListItem>
                        <asp:ListItem Value="Gyl">供应链</asp:ListItem>
                        <asp:ListItem Value="Swjl">商务经理</asp:ListItem>
                        <asp:ListItem Value="Zjlzl">总助</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                   
                </ul>

            </div>
            <div class="layout" >
                <ul>
                    <li><span class="spanLabel">PMC会签状态</span><span class="spanControl"><asp:DropDownList ID="ddlPMChqzt" runat="server">
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">质量会签状态</span><span class="spanControl"><asp:DropDownList ID="ddlZlhqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">工程会签状态</span><span class="spanControl"><asp:DropDownList ID="ddlGchqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">制造会签状态</span><span class="spanControl"><asp:DropDownList ID="ddlZzhqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">设备会签状态</span><span class="spanControl"><asp:DropDownList ID="ddlSbhqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">生产总监状态</span><span class="spanControl"><asp:DropDownList ID="ddlSczjhqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">总工会签状态</span><span class="spanControl"><asp:DropDownList ID="ddlZghqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">供应链会签状态</span><span class="spanControl"><asp:DropDownList ID="ddlGylhqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">商务经理经会签</span><span class="spanControl"><asp:DropDownList ID="ddlSwjlhqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">总助会签</span><span class="spanControl"><asp:DropDownList ID="ddlZjlzlhqzt" runat="server">
                        <asp:ListItem>-</asp:ListItem>
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList></span></li>
                    <li><span class="spanLabel">流程会签状态</span><span class="spanControl"><asp:TextBox ID="tbLchqzt"
                        runat="server" Width="90%"></asp:TextBox></span></li>
            </div>
            <div class="layout" style="text-align:center; margin-top:10px;">
                &nbsp;<asp:LinkButton Style="font-size: 20px; margin-left: 14px; color: white; line-height: 28px; background-color: #3385ff; text-align: center; text-decoration: none"
                    ID="lbSubmit"
                    runat="server" Width="100px" OnClick="lbSubmit_Click" OnClientClick="return thbm()">提交</asp:LinkButton></div>
            <div style="display: none;">
                <asp:DropDownList ID="ddlDw1" runat="server">
                    <asp:ListItem>PCS</asp:ListItem>
                    <asp:ListItem>组</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="tbUserName" runat="server"></asp:TextBox>
            </div>
        </div>
    </form>
</body>
</html>
