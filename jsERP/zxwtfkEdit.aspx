<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zxwtfkEdit.aspx.cs" Inherits="zxwtfkEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>
<head runat="server">
    <title>专项问题反馈</title>
    <script language="javascript" >// Example: obj = findObj("image1");
 //质量部经理签字
function ZlbjlChange(){
       if(document.getElementById('<%= ddlZlbjl.ClientID %>').value.length>0){
         document.getElementById('<%= ddlZLBJLHQZT.ClientID %>').value="已会签"; 
         var sysDate=new Date(); 
         document.getElementById('<%= tbZlbjlhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(parseInt(sysDate.getMonth())+1)+"-"+sysDate.getDate();
         //如果下一步的状态不为空    
         if ("-"==document.getElementById('<%= ddlFXRHQZT.ClientID %>').value){
           document.getElementById('<%= ddlFXRHQZT.ClientID %>').value="会签中";
           document.getElementById('<%= tbLchqzt.ClientID %>').value="工程师会签中";
         }
          
       }
}

 //工程师签字
function FxrChange(){
       if(document.getElementById('<%= ddlFxr.ClientID %>').value.length>0){
         document.getElementById('<%= ddlFXRHQZT.ClientID %>').value="已会签"; 
         var sysDate=new Date(); 
         document.getElementById('<%= tbFxrhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(parseInt(sysDate.getMonth())+1)+"-"+sysDate.getDate();
         //如果下一步的状态不为空    
         if ("-"==document.getElementById('<%= ddlFXRSHHQZT.ClientID %>').value){
           document.getElementById('<%= ddlFXRSHHQZT.ClientID %>').value="会签中";
           document.getElementById('<%= tbLchqzt.ClientID %>').value="工程经理会签中";
         }
          
       } else {//工程师名字选择后再选空，流程会继续往下走 (BUG现象)
         document.getElementById('<%= ddlFXRHQZT.ClientID %>').value="会签中"; 
         var sysDate=new Date();
         //如果下一步的状态不为空    
         document.getElementById('<%= ddlFXRSHHQZT.ClientID %>').value="-";
         document.getElementById('<%= tbLchqzt.ClientID %>').value="工程师会签中";
       }
}

 //工程经理签字
function FxrshChange(){
       if(document.getElementById('<%= ddlFxrsh.ClientID %>').value.length>0){
         //初始化会签状态
         document.getElementById('<%= ddlFXRHQZT.ClientID %>').value="已会签"; 
         document.getElementById('<%= ddlFXRSHHQZT.ClientID %>').value="会签中"; 
         document.getElementById('<%= ddlZLBQRRHQZT.ClientID %>').value="-";
        
         if (document.getElementById('<%= ddlFxrsh.ClientID %>').value!="退回分析人重填"){ 
           document.getElementById('<%= ddlFXRSHHQZT.ClientID %>').value="已会签"; 
           var sysDate=new Date(); 
           document.getElementById('<%= tbFxrshhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(parseInt(sysDate.getMonth())+1)+"-"+sysDate.getDate();
           //如果下一步的状态不为空    
           if ("-"==document.getElementById('<%= ddlZLBQRRHQZT.ClientID %>').value){
             document.getElementById('<%= ddlZLBQRRHQZT.ClientID %>').value="会签中";
             document.getElementById('<%= tbLchqzt.ClientID %>').value="质量确认人会签中";
           }
         } else if (document.getElementById('<%= ddlFxrsh.ClientID %>').value=="退回分析人重填"){//5、工程经理审核时可退回分析改善人
           document.getElementById('<%= ddlFXRHQZT.ClientID %>').value="会签中"; 
           document.getElementById('<%= ddlFXRSHHQZT.ClientID %>').value="-"; 
           document.getElementById('<%= tbLchqzt.ClientID %>').value="工程师会签中";
           document.getElementById('<%= ddlFxrsh.ClientID %>').value="";
           document.getElementById('<%= ddlFxr.ClientID %>').value="";
         }
          
       } 
}

 //质量部确认人签字
function ZlbqrrChange(){
       if(document.getElementById('<%= ddlZlbqrr.ClientID %>').value.length>0){
         document.getElementById('<%= ddlZLBQRRHQZT.ClientID %>').value="已会签"; 
         var sysDate=new Date(); 
         document.getElementById('<%= tbZlbqrrhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(parseInt(sysDate.getMonth())+1)+"-"+sysDate.getDate();
         //如果下一步的状态不为空    
         //if ("-"==document.getElementById('<%= ddlFXRHQZT.ClientID %>').value){
           document.getElementById('<%= ddlZLBQRRHQZT.ClientID %>').value="已会签";
           document.getElementById('<%= tbLchqzt.ClientID %>').value="已完成";
         // }
          
       }
}

function insertExistsRow()
{
var table = document.getElementById("tableExists");
  {
  var rowID=parseInt(document.getElementById('<%= txtTRLastIndex.ClientID %>').value)+1;
  document.getElementById('<%= txtTRLastIndex.ClientID %>').value=rowID;
  document.getElementById('tableRows').value=rowID;
  //alert(document.getElementById('tableRows').value);
  var row = table.insertRow(rowID-1);
  var cell0 = row.insertCell(0);
  var cell1 = row.insertCell(1);
  var cell2 = row.insertCell(2);
  var cell3 = row.insertCell(3);
  var cell4 = row.insertCell(4);
  var cell5 = row.insertCell(5);
  //cell2.innerHTML = "<input name='txtGSDC" + rowID + "' id='txtGSDC" + rowID + "' type='text' size='20'/>";
  cell0.innerHTML = "<textarea name='txtGSDC" + rowID +"'id='txtGSDC" + rowID + "' cols='50' rows='3'  />";
  cell1.innerHTML = "<input name='txtFZR" + rowID + "' id='txtFZR" + rowID + "' type='text' size='10'/>";
  cell2.innerHTML = "<input name='txtYJSSRQ" + rowID + "' id='txtYJSSRQ" + rowID + "' type='text' size='12'/>";
  cell3.innerHTML = "<select  name='txtSSZK" + rowID + "' id='txtSSZK" + rowID + "'  onchange='sszkChange(this)'  > <option>未实施</option> <option>进行中</option> <option>已实施</option>    </select>";
  cell4.innerHTML = "<input name='txtSSWCRQ" + rowID + "' id='txtSSWCRQ" + rowID + "' type='text' size='20' readonly='true'   />";
  cell5.innerHTML = "<div align='center' style='width:40px'><a href='javascript:void(0);' onclick=\"deleteExistsRow(this)\">删除</a></div>";
  }
}

function deleteExistsRow(r)
  {
  var i=r.parentNode.parentNode.parentNode.rowIndex;
  document.getElementById('tableExists').deleteRow(i); 
  //初始化tableRows
  var rowNum=document.getElementById('tableExists').rows.length;
  document.getElementById('<%= txtTRLastIndex.ClientID %>').value=rowNum;
  document.getElementById('tableRows').value=rowNum;
  //document.getElementById('<%= txtTRLastIndex.ClientID %>').value=rowID;
  //document.getElementById('tableRows').value=rowID;
  
  }
//改善提案不为空时，实施完成日起可以填
function sswcrqEnable(r){  
   if (r.value!=""){
      document.getElementById('txtSSWCRQ'+r.name.substring(7)).readOnly=false;
   }
}


function sszkChange(r){
   if (r.selectedIndex==2){
      document.getElementById('txtSSWCRQ'+r.name.substring(7)).readOnly=false;
   }  else {
      document.getElementById('txtSSWCRQ'+r.name.substring(7)).readOnly=true;
   } 
}


//完成日期改好后判断是否需要走到下一步
function gcshq(){ 
   var result=true;
   if(document.getElementById('<%= ddlFxr.ClientID %>').value.length>0){
       for (var i=1;i<=10;i++){
         if(document.getElementById('txtSSWCRQ'+i)!=null){         
              if(document.getElementById('txtSSWCRQ'+i).value==""){
                result=false;
                alert('签名后实施完成日期不能为空，请填写实施完成日期');
                //tablerows会被重置成1 所以要重新设置下tablerows正确获取tablerows
                document.getElementById('tableRows').value=parseInt(document.getElementById('<%= txtTRLastIndex.ClientID %>').value)+1;
                return false;
                //工程部会签状态=已会签
                //工程领导会签状态的=会签中
              }  
          }

       } 
   }
   return result;
}






  
    </script>

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


</head>
<body>
   <form id="form1" runat="server">
   <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="tbFzr" ServicePath="~/GetContent.asmx" ServiceMethod="GetUserNameList" MinimumPrefixLength="1"  EnableCaching="true" CompletionInterval="200"></ajaxToolkit:AutoCompleteExtender>

    <div style="font-size:12px;">
      <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
         </ajaxToolkit:ToolkitScriptManager>
<table width="760" border="0" cellspacing="0" cellpadding="0" id="table" bgcolor="#F1FEDD" align="center">
    <tr>
        <td  colspan="12" style="height: 51px" class="Style_Title">
            专项问题反馈单         
            <a style="color:#000;padding:6px 3px;display:inline-block; text-decoration:none; background-color:#529F1D; font-size:12px" href="zxwtfkPrint.aspx?xh=<%=xh%>&lb=EDIT&editType=全部" target="_blank">打印</a>
          </td>
    </tr>
    <tr>
        <td class="table_td" style="height: 30px">
            单号</td>
        <td class="table_td" colspan="3" style="height: 30px">
            <asp:TextBox ID="tbBH" runat="server" Width="90%"></asp:TextBox></td>
        <td class="table_td" style="height: 30px">
            流程会签状态</td>
        <td class="table_td" colspan="3" style="height: 30px">
            <asp:TextBox ID="tbLchqzt" runat="server" Width="90%"></asp:TextBox></td>
        <td class="table_td" style="height: 30px; width: 63px;">
            退回部门</td>
        <td class="table_td" colspan="3" style="height: 30px"><asp:DropDownList ID="ddlThbm" runat="server" Width="90%">
            <asp:ListItem>-</asp:ListItem>
            <asp:ListItem>质量部经理</asp:ListItem>
            <asp:ListItem>分析人</asp:ListItem>
            <asp:ListItem>分析人审核</asp:ListItem>
        </asp:DropDownList></td>
    </tr>
  <tr>
    <td class="table_td" style="height: 30px">日期</td>
    <td class="table_td" style="height: 30px" colspan="3"> 
        <asp:TextBox ID="tbRQ" runat="server" Width="90%"></asp:TextBox></td>
    <td class="table_td" style="height: 30px">收文部门</td>
    <td class="table_td" style="height: 30px" colspan="3"> 
        <asp:TextBox ID="tbSwbm" runat="server" Width="90%"></asp:TextBox></td>
    <td class="table_td" style="height: 30px; width: 63px;">负责人</td>
    <td class="table_td" style="height: 30px" colspan="3"> 
        <asp:TextBox ID="tbFzr" runat="server" Width="90%"></asp:TextBox>
        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="该负责人在系统中不存在,请检查" OnServerValidate="CustomValidator1_ServerValidate"
         ControlToValidate="tbFzr" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
        
        </td>
  </tr>
  <tr>
    <td class="table_td" style="height: 31px">型号</td>
    <td class="table_td" style="height: 31px" colspan="3"> 
        <asp:TextBox ID="tbXh" runat="server" Width="90%"></asp:TextBox></td>
    <td class="table_td" style="height: 31px">批次</td>
    <td class="table_td" style="height: 31px" colspan="3"> 
        <asp:TextBox ID="tbPc" runat="server" Width="90%"></asp:TextBox></td>
    <td class="table_td" style="height: 31px; width: 63px;">发生工序</td>
    <td class="table_td" style="height: 31px" colspan="3"> 
        <asp:TextBox ID="tbFsgx" runat="server" Width="90%"></asp:TextBox></td>
  </tr>
  <tr>
    <td class="table_td" style="height: 26px">主题</td>
    <td class="table_td" style="height: 26px" colspan="11">     
        <asp:TextBox ID="tbZt" runat="server" Width="97%"></asp:TextBox></td>
  </tr>
  <tr>
    <td  colspan="12" style="text-align:left; height: 19px;">
        问题描述：     </td>
  </tr>
  <tr>
    <td class="table_td" style="height: 67px" colspan="12">
        <asp:TextBox ID="tbWtms" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
  </tr>
  <tr>
    <td colspan="2" style="height: 27px" >质量部发起人</td>
    <td colspan="2" class="table_td" style="height: 27px">
        <asp:DropDownList ID="ddlFqr" runat="server" Width="90%">
        </asp:DropDownList></td>
    <td colspan="2" class="table_td" style="height: 27px">
        <asp:TextBox ID="tbFqrhqsj" runat="server" Width="90%"></asp:TextBox></td>
    <td colspan="2" class="table_td" style="height: 27px">质量经理</td>
    <td colspan="2" class="table_td" style="height: 27px"><asp:DropDownList ID="ddlZlbjl" runat="server" Width="90%" onblur="ZlbjlChange()">
    </asp:DropDownList></td>
    <td colspan="2" class="table_td" style="height: 27px">
        <asp:TextBox ID="tbZlbjlhqsj" runat="server" Width="90%"></asp:TextBox></td>
  </tr>
  <tr>
    <td  colspan="12" style="text-align:left; height: 22px;">
        原因分析：     </td>
  </tr>
  <tr>
    <td class="table_td" style="height: 69px" colspan="12">     
        <asp:TextBox ID="tbYyfx" runat="server" Rows="5" Width="95%" TextMode="MultiLine" ></asp:TextBox></td>
  </tr>
    <tr>
        <td class="table_td" colspan="12" style="height: 69px">
         <div id="dtb" runat="server"></div>
            <br /> &nbsp;</td>
    </tr>
  <tr>
    <td colspan="2" class="table_td" style="height: 33px">
        分析人</td>
    <td colspan="2" class="table_td" style="height: 33px"><asp:DropDownList ID="ddlFxr" runat="server" Width="90%" onblur="FxrChange()">
    </asp:DropDownList></td>
    <td colspan="2" class="table_td" style="height: 33px">
        <asp:TextBox ID="tbFxrhqsj" runat="server" Width="90%"></asp:TextBox></td>
    <td colspan="2" class="table_td" style="height: 33px">
        部门经理</td> 
    <td colspan="2" class="table_td" style="height: 33px"><asp:DropDownList ID="ddlFxrsh" runat="server" Width="90%" onblur="FxrshChange()">
    <asp:ListItem>退回分析人重填</asp:ListItem>
    </asp:DropDownList></td>
    <td colspan="2" class="table_td" style="height: 33px">
        <asp:TextBox ID="tbFxrshhqsj" runat="server" Width="90%"></asp:TextBox></td>
  </tr>
  <tr>
    <td style="height: 34px; text-align:left;" colspan="12" >
        效果确认：     </td>
  </tr>
  <tr>
    <td class="table_td" style="height: 75px" colspan="12">
        <asp:TextBox ID="tbXgqr" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
  </tr>
  <tr>
    <td colspan="2" style="height: 31px" >
        最终结论</td>
    <td class="table_td" style="height: 31px" colspan="2"><asp:DropDownList ID="ddlXgsfyx" runat="server" Width="90%">
     <asp:ListItem>请选择</asp:ListItem>
     <asp:ListItem>改善效果明显</asp:ListItem>
     <asp:ListItem>改善效果一般</asp:ListItem>
     <asp:ListItem>视同无改善效果</asp:ListItem>
    </asp:DropDownList></td>
    <td class="table_td" style="height: 31px" colspan="8">   质量部确认人<asp:DropDownList ID="ddlZlbqrr" runat="server" Width="25%" onblur="ZlbqrrChange()">
    </asp:DropDownList>
        <asp:TextBox ID="tbZlbqrrhqsj" runat="server" Width="25%"></asp:TextBox></td>
  </tr>
    <tr>
        <td colspan="2" style="height: 31px">
            附件</td>
        <td class="table_td" colspan="10" style="height: 31px">
            <asp:FileUpload ID="fulFj" runat="server" />
            <asp:TextBox ID="tbURL" runat="server" Style="border-right: 0px; border-top: 0px;
                border-left: 0px; border-bottom: 1px" Width="247px"></asp:TextBox><br />
            &nbsp;<asp:ImageButton ID="iBtnDownLoad" runat="server" ImageUrl="~/images/btnDownload.jpg"
                OnClick="btnDownLoad_Click" /></td>
    </tr>
    <tr>

</table>
<table width="760" border="0" cellspacing="0" cellpadding="0"   align="center">
<tr>
  <td align="center" colspan="10" rowspan="1" style="height: 29px" >
            &nbsp;&nbsp;<br />
            <asp:LinkButton ID="lbtnOK" runat="server"   style="display:block; background-color:#4B97E3; width:105px; height:30px; color:white; font-size:15px; line-height:30px; text-decoration:none;" OnClick="btnTj_Click" OnClientClick="return gcshq()">提交</asp:LinkButton>
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
    </div>
    </form>
</body>
</html>
