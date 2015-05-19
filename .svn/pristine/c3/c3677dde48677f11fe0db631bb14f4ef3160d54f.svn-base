<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cpkftaPrint.aspx.cs" Inherits="cpkftaPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>产品开发提案评审单</title>
    <style type="text/css">
  table#border
  {
    border-top:#000 1px solid;
    border-left:#000 1px solid;
  }
  
  table#border td
  {
    border-bottom:#000 1px solid;
    border-right:#000 1px solid;
    text-align:center;
  }
  
  table#tableCpkfta
  {
    border-top:#000 1px solid;
    border-left:#000 1px solid;
  }
  
  table#tableCpkfta td
  {
    border-bottom:#000 1px solid;
    border-right:#000 1px solid;
    text-align:center;
  }
  
  table#tablePs
  {
    border-top:#000 1px solid;
    border-left:#000 1px solid;
  }
  
  table#tablePs td
  {
    border-bottom:#000 1px solid;
    border-right:#000 1px solid;
    text-align:center;
  }
  
  table#tableKhxq
  {
    border-top:#000 1px solid;
    border-left:#000 1px solid;
  }
  
  table#tableKhxq td
  {
    border-bottom:#000 1px solid;
    border-right:#000 1px solid;
    text-align:center;
    width:110px;
  }
  
  table#tablePackyq
  {
    border-top:#000 1px solid;
    border-left:#000 1px solid;
  }
  
  table#tablePackyq td
  {
    border-bottom:#000 1px solid;
    border-right:#000 1px solid;
    text-align:center;
  }
  
  
  .tdNeed {
    color:#FF0000;
  }
</style>

<style media="print">  
   .noprint { display : none; }  
</style>  


    <script type="text/javascript"> 
//0.js处理会签流程开始
//1.销售人员会签
/*function xsryChange(){
       if(document.getElementById('<%= ddlXsry.ClientID %>').value.length>0){
         document.getElementById('<%= ddlXsryhqzt.ClientID %>').value="已会签"; 
         var sysDate=new Date(); 
         document.getElementById('<%= tbXsryhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
         //如果下一步的状态不为空    
         if ("-"==document.getElementById('<%= ddlXsjlhqzt.ClientID %>').value){
           document.getElementById('<%= ddlXsjlhqzt.ClientID %>').value="会签中";
           document.getElementById('<%= tbLchqzt.ClientID %>').value="销售经理会签中";
         } 
       }
}*/

