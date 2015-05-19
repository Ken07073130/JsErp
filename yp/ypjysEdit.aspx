<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ypjysEdit.aspx.cs" Inherits="ypjysEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>样品建议书</title>
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
  
  .tdNeed {
    color:#FF0000;
  }
 

  .STYLE_Title {
    font-size:22px;
    font-weight:bold;
  }
  .STYLE_ChildTitle {
    font-size:15px;
    font-weight:bold;
  }
  .STYLE_RESULT{
    font-weight:bold;
  }
  
  .ulTab{
    /*width:760px;*/  
    background:#FFF;
    overflow:hidden;  
    /*UL填充满DIV*/
    margin:0px;
    padding:0px;
  }
  .ulTab li{
    display:inline; 
    float:left; 
    text-align:center;
    border: 1px solid #FFF;
  }
  .ulTab li a {
     background-color:#F4F4F4;
     text-decoration:none; 
	 display:block; 
     width:150px; 
	 height:30px; 
     line-height:34px; 
     color:#000;
  }
  
  .ulTab li a:hover{
    background-color:#FFF;
	font-weight:bold;
  }
  
  #divAll{
    position:relative;
    overflow:hidden; 
	margin:auto;
  }
  
  /*#divAll table {
    border-collapse:collapse;
    border:none;
  }
  
  #divAll td {
    border:solid #000 1px;
    border-color:"#cccc99";
  }*/
  
  #divTableLc {
     display:block;
  }
  #divTableLc td {
     border:0px;
  }
  
  #divTab1{
    display:block;
    margin-top:55px;
  }

  
  #divTab2{
    display:none;
  }
  
  #divTab3{
    display:none;
  }
  
  #divNav {
    position:fixed;
    left:200px;
    right:0px;
    width:530px;
    /*background-color:#000;*/
    margin-left:auto;
    margin-right:auto;
  }
 
  
</style>
</head>
<body>

    <script type="text/javascript"> 

