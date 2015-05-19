<%@ Page Language="C#" CodeFile="ywydyEdit.aspx.cs" Inherits="ywydyEdit" MasterPageFile="main.master"    Culture="auto" UICulture="auto"  Title="业务员与技术部人员维护"   %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>

<asp:Content id="Content1" runat="server" ContentPlaceholderID="ContentPlaceHolder1">

<ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="tbYwy" ServicePath="~/GetContent.asmx" ServiceMethod="GetUserNameList" MinimumPrefixLength="1"  EnableCaching="true" CompletionInterval="200"></ajaxToolkit:AutoCompleteExtender>
<ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tbJsbry" ServicePath="~/GetContent.asmx" ServiceMethod="GetUserNameList" MinimumPrefixLength="1"  EnableCaching="true" CompletionInterval="200"></ajaxToolkit:AutoCompleteExtender>

<div style="overflow:scroll; height:100%; width:100% ;overflow:auto;"> 
 <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
         </ajaxToolkit:ToolkitScriptManager>
    <div style="margin:0 auto;width:760px;">
    <div  style="text-align:center; font-size:large; font-weight:bold">业务员与技术部人员维护</div>
    <div  style="margin-bottom:10px;" >
        <span style="width:100px; display:inline-block;">业务员:</span><span><asp:TextBox ID="tbYwy" runat="server"></asp:TextBox>
            &nbsp;        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="该业务员在系统中不存在,请检查" OnServerValidate="CustomValidator1_ServerValidate"
         ControlToValidate="tbYwy" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator></span></div>
    <div style="margin-bottom:10px;"  >
        <span style="width:100px; display:inline-block;">对应技术部人员:</span><span><asp:TextBox ID="tbJsbry" runat="server"></asp:TextBox>
            &nbsp;        <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="该技术部人员在系统中不存在,请检查" OnServerValidate="CustomValidator1_ServerValidate"
         ControlToValidate="tbJsbry" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator></span>
    </div>
    <div  > <asp:LinkButton ID="lbtnOK" runat="server"   style="display:block; background-color:#4B97E3; width:105px; height:30px; color:white; font-size:15px; line-height:30px; text-decoration:none; text-align:center;" OnClick="btnTj_Click" OnClientClick="return gcshq()">提交</asp:LinkButton>
           </div>
           </div>
</div> 
    
    
</asp:Content>

