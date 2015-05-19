<%@ Page Language="C#" AutoEventWireup="true" CodeFile="khtsdEdit.aspx.cs" Inherits="khtsdEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>客户投诉单</title>
    <link rel="stylesheet" type="text/css" href="../cgxt/css/common.css" />
    <script type="text/javascript">
    
    //已处理的单据进行状态更改
     function clztChange(){
        if(document.getElementById('ddlClzt').value=="处理完成"){
           document.getElementById('tbClr').value=document.getElementById('tbUserName').value;
           var sysDate=new Date(); 
           document.getElementById('tbClrq').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate();
           document.getElementById('tbLchqzt').value="已完成";
           document.getElementById('tbZlbhqzt').value="已会签";
        }
     }
    </script>

</head>
<body>
    <form id="form1" runat="server">
      <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="true"
                EnableScriptLocalization="true">
                <Services>
                    <asp:ServiceReference Path="~/AutoCompleteService.svc" />
                </Services>
            </ajaxToolkit:ToolkitScriptManager>
        <div id="divPage">
            <div class="layout" style=" text-align:center; font-size:large">
               客户投诉录入及处理表<asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
                    EnableClientScript="true" HeaderText="请检查如下项目是否填写正确" ShowMessageBox="true" />
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >单号</span><span class="spanControl">
                        <asp:TextBox ID="tbBh" runat="server" Width="90%"></asp:TextBox><asp:TextBox ID="tbJbrq"
                            Visible="false" runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">会签状态</span><span class="spanControl"><asp:TextBox ID="tbLchqzt"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" style="color:#FF0000">投诉日期(＊)</span><span class="spanControl"><asp:TextBox ID="tbTsrq"
                        runat="server" Width="90%"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd"
                            TargetControlID="tbTsrq">
                        </ajaxToolkit:CalendarExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbTsrq"
                            Display="Dynamic" ErrorMessage="请选择投诉日期" SetFocusOnError="true"></asp:RequiredFieldValidator></span>
                    </li>
                    <li><span class="spanLabel" style="color:#FF0000">投诉方式(＊)</span><span class="spanControl"><asp:DropDownList
                        ID="ddlTsfs" runat="server" Width="50%">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>电话</asp:ListItem>
                        <asp:ListItem>邮件</asp:ListItem>
                        <asp:ListItem>面谈</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlTsfs"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择投诉方式" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                        </asp:CompareValidator></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" style="color:#FF0000">客户代码(＊)</span><span class="spanControl"><asp:TextBox ID="tbKhdm"
                        runat="server" Width="90%"></asp:TextBox>
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="200"
                            EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetKhdmList" ServicePath="~/GetContent.asmx"
                            TargetControlID="tbKhdm">
                        </ajaxToolkit:AutoCompleteExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbKhdm"
                            Display="Dynamic" ErrorMessage="请填写客户代码" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server"
                            ControlToValidate="tbKhdm" Display="Dynamic" ErrorMessage="客户代码需要为FXXXX的格式，其中F大写，XXXX为4位数字和字母组合"
                            SetFocusOnError="true" ValidationExpression="^[F][A-Z0-9]{4}$"></asp:RegularExpressionValidator></span> </li>
                    <li><span class="spanLabel" style="color:#FF0000">投诉主题(＊)</span><span class="spanControl"><asp:TextBox ID="tbTszt"
                        runat="server" Width="90%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbTszt"
                            Display="Dynamic" ErrorMessage="请填写投诉主题" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">型号</span><span class="spanControl"><asp:TextBox ID="tbXh"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel" style="color:#FF0000">8D报告(＊)</span><span class="spanControl"><asp:DropDownList
                        ID="ddl8Dbg" runat="server" Width="50%">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>要</asp:ListItem>
                        <asp:ListItem>不要</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddl8Dbg"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择是否需要8D报告" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                        </asp:CompareValidator></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">容量</span><span class="spanControl"><asp:TextBox ID="tbRl"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">录入人</span><span class="spanControl"><asp:TextBox ID="tbLlr"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">数量</span><span class="spanControl"><asp:TextBox ID="tbSl"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">录入日期</span><span class="spanControl"><asp:TextBox ID="tbLlrq"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" style="float: left; margin-top: 5px;">投诉内容</span><span
                        class="spanControl"><asp:TextBox ID="tbTsnr" runat="server" Width="246%" Rows="10"
                            TextMode="MultiLine"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" style="float: left; margin-top: 5px;">处理结果</span><span
                        class="spanControl"><asp:TextBox ID="tbCljg" runat="server" Width="246%" Rows="10"
                            TextMode="MultiLine"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width:760px;"><span class="spanLabel" style="float: left; margin-top: 5px;">附件</span><span class="spanControl">
                        <asp:FileUpload ID="fulFj" runat="server"></asp:FileUpload><asp:TextBox Style="border-top-width: 0px;
                            border-left-width: 0px; border-bottom-width: 1px; border-right-width: 0px" ID="tbURL"
                            runat="server" Width="247px"></asp:TextBox><asp:ImageButton ID="iBtnDownLoad" OnClick="btnDownLoad_Click"
                                runat="server" ImageUrl="~/images/btnDownload.jpg"></asp:ImageButton>
                    </span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">处理状态</span><span class="spanControl"><asp:DropDownList
                        ID="ddlClzt" runat="server" onchange="clztChange()">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>处理中</asp:ListItem>
                        <asp:ListItem>处理中(待传报告)</asp:ListItem>
                        <asp:ListItem>处理完成</asp:ListItem>
                    </asp:DropDownList></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">处理人</span><span class="spanControl"><asp:TextBox ID="tbClr"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">处理日期</span><span class="spanControl"><asp:TextBox ID="tbClrq"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">发起人会签状态</span><span class="spanControl"><asp:TextBox
                        ID="tbFqrhqzt" runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">质量部会签状态</span><span class="spanControl"><asp:TextBox
                        ID="tbZlbhqzt" runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div style="text-align: center; width: 760px;">
                <br />
                <asp:LinkButton ID="lbtnOK" runat="server" Style="display: block; background-color: #4B97E3;
                    width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                    text-decoration: none; margin: 0 auto;" OnClick="btnTj_Click">提交</asp:LinkButton>
            </div>
        </div>
        <div style="display: none">
            <asp:TextBox ID="fileName" runat="server"></asp:TextBox>
            <asp:TextBox ID="tbUserName" runat="server"></asp:TextBox>
        </div>
    </form>
</body>
</html>
