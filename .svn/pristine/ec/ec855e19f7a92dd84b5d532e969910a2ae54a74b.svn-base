<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jpscrb.aspx.cs" Inherits="sclr_jpscrb" EnableEventValidation="false" %>
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
<script src="../jquery-ui/ui/jquery.ui.position.js"></script>
<script src="../jquery-ui/ui/jquery.ui.menu.js"></script>
<script src="../jquery-ui/ui/jquery.ui.autocomplete.js"></script>
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
      function addTr(tab, row, trHtml){
         //获取table最后一行 $("#tab tr:last")
         //获取table第一行 $("#tab tr").eq(0)
         //获取table倒数第二行 $("#tab tr").eq(-2)
         var $tr=$("#"+tab+" tr").eq(row-1);
         if($tr.size()==0){
            alert("指定的table id或行数不存在！");
            return;
         }
         $tr.after(trHtml);
         
         if (tab=="tab1"){
             sxkz();
             document.getElementById("DDL_sx" + $('#wl').val()  ).value= $("#DDL_sx").val();
             $("#DDL_sx").val("");
         }
         bfjs();
      }
      function addTr2(tab, row){
            var trHtml="";
            if(tab=="tab"){
                var b=parseInt($('#bl').val());
                b=b+1;
                $('#bl').val(b);
                document.getElementById("TB_bldm").focus();
                var blsl=$("#TB_blsl").val();
                if( blsl.length==0)
                {
                    alert("不良品是否不能为空!");
                    document.getElementById("TB_blsl").focus();
                    return false;
                }   
                if( $("#TB_bldm").val()=="" )
                {
                    alert("不良品代码不能为空!");
                    document.getElementById("TB_bldm").focus();
                    return false;
                }
                if( $("#TB_blmc").val()=="" )
                {
                    alert("不良品名称不能为空!");
                    document.getElementById("TB_blmc").focus();
                    return false;
                }    
                trHtml="<tr><td><input  type='text'  style='width:95%' name='TB_bldm"+ b +"'   id='TB_bldm"+ b +"'  value='"+ $('#TB_bldm').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_bllb"+ b +"'   id='TB_bllb"+ b +"'  value='"+ $('#TB_bllb').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_blmc"+ b +"'   id='TB_blmc"+ b +"' value='"+ $('#TB_blmc').val() +"' /></td>"
                        +"  <td><input  type='text' onchange='bfjs();' style='width:95%' name='TB_blsl"+ b +"'   id='TB_blsl"+ b +"' value='"+ $('#TB_blsl').val() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_blbz"+ b +"'   id='TB_blbz"+ b +"' value='"+ $('#TB_blbz').val() +"'/></td>"
                        +"  <td><input type='checkbox' name='ckb'/></td></tr>"
                $('#TB_blmc').val("");
                $('#TB_bldm').val("");
                $('#TB_bllb').val("");
                $('#TB_blsl').val("");
                $('#TB_blbz').val("");
                  
            }else{
                var w=parseInt($('#wl').val());
                w=w+1;
                $('#wl').val(w);
                 var sl=$("#TB_sl").val();
                 document.getElementById("TB_wlbh").focus();
                if( sl.length==0)
                {
                    alert("物料数量不能为空!");
                    document.getElementById("TB_sl").focus();
                    return false;
                }
                if( $("#TB_wlbh").val()=="")
                {
                    alert("物料代码不能为空!");
                    document.getElementById("TB_wlbh").focus();
                    return false;
                }
                if( $("#TB_wlmc").val()=="")
                {
                    alert("物料名称不能为空!");
                    document.getElementById("TB_wlmc").focus();
                    return false;
                }
                  
                  
                trHtml="<tr><td> <select   style='width:95%' name='DDL_sx" + w + "' ID='DDL_sx" + w + "'  ><option></option><option value='返料'>返料</option><option value='材料报废'>材料报废</option><option value='混批转入'>混批转入</option> </select> </td>  "
                       +" <td><input  type='text'  style='width:95%' name='TB_wlbh"+ w +"'   id='TB_wlbh"+ w +"' value='"+ $('#TB_wlbh').val() +"'/></td> "
                       +" <td><input  type='text'  style='width:95%' name='TB_wlmc"+ w +"'   id='TB_wlmc"+ w +"' value='"+ $('#TB_wlmc').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_wlpc"+ w +"'   id='TB_wlpc"+ w +"' value='"+ $('#TB_wlpc').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_gys"+ w +"'  id='TB_gys"+ w +"' value='"+ $('#TB_gys').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_gg"+ w +"'  id='TB_gg"+ w +"' value='"+ $('#TB_gg').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_qmsl"+ w +"'  id='TB_qmsl"+ w +"' value='"+ $('#TB_qmsl').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' onchange='bfjs()'  name='TB_sl"+ w +"'  id='TB_sl"+ w +"' value='"+ $('#TB_sl').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_dw"+ w +"'  id='TB_dw"+ w +"' value='"+ $('#TB_dw').val() +"'/></td>"
                       +" <td><input  type='checkbox' name='ckb'/></td></tr>";
                $("#TB_wlbh").val(""); 
                $("#TB_wlmc").val(""); 
                $("#TB_wlpc").val(""); 
                $("#TB_qmsl").val("");
                $("#TB_gys").val(""); 
                $("#TB_gg").val(""); 
                $("#TB_sl").val(""); 
                $("#TB_dw").val(""); 
                
            }
            

            addTr(tab, row, trHtml);
        }
        
        function getwlxx(){
            
            var data = "{'wlxx':{'Ckbh':'"+ $("#DDL_gxmc").val() +"','Wlbh':'"+ $("#TB_wlbh").val() +"','Wlmc':'"+ $("#TB_wlmc").val() +"','Sx':'"+ $("#DDL_sx").val() +"','Wlpc':'"+ $("#TB_pc").val() +"','Sl':'1','Dw':'pcs','Gys':'"+ $("#TB_gys").val() +"'}}";
            $.ajax({
                type: "POST",
                url: "../GetContent.asmx/GetwlxxArrayList",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function(json) {  $(json).each(function() { 
                        var trHtml="<tr><th><input type='checkbox' name='wlxx_dx'  /></th><td>"+ this.Ckbh +"</td><td>"+ this.Wlbh +"</td><td>"+ this.Wlmc +"</td><td>"+ this.Wlpc +"</td><td>"+ this.Gys +"</td><td>"+ this.Gg +"</td><td>"+ this.Sl +"</td><td>"+ this.Dw +"</td></tr>";
                        var $tr=$("#wlxx tbody");
//                        if($tr.size()==0){
//                            alert("指定的table id或行数不存在！");
//                            return;
//                        }
                        $tr.append(trHtml);
                    
                    });
                    trSize = $("#wlxx tbody tr").size();//datagrid中tr的数量 
                    $("#wlxx tbody tr").mouseover(function(){//鼠标滑过 
	                    $(this).addClass("hover"); 
                    }).mouseout(function(){ //鼠标滑出 
	                    $(this).removeClass("hover"); 
                    }).each(function(i){ //初始化 id 和 index 属性 
		                $(this).attr("id", "tr_" + i).attr("index", i); 
		                $(this).find("input").each(function() {
                           $(this).val(i);
                        });
	                }).dblclick(function(){ //鼠标单击 
		                //clickTr($(this).attr("index")); 
		                $("#TB_wlbh").val(($(this).find("td")[1]).innerHTML); 
                        $("#TB_wlmc").val(($(this).find("td")[2]).innerHTML); 
                        $("#TB_wlpc").val(($(this).find("td")[3]).innerHTML); 
                        $("#TB_gys").val(($(this).find("td")[4]).innerHTML); 
                        $("#TB_gg").val(($(this).find("td")[5]).innerHTML); 
                        $("#TB_qmsl").val(($(this).find("td")[6]).innerHTML); 
                        $("#TB_dw").val(($(this).find("td")[7]).innerHTML); 
		                $("#dialog-form").dialog("close");
		                $("#TB_sl").focus();
	                });//.dblclick(function(){ //鼠标双击 
		              //   $("#TB_wlbh").val(($(this).find("td")[1]).innerHTML); 
	                  //}); 
	                  
                   
           	                  
	                if (trSize>0) //如果trSize大于零代表有数据 点亮从零行开始
                    {
                        clickTr(0); 
                    } 
                },
                error: function(error) {
                    alert("调用出错" + error.responseText);
                }
                
            });

        }
        
        
        
        
        function getblxx(){
            
            var data = "{'blp':{'Blmc':'"+ $("#TB_blmc").val() +"','Bldm':'"+ $("#TB_bldm").val() +"','Blsl':0,'Blbz':'','Bllb':'"+ $("#DDL_gxmc").val() +"'}}";
            $.ajax({
                type: "POST",
                url: "../GetContent.asmx/GetCPDMZTList",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function(json) {  $(json).each(function() { 
                        var trHtml="<tr><th><input type='checkbox' name='blxx_dx'  /></th><td>"+ this.Blmc +"</td><td>"+ this.Bldm +"</td><td>"+ this.Bllb +"</td></tr>";
                        var $tr=$("#blxx tbody");
//                        if($tr.size()==0){
//                            alert("指定的table id或行数不存在！");
//                            return;
//                        }
                        $tr.append(trHtml);
                    
                    });
                    trSize = $("#blxx tbody tr").size();//datagrid中tr的数量 

                    $("#blxx tbody tr").mouseover(function(){//鼠标滑过 
	                    $(this).addClass("hover"); 
                    }).mouseout(function(){ //鼠标滑出 
	                    $(this).removeClass("hover"); 
                    }).each(function(i){ //初始化 id 和 index 属性 
		                $(this).attr("id", "tr_" + i).attr("index", i); 
		                $(this).find("input").each(function() {
                           $(this).val(i);
                        });
	                }).dblclick(function(){ //鼠标单击 
		                //clickTr($(this).attr("index")); 
		                $("#TB_blmc").val(($(this).find("td")[0]).innerHTML); 
                        $("#TB_bldm").val(($(this).find("td")[1]).innerHTML); 
                        $("#TB_bllb").val(($(this).find("td")[2]).innerHTML); 
		                $("#dialog-form").dialog("close");
		                $("#TB_blsl").focus();
                    });
                    if (trSize>0) //如果trSize大于零代表有数据 点亮从零行开始
                    {
                        clickTr(0); 
                    }

                },
                error: function(error) {
                    alert("调用出错" + error.responseText);
                }
                
            });

        }
        
        function bfjs()
        {
            var gxmc=$("#DDL_gxmc").val();
            var bfsl=0;
            var bfslf=0;
            var bfslz=0;
            var hgp=0;
            var dclp=0;
            var dzp=0;
            var bmlq=0;

            if (gxmc=="40" ){
                for(var i=1;i<25;i++){
                    var bf=$("#TB_sl"+i).val();
                    var blbf=$("#TB_blsl"+i).val();
                    var lb=$("#TB_bllb"+i).val();
                    if (bf!=""  && bf!=undefined && $("#DDL_sx"+i).val()=="正极报废"){
                        bfslz += parseInt(bf);
                    }
                    if (bf!=""  && bf!=undefined && $("#DDL_sx"+i).val()=="负极报废"){
                        bfslf += parseInt(bf);
                    }
                    if (blbf!=""  && blbf!=undefined && lb=="报废品"){
                        bfsl += parseInt(blbf);
                    }
                    if (blbf!=""  && blbf!=undefined && lb=="合格品"){
                        hgp += parseInt(blbf);
                    }
                    if (blbf!=""  && blbf!=undefined && lb=="次品"){
                        dzp += parseInt(blbf);
                    }
                    if (blbf!=""  && blbf!=undefined && lb.substring(2,4)=="领取"){
                        bmlq += parseInt(blbf);
                    }
                    if (blbf!=""  && blbf!=undefined && lb=="待处理品"){
                        dclp += parseInt(blbf);
                    }
                }
                if ($("#TB_sl").val()!=""  && $("#TB_sl").val()!=undefined && $("#DDL_sx").val()=="正极报废"){
                        bfslz += parseInt($("#TB_sl").val());
                    }
                if ($("#TB_sl").val()!=""  && $("#TB_sl").val()!=undefined && $("#DDL_sx").val()=="负极报废"){
                        bfslf += parseInt($("#TB_sl").val());
                    }
                var tb_bf=$("#TB_blsl").val();
                var tb_lb=$("#TB_bllb").val();
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb=="报废品"){
                        bfsl += parseInt(tb_bf);
                    } 
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb=="合格品"){
                        hgp += parseInt(tb_bf);
                    } 
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb=="次品"){
                        dzp += parseInt(tb_bf);
                    }
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb.substring(2,4)=="领取"){
                        bmlq += parseInt(tb_bf);
                    }
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb=="待处理品"){
                        dclp += parseInt(tb_bf);
                    }
                 $("#TB_bfsl1").val(bfslz);
                 $("#TB_bfsl2").val(bfslf);
                 $("#HF_FP").val(bfsl);
                 $("#HF_HGP").val(hgp);
                 $("#HF_DZP").val(dzp);
                 $("#HF_BMLQ").val(bmlq);
                 $("#HF_DCLP").val(dclp);
                
            }else{
                for(var i=1;i<25;i++){
                    var bf=$("#TB_blsl"+i).val();
                    var lb=$("#TB_bllb"+i).val();
                    if (bf!=""  && bf!=undefined && lb=="报废品"){
                        bfsl += parseInt(bf);
                    }
                    if (bf!=""  && bf!=undefined && lb=="合格品"){
                        hgp += parseInt(bf);
                    }
                    if (bf!=""  && bf!=undefined && lb=="次品"){
                        dzp += parseInt(bf);
                    }
                    if (bf!=""  && bf!=undefined && lb.substring(2,4)=="领取"){
                        bmlq += parseInt(bf);
                    }
                    if (bf!=""  && bf!=undefined && lb=="待处理品"){
                        dclp += parseInt(bf);
                    }
                }
                var tb_bf=$("#TB_blsl").val();
                var tb_lb=$("#TB_bllb").val();
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb=="报废品"){
                        bfsl += parseInt(tb_bf);
                    }
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb=="合格品"){
                        hgp += parseInt(tb_bf);
                    } 
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb=="次品"){
                        dzp += parseInt(tb_bf);
                    }
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb.substring(2,4)=="领取"){
                        bmlq += parseInt(tb_bf);
                    }
                if (tb_bf!=""  && tb_bf!=undefined && tb_lb=="待处理品"){
                        dclp += parseInt(tb_bf);
                    }
                 $("#TB_bfsl1").val(bfsl);
                 $("#HF_FP").val(bfsl);
                 $("#HF_HGP").val(hgp);
                 $("#HF_DZP").val(dzp);
                 $("#HF_BMLQ").val(bmlq);
                 $("#HF_DCLP").val(dclp);
            }
            cyjs();
        }
        
        function cyjs()   //差异计算
        {
            var gxmc=$("#DDL_gxmc").val();
            var cys=0;
            if (gxmc=="40" ){
                //正极
                for(var i=1;i<5;i++){
                    var qrjc=$("#TB_qrjc"+i).val();
                    if (qrjc!=""  && qrjc!=undefined && i!=2){
                        cys+=parseInt(qrjc)
                    }
                    var drzr=$("#TB_drzr"+i).val();
                    if (drzr!=""  && drzr!=undefined && i==1){
                        cys+=parseInt(drzr)
                    }
                    var drzc=$("#TB_drzc"+i).val();
                    if (drzc!=""  && drzc!=undefined && i==1){
                        cys-=parseInt(drzc)
                    }
                    var drjc=$("#TB_drjc"+i).val();
                    if (drjc!=""  && drjc!=undefined && i!=2){
                        cys-=parseInt(drjc)
                    }
                }
                var bfsl=$("#TB_bfsl1").val();
                if (bfsl!=""  && bfsl!=undefined){
                        cys-=parseInt(bfsl)
                }
                $("#TB_cy1").val(cys);
                //负极
                cys=0;
                for(var i=1;i<5;i++){
                    var qrjc=$("#TB_qrjc"+i).val();
                    if (qrjc!=""  && qrjc!=undefined && i!=1){
                        cys+=parseInt(qrjc)
                    }
                    var drzr=$("#TB_drzr"+i).val();
                    if (drzr!=""  && drzr!=undefined && i==2){
                        cys+=parseInt(drzr)
                    }
                    var drzc=$("#TB_drzc"+i).val();
                    if (drzc!=""  && drzc!=undefined && i==1){
                        cys-=parseInt(drzc)
                    }
                    var drjc=$("#TB_drjc"+i).val();
                    if (drjc!=""  && drjc!=undefined && i!=1){
                        cys-=parseInt(drjc)
                    }
                }
                bfsl=$("#TB_bfsl2").val();
                if (bfsl!=""  && bfsl!=undefined){
                        cys-=parseInt(bfsl)
                }
                $("#TB_cy2").val(cys);
            }else {
                for(var i=1;i<5;i++){
                    var qrjc=$("#TB_qrjc"+i).val();
                    if (qrjc!=""  && qrjc!=undefined){
                        cys+=parseInt(qrjc)
                    }
                    var drzr=$("#TB_drzr"+i).val();
                    if (drzr!=""  && drzr!=undefined){
                        cys+=parseInt(drzr)
                    }
                }
                for(var i=1;i<7;i++){
                    var drzc=$("#TB_drzc"+i).val();
                    if (drzc!=""  && drzc!=undefined){
                        cys-=parseInt(drzc)
                    }
                    var drjc=$("#TB_drjc"+i).val();
                    if (drjc!=""  && drjc!=undefined){
                        cys-=parseInt(drjc)
                    }
                }
                var bfsl=$("#TB_bfsl1").val();
                if (bfsl!=""  && bfsl!=undefined){
                        cys-=parseInt(bfsl)
                }
                
                $("#TB_cy1").val(cys);
            }
        }
        
        function clickTr(currTrIndex){ 
		    var prevTrIndex = $("#prevTrIndex").val();   //前一个hover行数
		    if (currTrIndex > -1){   //现在移动到的行数
			    $("#tr_" + currTrIndex).addClass("hover"); 
		    } 
		    if (prevTrIndex!=currTrIndex){   //只有在行数移动了以后才会删除前一个行数的hover
		        $("#tr_" + prevTrIndex).removeClass("hover"); 
		    }
		    $("#prevTrIndex").val(currTrIndex); 
		    
	    } 
        
        
        function addCZXX(tab, row, trHtml){
         //获取table最后一行 $("#tab tr:last")
         //获取table第一行 $("#tab tr").eq(0)
         //获取table倒数第二行 $("#tab tr").eq(-2) 
        }
      
        function duoxuan(bgmc){
            var bgmcs=$("input[name="+bgmc+"]:checked");
            if(bgmcs.size()==0){
                return;
            }
            var w=parseInt($('#wl').val());
            var b=parseInt($('#bl').val());
            var trHtml="";
            if (bgmc=="wlxx_dx"){
                if (bgmcs.size()>0){
                    bgmcs.each(function(){
                        w=w+1;
                        trHtml="<tr><td> <select   style='width:95%' name='DDL_sx" + w + "' ID='DDL_sx" + w + "'  ><option></option><option value='返料'>返料</option><option value='材料报废'>材料报废</option><option value='混批转入'>混批转入</option> </select> </td>  "
                           +" <td><input  type='text'  style='width:95%' name='TB_wlbh"+ w +"'   id='TB_wlbh"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[1]).innerHTML +"'/></td> "
                           +" <td><input  type='text'  style='width:95%' name='TB_wlmc"+ w +"'   id='TB_wlmc"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[2]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_wlpc"+ w +"'   id='TB_wlpc"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[3]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_gys"+ w +"'  id='TB_gys"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[4]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_gg"+ w +"'  id='TB_gg"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[5]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_qmsl"+ w +"'  id='TB_qmsl"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[6]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' onchange='bfjs()'  name='TB_sl"+ w +"'  id='TB_sl"+ w +"' value=''/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_dw"+ w +"'  id='TB_dw"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[7]).innerHTML +"'/></td>"
                           +" <td><input  type='checkbox' name='ckb'/></td></tr>";
                        $('#wl').val(w);
                        addTr("tab1",-1, trHtml);
                    });
                    $("#TB_wlbh").val(""); 
                    $("#TB_wlmc").val(""); 
                    $("#TB_wlpc").val(""); 
                    $("#TB_gys").val(""); 
                    $("#TB_gg").val(""); 
                    $("#TB_sl").val(""); 
                    $("#TB_dw").val("");
                }
                
            }else{
                if (bgmcs.size()>0){
                    bgmcs.each(function(){
                        b=b+1;
                        trHtml="<tr><td><input  type='text'  style='width:95%' name='TB_bldm"+ b +"'   id='TB_bldm"+ b +"'  value='"+ ($("#tr_" + $(this).val()).find("td")[1]).innerHTML +"'/></td>"
                                +"  <td><input  type='text'  style='width:95%' name='TB_bllb"+ b +"'   id='TB_bllb"+ b +"'  value='"+ ($("#tr_" + $(this).val()).find("td")[2]).innerHTML +"'/></td>"
                                +"  <td><input  type='text'  style='width:95%' name='TB_blmc"+ b +"'   id='TB_blmc"+ b +"' value='"+ ($("#tr_" + $(this).val()).find("td")[0]).innerHTML +"' /></td>"
                                +"  <td><input  type='text' onchange='bfjs();' style='width:95%' name='TB_blsl"+ b +"'   id='TB_blsl"+ b +"' value=''/></td>"
                                +"  <td><input  type='text'  style='width:95%' name='TB_blbz"+ b +"'   id='TB_blbz"+ b +"' value=''/></td>"
                                +"  <td><input type='checkbox' name='ckb'/></td></tr>"
                         addTr("tab",-1, trHtml);
                    });
                $('#TB_blmc').val("");
                $('#TB_bldm').val("");
                $('#TB_bllb').val("");
                $('#TB_blsl').val("");
                $('#TB_blbz').val("");
                }
                $('#bl').val(b);
            }
        }
      
      function delTr(ckb){
        //获取选中的复选框，然后循环遍历删除
        var ckbs=$("input[name="+ckb+"]:checked");
        if(ckbs.size()==0){
            alert("要删除指定行，需选中要删除的行！");
                return;
            }
            ckbs.each(function(){
                var data="";
                var del_ID=$(this).val();
                if (del_ID.substr(0,2)=="bl" || (del_ID.substr(0,2)=="wl"))
                {
                    if (del_ID.substr(0,2)=="bl"){
                        data="{'sgrb':{'Id':'"+ $("#HF_id").val() +"','Blid':'"+$("#"+del_ID ).val()+"','Wlid':'0'}}";
                    }else if (del_ID.substr(0,2)=="wl"){
                        data="{'sgrb':{'Id':'"+ $("#HF_id").val() +"','Blid':'0','Wlid':'"+$("#"+del_ID ).val() +"'}}";
                    }
                    $.ajax({
                        type: "POST",
				        url: "../GetContent.asmx/Del_sgrb_bl_wl",
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
   
      /**
       * 全选
       * 
       * allCkb 全选复选框的id
       * items 复选框的name
       */
       
      function allCheck(allCkb, items){
        $("#"+allCkb).click(function(){
          $('[name='+items+']:checkbox').attr("checked", this.checked);
        });
      }
   
      ////////添加一行、删除一行测试方法///////
      $(function(){
       //全选
       allCheck("allCkb", "ckb");
      });
  
    function delTr2(){
        delTr('ckb');
    }
    
//    function EnterTextBox()
//    {
//        //判断当event.keyCode 为37时（即左方面键），执行函数to_left();  
//        //判断当event.keyCode 为39时（即右方面键），执行函数to_right();  

//        if(event.keyCode == 38){  
//            var prevTrIndex = parseInt($("#prevTrIndex").val()); 
//            if (prevTrIndex == -1 || prevTrIndex == 0){ 
//                clickTr(trSize - 1); 
//            } else if(prevTrIndex > 0){ 
//                clickTr(prevTrIndex - 1); 
//            } 
//            //return false;    
//        }else if (event.keyCode == 40){   
//            var prevTrIndex = parseInt($("#prevTrIndex").val()); 
//            if (prevTrIndex == -1 || prevTrIndex == (trSize - 1)){ 
//                clickTr(0); 
//            } else if (prevTrIndex < (trSize - 1)) { 
//                clickTr(prevTrIndex + 1); 
//            } 
//            //return false; 
//        } 
//    }
//    
    
    function SaveClick()
    {
        var zt=0
        if ($("#DDL_gxmc").val()!=10 && $("#DDL_gxmc").val()!=25  ){
            var rl=$("#TB_rl").val()
            if( rl=="")
            {
                $("#div_rl").text("*电芯容量不能为空!");
                $("#div_rl").show();
                document.getElementById("TB_rl").focus();
                zt=1;
            }else{
                $("#div_rl").hide();
            }
            var xh=$("#TB_xh").val();
            if( xh.length<9 || xh.substr(0,2)!="FT")
            {
                $("#div_xh").text("*电芯型号格式不正确!");  
                $("#div_xh").show();
                document.getElementById("TB_xh").focus();
                 zt=1;
            }else{
                $("#div_xh").hide();
            }
        }
        var pc=$("#TB_pc").val();
        var fqts=$("#TB_fqts").val();
        if ($("#DDL_gxmc").val()==10 || $("#DDL_gxmc").val()==25  ){
            if( pc.length!=6)
            {
                $("#div_pc").text("*生产批次位数不正确!");
                $("#div_pc").show();
                document.getElementById("TB_pc").focus();
                 zt=1;
            }else{
                $("#div_pc").hide();
            }
            
            if( fqts.length!=3 && fqts.length!=6)
            {
                $("#div_fqts").text("*配方版本必须是3位或者6位!");
                $("#div_fqts").show();
                document.getElementById("TB_fqts").focus();
                 zt=1;
            }else{
                $("#div_fqts").hide();
            }
            
        }else{
            if( pc.length<10 || pc.length>11)
            {
                $("#div_pc").text("*生产批次位数不正确!");
                $("#div_pc").show();
                document.getElementById("TB_pc").focus();
                 zt=1;
            }else{
                $("#div_pc").hide();
            }
            
            if( fqts.length==0)
            {
                $("#div_fqts").text("*分切条数不能为空!");
                $("#div_fqts").show();
                document.getElementById("TB_fqts").focus();
                 zt=1;
            }else{
                $("#div_fqts").hide();
            }
        }
        var rq=$("#TB_rq").val();
        if( rq.length==0)
        {
            $("#div_rq").text("*生产日期不能为空!");
            $("#div_rq").show();
            document.getElementById("TB_rq").focus();
             zt=1;
        }else{
            $("#div_rq").hide();
        }
        

        var bfsl1=$("#TB_bfsl1").val();
        if( bfsl1.length==0)
        {
            $("#div_bfsl1").text("*报废数量不能为空!");
            $("#div_bfsl1").show();
            document.getElementById("TB_bfsl1").focus();
             zt=1;
        }else{
            $("#div_bfsl1").hide();
        }
        var cy1=$("#TB_cy1").val();
        if( cy1.length==0)
        {
            $("#div_cy1").text("*差异数不能为空!");
            $("#div_cy1").show();
            document.getElementById("TB_cy1").focus();
             zt=1;
        }else{
            $("#div_cy1").hide();
        }
        var cy2=$("#TB_cy2").val();
        if( cy2.length==0)
        {
            $("#div_cy2").text("*差异数不能为空!");
            $("#div_cy2").show();
            document.getElementById("TB_cy2").focus();
             zt=1;
        }else{
            $("#div_cy2").hide();
        }
        var bfsl2=$("#TB_bfsl2").val();
        if( bfsl2.length==0)
        {
            $("#div_bfsl2").text("*报废数不能为空!");
            $("#div_bfsl2").show();
            document.getElementById("TB_bfsl2").focus();
             zt=1;
        }else{
            $("#div_bfsl2").hide();
        }
        
        
        if( $("#TB_bldm").val().length!=0 && $("#TB_blsl").val()=="")
        {
            $("#div_bldm").text("*不良品数量不能为空!");
            $("#div_bldm").show();
            document.getElementById("TB_blsl").focus();
             zt=1;
        }else{
            $("#div_bldm").hide();
        }
        
        if( $("#TB_wlbh").val().length!=0 && $("#TB_sl").val()=="" )
        {
            $("#div_wlbh").text("*物料数量不能为空!");
            $("#div_wlbh").show();
            document.getElementById("TB_sl").focus();
             zt=1;
        }else{
            $("#div_wlbh").hide();
        }
        
//        var cy=$("#TB_cy1").val();
//        if( cy.length!=0 && cy!="0" )
//        {
//            $("#div_cy1").text("*请确认差异数是否正确!");
//            $("#div_cy1").show();
//            document.getElementById("TB_cy1").focus();
//            zt=1;
//        }else{
//            $("#div_cy1").hide();
//        }

        for(var i=1;i<25;i++){
            var wlbh=$("#TB_wlbh"+i).val();
            if( wlbh!=undefined && wlbh.length!=0 && wlbh.substr(0,1)=="1"  )
            {
                for(s=i+1;s<25;s++){
                    if (wlbh==$("#TB_wlbh"+s).val() && ($("#DDL_sx"+s).val()== null || $("#DDL_sx"+s).val()== "" )&& ($("#DDL_sx"+i).val()=="" || $("#DDL_sx"+i).val()== null)  ){
                        $("#div_wlbh").show();
                        $("#div_wlbh").text("*出现2个相同物料");
                        s=25;
                        i=25;
                        zt=1;
                    }
                }
            }else{
                $("#div_wlbh").hide();
            }
        }
        
        
        for(var i=1;i<5;i++){
            var qrjc=$("#TB_qrjc"+i).val();
            if( qrjc!=undefined && qrjc.length==0  )
            {
                $("#div_qrjc"+i).text("*数值不能为空!");
                $("#div_qrjc"+i).show();
                document.getElementById("TB_qrjc"+i).focus();
                zt=1;
            }else{
                $("#div_qrjc"+i).hide();
            }
        }
        
        for(var i=1;i<5;i++){
            var qrjc=$("#TB_drzr"+i).val();
            if( qrjc!=undefined && qrjc.length==0  )
            {
                $("#div_drzr"+i).text("*数值不能为空!");
                $("#div_drzr"+i).show();
                document.getElementById("TB_drzr"+i).focus();
                zt=1;
            }else{
                $("#div_drzr"+i).hide();
            }
        
        }
        
        for(var i=1;i<4;i++){
            var qrjc=$("#TB_drsc"+i).val();
            if( qrjc!=undefined && qrjc.length==0  )
            {
                $("#div_drsc"+i).text("*数值不能为空!");
                $("#div_drsc"+i).show();
                document.getElementById("TB_drsc"+i).focus();
                zt=1;
            }else{
                $("#div_drsc"+i).hide();
            }
        
        }
        for(var i=1;i<7;i++){
            var qrjc=$("#TB_drzc"+i).val();
            if( qrjc!=undefined && qrjc.length==0  )
            {
                $("#div_drzc"+i).text("*数值不能为空!");
                $("#div_drzc"+i).show();
                document.getElementById("TB_drzc"+i).focus();
                zt=1;
            }else{
                $("#div_drzc"+i).hide();
            }
        
        }
        for(var i=1;i<5;i++){
            var qrjc=$("#TB_drjc"+i).val();
            if( qrjc!=undefined && qrjc.length==0  )
            {
                $("#div_drjc"+i).text("*数值不能为空!");
                $("#div_drjc"+i).show();
                document.getElementById("TB_drjc"+i).focus();
                zt=1;
            }else{
                $("#div_drjc"+i).hide();
            }
        }
        
        if (zt==1){
            return false;
        }
    }
  
	$(function() {

         $(document).keydown(function(event){  
            //判断当event.keyCode 为37时（即左方面键），执行函数to_left();  
            //判断当event.keyCode 为39时（即右方面键），执行函数to_right();  

            if(event.keyCode == 38){  
                var prevTrIndex = parseInt($("#prevTrIndex").val()); 
                if (prevTrIndex == -1 || prevTrIndex == 0){ 
                    clickTr(trSize - 1); 
                } else if(prevTrIndex > 0){ 
                    clickTr(prevTrIndex - 1); 
                } 
                //return false;    
            }else if (event.keyCode == 40){   
                var prevTrIndex = parseInt($("#prevTrIndex").val()); 
                if (prevTrIndex == -1 || prevTrIndex == (trSize - 1)){ 
                    clickTr(0); 
                } else if (prevTrIndex < (trSize - 1)) { 
                    clickTr(prevTrIndex + 1); 
                } 
                //return false; 
            }

        });   
//     });
        
        $(document).keypress(function(e) {  
        // 回车键事件  
            if(e.which == 13) { 
                var prevTrIndex = parseInt($("#prevTrIndex").val()); 
                if($("#wlxx").is(":visible") ){
                    $("#TB_wlbh").val(($("#tr_" + prevTrIndex).find("td")[1]).innerHTML);   
                    $("#TB_wlmc").val(($("#tr_" + prevTrIndex).find("td")[2]).innerHTML); 
                    $("#TB_wlpc").val(($("#tr_" + prevTrIndex).find("td")[3]).innerHTML); 
                    $("#TB_gys").val(($("#tr_" + prevTrIndex).find("td")[4]).innerHTML); 
                    $("#TB_gg").val(($("#tr_" + prevTrIndex).find("td")[5]).innerHTML); 
                    $("#TB_qmsl").val(($("#tr_" + prevTrIndex).find("td")[6]).innerHTML); 
                    $("#TB_dw").val(($("#tr_" + prevTrIndex).find("td")[7]).innerHTML); 
                    $("#dialog-form").dialog("close");
                    $("#TB_sl").focus();
                    return false;
                }
                if($("#blxx").is(":visible") ){
	                $("#TB_blmc").val(($("#tr_" + prevTrIndex).find("td")[0]).innerHTML); 
                    $("#TB_bldm").val(($("#tr_" + prevTrIndex).find("td")[1]).innerHTML); 
                    $("#TB_bllb").val(($("#tr_" + prevTrIndex).find("td")[2]).innerHTML); 
                    $("#dialog-form").dialog("close");
                    $("#TB_blsl").focus();
                    return false;
                }
            }
             
         });

		$("#TB_wlbh").keypress(function(e){
            if(e.which == 32) {
                getwlxx();
	            $( "#dialog-form" ).dialog( "open" );
	            $("#wlxx").show();
	            $("#blxx").hide();
            } 
        });  
        $("#TB_bldm").keypress(function(e){
            if(e.which == 32) {
                getblxx();
	            $( "#dialog-form" ).dialog( "open" );
	            $("#wlxx").hide();
	            $("#blxx").show();
            } 
        });
        
//        $("#TB_pc").change(function(){
//             var availableTags = "";
//                var data="{'dxxx':{'Xh':'"+$("#TB_xh" ).val()+"','Rl':''}} "; 
//                $.ajax({
//                    type: "POST",
//		            url: "../GetContent.asmx/Get_pcList",
//		            dataType: "json",
//		            contentType: "application/json; charset=utf-8",
//		            data: data,
//		            success: function(data) { 
//		                availableTags =data.split(",");
//		            },
//		            error: function(error) {
//		                alert("调用出错" + error.responseText);
//		            }
//                });
//            $(this).autocomplete({
//			    source: availableTags
//		    }); 
//        });
        $.ui.autocomplete.prototype._renderItem = function (ul, item) {   
            return $("<li></li>")   
                    .data("item.autocomplete", item)   
                    .append("<a>" + item.label + "</a>")   
                    .appendTo(ul);   
        };

		$( "#TB_pc" ).autocomplete({
			source: function( request, response ) {
			    var data="{'dxxx':{'Xh':'"+$("#TB_xh" ).val()+"','pc':'"+ $("#TB_pc" ).val()  +"'}} "; 
				$.ajax({
				    type: "POST",
				    contentType: "application/json",
					url: "../GetContent.asmx/Get_pcList",
					data: data,
					dataType: "json",
					success: function(json) {  
						 response( $.map( json, function( item ) {
							return {
								label: item.Pc
							}
						}));
					}
				});
			},
			minLength: 1
		});

        

         
		allFields = $( [] ),
		tips = $( ".validateTips" );

		$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 400,
			width: 850,
			modal: true,
			buttons: {
				"保存":function() {
					var bValid = true;
					if ($("#wlxx").is(":visible")==true){
					    duoxuan("wlxx_dx");
					}
					if ($("#blxx").is(":visible")==true){
					    duoxuan("blxx_dx");
					}
					$( this ).dialog( "close" );
				},
				Cancel:function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
			    $('#wlxx tbody tr').remove();   //关闭窗口的时候清空记录
			    $('#blxx tbody tr').remove();
				allFields.val("").removeClass( "ui-state-error" );
			}
		});

		$( "#TB_wlbh" )
			.dblclick(function() {
			    getwlxx();
				$( "#dialog-form" ).dialog( "open" );
				$("#wlxx").show();
				$("#blxx").hide();
			});
			
		$( "#TB_bldm" )
		    .dblclick(function() {
		        getblxx();
			    $( "#dialog-form" ).dialog( "open" );
			    $("#wlxx").hide();
			    $("#blxx").show();
		    });
			
	    });
	    

        $("#prevTrIndex").val("-1");//默认-1 
	    var trSize = $("#wlxx tbody  tr").size(); //datagrid中tr的数量 
         //投产计划参照
        function xhrl(xh_rl){
            if(xh_rl!=""){
                $("#TB_xh").val(xh_rl.split('|')[0]); 
                $("#TB_rl").val(xh_rl.split('|')[1]); 
            }
        }
        
        function sxkz(){   //控制属性选择框的内容
            var gxmc=$("#DDL_gxmc").val()
            var wlsl=$("#wl").val()
            var ddl_sx=$("#DDL_sx").val();
            var ddl_sxi="";
            if (gxmc=="10" ||  gxmc=="25"){ 
                $("#DDL_sx").empty();  
                $("#DDL_sx").append("<option value=''></option>"); 
                $("#DDL_sx").append("<option value='返料'>返料</option>"); 
                for (i=1;i<=wlsl;i++){
                    ddl_sxi=$("#DDL_sx"+i).val();
                    $("#DDL_sx"+i).empty();  
                    $("#DDL_sx"+i).append("<option value=''></option>"); 
                    $("#DDL_sx"+i).append("<option value='返料'>返料</option>"); 
                    $("#DDL_sx"+i).val(ddl_sxi);
                }
               
            }else if (gxmc=="40" ){
                $("#DDL_sx").empty();  
                $("#DDL_sx").append("<option value=''></option>"); 
                $("#DDL_sx").append("<option value='正极报废'>正极报废</option>");
                $("#DDL_sx").append("<option value='负极报废'>负极报废</option>");
                $("#DDL_sx").append("<option value='材料报废'>材料报废</option>");
                $("#DDL_sx").append("<option value='混批转入'>混批转入</option>");
                for (i=1;i<=wlsl;i++){
                    ddl_sxi=$("#DDL_sx"+i).val();
                    $("#DDL_sx"+i).empty(); 
                    $("#DDL_sx"+i).append("<option value=''></option>"); 
                    $("#DDL_sx"+i).append("<option value='正极报废'>正极报废</option>");
                    $("#DDL_sx"+i).append("<option value='负极报废'>负极报废</option>");
                    $("#DDL_sx"+i).append("<option value='材料报废'>材料报废</option>");
                    $("#DDL_sx"+i).append("<option value='混批转入'>混批转入</option>");
                    $("#DDL_sx"+i).val(ddl_sxi);
                }
                
            }else {
                $("#DDL_sx").empty();  
                $("#DDL_sx").append("<option value=''></option>"); 
                $("#DDL_sx").append("<option value='材料报废'>材料报废</option>");
                $("#DDL_sx").append("<option value='混批转入'>混批转入</option>");
                for (i=1;i<=wlsl;i++){
                    ddl_sxi=$("#DDL_sx"+i).val();
                    $("#DDL_sx"+i).empty();  
                    $("#DDL_sx"+i).append("<option value=''></option>"); 
                    $("#DDL_sx"+i).append("<option value='材料报废'>材料报废</option>");
                    $("#DDL_sx"+i).append("<option value='混批转入'>混批转入</option>");
                    $("#DDL_sx"+i).val(ddl_sxi);
                }
            }
             $("#DDL_sx").val(ddl_sx);
        }

        
        function gxchange(gxmc,cczr){    //不同的工序显示不同的页面输入信息
             if (gxmc=="10" ||  gxmc=="25"){   //涂布工序录入显示需要输入的信息
                $("#ggxx_tr1").find("th")[2].innerHTML="配方";
                $("#TB_fqts").show();
                $("#DDL_sclx").hide();
                $("#ggxx_tr1").find("th")[3].innerHTML=""; 
                $("#TB_cy1").hide();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML=""; 
                $("#ggxx_tr2").find("th")[1].innerHTML=""; 
                $("#TB_xh").hide();
                $("#TB_rl").hide();
                $("#ggxx_tr2").find("th")[3].innerHTML=""; 
                $("#TB_bfsl1").hide();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";
                $("#scxx_tr1").find("th")[1].innerHTML="";
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";
                $("#scxx_tr1").find("th")[3].innerHTML="良品转出";
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";
                $("#ggxx_tr3").hide();
                $("#scxx_tr3").hide();
                $("#scxx_tr4").hide();
                $("#scxx_tr5").hide();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="前日结存";  //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="";          //前日结存标签2
                $("#TB_qrjc2").hide();                              //前日结存2textbox
                $("#scxx_tr2").find("th")[1].innerHTML="";          //当日转入标签1
                $("#TB_drzr1").hide();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="";          //当日转入标签2
                $("#TB_drzr2").hide();                              //当日转入2textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="";          //当日生产标签2
                $("#TB_drsc2").hide();                              //当日生产2textbox
                $("#scxx_tr2").find("th")[3].innerHTML="合格";      //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="";          //当日转出标签2
                $("#TB_drzc2").hide();                              //当日转出2textbox
                $("#scxx_tr2").find("th")[4].innerHTML="当日结存";  //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="";          //当日结存标签2
                $("#TB_drjc2").hide();                              //当日结存2textbox
            }else if (gxmc=="11" ||  gxmc=="26"){   //涂布工序录入显示需要输入的信息
                $("#ggxx_tr1").find("th")[2].innerHTML="分切条数";
                $("#TB_fqts").show();
                $("#DDL_sclx").hide();
                $("#ggxx_tr1").find("th")[3].innerHTML=""; 
                $("#TB_cy1").hide();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号"; 
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="";
                $("#scxx_tr1").find("th")[1].innerHTML="理论数量";
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";
                $("#scxx_tr1").find("th")[3].innerHTML="良品转出";
                $("#scxx_tr1").find("th")[4].innerHTML="单面结存";
                $("#ggxx_tr3").hide();
                $("#scxx_tr3").hide();
                $("#scxx_tr4").hide();
                $("#scxx_tr5").hide();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="";          //前日结存标签1
                $("#TB_qrjc1").hide();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="";          //前日结存标签2
                $("#TB_qrjc2").hide();                              //前日结存2textbox
                $("#scxx_tr2").find("th")[1].innerHTML="理论数量";  //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="";          //当日转入标签2
                $("#TB_drzr2").hide();                              //当日转入2textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="";          //当日生产标签2
                $("#TB_drsc2").hide();                              //当日生产2textbox
                $("#scxx_tr2").find("th")[3].innerHTML="合格";      //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="";          //当日转出标签2
                $("#TB_drzc2").hide();                              //当日转出2textbox
                $("#scxx_tr2").find("th")[4].innerHTML="单面结存";  //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="";          //当日结存标签2
                $("#TB_drjc2").hide();                              //当日结存2textbox

            }else if (gxmc=="12" || gxmc=="27"){
                $("#ggxx_tr1").find("th")[2].innerHTML="分切条数";  //分切条数标签
                $("#TB_fqts").show();
                $("#DDL_sclx").hide();                               //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号"; 
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";  //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#ggxx_tr3").hide();                              //隐藏pack型号
                $("#scxx_tr3").show();                              //第三行显示
                $("#scxx_tr4").hide();
                $("#scxx_tr5").hide();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="未制";      //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="";          //前日结存标签2
                $("#TB_qrjc2").hide();                              //前日结存2textbox
                $("#scxx_tr2").find("th")[1].innerHTML="转入数";    //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="";          //当日转入标签2
                $("#TB_drzr2").hide();                              //当日转入2textbox
                $("#scxx_tr2").find("th")[2].innerHTML="片数";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="";      //当日生产标签2
                $("#TB_drsc2").hide();                              //当日生产2textbox
                $("#scxx_tr2").find("th")[3].innerHTML="良品转出";  //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="入库";      //当日转出标签2
                $("#TB_drzc2").show();                              //当日转出2textbox
                $("#scxx_tr2").find("th")[4].innerHTML="当日结存";  //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="";          //当日结存标签2
                $("#TB_drjc2").hide();                              //当日结存2textbox
            }else if (gxmc=="13" || gxmc=="28" || gxmc=="15" || gxmc=="30"){
                $("#ggxx_tr1").find("th")[2].innerHTML="";          //分切条数标签
                $("#TB_fqts").hide();
                $("#DDL_sclx").hide();                               //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号"; 
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";  //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#scxx_tr3").show();                              //第三行显示
                $("#ggxx_tr3").hide();                              //隐藏pack型号
                $("#scxx_tr4").hide();
                $("#scxx_tr5").hide();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="已制";      //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="未制";      //前日结存标签2
                $("#TB_qrjc2").show();                              //前日结存2textbox
                $("#scxx_tr2").find("th")[1].innerHTML="合格";      //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="不合格";    //当日转入标签2
                $("#TB_drzr2").show();                              //当日转入2textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="不合格";    //当日生产标签2
                $("#TB_drsc2").show();                              //当日生产2textbox
                $("#scxx_tr2").find("th")[3].innerHTML="合格";      //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="不合格";    //当日转出标签2
                $("#TB_drzc2").show();                              //当日转出2textbox
                $("#scxx_tr2").find("th")[4].innerHTML="已制";      //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="未制";      //当日结存标签2
                $("#TB_drjc2").show();                              //当日结存2textbox
            }else if (gxmc=="40" ){
                $("#ggxx_tr1").find("th")[2].innerHTML="";          //分切条数标签
                $("#TB_fqts").hide();
                $("#DDL_sclx").hide();                               //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="正极差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML="负极差异"; 
                $("#TB_cy2").show();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号";
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show(); 
                $("#ggxx_tr2").find("th")[3].innerHTML="正极报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox              
                $("#ggxx_tr2").find("th")[4].innerHTML="负极报废"; 
                $("#TB_bfsl2").show();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="当日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";  //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#scxx_tr3").show();                              //第三行显示
                $("#ggxx_tr3").hide();                              //隐藏pack型号
                $("#scxx_tr4").show();
                $("#scxx_tr5").show();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="极片正";    //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="极片负";    //前日结存标签2
                $("#TB_qrjc2").show();                              //前日结存2textbox
                $("#scxx_tr4").find("th")[0].innerHTML="合格卷芯";  //前日结存标签3
                $("#TB_qrjc3").show();                              //前日结存3textbox
                $("#scxx_tr5").find("th")[0].innerHTML="不合格卷芯";//前日结存标签4
                $("#TB_qrjc4").show();                              //前日结存4textbox
                $("#scxx_tr2").find("th")[1].innerHTML="正极";      //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="负极";      //当日转入标签2
                $("#TB_drzr2").show();                              //当日转入2textbox
                $("#scxx_tr4").find("th")[1].innerHTML="";          //当日转入标签3
                $("#TB_drzr3").hide();                              //当日转入3textbox
                $("#scxx_tr5").find("th")[1].innerHTML="";          //当日转入标签4
                $("#TB_drzr4").hide();                              //当日转入4textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="不合格";    //当日生产标签2
                $("#TB_drsc2").show();                              //当日生产2textbox
                $("#scxx_tr4").find("th")[2].innerHTML="";          //当日生产标签3
                $("#TB_drsc3").hide();                              //当日生产3textbox
                $("#scxx_tr2").find("th")[3].innerHTML="良品";      //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="";          //当日转出标签2
                $("#TB_drzc2").hide();                              //当日转出2textbox
                $("#scxx_tr4").find("th")[3].innerHTML="";          //当日转出标签1
                $("#TB_drzc3").hide();                              //当日转出1textbox
                $("#scxx_tr5").find("th")[3].innerHTML="";          //当日转出标签2
                $("#TB_drzc4").hide();                              //当日转出2textbox
                $("#scxx_tr2").find("th")[4].innerHTML="极片正";    //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="极片负";    //当日结存标签2
                $("#TB_drjc2").show();                              //当日结存2textbox
                $("#scxx_tr4").find("th")[4].innerHTML="合格卷芯";  //当日结存标签3
                $("#TB_drjc3").show();                              //当日结存3textbox
                $("#scxx_tr5").find("th")[4].innerHTML="不合格卷芯";//当日结存标签4
                $("#TB_drjc4").show();                              //当日结存4textbox
            }else if (gxmc=="50" || gxmc=="55"){
                $("#ggxx_tr1").find("th")[2].innerHTML="";          //分切条数标签
                $("#TB_fqts").hide();
                $("#DDL_sclx").hide();                              //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号"; 
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";  //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#scxx_tr3").show();                              //第三行显示
                $("#ggxx_tr3").hide();                              //隐藏pack型号
                $("#scxx_tr4").hide();
                $("#scxx_tr5").hide();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="已制";      //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="未制";      //前日结存标签2
                $("#TB_qrjc2").show();                              //前日结存2textbox
                $("#scxx_tr2").find("th")[1].innerHTML="合格";      //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="不合格";    //当日转入标签2
                $("#TB_drzr2").show();                              //当日转入2textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="不合格";    //当日生产标签2
                $("#TB_drsc2").show();                              //当日生产2textbox
                $("#scxx_tr2").find("th")[3].innerHTML="合格";      //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="不合格";    //当日转出标签2
                $("#TB_drzc2").show();                              //当日转出2textbox
                $("#scxx_tr2").find("th")[4].innerHTML="已制";      //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="未制";      //当日结存标签2
                $("#TB_drjc2").show();                              //当日结存2textbox
            }else if (gxmc=="60" || gxmc=="65" ){
                $("#ggxx_tr1").find("th")[2].innerHTML="";          //分切条数标签
                $("#TB_fqts").hide();
                $("#DDL_sclx").hide();                               //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号"; 
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";  //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#scxx_tr3").show();                              //第三行显示
                $("#ggxx_tr3").hide();                              //隐藏pack型号
                $("#scxx_tr4").hide();
                $("#scxx_tr5").hide();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="已制";      //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="未制";      //前日结存标签2
                $("#TB_qrjc2").show();                              //前日结存2textbox
                $("#scxx_tr2").find("th")[1].innerHTML="合格";      //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="不合格";    //当日转入标签2
                $("#TB_drzr2").show();                              //当日转入2textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="不合格";    //当日生产标签2
                $("#TB_drsc2").show();                              //当日生产2textbox
                $("#scxx_tr2").find("th")[3].innerHTML="合格";      //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="不合格";    //当日转出标签2
                $("#TB_drzc2").show();                              //当日转出2textbox
                $("#scxx_tr2").find("th")[4].innerHTML="已制";      //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="未制";      //当日结存标签2
                $("#TB_drjc2").show();                              //当日结存2textbox
            }else if (gxmc=="70" ){
                $("#ggxx_tr1").find("th")[2].innerHTML="";          //分切条数标签
                $("#TB_fqts").hide();    
                $("#DDL_sclx").hide();                           //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号"; 
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";  //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#scxx_tr3").show();                              //第三行显示
                $("#ggxx_tr3").hide();                              //隐藏pack型号
                $("#scxx_tr4").show();
                $("#scxx_tr5").hide();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="合格";      //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="不合格";    //前日结存标签2
                $("#TB_qrjc2").show();                              //前日结存2textbox
                $("#scxx_tr4").find("th")[0].innerHTML="未制";      //前日结存标签3
                $("#TB_qrjc3").show();                              //前日结存3textbox
                $("#scxx_tr2").find("th")[1].innerHTML="合格";      //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="不合格";    //当日转入标签2
                $("#TB_drzr2").show();                              //当日转入2textbox
                $("#scxx_tr4").find("th")[1].innerHTML="";          //当日转入标签3
                $("#TB_drzr3").hide();                              //当日转入3textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="不合格";    //当日生产标签2
                $("#TB_drsc2").show();                              //当日生产2textbox
                $("#scxx_tr4").find("th")[2].innerHTML="重分生产";  //当日生产标签3
                $("#TB_drsc3").show();                              //当日生产3textbox
                $("#scxx_tr2").find("th")[3].innerHTML="合格";      //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="不合格";    //当日转出标签2
                $("#TB_drzc2").show();                              //当日转出2textbox
                $("#scxx_tr4").find("th")[3].innerHTML="";          //当日转出标签3
                $("#TB_drzc3").hide();                              //当日转出3textbox
                $("#scxx_tr2").find("th")[4].innerHTML="合格";      //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="不合格";    //当日结存标签2
                $("#TB_drjc2").show();                              //当日结存2textbox
                $("#scxx_tr4").find("th")[4].innerHTML="未制";      //当日结存标签3
                $("#TB_drjc3").show();                              //当日结存3textbox
            }else if (gxmc=="75" ){
                $("#ggxx_tr1").find("th")[2].innerHTML="生产类型";  //分切条数标签
                $("#TB_fqts").hide();
                $("#DDL_sclx").show();                              //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号"; 
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";  //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#scxx_tr3").show();                              //第三行显示
                $("#ggxx_tr3").hide();                              //隐藏pack型号
                $("#scxx_tr4").show();
                $("#scxx_tr5").show();
                $("#scxx_tr6").show();
                $("#scxx_tr7").show();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="合格";      //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="不合格";    //前日结存标签2
                $("#TB_qrjc2").show();                              //前日结存2textbox
                $("#scxx_tr4").find("th")[0].innerHTML="未制";      //前日结存标签3
                $("#TB_qrjc3").show();                              //前日结存3textbox
                $("#scxx_tr5").find("th")[0].innerHTML="";          //前日结存标签4
                $("#TB_qrjc4").hide();                              //前日结存4textbox
                $("#scxx_tr2").find("th")[1].innerHTML="合格";      //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="不合格";    //当日转入标签2
                $("#TB_drzr2").show();                              //当日转入2textbox
                $("#scxx_tr4").find("th")[1].innerHTML="PACK转入";  //当日转入标签3
                $("#TB_drzr3").show();                              //当日转入3textbox
                $("#scxx_tr5").find("th")[1].innerHTML="成品库转入";//当日转入标签4
                $("#TB_drzr4").show();                              //当日转入4textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="返修";      //当日生产标签2
                $("#TB_drsc2").show();                              //当日生产2textbox
                $("#scxx_tr4").find("th")[2].innerHTML="";          //当日生产标签3
                $("#TB_drsc3").hide();                              //当日生产3textbox
                $("#scxx_tr2").find("th")[3].innerHTML="转至出货";  //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="转至PACK";  //当日转出标签2
                $("#TB_drzc2").show();                              //当日转出2textbox
                $("#scxx_tr4").find("th")[3].innerHTML="转至分选";  //当日转出标签3
                $("#TB_drzc3").show();                              //当日转出3textbox
                $("#scxx_tr5").find("th")[3].innerHTML="入库A";     //当日转出标签4
                $("#TB_drzc4").show();                              //当日转出4textbox
                $("#scxx_tr6").find("th")[3].innerHTML="入库AE";    //当日转出标签5
                $("#TB_drzc5").show();                              //当日转出5textbox
                $("#scxx_tr7").find("th")[3].innerHTML="入库B";     //当日转出标签6
                $("#TB_drzc6").show();                              //当日转出6textbox
                $("#scxx_tr2").find("th")[4].innerHTML="合格";      //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="不合格";    //当日结存标签2
                $("#TB_drjc2").show();                              //当日结存2textbox
                $("#scxx_tr4").find("th")[4].innerHTML="未制";      //当日结存标签3
                $("#TB_drjc3").show();                              //当日结存3textbox
                $("#scxx_tr5").find("th")[4].innerHTML="";          //当日结存标签4
                $("#TB_drjc4").hide();                              //当日结存4textbox
            }else if (gxmc=="80" ){
                $("#ggxx_tr1").find("th")[2].innerHTML="生产类型";          //分切条数标签
                $("#TB_fqts").hide();
                $("#DDL_sclx").show();                               //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="PACK型号";
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";  //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#scxx_tr3").show();                              //第三行显示
                $("#ggxx_tr3").hide();                              //显示pack型号
                $("#scxx_tr4").show();
                $("#scxx_tr5").show();
                $("#scxx_tr6").hide();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="合格";      //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="不合格";    //前日结存标签2
                $("#TB_qrjc2").show();                              //前日结存2textbox
                $("#scxx_tr4").find("th")[0].innerHTML="未制";      //前日结存标签3
                $("#TB_qrjc3").show();                              //前日结存3textbox
                $("#scxx_tr5").find("th")[0].innerHTML="";          //前日结存标签4
                $("#TB_qrjc4").hide();                              //前日结存4textbox
                $("#scxx_tr2").find("th")[1].innerHTML="合格";      //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="不合格";    //当日转入标签2
                $("#TB_drzr2").show();                              //当日转入2textbox
                $("#scxx_tr4").find("th")[1].innerHTML="成品库转入";//当日转入标签3
                $("#TB_drzr3").show();                              //当日转入3textbox
                $("#scxx_tr5").find("th")[1].innerHTML="";          //当日转入标签4
                $("#TB_drzr4").hide();                              //当日转入4textbox
                $("#scxx_tr2").find("th")[2].innerHTML="合格";      //当日生产标签1
                $("#TB_drsc1").show();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="不合格";    //当日生产标签2
                $("#TB_drsc2").show();                              //当日生产2textbox
                $("#scxx_tr4").find("th")[2].innerHTML="";          //当日生产标签3
                $("#TB_drsc3").hide();                              //当日生产3textbox
                $("#scxx_tr2").find("th")[3].innerHTML="转至出货";  //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="入库A";     //当日转出标签2
                $("#TB_drzc2").show();                              //当日转出2textbox
                $("#scxx_tr4").find("th")[3].innerHTML="入库AE";    //当日转出标签3
                $("#TB_drzc3").show();                              //当日转出3textbox
                $("#scxx_tr5").find("th")[3].innerHTML="入库B";     //当日转出标签4
                $("#TB_drzc4").show();                              //当日转出4textbox
                $("#scxx_tr6").find("th")[3].innerHTML="";          //当日转出标签5
                $("#TB_drzc5").hide();                              //当日转出5textbox
                $("#scxx_tr7").find("th")[3].innerHTML="";          //当日转出标签6
                $("#TB_drzc6").hide();                              //当日转出6textbox
                $("#scxx_tr2").find("th")[4].innerHTML="合格";      //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="不合格";    //当日结存标签2
                $("#TB_drjc2").show();                              //当日结存2textbox
                $("#scxx_tr4").find("th")[4].innerHTML="未制";      //当日结存标签3
                $("#TB_drjc3").show();                              //当日结存3textbox
                $("#scxx_tr5").find("th")[4].innerHTML="";          //当日结存标签4
                $("#TB_drjc4").hide();                              //当日结存4textbox
            }else if (gxmc=="85" ){
                $("#ggxx_tr1").find("th")[2].innerHTML=" 出货订单号";          //分切条数标签
                $("#TB_fqts").show();
                $("#DDL_sclx").hide();                               //分切调试textbox
                $("#ggxx_tr1").find("th")[3].innerHTML="差异"; 
                $("#TB_cy1").show();                                //差异1textbox
                $("#ggxx_tr1").find("th")[4].innerHTML=""; 
                $("#TB_cy2").hide();                                //差异2textbox
                $("#ggxx_tr2").find("th")[0].innerHTML="电芯型号";
                $("#ggxx_tr2").find("th")[1].innerHTML="容量"; 
                $("#TB_xh").show();
                $("#TB_rl").show();
                $("#ggxx_tr2").find("th")[3].innerHTML="报废"; 
                $("#TB_bfsl1").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[4].innerHTML=""; 
                $("#TB_bfsl2").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";  //前日结存主标签
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";  //当日转入主标签
                $("#scxx_tr1").find("th")[2].innerHTML="";          //当日生产主标签
                $("#scxx_tr1").find("th")[3].innerHTML="当日发货";  //当日转出主标签
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";  //当日结存主标签
                $("#scxx_tr3").show();                              //第三行显示
                $("#ggxx_tr3").hide();                              //隐藏pack型号
                $("#scxx_tr4").show();
                $("#scxx_tr5").show();
                $("#scxx_tr6").show();
                $("#scxx_tr7").hide();
                $("#tab").show();
                $("#scxx_tr2").find("th")[0].innerHTML="前日结存";  //前日结存标签1
                $("#TB_qrjc1").show();                              //前日结存1textbox
                $("#scxx_tr3").find("th")[0].innerHTML="";          //前日结存标签2
                $("#TB_qrjc2").hide();                              //前日结存2textbox
                $("#scxx_tr4").find("th")[0].innerHTML="";          //前日结存标签3
                $("#TB_qrjc3").hide();                              //前日结存3textbox
                $("#scxx_tr5").find("th")[0].innerHTML="";          //前日结存标签4
                $("#TB_qrjc4").hide();                              //前日结存4textbox
                $("#scxx_tr2").find("th")[1].innerHTML="包装转入";  //当日转入标签1
                $("#TB_drzr1").show();                              //当日转入1textbox
                $("#scxx_tr3").find("th")[1].innerHTML="PACK转入";  //当日转入标签2
                $("#TB_drzr2").show();                              //当日转入2textbox
                $("#scxx_tr4").find("th")[1].innerHTML="";          //当日转入标签3
                $("#TB_drzr3").hide();                              //当日转入3textbox
                $("#scxx_tr5").find("th")[1].innerHTML="";          //当日转入标签4
                $("#TB_drzr4").hide();                              //当日转入4textbox
                $("#scxx_tr2").find("th")[2].innerHTML="";          //当日生产标签1
                $("#TB_drsc1").hide();                              //当日生产1textbox
                $("#scxx_tr3").find("th")[2].innerHTML="";          //当日生产标签2
                $("#TB_drsc2").hide();                              //当日生产2textbox
                $("#scxx_tr4").find("th")[2].innerHTML="";          //当日生产标签3
                $("#TB_drsc3").hide();                              //当日生产3textbox
                $("#scxx_tr2").find("th")[3].innerHTML="发货";      //当日转出标签1
                $("#TB_drzc1").show();                              //当日转出1textbox
                $("#scxx_tr3").find("th")[3].innerHTML="B品";       //当日转出标签2
                $("#TB_drzc2").show();                              //当日转出2textbox
                $("#scxx_tr4").find("th")[3].innerHTML="补货";      //当日转出标签3
                $("#TB_drzc3").show();                              //当日转出3textbox
                $("#scxx_tr5").find("th")[3].innerHTML="备品";      //当日转出标签4
                $("#TB_drzc4").show();                              //当日转出4textbox
                $("#scxx_tr6").find("th")[3].innerHTML="客退返修";  //当日转出标签5
                $("#TB_drzc5").show();                              //当日转出5textbox
                $("#scxx_tr7").find("th")[3].innerHTML="";          //当日转出标签6
                $("#TB_drzc6").hide();                              //当日转出6textbox
                $("#scxx_tr2").find("th")[4].innerHTML="当日结存";  //当日结存标签1
                $("#TB_drjc1").show();                              //当日结存1textbox
                $("#scxx_tr3").find("th")[4].innerHTML="";          //当日结存标签2
                $("#TB_drjc2").hide();                              //当日结存2textbox
                $("#scxx_tr4").find("th")[4].innerHTML="";          //当日结存标签3
                $("#TB_drjc3").hide();                              //当日结存3textbox
                $("#scxx_tr5").find("th")[4].innerHTML="";          //当日结存标签4
                $("#TB_drjc4").hide();                              //当日结存4textbox
            }
            
            
            //转换工序后清空数据
            if (cczr==2){
                $("#TB_rq").val("");
                $("#TB_fqts").val(0);
                $("#TB_cy1").val(0);
                $("#TB_cy2").val(0);
                $("#TB_xh").val("");
                $("#TB_rl").val("");
                $("#TB_pc").val("");
                $("#TB_bfsl1").val(0);
                $("#TB_bfsl2").val(0);
                $("#TB_PACK").val("");
                $("#TB_qrjc1").val(0);
                $("#TB_qrjc2").val(0);
                $("#TB_qrjc3").val(0);
                $("#TB_qrjc4").val(0);
                $("#TB_drzr1").val(0);
                $("#TB_drzr2").val(0);
                $("#TB_drzr3").val(0);
                $("#TB_drzr4").val(0);
                $("#TB_drsc1").val(0);
                $("#TB_drsc2").val(0);
                $("#TB_drsc3").val(0);
                $("#TB_drzc1").val(0);
                $("#TB_drzc2").val(0);
                $("#TB_drzc3").val(0);
                $("#TB_drzc4").val(0);
                $("#TB_drzc5").val(0);
                $("#TB_drzc6").val(0);
                $("#TB_drjc1").val(0);
                $("#TB_drjc2").val(0);
                $("#TB_drjc3").val(0);
                $("#TB_drjc4").val(0);
                sxkz();
            }
            
        }


