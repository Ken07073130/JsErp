<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jxkh_pz.aspx.cs" Inherits="jxkh_pz" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

<link rel="stylesheet" href="../jquery-ui/themes/base/jquery.ui.all.css">
<script src="../jquery-ui/jquery-1.10.2.js"></script>
<script src="../jquery-ui/ui/jquery.ui.core.js"></script>
<script src="../jquery-ui/ui/jquery.ui.widget.js"></script>
<script src="../jquery-ui/ui/jquery.ui.mouse.js"></script>
<script src="../jquery-ui/ui/jquery.ui.button.js"></script>
<script src="../jquery-ui/ui/jquery.ui.draggable.js"></script>
<script src="../jquery-ui/ui/jquery.ui.position.js"></script>
<script src="../jquery-ui/ui/jquery.ui.resizable.js"></script>
<script src="../jquery-ui/ui/jquery.ui.button.js"></script>
<script src="../jquery-ui/ui/jquery.ui.dialog.js"></script>
<script src="../jquery-ui/ui/jquery.ui.effect.js"></script>
<link rel="stylesheet" href="../jquery-ui/demos.css">

<style type="text/css">
/* CSS Document */
body {
    font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    color: #4f6b72;
    background: #E6EAE9;
}
a {
    color: #c75f3e;
}
.mytable {
    padding: 0;
    margin: 0;
}
caption {
    padding: 0 0 5px 0;
    width: 700px; 
    font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    text-align: right;
}
th {
    font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
    color: #4f6b72;
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    border-top: 1px solid #C1DAD7;
    letter-spacing: 2px;
    text-transform: uppercase;
    text-align: center;

    background: #CAE8EA;
}
th.nobg {
    border-top: 0;
    border-left: 0;
    border-right: 1px solid #C1DAD7;
    background: none;
}
td {
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    border-top: 1px solid #C1DAD7;
    /*background: #fff;*/
    font-size:11px;
    text-align: center;
    color: #4f6b72;
}
.hover{
    cursor:pointer;
    background-color:#bcd4ec;  
}   /*这里是鼠标经过时的颜色*/ 
</style>
    <title>极片生产日报</title>
</head>

