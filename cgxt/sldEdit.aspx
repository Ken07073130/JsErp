﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sldEdit.aspx.cs" Inherits="sldEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>收料单</title>
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <link rel="stylesheet" href="../jquery-ui/themes/base/jquery.ui.all.css" />
    <link rel="stylesheet" href="../jquery-ui/demos.css" />

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

    <style type="text/css">
    /* CSS Document */
    body {
        font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
        color: #4f6b72;
       
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

        color: #4f6b72;
    }
    
    #rblDdh td{
      border:0;
      
    }
    
   

    </style>

    <script type="text/javascript">
    
    //updatePanel里需要使用jquery则把这个注释去掉
     /* function load() {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        }

        function EndRequestHandler(sender, args)

        {

           alert('1');
            
		    $( "#tbWlbh" ).click(function(){
			        getwlxx();
				    $( "#dialog-form" ).dialog( "open" );
			    });
	     
        }*/
        
    
    </script>

    <script type="text/javascript">
    
      



    	    $(function() {
    //          var name = $( "#name" ),
    //			email = $( "#email" ),
    //			password = $( "#password" ),
			    allFields = $( [] ),
			    tips = $( ".validateTips" );
			


		    $( "#dialog-form" ).dialog({
			    autoOpen: false,
			    height: 400,
			    width: 850,
			    modal: true,
			    buttons: {
				    "保存": function() {
					    var bValid = true;
					    duoxuan("wlxx_dx");
					    $( this ).dialog( "close" );
				    },
				    Cancel: function() {
					    $( this ).dialog( "close" );
				    }
			    },
			    close: function() {
				    allFields.val("").removeClass( "ui-state-error" );
			    }
		    });

		        //双击触发
		        $( "#tbWlbh" ).dblclick(function(){
			        getwlxx();
				    $( "#dialog-form" ).dialog( "open" );
			    });
			    
			    //ASCII码'32' 空格键事件
			    $("#tbWlbh").keypress(function(e){
                    if(e.which == 32) {
                        getwlxx();
	                    $( "#dialog-form" ).dialog( "open" );
                    } 
                });
                
                
	        }); 
	        
	        
	        
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
      
       $(document).keypress(function(e) {  
        // 回车键事件  
            if(e.which == 13) { 
                var prevTrIndex = parseInt($("#prevTrIndex").val()); 
                
                $("#tbWlbh").val(($(this).find("td")[0]).innerHTML); 
                $("#tbWlmc").val(($(this).find("td")[1]).innerHTML); 
                $("#tbDw").val(($(this).find("td")[3]).innerHTML); 
                $("#tbGG").val(($(this).find("td")[2]).innerHTML); 
		        $( "#dialog-form" ).dialog( "close" );
		        document.getElementById("tbPh").focus();
                return false;
                
               
            }
             
         });

      
      function addTr2(tab, row){
      
            var trHtml="";
            
            var groupNames=document.getElementById("tbGroupNames").value;
            var phtkkcReadOnly="";
            var pzkcReadOnly="";
            var cwhjbzReadOnly="";
               if(groupNames.indexOf("领料退料单-仓管员")>=0 || groupNames.indexOf("超级用户")>=0){
                  phtkkcReadOnly="";
                  pzkcReadOnly="";
                  cwhjbzReadOnly="";
               } else {
                  phtkkcReadOnly="readonly='readonly'";
                  pzkcReadOnly="readonly='readonly'";
                  cwhjbzReadOnly="readonly='readonly'";
               }
            
              
            if(tab=="tab"){
                var b=parseInt($('#bl').val());
                b=b+1;
                $('#bl').val(b);
                trHtml=  "<tr>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + " style='width:90%' name='tbWlbh" + b + "'   id='tbWlbh" + b + "'  value='"+$("#tbWlbh").val()+"'  /></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + " style='width:90%' name='tbWlmc" + b + "'   id='tbWlmc" + b + "'  value='"+$("#tbWlmc").val()+"'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + " style='width:90%' name='tbGG" + b + "'   id='tbGG" + b + "'  value='"+$("#tbGG").val()+"'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + " style='width:90%' name='tbPh" + b + "'   id='tbPh" + b + "'  value='"+$("#tbPh").val()+"'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + " style='width:90%' name='tbSl" + b + "'   id='tbSl" + b + "'  value='"+$("#tbSl").val()+"'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + " style='width:90%' name='tbJe" + b + "'   id='tbJe" + b + "'  value='"+$("#tbJe").val()+"'/></td>"    
                          + "  <td><input  type='text' " + phtkkcReadOnly + " style='width:90%' name='tbDw" + b + "'   id='tbDw" + b + "'  value='"+$("#tbDw").val()+"'/></td>"
                          + "  <td><input  type='text' " + cwhjbzReadOnly + " style='width:90%' name='tbCw" + b + "'   id='tbCw" + b + "' value='"+$("#tbCw").val()+"'/></td>"
                          + "  <td><input  type='text' " + cwhjbzReadOnly + " style='width:90%' name='tbHjh" + b + "'   id='tbHjh" + b + "' value='"+$("#tbHjh").val()+"'/></td>"
                          + " <td> <select id='ddlPzzk" + b + "' name='ddlPzzk" + b + "' " + pzkcReadOnly + " > <option selected='selected'>请选择</option> <option >合格</option> <option>不合格</option> <option >让步</option></select> </td> "
                          + " <td> <select id='ddlRkcz" + b + "' name='ddlRkcz" + b + "' " + pzkcReadOnly + " > <option selected='selected'>请选择</option> <option >入库</option> <option>退货</option> </td> "
                          + "  <td style='display:none'><input  type='text' " + pzkcReadOnly + " style='width:90%' name='tbSm" + b + "'   id='tbSm" + b + "' value='"+$("#tbSm").val()+"'/></td>"
                          + "  <td style='display:none' ><input  type='text'   style='display:none;width:50px;' name='tbRkrq"+ b +"'   id='tbRkrq"+ b +"'  value=''/></td>"
                          + "  <td style='display:none' ><input  type='text'   style='display:none;width:50px;' name='tbJyrq"+ b +"'   id='tbJyrq"+ b +"'  value=''/></td>"
                          + " <td><input id='rkzt"+b+"' name='rkzt"+b+"' type='text' style='width:55%;font-size:9px;' readonly='readonly' value='未入库'/><input type='checkbox' name='ckb'  /></td></tr>";

                $("#tbWlbh").val("");
                $("#tbWlmc").val("");
                $("#tbWlbh").val("");
                $("#tbGG").val("");
                $("#tbPh").val("");
                $("#tbSl").val("");
                $("#tbJe").val("");
                $("#tbDw").val("");
                $("#tbHjh").val("");
                $("#ddlPzzk").val("请选择");
                $("#ddlRkcz").val("请选择");
                $("#tbSm").val("");
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
            //改变ClientHeight的高度 
            var win=window.parent.document.getElementsByName("main")[0];
            win.height=win.height+50;
           
        }
        
        function rkztChange(obj){
          var objname=obj.id;
          var b=-1;
          if(objname.substr(0,4)=="tbCw"){
            b=objname.substr(4,objname.length-4);
          } else if(objname.substr(0,5)=="tbHjh"){
            b=objname.substr(5,objname.length-5);
          } else if(objname.substr(0,7)=="ddlPzzk"){
            b=objname.substr(7,objname.length-7);
          } else if(objname.substr(0,7)=="ddlRkcz"){
            b=objname.substr(7,objname.length-7);
          }
          var cw= document.getElementById("tbCw"+b).value;
          var hjh= document.getElementById("tbHjh"+b).value;
          var ph= document.getElementById("tbPh"+b).value;
          //var pzzk = $("#ddlPzzk"+b).find("option:selected").text();
          //var pzzk= document.getElementById("ddlPzzk"+b).value;
          var rkcz = $("#ddlRkcz"+b).find("option:selected").text();
          // var rkcz= document.getElementById("ddlRkcz"+b).value;
          if(cw!="" && hjh!="" && rkcz=="入库" && ph!="" ){
             document.getElementById("rkzt"+b).value="待入库";
          } else if (cw!="" && hjh!="" && rkcz=="退货"  && ph!="" ) {
             document.getElementById("rkzt"+b).value="待退货";
          } else {
            document.getElementById("rkzt"+b).value="未入库";
          }
          
          //把退货的tbSm置为可见
          if(rkcz=="退货"){
             document.getElementById("tdSm"+b).style.display="";
          } else {
             document.getElementById("tdSm"+b).style.display="none";
          }
          
          //代表仓管员已经填写，填写入库日期
          if(cw!="" && hjh!=""){
            var sysDate=new Date(); 
            document.getElementById('tbRkrq'+b).value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
          } else {
            document.getElementById('tbRkrq'+b).value=""; 
            
          }
          //代表IQC已经填写，填入校验日期
          if(rkcz=="入库"){
            var sysDate=new Date(); 
            document.getElementById('tbJyrq'+b).value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
          } else {
            document.getElementById('tbJyrq'+b).value="";   
          }
          
        }
        
        
        
       function clickTr(currTrIndex){ 
		    var prevTrIndex = $("#prevTrIndex").val(); 
		    if (currTrIndex > -1){ 
			    $("#tr_" + currTrIndex).addClass("hover"); 
		    } 
		    $("#tr_" + prevTrIndex).removeClass("hover"); 
		    $("#prevTrIndex").val(currTrIndex); 
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
    
       
        
   
  
        
	 
    	    
	    
	    
      function getwlxx(){
            $('#wlxx tbody tr').empty();
            var data = "{'wlxx':{'Ckbh':'"+$("#tbDdh").val()+"','Wlbh':'"+ $("#tbWlbh").val() +"','Wlmc':'"+ "" +"','Gg':'"+$("#tbGG").val() +"','Wlpc':'"+ "" +"','Sl':'1','Dw':'pcs','Gys':'"+$("#tbGysdm").val()+"'}}";
            $.ajax({
                type: "POST",
                url: "../GetContent.asmx/GetSldWlxxArrayList",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function(json) {  $(json).each(function() { 
                       /* var trHtml="<tr><th><input type='checkbox' name='wlxx_dx'  /></th>"
                                  +"<td sytle='width:200px;text-align:center'>"+ this.Wlbh
                                  +"</td><td sytle='width:200px'>"+ this.Wlmc 
                                  +"</td><td sytle='width:200px'>"+ this.Gg 
                                  +"</td><td sytle='width:200px'>"+ this.Dw +"</td></tr>";*/
                        var trHtml="<tr><th><input type='checkbox' name='wlxx_dx'  /></th><td>"+ this.Wlbh +"</td><td>"+ this.Wlmc +"</td><td>"+ this.Gg +"</td><td>"+ this.Dw +"</td></tr>";
                      
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
                        $("#tbDw").val(($(this).find("td")[3]).innerHTML); 
                        $("#tbGG").val(($(this).find("td")[2]).innerHTML); 
		                $( "#dialog-form" ).dialog( "close" );
		                document.getElementById("tbPh").focus();
	                })//.dblclick(function(){ //鼠标双击 
		              //   $("#TB_wlbh").val(($(this).find("td")[1]).innerHTML); 
	                  //}); 
	                  
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
                            return false;    
                        }else if (event.keyCode == 40){   
		                    var prevTrIndex = parseInt($("#prevTrIndex").val()); 
		                    if (prevTrIndex == -1 || prevTrIndex == (trSize - 1)){ 
			                    clickTr(0); 
		                    } else if (prevTrIndex < (trSize - 1)) { 
			                    clickTr(prevTrIndex + 1); 
		                    } 
		                    return false; 
                        } 
                    });   
                    
                     $(document).bind('keyup',function(event) {  
                        // aa(event);  
                        if(event.keyCode==13){  
                            var prevTrIndex = parseInt($("#prevTrIndex").val()); 
                            $("#tbWlbh").val(($("#tr_" + prevTrIndex).find("td")[0]).innerHTML);   
                            $("#tbWlmc").val(($("#tr_" + prevTrIndex).find("td")[1]).innerHTML); 
                            $("#tbDw").val(($("#tr_" + prevTrIndex).find("td")[3]).innerHTML); 
                            $("#tbGG").val(($("#tr_" + prevTrIndex).find("td")[2]).innerHTML); 
                        }  
                     });  
                	                  
	                  
                       
	                clickTr(0); 
                    
                    
                },
                error: function(error) {
                    alert("调用出错" + error.responseText);
                }
                
            });
            
            
        }
        
        //多选
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
                        trHtml="<tr>  "
                           +" <td><input  type='text'  style='width:95%' name='tbWlbh"+ w +"'   id='tbWlbh"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[0]).innerHTML +"'/></td> "
                           +" <td><input  type='text'  style='width:95%' name='tbWlmc"+ w +"'   id='tbWlmc"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[1]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='tbGG"+ w +"'   id='tbGG"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[2]).innerHTML +"'/></td>"
                           +" <td><input  type='text'  style='width:95%' name='tbPh"+ w +"'  id='tbPh"+ w +"' value=''/></td>"
                           +" <td><input  type='text'  style='width:95%' name='tbSl"+ w +"'  id='tbSl"+ w +"' value=''/></td>"
                           +" <td><input  type='text'  style='width:95%' name='tbJe"+ w +"'  id='tbJe"+ w +"' value=''/></td>"
                           +" <td><input  type='text'  style='width:95%' name='tbDw"+ w +"'  id='tbDw"+ w +"' value='"+ ($("#tr_" + $(this).val()).find("td")[3]).innerHTML +"'/></td>"
                           + "  <td><input  type='text'  style='width:50px' name='tbCw"+ w +"'   id='tbCw"+ w +"' value=''/></td>"
                           + "  <td><input  type='text'  style='width:50px' name='tbHjh"+ w +"'   id='tbHjh"+ w +"' value=''/></td>"
                           + " <td><select id='ddlPzzk"+ w +"' name='ddlPzzk"+ w +"'  > <option selected='selected'>请选择</option> <option>合格</option> <option>不合格</option> <option>让步</option></select> </td>"
                           + " <td style='height: 28px'><select id='ddlRkcz"+ w +"' name='ddlRkcz"+ w +"'><option selected='selected'>请选择</option><option>入库</option><option>退货</option> </select></td>"
                           + "  <td style='display:none'><input  type='text'  style='width:90%' name='tbSm"+ w +"'   id='tbSm"+ w +"' value=''/></td>"
                           + "  <td style='display:none' ><input  type='text'   style='display:none;width:50px;' name='tbRkrq"+ w +"'   id='tbRkrq"+ w +"'  value=''/></td>"
                           + "  <td style='display:none' ><input  type='text'   style='display:none;width:50px;' name='tbJyrq"+ w +"'   id='tbJyrq"+ w +"'  value=''/></td>" +" <td><input style='width:50%' name='rkzt"+w+"' id='rkzt"+w+"' type='text' value='未入库'><input  type='checkbox' name='ckb'/></td></tr>";
                        $('#wl').val(w);
                        addTr("tab",-1, trHtml);
                    });
                    $("#TB_wlbh").val(""); 
                    $("#TB_wlmc").val(""); 
                    $("#TB_wlpc").val(""); 
                    $("#TB_gys").val(""); 
                    $("#TB_gg").val(""); 
                    $("#TB_sl").val(""); 
                    $("#TB_dw").val("");
                }
                
            }
        }
        
        function clickTr(currTrIndex){ 
		    var prevTrIndex = $("#prevTrIndex").val(); 
		    if (currTrIndex > -1){ 
			    $("#tr_" + currTrIndex).addClass("hover"); 
		    } 
		    $("#tr_" + prevTrIndex).removeClass("hover"); 
		    $("#prevTrIndex").val(currTrIndex); 
	    } 
	    
	    
	    function checkAll(){
	      //如果有订单号，那么订单号必填
	      $('[id^=ddlPzzk]').each(function(){$(this).removeAttr("disabled")});
	      $('[id^=ddlRkcz]').each(function(){$(this).removeAttr("disabled")});
	      $('[id^=tbSm]').each(function(){$(this).removeAttr("disabled")});
	      
	      //获得table行数
	      document.getElementById('bl').value= document.getElementById('tab').rows.length;
	      
	      var result="";
	      var rblDdh=$("input[name='rblDdh']:checked").val();
	      if (rblDdh=="有订单号"){
	        var ddh=document.getElementById('tbDdh').value;
	        if(ddh=="" || ddh == null){
	           alert("请填写订单号");
	           result="fasle";
	           document.getElementById('tbDdh').focus();
	           
	        }
	        //$('[id^=tbDdh]').each(function(){alert('1')});
	      }
	      if(result=="false"){
	        return false;
	      }
	      
	      //1.检查批号 数量是否填写
	      //2.入库状态为退货的，需要填写理由
	      if(document.getElementById("tbWlbh").value!=""){
	          if(document.getElementById("tbSl").value==""){
	            alert('请填写数量');
	            document.getElementById("tbSl").focus();
	            return false;
	          }
	          /*if(document.getElementById("tbPh").value==""){
	            alert('请填写批号');
	            document.getElementById("tbPh").focus();
	            return false;
	          }*/
	          //2.入库状态为退货的，需要填写理由
	          var rkcz = $("#ddlRkcz").find("option:selected").text();
	          if(rkcz=="退货" && document.getElementById("tbSm").value==""){
	            alert('退货需填写说明');
	            document.getElementById("tbSm").focus();
	            return false;
	          }
	      } 
	      
	      //检查批号 数量是否填写
	      for(var i=1;i<=document.getElementById('tab').rows.length;i++){
	        if(document.getElementById("tbWlbh"+i).value!=""){
	          if(document.getElementById("tbSl"+i).value==""){
	            alert('请填写数量');
	            document.getElementById("tbSl"+i).focus();
	            return false;
	          }
	          /*if(document.getElementById("tbPh"+i).value==""){
	            alert('请填写批号');
	            document.getElementById("tbPh"+i).focus();
	            return false;
	          }*/
	          //2.入库状态为退货的，需要填写理由
	          var rkcz = $("#ddlRkcz"+i).find("option:selected").text();
	          if(rkcz=="退货" && document.getElementById("tbSm"+i).value==""){
	            alert('退货需填写说明');
	            document.getElementById("tdSm"+i).style.display="";
	            document.getElementById("tbSm"+i).focus();
	            return false;
	          }
	          
	        }
	        
	      } 
	      
	      
	      
	      
	      
	    
	    }
	    
	    
	    function IQCChange(){
	         if(document.getElementById('ddlIQC').value.length>0){
               var sysDate=new Date(); 
               document.getElementById('tbIQChqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds();
             }
	    }
	    
	     function CgyChange(){
	         if(document.getElementById('ddlCgy').value.length>0){
               var sysDate=new Date(); 
               document.getElementById('tbCgyhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds();
             }
	    }
	    
	  
    </script>

</head>
<body id="bMain">
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
                AsyncPostBackTimeout="600" EnableScriptGlobalization="true" EnableScriptLocalization="true" />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div id="divPage">
                        <div class="layout" style="font-size: 20px; font-weight: bold; text-align: center;
                            color: Black;">
                            收料单
                        </div>
                        <div class="layout">
                            <div style="width: 140px; margin: 0 auto;">
                            </div>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">
                                    <asp:CheckBox ID="cbBh" runat="server" Text="补货" /></span><span class="spanControl"><asp:RadioButtonList
                                        ID="rblDdh" runat="server" RepeatDirection="Horizontal" Width="90%">
                                        <asp:ListItem>有订单号</asp:ListItem>
                                        <asp:ListItem>无订单号</asp:ListItem>
                                    </asp:RadioButtonList><asp:RequiredFieldValidator ID="requiredDdh" runat="server"
                                        ErrorMessage="请选择是否需要订单号" Display="Dynamic" ControlToValidate="rblDdh"></asp:RequiredFieldValidator></span></li><li><span class="spanLabel">订单号</span><span class="spanControl"><asp:TextBox ID="tbDdh"
                                    runat="server" Width="90%" AutoPostBack="True" OnTextChanged="tbDdh_TextChanged"></asp:TextBox><ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2"
                                        runat="server" TargetControlID="tbDdh" ServicePath="~/GetContent.asmx" ServiceMethod="GetCgdList"
                                        MinimumPrefixLength="1" EnableCaching="true" CompletionInterval="200" />
                                </span></li>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">单号</span><span class="spanControl"><asp:TextBox ID="tbBh"
                                    runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                                <li><span class="spanLabel">工厂</span><span class="spanControl"><asp:DropDownList
                                    ID="ddlGc" runat="server" Width="111px">
                                    <asp:ListItem Value="1">新桥工厂</asp:ListItem>
                                    <asp:ListItem Value="2">东洲工厂</asp:ListItem>
                                </asp:DropDownList></span> </li>
                                <div onmouseover="" onmouseout="">
                                </div>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">收料状态</span><span class="spanControl"><asp:TextBox ID="tbSlzt"
                                    runat="server" Width="90%" BackColor="Silver"></asp:TextBox>
                                </span></li>
                                <li><span class="spanLabel">物料类别</span><span class="spanControl"><asp:DropDownList
                                    ID="ddlWllb" runat="server" Width="111px">
                                    <asp:ListItem Value="0">请选择</asp:ListItem>
                                    <asp:ListItem Value="金属材料">金属材料</asp:ListItem>
                                    <asp:ListItem Value="塑胶材料">塑胶材料</asp:ListItem>
                                    <asp:ListItem Value="包装材料">包装材料</asp:ListItem>
                                    <asp:ListItem Value="化工材料">化工材料</asp:ListItem>
                                    <asp:ListItem>消耗</asp:ListItem>
                                    <asp:ListItem>电器</asp:ListItem>
                                    <asp:ListItem>五金</asp:ListItem>
                                    <asp:ListItem>化工原料</asp:ListItem>
                                    <asp:ListItem>化工辅料</asp:ListItem>
                                </asp:DropDownList>
                                    <asp:CompareValidator ID="compareWllb" runat="server" ErrorMessage="请选择物料类别" Operator="NotEqual"
                                        ControlToValidate="ddlWllb" Display="Dynamic" ValueToCompare="0"></asp:CompareValidator>
                                </span></li>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">供应商代码</span><span class="spanControl"><asp:TextBox ID="tbGysdm"
                                    runat="server" Width="90%" OnTextChanged="tbGysdm_TextChanged" AutoPostBack="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="requiredGysdm" runat="server" ErrorMessage="&nbsp;请填写供应商代码"
                                        ControlToValidate="tbGysdm" Display="Dynamic"></asp:RequiredFieldValidator></span>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="tbGysdm"
                                        ServicePath="~/GetContent.asmx" ServiceMethod="GetGysdmList" MinimumPrefixLength="1"
                                        EnableCaching="true" CompletionInterval="200" />
                                    &nbsp; </li>
                                <li><span class="spanLabel">供应商名称</span><span class="spanControl"><asp:TextBox ID="tbGysmc"
                                    runat="server" Width="90%"></asp:TextBox></span></li></ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">收料员</span><span class="spanControl"><asp:TextBox ID="tbSly"
                                    runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span></li><li><span
                                        class="spanLabel">收料日期</span><span class="spanControl"><asp:TextBox ID="tbJbrq" runat="server"
                                            Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">订单类型</span><span class="spanControl"><asp:DropDownList
                                    ID="ddlDdlx" runat="server">
                                    <asp:ListItem>请选择</asp:ListItem>
                                    <asp:ListItem>常规</asp:ListItem>
                                    <asp:ListItem>样品</asp:ListItem>
                                    <asp:ListItem>客供</asp:ListItem>
                                </asp:DropDownList></span></li><li><span class="spanLabel"></span><span class="spanControl">
                                    &nbsp; </span></li>
                            </ul>
                        </div>
                        <div class="layout" style="display: none">
                            <ul>
                                <li><span class="spanLabel">入库日期</span><span class="spanControl"><asp:TextBox ID="tbRkrq"
                                    runat="server" Width="90%"></asp:TextBox><ajaxToolkit:CalendarExtender ID="CalendarExtender2"
                                        runat="server" Format="yyyy-MM-dd" TargetControlID="tbRkrq">
                                    </ajaxToolkit:CalendarExtender>
                                </span></li>
                                <li><span class="spanLabel">检验日期</span><span class="spanControl">
                                    <asp:TextBox ID="tbJyrq" runat="server" Width="90%"></asp:TextBox>
                                    <asp:TextBox ID="tbShdh" runat="server" Width="90%" BackColor="Silver"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd"
                                        TargetControlID="tbJyrq">
                                    </ajaxToolkit:CalendarExtender>
                                </span></li>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">IQC</span><span class="spanControl"><asp:DropDownList
                                    ID="ddlIQC" runat="server" onchange="IQCChange()">
                                </asp:DropDownList>
                                    <asp:TextBox ID="tbIQChqsj" runat="server" Width="45%"></asp:TextBox>
                                </span></li>
                                <li><span class="spanLabel">仓管员</span><span class="spanControl"><asp:DropDownList
                                    ID="ddlCgy" runat="server" onchange="CgyChange()">
                                </asp:DropDownList>
                                    <asp:TextBox ID="tbCgyhqsj" runat="server" Width="45%"></asp:TextBox>
                                </span></li>
                            </ul>
                        </div>
                    </div>
                    <div style="display: none">
                        <asp:HiddenField ID="bl" runat="server" Value="0" />
                        <asp:DropDownList ID="ddlCgyhqzt" runat="server">
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlIQChqzt" runat="server">
                            <asp:ListItem>会签中</asp:ListItem>
                            <asp:ListItem>已会签</asp:ListItem>
                        </asp:DropDownList>
                        <asp:HiddenField ID="wl" runat="server" Value="0" />
                        <asp:HiddenField ID="HF_id" runat="server" />
                        <input id="prevTrIndex" name="prevTrIndex" type="hidden" value="-1" /><asp:TextBox
                            ID="tbLx" runat="server" Style="display: none"></asp:TextBox><asp:TextBox ID="tbGroupNames"
                                runat="server" Style="display: none"></asp:TextBox>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="dialog-form" title="物料信息">
            <table id="wlxx" width="800px" cellspacing="0">
                <thead>
                    <tr>
                        <th style="width: 5%">
                            <input type='checkbox' name='wlxx_qx' value="全选" /></th>
                        <th style="width: 10%">
                            物料编号</th>
                        <th style="width: 10%">
                            物料名称</th>
                        <th style="width: 25%">
                            规格</th>
                        <th style="width: 5%">
                            单位</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div id="divFlqk" runat="server" style="margin-top: 30px; margin-bottom: 20px; font: italic arial,sans-serif;">
            <table id="tab" width="1000" cellspacing="0" align="center">
                <tr>
                    <th style="width: 8%; height: 28px;">
                        订单号</th>
                    <th style="width: 8%; height: 28px;">
                        物料编号</th>
                    <th style="width: 77px; height: 28px;">
                        物料名称</th>
                    <th style="width: 8%; height: 28px;">
                        规格</th>
                    <th style="width: 77px; height: 28px;">
                        批号</th>
                    <th style="width: 8%; height: 28px;">
                        数量</th>
                    <th style="width: 8%; height: 28px;">
                        金额</th>
                    <th style="width: 8%; height: 28px;">
                        单位</th>
                    <th style="width: 8%; height: 28px;">
                        仓位</th>
                    <th style="width: 8%; height: 28px;">
                        货架号</th>
                    <th style="width: 8%; height: 28px;">
                        品质状况</th>
                    <th style="width: 8%; height: 28px;">
                        入库操作</th>
                    <th style="width: 8%; height: 28px;">
                        说明</th>
                    <th style="width: 4%; height: 28px;">
                        <asp:Button runat="server" ID="bl_delete" OnClientClick="delTr2();return false;"
                            Text="删除" Style="width: 58px" /></th>
                </tr>
                <tr>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbDdh11" runat="server" Width="95%" TabIndex="28"></asp:TextBox>
                    </td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbWlbh" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="height: 28px; width: 77px;">
                        <asp:TextBox ID="tbWlmc" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbGG" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="height: 28px; width: 77px;">
                        <asp:TextBox ID="tbPh" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbSl" runat="server" Width="90%"></asp:TextBox></td>
                     <td style="height: 28px">
                        <asp:TextBox ID="tbJe" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbDw" runat="server" Width="90%"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbCw" runat="server" Width="90%" onchange="rkztChange()"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbHjh" runat="server" Width="90%" onchange="rkztChange()"></asp:TextBox></td>
                    <td style="height: 28px">
                        <select id="ddlPzzk" onchange="rkztChange()">
                            <option selected="selected">请选择</option>
                            <option>合格</option>
                            <option>不合格</option>
                            <option>让步</option>
                        </select>
                    </td>
                    <td style="height: 28px">
                        <select id="ddlRkcz" onchange="rkztChange()">
                            <option selected="selected">请选择</option>
                            <option>入库</option>
                            <option>退货</option>
                        </select>
                    </td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbSm" runat="server" TabIndex="32" Width="95%"></asp:TextBox>
                    </td>
                    <td style="height: 28px">
                        <asp:Button runat="server" ID="bl_add" OnClientClick="addTr2('tab', -1);return false;"
                            Text="添加" Style="width: 58px" TabIndex="33" />
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; width: 760px; margin: 0 auto;">
            <br />
            <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline-block; background-color: #4B97E3;
                width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                text-decoration: none; margin: 0 auto;" OnClick="btnTj_Click" OnClientClick="return checkAll();">提交</asp:LinkButton>
            <asp:LinkButton ID="LinkButton1" runat="server" Style="display: inline-block; background-color: #4B97E3;
                width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                text-decoration: none; margin: 0 auto; text-align: center" CausesValidation="false"
                PostBackUrl="~/cgxt/sldList.aspx">返回列表</asp:LinkButton>
        </div>
    </form>
</body>
</html>
