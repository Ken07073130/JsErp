<%@ Page Language="C#" AutoEventWireup="true" CodeFile="nonProductEdit.aspx.cs" Inherits="nonProductEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>领料退料单</title>
    <link rel="stylesheet" type="text/css" href="css/common.css" />

    <script type="text/javascript">
        function openWzfl(){
          window.open ('wzflEdit.aspx','newwindow','height=600,width=600,top=200,left=400,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no');
        }
        
        //GG如果不是[开头的 开头和结尾补上[]标识 不然4*15规格取出来是60，而不是4*15
        function ggChange(){
          var gg=document.getElementById('tbGG').value;
          if(gg.substring(0,1)!="{"){
             gg="{"+gg+"}";
             document.getElementById('tbGG').value=gg;
          }
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="divPage">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
                AsyncPostBackTimeout="600" />
            <div class="layout" style="font-weight: bold; font-size: 25px; text-align: center;
                color: Black;">
                <asp:Label ID="lblTile" runat="server" Text=""></asp:Label>
            </div>
            <div class="layout" style="text-align: right;">
                <a onclick="openWzfl()" href="javascript:void(0)">物资分类添加</a>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">日期(＊)</span><span class="spanControl"><asp:TextBox ID="tbJbrq"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                    <li><span class="spanLabel" id="spLly" runat="server">部门(＊)</span><span class="spanControl"><asp:TextBox
                        ID="tbBm" runat="server" Width="90%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="requiredBm" runat="server" ControlToValidate="tbBm"
                            Display="Dynamic" ErrorMessage="&nbsp;请填写部门"></asp:RequiredFieldValidator></span>
                    </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">工厂(＊)</span><span class="spanControl"><asp:DropDownList
                        ID="ddlGc" runat="server">
                        <asp:ListItem Value="1">新桥工厂</asp:ListItem>
                        <asp:ListItem Value="2">东洲工厂</asp:ListItem>
                    </asp:DropDownList></span> </li>
                    <li><span class="spanLabel">物料编号(＊)</span><span class="spanControl"><asp:TextBox
                        ID="tbWlbh" runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" id="SPAN1">物料类别(＊)</span><span class="spanControl"><asp:DropDownList
                        ID="ddlWllb" runat="server" OnSelectedIndexChanged="ddlWllb_SelectedIndexChanged"
                        AutoPostBack="True">
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlWllb"
                            Display="Dynamic" ErrorMessage="请选择物料类别" Operator="NotEqual" ValueToCompare="0"></asp:CompareValidator></span>
                    </li>
                    <li><span class="spanLabel">物料名称(＊)</span><span class="spanControl"><asp:DropDownList
                        ID="ddlWlmc" runat="server">
                    </asp:DropDownList>
                        <asp:CompareValidator ID="compareWllb" runat="server" ControlToValidate="ddlWlmc"
                            Display="Dynamic" ErrorMessage="请选择物料类别" Operator="NotEqual" ValueToCompare="0"></asp:CompareValidator></span></li></ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 760px;"><span class="spanLabel">规格(＊)</span><span class="spanControl"
                        style="width: 600px;"><asp:TextBox ID="tbGG" runat="server" Width="95%" onblur="ggChange()" AutoPostBack="True" OnTextChanged="tbGG_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbGG"
                            Display="Dynamic" ErrorMessage="&nbsp;请填写规格"></asp:RequiredFieldValidator>&nbsp;<ajaxToolkit:AutoCompleteExtender
                                ID="AutoCompleteExtender1" runat="server" CompletionInterval="200" MinimumPrefixLength="1"
                                ServiceMethod="GetNonProductGGList" ServicePath="~/GetContent.asmx" TargetControlID="tbGG">
                            </ajaxToolkit:AutoCompleteExtender>
                    </span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">数量(＊)</span><span class="spanControl"><asp:TextBox ID="tbSl"
                        runat="server" Width="90%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbSl"
                            Display="Dynamic" ErrorMessage="&nbsp;请填写数量"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="tbSl"
                            Display="Dynamic" ErrorMessage="数量只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator></span></li><li>
                                <span class="spanLabel">单位(＊)</span><span class="spanControl"><asp:TextBox ID="tbDw"
                                    runat="server" Width="90%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbDw"
                                        Display="Dynamic" ErrorMessage="&nbsp;请填写单位"></asp:RequiredFieldValidator>
                                </span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">金额</span><span class="spanControl"><asp:TextBox ID="tbJe"
                        runat="server" Width="80%"></asp:TextBox>&nbsp;<asp:Label ID="lblJedw" runat="server" Text="元"></asp:Label>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbJe"
                            Display="Dynamic" ErrorMessage="金额只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator></span></li><li>
                                <span class="spanLabel"></span><span class="spanControl"></span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">供应商</span><span class="spanControl"><asp:TextBox ID="tbGys"
                        runat="server" Width="90%"></asp:TextBox></span></li><li><span class="spanLabel">库存量</span><span
                            class="spanControl"><asp:TextBox ID="tbKcl" runat="server" Width="90%"></asp:TextBox></span>
                        </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li id="liXqsl" runat="server"><span class="spanLabel">仓位</span><span class="spanControl"><asp:TextBox
                        ID="tbCw" runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel" id="spFlsl" runat="server">货架号</span><span class="spanControl"><asp:TextBox
                        ID="tbHjh" runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">操作人</span><span class="spanControl"><asp:TextBox ID="tbCzr"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                    <li><span class="spanControl">&nbsp;</span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 760px;"><span class="spanLabel">备注</span><span class="spanControl"
                        style="width: 600px;">
                        <asp:TextBox ID="tbBz" runat="server" Width="95%" Rows="3" TextMode="MultiLine"></asp:TextBox></span></li></ul>
            </div>
            <div style="text-align: center; margin-top: 10px;">
                <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline-block; background-color: #4B97E3;
                    width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                    text-decoration: none; margin: 0 auto; text-align: center" OnClick="btnTj_Click"
                    OnClientClick="return checkAll()">提交</asp:LinkButton>
                <asp:LinkButton ID="lblReturn" runat="server" Style="display: inline-block; background-color: #4B97E3;
                    width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                    text-decoration: none; margin: 0 auto; text-align: center" CausesValidation="false">返回列表</asp:LinkButton>
            </div>
            <div style="display: none">
                <asp:TextBox ID="tbLx" runat="server" Style="display: none"></asp:TextBox>
                <asp:TextBox ID="tbGroupNames" runat="server" Style="display: none"></asp:TextBox>
            </div>
        </div>
    </form>
</body>
</html>
