<%@ Page Language="C#" CodeFile="ksdPrint.aspx.cs" Inherits="ksd_Print"    Culture="auto" UICulture="auto"  Title="客诉单打印"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" >
    <%--信息补全控件--%>
    &nbsp; &nbsp;<%--日期选择控件--%>

                       
<title>客诉单内容</title>&nbsp; &nbsp; &nbsp;&nbsp;
    <style type="text/css">

    .T_Sample1 {
        border-collapse: collapse;
        border: none;
        background: #DDF3FF;
        bgcolor:#DDF3FF;
        font-size:14px;
         
      
    }
    .T_Sample1 th {
        border: solid 1px #707070;
    }
    .T_Sample1 td {
        border: solid 1px #707070;
    }
    
    .T_Sample2 {
        border-collapse: collapse;
        border: none;
        background: #DDF3FF;
        bgcolor:#DDF3FF;
        font-size:14px;
      
    }
    .T_Sample2 th {
        border: solid 1px #707070;
	  
	  
    }
    .T_Sample2 td {
	    border: solid 1px #707070;
	    height:40px;
	    text-align: center;
	    vertical-align: middle;
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
    #divNav {
        position:fixed;
        left:200px;
        right:0px;
        width:310px;
        /*background-color:#000;*/
        margin-left:auto;
        margin-right:auto;
    }
    #divTab1{
        display:block;
        margin-top:55px;
    }
    
    .div2{  width:300px; 
	    height:40px;
	    size:12px; 
	    float:left;
	    line-height:42px;
	    over-flow: hidden;
	    color: #fef4e9;  
	    border: solid 1px #b45b3e;  
	    background: #b45b3e;  
	     }  
    #divTab2{
        display:none;
        }
    .checkNum{
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
    <form id="form1" runat="server">
              <table   border="1" cellpadding="2" cellspacing="0" class="T_Sample1" width="800px"  style="text-align:left;"  align="center" >
                <tr>
                    <td colspan="8" style="height: 50px; font-size:20px; text-align: center; font-weight:bolder;" >
                      <table border="0" cellspacing="0" cellpadding="0" class=""  width="100%" height="100%"   >
                          <tr  >
                              <td style="height: 50px; width: 30%; border:0; text-align:left;"  ><img  src="../images/FP_LOGO.GIF" height="50px"/></td>
                              <td style="height: 50px;border:0;width:40%;" >质量投诉处理单<asp:Button ID="B_print" class="noprint" runat="server" Text="打印" OnClientClick="cpkftaPrint()" OnClick="B_print_Click" />
                               <%--<input id="Button1"  onclick="" type="button" value="打印" />--%>
                              </td>
                              <td style="height: 50px;border:0;width:30%;font-size:12px; text-align:right; vertical-align:bottom;" >GPT/F17-01/E
                              </td>
                          </tr>
                      </table>
                    </td>
                </tr>
                            <tr>

                              <td rowspan="8" style="width: 60px; text-align:center">
                              
                                投<br />
                                诉<br />
                                信<br />
                                息<br />
                                描<br />
                                述</td>
                              <td  style="width: 120px;" >客诉编号：</td>
                              <td colspan="2" style="width: 203px;"><asp:TextBox ID="tb_tsbh" runat="server" ></asp:TextBox></td>
                              <td style="width: 104px;">产品批号：</td>
                              <td style="width: 315px;" colspan="3"><asp:TextBox ID="tb_cpph" runat="server" Width="200px" onchange="javascript:pccz(this.value);"></asp:TextBox></td>
                              
                            </tr>
                            <tr>
                                <td >客户代码：</td>
                                <td colspan="2" style="width: 203px;"> <asp:TextBox ID="tb_khdm" runat="server"   onchange="this.value=this.value.split('|')[0];" ></asp:TextBox>
                                     </td>
                                <td style="width: 107px">产品型号：</td>
                                <td colspan="3" style="text-align:left " ><asp:TextBox ID="tb_cpxh" runat="server" Width="200px" ></asp:TextBox>
                                </td>

                            </tr>
                            <tr>
                                <td >出货数量：</td>
                                <td colspan="2" style="width: 203px;"><asp:TextBox ID="tb_chsl" runat="server"></asp:TextBox></td>
                                <td style="width: 107px" >出货日期：</td>
                                <td style="width: 112px" ><asp:TextBox ID="tb_chrq" runat="server" Width="100px" ></asp:TextBox></td>
                                <td colspan="2" >&nbsp;      </td>
                            </tr>
                            <tr>
                                <td>客户投诉信息描述：</td>
                                <td colspan="6"><asp:TextBox ID="tb_tsxxms" runat="server" Height="50px" Width="601px" TextMode="MultiLine" ></asp:TextBox></td>
                            </tr>
                 <tr>
                   <td >投诉类型：</td>
                   <td colspan="2" style="width: 203px;">
                       <asp:RadioButtonList ID="RB_tslx" runat="server"  RepeatColumns="2" Width="120px"  >
                       <asp:ListItem  Selected="True">批量</asp:ListItem>
                       <asp:ListItem >样品</asp:ListItem>
                       </asp:RadioButtonList>
                   
                    </td>
                   <td style="width: 107px" >客诉日期：</td>
                   <td style="width: 112px" >
                     <asp:TextBox ID="tb_tsrq" runat="server" Width="100px"></asp:TextBox>
                   </td>
                     <td colspan="2" >&nbsp;</td>
                 </tr>
                 <tr>
                   <td >客户退货：</td>
                   <td colspan="2" style="width: 203px" >
                   <asp:RadioButtonList ID="RB_khth" runat="server"  RepeatColumns="2" Width="120px">
                       <asp:ListItem Selected="True" >YES</asp:ListItem>
                       <asp:ListItem >NO</asp:ListItem>
                    </asp:RadioButtonList>
                    </td>
                   <td style="width: 107px" >数量:</td>
                   <td style="width: 112px" ><asp:TextBox ID="tb_thsl" runat="server" Width="51px"></asp:TextBox> 只
                   </td>
                     <td style="width: 71px" >收到退货日期：&nbsp; </td>
                     <td ><asp:TextBox ID="tb_sdthrq" runat="server" Width="100px" ></asp:TextBox></td>
                 </tr>
                 <tr>
                   <td >客户要求：</td>
                   <td colspan="2" style="width: 203px" > 
                        <asp:CheckBoxList ID="cbl_khyq" runat="server" RepeatColumns="3">
                            <asp:ListItem value="换补货"    Text="换补货"></asp:ListItem>
                            <asp:ListItem value="扣款"      Text="扣款"></asp:ListItem>
                            <asp:ListItem value="回复报告"  Text="回复报告"></asp:ListItem>
                        </asp:CheckBoxList>
                   </td>
                   <td style="width: 107px">反馈日期：
                                    </td>
                   <td style="width: 112px"><asp:TextBox ID="tb_fkrq" runat="server" Width="100px"></asp:TextBox></td>
                     <td style="width: 71px" >
                        其他：
                     </td>
                     <td >
                        <asp:TextBox ID="tb_qt" runat="server" Width="100px"></asp:TextBox>
                     </td>
                 </tr>
                 <tr>
                   <td>商务部确认：</td>
                   <td colspan="2" style="width: 203px"><asp:TextBox ID="tb_swbqr" runat="server"></asp:TextBox></td>
                   <td style="width: 107px">确认日期：</td>
                   <td style="width: 112px"><asp:TextBox ID="tb_qrrq" runat="server" Width="100px"></asp:TextBox></td>
                     <td colspan="2" >&nbsp;
                         
                     </td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td rowspan="8" style="width: 60px;text-align:center">
                     质<br />
                     量<br />
                     部<br />
                     回<br />
                     复</td>
                   <td>检验结果：</td>
                   <td colspan="6"><asp:TextBox ID="tb_jyjg" runat="server" Height="110px" Width="612px" TextMode="MultiLine"  onchange="javascript:ClickJYJG(this.value);"></asp:TextBox></td>
                   </tr>
                 <tr bgcolor="#F1FEDD">
                     <td>&nbsp;</td>
                     <td colspan="2" style="width: 203px">&nbsp;</td>
                     <td style="width: 107px"></td>
                     <td style="width: 112px">检验日期：</td>
                     <td colspan="2"><asp:TextBox ID="tb_jyrq" runat="server" Width="100px"></asp:TextBox></td>

                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td>分析结果：</td>
                   <td colspan="6"><asp:TextBox ID="tb_fxjg" runat="server" Height="110px" Width="612px" TextMode="MultiLine"   onchange="javascript:ClickFXJG(this.value);"   ></asp:TextBox></td>
                   </tr>
                 <tr bgcolor="#F1FEDD">
                   <td>&nbsp;</td>
                   <td colspan="2" style="width: 203px">&nbsp;</td>
                   <td style="width: 107px" ></td>
                   <td style="width: 112px" >分析日期：</td>
                     <td colspan="2"><asp:TextBox ID="tb_fxrq" runat="server" Width="100px"></asp:TextBox></td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td >处理意见：</td>
                   <td colspan="6" ><asp:TextBox ID="tb_clyj" runat="server" Height="110px" Width="612px" TextMode="MultiLine" ></asp:TextBox></td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td>入库处理：</td>
                   <td colspan="6">
						<asp:TextBox ID="tb_rkcl" runat="server" Width="612px"></asp:TextBox>
                     </td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td style="height: 29px">&nbsp;</td>
                   <td style="width: 101px; height: 29px;"></td>
                   <td style="width: 101px; height: 29px;"></td>
                   <td style="height: 29px; width: 107px;" >质量部完成状态：</td>
                   <td style="width: 112px; height: 29px;" >
                   <asp:DropDownList ID="dd_zlbwczt" runat="server" Width="100px" onchange="javascript:ClickZLBWCZT(this.value);">
                        <asp:ListItem value="已完成" Text="已完成"></asp:ListItem>
                        <asp:ListItem Value="" Text="" Selected="True" ></asp:ListItem>
                   </asp:DropDownList>
                    </td>
                   <td style="height: 29px" >
                       质量部回复人:</td>
                   <td style="height: 29px" ><asp:TextBox ID="tb_zlbhfr" runat="server" Width="100px"/></td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td>&nbsp;</td>
                   <td >审核状态：</td>
                   <td >
                   <asp:DropDownList ID="dd_shzt" runat="server" Width="100px" onchange="javascript:ClickSHZT(this.value);" >
                        <asp:ListItem value="审核通过" Text="审核通过"></asp:ListItem>
                        <asp:ListItem Value="审核不通过" Text="审核不通过"></asp:ListItem>
                        <asp:ListItem Value="" Text="" ></asp:ListItem>
                   </asp:DropDownList>
                   </td>
                   <td style="width: 107px" >审核人：                   </td>
                   <td style="width: 112px" ><asp:TextBox ID="tb_shr" runat="server" Width="100px"></asp:TextBox></td>
                     <td style="width: 71px">
                     审核日期： </td>
                     <td><asp:TextBox ID="tb_shrq" runat="server" Width="100px"></asp:TextBox></td>
                 </tr>

             </table>

             <table id="G4" runat="server" align="center" style="text-align:center; border-top-width:0px;" border="1" cellpadding="2" cellspacing="0" class="T_Sample1" width="800px">
                <tr bgcolor="ffcccc" >
                   <td style="width:50px;text-align:center" >
                   特
                   殊<br/>
                   处
                   理<br/>
                   意
                   见                 </td>
                   <td colspan="6" style="width:740px; height: 40px;" ><asp:TextBox ID="tb_tsclyj" runat="server" Height="50px" Width="612px" TextMode="MultiLine" ></asp:TextBox></td>
                 </tr>

                 <tr bgcolor="ffcccc" >
                     <td rowspan="8" style="width: 60px;text-align:center">
                         材<br />
                         损<br />
                         统<br />
                         计<br />
                     </td>

                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td  style=" width:90px">
                         退回/补发运费：</td>
                     <td style=" width:159px">                   
                        <asp:DropDownList ID="DD_thyfdw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                         <asp:TextBox ID="tb_thyf" runat="server" Width="100px" ValidationGroup="MKE" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                     <td style=" width:90px" >报废电池成本：</td>
                     <td style=" width:155px">
                        <asp:DropDownList ID="DD_bfdccbdw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_bfdccb" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();"></asp:TextBox></td>
                     <td style=" width:90px" ></td>
                     <td style=" width:155px"  >&nbsp;</td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td rowspan="2">
                         返工/检验费用：</td>
                     <td rowspan="2" style="width: 159px" >
                        <asp:DropDownList ID="DD_fgfjfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                         <asp:TextBox ID="tb_fgfy" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();"></asp:TextBox></td>
                     <td >
                         人工：</td>
                     <td >
                        <asp:DropDownList ID="DD_rgfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="tb_rg" runat="server" Width="100px" onkeyup="clearNoNum(this)"  onchange="CHTJ();" ></asp:TextBox>
                        </td>
                     <td >补充材料： </td>
                     <td >
                        <asp:DropDownList ID="DD_bccldw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_bccl" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td>
                         其他：</td>
                     <td>
                        <asp:DropDownList ID="DD_qtfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_qtfy" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td >现场处理费用：</td>
                     <td style="width: 159px">
                     <asp:DropDownList ID="DD_xcclfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_xcclfy" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                     <td >赔偿费用： </td>
                      <td>
                      <asp:DropDownList ID="DD_pcfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                      <asp:TextBox ID="tb_pcfy" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                      <td></td>
                      <td></td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td style="height: 29px">
                         处理结果：</td>
                     <td colspan="5" style="height: 29px" ><asp:TextBox ID="tb_cljg" runat="server" Width="580px" ></asp:TextBox></td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td>
                         合计损失：</td>
                     <td style="width: 159px" colspan="5">
                        <asp:DropDownList ID="DD_hjzssdw" runat="server" Width="38px"  >
                            <asp:ListItem value="￥" Text="￥" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_hjzss" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();"></asp:TextBox></td>

                 </tr>
                <tr bgcolor="ffcccc" >
                     <td style=" height:25px">
                         商务审核：</td>
                     <td colspan="5">
                     </td>

                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td colspan="2" style="height: 45px">
                         总经理批准：</td>
                     <td style="height: 45px" colspan="5">&nbsp; &nbsp;</td>

                 </tr>
                
                 
           </table>

             <asp:HiddenField ID="czlb" runat="server" />
             <asp:HiddenField ID="djxh" runat="server" />
             <asp:HiddenField ID="hqzt" runat="server" />
                <asp:HiddenField ID="HF_username" runat="server" />
                &nbsp;&nbsp;<br />
             &nbsp;&nbsp;
  


    

    </form>
</body>
</html>

