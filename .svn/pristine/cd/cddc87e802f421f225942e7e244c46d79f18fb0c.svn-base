<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zxwtfkPrint.aspx.cs" Inherits="jsERP_zxwtfkPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    <style type="text/css">
    #table table {
      border-collapse:collapse;
      border:none;
    }
    #table td {
      border:solid #000 1px;
      border-color:"#cccc99";
      text-align:center;
    }
 
    .table_td{
      word-wrap:break-word;
      width:63px;
    }
    .Style_Title {
    font-size:22px;
    font-weight:bold;
    }
    </style>
    <style media="print">  
   .noprint { display : none; }  
   

  </style>  
  <script type="text/javascript">
     function cpkftaPrint(){
   window.print();
   }
  </script>

</head>
<body>
<div>
<form id="frmMain"  runat="server">
<table width="760" border="0" cellspacing="0" cellpadding="0" id="table" bgcolor="#F1FEDD" align="center" >
    <tr>
        <td  colspan="12" style="height: 51px" class="Style_Title">
            专项问题反馈单<input id="Button1" class="noprint" onclick="cpkftaPrint()" type="button"
                value="打印" /></td>
    </tr>
    <tr>
        <td class="table_td" style="height: 43px">
            单号</td>
        <td class="table_td" colspan="3" style="height: 43px">
            <asp:TextBox ID="tbBH" runat="server" Width="90%"></asp:TextBox></td>
        <td class="table_td" style="height: 43px">
            流程会签状态</td>
        <td class="table_td" colspan="3" style="height: 43px">
            <asp:TextBox ID="tbLchqzt" runat="server" Width="90%"></asp:TextBox></td>
        <td class="table_td" style="height: 43px; width: 63px;">
            退回部门</td>
        <td class="table_td" colspan="3" style="height: 43px"><asp:DropDownList ID="ddlThbm" runat="server" Width="90%">
            <asp:ListItem>-</asp:ListItem>
            <asp:ListItem>质量部经理</asp:ListItem>
            <asp:ListItem>分析人</asp:ListItem>
            <asp:ListItem>分析人审核</asp:ListItem>
        </asp:DropDownList></td>
    </tr>
  <tr>
    <td class="table_td" style="height: 52px">日期</td>
    <td class="table_td" colspan="3" style="height: 52px"> 
        <asp:TextBox ID="tbRQ" runat="server" Width="90%"></asp:TextBox></td>
    <td class="table_td" style="height: 52px">收文部门</td>
    <td class="table_td" colspan="3" style="height: 52px"> 
        <asp:TextBox ID="tbSwbm" runat="server" Width="90%"></asp:TextBox></td>
    <td class="table_td" style="width: 63px; height: 52px;">负责人</td>
    <td class="table_td" colspan="3" style="height: 52px"> 
        <asp:TextBox ID="tbFzr" runat="server" Width="90%"></asp:TextBox>
        
        </td>
  </tr>
  <tr>
    <td class="table_td" style="height: 51px">型号</td>
    <td class="table_td" colspan="3" style="height: 51px"> 
        <asp:TextBox ID="tbXh" runat="server" Width="90%"></asp:TextBox></td>
    <td class="table_td" style="height: 51px">批次</td>
    <td class="table_td" colspan="3" style="height: 51px"> 
        <asp:TextBox ID="tbPc" runat="server" Width="90%"></asp:TextBox></td>
    <td class="table_td" style="width: 63px; height: 51px;">发生工序</td>
    <td class="table_td" colspan="3" style="height: 51px"> 
        <asp:TextBox ID="tbFsgx" runat="server" Width="90%"></asp:TextBox></td>
  </tr>
  <tr>
    <td class="table_td" style="height: 37px">主题</td>
    <td class="table_td" colspan="11" style="height: 37px">     
        <asp:TextBox ID="tbZt" runat="server" Width="97%"></asp:TextBox></td>
  </tr>
  <tr>
    <td  colspan="12" style="text-align:left; height: 38px;">
        问题描述：     </td>
  </tr>
  <tr>
    <td class="table_td" colspan="12" style="height: 89px">
        <asp:TextBox ID="tbWtms" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
  </tr>
  <tr>
    <td colspan="2" style="height: 38px" >质量部发起人</td>
    <td colspan="2" class="table_td" style="height: 38px">
        <asp:DropDownList ID="ddlFqr" runat="server" Width="90%">
        </asp:DropDownList></td>
    <td colspan="2" class="table_td" style="height: 38px">
        <asp:TextBox ID="tbFqrhqsj" runat="server" Width="90%"></asp:TextBox></td>
    <td colspan="2" class="table_td" style="height: 38px">质量经理</td>
    <td colspan="2" class="table_td" style="height: 38px"><asp:DropDownList ID="ddlZlbjl" runat="server" Width="90%" onblur="ZlbjlChange()">
    </asp:DropDownList></td>
    <td colspan="2" class="table_td" style="height: 38px">
        <asp:TextBox ID="tbZlbjlhqsj" runat="server" Width="90%"></asp:TextBox></td>
  </tr>
  <tr>
    <td  colspan="12" style="text-align:left; height: 29px;">
        原因分析：     </td>
  </tr>
  <tr>
    <td class="table_td" colspan="12" style="height: 85px">     
        <asp:TextBox ID="tbYyfx" runat="server" Rows="5" Width="95%" TextMode="MultiLine" ></asp:TextBox></td>
  </tr>
    <tr>
        <td class="table_td" colspan="12">
         <div id="dtb" runat="server"></div>
            <br /> &nbsp;</td>
    </tr>
  <tr>
    <td colspan="2" class="table_td">
        分析人</td>
    <td colspan="2" class="table_td"><asp:DropDownList ID="ddlFxr" runat="server" Width="90%" onblur="FxrChange()">
    </asp:DropDownList></td>
    <td colspan="2" class="table_td">
        <asp:TextBox ID="tbFxrhqsj" runat="server" Width="90%"></asp:TextBox></td>
    <td colspan="2" class="table_td">
        部门经理</td> 
    <td colspan="2" class="table_td"><asp:DropDownList ID="ddlFxrsh" runat="server" Width="90%" onblur="FxrshChange()">
    <asp:ListItem>退回分析人重填</asp:ListItem>
    </asp:DropDownList></td>
    <td colspan="2" class="table_td">
        <asp:TextBox ID="tbFxrshhqsj" runat="server" Width="90%"></asp:TextBox></td>
  </tr>
  <tr>
    <td style="text-align:left; height: 41px;" colspan="12" >
        效果确认：     </td>
  </tr>
  <tr>
    <td class="table_td" colspan="12" style="height: 79px">
        <asp:TextBox ID="tbXgqr" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
  </tr>
  <tr>
    <td colspan="2" style="height: 41px" >
        最终结论</td>
    <td class="table_td" colspan="2" style="height: 41px"><asp:DropDownList ID="ddlXgsfyx" runat="server" Width="90%">
     <asp:ListItem>请选择</asp:ListItem>
     <asp:ListItem>改善效果明显</asp:ListItem>
     <asp:ListItem>改善效果一般</asp:ListItem>
     <asp:ListItem>无改善效果</asp:ListItem>
    </asp:DropDownList></td>
    <td class="table_td" colspan="8" style="height: 41px">   质量部确认人<asp:DropDownList ID="ddlZlbqrr" runat="server" Width="25%" onblur="ZlbqrrChange()">
    </asp:DropDownList>
        <asp:TextBox ID="tbZlbqrrhqsj" runat="server" Width="25%"></asp:TextBox></td>
  </tr>
    <tr style="display:none">
        <td colspan="2" style="height: 31px">
            附件</td>
        <td class="table_td" colspan="10" style="height: 31px">
            <asp:FileUpload ID="fulFj" runat="server" />
            <asp:TextBox ID="tbURL" runat="server" Style="border-right: 0px; border-top: 0px;
                border-left: 0px; border-bottom: 1px" Width="247px"></asp:TextBox><br />
            &nbsp;<asp:ImageButton ID="iBtnDownLoad" runat="server" ImageUrl="~/images/btnDownload.jpg"
                OnClick="btnDownLoad_Click" /></td>
    </tr>