<body style="text-align: center" >
<script type ="text/javascript"  >
  function addTr(tab, row, trHtml,ddl){
         //获取table最后一行 $("#tab tr:last")
         //获取table第一行 $("#tab tr").eq(0)
         //获取table倒数第二行 $("#tab tr").eq(-2)
         var $tr=$("#"+tab+" tr").eq(row-1);
         if($tr.size()==0){
            alert("指定的table id或行数不存在！");
            return;
         }
         $tr.after(trHtml);
         
         eval(ddl);
      }
      function addTr1(tab, row){
            var trHtml="";
            var ddl="";
            if(tab=="tab"){
                var b=parseInt($('#bl').val());
                b=b+1;
                $('#bl').val(b);
                data = "{'bhxx':{'bhxx1':'"+ $("#TB_xxbh1").val() +"','bhxx_max':'"+ $("#HF_bhxx_max").val() +"'}}";
                $.ajax({
                    type: "POST",
                    url: "../GetContent.asmx/Getjxkh_bhxx",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: data,
                    success: function(data) { 
				                $('#TB_xxbh'+b).val(data);
				                $('#HF_bhxx_max').val(data);
				             },
				            error: function(error) {
				                alert("调用出错" + error.responseText);
				            }
                });
                trHtml="<tr><td><input  type='text'  style='width:95%' name='TB_xmmc"+ b +"'   id='TB_xmmc"+ b +"'  value='"+ $('#TB_xmmc').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_mrz"+ b +"'   id='TB_mrz"+ b +"'  value='"+ $('#TB_mrz').val() +"'/></td>"                      
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw"+ b +"'   id='TB_dw"+ b +"' value='"+ $('#TB_dw').val() +"' /></td>"
                        +" <td> <select   style='width:95%' name='DDL_lrbm" + b + "' ID='DDL_lrbm" + b + "'  ><option></option><option value='sbb'>设备部</option><option value='gcb'>工程部</option><option value='zlb'>质量部</option> <option value='gyl'>供应链管理部</option> <option value='jsb'>技术部</option><option value='zzb'>制造部</option>  <option value='swb'>商务部</option><option value='cwb'>财务部</option>   <option value='xzb'>行政部</option><option value='wab'>网络安防部</option><option value='scb'>市场部</option><option value='zjlms'>总经理秘书</option><option value='khxz'>考核小组</option></select> </td> "
                        +"  <td><input  type='text'  style='width:95%' name='TB_xxbh"+ b +"'   id='TB_xxbh"+ b +"' value='"+ $('#TB_xxbh').val() +"' readonly /></td>"
                        +"  <td><input type='checkbox' name='ckb'/></td></tr>"
                ddl="document.getElementById('DDL_lrbm" + b + "').value='" + $('#DDL_lrbm').val() + "';";
                $('#TB_xmmc').val("");
                $('#TB_mrz').val("");
                $('#TB_dw').val(""); 
                $('#TB_lrbm').val("");
                $('#TB_xxbh').val("");
                  
            }else if(tab=="tab1"){
                var b=parseInt($('#gz1').val());
                b=b+1;
                $('#gz1').val(b);
                trHtml="<tr><td> <select   style='width:95%' name='DDL_gz51" + b + "' ID='DDL_gz51" + b + "'  ><option value=''></option><option value='>'>＞</option><option value='>='>≥</option><option value='=='>=</option> <option value='<='>≤</option> <option value='<'>＜</option> </select> </td>  "
                        +"  <td><input  type='text'  style='width:95%' name='TB_sz51"+ b +"'   id='TB_sz51"+ b +"'  value='"+ $('#TB_sz51').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw51"+ b +"'   id='TB_dw51"+ b +"' value='"+ $('#TB_dw51').val() +"' /></td>"
                        +"  <td> <select   style='width:95%' name='DDL_gx51" + b + "' ID='DDL_gx51" + b + "'  ><option value=''></option><option value='&&'>and</option><option value='||'>or</option></select> </td>  "
                        +"  <td> <select   style='width:95%' name='DDL_gz52" + b + "' ID='DDL_gz52" + b + "'  ><option value=''></option><option value='>'>＞</option><option value='>='>≥</option><option value='=='>=</option> <option value='<='>≤</option> <option value='<'>＜</option> </select> </td>  "
                        +"  <td><input  type='text'  style='width:95%' name='TB_sz52"+ b +"'   id='TB_sz52"+ b +"' value='"+ $('#TB_sz52').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw52"+ b +"'   id='TB_dw52"+ b +"' value='"+ $('#TB_dw52').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_df51"+ b +"'   id='TB_df51"+ b +"' value='"+ $('#TB_df51').val() +"'/></td>"
                        +"  <td><input type='checkbox' name='ckb'/></td></tr>"
                ddl="document.getElementById('DDL_gz51" + b + "').value='" + $('#DDL_gz51').val() + "';document.getElementById('DDL_gx51" + b + "').value='" + $('#DDL_gx51').val() + "';document.getElementById('DDL_gz52" + b + "').value='" + $('#DDL_gz52').val() + "';  ";
                $("#DDL_gz51").val(""); 
                $("#DDL_gx51").val("");          
                $("#TB_sz51").val(""); 
                $("#TB_dw51").val(""); 
                $("#DDL_gz52").val(""); 
                $("#TB_sz52").val(""); 
                $("#TB_dw52").val(""); 
                $("#TB_df51").val(""); 

            }else if(tab=="tab2"){
                var b=parseInt($('#gz2').val());
                b=b+1;
                $('#gz2').val(b);
                trHtml="<tr><td> <select   style='width:95%' name='DDL_gz21" + b + "' ID='DDL_gz21" + b + "'  ><option></option><option value='>'>＞</option><option value='>='>≥</option><option value='=='>=</option> <option value='<='>≤</option> <option value='<'>＜</option> </select> </td>  "
                        +"  <td><input  type='text'  style='width:95%' name='TB_sz21"+ b +"'   id='TB_sz21"+ b +"'  value='"+ $('#TB_sz21').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw21"+ b +"'   id='TB_dw21"+ b +"' value='"+ $('#TB_dw21').val() +"' /></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_df21"+ b +"'   id='TB_df21"+ b +"' value='"+ $('#TB_df21').val() +"'/></td>"
                        +"  <td><input type='checkbox' name='ckb'/></td></tr>"
                ddl="document.getElementById('DDL_gz21" + b + "').value='" + $('#DDL_gz21').val() + "';";
                $("#DDL_gz21").val(""); 
                $("#TB_sz21").val("");          
                $("#TB_dw21").val(""); 
                $("#TB_df21").val(""); 

            }else if(tab=="tab3"){
                var b=parseInt($('#gz3').val());
                b=b+1;
                $('#gz3').val(b);
                trHtml="<tr><td><input  type='text'  style='width:95%' name='TB_dj31"+ b +"'   id='TB_dj31"+ b +"'  value='"+ $('#TB_dj31').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_zhs31"+ b +"'  id='TB_zhs31"+ b +"' value='"+ $('#TB_zhs31').val() +"' /></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw31"+ b +"'   id='TB_dw31"+ b +"' value='"+ $('#TB_dw31').val() +"'/></td>"
                        +"  <td><input type='checkbox' name='ckb'/></td></tr>"
                $("#TB_dj31").val(""); 
                $("#TB_zhs31").val("");          
                $("#TB_dw31").val(""); 
            }else if(tab=="tab4"){
                var b=parseInt($('#gz4').val());
                b=b+1;
                $('#gz4').val(b);
                trHtml="<tr><td> <select   style='width:95%' name='DDL_gz41" + b + "' ID='DDL_gz41" + b + "'  ><option></option><option value='>'>＞</option><option value='>='>≥</option><option value='=='>=</option> <option value='<='>≤</option> <option value='<'>＜</option> </select> </td>  "
                        +"  <td><input  type='text'  style='width:95%' name='TB_sz41"+ b +"'   id='TB_sz41"+ b +"'  value='"+ $('#TB_sz41').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw41"+ b +"'   id='TB_dw41"+ b +"' value='"+ $('#TB_dw41').val() +"' /></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_df41"+ b +"'   id='TB_df41"+ b +"' value='"+ $('#TB_df41').val() +"'/></td>"
                        +"  <td><input type='checkbox' name='ckb'/></td></tr>"
                ddl="document.getElementById('DDL_gz41" + b + "').value='" + $('#DDL_gz41').val() + "';";
                $("#DDL_gz41").val(""); 
                $("#TB_sz41").val("");          
                $("#TB_dw41").val(""); 
                $("#TB_df41").val(""); 

            }else if(tab=="tab6"){
                var b=parseInt($('#gz6').val());
                b=b+1;
                $('#gz6').val(b);
                trHtml="<tr><td><input  type='text'  style='width:95%' name='TB_dj61"+ b +"'   id='TB_dj61"+ b +"'  value='"+ $('#TB_dj61').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_zhs61"+ b +"'   id='TB_zhs61"+ b +"' value='"+ $('#TB_zhs61').val() +"' /></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw61"+ b +"'   id='TB_dw61"+ b +"' value='"+ $('#TB_dw61').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dyz61"+ b +"'   id='TB_dyz61"+ b +"' value='"+ $('#TB_dyz61').val() +"'/></td>"
                        +"  <td><input type='checkbox' name='ckb'/></td></tr>"
                $("#TB_dyz61").val(""); 
                $("#TB_dj61").val("");          
                $("#TB_zhs61").val(""); 
                $("#TB_dw61").val(""); 

            }
            addTr(tab, row, trHtml,ddl);
        }
     function delTr(ckb){
        ckb='ckb';
        //获取选中的复选框，然后循环遍历删除
        var ckbs=$("input[name="+ckb+"]:checked");
        if(ckbs.size()==0){
            alert("要删除指定行，需选中要删除的行！");
                return;
            }
            ckbs.each(function(){
                var data="";
                var del_ID=$(this).val();
                if (del_ID != "on" )
                {
                    if (del_ID.substr(0,4)=="xmsx" )
                    {
                        data="{'jxkh_del':{'table':'js_jxkh_xmsx','sqlstr':'delete [js_jxkh_xmsx]  where id ="+$("#"+del_ID ).val()+" '}} "; 
                    }else if (del_ID.substr(0,3)=="gzB"  || del_ID.substr(0,7)=="gz_B_fj"   )
                    {
                        data="{'jxkh_del':{'table':'js_jxkh_xmsx','sqlstr':' delete [js_jxkh_gz]  where id ="+$("#"+del_ID ).val()+"'}} "; 
                    }else if (del_ID.substr(0,4)=="gz_C")
                    {
                        data="{'jxkh_del':{'table':'js_jxkh_xmsx','sqlstr':' delete [js_jxkh_gz]  where id ="+$("#"+del_ID ).val()+"'}} "; 
                    }
                    
                    $.ajax({
                        type: "POST",
				        url: "../GetContent.asmx/Del_jxkh",
				        dataType: "json",
				        contentType: "application/json; charset=utf-8",
				        data: data,
				        success: function(data) { 
				            alert(data);
				        },
				        error: function(error) {
				            alert("调用出错" + error.responseText);
				        }
                    });
                }
                $(this).parent().parent().remove();
            });
        }

        function showta(){
            if($("#CB_sfta").prop('checked')==true){
                $("#tab6").show();
            }else{
                $("#tab6").hide();
            }
        }
 
        
    function gzchange(gz){ 
        if (gz=="A"){
            $("#tab_1").hide();
            $("#tab_2").hide();
            $("#tab3").show();
            $("#tab6").hide();
            $("#ggxx_tr5").hide();
        }else if(gz=="B"){
            $("#tab_1").show();
            $("#tab_2").hide();
            $("#tab3").hide();
            $("#tab6").hide();
            $("#ggxx_tr5").hide();
        }else if (gz=="C"){
            $("#tab_1").hide();
            $("#tab_2").show();
            $("#tab3").hide();
            $("#tab6").hide();
            $("#ggxx_tr5").show();
        }else if (gz=="N"){
            $("#tab_1").hide();
            $("#tab_2").hide();
            $("#tab3").hide();
            $("#tab6").hide();
            $("#ggxx_tr5").hide();
        }
       
    }