</script>
    <form id="form1" runat="server">
    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"  TargetControlID="TB_xh" ServicePath="../GetContent.asmx" ServiceMethod="GetxhbomlList" MinimumPrefixLength="1"  CompletionInterval="500" />
<%--    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server"  TargetControlID="TB_pc" ServicePath="../GetContent.asmx" ServiceMethod="GetpcList" MinimumPrefixLength="1"  CompletionInterval="500" />--%>
    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server"  TargetControlID="TB_PACK" ServicePath="../GetContent.asmx" ServiceMethod="GetPackxhList" MinimumPrefixLength="1"  CompletionInterval="500" />
    
    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server"  TargetControlID="TB_rq" Format="yyyy-MM-dd"  />
    <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"  EnableScriptGlobalization="true" EnableScriptLocalization="true">
    <Services>
        <asp:ServiceReference Path="~/AutoCompleteService.svc" />
    </Services>
    </ajaxToolkit:ToolkitScriptManager>
        <br />

    <div id ="tablename" runat="server" >
    
<table width="1000" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
        <th  colspan ="10" style=" height: auto"> <h1  style=" margin-top:10px">
            <asp:DropDownList ID="DDL_gxmc" runat="server" Width="200px" Height="30px" Font-Size="25px"    onchange="javascript:gxchange(this.value,2)" >
                <asp:ListItem Value="25">正极搅拌</asp:ListItem >
                <asp:ListItem Value="10">负极搅拌</asp:ListItem>
                <asp:ListItem Value="26">正极涂布</asp:ListItem >
                <asp:ListItem Value="11">负极涂布</asp:ListItem>
                <asp:ListItem Value="27">正极分切</asp:ListItem>
                <asp:ListItem Value="12">负极分切</asp:ListItem>
                <asp:ListItem Value="28">正极分小片</asp:ListItem>
                <asp:ListItem Value="13">负极分小片</asp:ListItem>
                <asp:ListItem Value="30">正极铆接</asp:ListItem>
                <asp:ListItem Value="15">负极铆接</asp:ListItem>
                <asp:ListItem Value="40">巻绕</asp:ListItem>
                <asp:ListItem Value="50">封装</asp:ListItem>
                <asp:ListItem Value="55">注液</asp:ListItem>
                <asp:ListItem Value="60">化成</asp:ListItem>
                <asp:ListItem Value="65">二封</asp:ListItem>
                <asp:ListItem Value="70">分选</asp:ListItem>
                <asp:ListItem Value="75">包装</asp:ListItem>
                <asp:ListItem Value="80">PACK</asp:ListItem>
                <asp:ListItem Value="85">出货</asp:ListItem>
            </asp:DropDownList>
            工序生产日报</h1></th>
    </tr>
  <tr id ="ggxx_tr1">
    <th width="8%">日期</th>
    <td width="12%"><asp:TextBox ID="TB_rq" runat="server"  Width="95%"  TabIndex="1"></asp:TextBox><div id="div_rq" style="color:Red;" visible="false"></div></td>
    <th width="8%">工厂</th>
    <td style="width: 119px">
        <asp:DropDownList ID="DDL_gc" runat="server" Width="95%" TabIndex="2">
            <asp:ListItem Value="新桥工厂">新桥工厂</asp:ListItem>
            <asp:ListItem Value="东洲工厂">东洲工厂</asp:ListItem>
        </asp:DropDownList>
    </td>
    <th width="8%"></th>
    <td width="12%">
        <asp:TextBox ID="TB_fqts" runat="server" Width="95%" TabIndex="3" >0</asp:TextBox>
        <asp:DropDownList ID="DDL_sclx" runat="server" Width="95%" TabIndex="2">
            <asp:ListItem Selected="True" >正常批次</asp:ListItem>
            <asp:ListItem >返工批次</asp:ListItem>
        </asp:DropDownList>
        <div id="div_fqts" style="color:Red;" visible="false"></div>
    </td>
    <th width="8%"></th>
    <td width="12%"><asp:TextBox ID="TB_cy1" runat="server" Width="95%" >0</asp:TextBox><div id="div_cy1" style="color:Red;" visible="false"></div></td>
    <th width="8%"></th>
    <td width="12%"><asp:TextBox ID="TB_cy2" runat="server" Width="95%" >0</asp:TextBox><div id="div_cy2" style="color:Red;" visible="false"></div></td>
  </tr>
  <tr id ="ggxx_tr2" >
    <th style="height: 39px">电芯型号</th>
    <td style="height: 39px"><asp:TextBox ID="TB_xh" runat="server" Width="95%" TabIndex="4"  onchange="javascript:xhrl(this.value)"  ></asp:TextBox><div id="div_xh" style="color:Red;" visible="false"></div></td>
    <th style="height: 39px">容量</th>
    <td style="height: 39px"><asp:TextBox ID="TB_rl" runat="server" Width="95%" TabIndex="5" ></asp:TextBox><div id="div_rl" style="color:Red;" visible="false"></div></td>
    <th style="height: 39px">生产批次</th>
    <td style="height: 39px"><asp:TextBox ID="TB_pc" runat="server" Width="95%" TabIndex="6"></asp:TextBox>    
    <div id="div_pc" style="color:Red;" visible="false"></div></td>
    <th style="height: 39px">报废</th>
    <td style="height: 39px"><asp:TextBox ID="TB_bfsl1" runat="server" Width="95%" >0</asp:TextBox><div id="div_bfsl1" style="color:Red;" visible="false"></div></td>
    <th style="height: 39px"></th>
    <td style="height: 39px"><asp:TextBox ID="TB_bfsl2" runat="server" Width="95%" >0</asp:TextBox><div id="div_bfsl2" style="color:Red;" visible="false"></div></td>
  </tr>
    <tr id ="ggxx_tr3" >
    <th>PACK型号</th>
    <td><asp:TextBox ID="TB_PACK" runat="server" Width="95%" TabIndex="7"  ></asp:TextBox></td>
    <th></th>
    <td></td>
    <th></th>
    <td></td>
    <th></th>
    <td></td>
    <th></th>
    <td></td>
  </tr>
    <tr id ="ggxx_tr4"  >
    <th style="height: 26px">备注</th>
    <td colspan="9" style="height: 26px"><asp:TextBox ID="TB_bz" runat="server" Width="99%" TabIndex="4"  ></asp:TextBox></td>

  </tr>
  <tr>
    <td colspan="10" style="text-align: right">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
    </td>
  </tr>
  <tr id ="scxx_tr1">
    <th colspan="2" style="height: 17px">前日结存</th>
    <th colspan="2" style="height: 17px">当日转入</th>
    <th colspan="2" style="height: 17px">当日生产</th>
    <th colspan="2" style="height: 17px">当日转出</th>
    <th colspan="2" style="height: 17px">当日结存</th>
  </tr>
  <tr id ="scxx_tr2" >
    <th style="height: 26px">已制</th>
    <td style="height: 26px"><asp:TextBox ID="TB_qrjc1" runat="server" Width="95%" onchange="cyjs();" TabIndex="7">0</asp:TextBox><div id="div_qrjc1" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">转入数</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drzr1" runat="server" Width="95%" onchange="cyjs();" TabIndex="11">0</asp:TextBox><div id="div_drzr1" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">当日生产</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drsc1" runat="server" Width="95%" TabIndex="15">0</asp:TextBox><div id="div_drsc1" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">良品转出</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drzc1" runat="server" Width="95%" onchange="cyjs();" TabIndex="18">0</asp:TextBox><div id="div_drzc1" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">已制</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drjc1" runat="server" Width="95%" onchange="cyjs();" TabIndex="24">0</asp:TextBox><div id="div_drjc1" style="color:Red;" visible="false"></div></td>
  </tr>
  <tr id ="scxx_tr3">
    <th style="height: 26px">未制</th>
    <td style="height: 26px"><asp:TextBox ID="TB_qrjc2" runat="server" Width="95%" onchange="cyjs();" TabIndex="8">0</asp:TextBox><div id="div_qrjc2" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px"></th>
    <td style="height: 26px"><asp:TextBox ID="TB_drzr2"  runat="server" Width="95%" onchange="cyjs();" TabIndex="12">0</asp:TextBox><div id="div_drzr2" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px"></th>
    <td style="height: 26px"><asp:TextBox ID="TB_drsc2" runat="server" Width="95%" TabIndex="16" >0</asp:TextBox><div id="div_drsc2" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">累计转出</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drzc2" runat="server" Width="95%" onchange="cyjs();" TabIndex="19">0</asp:TextBox><div id="div_drzc2" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">未制</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drjc2" runat="server" Width="95%" onchange="cyjs();" TabIndex="25">0</asp:TextBox><div id="div_drjc2" style="color:Red;" visible="false"></div></td>
  </tr>
    <tr id ="scxx_tr4">
        <th></th>
        <td><asp:TextBox ID="TB_qrjc3" runat="server" Width="95%" onchange="cyjs();" TabIndex="9">0</asp:TextBox><div id="div_qrjc3" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td><asp:TextBox ID="TB_drzr3"  runat="server" Width="95%" onchange="cyjs();" TabIndex="13">0</asp:TextBox><div id="div_drzr3" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td><asp:TextBox ID="TB_drsc3" runat="server" Width="95%"  TabIndex="17">0</asp:TextBox><div id="div_drsc3" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td><asp:TextBox ID="TB_drzc3" runat="server" Width="95%" onchange="cyjs();" TabIndex="20">0</asp:TextBox><div id="div_drzc3" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td><asp:TextBox ID="TB_drjc3" runat="server" Width="95%" onchange="cyjs();" TabIndex="26">0</asp:TextBox><div id="div_drjc3" style="color:Red;" visible="false"></div></td>
    </tr>
    <tr id ="scxx_tr5">
        <th></th>
        <td><asp:TextBox ID="TB_qrjc4" runat="server" Width="95%" onchange="cyjs();" TabIndex="10">0</asp:TextBox><div id="div_qrjc4" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td><asp:TextBox ID="TB_drzr4" runat="server" Width="95%" onchange="cyjs();" TabIndex="14">0</asp:TextBox><div id="div_drzr4" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td></td>
        <th></th>
        <td><asp:TextBox ID="TB_drzc4" runat="server" Width="95%" onchange="cyjs();" TabIndex="21">0</asp:TextBox><div id="div_drzc4" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td><asp:TextBox ID="TB_drjc4" runat="server" Width="95%" onchange="cyjs();" TabIndex="27">0</asp:TextBox><div id="div_drjc4" style="color:Red;" visible="false"></div></td>
    </tr>
    <tr id ="scxx_tr6">
        <th></th>
        <td></td>
        <th></th>
        <td></td>
        <th></th>
        <td></td>
        <th></th>
        <td><asp:TextBox ID="TB_drzc5" runat="server" Width="95%" onchange="cyjs();" TabIndex="22">0</asp:TextBox><div id="div_drzc5" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td></td>
    </tr>
    <tr id ="scxx_tr7">
        <th></th>
        <td></td>
        <th></th>
        <td></td>
        <th></th>
        <td></td>
        <th></th>
        <td><asp:TextBox ID="TB_drzc6" runat="server" Width="95%" onchange="cyjs();" TabIndex="23">0</asp:TextBox><div id="div_drzc6" style="color:Red;" visible="false"></div></td>
        <th></th>
        <td></td>
    </tr>
    <tr>
        <td colspan="10" rowspan="2" style="height: 15px">
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</td>
    </tr>
    <tr>
    </tr>
