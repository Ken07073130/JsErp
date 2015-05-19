<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pzfkbEdit.aspx.cs" Inherits="pzfkbEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>客户投诉单</title>
    <link rel="stylesheet" type="text/css" href="../jsERP/css/common.css" />

    <script type="text/javascript">
    
    //已处理的单据进行状态更改
     function clztChange(){
           if (document.getElementById('ddlHkr').value!='请选择'){
               var sysDate=new Date(); 
               document.getElementById('tbHkrq').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate();
               document.getElementById('tbLchqzt').value="已回馈";
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
            <div class="layout" style="text-align: center; font-size: large">
                品质反馈表<asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
                    EnableClientScript="true" HeaderText="请检查如下项目是否填写正确" ShowMessageBox="true" />
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">反馈接收人员</span><span class="spanControl"><asp:DropDownList
                        ID="ddlFkjsry" runat="server">
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFkjsry"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择反馈接收人员" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                        </asp:CompareValidator>
                        状态<asp:TextBox ID="tbLchqzt" runat="server" Width="50%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">单号</span><span class="spanControl"><asp:TextBox ID="tbBh"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">型号</span><span class="spanControl">
                        <asp:TextBox ID="tbXh" runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">批号</span><span class="spanControl"><asp:TextBox ID="tbPh"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">客户代码</span><span class="spanControl">
                        <asp:TextBox ID="tbKhdm" runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">设备名称</span><span class="spanControl"><asp:TextBox ID="tbSbmc"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 760px;"><span class="spanLabel">反馈主题</span><span class="spanControlOne">
                        <asp:TextBox ID="tbFkzt" runat="server" Width="95%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbFkzt"
                            Display="Dynamic" ErrorMessage="请填写反馈主题" SetFocusOnError="true"></asp:RequiredFieldValidator></span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 760px;"><span class="spanLabel">反馈内容</span><span class="spanControlOne">
                        <asp:TextBox ID="tbFknr" runat="server" Width="95%" Rows="5" TextMode="MultiLine"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbFknr"
                            Display="Dynamic" ErrorMessage="请填写反馈内容" SetFocusOnError="true"></asp:RequiredFieldValidator></span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">反馈人</span><span class="spanControl">
                        <asp:TextBox ID="tbFkr" runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span>
                    </li>
                    <li><span class="spanLabel">日期</span><span class="spanControl"><asp:TextBox ID="tbJbrq"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 760px;"><span class="spanLabel">回馈内容</span><span class="spanControlOne">
                        <asp:TextBox ID="tbHknr" runat="server" Width="95%" Rows="5" TextMode="MultiLine"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbHknr"
                            Enabled="false" Display="Dynamic" ErrorMessage="请填写回馈内容" SetFocusOnError="true"></asp:RequiredFieldValidator></span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">回馈人</span><span class="spanControl"><asp:DropDownList
                        ID="ddlHkr" runat="server" onchange="clztChange();">
                    </asp:DropDownList></span>
                    </li>
                    <li><span class="spanLabel">日期</span><span class="spanControl"><asp:TextBox ID="tbHkrq"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div style="text-align: center; width: 760px; margin: 0 auto;">
                <br />
                <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline-block; background-color: #4B97E3;
                    width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                    text-decoration: none; margin: 0 auto;" OnClick="btnTj_Click" >提交</asp:LinkButton>
              
            </div>
        </div>
        <div style="display: none">
            &nbsp;<asp:TextBox ID="tbUserName" runat="server"></asp:TextBox>
        </div>
    </form>
</body>
</html>