//电芯出货方式   单体/配组 Dxchfs
function dxchfsChange(){
   var dxchfs=document.getElementById('<%= ddlDxchfs.ClientID %>').value;
   if ("单体出货"==dxchfs){
      document.getElementById('<%= tbDxchsl.ClientID %>').style.display="none";
      document.getElementById('<%= tbDw.ClientID %>').style.display="none";
   } else if (("串联配组出货"==dxchfs)||("并联配组出货"==dxchfs)){
      document.getElementById('<%= tbDxchsl.ClientID %>').style.display="";
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


//成品状态  电芯/PACK
function cpztChange(){
   var cpzt=document.getElementById('<%= ddlCpzt.ClientID %>').value;
   if ("电芯"==cpzt){
      document.getElementById('divDxchfs').style.display="block";
      document.getElementById('divPackchfs').style.display="none";
      document.getElementById('trPack').style.display="none";
   } else if ("PACK"==cpzt){
      document.getElementById('divPackchfs').style.display="block";
      document.getElementById('divDxchfs').style.display="none";
      document.getElementById('trPack').style.display="";
   }
}



//载入页面时，判断DIV是否显示
window.onload=function divVisible(){
   cpztChange();// 成品状态 电芯/PACK
   dxchfsChange();//电芯出货方式  单体/组合
   packchfsChange();//PACK出货方式 单体/组合         
}



//受影响:发起部门、商务部审核状态 控制控件:发起审核人 
function fqrChange(){
       if(document.getElementById('<%= ddlFqr.ClientID %>').value.length>0){
         document.getElementById('<%= ddlFQBMHQZT.ClientID %>').value="会签中";
         document.getElementById('<%= tbLchqzt.ClientID %>').value="发起部门会签中"; 
       }
      if(document.getElementById('<%= tbFqrhqsj.ClientID %>').value==""){  
         //发起人时间更改 
         var sysDate=new Date(); 
         document.getElementById('<%= tbFqrhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(parseInt(sysDate.getMonth())+1)+"-"+sysDate.getDate();
       }
        
}
 
 //受影响:发起部门、商务部审核状态 控制控件:发起审核人 
function fqshrChange(){
       if(document.getElementById('<%= ddlFQSHR.ClientID %>').value.length>0){
         document.getElementById('<%= ddlFQBMHQZT.ClientID %>').value="已会签"; 
         var sysDate=new Date(); 
         document.getElementById('<%= tbFqshrhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(parseInt(sysDate.getMonth())+1)+"-"+sysDate.getDate();
         //如果下一步的状态不为空    
         if ("-"==document.getElementById('<%= ddlSWBHQZT.ClientID %>').value){
           document.getElementById('<%= ddlSWBHQZT.ClientID %>').value="会签中";
           document.getElementById('<%= tbLchqzt.ClientID %>').value="商务部会签中";
         }
         //免费样品，后续操作中，<1000MAH的20PCS以上免费，>=1000MAH-10PCS以上免费,这两种情况，务必主任/副主任签字说明原因
        if( 
             (parseInt(document.getElementById('<%= tbCpsl.ClientID %>').value)>=20)&&(parseInt(document.getElementById('<%= tbBcrl.ClientID %>').value)<1000)&&(document.getElementById('<%= ddlSfqk.ClientID %>').value=='免费样品')
           ||(parseInt(document.getElementById('<%= tbCpsl.ClientID %>').value)>=10)&&(parseInt(document.getElementById('<%= tbBcrl.ClientID %>').value)>=1000)&&(document.getElementById('<%= ddlSfqk.ClientID %>').value=='免费样品')
          ){ 
              ValidatorEnable(document.getElementById('<%= RequiredFieldValidator11.ClientID %>'), true);
            } 
          
       }
}

//受影响:(总经理助理),实验室审核状态 控制控件:商务审核人 
function swbChange(){
       if(document.getElementById('<%= ddlSwb.ClientID %>').value.length>0){
         //document.getElementById('<%= ddlSWBHQZT.ClientID %>').disabled=false;
         document.getElementById('<%= ddlSWBHQZT.ClientID %>').value='已会签';
         //document.getElementById('<%= ddlSWBHQZT.ClientID %>').disabled=true;
         var sysDate=new Date(); 
         document.getElementById('<%= tbSwbhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
         //
         if (("-"==document.getElementById('<%= ddlZJLHQZT.ClientID %>').value)&&("-"==document.getElementById('<%= ddlSYSHQZT.ClientID %>').value)){
            //<1000MAH的20PCS以上免费，>=1000MAH-10PCS以上免费,这两种情况，必须经过总经理助理
            if( 
                 (parseInt(document.getElementById('<%= tbCpsl.ClientID %>').value)>=20)&&(parseInt(document.getElementById('<%= tbBcrl.ClientID %>').value)<1000)
               ||(parseInt(document.getElementById('<%= tbCpsl.ClientID %>').value)>=10)&&(parseInt(document.getElementById('<%= tbBcrl.ClientID %>').value)>=1000)
              ){
               document.getElementById('<%= ddlZJLHQZT.ClientID %>').value="会签中";
               document.getElementById('<%= tbLchqzt.ClientID %>').value="总助会签中会签中";
            } else {
               document.getElementById('<%= ddlSYSHQZT.ClientID %>').value="会签中";
               document.getElementById('<%= tbLchqzt.ClientID %>').value="实验室会签中";
            }
         }
       }
}

 //受影响:实验室审核状态 控制控件:总经理
function zjlChange(){
       if(document.getElementById('<%= ddlZjl.ClientID %>').value.length>0){
           document.getElementById('<%= ddlZJLHQZT.ClientID %>').value="已会签";
           var sysDate=new Date(); 
           document.getElementById('<%= tbZjlhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
           if("-"==document.getElementById('<%= ddlSYSHQZT.ClientID %>').value){
              document.getElementById('<%= ddlSYSHQZT.ClientID %>').value="会签中";
              document.getElementById('<%= tbLchqzt.ClientID %>').value="实验室会签中";
           }
       }
       
}


 //受影响:项目负责人审核状态 控制控件:实验室
function sysChange(){
       if(document.getElementById('<%= ddlSys.ClientID %>').value.length>0){
           var sysDate=new Date(); 
           document.getElementById('<%= tbSyshqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
           document.getElementById('<%= ddlSYSHQZT.ClientID %>').value="已会签";
           if("-"==document.getElementById('<%= ddlXMFZRHQZT.ClientID %>').value){
              document.getElementById('<%= ddlXMFZRHQZT.ClientID %>').value="会签中";
              document.getElementById('<%= tbLchqzt.ClientID %>').value="技术部会签中";
           }
       }
       //实验室审核时候必填项激活
       ValidatorEnable(document.getElementById('<%= RequiredFieldValidator10.ClientID %>'), true);
}



 //受影响:总负责人审核状态 控制控件:技术负责人 
function xmfzrChange(){
       if(document.getElementById('<%= ddlJsfzr.ClientID %>').value.length>0){
           document.getElementById('<%= ddlXMFZRHQZT.ClientID %>').value="已会签";
           var sysDate=new Date(); 
           document.getElementById('<%= tbJsfzrhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
           if("-"==document.getElementById('<%= ddlZFZRHQZT.ClientID %>').value){
              document.getElementById('<%= ddlZFZRHQZT.ClientID %>').value="会签中";
              document.getElementById('<%= tbLchqzt.ClientID %>').value="总负责人会签中";
           }
       }
}

 //受影响:总负责人审核状态 控制控件:总负责人
function zfzrChange(){
       if(document.getElementById('<%= ddlZfzr.ClientID %>').value.length>0){
           var sysDate=new Date(); 
           document.getElementById('<%= tbZfzrhqsj.ClientID %>').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate(); 
           document.getElementById('<%= ddlZFZRHQZT.ClientID %>').value="已会签";
           document.getElementById('<%= tbLchqzt.ClientID %>').value="已完成(未发样)"; 
       }
}

 //发样状态控制
function fhrqChange(){
       if(document.getElementById('<%= tbFhrq.ClientID %>').value.length>0){
          document.getElementById('<%= tbLchqzt.ClientID %>').value="已完成(待反馈)"; 
       }
}

 //客户使用情况反馈
function khsyqkChange(){
          document.getElementById('<%= tbLchqzt.ClientID %>').value="已完成"; 
}


//动态超级连接到 产品开发提案书
function getCpkfta(){
    var bh=document.getElementById('<%= tbCpkftaBh.ClientID %>').value;
    if(""==bh){
      alert('产品开发提案编号为空');
    } else {
      document.getElementById('HyperCpkfta').href="cpkftaEdit.aspx?xh=" + bh + "&lb=EDIT&editType=已会签";
    }
}





function lbtnOK_disbale(){
    //同步过来的单子发起人名字不为空但是发起时为空 手动触发一下fqrchange这个js函数
    if (document.getElementById('<%= ddlFqr.ClientID %>').value.length>0 && document.getElementById('<%= tbFqrhqsj.ClientID %>').value.length<=0 ){
          fqrChange();
          //初始化会签状态
          document.getElementById('<%= ddlSWBHQZT.ClientID %>').value="-";
          document.getElementById('<%= ddlZJLHQZT.ClientID %>').value="-";
          document.getElementById('<%= ddlSYSHQZT.ClientID %>').value="-";
          document.getElementById('<%= ddlXMFZRHQZT.ClientID %>').value="-";
          document.getElementById('<%= ddlZFZRHQZT.ClientID %>').value="-";
    }
    if (Page_ClientValidate()) {
       if(document.getElementById('<%= fulFj.ClientID %>').value.length>0){
         document.getElementById('<%= iBtnOK.ClientID %>').innerText="上传文件中...";
         document.getElementById('<%= iBtnOK.ClientID %>').style.color="#CCCCCC";
       }
    } 
    
    
    
}

//商务填写发样时激活必填项
function swfyCheck(){
    ValidatorEnable(document.getElementById('<%= RequiredFieldValidator5.ClientID %>'), true);
    ValidatorEnable(document.getElementById('<%= RequiredFieldValidator7.ClientID %>'), true);
    ValidatorEnable(document.getElementById('<%= RequiredFieldValidator6.ClientID %>'), true);
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
    ValidatorEnable(document.getElementById('<%= RequiredFieldValidator14.ClientID %>'), true);
  } else {
     ValidatorEnable(document.getElementById('<%= RequiredFieldValidator14.ClientID %>'), false);
  }
  
}


//选择测试不通过时激活必填项
function khfqCheck(){
    if(document.getElementById('<%= ddlKhcs.ClientID %>').value=="测试不通过"){
      ValidatorEnable(document.getElementById('<%= RequiredFieldValidator3.ClientID %>'), true);
      khsyqkChange();
    } else {
      ValidatorEnable(document.getElementById('<%= RequiredFieldValidator3.ClientID %>'), false);
    }
    if ((document.getElementById('<%= ddlDdqk.ClientID %>').value=="小批量")||(document.getElementById('<%= ddlDdqk.ClientID %>').value=="批量")){
       document.getElementById('tdDdqk').innerText ="首次订单编号";
       ValidatorEnable(document.getElementById('<%= RequiredFieldValidator13.ClientID %>'), true);
       khsyqkChange();
    } else if (document.getElementById('<%= ddlDdqk.ClientID %>').value=="无订单"){
       document.getElementById('tdDdqk').innerText ="无订单原因";
       ValidatorEnable(document.getElementById('<%= RequiredFieldValidator13.ClientID %>'), true);
       khsyqkChange();
    } 
    if (document.getElementById('<%= ddlKhcs.ClientID %>').value=="测试通过"){
      khsyqkChange();
    }
}

//分页
function changeTab(num){
	  for(var id=1;id<=3;id++){
	      var tabName="divTab"+id;
	      var aName="aTab"+id;
	      if(id==num){
		     document.getElementById(tabName).style.display="block";
		     //初始激活的标签页离导航栏要保持55像素
		     document.getElementById(tabName).style.marginTop="55px";
		     document.getElementById(aName).style.fontWeight="bold";
		     document.getElementById(aName).style.backgroundColor="#FFFFFF";
		  } else { 
		     document.getElementById(tabName).style.display="none";
		     document.getElementById(aName).style.fontWeight="normal";
		     document.getElementById(aName).style.backgroundColor="#F4F4F4";
		  }
	  }  
}





    </script>

    <form id="form1" runat="server">
        <div style="font-size: 12px;" runat="server" id="Div1">
            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tbYqjhjq"
                Format="yyyy-MM-dd">
            </ajaxToolkit:CalendarExtender>
            <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="true"
                EnableScriptLocalization="true">
                <Services>
                    <asp:ServiceReference Path="~/AutoCompleteService.svc" />
                </Services>
            </ajaxToolkit:ToolkitScriptManager>
            <div id="divAll">
                <div id="divNav">
                    <ul class="ulTab">
                        <li><a id="aTab1" href="javascript:void(0)" onclick="javascript:changeTab(1)">样品评审</a></li><li>
                            <a id="aTab2" href="javascript:void(0)" onclick="javascript:changeTab(2)">样品发货及反馈</a></li><li>
                                <a id="aTab3" href="javascript:void(0)" onclick="javascript:changeTab(3)">样品制作进度</a></li></ul>
                </div>
                <div align="center" id="divTab1">
                    <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                        id="border">
                        <tr>
                            <td colspan="12" style="height: 47px; font-size: 23px; font-weight: bold;">
                                <label runat="server" id="lblTitle">样品建议书</label> <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="请检查如下项目是否填写正确"
                                    DisplayMode="BulletList" EnableClientScript="true" ShowMessageBox="true" />
                                <a style="color: #000; padding: 6px 3px; display: inline-block; text-decoration: none;
                                    background-color: #529F1D; font-size: 12px" href="ypjysPrint.aspx?xh=<%=xh%>&lb=EDIT&editType=全部"
                                    target="_blank">打印</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px">
                                编号</td>
                            <td colspan="3" style="height: 47px">
                                <asp:TextBox ID="tbBh" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 79px; height: 47px">
                                日期</td>
                            <td colspan="3" style="height: 47px">
                                &nbsp;<asp:TextBox ID="tbJBRQ" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 60px; height: 47px">
                            </td>
                            <td style="height: 47px" colspan="3">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px">
                                流程会签状态</td>
                            <td colspan="3" style="height: 47px">
                                <asp:TextBox ID="tbLchqzt" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 79px; height: 47px">
                                对应产品开发提案</td>
                            <td colspan="4" style="height: 47px">
                                <asp:TextBox ID="tbCpkftaBh" runat="server" Width="55%"></asp:TextBox><span style="background-color: #529f1d">&nbsp;<a
                                    id="HyperCpkfta" onclick="getCpkfta()" href="#" target="_blank" style="color: #000;
                                    padding: 5 5; display: inline; background-color: #529f1d; text-decoration: none;">产品开发提案书查询</a></span>
                            </td>
                            <td colspan="3" style="height: 47px">
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="3" style="width: 79px">
                                客户信息</td>
                            <td style="width: 60px; height: 47px">
                                客户型号</td>
                            <td colspan="4" style="height: 47px">
                                <asp:TextBox ID="tbKhxh" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 63px; height: 47px" class="tdNeed">
                                客户代码(＊)</td>
                            <td colspan="5" style="height: 47px">
                                <asp:TextBox ID="tbKhdm" runat="server" Width="90%"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="请填写客户代码"
                                    Display="Dynamic" ControlToValidate="tbKhdm" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="tbKhdm"
                                    Display="Dynamic" ErrorMessage="客户代码需要为FXXXX的格式，其中F大写，XXXX为4位数字和字母组合" SetFocusOnError="true"
                                    ValidationExpression="^[F][A-Z0-9]{4}$"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px">
                                重要性</td>
                            <td colspan="4" style="height: 47px">
                                <asp:CheckBoxList ID="cblZyx" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem>A</asp:ListItem>
                                    <asp:ListItem>B</asp:ListItem>
                                    <asp:ListItem>C</asp:ListItem>
                                    <asp:ListItem>D</asp:ListItem>
                                    <asp:ListItem>E</asp:ListItem>
                                </asp:CheckBoxList></td>
                            <td style="width: 63px; height: 47px">
                                应用领域</td>
                            <td colspan="5" style="height: 47px">
                                <asp:TextBox ID="tbYyly" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px">
                                规格书编号</td>
                            <td colspan="4" style="height: 47px">
                                <asp:TextBox ID="tbGGSBH" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 63px; height: 47px">
                                规格书版本</td>
                            <td colspan="5" style="height: 47px">
                                <asp:TextBox ID="tbGGSBB" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr class="tdNeed">
                            <td style="width: 79px;">
                                UL信息</td>
                            <td style="height: 47px; width: 60px;">
                                是否需要UL认证(＊)</td>
                            <td style="height: 47px;" colspan="2">
                                <asp:DropDownList ID="ddlSfxyul" runat="server" onchange="sfxyulChange()">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>要</asp:ListItem>
                                    <asp:ListItem>不要</asp:ListItem>
                                </asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator7" runat="server" ControlToValidate="ddlSfxyul"
                                    Display="Dynamic" EnableTheming="true" ErrorMessage="请选择是否需要UL认证" Operator="NotEqual"
                                    SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                                </asp:CompareValidator></td>
                            <td style="height: 47px; width: 60px;">
                                是否有替代型号</td>
                            <td style="height: 47px;" colspan="2">
                                <asp:DropDownList ID="ddlSfytdxh" runat="server" onchange="sfytdxhChange()">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>有</asp:ListItem>
                                    <asp:ListItem>无</asp:ListItem>
                                </asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator8" runat="server" ControlToValidate="ddlSfytdxh"
                                    Display="Dynamic" Enabled="false" EnableTheming="true" ErrorMessage="请选择是否有替代型号"
                                    Operator="NotEqual" SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                                </asp:CompareValidator></td>
                            <td style="height: 47px; width: 79px;">
                                UL替代型号</td>
                            <td style="height: 47px;" colspan="4">
                                <asp:TextBox ID="tbUltdxh" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="tbUltdxh"
                                     Enabled="false" Display="Dynamic" ErrorMessage="请填写UL替代型号" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td rowspan="11" style="width: 79px">
                                客<br />
                                户<br />
                                需<br />
                                求</td>
                            <td colspan="2" style="height: 42px" class="tdNeed">
                                成品状态(＊)</td>
                            <td colspan="3" style="height: 42px">
                                <asp:DropDownList ID="ddlCpzt" runat="server" onchange="cpztChange()">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>电芯</asp:ListItem>
                                    <asp:ListItem>PACK</asp:ListItem>
                                </asp:DropDownList><asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlCpzt"
                                    Display="Dynamic" EnableTheming="true" ErrorMessage="请选择成品状态" Operator="NotEqual"
                                    SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                                </asp:CompareValidator></td>
                            <td colspan="6" style="height: 42px">
                                <div id="divDxchfs" style="display: block">
                                    <asp:DropDownList ID="ddlDxchfs" runat="server" Width="30%" onchange="dxchfsChange()">
                                        <asp:ListItem>请选择</asp:ListItem>
                                        <asp:ListItem>单体出货</asp:ListItem>
                                        <asp:ListItem>串联配组出货</asp:ListItem>
                                        <asp:ListItem>并联配组出货</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="tbDxchsl" runat="server" Width="25%"></asp:TextBox>
                                    <asp:TextBox ID="tbDw" runat="server" Width="25%"></asp:TextBox></div>
                                <div id="divPackchfs" style="display: none">
                                    <asp:DropDownList ID="ddlPackchfs" runat="server" Width="35%" onchange="packchfsChange()">
                                        <asp:ListItem>请选择</asp:ListItem>
                                        <asp:ListItem>单体PACK</asp:ListItem>
                                        <asp:ListItem>组合PACK</asp:ListItem>
                                    </asp:DropDownList><span id="spCBLQK">串并联情况
                                        <asp:TextBox ID="tbCblqk" runat="server" Width="30%"></asp:TextBox></span></div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 47px">
                                要求交货交期</td>
                            <td colspan="3" style="height: 47px">
                                <asp:TextBox ID="tbYqjhjq" runat="server" Width="90%"></asp:TextBox></td>
                            <td colspan="6" style="height: 47px">
                                产品尺寸</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 47px">
                                内部型号&nbsp;</td>
                            <td colspan="3" style="height: 47px">
                                <asp:TextBox ID="tbNbxh" runat="server" Width="90%"></asp:TextBox><br />
                            </td>
                            <td colspan="2" style="height: 47px">
                                厚(mm)≤</td>
                            <td colspan="4" style="height: 47px">
                                <asp:TextBox ID="tbCCH" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 53px" class="tdNeed">
                                成品数量(＊)</td>
                            <td colspan="1" style="height: 53px">
                                <asp:TextBox ID="tbCpsl" runat="server" Width="90%"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="请填写成品数量"
                                    SetFocusOnError="true" Display="Dynamic" ControlToValidate="tbCpsl"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator3" ControlToValidate="tbCpsl" ValidationExpression="^\d+(\.\d+)?$"
                                        ErrorMessage="数量只能为数字" runat="server" Display="Dynamic" SetFocusOnError="true" />
                            </td>
                            <td style="height: 53px; width: 79px;" class="tdNeed">
                                单位(＊)</td>
                            <td style="height: 53px">
                                <asp:DropDownList ID="ddlSydw" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>PCS</asp:ListItem>
                                    <asp:ListItem>组</asp:ListItem>
                                </asp:DropDownList><asp:CompareValidator ID="CompareValidator2" runat="server" SetFocusOnError="true"
                                    EnableTheming="true" ErrorMessage="请选择单位" Operator="NotEqual" ValueToCompare="请选择"
                                    Type="string" ControlToValidate="ddlSydw" Display="Dynamic">
                                </asp:CompareValidator></td>
                            <td colspan="2" style="height: 53px">
                                宽(mm)≤</td>
                            <td colspan="4" style="height: 53px">
                                <asp:TextBox ID="tbCCK" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 47px" class="tdNeed">
                                总电芯数量(＊)</td>
                            <td colspan="3" style="height: 47px">
                                <asp:TextBox ID="tbSl" runat="server" Width="90%"></asp:TextBox>&nbsp;
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="请填写总电芯数量"
                                    SetFocusOnError="true" Display="Dynamic" ControlToValidate="tbSl">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="tbSl"
                                    ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="数量只能为数字" runat="server" Display="Dynamic"
                                    SetFocusOnError="true" />
                            </td>
                            <td colspan="2" style="height: 47px">
                                高(mm)≤</td>
                            <td colspan="4" style="height: 47px">
                                <asp:TextBox ID="tbCCC" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px" class="tdNeed">
                                标称容量(＊)<br />
                                &nbsp; (mAh)</td>
                            <td style="height: 47px" colspan="2">
                                <asp:TextBox ID="tbBcrl" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="请填写容量"
                                    SetFocusOnError="true" Display="Dynamic" ControlToValidate="tbBcrl">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ControlToValidate="tbBcrl"
                                    ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="容量只能为数字" runat="server" Display="Dynamic"
                                    SetFocusOnError="true" />
                            </td>
                            <td style="width: 79px; height: 47px">
                                最小容量<br />
                                &nbsp; (mAh)</td>
                            <td style="height: 47px" colspan="2">
                                <asp:TextBox ID="tbZxrl" runat="server" Width="90%"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" SetFocusOnError="true"
                                    ControlToValidate="tbZxrl" Display="Dynamic" ErrorMessage="最小容量只能为数字" ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator>
                            </td>
                            <td style="width: 60px; height: 47px">
                                &nbsp; 内阻<br />
                                &nbsp; (mΩ)</td>
                            <td style="height: 47px" colspan="4">
                                <asp:TextBox ID="tbNz" runat="server" Width="90%"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" SetFocusOnError="true"
                                    ControlToValidate="tbNz" Display="Dynamic" ErrorMessage="内阻只能为数字" ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px" class="tdNeed">
                                出货电压<br />
                                (＊)<br />
                                (V)</td>
                            <td colspan="5" style="height: 47px">
                                <asp:TextBox ID="tbChdy" runat="server" Width="40%"></asp:TextBox>
                                ～<asp:TextBox ID="tbChdyMax" runat="server" Width="40%"></asp:TextBox><asp:RegularExpressionValidator
                                    ID="RegularExpressionValidator9" runat="server" SetFocusOnError="true" ControlToValidate="tbChdy"
                                    Display="Dynamic" ErrorMessage="出货电压只能为数字" ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator16"
                                    runat="server" ControlToValidate="tbChdyMax" Display="Dynamic" ErrorMessage="出货电压只能为数字"
                                    SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                    runat="server" ControlToValidate="tbChdy" Display="Dynamic" ErrorMessage="请填写出货电压"
                                    SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                                &nbsp;
                            </td>
                            <td style="width: 60px; height: 47px">
                                标称电压(V)</td>
                            <td style="height: 47px" colspan="4">
                                <asp:TextBox ID="tbBcdy" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator
                                    ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbBcdy" Display="Dynamic"
                                    ErrorMessage="标称电压只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px">
                                极耳长度<br />
                                &nbsp;&nbsp; (mm)</td>
                            <td colspan="2" style="height: 47px">
                                <asp:TextBox ID="tbJecd" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator
                                    ID="RegularExpressionValidator10" runat="server" SetFocusOnError="true" ControlToValidate="tbJecd"
                                    Display="Dynamic" ErrorMessage="极耳长度只能为数字" ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator></td>
                            <td style="width: 79px; height: 47px">
                                极耳宽度<br />
                                &nbsp; (mm)</td>
                            <td colspan="7" style="height: 47px">
                                <asp:TextBox ID="tbJekd" runat="server" Width="90%"></asp:TextBox><asp:RegularExpressionValidator
                                    ID="RegularExpressionValidator11" runat="server" SetFocusOnError="true" ControlToValidate="tbJekd"
                                    Display="Dynamic" ErrorMessage="极耳宽度只能为数字" ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px">
                                极耳中心距(mm)</td>
                            <td style="height: 47px" colspan="2">
                                <asp:TextBox ID="tbJezxj" runat="server" Width="90%"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server"
                                    SetFocusOnError="true" ControlToValidate="tbJezxj" Display="Dynamic" ErrorMessage="极耳中心距只能为数字"
                                    ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator>
                            </td>
                            <td style="width: 79px; height: 47px">
                                焊盘中心距<br />
                                &nbsp; (mm)</td>
                            <td style="height: 47px" colspan="2">
                                <asp:TextBox ID="tbHpzxj" runat="server" Width="90%"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server"
                                    SetFocusOnError="true" ControlToValidate="tbHpzxj" Display="Dynamic" ErrorMessage="焊盘中心距只能为数字"
                                    ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator>
                            </td>
                            <td style="width: 60px; height: 47px">
                                焊盘宽度<br />
                                &nbsp; (mm)</td>
                            <td style="height: 47px" colspan="4">
                                <asp:TextBox ID="tbHpkd" runat="server" Width="90%"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server"
                                    SetFocusOnError="true" ControlToValidate="tbHpkd" Display="Dynamic" ErrorMessage="焊盘宽度只能为数字"
                                    ValidationExpression="^\d+(\.\d+)?$">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 47px">
                                产品销往地</td>
                            <td colspan="4" style="height: 47px">
                                <asp:TextBox ID="tbCpxwd" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 60px; height: 47px">
                                运输方式</td>
                            <td style="height: 47px" colspan="4">
                                <asp:TextBox ID="tbYsfs" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px">
                                环保要求</td>
                            <td style="height: 47px" colspan="2">
                                <asp:TextBox ID="tbHbyq" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 79px; height: 47px">
                                认证要求</td>
                            <td style="height: 47px" colspan="7">
                                <asp:TextBox ID="tbRzyq" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="height: 47px;" colspan="12">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 79px;" rowspan="3">
                                工作状态</td>
                            <td style="height: 47px; width: 60px;">
                                充电电流<br />
                                &nbsp; (mA)</td>
                            <td style="height: 47px;" colspan="2">
                                <asp:TextBox ID="tbCddl" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="height: 47px; width: 79px;">
                                放电电流<br />
                                &nbsp; (mA)</td>
                            <td style="height: 47px;" colspan="2">
                                <asp:TextBox ID="tbFddl" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="height: 47px; width: 60px;">
                                最大使用电流(mA)</td>
                            <td style="height: 47px;" colspan="4">
                                <asp:TextBox ID="tbZdsydl" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px">
                                持续时间</td>
                            <td style="height: 47px" colspan="2">
                                <asp:TextBox ID="tbCxsj" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 79px; height: 47px">
                                充电温度<br />
                                &nbsp; (℃)</td>
                            <td style="height: 47px" colspan="2">
                                <asp:TextBox ID="tbCdwd" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 60px; height: 47px">
                                放电温度</td>
                            <td style="height: 47px" colspan="4">
                                <asp:TextBox ID="tbFdwd" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 60px; height: 47px">
                                截至电压<br />
                                &nbsp;&nbsp; (V)</td>
                            <td style="height: 47px" colspan="2">
                                <asp:TextBox ID="tbJzdy" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="height: 47px" colspan="8">
                            </td>
                        </tr>
                        <tr id="trPack" style="display: none" bgcolor="#FFCCCC">
                            <td style="height: 51px; width: 79px;">
                                P<br />
                                A<br />
                                C<br />
                                K<br />
                                要<br />
                                求</td>
                            <td colspan="11" style="height: 51px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="10%" style="height: 53px">
                                            &nbsp;PACK方式</td>
                                        <td style="height: 53px" colspan="9">
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
                                        <td style="height: 56px; width: 10%;">
                                            品牌</td>
                                        <td style="height: 56px" colspan="5">
                                            <asp:CheckBoxList ID="cblPP" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                <asp:ListItem>精工</asp:ListItem>
                                                <asp:ListItem>理光</asp:ListItem>
                                                <asp:ListItem>光之美</asp:ListItem>
                                                <asp:ListItem>宏康</asp:ListItem>
                                                <asp:ListItem>富晶</asp:ListItem>
                                            </asp:CheckBoxList></td>
                                        <td style="height: 49px" width="10%">
                                            <asp:CheckBox ID="cbICPPNK" runat="server" Text="内控" /></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 49px; width: 10%;">
                                            规格</td>
                                        <td colspan="5" style="height: 49px">
                                            <asp:TextBox ID="tbGG" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 49px" width="10%">
                                            <asp:CheckBox ID="cbGgnk" runat="server" Text="内控" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 42px">
                                            电量管理IC规格：<asp:TextBox ID="tbDlglicgg" runat="server" Width="75%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            <asp:CheckBox ID="cbDlglicggnk" runat="server" Text="内控" /></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            MOS管要求</td>
                                        <td colspan="7" style="height: 42px">
                                            <asp:TextBox ID="tbMosgyq" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            <asp:CheckBox ID="cbMOSGNK" runat="server" Text="内控" /></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            NTC阻值(K)</td>
                                        <td style="height: 42px" colspan="2">
                                            <asp:TextBox ID="tbNTCZZ" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            B值(K)</td>
                                        <td style="height: 42px" colspan="2">
                                            <asp:TextBox ID="tbBz" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            精度</td>
                                        <td style="height: 42px" colspan="2">
                                            <asp:DropDownList ID="ddlJD" runat="server">
                                                <asp:ListItem>请选择</asp:ListItem>
                                                <asp:ListItem>&#177;1%</asp:ListItem>
                                                <asp:ListItem>&#177;5%</asp:ListItem>
                                                <asp:ListItem>&#177;10%</asp:ListItem>
                                                <asp:ListItem>&#177;3%</asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            PPTC</td>
                                        <td style="height: 42px" width="10%">
                                            Hold电流</td>
                                        <td style="height: 42px; width: 10%;">
                                            <asp:TextBox ID="tbHolddl" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            Trip电流</td>
                                        <td style="height: 42px" colspan="2">
                                            <asp:TextBox ID="tbTripdl" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            其他要求</td>
                                        <td style="height: 42px" colspan="2">
                                            <asp:TextBox ID="tbBhbQtyq" runat="server" Width="90%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            Breaker温度开关</td>
                                        <td style="height: 42px" colspan="5">
                                            <asp:CheckBoxList ID="cblBreakerwdkg" runat="server" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow">
                                                <asp:ListItem>LC72AY</asp:ListItem>
                                                <asp:ListItem>LC77AY</asp:ListItem>
                                                <asp:ListItem>LC82AY</asp:ListItem>
                                                <asp:ListItem>LC85AY</asp:ListItem>
                                            </asp:CheckBoxList></td>
                                        <td style="height: 42px" width="10%">
                                            其他规格</td>
                                        <td style="height: 42px" colspan="3">
                                            <asp:TextBox ID="tbQTGG" runat="server" Width="90%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            Fuse保险丝</td>
                                        <td style="height: 42px" colspan="9">
                                            <asp:TextBox ID="tbFusebxs" runat="server" Width="90%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td width="10%" rowspan="3">
                                            电子线</td>
                                        <td style="height: 42px" width="10%">
                                            出线位置</td>
                                        <td colspan="8" style="height: 42px">
                                            <asp:TextBox ID="tbCxwz" runat="server" Width="90%"></asp:TextBox>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            线规</td>
                                        <td style="height: 42px" width="10%">
                                            <asp:CheckBox ID="cbXgnk" runat="server" Text="内控" /></td>
                                        <td colspan="7" style="height: 42px">
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
                                        <td colspan="3" style="height: 42px">
                                            外线露长±3mm：<asp:TextBox ID="tbWxlc" runat="server" Width="40%"></asp:TextBox></td>
                                        <td style="height: 42px" colspan="3">
                                            线头挂锡长度±0.5mm：<asp:TextBox ID="tbXtgxcd" runat="server" Width="30%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            其他</td>
                                        <td style="height: 42px" colspan="2">
                                            <asp:TextBox ID="tbDzxqt" runat="server" Width="90%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td width="10%" rowspan="2">
                                            插头线</td>
                                        <td style="height: 42px" colspan="2">
                                            连接器品牌</td>
                                        <td style="height: 42px;" colspan="2">
                                            <asp:TextBox ID="tbLjqpp" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" colspan="2">
                                            连接器规格：</td>
                                        <td colspan="2" style="height: 42px">
                                            <asp:TextBox ID="tbLjqgg" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            <asp:CheckBox ID="cbLjqnk" runat="server" Text="内控" /></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            排列线序</td>
                                        <td colspan="4" style="height: 42px">
                                            <asp:CheckBox ID="cbDzmxs" runat="server" Text="端子面向上" />
                                            <asp:TextBox ID="tbDzmxsnr" runat="server" Width="50%"></asp:TextBox></td>
                                        <td colspan="4" style="height: 42px">
                                            <asp:CheckBox ID="cbDzmxx" runat="server" Text="端子面向下" />
                                            <asp:TextBox ID="tbDzmxxnr" runat="server" Width="50%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            PVC热缩膜</td>
                                        <td style="height: 42px" width="10%">
                                            颜色</td>
                                        <td style="height: 42px" colspan="4">
                                            <asp:CheckBoxList ID="cblPVCRsmys" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                <asp:ListItem>内控</asp:ListItem>
                                                <asp:ListItem>蓝色</asp:ListItem>
                                                <asp:ListItem>透明</asp:ListItem>
                                                <asp:ListItem>白色</asp:ListItem>
                                            </asp:CheckBoxList></td>
                                        <td style="height: 42px" width="10%">
                                            其他颜色</td>
                                        <td style="height: 42px" colspan="3">
                                            <asp:TextBox ID="tbQtys" runat="server" Width="50%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2" width="10%">
                                            塑胶壳</td>
                                        <td style="height: 42px" width="10%">
                                            颜色</td>
                                        <td colspan="2" style="height: 42px">
                                            <asp:TextBox ID="tbSjkys" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            材质</td>
                                        <td colspan="2" style="height: 42px">
                                            <asp:TextBox ID="tbSjkcz" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            防火等级</td>
                                        <td colspan="2" style="height: 42px">
                                            <asp:TextBox ID="tbFhdj" runat="server" Width="90%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            供应方式</td>
                                        <td colspan="3" style="height: 42px">
                                            <asp:CheckBoxList ID="cblGyfs" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                <asp:ListItem>客供</asp:ListItem>
                                                <asp:ListItem>手板</asp:ListItem>
                                                <asp:ListItem>自行开模</asp:ListItem>
                                            </asp:CheckBoxList></td>
                                        <td style="width: 10%; height: 42px">
                                            其他要求</td>
                                        <td colspan="4" style="height: 42px">
                                            <asp:TextBox ID="tbSjkqtyq" runat="server" Width="90%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 42px" width="10%">
                                            双面胶</td>
                                        <td style="height: 42px" width="10%">
                                            品牌</td>
                                        <td colspan="2" style="height: 42px">
                                            <asp:CheckBoxList ID="cblSmjpp" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                <asp:ListItem>3M</asp:ListItem>
                                                <asp:ListItem>普通</asp:ListItem>
                                            </asp:CheckBoxList></td>
                                        <td style="height: 42px" width="10%">
                                            规格型号</td>
                                        <td colspan="2" style="height: 42px">
                                            <asp:TextBox ID="tbGGXH" runat="server" Width="90%"></asp:TextBox></td>
                                        <td style="height: 42px" width="10%">
                                            粘帖位置</td>
                                        <td colspan="2" style="height: 42px">
                                            <asp:TextBox ID="tbNTWZ" runat="server" Width="90%"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 72px">
                                            其他PACK器件</td>
                                        <td colspan="8" style="height: 72px">
                                            <asp:TextBox ID="tbQtPACKqj" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px">
                                喷码要求</td>
                            <td style="height: 47px" colspan="11">
                                <asp:TextBox ID="tbPmyq" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px">
                                侧边保护方式
                            </td>
                            <td style="height: 47px" colspan="11">
                                <asp:TextBox ID="tbCbbhfs" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px">
                                成品包装方式</td>
                            <td style="height: 47px" colspan="11">
                                <asp:TextBox ID="tbCpbzfs" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px">
                                其他要求</td>
                            <td colspan="11" style="height: 47px">
                                <asp:TextBox ID="tbQtyq" runat="server" Rows="5" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px" class="tdNeed">
                                收费情况(＊)</td>
                            <td style="height: 47px" colspan="2">
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
                            <td style="width: 60px; height: 47px" class="tdNeed">
                                制作情况(＊)</td>
                            <td style="height: 47px" colspan="2">
                                <asp:DropDownList ID="ddlZzqk" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>库存出货</asp:ListItem>
                                    <asp:ListItem>样品新做</asp:ListItem>
                                    <asp:ListItem>无库存需制样</asp:ListItem>
                                </asp:DropDownList><br />
                                <asp:CompareValidator ID="CompareValidator4" runat="server" SetFocusOnError="true"
                                    EnableTheming="true" ErrorMessage="请选择制作情况" Operator="NotEqual" ValueToCompare="请选择"
                                    Type="string" ControlToValidate="ddlZzqk" Display="Dynamic">
                                </asp:CompareValidator>
                            </td>
                            <td style="width: 63px; height: 47px">
                                是否开模(＊)</td>
                            <td style="height: 47px" colspan="5">
                                &nbsp;<asp:DropDownList ID="ddlSfkm" runat="server">
                                    <asp:ListItem>-</asp:ListItem>
                                    <asp:ListItem>是</asp:ListItem>
                                    <asp:ListItem>否</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px">
                                预计价格(＊)</td>
                            <td colspan="5" style="height: 47px">
                                <asp:DropDownList ID="ddlYjjgdw" runat="server" Width="37%">
                                    <asp:ListItem Selected="True">￥</asp:ListItem>
                                    <asp:ListItem>$</asp:ListItem>
                                    <asp:ListItem>HK＄</asp:ListItem>
                                    <asp:ListItem>NT＄</asp:ListItem>
                                    <asp:ListItem>€</asp:ListItem>
                                    <asp:ListItem>￡</asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="tbYjjg" runat="server" Width="50%"></asp:TextBox>
                                <span style="color: #ff0000"></span>
                            </td>
                            <td class="tdNeed" colspan="6" style="height: 47px">
                                &nbsp;第<asp:TextBox ID="tbDjcsy" runat="server" onchange="scsyCheck()" Width="41px"></asp:TextBox>次送样<br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="tbDjcsy"
                                    Display="Dynamic" ErrorMessage="请填写送样次数" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 79px; height: 47px">
                                上次送样未通过原因</td>
                            <td colspan="2" style="height: 47px">
                                <asp:TextBox ID="tbScsywtgyy" runat="server" Width="90%"></asp:TextBox></td>
                            <td colspan="3" style="height: 47px">
                                模具付费情况<asp:DropDownList ID="ddlMjffqk" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>已付费</asp:ListItem>
                                    <asp:ListItem>未付费</asp:ListItem>
                                </asp:DropDownList></td>
                            <td colspan="2" style="height: 47px">
                                上次送样日期</td>
                            <td colspan="4" style="height: 47px">
                                <asp:TextBox ID="tbScsyrq" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 47px">
                                后续单量描述</td>
                            <td class="tdNeed" colspan="3" style="height: 47px">
                                <asp:TextBox ID="tbHxddl" runat="server" Width="35%"></asp:TextBox>
                                <asp:DropDownList ID="ddlHxddldw" runat="server" Width="23%">
                                    <asp:ListItem>PCS</asp:ListItem>
                                    <asp:ListItem>组</asp:ListItem>
                                </asp:DropDownList>
                                /&nbsp;<asp:DropDownList ID="ddlDdljg" runat="server" Width="18%">
                                    <asp:ListItem Selected="True">月</asp:ListItem>
                                    <asp:ListItem>周</asp:ListItem>
                                    <asp:ListItem>年</asp:ListItem>
                                    <asp:ListItem>天</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="height: 47px" colspan="2">
                                预计下单日期</td>
                            <td class="tdNeed" style="height: 47px" colspan="4">
                                <asp:TextBox ID="tbYjxdrq" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 47px">
                                技术说明&nbsp;<asp:CheckBoxList ID="cblYpcsbg" runat="server" RepeatDirection="Horizontal"
                                    RepeatLayout="Flow">
                                    <asp:ListItem>样品测试报告</asp:ListItem>
                                    <asp:ListItem>规格书</asp:ListItem>
                                </asp:CheckBoxList></td>
                            <td style="height: 47px" colspan="2">
                                送样方式</td>
                            <td class="tdNeed" style="height: 47px" colspan="4">
                                <asp:DropDownList ID="ddlSyfs" runat="server" Width="90%">
                                    <asp:ListItem>交业务员</asp:ListItem>
                                    <asp:ListItem>送PACK</asp:ListItem>
                                    <asp:ListItem>指定地址送样(附地址)</asp:ListItem>
                                    <asp:ListItem>其他方式</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr style="display: none">
                            <td style="width: 79px; height: 47px">
                                详细地址</td>
                            <td colspan="11" style="height: 47px">
                                <asp:TextBox ID="tbXxdz" runat="server" Rows="5" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="height: 47px; width: 79px;">
                                附件</td>
                            <td style="height: 47px;" colspan="11">
                                &nbsp;可添加附件（客户详细要求）<asp:FileUpload ID="fulFj" runat="server" />
                                <asp:TextBox ID="tbURL" runat="server" Style="border-right: 0px; border-top: 0px;
                                    border-left: 0px; border-bottom: 1px" Width="247px"></asp:TextBox><br />
                                &nbsp;<asp:ImageButton ID="iBtnDownLoad" runat="server" ImageUrl="~/images/btnDownload.jpg"
                                    OnClick="btnDownLoad_Click" /></td>
                        </tr>
                        <tr bgcolor="#CCFFFF">
                            <td height="37" class="STYLE_RESULT" style="width: 86px">
                                业务员</td>
                            <td colspan="2">
                                <asp:DropDownList ID="ddlFqr" runat="server" Width="90%" onblur="fqrChange()">
                                </asp:DropDownList></td>
                            <td colspan="2">
                                日期<asp:TextBox ID="tbFqrhqsj" runat="server" Width="60%"></asp:TextBox></td>
                            <td style="width: 70px" class="STYLE_RESULT">
                                业务领导审核</td>
                            <td colspan="2">
                                <asp:DropDownList ID="ddlFQSHR" runat="server" Width="90%" onblur="fqshrChange()">
                                    <asp:ListItem> </asp:ListItem>
                                </asp:DropDownList></td>
                            <td colspan="4">
                                日期<asp:TextBox ID="tbFqshrhqsj" runat="server" Width="75%"></asp:TextBox></td>
                        </tr>
                        <tr bgcolor="#CCFFFF">
                            <td style="width: 86px; height: 37px;" class="STYLE_RESULT">
                                商务部</td>
                            <td colspan="2" style="height: 37px">
                                <asp:DropDownList ID="ddlSwb" runat="server" Width="90%" onblur="swbChange()">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="height: 37px;" colspan="2">
                                日期<asp:TextBox ID="tbSwbhqsj" runat="server" Width="60%"></asp:TextBox></td>
                            <td style="width: 70px; height: 37px;" class="STYLE_RESULT">
                                总经理助理</td>
                            <td colspan="2" style="height: 37px">
                                <asp:DropDownList ID="ddlZjl" runat="server" Width="90%" onblur="zjlChange()">
                                    <asp:ListItem> </asp:ListItem>
                                </asp:DropDownList></td>
                            <td colspan="4" style="height: 37px">
                                日期<asp:TextBox ID="tbZjlhqsj" runat="server" Width="75%"></asp:TextBox></td>
                        </tr>
                        <tr bgcolor="#ccffff">
                            <td class="STYLE_RESULT" style="width: 86px; height: 74px">
                                评审备注</td>
                            <td colspan="11">
                                <asp:TextBox ID="tbPsbz" runat="server" Height="53px" TextMode="MultiLine" Width="95%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="tbPsbz"
                                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="<1000mah(数量>20)或>1000mah(数量>10)的免费样品请在此填写原因说明"
                                    Enabled="false"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td height="33" colspan="12" align="center" class="STYLE_ChildTitle">
                                技术部门评审</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 28px">
                                1. 电池型号/规格</td>
                            <td colspan="2" style="height: 28px">
                                <asp:DropDownList ID="ddlDcxhgg" runat="server">
                                    <asp:ListItem>新品</asp:ListItem>
                                    <asp:ListItem>老产品</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 79px; height: 28px;">
                                简述</td>
                            <td colspan="7">
                                <asp:TextBox ID="tbDcxhggjs" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td height="27" colspan="2">
                                2．性能要求/质量要求</td>
                            <td colspan="2">
                                <asp:DropDownList ID="ddlXnzlyq" runat="server">
                                    <asp:ListItem>符合</asp:ListItem>
                                    <asp:ListItem>不符合</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 79px">
                                简述</td>
                            <td colspan="7">
                                <asp:TextBox ID="tbXnzlyqjs" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 28px">
                                3．设备/工装模具需求</td>
                            <td colspan="2" style="height: 28px">
                                <asp:DropDownList ID="ddlSbgzmjxq" runat="server">
                                    <asp:ListItem>符合</asp:ListItem>
                                    <asp:ListItem>不符合</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 79px; height: 28px;">
                                简述</td>
                            <td colspan="7">
                                <asp:TextBox ID="tbSbgzmjxqjs" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 29px">
                                4．物料/交期</td>
                            <td colspan="2" style="height: 29px">
                                <asp:DropDownList ID="ddlWljq" runat="server">
                                    <asp:ListItem>符合</asp:ListItem>
                                    <asp:ListItem>不符合</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 79px; height: 29px;">
                                简述</td>
                            <td colspan="7">
                                <asp:TextBox ID="tbWljqjs" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 28px">
                                5. 其他要求</td>
                            <td colspan="4" style="height: 28px">
                                <asp:TextBox ID="tbJsqtyq" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 75px; height: 28px;">
                                结论</td>
                            <td colspan="5">
                                <asp:DropDownList ID="ddlJl" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>符合</asp:ListItem>
                                    <asp:ListItem>不符合</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr bgcolor="#ccffff">
                            <td colspan="3" style="height: 34px; color: #FF0000;">
                                样品规格书中型号名称(＊)</td>
                            <td style="height: 34px" colspan="2">
                                <asp:TextBox ID="tbGgszxhmc" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="tbGgszxhmc"
                                    Display="Dynamic" Enabled="false" ErrorMessage="请填写规格书中型号名称" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator15" runat="server"
                                    SetFocusOnError="true" ControlToValidate="tbGgszxhmc" Display="Dynamic" ErrorMessage="型号请不要填写(/)和容量"
                                    ValidationExpression="^[A-Z0-9]+$"></asp:RegularExpressionValidator>
                            </td>
                            <td class="STYLE_RESULT" style="width: 70px; height: 34px">
                                实验室</td>
                            <td colspan="2" style="height: 34px">
                                <asp:DropDownList ID="ddlSys" runat="server" Width="90%" onblur="sysChange()">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList></td>
                            <td colspan="4">
                                日期<asp:TextBox ID="tbSyshqsj" runat="server" Width="75%"></asp:TextBox></td>
                        </tr>
                        <tr bgcolor="#ccffff">
                            <td class="STYLE_RESULT" colspan="3" style="height: 34px">
                                技术负责人<asp:DropDownList ID="ddlJsfzr" runat="server" Width="50%" onblur="xmfzrChange()">
                                    <asp:ListItem> </asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 79px; height: 34px">
                                日期</td>
                            <td style="width: 79px; height: 34px">
                                <asp:TextBox ID="tbJsfzrhqsj" runat="server" Width="90%"></asp:TextBox></td>
                            <td class="STYLE_RESULT" style="width: 70px; height: 34px">
                                总负责人</td>
                            <td colspan="2" style="height: 34px">
                                <asp:DropDownList ID="ddlZfzr" runat="server" Width="90%" onblur="zfzrChange()">
                                    <asp:ListItem> </asp:ListItem>
                                </asp:DropDownList></td>
                            <td colspan="4">
                                日期<asp:TextBox ID="tbZfzrhqsj" runat="server" Width="75%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="border: 0px;">
                            </td>
                            <td style="height: 43px; border: 0px" colspan="11">
                                <asp:ImageButton ID="iBtnOK" runat="Server" ImageUrl="~/images/btnSubmit.jpg" OnClick="btnTj_Click"
                                    OnClientClick="return lbtnOK_disbale();" />
                            </td>
                        </tr>
                    </table>
                    <div id="divTableLc">
                        <table height="45" border="0" cellpadding="0" cellspacing="0" background="../images/ypjys_lc.jpg"
                            style="width: 654px;">
                            <tr align="left" valign="bottom">
                                <td style="height: 35px; width: 103px;">
                                    <asp:DropDownList ID="ddlFQRHQZT" runat="server" Width="64px">
                                        <asp:ListItem>已会签</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="height: 35px; width: 104px;">
                                    <asp:DropDownList ID="ddlFQBMHQZT" runat="server" Width="66px">
                                        <asp:ListItem>会签中</asp:ListItem>
                                        <asp:ListItem>已会签</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="height: 35px; width: 103px;">
                                    <asp:DropDownList ID="ddlSWBHQZT" runat="server" Width="66px">
                                        <asp:ListItem>-</asp:ListItem>
                                        <asp:ListItem>会签中</asp:ListItem>
                                        <asp:ListItem>已会签</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="height: 35px; width: 103px;">
                                    <asp:DropDownList ID="ddlZJLHQZT" runat="server" Width="66px">
                                        <asp:ListItem>-</asp:ListItem>
                                        <asp:ListItem>会签中</asp:ListItem>
                                        <asp:ListItem>已会签</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="height: 35px; width: 100px;">
                                    <asp:DropDownList ID="ddlSYSHQZT" runat="server" Width="66px">
                                        <asp:ListItem>-</asp:ListItem>
                                        <asp:ListItem>会签中</asp:ListItem>
                                        <asp:ListItem>已会签</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="height: 35px; width: 102px;">
                                    <asp:DropDownList ID="ddlXMFZRHQZT" runat="server" Width="66px">
                                        <asp:ListItem>-</asp:ListItem>
                                        <asp:ListItem>会签中</asp:ListItem>
                                        <asp:ListItem>已会签</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="height: 35px; width: 60px;">
                                    <asp:DropDownList ID="ddlZFZRHQZT" runat="server" Width="66px">
                                        <asp:ListItem>-</asp:ListItem>
                                        <asp:ListItem>会签中</asp:ListItem>
                                        <asp:ListItem>已会签</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                        </table>
                    </div>
                    <div style="display: none">
                        <asp:TextBox ID="fileName" runat="server"></asp:TextBox></div>
                    <!--第一页结束-->
                </div>
                <!--第二页开始-->
                <div style="text-align: center; width: 710px; margin: auto;" id="divTab2">
                    <table width="710" border="0" cellspacing="0" cellpadding="0" bgcolor="#F1FEDD">
                        <tr>
                            <td width="72" rowspan="5">
                                <p>
                                    商<br />
                                    务<br />
                                    发<br />
                                    货<br />
                                    情<br />
                                    况</p>
                                <p>
                                </p>
                            </td>
                            <td width="71" style="height: 41px">
                                发货日期</td>
                            <td colspan="3" style="height: 41px">
                                <asp:TextBox ID="tbFhrq" runat="server" Width="90%" onchange="swfyCheck()" onblur="fhrqChange()"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbFhrq"
                                    Display="Dynamic" Enabled="false" ErrorMessage="请选择发货日期" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td width="70" style="height: 41px">
                                快递公司</td>
                            <td colspan="5" style="height: 41px">
                                <asp:TextBox ID="tbKdgs" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="height: 39px">
                                发货数量</td>
                            <td width="71" style="height: 39px">
                                <asp:TextBox ID="tbFhsl" runat="server" Width="90%" onchange="swfyCheck()"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbFhsl"
                                    Display="Dynamic" Enabled="false" ErrorMessage="请填写发货数量" SetFocusOnError="true" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="tbFhsl"
                                    ValidationExpression="^\d+(\.\d+)?$" ErrorMessage="发货数量只能为数字" runat="server"
                                    Display="Dynamic" SetFocusOnError="true" />
                            </td>
                            <td width="71" style="height: 39px">
                                单位</td>
                            <td width="70" style="height: 39px">
                                <asp:DropDownList ID="ddlFhdw" runat="server" Width="90%" onchange="swfyCheck()">
                                    <asp:ListItem>PCS</asp:ListItem>
                                    <asp:ListItem>组</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlFhdw"
                                    Display="Dynamic" Enabled="false" ErrorMessage="请选择发货数量单位" SetFocusOnError="true" />
                            </td>
                            <td style="height: 39px">
                                快递单号</td>
                            <td colspan="4" style="height: 39px; width: 183px;">
                                &nbsp;<asp:TextBox ID="tbKddh" runat="server" Width="90%"></asp:TextBox>
                            </td>
                            <td colspan="1" style="height: 39px">
                                <asp:LinkButton ID="lbKdcx" OnClick="btnKdcx_Click" runat="server" Style="color: #000;
                                    padding: 6px 3px; display: block; text-decoration: none; background-color: #529F1D;">快递查询</asp:LinkButton></td>
                        </tr>
                        <tr>
                            <td style="height: 43px">
                                收件人</td>
                            <td colspan="3" style="height: 43px">
                                <asp:TextBox ID="tbSjr" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="height: 43px">
                                回单号</td>
                            <td colspan="5" style="height: 43px">
                                <asp:TextBox ID="tbHdh" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="height: 42px">
                                收件地址</td>
                            <td colspan="9" style="height: 42px">
                                <asp:TextBox ID="tbSjdz" runat="server" Width="95%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="height: 54px">
                                备注</td>
                            <td colspan="9" style="height: 54px">
                                <asp:TextBox ID="tbFhbz" runat="server" Height="37px" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="11" style="height: 16px">
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 63px">
                                客户测试<br />
                                (业务员填写)</td>
                            <td colspan="2" style="height: 63px">
                                <asp:DropDownList ID="ddlKhcs" runat="server" onchange="khfqCheck()">
                                    <asp:ListItem>测试中</asp:ListItem>
                                    <asp:ListItem>测试不通过</asp:ListItem>
                                    <asp:ListItem>测试通过</asp:ListItem>
                                </asp:DropDownList></td>
                            <td colspan="1" style="height: 63px">
                                测试<br />
                                不通过原因</td>
                            <td colspan="7" style="height: 63px">
                                <asp:TextBox ID="tbKhcsqk" runat="server" Height="47px" TextMode="MultiLine" Width="95%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbKhcsqk"
                                    Display="Dynamic" Enabled="false" ErrorMessage="请填写测试不通过原因" SetFocusOnError="true" /></td>
                        </tr>
                        <tr>
                            <td style="height: 63px">
                                订单情况<br />
                                (业务员填写)</td>
                            <td colspan="2" style="height: 63px">
                                <asp:DropDownList ID="ddlDdqk" runat="server" onchange="khfqCheck()">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>小批量</asp:ListItem>
                                    <asp:ListItem>批量</asp:ListItem>
                                    <asp:ListItem>无订单</asp:ListItem>
                                </asp:DropDownList></td>
                            <td colspan="1" style="height: 63px" id="tdDdqk">
                            </td>
                            <td colspan="7" style="height: 63px">
                                <asp:TextBox ID="tbFkddqk" runat="server" Height="47px" TextMode="MultiLine" Width="95%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="tbFkddqk"
                                    Display="Dynamic" Enabled="false" ErrorMessage="小批量/批量订单请填写首次订单号,无订单请在此说明原因"
                                    SetFocusOnError="true" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 63px">
                                客户使用<br />
                                情况反馈<br />
                                (业务员填写)</td>
                            <td colspan="10" style="height: 63px">
                                <asp:TextBox ID="tbSyqkfk" runat="server" Height="47px" TextMode="MultiLine" Width="95%"
                                    onchange="khsyqkChange()"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="11" style="height: 56px">
                                <asp:ImageButton ImageUrl="~/images/btnSubmit.jpg" ID="ibtnFyOK" OnClick="btnTj_Click"
                                    runat="server" /></td>
                        </tr>
                    </table>
                </div>
                <!--第二页结束-->
                <!--第三页开始-->
                <div style="text-align: center; width: 710px; margin: auto;" id="divTab3">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                        Style="text-align: center" Font-Names="Verdana" Font-Size="12px" EmptyDataText="该样品暂无实验进度"
                        Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
                        GridLines="Horizontal" AllowPaging="false" EmptyDataRowStyle-BackColor="#40e0d0">
                        <RowStyle ForeColor="#333333" BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="TABH" HeaderText="样品编号">
                                <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SZSL" HeaderText="实做数量">
                                <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FZR" HeaderText="负责人">
                                <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RQ" HeaderText="日期">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SYJD" HeaderText="实验进度">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#333333" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#479AC7" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </div>
                <!--第三页结束-->
                <!--divAll结束-->
            </div>
        </div>
    </form>
</body>
</html>