</table>
    <table id="tab" runat="server" width="1000px" cellspacing="0" align="center">
          <tr>
            <th style="width:15%">不良代码</th>
            <th style="width:10%">类别</th>
            <th style="width:15%">不良名称</th>
            <th style="width:10%">数量</th>
            <th style="width:45%">备注</th>
            <th style="width:5%"><asp:button  runat="server" id="bl_delete" OnClientClick ="delTr2();return false;" text="删除" style="width:58px" /></th>
          </tr>
          <tr>
            <td>
                <asp:TextBox ID="TB_bldm" runat="server" Width="95%" TabIndex="28"></asp:TextBox>
            </td>
             <td>
                <asp:TextBox ID="TB_bllb" runat="server" Width="95%" TabIndex="29"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TB_blmc" runat="server" Width="95%"  TabIndex="30" ></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TB_blsl" runat="server" Width="95%"  onchange="bfjs()"  TabIndex="31"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TB_blbz" runat="server" Width="95%"  TabIndex="32"></asp:TextBox>
            </td>
            <td>
                <asp:button  runat="server"  id="bl_add"  OnClientClick="addTr2('tab', -1);return false;" text="添加"  style="width:58px" TabIndex="33"  />
            </td>
          </tr>
        </table>
        <table id="tab1" runat="server" width="1000px" cellspacing="0" align="center">
            <tr>
                <th style="width:5%">属性</th>
                <th style="width:11%">物料编号</th>
                <th style="width:10%">物料名称</th>
                <th style="width:11%">物料批次</th>
                <th style="width:10%">供应商</th>
                <th style="width:33%">规格</th>
                <th style="width:6%">期末数量</th>
                <th style="width:6%">使用数</th>
                <th style="width:3%">单位</th>
                <th style="width:5%"><asp:button  runat="server" id="wl_delete"  OnClientClick="delTr2();return false;" text="删除" style="width:58px" /></th>
            </tr>
            <tr>
                <td style="height: 28px">
                     <asp:DropDownList ID="DDL_sx" runat="server" >
                        <asp:ListItem ></asp:ListItem >
                        <asp:ListItem >返料</asp:ListItem >
                        <asp:ListItem >材料报废</asp:ListItem>
                        <asp:ListItem >混批转入</asp:ListItem>
                    </asp:DropDownList>
                   
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_wlbh" runat="server" Width="95%" TabIndex="34"  ></asp:TextBox>
                    <div id="div_wlbh" style="color:Red"  visible="false" ></div>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_wlmc" runat="server" Width="95%" TabIndex="35"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_wlpc" runat="server" Width="95%" TabIndex="36"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_gys" runat="server" Width="95%" TabIndex="37"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_gg" runat="server" Width="95%" TabIndex="38"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_qmsl" runat="server" Width="95%" TabIndex="39" ></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_sl" runat="server" Width="95%" TabIndex="39" onchange="bfjs()" ></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_dw" runat="server" Width="95%" TabIndex="40"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:button  runat="server" OnClientClick="addTr2('tab1', -2);return false; " id="wl_add"  text="添加"  style="width:58px"  TabIndex="41" /> 
                </td>
            </tr>
            <tr>
            <td colspan="10" style="text-align: left">
                &nbsp; &nbsp;&nbsp;
            生产数据录入说明：<br />
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
       1）、“电芯型号”“生产批次”只需录入部分信息后系统会自动匹配
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
       2）、“项目代码”“物料编号”录入部分信息后鼠标双击或空格可弹出对话框
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
       3）、“属性”中不同工序会出现不同选项，选项含义如下&nbsp;<br />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;【返料】只有配料工序有，指涂布工序返回配料的浆料&nbsp;<br />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;【正极报废】只有卷绕工序有，指正极片报废的数量
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            【负极报废】只有卷绕工序有，指负极片报废的数量
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            【材料报废】指材料异常报废的数量
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            【混批转入】指非本批号半成品转入至本批
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
       4）、PACK工序入库时，电芯和PACK电池同批次同时入库，数量需相加 
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
       5）、“差异”不为0时确认是否异常
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
       6）、材料消耗的录入包含【材料报废】的数量
            </td>
            
            </tr>
            

        </table>
 </div>

