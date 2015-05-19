<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ypzhpsdPrint.aspx.cs" Inherits="ypzhpsdPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
  
    table#tbGzzt
  {
    border-top:#000 1px solid;
    border-left:#000 1px solid;
  }
  
  table#tbGzzt td
  {
    border-bottom:#000 1px solid;
    border-right:#000 1px solid;
    text-align:center;
  }
  
  table#tbYpxx
  {
    border-top:#000 1px solid;
    border-left:#000 1px solid;
  }
  
  table#tbYpxx td
  {
    border-bottom:#000 1px solid;
    border-right:#000 1px solid;
    text-align:center;
  }
  table#tableYQ
  {
    border-top:#000 1px solid;
    border-left:#000 1px solid;
  }
  
  table#tableYQ td
  {
    border-bottom:#000 1px solid;
    border-right:#000 1px solid;
    text-align:center;
  }
  
  
  
  
  .tdNeed {
    /*color:#FF0000;*/
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
  
  #divTab1{
    display:block;
    
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

<style media="print">  
   .noprint { display : none; }  
</style> 

    <script type="text/javascript"> 
    
      //处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外
        function forbidBackSpace(e) {
            var ev = e || window.event; //获取event对象 
            var obj = ev.target || ev.srcElement; //获取事件源 
            var t = obj.type || obj.getAttribute('type'); //获取事件源类型 
            //获取作为判断条件的事件类型 
            var vReadOnly = obj.readOnly;
            var vDisabled = obj.disabled;
            //处理undefined值情况 
            vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
            vDisabled = (vDisabled == undefined) ? true : vDisabled;
            //当敲Backspace键时，事件源类型为密码或单行、多行文本的， 
            //并且readOnly属性为true或disabled属性为true的，则退格键失效 
            var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
            //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效 
            var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
            //判断 
            if (flag2 || flag1) return false;
        }
        //禁止后退键 作用于Firefox、Opera
        document.onkeypress = forbidBackSpace;
        //禁止后退键  作用于IE、Chrome
        document.onkeydown = forbidBackSpace;

    
    /*****流程控制开始*******/
//1.销售经理会签
function xsjlChange(){
       if(document.getElementById('ddlXsjl').value.length>0){
           document.getElementById('ddlXsjlhqzt').value="已会签"; 
           var sysDate=new Date(); 
           document.getElementById('tbXsjlhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
           //如果下一步的状态不为空    
           if ("-"==document.getElementById('ddlSwjlhqzt').value){
             document.getElementById('ddlSwjlhqzt').value="会签中";
             document.getElementById('tbLchqzt').value="商务经理会签中";
           }
            
       }
}

//2.商务经理会签
function swjlChange(){
       if(document.getElementById('ddlSwjl').value.length>0){
           document.getElementById('ddlSwjlhqzt').value="已会签";
           var sysDate=new Date(); 
           document.getElementById('tbSwjlhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds();
           if("-"==document.getElementById('ddlZghqzt').value){
               document.getElementById('ddlZghqzt').value="会签中";
               if(document.getElementById('ddlDjlx').value=="样品建议书"){
                 document.getElementById('tbLchqzt').value="总负责人会签中";
               } else {
                 document.getElementById('tbLchqzt').value="总工会签中";
               }
           }  
       }
}

//3.总工会签(开发提案结束)
function zgChange(){
        if(document.getElementById('ddlZg').value.length>0){
               var sysDate=new Date(); 
               document.getElementById('tbZghqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
               document.getElementById('ddlZghqzt').value="已会签";
               //如果是产品开发提案，那么流程结束
               if (document.getElementById('tbLclx').value=="产品开发提案"){
                  document.getElementById('tbLchqzt').value="已完成"; 
               } 
               //样品建议书  流程到总助或者电芯工程师
               else if(document.getElementById('tbLclx').value=="样品建议书"){
                  if(("-"==document.getElementById('ddlZzhqzt').value)&&("-"==document.getElementById('ddlDxhqzt').value)){
                     if( 
                         (parseInt(document.getElementById('tbCpsl').value)>=20)&&(parseInt(document.getElementById('tbBcrl').value)<1000)
                       ||(parseInt(document.getElementById('tbCpsl').value)>=10)&&(parseInt(document.getElementById('tbBcrl').value)>=1000)
                      ){
                       document.getElementById('ddlZzhqzt').value="会签中";
                       document.getElementById('tbLchqzt').value="总助会签中";
                     } else {
                       document.getElementById('ddlDxhqzt').value="会签中";
                       document.getElementById('tbLchqzt').value="电芯会签中";
                     }
                  }
               } 
               //规格书 流程到电芯工程师
               else if (document.getElementById('tbLclx').value=="规格书"){
                  if("-"==document.getElementById('ddlDxhqzt').value){
                     document.getElementById('ddlDxhqzt').value="会签中";
                     document.getElementById('tbLchqzt').value="电芯会签中";
                  }
               }
        }
       
       
}


//*总助会签
function zzChange(){
  if(document.getElementById('ddlZg').value.length>0){
      var sysDate=new Date(); 
      document.getElementById('tbZzhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
      document.getElementById('ddlZzhqzt').value="已会签";
      if("-"==document.getElementById('ddlDxhqzt').value){
           document.getElementById('ddlDxhqzt').value="会签中";
           document.getElementById('tbLchqzt').value="电芯会签中";
      }       
  }
}


//电芯会签
function dxChange(){
  if(document.getElementById('ddlDx').value.length>0){
      var sysDate=new Date(); 
      document.getElementById('tbDxhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
       document.getElementById('ddlDxhqzt').value="已会签";
      if("-"==document.getElementById('ddlPackhqzt').value&&"PACK"==document.getElementById('ddlCpzt').value){
           document.getElementById('ddlPackhqzt').value="会签中";
           document.getElementById('tbLchqzt').value="PACK会签中";
      } else if ("-"==document.getElementById('ddlSyshqzt').value){
           document.getElementById('ddlSyshqzt').value="会签中";
           document.getElementById('tbLchqzt').value="实验室会签中";
      }  
      
  }
}

//PACK会签
function packChange(){
  if(document.getElementById('ddlPack').value.length>0){
      var sysDate=new Date(); 
      document.getElementById('tbPackhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
      document.getElementById('ddlPackhqzt').value="已会签";
      if("-"==document.getElementById('ddlSyshqzt').value){
           document.getElementById('ddlSyshqzt').value="会签中";
           document.getElementById('tbLchqzt').value="实验室会签中";
      }    
  }
}



//实验室会签
function sysChange(){
   if(document.getElementById('ddlSys').value.length>0){
       var sysDate=new Date(); 
       document.getElementById('tbSyshqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds();  
       document.getElementById('ddlSyshqzt').value="已会签";
       //规格书流程结束
       if (document.getElementById('tbLclx').value=="规格书"){
          document.getElementById('tbLchqzt').value="已完成"; 
       } 
       else if(document.getElementById('tbLclx').value=="样品建议书"){
          document.getElementById('tbLchqzt').value="商务发样中"; 
       }
       
       
      //激活必填项
      ValidatorEnable(document.getElementById('RequiredFieldValidator67'), true);   
      //PACK激活必填项
      if (document.getElementById('ddlCpzt').value=="PACK"){
        ValidatorEnable(document.getElementById('RequiredFieldValidator68'), true);
      }  
   }
}


 //发样状态控制
function fhrqChange(){
       if(document.getElementById('tbFhrq').value.length>0){
          document.getElementById('tbLchqzt').value="待业务反馈中"; 
       }
}

//选择测试不通过时激活必填项
function khfqCheck(){
    if(document.getElementById('ddlKhcs').value=="测试不通过"){
      ValidatorEnable(document.getElementById('RequiredFieldValidator3'), true);
      khsyqkChange();
    } else {
      ValidatorEnable(document.getElementById('RequiredFieldValidator3'), false);
    }
    if ((document.getElementById('ddlDdqk').value=="小批量")||(document.getElementById('ddlDdqk').value=="批量")){
       document.getElementById('tdDdqk').innerText ="首次订单编号";
       ValidatorEnable(document.getElementById('RequiredFieldValidator13'), true);
       khsyqkChange();
    } else if (document.getElementById('ddlDdqk').value=="无订单"){
       document.getElementById('tdDdqk').innerText ="无订单原因";
       ValidatorEnable(document.getElementById('RequiredFieldValidator13'), true);
       khsyqkChange();
    } 
    if (document.getElementById('ddlKhcs').value=="测试通过"){
      khsyqkChange();
    }
}

 //客户使用情况反馈
function khsyqkChange(){
          document.getElementById('tbLchqzt').value="已完成"; 
}

/*****流程控制结束*******/


//成品状态  电芯/PACK
function cpztChange(){
   var cpzt=document.getElementById('ddlCpzt').value;
   if ("电芯"==cpzt){
      document.getElementById('divDxchfs').style.display="block";
      document.getElementById('divPackchfs').style.display="none";
     // document.getElementById('trPack').style.display="none";
      document.getElementById('lblCpzt').innerText="电芯尺寸";
   } else if ("PACK"==cpzt){
      document.getElementById('divPackchfs').style.display="block";
      document.getElementById('divDxchfs').style.display="none";
     // document.getElementById('trPack').style.display="";
      document.getElementById('lblCpzt').innerText="成品(PACK)尺寸";
   }
}

//电芯出货方式   单体/配组 Dxchfs
function dxchfsChange(){
   var dxchfs=document.getElementById('ddlDxchfs').value;
   if ("单体出货"==dxchfs){
      document.getElementById('tbSl').style.display="none";
      document.getElementById('tbDxdw').style.display="none";
   } else if (("串联配组出货"==dxchfs)||("并联配组出货"==dxchfs)){
      document.getElementById('tbSl').style.display="";
      document.getElementById('tbDxdw').style.display="";
      document.getElementById('tbDxdw').value='PCS/组';
   }
}

//PACK出货方式 单体PACK/组合PACK 
function packchfsChange(){
  var packchfs=document.getElementById('ddlPackchfs').value;
  if("单体PACK"==packchfs){
    document.getElementById('spCBLQK').style.display="none";
  } else if ("组合PACK"){
    document.getElementById('spCBLQK').style.display=""; 
  } 
}


//成品尺寸类型  初始尺寸/循环后尺寸 
function cpcclxChange(){
   var cpcclx=document.getElementById('ddlCpcclx').value;
   if ("初始尺寸"==cpcclx){
      document.getElementById('lblCclx').innerText="初始";
     // document.getElementById('divXhzq').style.display="none";
   } else if ("循环后尺寸"==cpcclx){
      document.getElementById('lblCclx').innerText="循环后";
     // document.getElementById('divXhzq').style.display="block";
   }
}

//内部结构尺寸是否被勾选
function nbjgccChange(){
      if(document.getElementById('cbNbkjcc').checked){
        document.getElementById('trNbjgcc').style.display="";
      } else {
        document.getElementById('trNbjgcc').style.display="none";
      }
}

//点击退单历史显示退单历史
function tdlsClick(){
   if( document.getElementById('aTdls').innerHTML=="点击查看退单历史"){
     document.getElementById('divTdls').style.display="";
     document.getElementById('aTdls').innerHTML="点击隐藏退单历史";
   } else if (document.getElementById('aTdls').innerHTML=="点击隐藏退单历史"){
     document.getElementById('divTdls').style.display="none";
     document.getElementById('aTdls').innerHTML="点击查看退单历史";
  
   }
}

//内控之后自动填写
function nkClick(){
   if(document.getElementById('cbGgnk').checked){
     document.getElementById('tbGG').value="/"; 
   }
   if(document.getElementById('cbDlglicggnk').checked){
     document.getElementById('tbDlglicgg').value="/"; 
   }
   if(document.getElementById('cbMOSGNK').checked){
     document.getElementById('tbMosgyq').value="/"; 
   }
}



//必填项
function setRequired(){
   if((document.getElementById('cbAzggs').checked||document.getElementById('cbCzggs').checked)&&document.getElementById('tbGGSBH').value!=""){
     document.getElementById('ddlZzqk').value="库存出货";
     var arrRequired=new Array(
                            "tbPmyq","tbCbbhfs","tbCpbzfs",
                            "tbCCC","tbCCK","tbCCH","tbBcrl","tbZxrl","tbNz","tbChdy","tbBcdy","tbJecd","tbJekd",
                            "tbJezxj","tbHpzxj","tbHpkd","tbCpxwd","tbYsfs","tbHbyq","tbRzyq","tbCddl","tbFddl","tbZdsydl",
                            "tbCxsj","tbCdwd","tbFdwd","tbJzdy","tbGG","tbDlglicgg","tbMosgyq","tbNTCZZ","tbBz","tbHolddl",
                            "tbTripdl","tbFusebxs","tbCxwz","tbWxlc","tbXtgxcd","tbLjqpp","tbLjqgg","tbDzmxsnr","tbDzmxxnr","tbSjkys",
                            "tbSjkcz","tbFhdj","tbGGXH","tbNTWZ"
                            );
     for(var i=0;i<arrRequired.length;i++){
        if(document.getElementById(arrRequired[i]).value==""){
         document.getElementById(arrRequired[i]).value="-";
        }
     }
     
   }

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
    ValidatorEnable(document.getElementById('CompareValidator8'), true);
  } else {
     ValidatorEnable(document.getElementById('CompareValidator8'), false);
  }
   
  
}

function sfytdxhChange(){
  if (document.getElementById('ddlSfytdxh').value=="有"){
    ValidatorEnable(document.getElementById('RequiredFieldValidator7'), true);
  } else {
     ValidatorEnable(document.getElementById('RequiredFieldValidator7'), false);
  }
  
}



//退回的单子业务员修改后
function lbtnOK_disbale(){
  if (document.getElementById('ddlXsry').value.length>0 && document.getElementById('tbXsryhqsj').value.length<=0 &&document.getElementById('tbLchqzt').value=="退回业务员处理"){
         var sysDate=new Date(); 
         document.getElementById('tbXsryhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
         //初始化会签状态
         document.getElementById('tbLchqzt').value="业务员已修改";
  } 
  if (document.getElementById('ddlXsry').value.length>0 && document.getElementById('tbXsryhqsj').value.length<=0 &&document.getElementById('tbLchqzt').value=="业务员保存"){
         var sysDate=new Date(); 
         document.getElementById('tbXsryhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
         //初始化会签状态
         document.getElementById('tbLchqzt').value="销售经理会签中";
         document.getElementById('ddlXsjlhqzt').value="会签中";
         document.getElementById('ddlSwjlhqzt').value="-";
         document.getElementById('ddlZghqzt').value="-";
         document.getElementById('ddlSyshqzt').value="-";
         
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


 function checkselect() {
            var cbl = document.getElementById('cblYpjys');
            var inputs = cbl.getElementsByTagName("input");

            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type == "checkbox") {
                    inputs[i].onclick = function () {                                          
                        var cbs = inputs;
                        for (var i = 0; i < cbs.length; i++) {
                            if (cbs[i].type == "checkbox" && cbs[i] != this && this.checked) {
                                cbs[i].checked = false;
                            }
                        }
                    }
                }
            }
        }
        
        
        function cpkftaPrint(){
          window.print();
        }
   

    </script>
    

</head>
<body>
    <form id="form1" runat="server">
        <div id="divAll1">
            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tbYqjhjq"
                Format="yyyy-MM-dd">
            </ajaxToolkit:CalendarExtender>
            <div align="center" id="divTab1">
                <div style="font-size: 12px;">
                    <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="true"
                        EnableScriptLocalization="true">
                        <Services>
                            <asp:ServiceReference Path="~/AutoCompleteService.svc" />
                        </Services>
                    </ajaxToolkit:ToolkitScriptManager>
                    <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                        id="border">
                        <tr style="font-size: 25px; font-weight: bold;">
                            <td colspan="12">
                                <asp:DropDownList ID="ddlDjlx" runat="server" Font-Size="15pt" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlDjlx_SelectedIndexChanged">
                                    <asp:ListItem>产品开发提案</asp:ListItem>
                                    <asp:ListItem>样品建议书</asp:ListItem>
                                    <asp:ListItem>规格书申请单</asp:ListItem>
                                </asp:DropDownList>
                                <label style="display: none">
                                    <asp:TextBox ID="tbLclx" runat="server"></asp:TextBox></label>
                                <asp:LinkButton ID="lbSave" runat="server" Style="color: #000; padding: 6px 3px;
                                    display: inline-block; text-decoration: none; background-color: #E6E6FA; font-size: 12px"
                                    OnClick="lbSave_Click" CausesValidation="False">保存</asp:LinkButton>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
                                    ShowMessageBox="true" HeaderText="请检查如下项目是否填写正确" EnableClientScript="true" />
                                <input id="Button1" class="noprint" onclick="cpkftaPrint()" type="button" value="打印" />
                                <a style="color: #000; padding: 6px 3px; display: none; text-decoration: none;
                                    background-color: #529F1D; font-size: 12px" href="ypzhpsdPrint.aspx?xh=<%=xh%>&lb=EDIT&editType=全部"
                                    target="_blank">打印</a>
                                <div runat="server" id="divYpjys" style="font-size: 11px; font-weight: normal; border-top: 1px  solid #000;
                                    border-bottom: 1px  solid #000;">
                                    样品需求
                                    <asp:RadioButtonList ID="rbYpjys" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                        RepeatLayout="Flow" OnSelectedIndexChanged="rbYpjys_SelectedIndexChanged">
                                        <asp:ListItem>要</asp:ListItem>
                                        <asp:ListItem>不要</asp:ListItem>
                                    </asp:RadioButtonList>     
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator66"
                                                runat="server" ControlToValidate="rbYpjys" Display="Dynamic" ErrorMessage="请选择是否需要样品建议书"
                                                SetFocusOnError="true" />
                                    <label id="lbDxsl" runat="server" visible="false">
                                        &nbsp; &nbsp;&nbsp;&nbsp; 收费情况
                                        <asp:DropDownList ID="ddlSfqk" runat="server">
                                            <asp:ListItem>请选择</asp:ListItem>
                                            <asp:ListItem>免费样品</asp:ListItem>
                                            <asp:ListItem>收费样品</asp:ListItem>
                                        </asp:DropDownList>成品数量<asp:TextBox ID="tbCpsl" runat="server" Width="60px"></asp:TextBox>
                                        单位
                                        <asp:DropDownList ID="ddlDw" runat="server">
                                            <asp:ListItem>请选择</asp:ListItem>
                                            <asp:ListItem>PCS</asp:ListItem>
                                            <asp:ListItem>组</asp:ListItem>
                                        </asp:DropDownList>总电芯数量
                                        <asp:TextBox ID="tbZdxsl" runat="server" Width="60px"></asp:TextBox><asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator11" runat="server" ControlToValidate="tbZdxsl" Display="Dynamic"
                                            ErrorMessage="请填写总电芯数量" SetFocusOnError="true">
                                        </asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                                            runat="server" ControlToValidate="tbSl" Display="Dynamic" ErrorMessage="数量只能为数字"
                                            SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
                                            <asp:CompareValidator
                                                ID="CompareValidator6" runat="server" ControlToValidate="ddlSfqk" Display="Dynamic"
                                                EnableTheming="true" ErrorMessage="请选择收费情况" Operator="NotEqual" SetFocusOnError="true"
                                                Type="string" ValueToCompare="请选择" />
                                            <asp:CompareValidator
                                                ID="CompareValidator2" runat="server" ControlToValidate="ddlDw" Display="Dynamic"
                                                EnableTheming="true" ErrorMessage="请选择单位" Operator="NotEqual" SetFocusOnError="true"
                                                Type="string" ValueToCompare="请选择">
                                            </asp:CompareValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator10"
                                                runat="server" ControlToValidate="tbCpsl" Display="Dynamic" ErrorMessage="请填写成品数量"
                                                SetFocusOnError="true"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                    ID="RegularExpressionValidator3" runat="server" ControlToValidate="tbCpsl" Display="Dynamic"
                                                    ErrorMessage="数量只能为数字" SetFocusOnError="true" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator></label></div>
                                <div runat="server" id="divGgs" style="font-size: 11px; font-weight: normal;">
                                    新规格书需求
                                    <asp:RadioButtonList ID="rbGGSXQ" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                        RepeatLayout="Flow" OnSelectedIndexChanged="rbYpjys_SelectedIndexChanged">
                                        <asp:ListItem>要</asp:ListItem>
                                        <asp:ListItem>不要</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator65"
                                                runat="server" ControlToValidate="rbGGSXQ" Display="Dynamic" ErrorMessage="请选择是否需要新规格书"
                                                SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    
                                    </div>
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
                            <td colspan="12" style="height: 47px">
                                退单次数
                                <asp:TextBox ID="tbTdcs" runat="server" Width="67px"></asp:TextBox><a href="javascript:void(0)"
                                    onclick="tdlsClick()" id="aTdls">点击查看退单历史</a>
                                <div id="divTdls" style="display: none">
                                    <asp:TextBox ID="tbLsjl" runat="server" Rows="30" TextMode="MultiLine" Width="90%"></asp:TextBox><br />
                                </div>
                            </td>
                        </tr>
                        <tr id="trKhxx" runat="server">
                            <td style="width: 79px;" rowspan="4">
                                客户信息</td>
                            <td style="width: 103px;">
                                客户代码</td>
                            <td colspan="10">
                                <asp:TextBox ID="tbKhdm" runat="server" Width="90%"></asp:TextBox><asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator4" runat="server" ErrorMessage="请填写客户代码" Display="Dynamic"
                                    ControlToValidate="tbKhdm" SetFocusOnError="true"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator13" runat="server" ControlToValidate="tbKhdm" Display="Dynamic"
                                        ErrorMessage="客户代码需要为FXXXX的格式，其中F大写，XXXX为4位数字和字母组合" SetFocusOnError="true" ValidationExpression="^[F][A-Z0-9]{4}$"></asp:RegularExpressionValidator>&nbsp;
                            </td>
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
                                应用领域</td>
                            <td colspan="5">
                                <asp:TextBox ID="tbYyly" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbYyly"
                                    Display="Dynamic" ErrorMessage="请填写应用领域" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        
                        <tr id="trKhxxKhxh" runat="server">
                            <td style="width: 103px;">
                                客户型号</td>
                            <td colspan="4">
                                <asp:TextBox ID="tbKhxh" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator42" runat="server" ControlToValidate="tbKhxh"
                                    Display="Dynamic" ErrorMessage="请填写客户型号" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td class="tdNeed" style="width: 75px;">
                                库存电池<br />
                                （2013年1月1日以后）</td>
                            <td colspan="5">
                                &nbsp;<asp:DropDownList ID="ddlKcdc" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>有</asp:ListItem>
                                    <asp:ListItem>无</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr runat="server" id="trYqjhjq">
                            <td style="width: 103px;">
                                要求交货交期</td>
                            <td colspan="4">
                                <asp:TextBox ID="tbYqjhjq" runat="server" Width="90%"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator54" runat="server" ControlToValidate="tbYqjhjq"
                                    Display="Dynamic" Enabled="true" ErrorMessage="请填写客户要求交期" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td class="tdNeed" style="width: 75px;">
                                库存数量</td>
                            <td colspan="5">
                                <asp:DropDownList ID="ddlKcsl" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>≥2K</asp:ListItem>
                                    <asp:ListItem>＜2K</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr runat="server" id="Tr1">
                            <td rowspan="1" style="width: 79px">
                            </td>
                            <td style="width: 103px">
                            </td>
                            <td colspan="4">
                            </td>
                            <td class="tdNeed" style="width: 75px">
                            </td>
                            <td colspan="5">
                            </td>
                        </tr>
                        <tr runat="server" id="trUlxx" class="tdNeed">
                            <td rowspan="1" style="width: 79px">
                                UL信息</td>
                            <td style="width: 103px;">
                                是否需要UL认证</td>
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
                    <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                        id="tableKhxq">
                        <tr>
                            <td rowspan="15">
                                &nbsp;客户需求 &nbsp;</td>
                                <td class="tdNeed">
                                成品状态&nbsp;</td>
                            <td>
                                &nbsp;<asp:DropDownList ID="ddlCpzt" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCpzt_SelectedIndexChanged">
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
                                    <asp:TextBox ID="tbDxdw" runat="server" Width="25%"></asp:TextBox></div>
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
                          <td>
                                内部型号&nbsp;</td>
                            <td colspan="5">
                                &nbsp; &nbsp;
                                <asp:TextBox ID="tbNbxh" runat="server" Width="90%" AutoPostBack="True" OnTextChanged="tbNbxh_TextChanged"></asp:TextBox>
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="200"
                                    EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetDxxhList" ServicePath="~/GetContent.asmx"
                                    TargetControlID="tbNbxh">
                                </ajaxToolkit:AutoCompleteExtender>
                                &nbsp;&nbsp;
                                <asp:CustomValidator ID="CustomValidator1" runat="server" Display="Dynamic" SetFocusOnError="true"
                                    ControlToValidate="tbNbxh" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="tbNbxh"
                                    Display="Dynamic" Enabled="false" ErrorMessage="请填写内部型号" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                         
                        </tr>
                        <tr id="trKhxxGGS" runat="server">
                            <td>
                                规格书编号</td>
                            <td colspan="2">
                                &nbsp;
                                <asp:TextBox ID="tbGGSBH" runat="server" Width="90%"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator43" runat="server" ControlToValidate="tbGGSBH"
                                    Display="Dynamic" ErrorMessage="请填写规格书型号" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                规格书版本</td>
                            <td colspan="2">
                                &nbsp;<asp:TextBox ID="tbKHGGSBB" runat="server" Width="90%"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator49" runat="server" ControlToValidate="tbKHGGSBB"
                                    Display="Dynamic" ErrorMessage="请填写规格书版本" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </td>
                        </tr>
                        <tr id="trKhxxGGS1" runat="server" align="left" visible="false">
                            <td colspan="6">
                                <div style="text-align: left">
                                    <asp:CheckBox ID="cbAzggs" runat="server" onclick="setRequired()" Text="按照以上版本的规格书内容制作样品" /></div>
                                <div style="text-align: left">
                                    <asp:CheckBox ID="cbCzggs" runat="server" onclick="setRequired()" Text="参考以上版本的规格书及以下信息制作样品或新规格书" /></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;成品尺寸类型</td>
                            <td colspan="2">
                                &nbsp;&nbsp;<asp:DropDownList ID="ddlCpcclx" runat="server" Width="90%" onchange="cpcclxChange()">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>初始尺寸</asp:ListItem>
                                    <asp:ListItem>循环后尺寸</asp:ListItem>
                                </asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlCpcclx"
                                    Display="Dynamic" EnableTheming="true" ErrorMessage="请选择成品尺寸类型" Operator="NotEqual"
                                    SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                                </asp:CompareValidator></td>
                            <td colspan="2">
                                &nbsp; 循环周期<asp:TextBox ID="tbXhzq" runat="server" Width="32px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator56" runat="server" ControlToValidate="tbXhzq"
                                    Display="Dynamic" Enabled="true" ErrorMessage="请填写循环周期" SetFocusOnError="true"></asp:RequiredFieldValidator>周</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="6">
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
                                <asp:TextBox ID="tbCCH" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="tbCCH"
                                    Display="Dynamic" ErrorMessage="请填写厚度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                <asp:TextBox ID="tbCCK" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="tbCCK"
                                    Display="Dynamic" ErrorMessage="请填写宽度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                <asp:TextBox ID="tbCCC" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="tbCCC"
                                    Display="Dynamic" ErrorMessage="请填写长度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr id="trNbjgcc">
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
                                标称容量<br />
                                &nbsp; (mAh)</td>
                            <td>
                                <asp:TextBox ID="tbBcrl" runat="server" Width="90%"></asp:TextBox><asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="请填写标称容量" Display="Dynamic"
                                    ControlToValidate="tbBcrl" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                最小容量<br />
                                &nbsp; (mAh)</td>
                            <td>
                                <asp:TextBox ID="tbZxrl" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" ControlToValidate="tbZxrl"
                                    Display="Dynamic" ErrorMessage="请填写最小容量" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                内阻<br />
                                &nbsp; (mΩ)</td>
                            <td>
                                <asp:TextBox ID="tbNz" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" ControlToValidate="tbCCH"
                                    Display="Dynamic" ErrorMessage="请填写内阻" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td class="tdNeed">
                                出货电压<br />
                                <br />
                                (V)</td>
                            <td colspan="3">
                                <asp:TextBox ID="tbChdy" runat="server" Width="40%"></asp:TextBox>
                                ～<asp:TextBox ID="tbChdyMax" runat="server" Width="40%"></asp:TextBox>&nbsp;
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbChdy"
                                    Display="Dynamic" ErrorMessage="请填写出货电压" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                &nbsp;&nbsp; &nbsp;
                            </td>
                            <td>
                                标称电压(V)</td>
                            <td>
                                <asp:TextBox ID="tbBcdy" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ControlToValidate="tbBcdy"
                                    Display="Dynamic" ErrorMessage="请填写标称电压" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                极耳长度<br />
                                &nbsp;&nbsp; (mm)</td>
                            <td colspan="2">
                                <asp:TextBox ID="tbJecd" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="tbJecd"
                                    Display="Dynamic" ErrorMessage="请填写极耳长度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                极耳宽度<br />
                                &nbsp; (mm)</td>
                            <td colspan="2">
                                <asp:TextBox ID="tbJekd" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="tbJekd"
                                    Display="Dynamic" ErrorMessage="请填写极耳宽度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                极耳中心距(mm)</td>
                            <td>
                                <asp:TextBox ID="tbJezxj" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="tbJezxj"
                                    Display="Dynamic" ErrorMessage="请填写极耳中心距" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                焊盘中心距<br />
                                &nbsp; (mm)</td>
                            <td>
                                <asp:TextBox ID="tbHpzxj" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ControlToValidate="tbHpzxj"
                                    Display="Dynamic" ErrorMessage="请填写焊盘中心距" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                焊盘宽度<br />
                                &nbsp; (mm)</td>
                            <td>
                                <asp:TextBox ID="tbHpkd" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ControlToValidate="tbHpkd"
                                    Display="Dynamic" ErrorMessage="请填写焊盘宽度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                产品销往地</td>
                            <td colspan="3">
                                <asp:TextBox ID="tbCpxwd" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator60" runat="server" ControlToValidate="tbCpxwd"
                                    Display="Dynamic" ErrorMessage="请填写产品销往地" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                运输方式</td>
                            <td>
                                <asp:TextBox ID="tbYsfs" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator61" runat="server" ControlToValidate="tbYsfs"
                                    Display="Dynamic" ErrorMessage="请填写运输方式" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                环保要求</td>
                            <td colspan="2">
                                <asp:TextBox ID="tbHbyq" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ControlToValidate="tbHbyq"
                                    Display="Dynamic" ErrorMessage="请填写环保要求" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                认证要求</td>
                            <td colspan="2">
                                <asp:TextBox ID="tbRzyq" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ControlToValidate="tbRzyq"
                                    Display="Dynamic" ErrorMessage="请填写认证要求" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                    </table>
                    <table border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                        width="760" id="tbGzzt">
                        <tr>
                            <td rowspan="3">
                                工作状态</td>
                            <td>
                                充电电流<br />
                                &nbsp; (mA)</td>
                            <td>
                                <asp:TextBox ID="tbCddl" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ControlToValidate="tbCddl"
                                    Display="Dynamic" ErrorMessage="请填写充电电流" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                放电电流<br />
                                &nbsp; (mA)</td>
                            <td>
                                <asp:TextBox ID="tbFddl" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" ControlToValidate="tbFddl"
                                    Display="Dynamic" ErrorMessage="请填写放电电流" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                最大使用电流(mA)</td>
                            <td>
                                <asp:TextBox ID="tbZdsydl" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator33" runat="server" ControlToValidate="tbZdsydl"
                                    Display="Dynamic" ErrorMessage="请填写最大使用电流" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                持续时间</td>
                            <td>
                                <asp:TextBox ID="tbCxsj" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" ControlToValidate="tbCxsj"
                                    Display="Dynamic" ErrorMessage="请填写持续时间" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                充电温度<br />
                                &nbsp; (℃)</td>
                            <td>
                                <asp:TextBox ID="tbCdwd" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator32" runat="server" ControlToValidate="tbCdwd"
                                    Display="Dynamic" ErrorMessage="请填写充电温度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                            <td>
                                放电温度</td>
                            <td>
                                <asp:TextBox ID="tbFdwd" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" ControlToValidate="tbFdwd"
                                    Display="Dynamic" ErrorMessage="请填写放电温度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                截至电压<br />
                                &nbsp;&nbsp; (V)</td>
                            <td>
                                <asp:TextBox ID="tbJzdy" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator30" runat="server" ControlToValidate="tbJzdy"
                                    Display="Dynamic" ErrorMessage="请填写截至电压" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
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
                        id="tablePackyq" width="760" runat="server" visible="false">
                        <tr id="trPack" bgcolor="#FFCCCC">
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
                                            <asp:TextBox ID="tbGG" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator35" runat="server" ControlToValidate="tbGG"
                                                Display="Dynamic" ErrorMessage="请填写规格" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            <asp:CheckBox ID="cbGgnk" runat="server" Text="内控" onclick="nkClick()" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8">
                                            电量管理IC规格：<asp:TextBox ID="tbDlglicgg" runat="server" Width="75%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator36" runat="server" ControlToValidate="tbDlglicgg"
                                                Display="Dynamic" ErrorMessage="请填写电源管理IC规格" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            <asp:CheckBox ID="cbDlglicggnk" runat="server" Text="内控" onclick="nkClick()" /></td>
                                    </tr>
                                    <tr>
                                        <td width="10%">
                                            MOS管要求</td>
                                        <td colspan="7">
                                            <asp:TextBox ID="tbMosgyq" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator37" runat="server" ControlToValidate="tbMosgyq"
                                                Display="Dynamic" ErrorMessage="请填写MOS管要求" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            <asp:CheckBox ID="cbMOSGNK" runat="server" Text="内控" onclick="nkClick()" /></td>
                                    </tr>
                                    <tr>
                                        <td width="10%">
                                            NTC阻值(K)</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbNTCZZ" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator38" runat="server" ControlToValidate="tbNTCZZ"
                                                Display="Dynamic" ErrorMessage="请填写NTC阻值" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            B值(K)</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbBz" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator40" runat="server" ControlToValidate="tbBz"
                                                Display="Dynamic" ErrorMessage="请填写B值" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
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
                                            <asp:TextBox ID="tbHolddl" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator39" runat="server" ControlToValidate="tbHolddl"
                                                Display="Dynamic" ErrorMessage="请填写Hold电流" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            Trip电流</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbTripdl" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator41" runat="server" ControlToValidate="tbTripdl"
                                                Display="Dynamic" ErrorMessage="请填写Trip电流" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            其他要求</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbBhbQtyq" runat="server" Width="90%"></asp:TextBox>
                                        </td>
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
                                            <asp:TextBox ID="tbQTGG" runat="server" Width="90%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="10%">
                                            Fuse保险丝</td>
                                        <td colspan="9">
                                            <asp:TextBox ID="tbFusebxs" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator44" runat="server" ControlToValidate="tbFusebxs"
                                                Display="Dynamic" ErrorMessage="请填写Fuse保险丝" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td width="10%" rowspan="3">
                                            电子线</td>
                                        <td width="10%">
                                            出线位置</td>
                                        <td colspan="8">
                                            <asp:TextBox ID="tbCxwz" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator45" runat="server" ControlToValidate="tbCxwz"
                                                Display="Dynamic" ErrorMessage="请填写出线位置" SetFocusOnError="true"></asp:RequiredFieldValidator>&nbsp;
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
                                            外线露长±3mm：<asp:TextBox ID="tbWxlc" runat="server" Width="40%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator46" runat="server" ControlToValidate="tbWxlc"
                                                Display="Dynamic" ErrorMessage="请填写外线露长" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td colspan="3">
                                            线头挂锡长度±0.5mm：<asp:TextBox ID="tbXtgxcd" runat="server" Width="30%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator48" runat="server" ControlToValidate="tbXtgxcd"
                                                Display="Dynamic" ErrorMessage="请填写线头挂锡长度" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            其他</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbDzxqt" runat="server" Width="90%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="10%" rowspan="2">
                                            插头线</td>
                                        <td colspan="2">
                                            连接器品牌</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbLjqpp" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator47" runat="server" ControlToValidate="tbLjqpp"
                                                Display="Dynamic" ErrorMessage="请填写连接器品牌" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td colspan="2">
                                            连接器规格：</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbLjqgg" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator50" runat="server" ControlToValidate="tbLjqgg"
                                                Display="Dynamic" ErrorMessage="请填写连接器规格" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            <asp:CheckBox ID="cbLjqnk" runat="server" Text="内控" /></td>
                                    </tr>
                                    <tr>
                                        <td width="10%">
                                            排列线序</td>
                                        <td colspan="4">
                                            <asp:CheckBox ID="cbDzmxs" runat="server" Text="端子面向上" />
                                            <asp:TextBox ID="tbDzmxsnr" runat="server" Width="50%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator51" runat="server" ControlToValidate="tbDzmxsnr"
                                                Display="Dynamic" ErrorMessage="请填写端子面向上内容" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td colspan="4">
                                            <asp:CheckBox ID="cbDzmxx" runat="server" Text="端子面向下" />
                                            <asp:TextBox ID="tbDzmxxnr" runat="server" Width="50%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator57" runat="server" ControlToValidate="tbDzmxxnr"
                                                Display="Dynamic" ErrorMessage="请填写端子面向下内容" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
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
                                            <asp:TextBox ID="tbQtys" runat="server" Width="50%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2" width="10%">
                                            塑胶壳</td>
                                        <td width="10%">
                                            颜色</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbSjkys" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator52" runat="server" ControlToValidate="tbSjkys"
                                                Display="Dynamic" ErrorMessage="请填写塑胶壳颜色" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            材质</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbSjkcz" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator53" runat="server" ControlToValidate="tbSjkcz"
                                                Display="Dynamic" ErrorMessage="请填写材质" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            防火等级</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbFhdj" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator55" runat="server" ControlToValidate="tbFhdj"
                                                Display="Dynamic" ErrorMessage="请填写防火等级" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
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
                                            <asp:TextBox ID="tbGGXH" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator58" runat="server" ControlToValidate="tbGGXH"
                                                Display="Dynamic" ErrorMessage="请填写型号规格" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                        <td width="10%">
                                            粘帖位置</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="tbNTWZ" runat="server" Width="90%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator59" runat="server" ControlToValidate="tbNTWZ"
                                                Display="Dynamic" ErrorMessage="请填写粘贴位置" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
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
                    </table>
                    <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                        id="tableYQ" runat="server">
                        <tr>
                            <td style="width: 79px;">
                                喷码要求</td>
                            <td colspan="11">
                                <asp:TextBox ID="tbPmyq" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator62" runat="server" ControlToValidate="tbPmyq"
                                    Display="Dynamic" ErrorMessage="请填写喷码要求" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 79px;">
                                侧边保护方式
                            </td>
                            <td colspan="11">
                                <asp:TextBox ID="tbCbbhfs" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator63" runat="server" ControlToValidate="tbCbbhfs"
                                    Display="Dynamic" ErrorMessage="请填写侧边保护方式" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 79px;">
                                成品包装方式</td>
                            <td colspan="11">
                                <asp:TextBox ID="tbCpbzfs" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator64" runat="server" ControlToValidate="tbCpbzfs"
                                    Display="Dynamic" ErrorMessage="请填写成品包装方式" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 79px;">
                                其他要求</td>
                            <td colspan="11">
                                <asp:TextBox ID="tbQtyq" runat="server" Rows="5" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                        </tr>
                    </table>
                    <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                        id="tbYpxx" runat="server">
                        <tr>
                            <td style="width: 79px;" class="tdNeed">
                                收费情况</td>
                            <td colspan="2">
                                &nbsp;
                            </td>
                            <td style="width: 60px;" class="tdNeed">
                                制作情况</td>
                            <td colspan="2">
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
                            <td style="width: 63px;">
                                是否开模</td>
                            <td colspan="5">
                                &nbsp;<asp:DropDownList ID="ddlSfkm" runat="server">
                                    <asp:ListItem>-</asp:ListItem>
                                    <asp:ListItem>是</asp:ListItem>
                                    <asp:ListItem>否</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width: 79px;">
                                预计价格</td>
                            <td colspan="5">
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
                            <td class="tdNeed" colspan="6">
                                &nbsp;第<asp:DropDownList ID="ddlDjcsy" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                    <asp:ListItem>6</asp:ListItem>
                                    <asp:ListItem>7</asp:ListItem>
                                    <asp:ListItem>8</asp:ListItem>
                                    <asp:ListItem>9</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                </asp:DropDownList><asp:CompareValidator ID="CompareValidator9" runat="server" ControlToValidate="ddlDjcsy"
                                    Display="Dynamic" EnableTheming="true" ErrorMessage="请选择第几次送样" Operator="NotEqual"
                                    SetFocusOnError="true" Type="string" ValueToCompare="请选择">
                                </asp:CompareValidator>次送样<br />
                                </td>
                        </tr>
                        <tr>
                            <td style="width: 79px;">
                                上次送样未通过原因</td>
                            <td colspan="2">
                                <asp:TextBox ID="tbScsywtgyy" runat="server" Width="90%"></asp:TextBox></td>
                            <td colspan="3">
                                模具付费情况<asp:DropDownList ID="ddlMjffqk" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>已付费</asp:ListItem>
                                    <asp:ListItem>未付费</asp:ListItem>
                                </asp:DropDownList></td>
                            <td colspan="2">
                                上次送样日期</td>
                            <td colspan="4">
                                <asp:TextBox ID="tbScsyrq" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                后续单量描述</td>
                            <td class="tdNeed" colspan="3">
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
                            <td colspan="2">
                                预计下单日期</td>
                            <td class="tdNeed" colspan="4">
                                <asp:TextBox ID="tbYjxdrq" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                技术说明&nbsp;<asp:CheckBoxList ID="cblYpcsbg" runat="server" RepeatDirection="Horizontal"
                                    RepeatLayout="Flow">
                                    <asp:ListItem>样品测试报告</asp:ListItem>
                                    <asp:ListItem>规格书</asp:ListItem>
                                </asp:CheckBoxList></td>
                            <td colspan="2">
                                送样方式</td>
                            <td class="tdNeed" colspan="4">
                                <asp:DropDownList ID="ddlSyfs" runat="server" Width="90%">
                                    <asp:ListItem>交业务员</asp:ListItem>
                                    <asp:ListItem>送PACK</asp:ListItem>
                                    <asp:ListItem>指定地址送样(附地址)</asp:ListItem>
                                    <asp:ListItem>其他方式</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                    </table>
                    <table width="760" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F1FEDD"
                        id="tableCpkfta" runat="server">
                        <tr runat="server" visible="false" id="Tr2">
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
                            <td colspan="4">
                                3.市场风险简述</td>
                            <td colspan="3" class="tdNeed">
                                4.评估结论</td>
                        </tr>
                        <tr bgcolor="#CCFFFF" id="trScqjnr" runat="server">
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
                        <tr bgcolor="#ccffff" id="trZzps" runat="server">
                            <td runat="server" style="width: 60px;" id="Td3">
                                总经理助理</td>
                            <td colspan="4">
                                <asp:DropDownList ID="ddlZz" runat="server" Width="45%" onchange="zzChange()">
                                </asp:DropDownList><asp:TextBox ID="tbZzhqsj" runat="server" Width="45%"></asp:TextBox></td>
                            <td runat="server" style="width: 60px;" id="Td4">
                            </td>
                            <td colspan="6">
                            </td>
                        </tr>
                        <tr bgcolor="#ccffff" id="trGcsps" runat="server">
                            <td runat="server" style="width: 60px;" id="Td5">
                                电芯工程师</td>
                            <td colspan="4">
                                <asp:DropDownList ID="ddlDx" runat="server" Width="45%" onchange="dxChange()">
                                </asp:DropDownList><asp:TextBox ID="tbDxhqsj" runat="server" Width="45%"></asp:TextBox></td>
                            <td runat="server" style="width: 60px;" id="Td6">
                                转交电芯工程师</td>
                            <td colspan="6">
                                <asp:DropDownList ID="ddlZjdxgcs" runat="server" Width="45%">
                                </asp:DropDownList></td>
                        </tr>
                        <tr runat="server" bgcolor="#ccffff" id="Tr3">
                            <td runat="server" colspan="12" id="Td9">
                                电芯型号<asp:TextBox ID="tbDxDxxh" runat="server" Width="9%"></asp:TextBox>容量<asp:TextBox
                                    ID="tbDxrl" runat="server" Width="7%"></asp:TextBox>厚(mm)<asp:TextBox ID="tbDxCch"
                                        runat="server" Width="5%"></asp:TextBox>宽(mm)<asp:TextBox ID="tbDxCck" runat="server"
                                            Width="6%"></asp:TextBox>高(mm)<asp:TextBox ID="tbDxCcc" runat="server" Width="5%"></asp:TextBox>内阻<asp:TextBox
                                                ID="tbDxnz" runat="server" Width="9%"></asp:TextBox>极耳中心距(mm)<asp:TextBox ID="tbDxJezxj"
                                                    runat="server" Width="9%"></asp:TextBox></td>
                        </tr>
                        <tr id="trPackgcs" runat="server" bgcolor="#ccffff">
                            <td id="Td1" runat="server" style="width: 60px;">
                                PACK工程师</td>
                            <td colspan="4">
                                <asp:DropDownList ID="ddlPack" runat="server" Width="45%" onchange="packChange()">
                                </asp:DropDownList><asp:TextBox ID="tbPackhqsj" runat="server" Width="45%"></asp:TextBox>
                            </td>
                            <td id="Td2" runat="server" style="width: 60px;">
                                转交PACK工程师</td>
                            <td colspan="6">
                                <asp:DropDownList ID="ddlZjgcs" runat="server" Width="45%">
                                </asp:DropDownList></td>
                        </tr>
                        <tr bgcolor="#ccffff" visible="false" runat="server" id="Tr4">
                            <td style="width: 60px;">
                                评审批注</td>
                            <td colspan="11">
                                <asp:TextBox ID="tbPspz" runat="server" Rows="9" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr bgcolor="#ccffff" id="trGGS1" runat="server">
                            <td style="width: 60px;">
                                规格书编号</td>
                            <td colspan="4">
                                <asp:TextBox ID="tbGgszxhmc" runat="server" Width="90%"></asp:TextBox></td>
                            <td style="width: 60px;">
                                &nbsp;版本</td>
                            <td colspan="6">
                                <asp:TextBox ID="tbGGSBB" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr runat="server" bgcolor="#ccffff" id="trXh">
                            <td id="Td7" runat="server" style="width: 60px;">
                                成品电芯型号</td>
                            <td colspan="4">
                                <asp:TextBox ID="tbZzdxxh" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator67" runat="server" ControlToValidate="tbZzdxxh"
                                    Display="Dynamic" ErrorMessage="请填写成品电芯型号" SetFocusOnError="true" Enabled="false"></asp:RequiredFieldValidator>
                            </td>
                            <td id="Td8" runat="server" style="width: 60px;">
                                成品PACK型号</td>
                            <td colspan="6">
                            <asp:TextBox ID="tbZzPackxh" runat="server" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator68" runat="server" ControlToValidate="tbZzPackxh"
                                    Display="Dynamic" ErrorMessage="请填写PACK型号" SetFocusOnError="true" Enabled="false"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr bgcolor="#ccffff" id="trGGS2" runat="server">
                            <td style="width: 60px;">
                                &nbsp;实验室</td>
                            <td colspan="4">
                                <asp:DropDownList ID="ddlSys" runat="server" Width="45%" onchange="sysChange()">
                                </asp:DropDownList>
                                <asp:TextBox ID="tbSyshqsj" runat="server" Width="45%"></asp:TextBox></td>
                            <td style="width: 60px;">
                                实验室评审交期</td>
                            <td colspan="6">
                            <asp:TextBox ID="tbSwyjjq" runat="server" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr bgcolor="#ccffff" id="trGGS3" runat="server" visible="false">
                            <td style="width: 60px; height: 39px">
                                是否需要退单</td>
                            <td colspan="4" style="height: 39px">
                                <asp:DropDownList ID="ddlSfxyth" runat="server" Width="45%" onchange="swjlChange()">
                                    <asp:ListItem>否</asp:ListItem>
                                    <asp:ListItem>是</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 60px; height: 39px">
                                退单理由</td>
                            <td colspan="6" rowspan="1">
                                <asp:TextBox ID="tbTdly" runat="server" Rows="9" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                        </tr>
                        <tr visible="false" runat="server" id="Tr5">
                            <td style="border: 0px; height: 43px;">
                            </td>
                            <td style="height: 43px; border: 0px" colspan="11" align="center">
                                <asp:ImageButton ID="iBtnOK" runat="Server" ImageUrl="~/images/btnSubmit.jpg" OnClick="btnTj_Click"
                                    OnClientClick="lbtnOK_disbale()" />
                            </td>
                        </tr>
                        <tr id="trLc1" runat="server" visible="false">
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
                                    <asp:ListItem>-</asp:ListItem>
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
                                &nbsp;</td>
                            <td style="height: 47px; width: 60px;">
                                &nbsp;</td>
                            <td style="height: 47px; width: 64px;">
                                &nbsp;</td>
                            <td style="height: 47px">
                            </td>
                        </tr>
                        <tr id="trLc2" runat="server" visible="false">
                            <td style="width: 79px; height: 47px">
                                总助</td>
                            <td style="width: 60px; height: 47px">
                                <asp:DropDownList ID="ddlZzhqzt" runat="server" Width="90%">
                                    <asp:ListItem>-</asp:ListItem>
                                    <asp:ListItem>会签中</asp:ListItem>
                                    <asp:ListItem>已会签</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 61px; height: 47px">
                                电芯工程师</td>
                            <td style="width: 60px; height: 47px">
                                <asp:DropDownList ID="ddlDxhqzt" runat="server" Width="90%">
                                    <asp:ListItem>-</asp:ListItem>
                                    <asp:ListItem>会签中</asp:ListItem>
                                    <asp:ListItem>已会签</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 61px; height: 47px">
                                PACK工程师</td>
                            <td style="width: 60px; height: 47px">
                                <asp:DropDownList ID="ddlPackhqzt" runat="server" Width="90%">
                                    <asp:ListItem>-</asp:ListItem>
                                    <asp:ListItem>会签中</asp:ListItem>
                                    <asp:ListItem>已会签</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 63px; height: 47px">
                                实验室</td>
                            <td style="width: 60px; height: 47px">
                                <asp:DropDownList ID="ddlSyshqzt" runat="server" Width="90%">
                                    <asp:ListItem>-</asp:ListItem>
                                    <asp:ListItem>会签中</asp:ListItem>
                                    <asp:ListItem>已会签</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 60px; height: 47px">
                            </td>
                            <td style="width: 60px; height: 47px">
                            </td>
                            <td style="width: 64px; height: 47px">
                            </td>
                            <td style="height: 47px">
                            </td>
                        </tr>
                    </table>
                    <div style="display: none">
                        <asp:TextBox ID="fileName" runat="server"></asp:TextBox>
                        <asp:TextBox ID="tbDjlx" runat="server"></asp:TextBox><asp:DropDownList ID="ddlHzgx"
                            runat="server">
                        </asp:DropDownList>&nbsp;&nbsp; &nbsp;&nbsp;
                        &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        <asp:CheckBox id="cbWlwdyq" runat="server" Text="物料未到延期" ></asp:CheckBox>
                        <asp:TextBox id="tbJqsm" runat="server" Width="90%"></asp:TextBox>
                        <asp:TextBox id="tbFkrq" runat="server"></asp:TextBox>
                                <asp:TextBox ID="tbLldhkhddh" runat="server" Width="90%"></asp:TextBox>
                    </div>
                </div>
            </div>
            <!--第一页结束-->
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbFhrq"
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbFhsl"
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlFhdw"
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="tbKhcsqk"
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
        </div>
        <!--divAll结束-->
    </form>
</body>
</html>
