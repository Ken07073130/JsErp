<%@ Page Language="C#" AutoEventWireup="true" CodeFile="htpsbEdit.aspx.cs" Inherits="htpsbEdit"  validateRequest="false"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>合同评审表</title>
    <link href="../swxt/css/htpsb.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
      .subTitle {
        font-size: 15px;
        font-weight: bold; 
        font-family: 微软雅黑;
        text-align:center;
      }
    </style>

    <script type="text/jscript">
        //点击显示变更日志
        function showChangeLog(){
           if(document.getElementById('aShowLog').innerHTML=="点击显示评审单变更日志"){
              document.getElementById('aShowLog').innerHTML='点击隐藏评审单变更日志';
              document.getElementById('divChangeLog').style.display='';
           } else {
              document.getElementById('aShowLog').innerHTML='点击显示评审单变更日志';
              document.getElementById('divChangeLog').style.display='none';
           }
        }
        //点击评审日志
        function showPsLog(){
           if(document.getElementById('aShowPsLog').innerHTML=="点击显示评审记录"){
              document.getElementById('aShowPsLog').innerHTML='点击隐藏评审记录';
              document.getElementById('divShowPsLog').style.display='';
           } else {
              document.getElementById('aShowPsLog').innerHTML='点击显示评审记录';
              document.getElementById('divShowPsLog').style.display='none';
           }
        }
        
        //1.PACK型号与规格书型号一致
        //2.成品类型为电芯时，清空Pack型号
        function setPackxh(){
          if(document.getElementById('ddlCplx').value=='PACK'){
            document.getElementById('tbNbpackxh').value=document.getElementById('tbGgsxh').value;
          } else if (document.getElementById('ddlCplx').value=='电芯') {
            document.getElementById('tbNbpackxh').value="";
          }
        }
        
        //不通条件触发不同的校验项目
        function Validate(controlname){
          //生产投料选是  激活投产数量必填项
          if(controlname=='ddlSctl'){
            if(document.getElementById('ddlSctl').value=='是'){
              ValidatorEnable(document.getElementById('RequiredFieldValidator10'), true);
            } else {
              ValidatorEnable(document.getElementById('RequiredFieldValidator10'), false); 
            }
            
          }
          
          //有备料是必须使用备货单号和消耗数量！
          if(controlname=='ddlDxbl'||controlname=='ddlPackbl'){
            if(document.getElementById('ddlDxbl').value=='是'||document.getElementById('ddlPackbl').value=='是'){
              ValidatorEnable(document.getElementById('RequiredFieldValidator11'), true);
              ValidatorEnable(document.getElementById('RequiredFieldValidator12'), true);
            } else {
              ValidatorEnable(document.getElementById('RequiredFieldValidator11'), false);
              ValidatorEnable(document.getElementById('RequiredFieldValidator12'), false);
            }
          }
          
          //非B品订单需填写规格书编号和规格书版本号
          if(controlname=='ddlDdlx'){
            if(document.getElementById('ddlDdlx').value=='B品订单'||document.getElementById('ddlDdlx').value=='需调整订单'){
              ValidatorEnable(document.getElementById('RequiredFieldValidator5'), false);
              ValidatorEnable(document.getElementById('RequiredFieldValidator6'), false);
            } else {
              ValidatorEnable(document.getElementById('RequiredFieldValidator5'), true);
              ValidatorEnable(document.getElementById('RequiredFieldValidator6'), true);
            }
          }
          
           //AAA开头的订单类型需要选为备货单
          if(controlname=='tbKhddh'){
             if(document.getElementById('tbKhddh').value.substring(0,3)=='AAA'){
               ValidatorEnable(document.getElementById('CompareValidator8'), true);
             } else {
               ValidatorEnable(document.getElementById('CompareValidator8'), false);
             }
          }
          
        }
        
        
        
        //签名通用 生成签名人+签名时间
        function qm(controlName){
           //签名者
           var bm=controlName.replace('ddl','').replace('psjg','');
           var hqr='tb'+bm+'hqr';
           document.getElementById(hqr).value=document.getElementById('tbUserName').value;
           var hqsj='tb'+bm+'hqsj';
           var date=new Date();
           //签名日期
           var hours=date.getHours()>9?date.getHours().toString():'0' + date.getHours().toString();
           var minutes=date.getMinutes()>9?date.getMinutes().toString():'0' + date.getMinutes().toString();
           var seconds=date.getSeconds()>9?date.getSeconds().toString():'0' + date.getSeconds().toString();
           var sj=date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate()+' '+hours+':'+minutes+':'+seconds;
           document.getElementById(hqsj).value=sj;
           //备注
           var bz='tb'+bm+'bz';
           //评审记录累加
           document.getElementById('tbPsjl').value=document.getElementById('tbPsjl').value
                                                  +document.getElementById(hqr).value+'   '
                                                  +document.getElementById(hqsj).value+'   '
                                                  //备注不用写入+document.getElementById(bz).value+'   '
                                                  +document.getElementById(controlName).value+'\n';
        }
        
        /*会签流程*/
        function lc(control){
          qm(control.name);
          var bm=control.name.replace('ddl','').replace('psjg','');
          //同意生产或者有条件通过的，流程进行流转
          if(control.value=='同意生产'||control.value=='有条件通过'){
             //PMC评审
             if(control.name=='ddlPMCpsjg'){
                if(document.getElementById('ddlGchqzt').value=='-'){
                  document.getElementById('ddlGchqzt').value='会签中';
                } 
                if(document.getElementById('ddlSbhqzt').value=='-'){
                  document.getElementById('ddlSbhqzt').value='会签中';
                } 
                if(document.getElementById('ddlZzhqzt').value=='-'){
                  document.getElementById('ddlZzhqzt').value='会签中';
                } 
                if(document.getElementById('ddlZlhqzt').value=='-'){
                  document.getElementById('ddlZlhqzt').value='会签中';
                } 
                document.getElementById('tbLchqzt').value='工程、设备、制造、质量会签';
                ValidatorEnable(document.getElementById('CompareValidator11'), true);
             }
             //工程评审
             if(control.name=='ddlGcpsjg'){
                //激活必填项
                ValidatorEnable(document.getElementById('RequiredFieldValidator8'), true);
                ValidatorEnable(document.getElementById('RequiredFieldValidator9'), true);
                ValidatorEnable(document.getElementById('RequiredFieldValidator16'), true);
                //成品类型为电芯的不需要PACK,直接到供应链
                if(document.getElementById('ddlCplx').value=='电芯'){
                    if(document.getElementById('ddlGylhqzt').value=='-'){
                      document.getElementById('ddlGylhqzt').value='会签中';
                    }
                }
                //成品类型为PACK，需要PACK会签
                else if(document.getElementById('ddlCplx').value=='PACK'){
                    if(document.getElementById('ddlPACKhqzt').value=='-'){
                     document.getElementById('ddlPACKhqzt').value='会签中';
                    }
                }
               
             }
             //PACK评审
             if(control.name=='ddlPACKpsjg'){
                if(document.getElementById('ddlGylhqzt').value=='-'){
                    document.getElementById('ddlGylhqzt').value='会签中';
                }
             }
             
             
             //设备部+制造+质量+供应链
             if(control.name=='ddlSbpsjg'||control.name=='ddlZzpsjg'||control.name=='ddlZlpsjg'||control.name=='ddlGylpsjg'){
                if(  (document.getElementById('ddlSbpsjg').value=='同意生产'||document.getElementById('ddlSbpsjg').value=='有条件通过')&&
                     (document.getElementById('ddlZzpsjg').value=='同意生产'||document.getElementById('ddlZzpsjg').value=='有条件通过')&&
                     (document.getElementById('ddlZlpsjg').value=='同意生产'||document.getElementById('ddlZlpsjg').value=='有条件通过')&&
                     (document.getElementById('ddlGylpsjg').value=='同意生产'||document.getElementById('ddlGylpsjg').value=='有条件通过')
                ){
                   if(document.getElementById('ddlZghqzt').value=='-'){
                      document.getElementById('ddlZghqzt').value='会签中';
                   }
                   if(document.getElementById('ddlSczjhqzt').value=='-'){
                      document.getElementById('ddlSczjhqzt').value='会签中';
                   }
                   document.getElementById('tbLchqzt').value='总工、生产总监会签';
                }
             }
             //设备部+制造+质量+供应链结束
             
             //生产总监+总工
             if(control.name=='ddlSczjpsjg'||control.name=='ddlZgpsjg'){
               if( (document.getElementById('ddlSczjpsjg').value=='同意生产'||document.getElementById('ddlSczjpsjg').value=='有条件通过')&&
                   (document.getElementById('ddlZgpsjg').value=='同意生产'||document.getElementById('ddlZgpsjg').value=='有条件通过')  
               ){
                   if(document.getElementById('ddlSwjlhqzt').value=='-'){
                      document.getElementById('ddlSwjlhqzt').value='会签中';
                   }
                   document.getElementById('tbLchqzt').value='商务经理会签';
               }
             }
             //生产总监+总工结束
             
             //商务经理
             if(control.name=="ddlSwjlpsjg"){
                ValidatorEnable(document.getElementById('RequiredFieldValidator14'), true);
                document.getElementById('tbLchqzt').value="已完成";
             }
             
          }
          
          //同意生产或者有条件通过的或者不同意生产的,变成已会签
          if(control.value=='同意生产'||control.value=='有条件通过'||control.value=='不同意生产'){
             var controlHqzt='ddl'+bm+'hqzt';
             document.getElementById(controlHqzt).value='已会签';
          }
          
          //判断是否是不同意变更
          var btybm='';
          if(document.getElementById('ddlPMCpsjg').value=='不同意生产') btybm='PMC'
          else if(document.getElementById('ddlGcpsjg').value=='不同意生产') btybm='工程部'
          else if(document.getElementById('ddlPACKpsjg').value=='不同意生产') btybm='PACK'
          else if(document.getElementById('ddlSbpsjg').value=='不同意生产') btybm='设备部'
          else if(document.getElementById('ddlZzpsjg').value=='不同意生产') btybm='制造部'
          else if(document.getElementById('ddlZlpsjg').value=='不同意生产') btybm='质量部'
          else if(document.getElementById('ddlGylpsjg').value=='不同意生产') btybm='供应链'
          else if(document.getElementById('ddlSczjpsjg').value=='不同意生产') btybm='生产总监'
          else if(document.getElementById('ddlZgpsjg').value=='不同意生产') btybm='总工'
          else if(document.getElementById('ddlSwjlpsjg').value=='不同意生产') btybm='商务经理';
          if(btybm!=""){
             document.getElementById('tbLchqzt').value=btybm+'不同意生产';
          }
         
          
        }
        /*会签流程结束*/
        
        //发起人变更时，判断是否需要重置流程
        //tbWorkFlowFlag=1后台需要重置流程 即lb=CHANGE
        function resetWorkFlowFlag(){
          var bb=parseFloat(document.getElementById('ddlBB').value);
          if(bb>1.0 && (document.getElementById('tbGroupName').value.indexOf("合同评审表-发起人")>=0||document.getElementById('tbGroupName').value.indexOf("超级用户")>=0)){
              var ctextbox=new Array("tbKhdm","tbNbdxxh","tbTcsl","tbDxsl","tbDdsl","tbNbbzxh","tbBbsl",
                          "tbGgsbh","tbGgsbb","tbGgsxh","tbCltx");
    
              for(var i=0;i<ctextbox.length;i++){
                 var tbControl=document.getElementById(ctextbox[i]);
                 if(tbControl.defaultValue!=tbControl.value){
                    document.getElementById('tbWorkFlowFlag').value=1;
                    document.getElementById('tbChangeControl').value = document.getElementById('tbChangeControl').value + ',' + ctextbox[i];
                 }
              }
              if( document.getElementById('tbWorkFlowFlag').value==1){
                document.getElementById('tbLchqzt').value='单据变更中';
                alert('基本信息已经被变更，此单将重新走流程');
              }
 
                  
          }
          
        
    
          
        }
        
       
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbKhyqjq" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbWspsjq" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbTlsj" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender4" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbPacksj" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender5" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbGyxfsj" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender6" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbMotzxfsj" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender7" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbGzfzxfsj" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender8" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbPACKgydecfsj" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender9" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbCldexfsj" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender10" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbGmdwsj" />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender11" runat="server" Format="yyyy-MM-dd"
            TargetControlID="tbBhbdwsj" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="200"
            EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetkhdmList" ServicePath="~/GetContent.asmx"
            TargetControlID="tbKhdm" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="200"
            EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetHtDxxhList" ServicePath="~/GetContent.asmx"
            TargetControlID="tbNbdxxh" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="tbNbpackxh"
            ServicePath="~/GetContent.asmx" ServiceMethod="GetgGgsxhList" MinimumPrefixLength="1"
            EnableCaching="true" CompletionInterval="200" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="tbGgsxh"
            ServicePath="~/GetContent.asmx" ServiceMethod="GetgGgsxhList" MinimumPrefixLength="1"
            EnableCaching="true" CompletionInterval="200" />
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" TargetControlID="tbNbbzxh"
            ServicePath="~/GetContent.asmx" ServiceMethod="GetHtDxxhList" MinimumPrefixLength="1"
            EnableCaching="true" CompletionInterval="200" />
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="true"
            EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
        </ajaxToolkit:ToolkitScriptManager>
        <div id="divPage">
            <div class="layout" style="font-size: 25px; text-align: center; font-weight: bold;">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                  ShowSummary="false"  ShowMessageBox="true" EnableClientScript="true" HeaderText="以下校验项未通过：" />
                合同评审单
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">变更理由</span><span class="spanControl"><asp:DropDownList
                        ID="ddlBgly" runat="server" Width="95%">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>客户需求变更</asp:ListItem>
                        <asp:ListItem>数据输入错误</asp:ListItem>
                        <asp:ListItem>评审内容变更</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator9" runat="server" ControlToValidate="ddlBgly"
                            Display="Dynamic" Enabled="false" ErrorMessage="请选择变更理由" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator></span> </li>
                    <li><span class="spanLabel">业务员</span><span class="spanControl"><asp:TextBox ID="tbYwy"
                        runat="server" Width="95%"></asp:TextBox></span> </li>
                    <li style="text-align: center;">  <asp:LinkButton ID="lbGetAllChange" runat="server" 
                    Style="display: inline-block; font-size: 15px; width: 100px; color: white; line-height: 25px;
                    background-color: #0099cc; text-decoration: none; text-align:center" OnClick="lbGetAllChange_Click">变更记录汇总</asp:LinkButton>
                    <a href="javascript:void(0)" style="line-height: 30px; display:none;" id="aShowLog" onclick="showChangeLog();">点击显示评审单变更日志</a></li>
                    <li><a href="javascript:void(0)" style="line-height: 30px;" id="aShowPsLog" onclick="showPsLog();">
                        点击显示评审记录</a></li>
                </ul>
            </div>
            <div class="layout" style="height:170px;  width:950px; display:none;" id="divLc" runat="server" >
                <ul>
                    <li style="height:170px;">
                        <asp:TextBox ID="tbBgsm" runat="server" Rows="6" TextMode="MultiLine" Width="221px"
                         Text="变更时请在此输入变更说明" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator10" runat="server" ControlToValidate="tbBgsm"
                            Display="Dynamic"  Enabled="false" ErrorMessage="请填写理由" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="变更时请在此输入变更说明"></asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="tbBgsm"
                            Display="Dynamic" ErrorMessage="请填写变更说明" SetFocusOnError="true" Enabled="false"></asp:RequiredFieldValidator>发起人<asp:DropDownList ID="ddlFqrhqzt" runat="server" >
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList><span style="font-size: 24pt; color: #ff3366">→</span>PMC<asp:DropDownList
                        ID="ddlPMChqzt" runat="server">
                        <asp:ListItem>会签中</asp:ListItem>
                        <asp:ListItem>已会签</asp:ListItem>
                    </asp:DropDownList><br />
                        流程会签状态<asp:TextBox ID="tbLchqzt" runat="server" Text="单据建立中"></asp:TextBox></li><li style="width: 400px;height:170px;"><span style="font-size: 24pt; color: #ff3366">
                        →</span>工程部<asp:DropDownList ID="ddlGchqzt" runat="server">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList><span style="font-size: 24pt; color: #ff3366">→</span>PACK<asp:DropDownList
                            ID="ddlPACKhqzt" runat="server">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList><span style="font-size: 24pt; color: #ff3366">→</span>供应链<span
                            style="font-size: 24pt; color: #ff3366"></span><asp:DropDownList ID="ddlGylhqzt"
                                runat="server">
                                <asp:ListItem>-</asp:ListItem>
                                <asp:ListItem>会签中</asp:ListItem>
                                <asp:ListItem>已会签</asp:ListItem>
                            </asp:DropDownList><br />
                        <span style="font-size: 24pt; color: #ff3366">→</span>设备部<asp:DropDownList ID="ddlSbhqzt"
                            runat="server">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList><br />
                        <span style="font-size: 24pt; color: #ff3366">→</span>制造部<asp:DropDownList ID="ddlZzhqzt"
                            runat="server">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList><br />
                        <span style="font-size: 24pt; color: #ff3366">→</span>质量部<asp:DropDownList ID="ddlZlhqzt"
                            runat="server">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList></li><li style="width: 152px;height:170px;"><span style="font-size: 24pt; color: #ff3366">
                            →</span>生产总监<asp:DropDownList ID="ddlSczjhqzt" runat="server">
                                <asp:ListItem>-</asp:ListItem>
                                <asp:ListItem>会签中</asp:ListItem>
                                <asp:ListItem>已会签</asp:ListItem>
                            </asp:DropDownList><br />
                            <span style="font-size: 24pt; color: #ff3366">→</span>总工<asp:DropDownList ID="ddlZghqzt"
                                runat="server">
                                <asp:ListItem>-</asp:ListItem>
                                <asp:ListItem>会签中</asp:ListItem>
                                <asp:ListItem>已会签</asp:ListItem>
                            </asp:DropDownList></li><li style="width: 152px;height:170px;"><span style="font-size: 24pt; color: #ff3366">
                                →</span>商务部<asp:DropDownList ID="ddlSwjlhqzt" runat="server">
                                    <asp:ListItem>-</asp:ListItem>
                                    <asp:ListItem>会签中</asp:ListItem>
                                    <asp:ListItem>已会签</asp:ListItem>
                                </asp:DropDownList></li></ul>
            </div>
            <div class="layout" id="divChangeLog" style="display: none;">
                &nbsp;
                <asp:TextBox ID="tbLsls" runat="server" Rows="8" TextMode="MultiLine" Width="80%"></asp:TextBox></div>
            <div class="layout" id="divShowPsLog" style="display: none;">
                评审记录
                <asp:TextBox ID="tbPsjl" runat="server" Rows="8" TextMode="MultiLine" Width="88%"></asp:TextBox></div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">评审单号</span><span class="spanControl"><asp:TextBox ID="tbBh"
                        runat="server" Width="95%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">版本</span><span class="spanControl"><asp:DropDownList
                        ID="ddlBB" runat="server" Width="95%" AutoPostBack="True" OnSelectedIndexChanged="ddlBB_SelectedIndexChanged">
                    </asp:DropDownList></span> </li>
                    <li><span class="spanLabel">制表人</span><span class="spanControl"><asp:TextBox ID="tbZbr"
                        runat="server" Width="95%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">制表日期</span><span class="spanControl"><asp:TextBox ID="tbJbrq"
                        runat="server" Width="95%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 474px; line-height: 30px;" class="subTitle">订单基本信息</li>
                    <li style="line-height: 30px;" class="subTitle">产品基本信息</li>
                    <li style="line-height: 30px;" class="subTitle">投料基本信息</li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >订单类型＊</span><span class="spanControl"><asp:DropDownList
                        ID="ddlDdlx" runat="server" Width="95%" onchange="Validate(this.name)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>生产订单</asp:ListItem>
                        <asp:ListItem>备货订单</asp:ListItem>
                        <asp:ListItem>B品订单</asp:ListItem>
                        <asp:ListItem>需调整订单</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlDdlx"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择订单类型" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator>
                        <asp:CompareValidator ID="CompareValidator8" runat="server" ControlToValidate="ddlDdlx"  Enabled="false"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="AAA开头的订单类型需要选为备货单" Operator="Equal"
                            SetFocusOnError="true" Type="string" ValueToCompare="备货订单"></asp:CompareValidator></span> </li>
                    <li><span class="spanLabel">订单拆分</span><span class="spanControl"><asp:DropDownList
                        ID="ddlDdcf" runat="server" Width="95%" OnSelectedIndexChanged="ddlDdcf_SelectedIndexChanged" >
                        <asp:ListItem>否</asp:ListItem>
                        <asp:ListItem>是</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="请勿提交重复订单" OnServerValidate="CustomValidator1_ServerValidate" Display="Dynamic"></asp:CustomValidator></span> </li>
                    <li><span class="spanLabel" >成品类型＊</span><span class="spanControl"><asp:DropDownList
                        ID="ddlCplx" runat="server" Width="95%" onchange="setPackxh()" OnSelectedIndexChanged="dropdownlistChange">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>电芯</asp:ListItem>
                        <asp:ListItem>PACK</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="ddlCplx"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择成品类型" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator></span> </li>
                    <li><span class="spanLabel" >生产投料＊</span><span class="spanControl"><asp:DropDownList
                        ID="ddlSctl" runat="server" Width="95%" onchange="Validate(this.name)" OnSelectedIndexChanged="dropdownlistChange">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>是</asp:ListItem>
                        <asp:ListItem>否</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator7" runat="server" ControlToValidate="ddlSctl"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择生产投料" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >客户订单号＊</span><span class="spanControl"><asp:TextBox ID="tbKhddh"
                        runat="server" Width="95%" onchange="Validate(this.name)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbKhddh"
                            Display="Dynamic" ErrorMessage="请填写客户订单号" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel" >客户代码＊</span><span class="spanControl"><asp:TextBox ID="tbKhdm"
                        runat="server" Width="95%" AutoPostBack="True" OnTextChanged="tbKhdm_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbKhdm"
                            Display="Dynamic" ErrorMessage="请填写客户代码" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </span></li>
                    <li><span class="spanLabel">内部电芯型号</span><span class="spanControl"><asp:TextBox ID="tbNbdxxh"
                        runat="server" Width="95%" AutoPostBack="True" OnTextChanged="tbNbdxxh_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="tbNbdxxh"
                            Display="Dynamic" ErrorMessage="请填写内部电芯型号" SetFocusOnError="true" Enabled="false"></asp:RequiredFieldValidator></span>&nbsp; </li>
                    <li><span class="spanLabel" >投产数量</span><span class="spanControl"><asp:TextBox ID="tbTcsl"
                        runat="server" Width="50%"></asp:TextBox>
                        <asp:DropDownList ID="ddlDw2" runat="server" Width="40%">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="tbTcsl"
                            Display="Dynamic" Enabled="false" ErrorMessage="有生产投料需要填写投产数量" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >电芯数量＊</span><span class="spanControl"><asp:TextBox ID="tbDxsl"
                        runat="server" Width="50%"></asp:TextBox>&nbsp;<asp:DropDownList ID="ddlDw4" runat="server"
                            Width="40%">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbDxsl"
                            Display="Dynamic" ErrorMessage="请填写电芯数量" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel" >订单数量＊</span><span class="spanControl"><asp:TextBox ID="tbDdsl"
                        runat="server" Width="50%"></asp:TextBox>&nbsp;<asp:DropDownList ID="ddlDw" runat="server"
                            Width="40%">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbDdsl"
                            Display="Dynamic" ErrorMessage="请填写订单数量" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel">内部包装型号</span><span class="spanControl"><asp:TextBox ID="tbNbbzxh"
                        runat="server" Width="95%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="tbNbbzxh"
                            Display="Dynamic" ErrorMessage="请填写内部包装型号" SetFocusOnError="true" Enabled="false"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel"></span><span class="spanControl">&nbsp; </span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >备品数量＊</span><span class="spanControl"><asp:TextBox ID="tbBbsl"
                        runat="server" Width="50%"></asp:TextBox>&nbsp;<asp:DropDownList ID="ddlDw1" runat="server"
                            Width="40%">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList></span> </li>
                    <li><span class="spanLabel">客户要求交期</span><span class="spanControl"><asp:TextBox ID="tbKhyqjq"
                        runat="server" Width="95%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="tbKhyqjq"
                            Display="Dynamic" ErrorMessage="请填写客户要求交期" SetFocusOnError="true" ></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel">电芯容量</span><span class="spanControl"><asp:TextBox ID="tbDxrl"
                        runat="server" Width="40%"></asp:TextBox>
                        <asp:TextBox ID="tbDxdm" runat="server" Width="30%"></asp:TextBox></span>
                    </li>
                    <li><span class="spanLabel">电芯备货</span><span class="spanControl"><asp:DropDownList
                        ID="ddlDxbl" runat="server" Width="95%" onchange="Validate(this.name)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>是</asp:ListItem>
                        <asp:ListItem>否</asp:ListItem>
                    </asp:DropDownList></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >规格书编号＊</span><span class="spanControl"><asp:TextBox ID="tbGgsbh"
                        runat="server" Width="95%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbGgsbh"
                            Display="Dynamic" ErrorMessage="请填写规格书编号" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel">我司评审交期</span><span class="spanControl"><asp:TextBox ID="tbWspsjq"
                        runat="server" Width="95%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="tbWspsjq"
                            Display="Dynamic" ErrorMessage="请填写我司评审交期" SetFocusOnError="true" Enabled="false"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel">内部PACK型号</span><span class="spanControl"><asp:TextBox
                        ID="tbNbpackxh" runat="server" Width="95%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">PACK备货</span><span class="spanControl"><asp:DropDownList
                        ID="ddlPackbl" runat="server" Width="95%" onchange="Validate(this.name)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>是</asp:ListItem>
                        <asp:ListItem>否</asp:ListItem>
                    </asp:DropDownList></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >规格书版本号＊</span><span class="spanControl"><asp:TextBox ID="tbGgsbb"
                        runat="server" Width="95%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbGgsbb"
                            Display="Dynamic" ErrorMessage="请填写规格书版本" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel" >规格书型号＊</span><span class="spanControl">
                        <asp:TextBox ID="tbGgsxh" runat="server" Width="95%" onchange="setPackxh()" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="tbGgsxh"
                            Display="Dynamic" ErrorMessage="请填写规格书型号" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel">工艺路线</span><span class="spanControl"><asp:DropDownList
                        ID="ddlGylx" runat="server" Font-Size="10px">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>手工制片+手工卷绕</asp:ListItem>
                        <asp:ListItem>手工制片+半自动卷绕</asp:ListItem>
                        <asp:ListItem>制片机+半自动卷绕</asp:ListItem>
                        <asp:ListItem>制片机+手工卷绕</asp:ListItem>
                        <asp:ListItem>制片机+全自动卷绕</asp:ListItem>
                    </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator11" runat="server" ControlToValidate="ddlGylx"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择工艺路线" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择" Enabled="false"></asp:CompareValidator></span> </li>
                    <li><span class="spanLabel">备货单号</span><span class="spanControl"><asp:TextBox ID="tbBhdh"
                        runat="server" Width="95%"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="tbBhdh"
                            Display="Dynamic" Enabled="false" ErrorMessage="有备料时请填写备货单号" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel"></span><span class="spanControl"></span> </li>
                    <li><span class="spanLabel" >客户型号＊</span><span class="spanControl"><asp:TextBox ID="tbKhxh"
                        runat="server" Width="95%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">材料体系</span><span class="spanControl"><asp:TextBox ID="tbCltx"
                        runat="server" Width="95%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="tbCltx"
                            Display="Dynamic" ErrorMessage="请填写材料体系" SetFocusOnError="true" Enabled="false"></asp:RequiredFieldValidator></span> </li>
                    <li><span class="spanLabel">消耗备货单数</span><span class="spanControl"><asp:TextBox ID="tbBhsl"
                        runat="server" Width="50%"></asp:TextBox>
                        <asp:DropDownList ID="DropDownList3"
                            runat="server" Width="40%">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="tbBhsl"
                            Display="Dynamic" Enabled="false" ErrorMessage="有备料时请填写消耗数量" SetFocusOnError="true"></asp:RequiredFieldValidator></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >ROHS要求＊</span><span class="spanControl"><asp:DropDownList
                        ID="ddlRohs" runat="server" Width="95%">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>有</asp:ListItem>
                        <asp:ListItem>无</asp:ListItem>
                    </asp:DropDownList><asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlRohs"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择ROHS要求" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator></span></li><li><span class="spanLabel" >无卤要求＊</span><span class="spanControl"><asp:DropDownList
                        ID="ddlWlyq" runat="server" Width="95%">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>有</asp:ListItem>
                        <asp:ListItem>无</asp:ListItem>
                    </asp:DropDownList><asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlWlyq"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择无卤要求" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator></span> </li>
                    <li><span class="spanLabel">出货包装代码</span><span class="spanControl"><asp:TextBox ID="tbChbzdm"
                        runat="server" Width="95%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel"></span><span class="spanControl"></span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" >HSF要求＊</span><span class="spanControl"><asp:DropDownList
                        ID="ddlHSFyq" runat="server" Width="95%">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>有</asp:ListItem>
                        <asp:ListItem>无</asp:ListItem>
                    </asp:DropDownList><asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlHSFyq"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择HSF要求" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator></span> </li>
                    <li><span class="spanLabel" >REACH要求＊</span><span class="spanControl"><asp:DropDownList
                        ID="ddlReach" runat="server" Width="95%">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>有</asp:ListItem>
                        <asp:ListItem>无</asp:ListItem>
                    </asp:DropDownList><asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="ddlReach"
                            Display="Dynamic" EnableTheming="true" ErrorMessage="请选择Reach要求" Operator="NotEqual"
                            SetFocusOnError="true" Type="string" ValueToCompare="请选择"></asp:CompareValidator></span></li><li><span class="spanLabel"></span><span class="spanControl"></span></li>
                    <li><span class="spanLabel">库存出货</span><span class="spanControl"><asp:TextBox ID="tbKcch"
                        runat="server" Width="50%"></asp:TextBox>
                        <asp:DropDownList ID="ddlDw3" runat="server"
                            Width="40%">
                            <asp:ListItem>PCS</asp:ListItem>
                            <asp:ListItem>组</asp:ListItem>
                        </asp:DropDownList></span></li></ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 950px; height: 90px;"><span class="spanLabel">备注</span><span class="spanControl"
                        style="width: 850px;"><asp:TextBox ID="tbQt" runat="server" Width="100%" Rows="5"
                            TextMode="MultiLine"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div style="text-align: center; font-size: 25px; font-weight: bold; width: 950px;">
                ↓</div>
            <!--商务会签-->
            <div style="width: 950px; border: 2px solid #99CCFF;"  runat="server" id="divPMChq">
                <div>
                    <span class="swSpanLabel">商业可行性</span> <span class="swSpanControl">
                        <asp:DropDownList ID="ddlSykxx" runat="server" Width="95%">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>满足</asp:ListItem>
                            <asp:ListItem>不满足</asp:ListItem>
                        </asp:DropDownList></span> <span class="swSpanLabel">规格书</span><span class="swSpanControl">
                            <asp:DropDownList ID="ddlGgssfqh" runat="server" Width="95%">
                                <asp:ListItem>请选择</asp:ListItem>
                                <asp:ListItem>已签回</asp:ListItem>
                                <asp:ListItem>未签回</asp:ListItem>
                            </asp:DropDownList></span><span class="swSpanLabel">首次生产</span><span class="swSpanControl"><asp:DropDownList
                                ID="ddlScsc" runat="server" Width="95%">
                                <asp:ListItem>请选择</asp:ListItem>
                                <asp:ListItem>是</asp:ListItem>
                                <asp:ListItem>否</asp:ListItem>
                            </asp:DropDownList></span><span class="swSpanLabel">投料时间</span><span class="swSpanControl"><asp:TextBox
                                ID="tbTlsj" runat="server" Width="95%"></asp:TextBox></span> <span class="swSpanLabel">
                                    老化时间</span><span class="swSpanControl"><asp:DropDownList ID="ddlLhsj" runat="server"
                                        Width="95%">
                                        <asp:ListItem>请选择</asp:ListItem>
                                        <asp:ListItem>有</asp:ListItem>
                                        <asp:ListItem>无</asp:ListItem>
                                    </asp:DropDownList></span><span class="swSpanLabel">PACK时间</span><span class="swSpanControl"><asp:TextBox
                                        ID="tbPacksj" runat="server" Width="95%"></asp:TextBox></span>
                </div>
                <div style="margin-top: 5px;">
                    <span style="width: 60px; text-align: center; display: inline-block; fonr">商务备注</span><span
                        style="width: 620px; display: inline-block;">
                        <asp:TextBox ID="tbPMCbz" runat="server" Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox></span>
                    <span style="display: inline-block; width: 260px; border: 1px solid #99CCFF;">
                        <ul style="list-style: none; margin: 0px;">
                            <li><span class="spanLabel">PMC评审结果</span><asp:DropDownList ID="ddlPMCpsjg" runat="server"
                                Width="120px" onchange="lc(this)">
                                <asp:ListItem>请选择</asp:ListItem>
                                <asp:ListItem>同意生产</asp:ListItem>
                                <asp:ListItem>不同意生产</asp:ListItem>
                                <asp:ListItem>有条件通过</asp:ListItem>
                                <asp:ListItem>处理中</asp:ListItem>
                            </asp:DropDownList></li>
                            <li><span class="spanLabel">PMC会签人</span><asp:TextBox ID="tbPMChqr" runat="server" Width="117px"></asp:TextBox>
                            </li>
                            <li><span class="spanLabel">PMC会签时间</span><asp:TextBox ID="tbPMChqsj" runat="server"
                                Width="117px"></asp:TextBox></li>
                        </ul>
                    </span>
                </div>
            </div>
            <!--商务会签结束-->
            <div style="text-align: center; font-size: 25px; font-weight: bold; width: 950px;">
                ↓</div>
            <!--主体部门会签-->
            <div style="border: 2px solid #99CCFF; width: 950px;" >
                <span class="spanSh" style="width: 360px;" runat="server" id="spanGchq"><span class="subTitle">工程部</span>
                    <ul>
                        <li style="width: 355px;"><span class="gcSpanLabel">工艺下发时间</span><span class="gcSpanControl"><asp:TextBox
                            ID="tbGyxfsj" runat="server" Width="95%"></asp:TextBox></span><span class="gcSpanLabel">量产可行性</span><span
                                class="gcSpanControl"><asp:DropDownList ID="ddlLckxx" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>是</asp:ListItem>
                                    <asp:ListItem>否</asp:ListItem>
                                </asp:DropDownList></span></li>
                        <li style="width: 355px;"><span class="gcSpanLabel">模具图纸下发时间</span><span class="gcSpanControl"><asp:TextBox
                            ID="tbMotzxfsj" runat="server" Width="95%"></asp:TextBox></span><span class="gcSpanLabel">工艺路线可行性</span><span
                                class="gcSpanControl"><asp:DropDownList ID="ddlGylxkxx" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>是</asp:ListItem>
                                    <asp:ListItem>否</asp:ListItem>
                                </asp:DropDownList></span></li>
                        <li style="width: 355px;"><span class="gcSpanLabel">工装图纸下发时间</span><span class="gcSpanControl"><asp:TextBox
                            ID="tbGzfzxfsj" runat="server" Width="95%"></asp:TextBox></span><span class="gcSpanLabel">是否有未结案问题</span><span
                                class="gcSpanControl"><asp:DropDownList ID="ddlSfywjawt" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>是</asp:ListItem>
                                    <asp:ListItem>否</asp:ListItem>
                                </asp:DropDownList></span></li>
                        <li style="width: 355px;"><span style="float: left">&nbsp; 材料定额下发时间<asp:TextBox ID="tbCldexfsj"
                            runat="server" Width="70px"></asp:TextBox></span></li>
                        <li style="width: 355px; height: 60px;">
                            <asp:TextBox ID="tbGcbz" runat="server" Width="90%" Rows="3" TextMode="MultiLine"
                                Style="margin-top: 3px;"></asp:TextBox></li>
                        <li>工程评审结果<asp:DropDownList ID="ddlGcpsjg" runat="server" onchange="lc(this)">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>同意生产</asp:ListItem>
                            <asp:ListItem>不同意生产</asp:ListItem>
                            <asp:ListItem>有条件通过</asp:ListItem>
                            <asp:ListItem>处理中</asp:ListItem>
                        </asp:DropDownList></li>
                        <li>工程会签人<asp:TextBox ID="tbGchqr" runat="server" Width="100px"></asp:TextBox>
                        </li>
                        <li>工程会签时间<asp:TextBox ID="tbGchqsj" runat="server" Width="90px"></asp:TextBox></li>
                        <li></li>
                        <li style="width: 355px; font-size: 25px; font-weight: bold; border: 0px;">↓</li>
                        <li style="width: 355px;" class="subTitle">技术PACK</li>
                        <li>PACK工艺</li><li>
                            <asp:DropDownList ID="ddlPACKmzyq" runat="server">
                                <asp:ListItem>请选择</asp:ListItem>
                                <asp:ListItem>能满足需求</asp:ListItem>
                                <asp:ListItem>不能满足需求</asp:ListItem>
                            </asp:DropDownList></li><li>PACK工艺定额下发时间</li><li>
                                <asp:TextBox ID="tbPACKgydecfsj" runat="server" Width="100px"></asp:TextBox></li>
                        <li style="width: 355px; height: 85px;">
                            <asp:TextBox ID="tbPACKbz" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></li><li>
                                PACK评审结果<asp:DropDownList ID="ddlPACKpsjg" runat="server"  onchange="lc(this)">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>同意生产</asp:ListItem>
                                    <asp:ListItem>不同意生产</asp:ListItem>
                                    <asp:ListItem>有条件通过</asp:ListItem>
                                    <asp:ListItem>处理中</asp:ListItem>
                                </asp:DropDownList></li>
                        <li>PACK会签人<asp:TextBox ID="tbPACKhqr" runat="server" Width="100px"></asp:TextBox></li>
                        <li>PACK会签时间<asp:TextBox ID="tbPACKhqsj" runat="server" Width="90px"></asp:TextBox></li>
                        <li></li>
                    </ul>
                </span><span class="spanSh" runat="server" id="spanSbhq"><span class="subTitle">设备部</span>
                    <ul>
                        <li>设备情况<asp:DropDownList ID="ddlSbnfmz" runat="server">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>能满足需求</asp:ListItem>
                            <asp:ListItem>不能满足需求</asp:ListItem>
                        </asp:DropDownList></li><li style="height: 125px;">
                            <asp:TextBox ID="tbSbbz" runat="server" Rows="7" TextMode="MultiLine" Width="95%"></asp:TextBox></li>
                        <li>设备评审结果<asp:DropDownList ID="ddlSbpsjg" runat="server"  onchange="lc(this)" >
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>同意生产</asp:ListItem>
                            <asp:ListItem>不同意生产</asp:ListItem>
                            <asp:ListItem>有条件通过</asp:ListItem>
                            <asp:ListItem>处理中</asp:ListItem>
                        </asp:DropDownList></li><li>设备会签人 &nbsp;<asp:TextBox ID="tbSbhqr" runat="server"
                            Width="90px"></asp:TextBox></li><li>设备会签时间<asp:TextBox ID="tbSbhqsj" runat="server"
                                Width="90px"></asp:TextBox></li><li style="border: 0px; margin-top: 100px; font-size: 40px;
                                    font-weight: bold;">→</li></ul>
                </span><span class="spanSh" runat="server" id="spanZlhq" ><span class="subTitle">质量部</span><ul>
                    <li>是否品质异常<asp:DropDownList ID="ddlYwpzyc" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>是</asp:ListItem>
                        <asp:ListItem>否</asp:ListItem>
                    </asp:DropDownList></li><li style="height: 125px;">
                        <asp:TextBox ID="tbZlbz" runat="server" Rows="7" TextMode="MultiLine" Width="95%"></asp:TextBox></li>
                    <li>质量评审结果<asp:DropDownList ID="ddlZlpsjg" runat="server"  onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意生产</asp:ListItem>
                        <asp:ListItem>不同意生产</asp:ListItem>
                        <asp:ListItem>有条件通过</asp:ListItem>
                        <asp:ListItem>处理中</asp:ListItem>
                    </asp:DropDownList></li><li>质量会签人 &nbsp;<asp:TextBox ID="tbZlhqr" runat="server" Width="90px"></asp:TextBox></li><li>
                        质量会签时间<asp:TextBox ID="tbZlhqsj" runat="server" Width="90px"></asp:TextBox></li></ul>
                    <ul runat="server" id="ulGylhq">
                    <li style="width: 355px; margin-top: 30px;" class="subTitle">供应链管理部</li>
                    <li style="width: 355px;"><span style="width: 177px; display: inline-block;">隔膜到位时间<asp:TextBox
                        ID="tbGmdwsj" runat="server" Width="80px"></asp:TextBox></span> <span style="width: 170px;
                            display: inline-block;">保护板到位时间<asp:TextBox ID="tbBhbdwsj" runat="server" Width="75px"></asp:TextBox></span></li>
                    <li style="width: 355px;"><span style="float: left">&nbsp;无法满足交期的物料<asp:TextBox ID="tbWfmzjq"
                        runat="server" Width="230px"></asp:TextBox></span></li>
                    <li style="width: 355px; height: 85px;">
                        <asp:TextBox ID="tbGylbz" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></li><li
                            style="width: 355px;"><span style="width: 180px;">供应链评审结果<asp:DropDownList ID="ddlGylpsjg"
                                runat="server"  onchange="lc(this)">
                                <asp:ListItem>请选择</asp:ListItem>
                                <asp:ListItem>同意生产</asp:ListItem>
                                <asp:ListItem>不同意生产</asp:ListItem>
                                <asp:ListItem>有条件通过</asp:ListItem>
                                <asp:ListItem>处理中</asp:ListItem>
                            </asp:DropDownList></span><span style="width: 180px;">供应链会签人<asp:TextBox ID="tbGylhqr"
                                runat="server" Width="100px"></asp:TextBox></span></li>
                    <li style="width: 355px;"><span style="float: left">供应链会签时间<asp:TextBox ID="tbGylhqsj"
                        runat="server" Width="90px"></asp:TextBox></span> </li>
                </ul>
                </span><span class="spanSh" runat="server" id="spanZzhq"><span class="subTitle">制造部</span><ul>
                    <li>产能是否有问题<asp:DropDownList ID="ddlCnwt" runat="server">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>是</asp:ListItem>
                        <asp:ListItem>否</asp:ListItem>
                    </asp:DropDownList></li><li style="height: 125px;">
                        <asp:TextBox ID="tbZzbz" runat="server" Rows="7" TextMode="MultiLine" Width="95%"></asp:TextBox></li>
                    <li>制造评审结果<asp:DropDownList ID="ddlZzpsjg" runat="server"  onchange="lc(this)">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>同意生产</asp:ListItem>
                        <asp:ListItem>不同意生产</asp:ListItem>
                        <asp:ListItem>有条件通过</asp:ListItem>
                        <asp:ListItem>处理中</asp:ListItem>
                    </asp:DropDownList></li><li>制造会签人 &nbsp;<asp:TextBox ID="tbZzhqr" runat="server"
                        Width="90px"></asp:TextBox></li><li>制造会签时间<asp:TextBox ID="tbZzhqsj" runat="server"
                            Width="90px"></asp:TextBox></li></ul>
                </span>
            </div>
            <!--主体部门会签结束-->
            <div style="text-align: center; font-size: 25px; font-weight: bold; width: 950px;">
                ↓</div>
            <!--生产总监、总工、商务评审结果-->
            <div style="border: 1px solid #99CCFF; width: 950px;">
                <div class="layout">
                    <ul>
                        <li style="height: 90px;" >
                            <asp:TextBox ID="tbSczjbz" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></li>
                        <li style="height: 90px; margin-left: 20px">
                            <asp:TextBox ID="tbZgbz" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></li>
                        <li style="width: 215px; border: 0px;">&nbsp</li>
                        <li style="height: 90px;">
                            <asp:TextBox ID="tbSwjlbz" runat="server" Rows="5" TextMode="MultiLine" Width="95%"></asp:TextBox></li><li runat="server" id="liSczjhq">
                                <span class="spanLabel">生产总监评审</span><span class="spanControl"><asp:DropDownList
                                    ID="ddlSczjpsjg" runat="server" Width="120px"  onchange="lc(this)" >
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>同意生产</asp:ListItem>
                                    <asp:ListItem>不同意生产</asp:ListItem>
                                    <asp:ListItem>有条件通过</asp:ListItem>
                                    <asp:ListItem>处理中</asp:ListItem>
                                </asp:DropDownList></span></li>
                        <li style="margin-left: 20px"  runat="server" id="liZghq" ><span class="spanLabel">总工评审</span><span class="spanControl"><asp:DropDownList
                            ID="ddlZgpsjg" runat="server" Width="120px"  onchange="lc(this)">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>同意生产</asp:ListItem>
                            <asp:ListItem>不同意生产</asp:ListItem>
                            <asp:ListItem>有条件通过</asp:ListItem>
                            <asp:ListItem>处理中</asp:ListItem>
                        </asp:DropDownList></span></li>
                        <li style="width: 215px; border: 0px;  font-size:23px;  font-weight:bold; text-align:center;">
                            →</li>
                        <li  runat="server" id="liSwjlhq"><span class="spanLabel">商务经理评审</span><span class="spanControl"><asp:DropDownList
                            ID="ddlSwjlpsjg" runat="server" Width="120px"  onchange="lc(this)">
                            <asp:ListItem>请选择</asp:ListItem>
                            <asp:ListItem>同意生产</asp:ListItem>
                            <asp:ListItem>不同意生产</asp:ListItem>
                            <asp:ListItem>有条件通过</asp:ListItem>
                            <asp:ListItem>处理中</asp:ListItem>
                        </asp:DropDownList></span></li><li><span class="spanLabel">生产总监签字</span><span class="spanControl"><asp:TextBox
                            ID="tbSczjhqr" runat="server" Width="120px"></asp:TextBox></span></li>
                        <li style="margin-left: 20px"><span class="spanLabel">总工签字</span><span class="spanControl"><asp:TextBox
                            ID="tbZghqr" runat="server" Width="120px"></asp:TextBox></span></li>
                        <li style="width: 215px; border: 0px;">&nbsp</li>
                        <li><span class="spanLabel">商务经理签字</span><span class="spanControl"><asp:TextBox ID="tbSwjlhqr"
                            runat="server" Width="120px"></asp:TextBox></span></li><li><span class="spanLabel">审核时间</span><span
                                class="spanControl"><asp:TextBox ID="tbSczjhqsj" runat="server" Width="120px"></asp:TextBox></span></li>
                        <li style="margin-left: 20px"><span class="spanLabel">审核时间</span><span class="spanControl"><asp:TextBox
                            ID="tbZghqsj" runat="server" Width="120px"></asp:TextBox></span></li>
                        <li style="width: 215px; border: 0px;">&nbsp</li>
                        <li><span class="spanLabel">审核时间</span><span class="spanControl"><asp:TextBox ID="tbSwjlhqsj"
                            runat="server" Width="120px"></asp:TextBox></span></li></ul>
                </div>
                <div style="border: 1px solid #99CCFF; width: 950px; text-align:center;">
                <asp:LinkButton style="DISPLAY: inline-block; FONT-SIZE: 15px; WIDTH: 80px; COLOR: white; LINE-HEIGHT: 28px; BACKGROUND-COLOR: #0099cc; TEXT-DECORATION: none" id="lbSubmit" onclick="lbSubmit_Click" runat="server" OnClientClick="resetWorkFlowFlag()">提交</asp:LinkButton>
                </div>
            </div>
        </div>
        
        <div style="display:none">
            <asp:TextBox ID="tbUserName" runat="server"></asp:TextBox>
            <asp:TextBox ID="tbGroupName" runat="server"></asp:TextBox>
            <asp:TextBox ID="tbWorkFlowFlag" runat="server" Rows="2" TextMode="MultiLine"></asp:TextBox>
            <asp:TextBox ID="tbChangeControl" runat="server"></asp:TextBox>
             
         </div>
    </form>
</body>
</html>