</script>
    <form id="form1" runat="server">
        &nbsp; &nbsp;&nbsp;
        <br />

    <div id ="tablename" runat="server" >
    
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
        <th  colspan ="10" style=" height: auto"> <h1  style=" margin-top:10px">
            绩效考核规则配置表</h1></th>
    </tr>
  <tr id ="ggxx_tr1">
    <th width="12%" >
        指标名称</th>
    <td width="36%"  colspan="3"><asp:TextBox ID="TB_zbmc" runat="server"  Width="95%"  TabIndex="1"></asp:TextBox><div id="div_rq" style="color:Red;" visible="false"></div></td>
    <th width="12%" >
        指标级别</th>
    <td width="12%">
        <asp:DropDownList ID="DDL_zbjb" runat="server" Width="95%" TabIndex="2">
            <asp:ListItem Value="gsj">公司级</asp:ListItem>
            <asp:ListItem Value="gfj">广泛级</asp:ListItem>
            <asp:ListItem Value="bmj">部门级</asp:ListItem>
        </asp:DropDownList>
    </td>

    <th width="12%" >
        指标属性</th>
    <td width="12%">
        <asp:DropDownList ID="DDL_zbsx" runat="server" Width="95%" TabIndex="2">
            <asp:ListItem Value="yx">有效</asp:ListItem>
            <asp:ListItem Value="wx">无效</asp:ListItem>
        </asp:DropDownList>
    
    </td>
  </tr>
  <tr id ="ggxx_tr2" >
    <th>考核部门1</th>
    <td colspan="5" >
        <asp:CheckBoxList ID="CB_khbm" runat="server" RepeatColumns="5"  >
            <asp:ListItem Value="sbb">设备部</asp:ListItem>
            <asp:ListItem Value="gcb">工程部</asp:ListItem>
            <asp:ListItem Value="zlb">质量部</asp:ListItem>
            <asp:ListItem Value="jsb">技术部</asp:ListItem>
            <asp:ListItem Value="zzb">制造部</asp:ListItem>
            <asp:ListItem Value="swb">商务部</asp:ListItem>
            <asp:ListItem Value="cwb">财务部</asp:ListItem>
            <asp:ListItem Value="xzb">行政部</asp:ListItem>
            <asp:ListItem Value="gyl">供应链管理部</asp:ListItem>
            <asp:ListItem Value="wab">网络安防部</asp:ListItem>
        </asp:CheckBoxList>
    </td>
    <th>考核规则1</th>
    <td ><div id="div1" style="color:Red;" visible="false"></div>
        <asp:DropDownList ID="DDL_khgz" runat="server" Width="95%" TabIndex="2" onchange="javascript:gzchange(this.value,2)" >
            <asp:ListItem Value="A">规则一</asp:ListItem>
            <asp:ListItem Value="B">规则二</asp:ListItem>
            <asp:ListItem Value="C">规则三</asp:ListItem>
            <asp:ListItem Value="N">无规则</asp:ListItem>
        </asp:DropDownList>
    </td>
  </tr> 
   <tr id ="ggxx_tr5" >
    <th>考核部门2</th>
    <td colspan="5" >
        <asp:CheckBoxList ID="CB_f_khbm" runat="server" RepeatColumns="5"  >
            <asp:ListItem Value="sbb">设备部</asp:ListItem>
            <asp:ListItem Value="gcb">工程部</asp:ListItem>
            <asp:ListItem Value="zlb">质量部</asp:ListItem>
            <asp:ListItem Value="jsb">技术部</asp:ListItem>
            <asp:ListItem Value="zzb">制造部</asp:ListItem>
            <asp:ListItem Value="swb">商务部</asp:ListItem>
            <asp:ListItem Value="cwb">财务部</asp:ListItem>
            <asp:ListItem Value="xzb">行政部</asp:ListItem>
            <asp:ListItem Value="gyl">供应链管理部</asp:ListItem>
            <asp:ListItem Value="wab">网络安防部</asp:ListItem>
        </asp:CheckBoxList>
    </td>
    <th></th>
    <td >
    </td>
  </tr> 
  <tr id ="ggxx_tr3" >
    <th>计算公式1</th>
    <td colspan="7" >
        <asp:TextBox ID="TB_jsgs1" runat="server" Width="99%" TabIndex="29"></asp:TextBox><BR />
        计算公式是通过每个输入的值通过计算帮你得出相应的得分如:([B1]+[B2])/[B3]
    </td>
  </tr> 
  <tr id ="ggxx_tr4" >
    <th>指标修改履历</th>
    <td colspan="7" >
        <asp:TextBox ID="TB_zbxgll" TextMode="MultiLine"  runat="server" Width="99%" Height="40px" TabIndex="29"></asp:TextBox>
    </td>
  </tr> 