//2.销售经理会签
function xsjlChange(){
       if(document.getElementById('<%= ddlXsjl.ClientID %>').value.length>0){
           document.getElementById('<%= ddlXsjlhqzt.ClientID %>').value="已会签"; 
           var sysDate=new Date(); 
           document.getElementById('<%= tbXsjlhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
           //如果下一步的状态不为空    
           if ("-"==document.getElementById('<%= ddlSwjlhqzt.ClientID %>').value){
             document.getElementById('<%= ddlSwjlhqzt.ClientID %>').value="会签中";
             //产品开发提案流程 
             if(document.getElementById('<%= tbDjlx.ClientID %>').value=="CPKFTA"){ 
               document.getElementById('<%= tbLchqzt.ClientID %>').value="商务经理会签中";
             } 
             //规格书流程
             else if (document.getElementById('<%= tbDjlx.ClientID %>').value=="GGS"){
               if(document.getElementById('<%= ddlCpzt.ClientID %>').value=="PACK"){
                  if (document.getElementById('<%= ddlZghqzt.ClientID %>').value=='-'){
                    document.getElementById('<%= ddlZghqzt.ClientID %>').value="会签中";
                    document.getElementById('<%= tbLchqzt.ClientID %>').value="电芯和PACK工程师会签中";
                  }
               } else {
                  document.getElementById('<%= tbLchqzt.ClientID %>').value="电芯工程师会签中";
               }
               
             }
           } 
        }
}

//3.商务经理会签
function swjlChange(){
       if(document.getElementById('<%= ddlSwjl.ClientID %>').value.length>0){
           document.getElementById('<%= ddlSwjlhqzt.ClientID %>').value="已会签";
           var sysDate=new Date(); 
           document.getElementById('<%= tbSwjlhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
           //产品开发提案
           if(document.getElementById('<%= tbDjlx.ClientID %>').value=="CPKFTA"){
               if("-"==document.getElementById('<%= ddlZghqzt.ClientID %>').value){
                  document.getElementById('<%= ddlZghqzt.ClientID %>').value="会签中";
                  document.getElementById('<%= tbLchqzt.ClientID %>').value="总工会签中";
               } 
           } 
           //规格书
           else if (document.getElementById('<%= tbDjlx.ClientID %>').value=="GGS"){
              DxChange();
           }
       }
}

//4.总工会签
function zgChange(){
       //产品开发提案
       if(document.getElementById('<%= tbDjlx.ClientID %>').value=="CPKFTA"){
           if(document.getElementById('<%= ddlZg.ClientID %>').value.length>0){
               var sysDate=new Date(); 
               document.getElementById('<%= tbZghqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
               document.getElementById('<%= ddlZghqzt.ClientID %>').value="已会签";
               document.getElementById('<%= tbLchqzt.ClientID %>').value="已完成"; 
           }
       } 
       //规格书
       else if(document.getElementById('<%= tbDjlx.ClientID %>').value=="GGS"){
           if(document.getElementById('<%= ddlZg.ClientID %>').value.length>0){
               var sysDate=new Date(); 
               document.getElementById('<%= tbZghqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
               document.getElementById('<%= ddlZghqzt.ClientID %>').value="已会签";
               if("-"==document.getElementById('<%= ddlSyshqzt.ClientID %>').value){
                 if("已会签"==document.getElementById('<%= ddlSwjlhqzt.ClientID %>').value){
                   document.getElementById('<%= ddlSyshqzt.ClientID %>').value="会签中";
                   document.getElementById('<%= tbLchqzt.ClientID %>').value="实验室会签中"; 
                 }
               }
           } 
       }
}
//5.js处理会签流程结束



//规格书流程
//电芯会签结果处理
function DxChange(){
      //实验室还未处理
      if("-"==document.getElementById('ddlSyshqzt').value){
          //只有电芯时,总工状态(pack状态)为'-'表示通过,有电芯和pack时，pack状态为已会签表示通过
          if("-"==document.getElementById('ddlZghqzt').value||"已会签"==document.getElementById('ddlZghqzt').value){
             document.getElementById('<%= ddlSyshqzt.ClientID %>').value="会签中";
             document.getElementById('<%= tbLchqzt.ClientID %>').value="实验室会签中";   
          } 
      }
}

//实验室会签
function sysChange(){
   if(document.getElementById('<%= ddlSys.ClientID %>').value.length>0){
               var sysDate=new Date(); 
               document.getElementById('<%= tbSyshqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
               document.getElementById('<%= ddlSyshqzt.ClientID %>').value="已会签";
               document.getElementById('<%= tbLchqzt.ClientID %>').value="已完成"; 
           }
}


//成品状态  电芯/PACK
function cpztChange(){
   var cpzt=document.getElementById('<%= ddlCpzt.ClientID %>').value;
   if ("电芯"==cpzt){
      document.getElementById('divDxchfs').style.display="block";
      document.getElementById('divPackchfs').style.display="none";
      document.getElementById('trPack').style.display="none";
      document.getElementById('<%= lblCpzt.ClientID %>').innerText="电芯尺寸";
   } else if ("PACK"==cpzt){
      document.getElementById('divPackchfs').style.display="block";
      document.getElementById('divDxchfs').style.display="none";
      document.getElementById('trPack').style.display="";
      document.getElementById('<%= lblCpzt.ClientID %>').innerText="成品(PACK)尺寸";
   }
}

//电芯出货方式   单体/配组 Dxchfs
function dxchfsChange(){
   var dxchfs=document.getElementById('<%= ddlDxchfs.ClientID %>').value;
   if ("单体出货"==dxchfs){
      document.getElementById('<%= tbSl.ClientID %>').style.display="none";
      document.getElementById('<%= tbDw.ClientID %>').style.display="none";
   } else if (("串联配组出货"==dxchfs)||("并联配组出货"==dxchfs)){
      document.getElementById('<%= tbSl.ClientID %>').style.display="";
      document.getElementById('<%= tbDw.ClientID %>').style.display="";
      document.getElementById('<%= tbDw.ClientID %>').value='PCS/组';
   }
}

//PACK出货方式 单体PACK/组合PACK 
function packchfsChange(){
  var packchfs=document.getElementById('<%= ddlPackchfs.ClientID %>').value;
  if("单体PACK"==packchfs){
    document.getElementById('spCBLQK').style.display="none";
  } else if ("组合PACK"){
    document.getElementById('spCBLQK').style.display=""; 
  } 
}


//成品尺寸类型  初始尺寸/循环后尺寸 
function cpcclxChange(){
   var cpcclx=document.getElementById('<%= ddlCpcclx.ClientID %>').value;
   if ("初始尺寸"==cpcclx){
      document.getElementById('<%= lblCclx.ClientID %>').innerText="初始";
      document.getElementById('divXhzq').style.display="none";
   } else if ("循环后尺寸"==cpcclx){
      document.getElementById('<%= lblCclx.ClientID %>').innerText="循环后";
      document.getElementById('divXhzq').style.display="block";
   }
}

//内部结构尺寸是否被勾选
function nbjgccChange(){
      if(document.getElementById('<%= cbNbkjcc.ClientID %>').checked){
        document.getElementById('trNbjgcc').style.display="";
      } else {
        document.getElementById('trNbjgcc').style.display="none";
      }
}

//点击退单历史显示退单历史
function tdlsClick(){
   document.getElementById('divTdls').style.display="";
}


//载入页面时，判断DIV是否显示
window.onload=function divVisible(){
   cpztChange();// 成品状态 电芯/PACK
   cpcclxChange();// 成品尺寸类型 初始尺寸/循环后尺寸 
   nbjgccChange();//内部结构尺寸是否被勾选
   dxchfsChange();//电芯出货方式  单体/组合
   packchfsChange();//PAKC出货方式 单体/组合                  
}


//2、以下修改为 a,“是否需UL认证” “要/不要” b,“要”时，增加字段“是否有替代型号”  “有/没有”   ，“有”时给个框填写型号

function sfxyulChange(){
  if (document.getElementById('ddlSfxyul').value=="要"){
    ValidatorEnable(document.getElementById('<%= CompareValidator8.ClientID %>'), true);
  } else {
     ValidatorEnable(document.getElementById('<%= CompareValidator8.ClientID %>'), false);
  }
   
  
}

function sfytdxhChange(){
  if (document.getElementById('ddlSfytdxh').value=="有"){
    ValidatorEnable(document.getElementById('<%= RequiredFieldValidator7.ClientID %>'), true);
  } else {
     ValidatorEnable(document.getElementById('<%= RequiredFieldValidator7.ClientID %>'), false);
  }
  
}



//退回的单子业务员修改后
function lbtnOK_disbale(){
  if (document.getElementById('<%= ddlXsry.ClientID %>').value.length>0 && document.getElementById('<%= tbXsryhqsj.ClientID %>').value.length<=0 ){
         var sysDate=new Date(); 
         document.getElementById('<%= tbXsryhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
         //初始化会签状态
         document.getElementById('<%= tbLchqzt.ClientID %>').value="业务员已修改";
  }
}


function cpkftaPrint(){
   window.print();
}



    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div style="font-size: 12px;">
            <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="true"
                EnableScriptLocalization="true">
                <Services>
                    <asp:ServiceReference Path="~/AutoCompleteService.svc" />
                </Services>
            </ajaxToolkit:ToolkitScriptManager>
            <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                id="border" onclick="return border_onclick()">
                <tr style="font-size: 25px; font-weight: bold;">
                    <td colspan="12">
                        <label id="lblTitle" runat="server">产品开发提案书</label> <input id="Button1" class="noprint" onclick="cpkftaPrint()" type="button"
                            value="打印" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 79px;">
                        编号</td>
                    <td colspan="3">
                        <asp:TextBox ID="tbBh" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="width: 61px;">
                        流程会签状态</td>
                    <td colspan="3">
                        <asp:TextBox ID="tbLchqzt" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="width: 60px;">
                        日期</td>
                    <td colspan="3">
                        <asp:TextBox ID="tbJBRQ" runat="server" Width="90%"></asp:TextBox></td>
                </tr>
                <tr id="trTdls" runat="server" visible="false">
                    <td colspan="12">
                        <a href="javascript:void(0)" onclick="tdlsClick()">点击查看退单历史</a>
                        <div id="divTdls" style="display:none">
                            退单次数
                            <asp:TextBox ID="tbTdcs" runat="server" Width="67px"></asp:TextBox><div>
                                <asp:TextBox ID="tbLsjl" runat="server" Rows="30" TextMode="MultiLine" Width="90%"></asp:TextBox><br />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr id="trKhxx" runat="server">
                    <td style="width: 79px;" rowspan="2">
                        客户信息</td>
                    <td style="width: 103px;">
                        客户型号</td>
                    <td colspan="4">
                        <asp:TextBox ID="tbKhxh" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="width: 75px;" class="tdNeed">
                        客户代码(＊)</td>
                    <td colspan="5">
                        <asp:TextBox ID="tbKhdm" runat="server" Width="90%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="请填写客户代码"
                            Display="Dynamic" ControlToValidate="tbKhdm" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server"
                            ControlToValidate="tbKhdm" Display="Dynamic" ErrorMessage="客户代码需要为FXXXX的格式，其中F大写，XXXX为4位数字和字母组合"
                            SetFocusOnError="true" ValidationExpression="^[F][A-Z0-9]{4}$"></asp:RegularExpressionValidator></td>
                </tr>
                <tr id="trZyx" runat="server">
                    <td style="width: 103px;">
                        重要性</td>
                    <td colspan="4">
                        <asp:CheckBoxList ID="cblZyx" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem>A</asp:ListItem>
                            <asp:ListItem>B</asp:ListItem>
                            <asp:ListItem>C</asp:ListItem>
                            <asp:ListItem>D</asp:ListItem>
                            <asp:ListItem>E</asp:ListItem>
                        </asp:CheckBoxList></td>
                    <td style="width: 75px;" class="tdNeed">
                        应用领域(＊)</td>
                    <td colspan="5">
                        <asp:TextBox ID="tbYyly" runat="server" Width="90%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbYyly"
                            Display="Dynamic" ErrorMessage="请填写应用领域" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                </tr>
                <tr runat="server" id="trUlxx" class="tdNeed">
                    <td rowspan="1" style="width: 79px">
                        UL信息</td>
                    <td style="width: 103px;">
                        是否需要UL认证(＊)</td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlSfxyul" runat="server" onchange="sfxyulChange()">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>要</asp:ListItem>
                            <asp:ListItem>不要</asp:ListItem>
                        </asp:DropDownList><asp:CompareValidator ID="CompareValidator7" runat="server" ControlToValidate="ddlSfxyul"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择是否需要UL认证" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                        </asp:CompareValidator></td>
                    <td colspan="2">
                        是否有替代型号</td>
                    <td class="tdNeed" style="width: 75px;">
                        <asp:DropDownList ID="ddlSfytdxh" runat="server" onchange="sfytdxhChange()">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>有</asp:ListItem>
                            <asp:ListItem>无</asp:ListItem>
                        </asp:DropDownList><asp:CompareValidator ID="CompareValidator8" runat="server" ControlToValidate="ddlSfytdxh"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择是否有替代型号" Operator="NotEqual"
                            Enabled="false" SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                        </asp:CompareValidator></td>
                    <td colspan="5">
                        UL替代型号<asp:TextBox ID="tbUltdxh" runat="server" Width="50%"></asp:TextBox><asp:RequiredFieldValidator
                            ID="RequiredFieldValidator7" runat="server" ControlToValidate="tbUltdxh" Display="Dynamic"
                            ErrorMessage="请填写UL替代型号" SetFocusOnError="true" Enabled="false"></asp:RequiredFieldValidator></td>
                </tr>
            </table>
            
          <table width="760"  border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                id="tableKhxq">
              <tr>
                <td rowspan="13">&nbsp;客户需求 &nbsp;</td>
                <td>
                        内部型号&nbsp;</td>
                <td colspan="5">&nbsp; &nbsp;
                    <asp:TextBox ID="tbNbxh" runat="server" Width="90%"></asp:TextBox>&nbsp;</td>
              </tr>
              <tr>
                <td class="tdNeed">
                        成品状态(＊)&nbsp;</td>
                <td>&nbsp;<asp:DropDownList ID="ddlCpzt" runat="server" onchange="cpztChange()">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>电芯</asp:ListItem>
                            <asp:ListItem>PACK</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" ControlToValidate="ddlCpzt" runat="server"
                            Type="string" ValueToCompare="请选择" Operator="NotEqual" ErrorMessage="请选择成品状态"
                            EnableTheming="true" SetFocusOnError="true" Display="Dynamic">
                        </asp:CompareValidator></td>
                <td colspan="4">
                    <div id="divDxchfs" style="display: block">
                        <asp:DropDownList ID="ddlDxchfs" runat="server" onchange="dxchfsChange()" Width="30%">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>单体出货</asp:ListItem>
                            <asp:ListItem>串联配组出货</asp:ListItem>
                            <asp:ListItem>并联配组出货</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="tbSl" runat="server" Width="25%"></asp:TextBox>
                        <asp:TextBox ID="tbDw" runat="server" Width="25%"></asp:TextBox></div>
                    <div id="divPackchfs" style="display: none">
                        <asp:DropDownList ID="ddlPackchfs" runat="server" onchange="packchfsChange()" Width="35%">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>单体PACK</asp:ListItem>
                            <asp:ListItem>组合PACK</asp:ListItem>
                        </asp:DropDownList><span id="spCBLQK">串并联情况
                            <asp:TextBox ID="tbCblqk" runat="server" Width="25%"></asp:TextBox></span></div>
                </td>
              </tr>
              <tr>
                <td>&nbsp;成品尺寸类型</td>
                <td colspan="2">&nbsp;&nbsp;<asp:DropDownList ID="ddlCpcclx" runat="server" Width="90%" onchange="cpcclxChange()">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>初始尺寸</asp:ListItem>
                            <asp:ListItem>循环后尺寸</asp:ListItem>
                        </asp:DropDownList></td>
                <td colspan="2">&nbsp; 循环周期<asp:TextBox ID="tbXhzq" runat="server" Width="32px"></asp:TextBox>周</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                  <td colspan="6" >
                        <asp:CheckBox ID="cbNbkjcc" runat="server" Text="客户机器内部空间尺寸" onclick="nbjgccChange()" />
                        （需要填写内部空间尺寸时请勾选此项填写详细尺寸）</td>
              </tr>
              <tr>
                  <td>
                  </td>
                  <td>
                        厚(mm)≤</td>
                  <td>
                        宽(mm)≤</td>
                  <td>
                        高(mm)≤</td>
                  <td>
                  </td>
                  <td>
                  </td>
              </tr>
              <tr>
                  <td>
                        <asp:Label ID="lblCclx" runat="server" Text=""></asp:Label><asp:Label ID="lblCpzt"
                            runat="server" Text=""></asp:Label></td>
                  <td>
                        <asp:TextBox ID="tbCCH" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                        <asp:TextBox ID="tbCCK" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                        <asp:TextBox ID="tbCCC" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                  </td>
                  <td>
                  </td>
              </tr>
              <tr id="trNbjgcc" >
                  <td>
                        客户机器内部空间尺寸</td>
                  <td>
                        <asp:TextBox ID="tbNBCCH" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                        <asp:TextBox ID="tbNBCCK" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                        <asp:TextBox ID="tbNBCCC" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                  </td>
                  <td>
                  </td>
              </tr>
              <tr>
                  <td class="tdNeed">
                      标称容量(mAh)</td>
                  <td>
                        <asp:TextBox ID="tbBcrl" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="tbBcrl"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="标称容量只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" /><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="请填写标称容量"
                            Display="Dynamic" ControlToValidate="tbBcrl" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                  <td>
                      最小容量(mAh)</td>
                  <td>
                        <asp:TextBox ID="tbZxrl" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="tbZxrl"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="最小容量只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" /></td>
                  <td>
                      内阻(mΩ)</td>
                  <td>
                        <asp:TextBox ID="tbNz" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator6" ControlToValidate="tbNz"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="内阻只能为数字" runat="server" Display="Dynamic"
                            SetFocusOnError="true" /></td>
              </tr>
              <tr>
                  <td class="tdNeed">
                      出货电压(V)</td>
                  <td colspan="3">
                        <asp:TextBox ID="tbChdy" runat="server" Width="40%"></asp:TextBox>
                        ～<asp:TextBox ID="tbChdyMax" runat="server" Width="40%"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ControlToValidate="tbChdy"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="出货电压只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbChdy"
                            Display="Dynamic" ErrorMessage="请填写出货电压" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        &nbsp;&nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator14" ControlToValidate="tbChdyMax"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="出货电压只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" />&nbsp;
                  </td>
                  <td>
                        标称电压(V)</td>
                  <td>
                        <asp:TextBox ID="tbBcdy" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator15" ControlToValidate="tbBcdy"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="标称电压只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" /></td>
              </tr>
              <tr>
                  <td>
                      极耳长度(mm)</td>
                  <td colspan="2">
                        <asp:TextBox ID="tbJecd" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator8" ControlToValidate="tbJecd" ValidationExpression="^\d+(\.\d+)?$"
                            ErrorMessage="极耳长度只能为数字" runat="server" Display="Dynamic" SetFocusOnError="true" /></td>
                  <td>
                      极耳宽度(mm)</td>
                  <td colspan="2">
                        <asp:TextBox ID="tbJekd" runat="server" Width="90%"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" ControlToValidate="tbJekd"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="极耳宽度只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" /></td>
              </tr>
              <tr>
                  <td>
                        极耳中心距(mm)</td>
                  <td>
                        <asp:TextBox ID="tbJezxj" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator10" ControlToValidate="tbJezxj"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="极耳中心距只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" /></td>
                  <td>
                      焊盘中心距(mm)</td>
                  <td>
                        <asp:TextBox ID="tbHpzxj" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator11" ControlToValidate="tbHpzxj"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="焊盘中心距只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" /></td>
                  <td>
                      焊盘宽度(mm)</td>
                  <td>
                        <asp:TextBox ID="tbHpkd" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator12" ControlToValidate="tbHpkd"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="焊盘宽度只能为数字" runat="server"
                            Display="Dynamic" SetFocusOnError="true" /></td>
              </tr>
              <tr>
                  <td>
                        产品销往地</td>
                  <td colspan="3">
                        <asp:TextBox ID="tbCpxwd" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                        运输方式</td>
                  <td>
                        <asp:TextBox ID="tbYsfs" runat="server" Width="90%"></asp:TextBox></td>
              </tr>
              <tr>
                  <td>
                        环保要求</td>
                  <td colspan="2">
                        <asp:TextBox ID="tbHbyq" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                        认证要求</td>
                  <td colspan="2">
                        <asp:TextBox ID="tbRzyq" runat="server" Width="90%"></asp:TextBox></td>
              </tr>
              <tr>
                  <td colspan="7" rowspan="1">
                  </td>
              </tr>
              <tr>
                  <td rowspan="3">
                      工作状态</td>
                  <td>
                      充电电流(mA)</td>
                  <td>
                        <asp:TextBox ID="tbCddl" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                      放电电流(mA)</td>
                  <td>
                        <asp:TextBox ID="tbFddl" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                        最大使用电流(mA)</td>
                  <td>
                        <asp:TextBox ID="tbZdsydl" runat="server" Width="90%"></asp:TextBox></td>
              </tr>
              <tr>
                  <td>
                        持续时间</td>
                  <td>
                        <asp:TextBox ID="tbCxsj" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                      充电温度(℃)</td>
                  <td>
                        <asp:TextBox ID="tbCdwd" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                        放电温度</td>
                  <td>
                        <asp:TextBox ID="tbFdwd" runat="server" Width="90%"></asp:TextBox></td>
              </tr>
              <tr>
                  <td>
                      截至电压(V)</td>
                  <td>
                        <asp:TextBox ID="tbJzdy" runat="server" Width="90%"></asp:TextBox></td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
              </tr>
            </table>

            <table border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                id="tablePackyq" width="760">
                <tr id="trPack" style="display: none" bgcolor="#FFCCCC">
                    <td style="height: 38px; width: 79px;">
                        P<br />
                        A<br />
                        C<br />
                        K<br />
                        要<br />
                        求</td>
                    <td colspan="11" style="height: 38px">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="10%">
                                    &nbsp;PACK方式</td>
                                <td colspan="9">
                                    &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;<asp:CheckBoxList ID="cblPACKFS" runat="server"
                                        RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem>加板加(插头)线</asp:ListItem>
                                        <asp:ListItem>加板加(插头)线加热缩膜</asp:ListItem>
                                        <asp:ListItem>只加引线</asp:ListItem>
                                        <asp:ListItem>加板加外壳</asp:ListItem>
                                        <asp:ListItem>其他PACK方式</asp:ListItem>
                                    </asp:CheckBoxList>&nbsp;</td>
                            </tr>
                            <tr>
                                <td rowspan="6" width="10%">
                                    保护板</td>
                                <td colspan="2" rowspan="2">
                                    保护IC品牌/规格</td>
                                <td style="width: 10%;">
                                    品牌</td>
                                <td colspan="5">
                                    <asp:CheckBoxList ID="cblPP" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem>精工</asp:ListItem>
                                        <asp:ListItem>理光</asp:ListItem>
                                        <asp:ListItem>光之美</asp:ListItem>
                                        <asp:ListItem>宏康</asp:ListItem>
                                        <asp:ListItem>富晶</asp:ListItem>
                                    </asp:CheckBoxList></td>
                                <td width="10%">
                                    <asp:CheckBox ID="cbICPPNK" runat="server" Text="内控" /></td>
                            </tr>
                            <tr>
                                <td style="width: 10%;">
                                    规格</td>
                                <td colspan="5">
                                    <asp:TextBox ID="tbGG" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    <asp:CheckBox ID="cbGgnk" runat="server" Text="内控" /></td>
                            </tr>
                            <tr>
                                <td colspan="8">
                                    电量管理IC规格：<asp:TextBox ID="tbDlglicgg" runat="server" Width="75%"></asp:TextBox></td>
                                <td width="10%">
                                    <asp:CheckBox ID="cbDlglicggnk" runat="server" Text="内控" /></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    MOS管要求</td>
                                <td colspan="7">
                                    <asp:TextBox ID="tbMosgyq" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    <asp:CheckBox ID="cbMOSGNK" runat="server" Text="内控" /></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    NTC阻值(K)</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbNTCZZ" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    B值(K)</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbBz" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    精度</td>
                                <td colspan="2">
                                    <asp:DropDownList ID="ddlJD" runat="server">
                                        <asp:ListItem>请选择</asp:ListItem>
                                        <asp:ListItem>&#177;1%</asp:ListItem>
                                        <asp:ListItem>&#177;3%</asp:ListItem>
                                        <asp:ListItem>&#177;5%</asp:ListItem>
                                        <asp:ListItem>&#177;10%</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    PPTC</td>
                                <td width="10%">
                                    Hold电流</td>
                                <td style="width: 10%;">
                                    <asp:TextBox ID="tbHolddl" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    Trip电流</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbTripdl" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    其他要求</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbBhbQtyq" runat="server" Width="90%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    Breaker温度开关</td>
                                <td colspan="5">
                                    <asp:CheckBoxList ID="cblBreakerwdkg" runat="server" RepeatDirection="Horizontal"
                                        RepeatLayout="Flow">
                                        <asp:ListItem>LC72AY</asp:ListItem>
                                        <asp:ListItem>LC77AY</asp:ListItem>
                                        <asp:ListItem>LC82AY</asp:ListItem>
                                        <asp:ListItem>LC85AY</asp:ListItem>
                                    </asp:CheckBoxList></td>
                                <td width="10%">
                                    其他规格</td>
                                <td colspan="3">
                                    <asp:TextBox ID="tbQTGG" runat="server" Width="90%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    Fuse保险丝</td>
                                <td colspan="9">
                                    <asp:TextBox ID="tbFusebxs" runat="server" Width="90%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td width="10%" rowspan="3">
                                    电子线</td>
                                <td width="10%">
                                    出线位置</td>
                                <td colspan="8">
                                    <asp:TextBox ID="tbCxwz" runat="server" Width="90%"></asp:TextBox>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    线规</td>
                                <td width="10%">
                                    <asp:CheckBox ID="cbXgnk" runat="server" Text="内控" /></td>
                                <td colspan="7">
                                    <asp:CheckBoxList ID="cblXg" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                        Width="85%">
                                        <asp:ListItem>UL3302/20awg</asp:ListItem>
                                        <asp:ListItem>UL3302/22awg</asp:ListItem>
                                        <asp:ListItem>UL3302/24awg</asp:ListItem>
                                        <asp:ListItem>UL3302/26awg</asp:ListItem>
                                        <asp:ListItem>UL3302/28awg</asp:ListItem>
                                        <asp:ListItem>UL3302/30awg</asp:ListItem>
                                    </asp:CheckBoxList></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    外线露长±3mm：<asp:TextBox ID="tbWxlc" runat="server" Width="40%"></asp:TextBox></td>
                                <td colspan="3">
                                    线头挂锡长度±0.5mm：<asp:TextBox ID="tbXtgxcd" runat="server" Width="30%"></asp:TextBox></td>
                                <td width="10%">
                                    其他</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbDzxqt" runat="server" Width="90%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td width="10%" rowspan="2">
                                    插头线</td>
                                <td colspan="2">
                                    连接器品牌</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbLjqpp" runat="server" Width="90%"></asp:TextBox></td>
                                <td colspan="2">
                                    连接器规格：</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbLjqgg" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    <asp:CheckBox ID="cbLjqnk" runat="server" Text="内控" /></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    排列线序</td>
                                <td colspan="4">
                                    <asp:CheckBox ID="cbDzmxs" runat="server" Text="端子面向上" />
                                    <asp:TextBox ID="tbDzmxsnr" runat="server" Width="50%"></asp:TextBox></td>
                                <td colspan="4">
                                    <asp:CheckBox ID="cbDzmxx" runat="server" Text="端子面向下" />
                                    <asp:TextBox ID="tbDzmxxnr" runat="server" Width="50%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    PVC热缩膜</td>
                                <td width="10%">
                                    颜色</td>
                                <td colspan="4">
                                    <asp:CheckBoxList ID="cblPVCRsmys" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem>内控</asp:ListItem>
                                        <asp:ListItem>蓝色</asp:ListItem>
                                        <asp:ListItem>透明</asp:ListItem>
                                        <asp:ListItem>白色</asp:ListItem>
                                    </asp:CheckBoxList></td>
                                <td width="10%">
                                    其他颜色</td>
                                <td colspan="3">
                                    <asp:TextBox ID="tbQtys" runat="server" Width="50%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td rowspan="2" width="10%">
                                    塑胶壳</td>
                                <td width="10%">
                                    颜色</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbSjkys" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    材质</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbSjkcz" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    防火等级</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbFhdj" runat="server" Width="90%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    供应方式</td>
                                <td colspan="3">
                                    <asp:CheckBoxList ID="cblGyfs" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem>客供</asp:ListItem>
                                        <asp:ListItem>手板</asp:ListItem>
                                        <asp:ListItem>自行开模</asp:ListItem>
                                    </asp:CheckBoxList></td>
                                <td style="width: 10%;">
                                    其他要求</td>
                                <td colspan="4">
                                    <asp:TextBox ID="tbSjkqtyq" runat="server" Width="90%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td width="10%">
                                    双面胶</td>
                                <td width="10%">
                                    品牌</td>
                                <td colspan="2">
                                    <asp:CheckBoxList ID="cblSmjpp" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem>3M</asp:ListItem>
                                        <asp:ListItem>普通</asp:ListItem>
                                    </asp:CheckBoxList></td>
                                <td width="10%">
                                    规格型号</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbGGXH" runat="server" Width="90%"></asp:TextBox></td>
                                <td width="10%">
                                    粘帖位置</td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbNTWZ" runat="server" Width="90%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    其他PACK器件</td>
                                <td colspan="8">
                                    <asp:TextBox ID="tbQtPACKqj" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="width: 79px;">
                        喷码要求</td>
                    <td colspan="11">
                        <asp:TextBox ID="tbPmyq" runat="server" Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 79px;">
                        侧边保护方式
                    </td>
                    <td colspan="11">
                        <asp:TextBox ID="tbCbbhfs" runat="server" Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 79px;">
                        成品包装方式</td>
                    <td colspan="11">
                        <asp:TextBox ID="tbCpbzfs" runat="server" Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 79px;">
                        其他要求</td>
                    <td colspan="11">
                        <asp:TextBox ID="tbQtyq" runat="server" Rows="5" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
            </table>
            <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                id="tableCpkfta" runat="server">
                <tr>
                    <td colspan="3" class="tdNeed">
                        样品建议书(＊)</td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlYpjys" runat="server">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>要</asp:ListItem>
                            <asp:ListItem>不要</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" SetFocusOnError="true"
                            EnableTheming="true" ErrorMessage="请选择是否需要样品建议书" Operator="NotEqual" ValueToCompare="请选择"
                            Type="string" ControlToValidate="ddlYpjys" Display="Dynamic">
                        </asp:CompareValidator>
                    </td>
                    <td colspan="2">
                        电子版规格书</td>
                    <td colspan="5">
                        <asp:DropDownList ID="ddlDzbggs" runat="server">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>要</asp:ListItem>
                            <asp:ListItem>不要</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CheckBoxList ID="cblGgsyy" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem>中文</asp:ListItem>
                            <asp:ListItem>英文</asp:ListItem>
                        </asp:CheckBoxList></td>
                </tr>
                <tr>
                    <td style="width: 79px;" class="tdNeed">
                        收费情况(＊)</td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlSfqk" runat="server">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>免费样品</asp:ListItem>
                            <asp:ListItem>收费样品</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator3" runat="server" SetFocusOnError="true"
                            EnableTheming="true" ErrorMessage="请选择收费情况" Operator="NotEqual" ValueToCompare="请选择"
                            Type="string" ControlToValidate="ddlSfqk" Display="Dynamic">
                        </asp:CompareValidator>
                    </td>
                    <td class="tdNeed">
                        制作情况(＊)</td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlZzqk" runat="server">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>库存出货</asp:ListItem>
                            <asp:ListItem>样品新做</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator4" runat="server" SetFocusOnError="true"
                            EnableTheming="true" ErrorMessage="请选择制作情况" Operator="NotEqual" ValueToCompare="请选择"
                            Type="string" ControlToValidate="ddlZzqk" Display="Dynamic">
                        </asp:CompareValidator>
                    </td>
                    <td style="width: 63px;">
                        是否开模</td>
                    <td style="width: 60px;">
                        &nbsp;<asp:DropDownList ID="ddlSfkm" runat="server">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>是</asp:ListItem>
                            <asp:ListItem>否</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 60px;">
                        预计价格</td>
                    <td colspan="3">
                        &nbsp;<asp:DropDownList ID="ddlYjjgdw" runat="server" Width="28%">
                            <asp:ListItem Selected="True">￥</asp:ListItem>
                            <asp:ListItem>$</asp:ListItem>
                            <asp:ListItem>HK＄</asp:ListItem>
                            <asp:ListItem>NT＄</asp:ListItem>
                            <asp:ListItem>€</asp:ListItem>
                            <asp:ListItem>￡</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="tbYjjg" runat="server" Width="50%"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="tbYjjg"
                            ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="价格只能为数字" runat="server" Display="Dynamic"
                            SetFocusOnError="true" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 79px;" class="tdNeed">
                        送样数量(＊)</td>
                    <td colspan="2">
                        <asp:TextBox ID="tbSysl" runat="server" Width="90%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="请填写送样数量"
                            ControlToValidate="tbSysl" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="tbSysl"
                            ValidationExpression="^\d*$" ErrorMessage="数量只能为数字" runat="server" Display="Dynamic"
                            SetFocusOnError="true" />
                    </td>
                    <td class="tdNeed">
                        单位(＊)</td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlSydw" runat="server">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator6" runat="server" SetFocusOnError="true"
                            EnableTheming="true" ErrorMessage="请选择单位" Operator="NotEqual" ValueToCompare="请选择"
                            Type="string" ControlToValidate="ddlSydw" Display="Dynamic">
                        </asp:CompareValidator>
                    </td>
                    <td style="width: 63px;" class="tdNeed">
                        电芯数量(＊)</td>
                    <td style="width: 60px;">
                        <asp:TextBox ID="tbDxsl" runat="server" Width="90%" onchange="zdxslChange()"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="请填写送样数量"
                            ControlToValidate="tbDxsl" Display="Dynamic">
                  
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="tbDxsl"
                            ValidationExpression="^\d*$" ErrorMessage="数量只能为数字" runat="server" Display="Dynamic"
                            SetFocusOnError="true" />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="配组出货时，电芯数量必须大于送样数量"
                            OnServerValidate="CustomValidator1_ServerValidate" Display="Dynamic" SetFocusOnError="true"
                            ControlToValidate="tbDxsl"></asp:CustomValidator>
                    </td>
                    <td style="width: 60px;">
                        送样方式</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlSyfs" runat="server" Width="90%">
                            <asp:ListItem>交业务员</asp:ListItem>
                            <asp:ListItem>送PACK</asp:ListItem>
                            <asp:ListItem>指定地址送样(附地址)</asp:ListItem>
                            <asp:ListItem>其他方式</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr style="display: none">
                    <td style="width: 79px;">
                        详细地址</td>
                    <td colspan="11">
                        <asp:TextBox ID="tbXxdz" runat="server" Rows="5" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="12">
                        <asp:CheckBox ID="cbYpcsbg" runat="server" Text="样品测试报告" Style="float: left" /></td>
                </tr>
                <tr>
                    <td style="width: 79px;">
                        附件</td>
                    <td colspan="11">
                        &nbsp;可添加附件（客户详细要求）<asp:FileUpload ID="fulFj" runat="server" />
                        <asp:TextBox ID="tbURL" runat="server" Style="border-right: 0px; border-top: 0px;
                            border-left: 0px; border-bottom: 1px" Width="247px"></asp:TextBox><br />
                        &nbsp;<asp:ImageButton ID="iBtnDownLoad" runat="server" ImageUrl="~/images/btnDownload.jpg"
                            OnClick="btnDownLoad_Click" /></td>
                </tr>
                <tr bgcolor="#CCFFFF" id="trScqj" runat="server">
                    <td rowspan="4" style="width: 79px">
                        评审意见</td>
                    <td colspan="2">
                        1.预计销售需求</td>
                    <td colspan="2">
                        2.预计市场前景</td>
                    <td  colspan="4">
                        3.市场风险简述</td>
                    <td colspan="3" class="tdNeed">
                        4.评估结论(＊)</td>
                </tr>
                <tr bgcolor="#CCFFFF"  id="trScqjnr" runat="server">
                    <td colspan="2">
                        <asp:TextBox ID="tbYjxsxq" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
                    <td colspan="2">
                        <asp:TextBox ID="tbYjscqj" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
                    <td colspan="4">
                        <asp:TextBox ID="tbScfxjs" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox>&nbsp;</td>
                    <td colspan="3" rowspan="3">
                        <asp:DropDownList ID="ddlPgjl" runat="server" Width="69%">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>同意</asp:ListItem>
                            <asp:ListItem>不同意</asp:ListItem>
                        </asp:DropDownList><asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="ddlPgjl"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择评估结论" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                        </asp:CompareValidator></td>
                </tr>
            </table>
            <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                id="tablePs">
                <tr bgcolor="#CCFFFF">
                    <td style="width: 60px;">
                        &nbsp;销售人员</td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlXsry" runat="server" Width="45%" onchange="xsryChange()">
                        </asp:DropDownList>
                        <asp:TextBox ID="tbXsryhqsj" runat="server" Width="45%"></asp:TextBox></td>
                    <td style="width: 60px;">
                        &nbsp;销售经理</td>
                    <td colspan="6">
                        &nbsp;&nbsp;<asp:DropDownList ID="ddlXsjl" runat="server" Width="45%" onchange="xsjlChange()">
                        </asp:DropDownList>
                        <asp:TextBox ID="tbXsjlhqsj" runat="server" Width="45%"></asp:TextBox></td>
                </tr>
                <tr bgcolor="#CCFFFF">
                    <td style="width: 60px;" id="tdSwjl" runat="server">
                        &nbsp;商务经理</td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlSwjl" runat="server" Width="45%" onchange="swjlChange()">
                        </asp:DropDownList>
                        <asp:TextBox ID="tbSwjlhqsj" runat="server" Width="45%"></asp:TextBox></td>
                    <td style="width: 60px;" id="tdZg" runat="server">
                        &nbsp;总工</td>
                    <td colspan="6">
                        &nbsp;&nbsp;<asp:DropDownList ID="ddlZg" runat="server" Width="45%" onchange="zgChange()">
                        </asp:DropDownList>
                        <asp:TextBox ID="tbZghqsj" runat="server" Width="45%"></asp:TextBox></td>
                </tr>
                <tr bgcolor="#ccffff" style="display:none;">
                    <td style="width: 60px;">
                        评审批注</td>
                    <td colspan="11">
                        <asp:TextBox ID="tbPspz" runat="server" Rows="9" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
                <tr bgcolor="#ccffff" id="trGGS1" runat="server" visible="false">
                    <td style="width: 60px;">
                        规格书编号</td>
                    <td colspan="4">
                        <asp:TextBox ID="tbGGSBH" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="width: 60px;">
                        &nbsp;版本</td>
                    <td colspan="6">
                        <asp:TextBox ID="tbGGSBB" runat="server" Width="90%"></asp:TextBox></td>
                </tr>
                <tr bgcolor="#ccffff" id="trGGS2" runat="server" visible="false">
                    <td style="width: 60px;">
                        &nbsp;实验室</td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlSys" runat="server" Width="45%" onchange="sysChange()">
                        </asp:DropDownList>
                        <asp:TextBox ID="tbSyshqsj" runat="server" Width="45%"></asp:TextBox></td>
                    <td style="width: 60px;">
                    </td>
                    <td colspan="6">
                    </td>
                </tr>
                <tr bgcolor="#ccffff" id="trGGS3" runat="server" visible="false">
                    <td style="width: 60px;">
                        是否需要退单</td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlSfxyth" runat="server" Width="45%" onchange="swjlChange()">
                            <asp:ListItem>否</asp:ListItem>
                            <asp:ListItem>是</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="width: 60px;">
                        退单理由</td>
                    <td colspan="6" rowspan="1">
                        <asp:TextBox ID="tbTdly" runat="server" Rows="9" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
                <tr style="display:none">
                    <td style="border: 0px;">
                    </td>
                    <td style="border: 0px" colspan="11" align="center">
                        <asp:ImageButton ID="iBtnOK" runat="Server" ImageUrl="~/images/btnSubmit.jpg" OnClick="btnTj_Click"  OnClientClick="lbtnOK_disbale()"/>
                    </td>
                </tr>
                <tr style="display:none">
                    <td style="height: 47px; width: 79px;">
                        销售人员</td>
                    <td style="height: 47px; width: 60px;">
                        <asp:DropDownList ID="ddlXsryhqzt" runat="server" Width="90%">
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="height: 47px; width: 61px;">
                        销售经理</td>
                    <td style="height: 47px; width: 60px;">
                        <asp:DropDownList ID="ddlXsjlhqzt" runat="server" Width="90%">
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="height: 47px; width: 61px;">
                        商务经理</td>
                    <td style="height: 47px; width: 60px;">
                        <asp:DropDownList ID="ddlSwjlhqzt" runat="server" Width="90%">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="height: 47px; width: 63px;">
                        总工</td>
                    <td style="height: 47px; width: 60px;">
                        <asp:DropDownList ID="ddlZghqzt" runat="server" Width="90%">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="height: 47px; width: 60px;">
                        实验室</td>
                    <td style="height: 47px; width: 60px;">
                        <asp:DropDownList ID="ddlSyshqzt" runat="server" Width="90%">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="height: 47px; width: 66px;">
                    </td>
                    <td style="height: 47px">
                    </td>
                </tr>
            </table>
            <div style="display: none">
                <asp:TextBox ID="fileName" runat="server"></asp:TextBox>
                <asp:TextBox ID="tbDjlx" runat="server"></asp:TextBox></div>
        </div>
    </form>
</body>
</html>
