<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jgd.aspx.cs" Inherits="jgd" %>
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
    function gxchange(gxmc,cczr){    //不同的工序显示不同的页面输入信息
        
             if (gxmc=="50" ){   //涂布工序录入显示需要输入的信息
                $("#ggxx_tr2").find("th")[2].innerHTML="数量"; 
                $("#TB_sl").show();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[3].innerHTML="单位"; 
                $("#TB_dw").show();                              //报废数量2textbox
                $("#scxx_tr1").hide();
                $("#scxx_tr2").hide();
                $("#scxx_tr3").hide();
                $("#tab1").show();
            }else if (gxmc=="15" ){   //涂布工序录入显示需要输入的信息
                $("#ggxx_tr2").find("th")[2].innerHTML=""; 
                $("#TB_sl").hide();                              //报废数量1textbox
                $("#ggxx_tr2").find("th")[3].innerHTML=""; 
                $("#TB_dw").hide();                              //报废数量2textbox
                $("#scxx_tr1").find("th")[0].innerHTML="前日结存";
                $("#scxx_tr1").find("th")[1].innerHTML="当日转入";
                $("#scxx_tr1").find("th")[2].innerHTML="当日生产";
                $("#scxx_tr1").find("th")[3].innerHTML="当日转出";
                $("#scxx_tr1").find("th")[4].innerHTML="当日结存";
                $("#scxx_tr1").show();
                $("#scxx_tr2").show();
                $("#scxx_tr3").show();
                $("#tab1").hide();
            }
            
            //转换工序后清空数据
            if (cczr==2){
                $("#TB_rq").val("");
                $("#TB_wlbh").val("");
                $("#TB_wlmc").val("");
                $("#TB_gys").val("");
                $("#TB_pc").val("");
                $("#TB_gg").val("");
                $("#TB_sl").val(0);
                $("#TB_dw").val("");
                $("#TB_qryz").val(0);
                $("#TB_qrwz").val(0);
                $("#TB_drzr").val(0);
                $("#TB_drsc").val(0);
                $("#TB_drzc").val(0);
                $("#TB_dryz").val(0);
                $("#TB_drwz").val(0);
               
            }
            
        }

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

      }
      function addTr2(tab, row){
            var trHtml="";
           
                var w=parseInt($('#wl').val());
                w=w+1;
                $('#wl').val(w);
                 var sl=$("#TB_sl_t").val();
                 document.getElementById("TB_wlbh_t").focus();
                if( sl.length==0)
                {
                    alert("物料数量不能为空!");
                    document.getElementById("TB_sl_t").focus();
                    return false;
                }
                if( $("#TB_wlbh_t").val()=="")
                {
                    alert("物料代码不能为空!");
                    document.getElementById("TB_wlbh_t").focus();
                    return false;
                }
                if( $("#TB_wlmc_t").val()=="")
                {
                    alert("物料名称不能为空!");
                    document.getElementById("TB_wlmc_t").focus();
                    return false;
                }
                  
                  
                trHtml  ="<tr><td><input  type='text'  style='width:95%' name='TB_wlbh"+ w +"'   id='TB_wlbh"+ w +"' value='"+ $('#TB_wlbh_t').val() +"'/></td> "
                       +" <td><input  type='text'  style='width:95%' name='TB_wlmc"+ w +"'   id='TB_wlmc"+ w +"' value='"+ $('#TB_wlmc_t').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_wlpc"+ w +"'   id='TB_wlpc"+ w +"' value='"+ $('#TB_wlpc_t').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_gys"+ w +"'  id='TB_gys"+ w +"' value='"+ $('#TB_gys_t').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_gg"+ w +"'  id='TB_gg"+ w +"' value='"+ $('#TB_gg_t').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_sl"+ w +"'  id='TB_sl"+ w +"' value='"+ $('#TB_sl_t').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_dw"+ w +"'  id='TB_dw"+ w +"' value='"+ $('#TB_dw_t').val() +"'/></td>"
                       +" <td><input  type='checkbox' name='ckb'/></td></tr>";
                $("#TB_wlbh_t").val(""); 
                $("#TB_wlmc_t").val(""); 
                $("#TB_wlpc_t").val(""); 
                $("#TB_gys_t").val(""); 
                $("#TB_gg_t").val(""); 
                $("#TB_sl_t").val(""); 
                $("#TB_dw_t").val(""); 

            addTr(tab, row, trHtml);
        }
        
        function getwlxx(){
            var data ="";
            if($("#xz").val()=="2" ){ 
                data = "{'wlxx':{'Ckbh':'"+ $("#DDL_gxmc").val() +"','Wlbh':'"+ $("#TB_wlbh_t").val() +"','Wlmc':'"+ $("#TB_wlmc_t").val() +"','Sx':'ycl','Wlpc':'"+ $("#TB_wlpc_t").val() +"','Sl':'1','Dw':'pcs','Gys':'"+ $("#TB_gys_t").val() +"'}}";
            }
            if($("#xz").val()=="1" ){ 
                data = "{'wlxx':{'Ckbh':'"+ $("#DDL_gxmc").val() +"','Wlbh':'"+ $("#TB_wlbh").val() +"','Wlmc':'"+ $("#TB_wlmc").val() +"','Sx':'"+ $("#DDL_sx").val() +"','Wlpc':'"+ $("#TB_pc").val() +"','Sl':'1','Dw':'pcs','Gys':'"+ $("#TB_gys").val() +"'}}";
            }
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
		                if($("#xz").val()=="2" ){
		                    $("#TB_wlbh_t").val(($(this).find("td")[1]).innerHTML); 
                            $("#TB_wlmc_t").val(($(this).find("td")[2]).innerHTML); 
                            $("#TB_wlpc_t").val($("#TB_pc").val()); 
                            $("#TB_gys_t").val(($(this).find("td")[4]).innerHTML); 
                            $("#TB_gg_t").val(($(this).find("td")[5]).innerHTML); 
                            $("#TB_dw_t").val(($(this).find("td")[7]).innerHTML); 
		                    $("#dialog-form").dialog("close");
		                    $("#TB_sl_t").focus();
		                }
		                if($("#xz").val()=="1" ){
		                    $("#TB_wlbh").val(($(this).find("td")[1]).innerHTML); 
                            $("#TB_wlmc").val(($(this).find("td")[2]).innerHTML); 
                            $("#TB_pc").val(($(this).find("td")[3]).innerHTML); 
                            $("#TB_gys").val(($(this).find("td")[4]).innerHTML); 
                            $("#TB_gg").val(($(this).find("td")[5]).innerHTML); 
                            $("#TB_dw").val(($(this).find("td")[7]).innerHTML); 
		                    $("#dialog-form").dialog("close");
		                    $("#TB_sl").focus();
		                }
	                });
                    //.dblclick(function(){ //鼠标双击 
                    //   $("#TB_wlbh").val(($(this).find("td")[1]).innerHTML); 
                    //}); 
	                  
                   
           	                  
	                clickTr(1); 
                },
                error: function(error) {
                    alert("调用出错" + error.responseText);
                }
                
            });

        }
   
        function clickTr(currTrIndex){ 
		    var prevTrIndex = $("#prevTrIndex").val(); 
		    if (currTrIndex > -1){ 
			    $("#tr_" + currTrIndex).addClass("hover"); 
		    } 
		    $("#tr_" + prevTrIndex).removeClass("hover"); 
		    $("#prevTrIndex").val(currTrIndex); 
	    } 
        
        
        function addCZXX(tab, row, trHtml){
         //获取table最后一行 $("#tab tr:last")
         //获取table第一行 $("#tab tr").eq(0)
         //获取table倒数第二行 $("#tab tr").eq(-2) 
        }
      
        function duoxuan(bgmc){
            if($("#xz").val()=="2" ){
                var bgmcs=$("input[name="+bgmc+"]:checked");
                if(bgmcs.size()==0){
                    return;
                }
                var w=parseInt($('#wl').val());
                var trHtml="";
                if (bgmcs.size()>0){
                    bgmcs.each(function(){
                        w=w+1;
                        trHtml="<tr><td><input  type='text'  style='width:95%' name='TB_wlbh"+ w +"'   id='TB_wlbh"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[1]).innerHTML +"'/></td> "
                           +" <td><input  type='text'  style='width:95%' name='TB_wlmc"+ w +"'   id='TB_wlmc"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[2]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_wlpc"+ w +"'   id='TB_wlpc"+ w +"' value='"+  $("#TB_pc").val() +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_gys"+ w +"'  id='TB_gys"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[4]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_gg"+ w +"'  id='TB_gg"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[5]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_sl"+ w +"'  id='TB_sl"+ w +"' value=''/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_dw"+ w +"'  id='TB_dw"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[7]).innerHTML +"'/></td>"
                           +" <td><input  type='checkbox' name='ckb'/></td></tr>";
                        $('#wl').val(w);
                        addTr("tab1",-1, trHtml);
                    });
                    $("#TB_wlbh_t").val(""); 
                    $("#TB_wlmc_t").val(""); 
                    $("#TB_wlpc_t").val(""); 
                    $("#TB_gys_t").val(""); 
                    $("#TB_gg_t").val(""); 
                    $("#TB_sl_t").val(""); 
                    $("#TB_dw_t").val(""); 
                }
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
                    data="{'sgrb':{'Id':'"+ $("#HF_id").val() +"','Blid':'0','Wlid':'"+$("#"+del_ID ).val() +"'}}";
                    $.ajax({
                        type: "POST",
				        url: "../GetContent.asmx/Del_jgd_wl",
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
    

    function SaveClick()
    {
        var zt=0
        var wlbh=$("#TB_wlbh").val()
        if( wlbh=="")
        {
            $("#div_wlbh").text("*物料编号不能为空!");
            $("#div_wlbh").show();
            document.getElementById("TB_wlbh").focus();
            zt=1;
        }else{
            $("#div_wlbh").hide();
        }
        var wlmc=$("#TB_wlmc").val();
        if( wlmc=="")
        {
            $("#div_wlmc").text("*物料名称不能为空!");
            $("#div_wlmc").show();
            document.getElementById("TB_wlmc").focus();
             zt=1;
        }else{
            $("#div_wlmc").hide();
        }

        var pc=$("#TB_pc").val();
        if( pc=="")
        {
            $("#div_pc").text("*生产批次不能为空!");
            $("#div_pc").show();
            document.getElementById("TB_pc").focus(); 
             zt=1;
        }else{
            $("#div_pc").hide();
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
        
        var fqts=$("#TB_gys").val();
        if( fqts.length==0)
        {
            $("#div_gys").text("*供应商不能为空!");
            $("#div_gys").show();
            document.getElementById("TB_gys").focus();
             zt=1;
        }else{
            $("#div_gys").hide();
        }
        
        var bfsl1=$("#TB_gg").val();
        if( bfsl1.length==0)
        {
            $("#div_gg").text("*报废数量不能为空!");
            $("#div_gg").show();
            document.getElementById("TB_gg").focus();
             zt=1;
        }else{
            $("#div_gg").hide();
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
        
        

        
        if( $("#TB_wlbh_t").val().length!=0 && $("#TB_sl_t").val()=="" )
        {
            $("#div_wlbh").text("*物料数量不能为空!");
            $("#div_wlbh").show();
            document.getElementById("TB_sl_t").focus();
             zt=1;
        }else{
            $("#div_wlbh_t").hide();
        }
        

        
        
        for(var i=1;i<3;i++){
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
        
        for(var i=1;i<2;i++){
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
        
        for(var i=1;i<2;i++){
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
        for(var i=1;i<2;i++){
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
        for(var i=1;i<3;i++){
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
        
        $(document).keypress(function(e) {  
        // 回车键事件  
            if(e.which == 13) { 
                var prevTrIndex = parseInt($("#prevTrIndex").val()); 
                if($("#xz").val()=="2" ){
                    $("#TB_wlbh_t").val(($("#tr_" + prevTrIndex).find("td")[1]).innerHTML);   
                    $("#TB_wlmc_t").val(($("#tr_" + prevTrIndex).find("td")[2]).innerHTML); 
                    $("#TB_wlpc_t").val($("#TB_pc").val()); 
                    $("#TB_gys_t").val(($("#tr_" + prevTrIndex).find("td")[4]).innerHTML); 
                    $("#TB_gg_t").val(($("#tr_" + prevTrIndex).find("td")[5]).innerHTML); 
                    $("#TB_dw_t").val(($("#tr_" + prevTrIndex).find("td")[7]).innerHTML); 
                    $("#dialog-form").dialog("close");
                    $("#TB_sl_t").focus();
                    return false;
                }
                if($("#xz").val()=="1" ){
                    $("#TB_wlbh").val(($("#tr_" + prevTrIndex).find("td")[1]).innerHTML);   
                    $("#TB_wlmc").val(($("#tr_" + prevTrIndex).find("td")[2]).innerHTML); 
                    $("#TB_pc").val(($("#tr_" + prevTrIndex).find("td")[3]).innerHTML); 
                    $("#TB_gys").val(($("#tr_" + prevTrIndex).find("td")[4]).innerHTML); 
                    $("#TB_gg").val(($("#tr_" + prevTrIndex).find("td")[5]).innerHTML); 
                    $("#TB_dw").val(($("#tr_" + prevTrIndex).find("td")[7]).innerHTML); 
                    $("#dialog-form").dialog("close");
                    $("#TB_sl").focus();
                    return false;
                }
            }
             
         });
           
        $("#TB_wlbh_t").keypress(function(e){
            if(e.which == 32) {
                $("#xz").val("2")
                getwlxx();
	            $( "#dialog-form" ).dialog( "open" );
	            $("#wlxx").show();
            } 
        });
        $("#TB_wlbh").keypress(function(e){
            if(e.which == 32) {
                $("#xz").val("1")
                getwlxx();
	            $( "#dialog-form" ).dialog( "open" );
	            $("#wlxx").show();
            } 
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
					duoxuan("wlxx_dx");
					$( this ).dialog( "close" );
				},
				Cancel:function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
			    $('#wlxx tbody tr').remove();   //关闭窗口的时候清空记录
				allFields.val("").removeClass( "ui-state-error" );
			}
		});

	    $( "#TB_wlbh_t" )
		.click(function() {
		    $("#xz").val("2")
		    getwlxx();
			$( "#dialog-form" ).dialog( "open" );
			$("#wlxx").show();
		});
		$( "#TB_wlbh" )
		.click(function() {
		    $("#xz").val("1")
		    getwlxx();
			$( "#dialog-form" ).dialog( "open" );
			$("#wlxx").show();
		});
		
    });
	    
	   
//	    });
	    
	    
	    
        $("#prevTrIndex").val("-1");//默认-1 
	    var trSize = $("#wlxx tbody  tr").size(); //datagrid中tr的数量 
         //投产计划参照
        function xhrl(xh_rl){
            if(xh_rl!=""){
                $("#TB_xh").val(xh_rl.split('|')[0]); 
                $("#TB_rl").val(xh_rl.split('|')[1]); 

            }
        }
        


</script>
    <form id="form1" runat="server">

    
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
                <asp:ListItem Value="50">铝塑膜分切</asp:ListItem >
                <asp:ListItem Value="15">正极耳点焊</asp:ListItem>
                <asp:ListItem Value="15">负极耳点焊</asp:ListItem >
            </asp:DropDownList>
            </h1></th>
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
    <th width="8%">
        物料编码</th>
    <td width="12%">
        <asp:TextBox ID="TB_wlbh" runat="server" Width="95%" TabIndex="3" ></asp:TextBox>
    </td>
    <th width="8%">
        物料名称</th>
    <td width="12%"><asp:TextBox ID="TB_wlmc" runat="server" Width="95%" ></asp:TextBox><div id="div_wlmc" style="color:Red;" visible="false"></div></td>
    <th width="8%">
        供应商</th>
    <td width="12%"><asp:TextBox ID="TB_gys" runat="server" Width="95%" ></asp:TextBox><div id="div_gys" style="color:Red;" visible="false"></div></td>
  </tr>
  <tr id ="ggxx_tr2" >
    <th>批次</th>
    <td><asp:TextBox ID="TB_pc" runat="server" Width="95%" TabIndex="4"  onchange="javascript:xhrl(this.value)"  ></asp:TextBox><div id="div_pc" style="color:Red;" visible="false"></div></td>
    <th>规格</th>
    <td colspan="3"><asp:TextBox ID="TB_gg" runat="server" Width="95%" TabIndex="5" ></asp:TextBox><div id="div_gg" style="color:Red;" visible="false"></div></td>
    <th>数量</th>
    <td><asp:TextBox ID="TB_sl" runat="server" Width="95%" >0</asp:TextBox><div id="div_sl" style="color:Red;" visible="false"></div></td>
    <th>单位</th>
    <td><asp:TextBox ID="TB_dw" runat="server" Width="95%" ></asp:TextBox><div id="div_dw" style="color:Red;" visible="false"></div></td>
  </tr>
    <tr id ="ggxx_tr3"  >
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
    <td style="height: 26px"><asp:TextBox ID="TB_qryz" runat="server" Width="95%" onchange="cyjs();" TabIndex="7">0</asp:TextBox><div id="div_qryz" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">
        转入</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drzr" runat="server" Width="95%" onchange="cyjs();" TabIndex="11">0</asp:TextBox><div id="div_drzr" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">
        生产</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drsc" runat="server" Width="95%" TabIndex="15">0</asp:TextBox><div id="div_drsc" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">
        转出</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drzc" runat="server" Width="95%" onchange="cyjs();" TabIndex="18">0</asp:TextBox><div id="div_drzc" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">已制</th>
    <td style="height: 26px"><asp:TextBox ID="TB_dryz" runat="server" Width="95%" onchange="cyjs();" TabIndex="24">0</asp:TextBox><div id="div_dryz" style="color:Red;" visible="false"></div></td>
  </tr>
  <tr id ="scxx_tr3">
    <th style="height: 26px">未制</th>
    <td style="height: 26px"><asp:TextBox ID="TB_qrwz" runat="server" Width="95%" onchange="cyjs();" TabIndex="8">0</asp:TextBox><div id="div_qrwz" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px"></th>
    <td style="height: 26px"><div id="div_drzr2" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px"></th>
    <td style="height: 26px"><div id="div_drsc2" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px"></th>
    <td style="height: 26px"><div id="div_drzc2" style="color:Red;" visible="false"></div></td>
    <th style="height: 26px">未制</th>
    <td style="height: 26px"><asp:TextBox ID="TB_drwz" runat="server" Width="95%" onchange="cyjs();" TabIndex="25">0</asp:TextBox><div id="div_drwz" style="color:Red;" visible="false"></div></td>
  </tr>
  
    <tr>
        <td colspan="10" rowspan="2" style="height: 15px">
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</td>
    </tr>
    <tr>
    </tr>
</table>
        <table id="tab1" runat="server" width="1000px" cellspacing="0" align="center">
            <tr>
                <th style="width:12%">物料编号</th>
                <th style="width:10%">物料名称</th>
                <th style="width:12%">物料批次</th>
                <th style="width:10%">供应商</th>
                <th style="width:39%">规格</th>
                <th style="width:4%">使用数</th>
                <th style="width:3%">单位</th>
                <th style="width:5%"><asp:button  runat="server" id="wl_delete"  OnClientClick="delTr2();return false;" text="删除" style="width:58px" /></th>
            </tr>
            <tr>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_wlbh_t" runat="server" Width="95%" TabIndex="34"  ></asp:TextBox>
                    <div id="div_wlbh_t" style="color:Red"  visible="false" ></div>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_wlmc_t" runat="server" Width="95%" TabIndex="35"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_wlpc_t" runat="server" Width="95%" TabIndex="36"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_gys_t" runat="server" Width="95%" TabIndex="37"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_gg_t" runat="server" Width="95%" TabIndex="38"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_sl_t" runat="server" Width="95%" TabIndex="39"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:TextBox ID="TB_dw_t" runat="server" Width="95%" TabIndex="40"></asp:TextBox>
                </td>
                <td style="height: 28px">
                    <asp:button  runat="server" OnClientClick="addTr2('tab1', -1);return false; " id="wl_add"  text="添加"  style="width:58px"  TabIndex="41" /> 
                </td>
            </tr>
        </table>
 </div>

<div id="dialog-form" title="物料信息">
<table id="wlxx" width="800px" cellspacing="0">
    <thead>
        <tr>
            <th style="height: 24px"><input type='checkbox' name='wlxx_qx' value="全选" /></th>
            <th style="height: 24px">仓库编号</th>
            <th style="height: 24px">物料编号</th>
            <th style="height: 24px">物料名称</th>
            <th style="height: 24px">物料批次</th>
            <th style="height: 24px">供应商</th>
            <th style="height: 24px">规格</th>
            <th style="height: 24px">期末数量</th>
            <th style="height: 24px">单位</th>
        </tr>
    </thead>
    <tbody> 

    </tbody>
</table>
</div>
        <asp:button text=" 保  存 " runat="server" style="width:80px" id="B_save" OnClick="B_save_Click" OnClientClick="return SaveClick();" TabIndex="42"/>
        &nbsp; &nbsp;&nbsp;
        <input id="Button2" type="button" value="返回列表" style="width:80px" onclick="window.location.href('jgdlb.aspx');"  TabIndex="43"/>
    <asp:HiddenField ID="xz" runat="server"  Value="1" />    
    <asp:HiddenField ID="wl" runat="server"  Value="0" />
    <asp:HiddenField ID="HF_id" runat="server" />
 </form>

<input type="hidden" name="prevTrIndex" id="prevTrIndex" value="-1" /> 
<script type ="text/javascript"  >
    gxchange($("#DDL_gxmc").val(),1);

</script>
</body>
</html>