</table>
    <table id="tab" runat="server" width="600px" cellspacing="0" align="center">
           <tr>
            <th colspan="7"> 
                数据提供部门
            </th>
          </tr>
          <tr>
            <th style="width:10%">
                项目名称</th>
            <th style="width:10%">
                默认值</th>
            <th style="width:10%">
                单位</th>
            <th style="width:10%">
                录入部门</th>
            <th style="width:10%">
                信息编号</th>
            <th style="width:5%"><asp:button  runat="server" id="xm_del"  OnClientClick ="delTr();return false;" text="删除" style="width:58px" /></th>
          </tr>
          <tr> 
            <td style="height: 28px">
                <asp:TextBox ID="TB_xmmc" runat="server" Width="95%" TabIndex="29"></asp:TextBox>
            </td>
             <td style="height: 28px">
                <asp:TextBox ID="TB_mrz" runat="server" Width="95%" TabIndex="29"></asp:TextBox>
            </td>
            <td style="height: 28px">
                <asp:TextBox ID="TB_dw" runat="server" Width="95%"  TabIndex="30" ></asp:TextBox>
            </td>
            <td style="height: 28px">
                <asp:DropDownList id="DDL_lrbm" tabIndex="29" runat="server" Width="95%">
                    <asp:ListItem Value="sbb">设备部</asp:ListItem>
                    <asp:ListItem Value="gcb">工程部</asp:ListItem>
                    <asp:ListItem Value="zlb">质量部</asp:ListItem>
                    <asp:ListItem Value="gyl">供应链管理部</asp:ListItem>
                    <asp:ListItem Value="jsb">技术部</asp:ListItem>
                    <asp:ListItem Value="zzb">制造部</asp:ListItem>
                    <asp:ListItem Value="swb">商务部</asp:ListItem>
                    <asp:ListItem Value="cwb">财务部</asp:ListItem>
                    <asp:ListItem Value="xzb">行政部</asp:ListItem>
                    <asp:ListItem Value="scb">市场部</asp:ListItem>
                    <asp:ListItem Value="zjlms">总经理秘书</asp:ListItem>
                    <asp:ListItem Value="khxz">考核小组</asp:ListItem>
                    <asp:ListItem Value="wab">网络安防部</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td style="height: 28px">
                <asp:TextBox ID="TB_xxbh" runat="server" Width="95%" TabIndex="29">0</asp:TextBox>
            </td>
            <td style="height: 28px">
                <asp:button  runat="server"  id="Button7"  OnClientClick="addTr1('tab', -1);return false;" text="添加"  style="width:58px" TabIndex="33"  />
            </td>
          </tr>
        </table>
        <table width="600px" cellspacing="0" align="center">
        <tr>
        <td  style="vertical-align:middle; text-align:left;">
            ※ 说明：<br />
           1、“规则一”是“月度出货金额”这个指标的专用规则，其他指标不能使用。 <br />
           2、“规则二”适用单一计算的指标，通过计算得出的最终数值和计分表中比较，得出最终的分值。<br />
                   （“改善提案”是此规则的延伸，比较特殊）<br />
           3、“规则三”适用2个计算值分别和不同的计分表比较后，得出最终的分值之和。<br />
           4、“无规则”适用直接填写分值的指标，无需转换。<br />
           5、各部门录入如果是百分比时，在“数据提供部门”中“单位”填写“%”<br />
        </td>
        </tr>
        </table>
    <table id="tab_1" runat="server" width="600px" cellspacing="0" align="center">
          <tr>
            <th colspan="9"> 
                考核规则二
                </th>
          </tr>
          <tr><td>
           <table id="tab1" runat="server" width="590px" cellspacing="0" align="center">
          <tr>
            <th style="width:10%"> 
                运算</th>
            <th style="width:10%">
                数值</th>
            <th style="width:10%">
                单位</th>
            <th style="width:10%">
                关系</th>
            <th style="width:10%">
                运算</th>
            <th style="width:10%">
                数值</th>
            <th style="width:10%">
                单位</th>
            <th style="width:10%">
                得分</th>
            <th style="width:5%"><asp:button  runat="server" id="gz2_del" OnClientClick ="delTr();return false;" text="删除" style="width:58px" /></th>
          </tr>
          <tr>
            <td>
                <asp:DropDownList ID="DDL_gz51" runat="server" Width="95%" TabIndex="2">
                    <asp:ListItem Value="" Selected="True"></asp:ListItem>
                    <asp:ListItem Value=">">＞</asp:ListItem>
                    <asp:ListItem Value=">=" >≥</asp:ListItem>
                    <asp:ListItem Value="==">＝</asp:ListItem>
                    <asp:ListItem Value="<=">≤</asp:ListItem>
                    <asp:ListItem Value="<">＜</asp:ListItem>
                </asp:DropDownList>
            </td>
             <td>
                <asp:TextBox ID="TB_sz51" runat="server" Width="95%" TabIndex="29"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TB_dw51" runat="server" Width="95%"  TabIndex="30" ></asp:TextBox>
            </td>
            <td>
                <asp:DropDownList id="DDL_gx51" tabIndex=2 runat="server" Width="95%">
                    <asp:ListItem Value=""></asp:ListItem>
                    <asp:ListItem Value="&&">and</asp:ListItem>
                    <asp:ListItem Value="||">or</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="DDL_gz52" runat="server" Width="95%" TabIndex="2">
                    <asp:ListItem Value="" Selected="True"></asp:ListItem>
                    <asp:ListItem Value=">">＞</asp:ListItem>
                    <asp:ListItem Value=">=" >≥</asp:ListItem>
                    <asp:ListItem Value="==">＝</asp:ListItem>
                    <asp:ListItem Value="<=">≤</asp:ListItem>
                    <asp:ListItem Value="<" >＜</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="TB_sz52" runat="server" Width="95%"  TabIndex="32"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TB_dw52" runat="server" Width="95%"  TabIndex="32"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TB_df51" runat="server" Width="95%"  TabIndex="32"></asp:TextBox>
            </td>
            <td>
                <asp:button  runat="server"  id="gz_add"  OnClientClick="addTr1('tab1', -1);return false;" text="添加"  style="width:58px" TabIndex="33"  />
            </td>
          </tr>
          </table>
          </td></tr>
          <tr>
            <th align="left" >
                <asp:CheckBox ID="CB_sfta" runat="server"  Text="是否提案改善"  onclick="showta();" />

            </th>
          </tr>
          <tr>
          <td>
          <table id="tab6"   runat="server"  width="360px" align="left">
            <tr>
                <th style="width:10%">
                    等级</th>
                <th style="width:10%">
                    转换数</th>
                <th style="width:10%">
                    单位</th>
                <th style="width:10%">
                    对应值</th>
                <th style="width:5%">
                    <asp:button  runat="server" id="gzfj_del" OnClientClick ="delTr();return false;" text="删除" style="width:58px" />
                </th>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TB_dj61" runat="server" TabIndex="28" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="TB_zhs61" runat="server" TabIndex="29" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="TB_dw61" runat="server" TabIndex="30" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="TB_dyz61" runat="server" TabIndex="30" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:button  runat="server"  id="Button11"  OnClientClick="addTr1('tab6', -1);return false;" text="添加"  style="width:58px" TabIndex="33"  />
                </td>
            </tr>
        </table>
          </td>
          </tr>
        </table>
        <table id="tab_2" runat="server" width="600px" cellspacing="0" align="center">
        <tr>
        <th colspan="2">
            考核规则三
        </th>
        </tr>
        <tr >
        
        <td width="295px" >
        <table  width="295px" id="tab2" runat="server" cellspacing="0" align="center">
            <tr>
                <th colspan="5">提出部门/缺件/延误
                </th>
            </tr>        
            <tr>
                <th style="width:10%">
                    运算</th>
                <th style="width:10%">
                    数值</th>
                <th style="width:10%">
                    单位</th>
                <th style="width:10%">
                    得分</th>
                <th style="width:5%">
                    <asp:button  runat="server" id="gz31_del" OnClientClick ="delTr();return false;" text="删除" style="width:58px" /></th>
            </tr>
            <tr>
                <td >
                    <asp:DropDownList ID="DDL_gz21" runat="server" Width="95%" TabIndex="2">
                        <asp:ListItem Value="" Selected="True"></asp:ListItem>
                        <asp:ListItem Value=">">＞</asp:ListItem>
                        <asp:ListItem Value=">=" >≥</asp:ListItem>
                        <asp:ListItem Value="==">＝</asp:ListItem>
                        <asp:ListItem Value="=<">≤</asp:ListItem>
                        <asp:ListItem Value="<">＜</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="TB_sz21" runat="server" TabIndex="29" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="TB_dw21" runat="server" TabIndex="30" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="TB_df21" runat="server" TabIndex="31" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:button  runat="server"  id="Button3"  OnClientClick="addTr1('tab2', -2);return false;" text="添加"  style="width:58px" TabIndex="33"  />
                </td>
            </tr>
            <tr>
                <th>
                   对应项目 
                </th>
                <td colspan="4">
                    <asp:TextBox ID="TB_dygs1" runat="server" TabIndex="29" Width="95%"></asp:TextBox>
                </td>
                
            </tr>
        </table >
        </td><td width="295px" >
        <table  width="295px" id="tab4" runat="server" cellspacing="0" align="center">
            <tr>
                <th colspan="5">被表扬部门/被投诉部门/迟交/差错
                </th>
            </tr>
            <tr>
                <th style="width:10%">
                    运算</th>
                <th style="width:10%">
                    数值</th>
                <th style="width:10%">
                    单位</th>
                <th style="width:10%">
                    得分</th>
                <th style="width:5%">
                    <asp:button  runat="server" id="gz32_del"  OnClientClick ="delTr();return false;" text="删除" style="width:58px" /></th>
            </tr>
            <tr>
                <td >
                    <asp:DropDownList ID="DDL_gz41" runat="server" Width="95%" TabIndex="2">
                        <asp:ListItem Value="" Selected="True"></asp:ListItem>
                        <asp:ListItem Value=">">＞</asp:ListItem>
                        <asp:ListItem Value=">=" >≥</asp:ListItem>
                        <asp:ListItem Value="==">＝</asp:ListItem>
                        <asp:ListItem Value="=<">≤</asp:ListItem>
                        <asp:ListItem Value="<">＜</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="TB_sz41" runat="server" TabIndex="29" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="TB_dw41" runat="server" TabIndex="30" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="TB_df41" runat="server" TabIndex="31" Width="95%"></asp:TextBox>
                </td>
                <td>
                    <asp:button  runat="server"  id="Button9"  OnClientClick="addTr1('tab4', -2);return false;" text="添加"  style="width:58px" TabIndex="33"  />
                </td>
            </tr>
            <tr>
                <th>
                   对应项目
                </th>
                <td colspan="4">
                    <asp:TextBox ID="TB_dygs2" runat="server" TabIndex="29" Width="95%"></asp:TextBox>
                </td>
                
            </tr>
        </table >
        </td>
        </tr>
        </table>
        <table id="tab3" runat="server" width="600px" cellspacing="0" align="center">
            <tr>
                <th>
                    考核规则一
                </th>
            </tr>
            <tr>
            <td>
        <table width="300px" align="left">
            <tr>
                <th style="width:10%">
                    考核幅度</th>
                <td style="width:10%">
                    <asp:TextBox ID="TB_khfd" runat="server" TabIndex="28" Width="95%"></asp:TextBox></td>
                <th style="width:10%">
                    分/点</th>
            </tr>
            <tr>
                <th style="width:10%">
                    最高分</th>
                <td style="width:10%">
                    <asp:TextBox ID="TB_zgf" runat="server" TabIndex="28" Width="95%"></asp:TextBox></td>
                <th style="width:10%">
                    分</th>
            </tr>
            <tr>
                <th style="width:10%">
                    最低分</th>
                <td style="width:10%">
                    <asp:TextBox ID="TB_zdf" runat="server" TabIndex="28" Width="95%"></asp:TextBox></td>
                <th style="width:10%">
                    分</th>
            </tr>
            <tr>
                <th style="width:10%">
                    发货金额高出</th>
                <td style="width:10%">
                    <asp:TextBox ID="TB_zhgc" runat="server" TabIndex="28" Width="95%"></asp:TextBox></td>
                <th style="width:10%">
                    元</th>
            </tr>
            <tr>
                <th style="width:10%">
                    考核分小于</th>
                <td style="width:10%">
                    <asp:TextBox ID="TB_khfxy" runat="server" TabIndex="28" Width="95%"></asp:TextBox></td>
                <th style="width:10%">
                    分</th>
            </tr>
            <tr>
                <th style="width:10%">
                    补足</th>
                <td style="width:10%">
                    <asp:TextBox ID="TB_bz" runat="server" TabIndex="28" Width="95%"></asp:TextBox></td>
                <th style="width:10%">
                    分</th>
            </tr>
            
           
        </table>
            </td>
            </tr>
        </table>
         
 </div>

