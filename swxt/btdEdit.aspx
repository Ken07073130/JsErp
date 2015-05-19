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
    
     
       
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
            AsyncPostBackTimeout="600" EnableScriptGlobalization="true" />
        <div id="divPage">
            <div class="layout" style="text-align: center; font-weight: bold; font-size: 25px;">生产补投单<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">单号</span><span class="spanControl"><asp:TextBox ID="tbBh"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">提出</span><span class="spanControl"><asp:TextBox ID="tbTc"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">日期</span><span class="spanControl"><asp:TextBox ID="tbRq"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">客户代码</span><span class="spanControl"><asp:TextBox ID="tbKhdm"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li style="width: 474px;"><span class="spanLabel">订单号</span><span class="spanControl"><asp:TextBox
                        ID="tbDdh" runat="server" Width="368px"></asp:TextBox></span></li>
                    <li><span class="spanLabel">缺货数量</span><span class="spanControl"><asp:TextBox ID="tbQqsl" runat="server" Width="90%"></asp:TextBox></span></li>
                    <li>
                        <span class="spanLabel">订单总数量</span><span class="spanControl"><asp:TextBox ID="tbDdzsl"
                            runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">评审单投量</span><span class="spanControl"><asp:TextBox ID="tbPsdzl"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">评审交期</span><span class="spanControl"><asp:TextBox ID="tbPsjq"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">交期延迟</span><span class="spanControl"><asp:TextBox ID="tbJqyc"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">容量</span><span class="spanControl"><asp:TextBox ID="tbRl"
                        runat="server" Width="90%"></asp:TextBox>
                        </span></li>
                    <li><span class="spanLabel">规格书型号</span><span class="spanControl"><asp:TextBox ID="tbGgsxh"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部电芯型号</span><span class="spanControl"><asp:TextBox ID="tbNbdxxh"
                        runat="server" onchange="setPlpc();" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部包装型号</span><span class="spanControl"><asp:TextBox ID="tbNbbzxh"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">内部PACK型号</span><span class="spanControl"><asp:TextBox
                        ID="tbNbpackxh" runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">电芯预计补投</span><span class="spanControl"><asp:TextBox ID="tbDxyjbt"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">正极预计补投</span><span class="spanControl"><asp:TextBox ID="tbZjyjbt"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">负极预计补投</span><span class="spanControl"><asp:TextBox ID="tbFjyjbt"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanLabel">PACK预计补投</span><span class="spanControl"><asp:TextBox
                        ID="tbPackyjbt" runat="server" Width="90%"></asp:TextBox></span></li>

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
                    <li style="width: 30%"><span class="spanLabel">问题描述</span><span class="spanControl"><asp:TextBox ID="tbWtms"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li style="width:19%; border:0;">
                    <asp:LinkButton ID="lbAddtr" runat="server" Style="margin-left: 14px; font-size: 15px; color: white; line-height: 25px; background-color: #3385ff; text-align: center; text-decoration: none"
                        Width="150px" OnClick="lbAddtr_Click" OnClientClick="return checkTcsl()">添加到分析列表</asp:LinkButton></li>
                </ul>
                <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                    AutoGenerateColumns="false" BorderStyle="None" BorderWidth="1px" CellPadding="4"
                    ForeColor="Black" GridLines="Vertical" EmptyDataText="暂无分析" EmptyDataRowStyle-BackColor="#40e0d0"
                    Width="800" Style="margin: 0 auto; text-align: center;" OnRowDeleting="GridView1_RowDeleting"
                    OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="blxm" HeaderText="不良项目" ItemStyle-Width="15%" />
                        <asp:CommandField ShowDeleteButton="true" HeaderText="删除" ItemStyle-Width="5%" />
                        <asp:BoundField DataField="sl" HeaderText="数量(PCS)" ItemStyle-Width="20%" />
                        <asp:TemplateField HeaderText="发生原因" ItemStyle-Width="20%">
                            <ItemTemplate>
                                <asp:TextBox ID="tbFsyy" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="对策" ItemStyle-Width="20%">
                            <ItemTemplate>
                                <asp:TextBox ID="tbDc" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            </ItemTemplate>

                        </asp:TemplateField>
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
            <div class="layout" style="margin-top: 10px;">
                <ul class="ulSign">
                    <li><span class="spanText">PMC评审结果</span><asp:DropDownList ID="ddlPMCpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">PMC会签人</span><span class="spanControl"><asp:TextBox ID="tbPMC"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">PMC会签时间</span><span class="spanControl"><asp:TextBox ID="tbPMChqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbPMCbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">质量评审结果</span><asp:DropDownList ID="ddlZlpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">质量会签人</span><span class="spanControl"><asp:TextBox ID="tbZl"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">质量会签时间</span><span class="spanControl"><asp:TextBox ID="tbZlhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbZlbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">工程评审结果</span><asp:DropDownList ID="ddlGcpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">工程会签人</span><span class="spanControl"><asp:TextBox ID="tbGc"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">工程会签时间</span><span class="spanControl"><asp:TextBox ID="tbGchqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbGcbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">制造评审结果</span><asp:DropDownList ID="ddlZzpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">制造会签人</span><span class="spanControl"><asp:TextBox ID="tbZz"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">制造会签时间</span><span class="spanControl"><asp:TextBox ID="tbZzhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbZzbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
            </div>
            <div class="layout" style="margin-top: 10px;">
                <ul class="ulSign">
                    <li><span class="spanText">设备评审结果</span><asp:DropDownList ID="ddlSbpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">设备会签人</span><span class="spanControl"><asp:TextBox ID="tbSb"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">设备会签时间</span><span class="spanControl"><asp:TextBox ID="tbSbhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbSbbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">生产总监评审</span><asp:DropDownList ID="ddlSczjpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">生产总监</span><span class="spanControl"><asp:TextBox ID="tbSczj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">时间</span><span class="spanControl"><asp:TextBox ID="tbSczjhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbSczjbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">总工评审</span><asp:DropDownList ID="ddlZgpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">总工</span><span class="spanControl"><asp:TextBox ID="tbZg"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">时间</span><span class="spanControl"><asp:TextBox ID="tbZghqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbZgbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">供应链评审</span><asp:DropDownList ID="ddlGylpsjg" runat="server">
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
                    <li><span class="spanText">商务经理评审</span><asp:DropDownList ID="ddlSwjlpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">商务经理</span><span class="spanControl"><asp:TextBox ID="tbSwjl"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">时间</span><span class="spanControl"><asp:TextBox ID="tbSwjlhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbSwjlbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>
                <ul class="ulSign">
                    <li><span class="spanText">总助评审</span><asp:DropDownList ID="ddlZjlzlpsjg" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意补投</asp:ListItem>
                    </asp:DropDownList>
                    </li>
                    <li><span class="spanText">总助</span><span class="spanControl"><asp:TextBox ID="tbZjlzl"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">时间</span><span class="spanControl"><asp:TextBox ID="tbZjlzlhqsj"
                        runat="server" Width="90%"></asp:TextBox></span></li>
                    <li><span class="spanText">备注</span><span class="spanControl"><asp:TextBox ID="tbZjlzlbz"
                        runat="server" Width="90%" TextMode="MultiLine" Rows="5"></asp:TextBox></span></li>
                </ul>

            </div>
        </div>
    </form>
</body>
</html>
