<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zlrb.aspx.cs" Inherits="zlrb" Title="批次查询（按日）" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server" >
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>
<script type="text/javascript"> 

    function arcxChange(){
        
       // if(document.getElementById('<%= arcx.ClientID %>').getAttribute ("Checked",true)){
       //         alert(111);
                document.getElementById('<%= gxmc.ClientID %>').disabled=false;
                document.getElementById('<%= xh.ClientID %>').disabled=false;
                document.getElementById('<%= ksrq.ClientID %>').disabled=false;
                document.getElementById('<%= jsrq.ClientID %>').disabled=false;
      //   }
    }
    function apcxChange(){
       // alert(222);
       // if(document.getElementById('<%= apcx.ClientID %>').getAttribute ("Checked",true)){
                
                document.getElementById('<%= gxmc.ClientID %>').disabled=true;
                document.getElementById('<%= xh.ClientID %>'  ).disabled=true;
                document.getElementById('<%= ksrq.ClientID %>').disabled=true;
                document.getElementById('<%= jsrq.ClientID %>').disabled=true;
        //}
    }
    
    
</script>  

</head>
<body>
<form id="form1" runat="server" >
     <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/AutoCompleteService.svc" />
        </Services>
     </ajaxToolkit:ToolkitScriptManager>
 <div align="center" class="STYLE1">
<br />
  <p style="font-weight: bold; font-size: 30px; color: black">批次数据</p><br />

</div>
<table width="800" border="0"  cellpadding="0"   cellspacing="1" bgcolor="#000000" align="center">
  <tr align="center" bgcolor="#add2da">
    <td width="75" style="height: 28px">查询方式：</td>
    <td colspan="5"  align ="left" style="height:28px" >
       <asp:RadioButton ID="arcx" runat="server" GroupName="cxlx"  Text="按日查询" Checked="true"  OnClick="arcxChange()" />
       <asp:RadioButton ID="apcx" runat="server" GroupName="cxlx"  Text="按批查询"  OnClick="apcxChange()"/>
    </td>
   </tr>
   
  <tr align="center" bgcolor="#add2da">
    <td width="75" style="height: 28px">工序名称：</td>
    <td colspan="5"  align ="left" style="height:28px" >
        <asp:CheckBoxList RepeatDirection="Horizontal" RepeatColumns="10"  ID="gxmc" runat="server"></asp:CheckBoxList>      
    </td>
   </tr>
  <tr align="center" bgcolor="#add2da">

    <td  style="height: 28px">批次：</td>
    <td style="height: 28px">
        <asp:TextBox ID="pc" runat="server" Width="120px" ></asp:TextBox>
        <ajaxToolkit:AutoCompleteExtender CompletionInterval="500" ID="AutoCompleteExtender1" runat="server" TargetControlID="pc" ServicePath="GetContent.asmx" ServiceMethod="GetpcList"  MinimumPrefixLength="1" >        
        </ajaxToolkit:AutoCompleteExtender>
    </td>
    <td style="height: 28px">型号：</td>
    <td style="height: 28px">
        <asp:TextBox ID="xh" runat="server" Width="120px"></asp:TextBox>
        <ajaxToolkit:AutoCompleteExtender CompletionInterval="500" ID="AutoCompleteExtender2" runat="server" TargetControlID="xh" ServicePath="GetContent.asmx" ServiceMethod="GetxhList" MinimumPrefixLength="1" >            
        </ajaxToolkit:AutoCompleteExtender>    
    </td>
    <td  colspan="2" rowspan="2" ><asp:Button ID="check" runat="server" Text="查询" Width="65" OnClick="check_Click" />    </td>

  </tr>
  <tr align="center" bgcolor="#add2da">
    <td  style="height: 28px">开始时间：</td>
    <td width="125" style="height: 28px">
        <asp:TextBox ID="ksrq" runat="server" Width="120px" ></asp:TextBox>
        <ajaxToolkit:CalendarExtender   ID="CalendarExtender1" runat="server"  TargetControlID="ksrq" Format="yyyy-MM-dd" >
        </ajaxToolkit:CalendarExtender>

    </td>
    <td width="75" style="height: 28px">结束时间：</td>
    <td width="125" style="height: 28px">
        <asp:TextBox ID="jsrq" runat="server" Width="120px"></asp:TextBox>
        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server"  TargetControlID="jsrq" Format="yyyy-MM-dd"   >        
        </ajaxToolkit:CalendarExtender> 
    </td>

   </tr>

</table>

 </form>
</body>
</html>
