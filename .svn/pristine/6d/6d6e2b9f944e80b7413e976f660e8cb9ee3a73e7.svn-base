<%@ Page Language="C#" MasterPageFile="~/chaxun/CXmain.master" AutoEventWireup="true" CodeFile="pcsj_p.aspx.cs" Inherits="chaxun_pcsj_p" Title="结存品查询" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

         <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
         </ajaxToolkit:ToolkitScriptManager>

 <div align="center" class="STYLE1">
<br />
  <p style="font-weight: bold; font-size: 30px; color: black">结存品查询</p><br />

</div>
<table width="800" border="0"  cellpadding="0"   cellspacing="1" bgcolor="#000000" align="center">
  <tr align="center" bgcolor="#add2da">
    <td width="75" style="height: 28px">工序名称：</td>
        <td colspan="5"  align ="left" style="height: 28px" >
            <asp:CheckBoxList RepeatDirection="Horizontal" RepeatColumns="6"  ID="gxmc" runat="server"  >
            </asp:CheckBoxList>
        </td>
   </tr>
  <tr align="center" bgcolor="#add2da">
    <td   style="height: 28px">批次：</td>
    <td style="height: 28px">
        <asp:TextBox ID="pc" runat="server" Width="120px"></asp:TextBox>
        <ajaxToolkit:AutoCompleteExtender CompletionInterval="500" ID="AutoCompleteExtender1" runat="server" TargetControlID="pc" ServicePath="GetContent.asmx" ServiceMethod="GetpcList"  MinimumPrefixLength="1" >        </ajaxToolkit:AutoCompleteExtender>
    </td>
    <td style="height: 28px">型号：</td>
    <td style="height: 28px">
        <asp:TextBox ID="xh" runat="server" Width="120px"></asp:TextBox>
        <ajaxToolkit:AutoCompleteExtender CompletionInterval="500" ID="AutoCompleteExtender2" runat="server" TargetControlID="xh" ServicePath="GetContent.asmx" ServiceMethod="GetxhList" MinimumPrefixLength="1" >            </ajaxToolkit:AutoCompleteExtender>    
    </td>
    <td colspan="1" rowspan="1">&nbsp;
        <asp:Button ID="check" runat="server" Text="查询" Width="65" OnClick="check_Click" />    </td>
  </tr>

</table>

</asp:Content>