<div id="dialog-form" title="物料信息">
    &nbsp;</div>
        <asp:button text=" 保  存 " runat="server" style="width:80px" id="B_save" OnClick="B_save_Click" OnClientClick="return SaveClick();" TabIndex="42"/>
        &nbsp; &nbsp;&nbsp;
        <input id="Button2" type="button" value="返回列表" style="width:80px" onclick="window.location.href('jxkh_bmlr_lb.aspx');" />
        
        &nbsp;
        <asp:HiddenField ID="bl" runat="server"  Value="0" />
        <asp:HiddenField ID="gz1" runat="server"  Value="0" />
        <asp:HiddenField ID="gz2" runat="server"  Value="0" />
        <asp:HiddenField ID="gz3" runat="server"  Value="0" />
        <asp:HiddenField ID="gz4" runat="server"  Value="0" />
        <asp:HiddenField ID="gz6" runat="server"  Value="0" />
        <asp:HiddenField ID="HF_id" runat="server" />
        <asp:HiddenField ID="HF_bhxx_max" runat="server" />
 </form>

<input type="hidden" name="prevTrIndex" id="prevTrIndex" value="-1" /> 
<script type ="text/javascript"  >
    gzchange($("#DDL_khgz").val());
    showta();
</script>

   
</body>
</html>
