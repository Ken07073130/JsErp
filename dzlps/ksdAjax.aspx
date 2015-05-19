<%@ Page Language="C#" CodeFile="ksdAjax.aspx.cs" Inherits="ksdAjax"   Culture="auto" UICulture="auto"  Title="¿ÍËßµ¥ÄÚÈÝ"   %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head2" runat="server"  >
                      
<title>¿ÍËßµ¥ÄÚÈÝ</title>
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
        /*ULÌî³äÂúDIV*/
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

        left:0px;
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
</head>
<body>
  <script type="text/javascript"> 
        //·ÖÒ³
        function changeTab(num){
	          for(var id=1;id<=3;id++){
	              var tabName="divTab"+id;
	              var aName="aTab"+id;
	              if(id==num){
		             document.getElementById(tabName).style.display="block";
		             //³õÊ¼¼¤»îµÄ±êÇ©Ò³Àëµ¼º½À¸Òª±£³Ö55ÏñËØ
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
        
        //Í¶²ú¼Æ»®²ÎÕÕ
        function pccz(pc_xh_khdm){
              if(pc_xh_khdm!=""){
	             document.getElementById('<%= tb_cpph.ClientID %>').value=pc_xh_khdm.split('|')[0]; 
	             document.getElementById('<%= tb_khdm.ClientID %>').value=pc_xh_khdm.split('|')[1]; 
	             document.getElementById('<%= tb_cpxh.ClientID %>').value=pc_xh_khdm.split('|')[2]; 
	          }
        }
        
        //Ìá½»Ç°¼ì²éÊäÈëÇé¿ö
        function IntoClick(){
             var hqzt=document.getElementById('<%= hqzt.ClientID %>').value
              if(hqzt=="ÉÌÎñ²¿»áÇ©"){
	             if (document.getElementById('<%= tb_tsbh.ClientID %>').value=="")
	             {
	                alert("¿ÍËß±àºÅ²»ÄÜÎª¿Õ£¡");
	                reture;
	             }
	          }
        }
        //»ñÈ¡µ±Ç°ÈÕÆÚ
        function GetDateT()
        {
            var d,s;
            d = new Date();
            s = d.getFullYear() + "-";             //È¡Äê·Ý
            s = s + (d.getMonth() + 1) + "-";//È¡ÔÂ·Ý
            s += d.getDate() + " ";         //È¡ÈÕÆÚ


            return(s);  

        } 
        //ÊäÈë¼ìÑé½á¹ûºó×Ô¶¯Éú³É¼ìÑéÈÕÆÚ
        function ClickJYJG(JYJG){
            if(JYJG!="" && document.getElementById('<%= tb_jyrq.ClientID %>').value==""){
                document.getElementById('<%= tb_jyrq.ClientID %>').value=GetDateT();
            }
        }
        //ÊäÈë·ÖÎö½á¹ûºó×Ô¶¯Éú³É·ÖÎöÈÕÆÚ
        function ClickFXJG(FXJG){
            if(FXJG!="" && document.getElementById('<%= tb_fxrq.ClientID %>').value==""){
                document.getElementById('<%= tb_fxrq.ClientID %>').value=GetDateT();
            }
        }
        //ÖÊÁ¿¾­ÀíÉóºËÒÔºóÖ±½ÓÉú³ÉÉóºËÈËºÍÉóºËÊ±¼ä
        function ClickSHZT(SHZT){
            if(SHZT=="ÉóºËÍ¨¹ý" || SHZT=="ÉóºË²»Í¨¹ý"){
                document.getElementById('<%= tb_shr.ClientID %>').value=document.getElementById('<%= HF_username.ClientID %>').value; 
                document.getElementById('<%= tb_shrq.ClientID %>').value=GetDateT();
            }
        }
        
        function ClickZLBWCZT(ZLBWCZT){
            if(ZLBWCZT=="ÒÑÍê³É"){
                document.getElementById('<%= tb_zlbhfr.ClientID %>').value=document.getElementById('<%= HF_username.ClientID %>').value; 
            }
        }
        
        function CHTJ(){
            var hj=0;
            if (document.getElementById('<%= tb_thyf.ClientID %>').value!=""){
                hj=hj+parseFloat(document.getElementById('<%= tb_thyf.ClientID %>').value); 
            }
            if (document.getElementById('<%= tb_rg.ClientID %>').value!=""){
                hj=hj+parseFloat(document.getElementById('<%= tb_rg.ClientID %>').value);
            }
            if (document.getElementById('<%= tb_bccl.ClientID %>').value!=""){
                hj=hj+parseFloat(document.getElementById('<%= tb_bccl.ClientID %>').value); 
            }
            if (document.getElementById('<%= tb_bfdccb.ClientID %>').value!=""){
                hj=hj+parseFloat(document.getElementById('<%= tb_bfdccb.ClientID %>').value); 
            }
            if(document.getElementById('<%= tb_fgfy.ClientID %>').value!=""){
                hj=hj+parseFloat(document.getElementById('<%= tb_fgfy.ClientID %>').value);
            }
            if(document.getElementById('<%= tb_qtfy.ClientID %>').value!=""){
                hj=hj+parseFloat(document.getElementById('<%= tb_qtfy.ClientID %>').value); 
            }
            if(document.getElementById('<%= tb_xcclfy.ClientID %>').value!=""){
                hj=hj+parseFloat(document.getElementById('<%= tb_xcclfy.ClientID %>').value);
            }
            if(document.getElementById('<%= tb_pcfy.ClientID %>').value!=""){
                hj=hj+parseFloat(document.getElementById('<%= tb_pcfy.ClientID %>').value);
            }

            document.getElementById('<%= tb_hjzss.ClientID %>').value=hj;

        }
        
        function clearNoNum(obj)
        {
            //ÏÈ°Ñ·ÇÊý×ÖµÄ¶¼Ìæ»»µô£¬³ýÁËÊý×ÖºÍ.
            obj.value = obj.value.replace(/[^\d.]/g,"");
            //±ØÐë±£Ö¤µÚÒ»¸öÎªÊý×Ö¶ø²»ÊÇ.
            obj.value = obj.value.replace(/^\./g,"");
            //±£Ö¤Ö»ÓÐ³öÏÖÒ»¸ö.¶øÃ»ÓÐ¶à¸ö.
            obj.value = obj.value.replace(/\.{2,}/g,".");
            //±£Ö¤.Ö»³öÏÖÒ»´Î£¬¶ø²»ÄÜ³öÏÖÁ½´ÎÒÔÉÏ
            obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
            
            
            CHTJ();
            
        }
        


     </script>   
<form id="form1" runat="server" >
     <%--ÐÅÏ¢²¹È«¿Ø¼þ--%>
    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"  TargetControlID="tb_khdm" ServicePath="../GetContent.asmx" ServiceMethod="GetkhdmList" MinimumPrefixLength="1"  CompletionInterval="500" />
    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="tb_cpxh" ServicePath="../GetContent.asmx" ServiceMethod="GetcpxhList"  MinimumPrefixLength="1" CompletionInterval="500" />
    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="tb_cpph" ServicePath="../GetContent.asmx" ServiceMethod="GetCpphList"  MinimumPrefixLength="1" CompletionInterval="500" />
    <%--ÈÕÆÚÑ¡Ôñ¿Ø¼þ--%>
    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server"  TargetControlID="tb_chrq" Format="yyyy-MM-dd"   />
    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server"  TargetControlID="tb_tsrq" Format="yyyy-MM-dd"  />
    <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server"  TargetControlID="tb_jyrq" Format="yyyy-MM-dd"  />                                  
    <ajaxToolkit:CalendarExtender ID="CalendarExtender4" runat="server"  TargetControlID="tb_fxrq" Format="yyyy-MM-dd"  />
    <ajaxToolkit:CalendarExtender ID="CalendarExtender5" runat="server"  TargetControlID="tb_shrq" Format="yyyy-MM-dd" PopupPosition="TopRight" />
    <ajaxToolkit:CalendarExtender ID="CalendarExtender6" runat="server"  TargetControlID="tb_qrrq" Format="yyyy-MM-dd"  />
    <ajaxToolkit:CalendarExtender ID="CalendarExtender7" runat="server"  TargetControlID="tb_fkrq" Format="yyyy-MM-dd"  />
    <ajaxToolkit:CalendarExtender ID="CalendarExtender8" runat="server"  TargetControlID="tb_sdthrq" Format="yyyy-MM-dd"  PopupPosition="BottomRight" />


         <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
            <Services>
                <asp:ServiceReference Path="~/AutoCompleteService.svc" />
            </Services>
         </ajaxToolkit:ToolkitScriptManager>
          
       <div  align="center"  id="divAll" style="width:800px;" >
            <div  id="divNav" >
                <ul class="ulTab" >
                    <li ><a id="aTab1" href="javascript:void(0)"  onclick="javascript:changeTab(1)">ÖÊÁ¿Í¶Ëßµ¥ÄÚÈÝ</a></li>
                    <li ><a id="aTab2" href="javascript:void(0)"  onclick="javascript:changeTab(2)" >»áÇ©×´Ì¬¸ü¸Ä</a></li>
                 </ul>
            </div>
            <div align="center" id="divTab1" style="text-align: center;">
                      
               <table   border="1" cellpadding="2" cellspacing="0" class="T_Sample1" width="800px"  style="text-align:left;"  >
                <tr>
                    <td colspan="8" style="height: 50px; font-size:20px; text-align: center; font-weight:bolder;" >ÖÊÁ¿Í¶Ëß´¦Àíµ¥</td>
                </tr>
                            <tr>
                              <td rowspan="8" style="width: 60px; text-align:center">
                                Í¶<br />
                                Ëß<br />
                                ÐÅ<br />
                                Ï¢<br />
                                Ãè<br /><ajaxToolkit:DropDownExtender runat="server" DropDownControlID="dd_shzt" TargetControlID="tb_tsbh"></ajaxToolkit:DropDownExtender>
                                Êö</td>
                              <td  style="width: 120px;" >¿ÍËß±àºÅ£º</td>
                              <td colspan="2" style="width: 203px;"><asp:TextBox ID="tb_tsbh" runat="server" ></asp:TextBox></td>
                              <td style="width: 104px;">²úÆ·ÅúºÅ£º</td>
                              <td style="width: 315px;" colspan="3"><asp:TextBox ID="tb_cpph" runat="server" Width="200px" onchange="javascript:pccz(this.value);"></asp:TextBox></td>
                              
                            </tr>
                            <tr>
                                <td >¿Í»§´úÂë£º</td>
                                <td colspan="2" style="width: 203px;"> <asp:TextBox ID="tb_khdm" runat="server"   onchange="this.value=this.value.split('|')[0];" ></asp:TextBox>
                                     </td>
                                <td style="width: 107px">²úÆ·ÐÍºÅ£º</td>
                                <td colspan="3" style="text-align:left " ><asp:TextBox ID="tb_cpxh" runat="server" Width="200px" ></asp:TextBox>
                                </td>

                            </tr>
                            <tr>
                                <td >³ö»õÊýÁ¿£º</td>
                                <td colspan="2" style="width: 203px;"><asp:TextBox ID="tb_chsl" runat="server"></asp:TextBox></td>
                                <td style="width: 107px" >³ö»õÈÕÆÚ£º</td>
                                <td style="width: 112px" ><asp:TextBox ID="tb_chrq" runat="server" Width="100px" ></asp:TextBox></td>
                                <td colspan="2" >&nbsp;      </td>
                            </tr>
                            <tr>
                                <td>¿Í»§Í¶ËßÐÅÏ¢ÃèÊö£º</td>
                                <td colspan="6"><asp:TextBox ID="tb_tsxxms" runat="server" Height="50px" Width="601px" TextMode="MultiLine" ></asp:TextBox></td>
                            </tr>
                 <tr>
                   <td >Í¶ËßÀàÐÍ£º</td>
                   <td colspan="2" style="width: 203px;">
                       <asp:RadioButtonList ID="RB_tslx" runat="server"  RepeatColumns="2" Width="120px"  >
                       <asp:ListItem  Selected="True">ÅúÁ¿</asp:ListItem>
                       <asp:ListItem >ÑùÆ·</asp:ListItem>
                       </asp:RadioButtonList>
                   
                    </td>
                   <td style="width: 107px" >¿ÍËßÈÕÆÚ£º</td>
                   <td style="width: 112px" >
                     <asp:TextBox ID="tb_tsrq" runat="server" Width="100px"></asp:TextBox>
                   </td>
                     <td colspan="2" >&nbsp;</td>
                 </tr>
                 <tr>
                   <td >¿Í»§ÍË»õ£º</td>
                   <td colspan="2" style="width: 203px" >
                   <asp:RadioButtonList ID="RB_khth" runat="server"  RepeatColumns="2" Width="120px">
                       <asp:ListItem Selected="True" >YES</asp:ListItem>
                       <asp:ListItem >NO</asp:ListItem>
                    </asp:RadioButtonList>
                    </td>
                   <td style="width: 107px" >ÊýÁ¿:</td>
                   <td style="width: 112px" ><asp:TextBox ID="tb_thsl" runat="server" Width="51px"></asp:TextBox> Ö»
                   </td>
                     <td style="width: 71px" >ÊÕµ½ÍË»õÈÕÆÚ£º&nbsp; </td>
                     <td ><asp:TextBox ID="tb_sdthrq" runat="server" Width="100px" ></asp:TextBox></td>
                 </tr>
                 <tr>
                   <td >¿Í»§ÒªÇó£º</td>
                   <td colspan="2" style="width: 203px" > 
                        <asp:CheckBoxList ID="cbl_khyq" runat="server" RepeatColumns="3">
                            <asp:ListItem value="»»²¹»õ"    Text="»»²¹»õ"></asp:ListItem>
                            <asp:ListItem value="¿Û¿î"      Text="¿Û¿î"></asp:ListItem>
                            <asp:ListItem value="»Ø¸´±¨¸æ"  Text="»Ø¸´±¨¸æ"></asp:ListItem>
                        </asp:CheckBoxList>
                   </td>
                   <td style="width: 107px">·´À¡ÈÕÆÚ£º
                                    </td>
                   <td style="width: 112px"><asp:TextBox ID="tb_fkrq" runat="server" Width="100px"></asp:TextBox></td>
                     <td style="width: 71px" >
                        ÆäËû£º
                     </td>
                     <td >
                        <asp:TextBox ID="tb_qt" runat="server" Width="100px"></asp:TextBox>
                     </td>
                 </tr>
                 <tr>
                   <td>ÉÌÎñ²¿È·ÈÏ£º</td>
                   <td colspan="2" style="width: 203px"><asp:TextBox ID="tb_swbqr" runat="server"></asp:TextBox></td>
                   <td style="width: 107px">È·ÈÏÈÕÆÚ£º</td>
                   <td style="width: 112px"><asp:TextBox ID="tb_qrrq" runat="server" Width="100px"></asp:TextBox></td>
                     <td colspan="2" >&nbsp;
                         
                     </td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td rowspan="8" style="width: 60px;text-align:center">
                     ÖÊ<br />
                     Á¿<br />
                     ²¿<br />
                     »Ø<br />
                     ¸´</td>
                   <td>¼ìÑé½á¹û£º</td>
                   <td colspan="6"><asp:TextBox ID="tb_jyjg" runat="server" Height="110px" Width="612px" TextMode="MultiLine"  onchange="javascript:ClickJYJG(this.value);"></asp:TextBox></td>
                   </tr>
                 <tr bgcolor="#F1FEDD">
                     <td>&nbsp;</td>
                     <td colspan="2" style="width: 203px">&nbsp;</td>
                     <td style="width: 107px"></td>
                     <td style="width: 112px">¼ìÑéÈÕÆÚ£º</td>
                     <td colspan="2"><asp:TextBox ID="tb_jyrq" runat="server" Width="100px"></asp:TextBox></td>

                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td>·ÖÎö½á¹û£º</td>
                   <td colspan="6"><asp:TextBox ID="tb_fxjg" runat="server" Height="110px" Width="612px" TextMode="MultiLine"   onchange="javascript:ClickFXJG(this.value);"   ></asp:TextBox></td>
                   </tr>
                 <tr bgcolor="#F1FEDD">
                   <td>&nbsp;</td>
                   <td colspan="2" style="width: 203px">&nbsp;</td>
                   <td style="width: 107px" ></td>
                   <td style="width: 112px" >·ÖÎöÈÕÆÚ£º</td>
                     <td colspan="2"><asp:TextBox ID="tb_fxrq" runat="server" Width="100px"></asp:TextBox></td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td >´¦ÀíÒâ¼û£º</td>
                   <td colspan="6" ><asp:TextBox ID="tb_clyj" runat="server" Height="110px" Width="612px" TextMode="MultiLine" ></asp:TextBox></td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td>Èë¿â´¦Àí£º</td>
                   <td colspan="6">
						<asp:TextBox ID="tb_rkcl" runat="server" Width="612px"></asp:TextBox>
                     </td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td style="height: 29px">&nbsp;</td>
                   <td style="width: 101px; height: 29px;"></td>
                   <td style="width: 101px; height: 29px;"></td>
                   <td style="height: 29px; width: 107px;" >ÖÊÁ¿²¿Íê³É×´Ì¬£º</td>
                   <td style="width: 112px; height: 29px;" >
                   <asp:DropDownList ID="dd_zlbwczt" runat="server" Width="100px" onchange="javascript:ClickZLBWCZT(this.value);">
                        <asp:ListItem value="ÒÑÍê³É" Text="ÒÑÍê³É"></asp:ListItem>
                        <asp:ListItem Value="" Text="" Selected="True" ></asp:ListItem>
                   </asp:DropDownList>
                    </td>
                   <td style="height: 29px" >
                       ÖÊÁ¿²¿»Ø¸´ÈË:</td>
                   <td style="height: 29px" ><asp:TextBox ID="tb_zlbhfr" runat="server" Width="100px"/></td>
                 </tr>
                 <tr bgcolor="#F1FEDD">
                   <td>&nbsp;</td>
                   <td >ÉóºË×´Ì¬£º</td>
                   <td >
                   <asp:DropDownList ID="dd_shzt" runat="server" Width="100px" onchange="javascript:ClickSHZT(this.value);" >
                        <asp:ListItem value="ÉóºËÍ¨¹ý" Text="ÉóºËÍ¨¹ý"></asp:ListItem>
                        <asp:ListItem Value="ÉóºË²»Í¨¹ý" Text="ÉóºË²»Í¨¹ý"></asp:ListItem>
                        <asp:ListItem Value="" Text="" ></asp:ListItem>
                   </asp:DropDownList>
                   </td>
                   <td style="width: 107px" >ÉóºËÈË£º                   </td>
                   <td style="width: 112px" ><asp:TextBox ID="tb_shr" runat="server" Width="100px"></asp:TextBox></td>
                     <td style="width: 71px">
                     ÉóºËÈÕÆÚ£º </td>
                     <td><asp:TextBox ID="tb_shrq" runat="server" Width="100px"></asp:TextBox></td>
                 </tr>

             </table>

             <table id="G4" runat="server"  style="text-align:center; border-top-width:0px;" border="1" cellpadding="2" cellspacing="0" class="T_Sample1" width="800px">
                <tr bgcolor="ffcccc" >
                   <td style="width:60px;text-align:center" >
                   ÌØ<br/>
                   Êâ<br/>
                   ´¦<br/>
                   Àí<br/>
                   Òâ<br/>
                   ¼û<br/>                  </td>
                   <td colspan="6" style="width:740px; height: 93px;" ><asp:TextBox ID="tb_tsclyj" runat="server" Height="80px" Width="612px" TextMode="MultiLine" ></asp:TextBox></td>
                 </tr>

                 <tr bgcolor="ffcccc" >
                     <td rowspan="7" style="width: 60px;text-align:center">
                         ²Ä<br />
                         Ëð<br />
                         Í³<br />
                         ¼Æ<br />
                     </td>

                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td  style=" width:90px">
                         ÍË»Ø/²¹·¢ÔË·Ñ£º</td>
                     <td style=" width:155px">                   
                        <asp:DropDownList ID="DD_thyfdw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                         <asp:TextBox ID="tb_thyf" runat="server" Width="100px" ValidationGroup="MKE" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                     <td style=" width:90px" >±¨·Ïµç³Ø³É±¾£º</td>
                     <td style=" width:155px">
                        <asp:DropDownList ID="DD_bfdccbdw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_bfdccb" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();"></asp:TextBox></td>
                     <td style=" width:90px" ></td>
                     <td style=" width:155px"  >&nbsp;</td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td rowspan="2">
                         ·µ¹¤/¼ìÑé·ÑÓÃ£º</td>
                     <td rowspan="2" >
                        <asp:DropDownList ID="DD_fgfjfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                         <asp:TextBox ID="tb_fgfy" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();"></asp:TextBox></td>
                     <td >
                         ÈË¹¤£º</td>
                     <td >
                        <asp:DropDownList ID="DD_rgfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="tb_rg" runat="server" Width="100px" onkeyup="clearNoNum(this)"  onchange="CHTJ();" ></asp:TextBox>
                        </td>
                     <td >²¹³ä²ÄÁÏ£º </td>
                     <td >
                        <asp:DropDownList ID="DD_bccldw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_bccl" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td>
                         ÆäËû£º</td>
                     <td>
                        <asp:DropDownList ID="DD_qtfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_qtfy" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td >ÏÖ³¡´¦Àí·ÑÓÃ£º</td>
                     <td>
                     <asp:DropDownList ID="DD_xcclfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_xcclfy" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                     <td >Åâ³¥·ÑÓÃ£º </td>
                      <td>
                      <asp:DropDownList ID="DD_pcfydw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                      <asp:TextBox ID="tb_pcfy" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();" ></asp:TextBox></td>
                      <td></td>
                      <td></td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td style="height: 29px">
                         ´¦Àí½á¹û£º</td>
                     <td colspan="5" style="height: 29px" ><asp:TextBox ID="tb_cljg" runat="server" Width="580px" ></asp:TextBox></td>
                 </tr>
                 <tr bgcolor="ffcccc" >
                     <td>
                         ºÏ¼ÆËðÊ§£º</td>
                     <td>
                        <asp:DropDownList ID="DD_hjzssdw" runat="server" Width="38px"  >
                            <asp:ListItem value="£¤" Text="£¤" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="$" Text="$"></asp:ListItem>
                            <asp:ListItem Value="€" Text="€"  ></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox ID="tb_hjzss" runat="server" Width="100px" onkeyup="clearNoNum(this)" onchange="CHTJ();"></asp:TextBox></td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                 </tr>
                
                 
           </table>
                
             <asp:HiddenField ID="czlb" runat="server" />
             <asp:HiddenField ID="djxh" runat="server" />
             <asp:HiddenField ID="hqzt" runat="server" />
                <asp:HiddenField ID="HF_username" runat="server" />
                &nbsp;<br />
             &nbsp;<asp:Button ID="B_tj" runat="server" OnClick="B_tj_Click"  OnClientClick="IntoClick()" Text="Ìá  ½»" />
             <asp:Button ID="B_print" runat="server" OnClick="B_print_Click" Text="´òÓ¡Ô¤ÀÀ" />
       </div>      
                  
        

      
        <div align="center" id="divTab2" style="text-align: center">
            <table width="300" border="0" align="center" cellpadding="0" cellspacing="0" class="T_Sample2">
              <tr>
                <td><div class="div2" >Á÷³Ì»áÇ©×´Ì¬£º<asp:Label ID="L_lchqzt" runat="server" ></asp:Label></div></td>
              </tr>
              <tr>
                <td>ÉÌÎñ²¿»áÇ©×´Ì¬£º<asp:DropDownList ID="DD_swbhqzt" runat="server">
                    <asp:ListItem Value="-" Text="-"></asp:ListItem>
                    <asp:ListItem Value="ÒÑ»áÇ©" Text="ÒÑ»áÇ©"></asp:ListItem>
                    <asp:ListItem Value="ÉÌÎñ¿ÍËßÂ¼ÈëÖÐ" Text="»áÇ©ÖÐ" />
                    </asp:DropDownList></td>
              </tr>
              <tr>
                <td style="height: 40px"><asp:Image ID="Image1" runat="server"  ImageUrl="../images/jt.png"/></td>
              </tr>
              <tr>
                <td>ÖÊÁ¿²¿»áÇ©×´Ì¬£º<asp:DropDownList ID="DD_zlbhqzt" runat="server">
                    <asp:ListItem Value="-" Text="-"></asp:ListItem>
                    <asp:ListItem Value="ÒÑ»áÇ©" Text="ÒÑ»áÇ©"></asp:ListItem>
                    <asp:ListItem Value="ÖÊÁ¿·ÖÎöÂ¼ÈëÖÐ" Text="»áÇ©ÖÐ" /> 
                    </asp:DropDownList>
                 </td>
              </tr>
              <tr>
                <td><asp:Image ID="Image2" runat="server"  ImageUrl="../images/jt.png"/></td>
              </tr>
              <tr>
                <td>ÉóºË»áÇ©×´Ì¬£º<asp:DropDownList ID="DD_shhqzt" runat="server">
                    <asp:ListItem Value="-" Text="-" ></asp:ListItem>
                    <asp:ListItem Value="ÒÑ»áÇ©" Text="ÒÑ»áÇ©"></asp:ListItem>
                    <asp:ListItem Value="ÖÊÁ¿¾­ÀíÉóºËÖÐ" Text="»áÇ©ÖÐ" />  
                    </asp:DropDownList></td>
              </tr>
              <tr>
                <td><asp:Image ID="Image3" runat="server"  ImageUrl="../images/jt.png"/></td>
              </tr>
              <tr>
                <td>²ÄºÄÍ³¼Æ»áÇ©×´Ì¬£º<asp:DropDownList ID="DD_chtjhqzt" runat="server">
                    <asp:ListItem Value="-" Text="-" ></asp:ListItem>
                    <asp:ListItem Value="ÒÑ»áÇ©" Text="ÒÑ»áÇ©" ></asp:ListItem>
                    <asp:ListItem Value="ÉÌÎñ²ÄºÄÍ³¼ÆÖÐ" Text="»áÇ©ÖÐ" />  
                    </asp:DropDownList></td>
              </tr>
            </table>
            &nbsp;<br />
            <asp:Button ID="B_Change" runat="server" OnClick="B_Change_Click"   Text="±£   ´æ" />
        </div>
        </div>
    
    </form>
    </body>
    </html>