</table>
<table width="760" border="0" cellspacing="0" cellpadding="0"   align="center" style="display:none">
<tr>
  <td align="center" colspan="10" rowspan="1" style="height: 29px" >
            &nbsp;&nbsp;<br />
            <asp:LinkButton ID="lbtnOK" runat="server"   style="display:block; background-color:#4B97E3; width:105px; height:30px; color:white; font-size:15px; line-height:30px; text-decoration:none;" OnClick="btnTj_Click">提交</asp:LinkButton>
            <br /></td>
    </tr>
</table>
<table height="45" border="0" cellpadding="0" cellspacing="0" style="width: 654px;display:none">
  <tr  align="left" valign="bottom">

    <td  style="height: 35px; width: 103px;"><asp:DropDownList ID="ddlFQRHQZT" runat="server" Width="64px">
            <asp:ListItem>已会签</asp:ListItem>
        </asp:DropDownList></td>
    <td  style="height: 35px; width: 104px;"><asp:DropDownList ID="ddlZLBJLHQZT" runat="server" Width="66px">
            <asp:ListItem>会签中</asp:ListItem>
            <asp:ListItem>已会签</asp:ListItem>
        </asp:DropDownList></td>
    <td  style="height: 35px; width: 103px;">
        <asp:DropDownList ID="ddlFXRHQZT" runat="server" Width="66px">
             <asp:ListItem>-</asp:ListItem>
             <asp:ListItem>会签中</asp:ListItem>
             <asp:ListItem>已会签</asp:ListItem>
        </asp:DropDownList></td>
    <td  style="height: 35px; width: 103px;">
        <asp:DropDownList ID="ddlFXRSHHQZT" runat="server" Width="66px">
            <asp:ListItem>-</asp:ListItem>
            <asp:ListItem>会签中</asp:ListItem>
            <asp:ListItem>已会签</asp:ListItem>
        </asp:DropDownList></td>
    <td  style="height: 35px; width: 100px;">
        <asp:DropDownList ID="ddlZLBQRRHQZT" runat="server" Width="66px">
            <asp:ListItem>-</asp:ListItem>
            <asp:ListItem>会签中</asp:ListItem>
            <asp:ListItem>已会签</asp:ListItem>
        </asp:DropDownList></td>
 
  </tr>
</table>
  
    <div style="display:none">
     <input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex' value="1" runat="server" />
     <input name='tableRows' type='hidden' id='tableRows' value="1" />
        <asp:TextBox ID="fileName" runat="server"></asp:TextBox></div>
  </form>
 </div>        
</body>
</html>