<div id="dialog-form" title="物料信息">
<table id="wlxx" width="800px" cellspacing="0">
    <thead>
        <tr>
            <th style=" width:5%"><input type='checkbox' name='wlxx_qx' value="全选" /></th>
            <th style=" width:10%">仓库编号</th>
            <th style=" width:10%">物料编号</th>
            <th style=" width:10%">物料名称</th>
            <th style=" width:10%">物料批次</th>
            <th style=" width:10%">供应商</th>
            <th style=" width:25%">规格</th>
            <th style=" width:5%">期末数量</th>
            <th style=" width:5%">单位</th>
        </tr>
    </thead>
    <tbody>

    </tbody>
</table>
<table id="blxx" width="800px" cellspacing="0">
    <thead>
        <tr>
            <th><input type='checkbox' name='blxx_qx' value="全选" /></th>
            <th style="height: 19px">不良名称</th>
            <th style="height: 19px">不良代码</th>
            <th style="height: 19px">类别</th>
        </tr>
    </thead>
    <tbody>

    </tbody>
</table>
</div>
    <asp:HiddenField ID="bl" runat="server"  Value="0" />
        <asp:Button ID="B_last" runat="server" Text="上一页" OnClick="B_last_Click" />
        &nbsp;&nbsp;&nbsp;
        <asp:button text=" 保  存 " runat="server" style="width:80px" id="B_save" OnClick="B_save_Click" OnClientClick="return SaveClick();" TabIndex="42"/>
        &nbsp;&nbsp;&nbsp;
        <input id="Button2" type="button" value="返回列表" style="width:80px" onclick="window.location.href('jpscrblb.aspx');"  TabIndex="43"/>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="B_next" runat="server" Text="下一页" OnClick="B_next_Click" />
    <asp:HiddenField ID="wl" runat="server"  Value="0" />
    <asp:HiddenField ID="HF_id" runat="server" />
    <asp:HiddenField ID="HF_ZJ" runat="server"  Value="0" />
    <asp:HiddenField ID="HF_HGP" runat="server"  Value="0" />
    <asp:HiddenField ID="HF_FP" runat="server"  Value="0" />
    <asp:HiddenField ID="HF_DZP" runat="server"  Value="0" />
    <asp:HiddenField ID="HF_BMLQ" runat="server"  Value="0" />
    <asp:HiddenField ID="HF_DCLP" runat="server"  Value="0" />
 </form>

<input type="hidden" name="prevTrIndex" id="prevTrIndex" value="-1" /> 
<script type ="text/javascript"  >
    gxchange($("#DDL_gxmc").val(),1);
    bfjs();
    sxkz();
</script>
</body>
</html>
