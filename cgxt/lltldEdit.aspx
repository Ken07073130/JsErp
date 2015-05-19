<%@ Page Language="C#" AutoEventWireup="true" CodeFile="lltldEdit.aspx.cs" Inherits="lltldEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>领料退料单</title>
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <link rel="stylesheet" href="../jquery-ui/themes/base/jquery.ui.all.css" />

    <script type="text/javascript" src="../jquery-ui/jquery-1.10.2.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.core.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.widget.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.mouse.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.button.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.draggable.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.position.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.resizable.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.button.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.dialog.js"></script>

    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.effect.js"></script>

    <link rel="stylesheet" href="../jquery-ui/demos.css" />
    <style type="text/css">
    /* CSS Document */
    body {
        font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
        color: #4f6b72;
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
</head>

<script type="text/javascript">
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
            
            var groupNames=document.getElementById("tbGroupNames").value;
            var phtkkcReadOnly="";
            var pzkcReadOnly="";
            var cwhjbzReadOnly="";
            if(document.getElementById("tbLx").value=="LLD"){
               if(groupNames.indexOf("领料退料单-仓管员")>=0 || groupNames.indexOf("超级用户")>=0){
                  phtkkcReadOnly="";
                  pzkcReadOnly="";
                  cwhjbzReadOnly="";
               } else {
                  phtkkcReadOnly="readonly='readonly'";
                  pzkcReadOnly="readonly='readonly'";
                  cwhjbzReadOnly="readonly='readonly'";
               }
            }
            
            if(document.getElementById("tbLx").value=="TLD"){
               if(groupNames.indexOf("领料退料单-领料退料员")>=0 || groupNames.indexOf("超级用户")>=0 ||
                  groupNames.indexOf("领料退料单-仓管员")>=0 ){
                  phtkkcReadOnly="";
               } else {
                  phtkkcReadOnly="readonly='readonly'";
               }

               if(groupNames.indexOf("领料退料单-IQC")>=0 || groupNames.indexOf("超级用户")>=0 ){
                  pzkcReadOnly="";
               } else {
                  pzkcReadOnly="readonly='readonly'";
               }

               if(groupNames.indexOf("领料退料单-仓管员")>=0 || groupNames.indexOf("超级用户")>=0 ){
                  cwhjbzReadOnly="";
               } else {
                  cwhjbzReadOnly="readonly='readonly'";
               }
            }
            if(tab=="tab"){
                var b=parseInt($('#bl').val());
                b=b+1;
                $('#bl').val(b);
                trHtml="<tr><td><input  type='text' "+phtkkcReadOnly+"  style='width:95%' name='tbPh"+ b +"'   id='tbPh"+ b +"'  value='"+ $('#tbPh').val() +"'/></td>"
                        +"  <td><input  type='text' "+phtkkcReadOnly+" style='width:95%' name='tbFlsl"+ b +"'   id='tbFlsl"+ b +"'  value='"+ $('#tbFlsl').val() +"'/></td>"
                        +"  <td><input  type='text'  "+phtkkcReadOnly+" style='width:95%' name='tbKcl"+ b +"'   id='tbKcl"+ b +"'  value='"+ $('#tbKcl').val() +"'/></td>"
                        + " <td> <select id='ddlPzzk" + b + "' name='ddlPzzk" + b + "' " + pzkcReadOnly + " > <option selected='selected'>请选择</option> <option >合格</option> <option>不合格</option> <option >让步</option></select> </td> "
                        + " <td> <select id='ddlRkcz" + b + "' name='ddlRkcz" + b + "' " + pzkcReadOnly + " > <option selected='selected'>请选择</option> <option >可用</option> <option>退货</option> <option>呆滞</option> </td> "
                        +"  <td><input   type='text' "+cwhjbzReadOnly+"  style='width:95%' name='tbCw"+ b +"'   id='tbCw"+ b +"'  value='"+ $('#tbCw').val() +"'/></td>"
                        +"  <td><input  type='text' "+cwhjbzReadOnly+" style='width:95%' name='tbHjh"+ b +"'   id='tbHjh"+ b +"' value='"+ $('#tbHjh').val() +"' /></td>"
                        +"  <td><input  type='text' "+cwhjbzReadOnly+"  style='width:95%' name='tbFlbz"+ b +"'   id='tbFlbz"+ b +"' value='"+ $('#tbFlbz').val() +"'/></td>"
                        +"  <td><input type='checkbox' name='ckb'/></td></tr>";
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
                 document.getElementById("tbWlbh").focus();
                  
                  
                trHtml="<tr><td> <select   style='width:95%' name='DDL_sx" + w + "' ID='DDL_sx" + w + "'  ><option></option><option value='返料'>返料</option><option value='材料报废'>材料报废</option><option value='混批转入'>混批转入</option> </select> </td>  "
                       +" <td><input  type='text'  style='width:95%' name='tbWlbh"+ w +"'   id='tbWlbh"+ w +"' value='"+ $('#tbWlbh').val() +"'/></td> "
                       +" <td><input  type='text'  style='width:95%' name='TB_wlmc"+ w +"'   id='TB_wlmc"+ w +"' value='"+ $('#TB_wlmc').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_wlpc"+ w +"'   id='TB_wlpc"+ w +"' value='"+ $('#TB_wlpc').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_gys"+ w +"'  id='TB_gys"+ w +"' value='"+ $('#TB_gys').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_gg"+ w +"'  id='TB_gg"+ w +"' value='"+ $('#TB_gg').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' onchange='bfjs()'  name='TB_sl"+ w +"'  id='TB_sl"+ w +"' value='"+ $('#TB_sl').val() +"'/></td>"
                       +" <td><input  type='text'  style='width:95%' name='TB_dw"+ w +"'  id='TB_dw"+ w +"' value='"+ $('#TB_dw').val() +"'/></td>"
                       +" <td><input  type='checkbox' name='ckb'/></td></tr>";
                $("#tbWlbh").val(""); 
                $("#TB_wlmc").val(""); 
                $("#TB_wlpc").val(""); 
                $("#TB_gys").val(""); 
                $("#TB_gg").val(""); 
                $("#TB_sl").val(""); 
                $("#TB_dw").val(""); 
            }
            

            addTr(tab, row, trHtml);
        }
        
        function getwlxx(){
          var djlx='<%=Request.QueryString["djlx"]%>';
          var ckxx="0001";
          if (djlx=='TLD'){
             ckxx= document.getElementById("tbCjdm").value;
          }
          var data = "{'wlxx':{'Ckbh':'"+ckxx+"','Wlbh':'"+ $("#tbWlbh").val() +"','Wlmc':'"+ $("#tbWlmc").val() +"','Gg':'ddhg','Wlpc':'"+ "" +"','Sl':'1','Dw':'pcs','Gys':'"+$("#tbGysdm").val()+"'}}";
             $.ajax({
                type: "POST",
                url: "../GetContent.asmx/GetWlkcxxArrayList",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function(json) {  $(json).each(function() {
                      //  var trHtml="<tr><th><input type='checkbox' name='wlxx_dx'  /></th><td>"+ this.Ckbh +"</td><td>"+ this.Wlbh +"</td><td>"+ this.Wlmc +"</td><td>"+ this.Wlpc +"</td><td>"+ this.Gys +"</td><td>"+ this.Gg +"</td><td>"+ this.Sl +"</td><td>"+ this.Dw +"</td></tr>";
                        var trHtml="<tr><td sytle='width:100px;text-align:center'>"+ this.Wlbh +"</td><td sytle='width:150px'>"+ this.Wlmc +"</td>"
                                  +"</td><td sytle='width:100px'>"+ this.Gys  +"</td><td sytle='width:100px'>"+ this.Gg +"</td><td sytle='width:100px'>"+ this.Sl+"</td><td visible='false' style='display:none;'>"+ this.Dw+"</td></tr>";
                     
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
                        $("#tbWlbh").val(($(this).find("td")[0]).innerHTML); 
                        $("#tbWlmc").val(($(this).find("td")[1]).innerHTML); 
                        $("#tbGys").val(($(this).find("td")[2]).innerHTML); 
                        $("#tbGg").val(($(this).find("td")[3]).innerHTML); 
                        $("#tbZkl").val(($(this).find("td")[4]).innerHTML); 
                        $("#tbDw").val(($(this).find("td")[5]).innerHTML); 
		                $("#dialog-form").dialog("close");
		                document.getElementById("tbXqsl").focus();
	                });//.dblclick(function(){ //鼠标双击 
		              //   $("#tbWlbh").val(($(this).find("td")[1]).innerHTML); 
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
        
        
         function getWlxx_PH(){
         
          var ckbh="";
          if($('#tbLx').val()=="LLD"){
             ckbh="0001";
          } else {
             ckbh=$('#tbCjdm').val();
          }
             
          var data = "{'wlxx':{'Ckbh':'"+ckbh+"','Wlbh':'"+ $("#tbWlbh").val() +"','Wlmc':'"+ $("#tbWlmc").val() +"','Gg':'ddhg','Wlpc':'"+ "" +"','Sl':'1','Dw':'pcs','Gys':'"+$("#tbGysdm").val()+"'}}";
             $.ajax({
                type: "POST",
                url: "../GetContent.asmx/GetWlkcxxPCArrayList",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function(json) {  $(json).each(function() { 
                      //  var trHtml="<tr><th><input type='checkbox' name='wlxx_dx'  /></th><td>"+ this.Ckbh +"</td><td>"+ this.Wlbh +"</td><td>"+ this.Wlmc +"</td><td>"+ this.Wlpc +"</td><td>"+ this.Gys +"</td><td>"+ this.Gg +"</td><td>"+ this.Sl +"</td><td>"+ this.Dw +"</td></tr>";
                        var trHtml="<tr><td sytle='width:100px;text-align:center'>"+ this.Wlpc +"</td><td sytle='width:150px'>"+ this.Sl +"</td>"
                                  +"</td><td sytle='width:100px'>"+ this.Cw  +"</td><td >"+ this.Hjh+"</td><td >"+ this.Pzzk+"</td><td >"+ this.Rkcz+"</td></tr>";
                     
                        var $tr=$("#ckxx tbody");
//                        if($tr.size()==0){
//                            alert("指定的table id或行数不存在！");
//                            return;
//                        }
                        $tr.append(trHtml);
                    
                    });
                    trSize = $("#ckxx tbody tr").size();//datagrid中tr的数量 
                    $("#ckxx tbody tr").mouseover(function(){//鼠标滑过 
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
                        $("#tbPh").val(($(this).find("td")[0]).innerHTML); 
                        $("#tbKcl").val(($(this).find("td")[1]).innerHTML); 
                        $("#tbCw").val(($(this).find("td")[2]).innerHTML); 
                        $("#tbHjh").val(($(this).find("td")[3]).innerHTML); 
                        
                       
                        var pzzk=($(this).find("td")[4]).innerHTML;
                        var rkcz=($(this).find("td")[5]).innerHTML;
                        var i=0;
                        if($('#tbLx').val()=="LLD"){
                           $("#ddlPzzk option").each(function(){
                                if($(this).val()==pzzk){
                                  $("#ddlPzzk").get(0).selectedIndex = i; 
                                }
                                i++;
                           });
                        }

                        i=0;
                        if($('#tbLx').val()=="LLD"){
                          $("#ddlRkcz option").each(function(){
                            if($(this).val()==rkcz){
                              $("#ddlRkcz").get(0).selectedIndex = i; 
                            }
                            i++;
                          });
                        }
                       
                         
                         //只读
                        $("#tbCw").attr("readonly","readonly");
                        $("#tbHjh").attr("readonly","readonly");
                        $("#ddlPzzk").attr("disabled","disabled");
                        $("#ddlRkcz").attr("disabled","disabled");
                        
                         $("#dialog-form").dialog("close");
		                document.getElementById("tbFlsl").focus();
	                });//.dblclick(function(){ //鼠标双击 
		              //   $("#tbWlbh").val(($(this).find("td")[1]).innerHTML); 
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
        
        
        
        
      
       
        function clickTr(currTrIndex){ 
		    var prevTrIndex = $("#prevTrIndex").val(); 
		    if (currTrIndex > -1){ 
			    $("#tr_" + currTrIndex).addClass("hover"); 
		    } 
		    $("#tr_" + prevTrIndex).removeClass("hover"); 
		    $("#prevTrIndex").val(currTrIndex); 
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
                           +" <td><input  type='text'  style='width:95%' name='tbWlbh"+ w +"'   id='tbWlbh"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[1]).innerHTML +"'/></td> "
                           +" <td><input  type='text'  style='width:95%' name='TB_wlmc"+ w +"'   id='TB_wlmc"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[2]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_wlpc"+ w +"'   id='TB_wlpc"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[3]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_gys"+ w +"'  id='TB_gys"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[4]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_gg"+ w +"'  id='TB_gg"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[5]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' onchange='bfjs()'  name='TB_sl"+ w +"'  id='TB_sl"+ w +"' value=''/></td>"
                           +" <td><input  type='text'  style='width:95%' name='TB_dw"+ w +"'  id='TB_dw"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[7]).innerHTML +"'/></td>"
                           +" <td><input  type='checkbox' name='ckb'/></td></tr>";
                        $('#wl').val(w);
                        addTr("tab1",-1, trHtml);
                    });
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
    
  
   
   //计算发料数量 
   function calZflsl(){
          var sum=0;
          $('[id^=tbFlsl]').each(function(){sum=sum+$(this).val()*1});
          document.getElementById("tbZFlsl").value=sum;
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
                if($("#wlxx").is(":visible") ){
                    $("#tbWlbh").val(($("#tr_" + prevTrIndex).find("td")[0]).innerHTML);   
                    $("#tbWlmc").val(($("#tr_" + prevTrIndex).find("td")[1]).innerHTML); 
                    $("#tbGys").val(($("#tr_" + prevTrIndex).find("td")[2]).innerHTML); 
                    $("#tbGg").val(($("#tr_" + prevTrIndex).find("td")[3]).innerHTML); 
                    $("#tbZkl").val(($("#tr_" + prevTrIndex).find("td")[4]).innerHTML); 
                     $("#tbDw").val(($("#tr_" + prevTrIndex).find("td")[5]).innerHTML); 
                    $("#dialog-form").dialog("close");
                    
		             document.getElementById("tbXqsl").focus();
                    
                    
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
           
        $("#tbWlbh").keypress(function(e){
            if(e.which == 32) {
               
                getwlxx();
	            $( "#dialog-form" ).dialog( "open" );
	            $("#wlxx").show();
	            $("#ckxx").hide();
            } 
        });
        
        $("#tbPh").keypress(function(e){
            if(e.which == 32) {
               
                getWlxx_PH();
	            $( "#dialog-form" ).dialog( "open" );
	            $("#wlxx").hide();
	            $("#ckxx").show();
            } 
        });
		
		
	    $("#tbCj").blur(function(e){
	           /*这里是根据textbox 显示 dropdownlist的jquery
                if($('#tbCj').val().length>0){
                    var i=0;
                    $("#ddlCj option").each(function() {
		                    if($(this).text().indexOf($('#tbCj').val())>=0){
		                      //  $("#ddlCj").find("option[text='二']").attr("selected",true);
		                      $("#ddlCj").get(0).selectedIndex = i;
		                    }
		                    i++
    		                
	                });*/ 
	                if($('#tbCj').val().length>0){
	                   var index=$('#tbCj').val().indexOf('_');
	                   if(index>=0){
	                       var cjdm=$('#tbCj').val().substring(0,index);
	                       $('#tbCjdm').val(cjdm);
	                   } else {
	                       alert('未获取到车间号，请填写车间');
	                   }
	                } 
        });
			
		
		allFields = $( [] ),
		tips = $( ".validateTips" );

		$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 400,
			width: 860,
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
				取消:function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
			    $('#wlxx tbody tr').remove();   //关闭窗口的时候清空记录
			    $('#ckxx tbody tr').remove();   //关闭窗口的时候清空记录
				allFields.val("").removeClass( "ui-state-error" );
				
			}
		});

		    $( "#tbWlbh" )
			.dblclick(function() {
			    $("#wlxx").show();
				$("#ckxx").hide();
			    getwlxx();
				$( "#dialog-form" ).dialog( "open" );
				
			});
			
	
			
			
			
		     $( "#TB_bldm" )
		    .click(function() {
		        getblxx();
			    $( "#dialog-form" ).dialog( "open" );
			    $("#wlxx").hide();
			    $("#blxx").show();
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
        
        
        
//1.IQC会签
function IQCChange(){
       if(document.getElementById('ddlIQC').value.length>0){
           document.getElementById('ddlIQChqzt').value="已会签";
           var sysDate=new Date(); 
           document.getElementById('tbIQChqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds();
           if("-"==document.getElementById('ddlCgyhqzt').value){
               document.getElementById('ddlCgyhqzt').value="会签中";
               document.getElementById('tbLlzt').value="等待退料进仓";
               
           }  
       }
}

//2.仓管员会签
function CgyChange(){
       if(document.getElementById('ddlCgy').value.length>0){
           document.getElementById('ddlCgyhqzt').value="已会签";
           var sysDate=new Date(); 
           document.getElementById('tbCgyhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds();
           document.getElementById('tbLlzt').value="已完成";
       
       }
}

//提交时 校验必填项
//1.发料数量/退库数量必填
//1.1 退料单  IQC签名后，需要校验品质状况和库存方式是否填写
//1.2 退料单  仓管员签名后，需要校验仓位库位是否填写正确
function checkAll(){
      var result="";
      //如果有批号，那么数量必填
      $('[id^=ddlPzzk]').each(function(){$(this).removeAttr("disabled")});
      $('[id^=ddlRkcz]').each(function(){$(this).removeAttr("disabled")});
      document.getElementById('bl').value=document.getElementById('tab').rows.length;
       
      // 退料单  IQC签名后，需要校验品质状况和库存方式
      var djlx='<%=Request.QueryString["djlx"]%>';
      //alert(djlx);
      var iqc=document.getElementById("ddlIQC").value.length;
      if(djlx=='TLD'&&iqc>0){
         $('[id^=tbPh]').each(function(){
	                            var i=$(this).attr("id");
	                            var pzzk="";
	                            var rkcz="";
	                            var rkcz="";
	                            var flbz="";
	                            var ph=$(this).val();
	                            i=i.substring(4);//获取i
	                            if(i=="h"){
                                  pzzk=document.getElementById("ddlPzzk").value;
                                  rkcz=document.getElementById("ddlRkcz").value;
                                  flbz=document.getElementById("tbFlbz").value;
	                            } else {
	                              pzzk=document.getElementById("ddlPzzk"+i).value;
                                  rkcz=document.getElementById("ddlRkcz"+i).value;
                                  flbz=document.getElementById("tbFlbz"+i).value;
	                            }
	                            //批号不为空，则品质状况和库存方式需要校验
	                            if(ph!=""&&(pzzk=="请选择"||rkcz=="请选择")){
	                               alert('请选择品质状况或者库存方式');
	                               result="false";
	                            }
	                             //退货需要填写退货理由
	                            if(rkcz=="退货"&&flbz==""){
	                               alert('退货需要填写退货理由');
	                               result="false";
	                            }
                             });
      }
      
   
      
      //退料单  仓管员签名后，需要校验仓位库位是否填写正确
      var cgy=document.getElementById("ddlCgy").value.length;
      if(djlx=="TLD"&&cgy>0){
          $('[id^=tbPh]').each(function(){
	                            var i=$(this).attr("id");
	                            var cw="";
	                            var kw="";
	                            var ph=$(this).val();
	                            i=i.substring(4);//获取i
	                            if(i=="h"){
                                  cw=document.getElementById("tbCw").value;
                                  hjh=document.getElementById("tbHjh").value;
	                            } else {
	                              cw=document.getElementById("tbCw"+i).value;
                                  hjh=document.getElementById("tbHjh"+i).value;
	                            }
	                            //批号不为空，则品质状况和库存方式需要校验
	                            if(ph!=""&&(cw==""||hjh=="")){
	                               alert('请填写仓位或者库位');
	                               result="false";
	                            }
	                           
                             });     
      }
      if (result=="false"){
        return false;
      }
      
      
             
      //有批号时 数量是否填写
      if(document.getElementById("tbPh").value!=""){
          if(document.getElementById("tbFlsl").value==""){
            alert('请填写数量');
            document.getElementById("tbFlsl").focus();
            return false;
          }
      }
       
      //有批号 数量是否填写
      for(var i=1;i<=document.getElementById('tab').rows.length;i++){
        if(document.getElementById("tbPh"+i).value!=""){
          if(document.getElementById("tbFlsl"+i).value==""){
            alert('请填写数量');
            document.getElementById("tbFlsl"+i).focus();
            return false;
          }
        } 
      } 
      
      
    	      
	      
}
  
</script>

<body>
    <form id="form1" runat="server">
        <div id="divPage">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
                AsyncPostBackTimeout="600" />
            <div class="layout" style="font-weight:bold; font-size:25px; text-align:center; color:Black;">
                <asp:Label ID="lblTile" runat="server" Text=""></asp:Label>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">单号</span><span class="spanControl"><asp:TextBox ID="tbBh"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                    <li><span class="spanLabel" id="spLly" runat="server">领料员</span><span class="spanControl"><asp:TextBox ID="tbLly"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">领料状态</span><span class="spanControl"><asp:TextBox ID="tbLlzt"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">日期</span><span class="spanControl"><asp:TextBox ID="tbJbrq"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel" id="SPAN1">工厂</span><span class="spanControl"><asp:DropDownList
                        ID="ddlGc" runat="server">
                        <asp:ListItem Value="1">新桥工厂</asp:ListItem>
                        <asp:ListItem Value="2">东洲工厂</asp:ListItem>
                    </asp:DropDownList></span> </li>
                    <li><span class="spanLabel">车间</span><span class="spanControl"><asp:TextBox ID="tbCj"
                        runat="server" Width="90%" ></asp:TextBox>
                        <ajaxToolkit:AutoCompleteExtender
                            ID="AutoCompleteExtender2" runat="server" CompletionInterval="200" MinimumPrefixLength="1"
                            ServiceMethod="GetCkxxList" ServicePath="~/GetContent.asmx" TargetControlID="tbCj">
                        </ajaxToolkit:AutoCompleteExtender>
                    </span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">物料编码</span><span class="spanControl">
                        <asp:TextBox ID="tbWlbh"
                        runat="server" Width="90%"></asp:TextBox>
                        <ajaxToolkit:AutoCompleteExtender
                            ID="AutoCompleteExtender1" runat="server" CompletionInterval="200" MinimumPrefixLength="1"
                            ServiceMethod="GetWlflList" ServicePath="~/GetContent.asmx" TargetControlID="tbWlmc">
                        </ajaxToolkit:AutoCompleteExtender>
                    </span></li>
                    <li><span class="spanLabel">车间代码</span><span class="spanControl"><asp:TextBox ID="tbCjdm"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">物料名称</span><span class="spanControl"><asp:TextBox ID="tbWlmc"
                        runat="server" Width="90%" BackColor="Silver" ></asp:TextBox>
                    </span> </li>
                    <li><span class="spanLabel">供应商</span><span class="spanControl"><asp:TextBox ID="tbGys"
                        runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
                <div class="layout">
                    <ul>
                        <li><span class="spanLabel">在库量</span><span class="spanControl"><asp:TextBox ID="tbZkl"
                            runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                        <li><span class="spanLabel">单位</span><span class="spanControl">
                            <asp:TextBox ID="tbDw" runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                    </ul>
                </div>
                <div class="layout">
                    <ul>
                        <li id="liXqsl" runat="server"><span class="spanLabel" >需求数量</span><span class="spanControl"><asp:TextBox
                            ID="tbXqsl" runat="server" Width="90%"></asp:TextBox></span> </li>
                        <li ><span class="spanLabel" id="spFlsl" runat="server">发料数量</span><span class="spanControl"><asp:TextBox
                            ID="tbZFlsl" runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                    </ul>
                </div>
                <div class="layout">
                    <ul>
                        <li style="width: 760px;"><span class="spanLabel">规格</span><span class="spanControl"
                            style="width: 600px;"><asp:TextBox ID="tbGg" runat="server" Width="95%" BackColor="Silver"></asp:TextBox>
                        </span></li>
                    </ul>
                </div>
                <div class="layout">
                    <ul>
                        <li style="width: 760px;"><span class="spanLabel">备注</span><span class="spanControl"
                            style="width: 600px;">
                            <asp:TextBox ID="tbBz" runat="server" Width="95%"></asp:TextBox></span></li></ul>
                </div>
                <div class="layout">
                    <ul>
                        <li id="liIQC" runat="server"><span class="spanLabel" id="Span2" runat="server">IQC签字确认</span><span class="spanControl"><asp:DropDownList
                            ID="ddlIQC" runat="server" onchange="IQCChange()">
                        </asp:DropDownList><asp:TextBox ID="tbIQChqsj" runat="server" Width="115px"></asp:TextBox></span>
                        </li>
                        <li id="li1" runat="server"><span class="spanLabel">仓管员签字确认</span><span class="spanControl"><asp:DropDownList
                            ID="ddlCgy" runat="server" onchange="CgyChange()">
                        </asp:DropDownList><asp:TextBox ID="tbCgyhqsj" runat="server" Width="115px"></asp:TextBox></span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div id="divFlqk" runat="server" style="margin-top: 30px; margin-bottom: 20px;">
            <table id="tab" runat="server" width="1000px" cellspacing="0" align="center">
                <tr>
                    <th style="width: 15%; height: 28px;">
                        批号</th>
                    <th style="width: 10%; height: 28px;">
                        发料数量</th>
                    <th style="width: 15%; height: 28px;">
                        库存量</th>
                    <th style="width: 10%; height: 28px;">
                        品质状况</th>
                    <th style="width: 10%; height: 28px;">
                        库存方式</th>
                    <th style="width: 10%; height: 28px;">
                        仓位</th>
                    <th style="width: 10%; height: 28px;">
                        货架号</th>
                    <th style="width: 45%; height: 28px;">
                        备注</th>
                    <th style="width: 5%; height: 28px;">
                        <asp:Button runat="server" ID="bl_delete" OnClientClick="delTr2();return false;"
                            Text="删除" Style="width: 58px" /></th>
                </tr>
                <tr>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbPh" runat="server" Width="95%" TabIndex="28"></asp:TextBox>
                    </td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbFlsl" runat="server" Width="95%" TabIndex="29" onchange="calZflsl()"></asp:TextBox>
                    </td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbKcl" runat="server" Width="95%" TabIndex="30"></asp:TextBox>
                    </td>
                    <td style="height: 28px">
                        <select id="ddlPzzk">
                            <option selected="selected">请选择</option>
                            <option>合格</option>
                            <option>不合格</option>
                            <option>让步</option>
                        </select></td>
                    <td style="height: 28px"><select id="ddlRkcz">
                        <option selected="selected">请选择</option>
                        <option>入库</option>
                        <option>退货</option>
                    </select>
                    </td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbCw" runat="server" TabIndex="32" Width="95%"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbHjh" runat="server" TabIndex="32" Width="95%"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbFlbz" runat="server" TabIndex="32" Width="95%"></asp:TextBox>
                    </td>
                    <td style="height: 28px">
                        <asp:Button runat="server" ID="bl_add" OnClientClick="addTr2('tab', -1);return false;"
                            Text="添加" Style="width: 58px" TabIndex="33" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="dialog-form" title="物料信息">
            <table id="wlxx" width="800px" cellspacing="0" style="text-align: center;" runat="server">
                <thead>
                    <tr>
                        <th>
                            物料编号</th>
                        <th>
                            物料名称</th>
                        <th>
                            供应商</th>
                        <th>
                            规格</th>
                        <th>
                            在库量</th>
                        <th visible="false" style="display: none;">
                            单位</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            
            <table id="ckxx" width="800px" cellspacing="0" style="text-align: center;" runat="server">
                <thead>
                    <tr>
                        <th>
                            批号</th>
                        <th>
                            在库量</th>
                        <th>
                            仓位</th>
                        <th>
                            货架号</th>
                        <th>
                            品质状况</th>
                        <th>
                            库存方式</th>
             
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <asp:HiddenField ID="bl" runat="server" Value="0" />
        <div style="text-align: center; margin-top: 10px;">
            <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline-block; background-color: #4B97E3;
                width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                text-decoration: none; margin: 0 auto; text-align: center" OnClick="btnTj_Click" OnClientClick="return checkAll()">提交</asp:LinkButton>
            <asp:LinkButton ID="lblReturn" runat="server" Style="display: inline-block; background-color: #4B97E3;
                width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                text-decoration: none; margin: 0 auto; text-align: center" >返回列表</asp:LinkButton>
        </div>
        <asp:HiddenField ID="wl" runat="server" Value="0" />
        <asp:HiddenField ID="HF_id" runat="server" />
        <div style="display: none">
            车间代码&nbsp;
            <input type="hidden" name="prevTrIndex" id="prevTrIndex" value="-1" />
            <asp:TextBox ID="tbLx" runat="server" Style="display: none"></asp:TextBox>
            <asp:TextBox ID="tbGroupNames" runat="server" Style="display: none"></asp:TextBox>
            <asp:DropDownList ID="ddlCgyhqzt" runat="server">
                <asp:ListItem>-</asp:ListItem>
                <asp:ListItem>会签中</asp:ListItem>
                <asp:ListItem>已会签</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlIQChqzt" runat="server">
                <asp:ListItem>-</asp:ListItem>
                <asp:ListItem>会签中</asp:ListItem>
                <asp:ListItem>已会签</asp:ListItem>
            </asp:DropDownList></div>
    </form>
</body>
</html>
