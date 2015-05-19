<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wlReplaceEdit.aspx.cs" Inherits="wlReplaceEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>物料替代</title>
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
    
    <script type="text/javascript" src="../jquery-ui/ui/jquery.ui.datepicker.js"></script>
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
//jquery日历控件调整中文
/*jQuery(function($){
        $.datepicker.regional['zh-CN'] = {
                closeText: '关闭',
                prevText: '<上月',
                nextText: '下月>',
                currentText: '今天',
                monthNames: ['一月','二月','三月','四月','五月','六月',
                '七月','八月','九月','十月','十一月','十二月'],
                monthNamesShort: ['一','二','三','四','五','六',
                '七','八','九','十','十一','十二'],
                dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
                dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
                dayNamesMin: ['日','一','二','三','四','五','六'],
                weekHeader: '周',
                dateFormat: 'yy-mm-dd',
                firstDay: 1,
                isRTL: false,
                showMonthAfterYear: true,
                yearSuffix: '年'};
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
});*/
//JQuery日历调用
$(document).ready(function() {
    $("#tbQsrq").datepicker();
  });
$(document).ready(function() {
    $("#tbZzrq").datepicker();
  });

        function addTr(tab, row, trHtml) {
            //获取table最后一行 $("#tab tr:last")
            //获取table第一行 $("#tab tr").eq(0)
            //获取table倒数第二行 $("#tab tr").eq(-2)
            var $tr = $("#" + tab + " tr").eq(row - 1);
            if ($tr.size() == 0) {
                alert("指定的table id或行数不存在！");
                return;
            }
            $tr.after(trHtml);
        }
        function addTr2(tab, row) {

            var trHtml = "";

            if (tab == "tab") {
                var b = parseInt($('#bl').val());
                b = b + 1;
                $('#bl').val(b);
                trHtml = "<tr><td><input  type='text'  style='width:95%' name='tbTdbh" + b + "'   id='tbTdbh" + b + "'  value='" + $('#tbTdbh').val() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='tbGysdm" + b + "'   id='tbGysdm" + b + "'  value='" + $('#tbGysdm').val() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='tbGysmc" + b + "'   id='tbGysmc" + b + "'  value='" + $('#tbGysmc').val() + "'/></td>"
                        + "  <td><input  type='text' style='width:95%' name='tbWlbh" + b + "'   id='tbWlbh" + b + "'  value='" + $('#tbWlbh').val() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='tbWlmc" + b + "'   id='tbWlmc" + b + "' value='" + $('#tbWlmc').val() + "' /></td>"
                        + "  <td><input  type='text'  style='width:95%' name='tbGG" + b + "'   id='tbGG" + b + "' value='" + $('#tbGG').val() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='tbQsrq" + b + "'   id='tbQsrq" + b + "' value='" + $('#tbQsrq').val() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='tbZzrq" + b + "'   id='tbZzrq" + b + "' value='" + $('#tbZzrq').val() + "'/></td>"
                        + "  <td><input type='checkbox' name='ckb'/></td></tr>";

                $("#tbTdbh").val("");
                $("#tbGysdm").val("");
                $("#tbGysmc").val("");
                $("#tbWlbh").val("");
                $("#tbWlmc").val("");
                $("#tbGG").val("");
                $("#tbQsrq").val("");
                $("#tbZzrq").val("");
            } else {
                var w = parseInt($('#wl').val());
                w = w + 1;
                $('#wl').val(w);
                var sl = $("#TB_sl").val();
                document.getElementById("tbWlbh").focus();


                trHtml = "<tr><td> <select   style='width:95%' name='DDL_sx" + w + "' ID='DDL_sx" + w + "'  ><option></option><option value='返料'>返料</option><option value='材料报废'>材料报废</option><option value='混批转入'>混批转入</option> </select> </td>  "
                       + " <td><input  type='text'  style='width:95%' name='tbWlbh" + w + "'   id='tbWlbh" + w + "' value='" + $('#tbWlbh').val() + "'/></td> "
                       + " <td><input  type='text'  style='width:95%' name='TB_wlmc" + w + "'   id='TB_wlmc" + w + "' value='" + $('#TB_wlmc').val() + "'/></td>"
                       + " <td><input  type='text'  style='width:95%' name='TB_wlpc" + w + "'   id='TB_wlpc" + w + "' value='" + $('#TB_wlpc').val() + "'/></td>"
                       + " <td><input  type='text'  style='width:95%' name='TB_gys" + w + "'  id='TB_gys" + w + "' value='" + $('#TB_gys').val() + "'/></td>"
                       + " <td><input  type='text'  style='width:95%' name='TB_gg" + w + "'  id='TB_gg" + w + "' value='" + $('#TB_gg').val() + "'/></td>"
                       + " <td><input  type='text'  style='width:95%' onchange='bfjs()'  name='TB_sl" + w + "'  id='TB_sl" + w + "' value='" + $('#TB_sl').val() + "'/></td>"
                       + " <td><input  type='text'  style='width:95%' name='TB_dw" + w + "'  id='TB_dw" + w + "' value='" + $('#TB_dw').val() + "'/></td>"
                       + " <td><input  type='checkbox' name='ckb'/></td></tr>";
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

        function getwlxx() {
            var tdfs = $("#ddlTdfs").find("option:selected").text();
            var data = "{'wlxx':{'Ckbh':'','Wlbh':'" + $("#tbWlbh").val() + "','Wlmc':'" + $("#tbMc").val() + "','Gg':'ddhg','Wlpc':'" + "" + "','Sl':'1','Dw':'pcs','Gys':'" + $("#tbGysmc").val() + "'}}";
            $.ajax({
                type: "POST",
                url: "../GetContent.asmx/GetGysWlxxArrayList",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function (json) {
                    $(json).each(function () {
                       var wlbh= (tdfs=="物料对应替代")?this.Wlbh:"";
                       var wlmc= (tdfs=="物料对应替代")?this.Wlmc:"";
                       var gg=   (tdfs=="物料对应替代")?this.Gg:"";
                        //  var trHtml="<tr><th><input type='checkbox' name='wlxx_dx'  /></th><td>"+ this.Ckbh +"</td><td>"+ this.Wlbh +"</td><td>"+ this.Wlmc +"</td><td>"+ this.Wlpc +"</td><td>"+ this.Gys +"</td><td>"+ this.Gg +"</td><td>"+ this.Sl +"</td><td>"+ this.Dw +"</td></tr>";
                        var trHtml = "<tr><td sytle='width:100px;text-align:center'>" + wlbh + "</td><td sytle='width:150px'>" + wlmc + "</td>"
                                  + "</td><td sytle='width:100px'>" + this.Gys + "</td><td sytle='width:100px'>" + this.Gysmc + "</td><td sytle='width:100px'>" + gg +"</td></tr>";

                        var $tr = $("#wlxx tbody");
                        //                        if($tr.size()==0){
                        //                            alert("指定的table id或行数不存在！");
                        //                            return;
                        //                        }
                        $tr.append(trHtml);

                    });
                    trSize = $("#wlxx tbody tr").size(); //datagrid中tr的数量 
                    $("#wlxx tbody tr").mouseover(function () {//鼠标滑过 
                        $(this).addClass("hover");
                    }).mouseout(function () { //鼠标滑出 
                        $(this).removeClass("hover");
                    }).each(function (i) { //初始化 id 和 index 属性 
                        $(this).attr("id", "tr_" + i).attr("index", i);
                        $(this).find("input").each(function () {
                            $(this).val(i);
                        });
                    }).dblclick(function () { //鼠标单击 
                        //clickTr($(this).attr("index")); 
                        $("#tbWlbh").val(($(this).find("td")[0]).innerHTML);
                        $("#tbWlmc").val(($(this).find("td")[1]).innerHTML);
                        $("#tbGysdm").val(($(this).find("td")[2]).innerHTML);
                        $("#tbGysmc").val(($(this).find("td")[3]).innerHTML);
                        $("#tbGG").val(($(this).find("td")[4]).innerHTML);
                        $("#dialog-form").dialog("close");
                    }); //.dblclick(function(){ //鼠标双击 
                    //   $("#tbWlbh").val(($(this).find("td")[1]).innerHTML); 
                    //}); 



                    if (trSize > 0) //如果trSize大于零代表有数据 点亮从零行开始
                    {
                        clickTr(0);
                    }
                },
                error: function (error) {
                    alert("调用出错" + error.responseText);
                }

            });

        }


        function clickTr(currTrIndex) {
            var prevTrIndex = $("#prevTrIndex").val();
            if (currTrIndex > -1) {
                $("#tr_" + currTrIndex).addClass("hover");
            }f
            $("#tr_" + prevTrIndex).removeClass("hover");
            $("#prevTrIndex").val(currTrIndex);
        }





        function delTr(ckb) {
            //获取选中的复选框，然后循环遍历删除
            var ckbs = $("input[name=" + ckb + "]:checked");
            if (ckbs.size() == 0) {
                alert("要删除指定行，需选中要删除的行！");
                return;
            }
            ckbs.each(function () {
                var data = "";
                var del_ID = $(this).val();
                if (del_ID.substr(0, 2) == "bl" || (del_ID.substr(0, 2) == "wl")) {
                    if (del_ID.substr(0, 2) == "bl") {
                        data = "{'sgrb':{'Id':'" + $("#HF_id").val() + "','Blid':'" + $("#" + del_ID).val() + "','Wlid':'0'}}";
                    } else if (del_ID.substr(0, 2) == "wl") {
                        data = "{'sgrb':{'Id':'" + $("#HF_id").val() + "','Blid':'0','Wlid':'" + $("#" + del_ID).val() + "'}}";
                    }
                    $.ajax({
                        type: "POST",
                        url: "../GetContent.asmx/Del_sgrb_bl_wl",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        data: data,
                        success: function (data) {
                            alert(data);
                        },
                        error: function (error) {
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

        function allCheck(allCkb, items) {
            $("#" + allCkb).click(function () {
                $('[name=' + items + ']:checkbox').attr("checked", this.checked);
            });
        }

        ////////添加一行、删除一行测试方法///////
        $(function () {
            //全选
            allCheck("allCkb", "ckb");
        });

        function delTr2() {
            delTr('ckb');
        }



        //计算发料数量 
        function calZflsl() {
            var sum = 0;
            $('[id^=tbFlsl]').each(function () { sum = sum + $(this).val() * 1 });
            document.getElementById("tbZFlsl").value = sum;
        }

        $(function () {
            $(document).keydown(function (event) {
                //判断当event.keyCode 为37时（即左方面键），执行函数to_left();  
                //判断当event.keyCode 为39时（即右方面键），执行函数to_right();  
                if (event.keyCode == 38) {
                    var prevTrIndex = parseInt($("#prevTrIndex").val());
                    if (prevTrIndex == -1 || prevTrIndex == 0) {
                        clickTr(trSize - 1);
                    } else if (prevTrIndex > 0) {
                        clickTr(prevTrIndex - 1);
                    }
                    //return false;    
                } else if (event.keyCode == 40) {
                    var prevTrIndex = parseInt($("#prevTrIndex").val());
                    if (prevTrIndex == -1 || prevTrIndex == (trSize - 1)) {
                        clickTr(0);
                    } else if (prevTrIndex < (trSize - 1)) {
                        clickTr(prevTrIndex + 1);
                    }
                    //return false; 
                }
            });

            $(document).keypress(function (e) {
                // 回车键事件  
                if (e.which == 13) {

                    var prevTrIndex = parseInt($("#prevTrIndex").val());
                    if ($("#wlxx").is(":visible")) {
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
                    if ($("#blxx").is(":visible")) {
                        $("#TB_blmc").val(($("#tr_" + prevTrIndex).find("td")[0]).innerHTML);
                        $("#TB_bldm").val(($("#tr_" + prevTrIndex).find("td")[1]).innerHTML);
                        $("#TB_bllb").val(($("#tr_" + prevTrIndex).find("td")[2]).innerHTML);
                        $("#dialog-form").dialog("close");
                        $("#TB_blsl").focus();
                        return false;
                    }
                }

            });

            $("#tbWlbh").keypress(function (e) {
                if (e.which == 32) {

                    getwlxx();
                    $("#dialog-form").dialog("open");
                    $("#wlxx").show();
                    $("#ckxx").hide();
                }
            });
            
            $("#tbGysmc").keypress(function (e) {
                if (e.which == 32) {

                    getwlxx();
                    $("#dialog-form").dialog("open");
                    $("#wlxx").show();
                    $("#ckxx").hide();
                }
            });

            $("#tbPh").keypress(function (e) {
                if (e.which == 32) {

                    getWlxx_PH();
                    $("#dialog-form").dialog("open");
                    $("#wlxx").hide();
                    $("#ckxx").show();
                }
            });


            $("#tbCj").blur(function (e) {
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
                if ($('#tbCj').val().length > 0) {
                    var index = $('#tbCj').val().indexOf('_');
                    if (index >= 0) {
                        var cjdm = $('#tbCj').val().substring(0, index);
                        $('#tbCjdm').val(cjdm);
                    } else {
                        alert('未获取到车间号，请填写车间');
                    }
                }
            });


            allFields = $([]),
		tips = $(".validateTips");

            $("#dialog-form").dialog({
                autoOpen: false,
                height: 400,
                width: 860,
                modal: true,
                buttons: {
                    "保存": function () {
                        var bValid = true;
                        if ($("#wlxx").is(":visible") == true) {
                            duoxuan("wlxx_dx");
                        }
                        if ($("#blxx").is(":visible") == true) {
                            duoxuan("blxx_dx");
                        }
                        $(this).dialog("close");
                    },
                    取消: function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                    $('#wlxx tbody tr').remove();   //关闭窗口的时候清空记录
                    $('#ckxx tbody tr').remove();   //关闭窗口的时候清空记录
                    allFields.val("").removeClass("ui-state-error");

                }
            });

            $("#tbWlbh")
			.dblclick(function () {
			    $("#wlxx").show();
			    $("#ckxx").hide();
			    getwlxx();
			    $("#dialog-form").dialog("open");

			});





            $("#TB_bldm")
		    .click(function () {
		        getblxx();
		        $("#dialog-form").dialog("open");
		        $("#wlxx").hide();
		        $("#blxx").show();
		    });

        });


        //	    });



        $("#prevTrIndex").val("-1"); //默认-1 
        var trSize = $("#wlxx tbody  tr").size(); //datagrid中tr的数量 
        //投产计划参照
        function xhrl(xh_rl) {
            if (xh_rl != "") {
                $("#TB_xh").val(xh_rl.split('|')[0]);
                $("#TB_rl").val(xh_rl.split('|')[1]);

            }
        }



       function checkAll() {
         var result="";
          $('[id^=tbTdbh]').each(function () {
                    var i = $(this).attr("id");
                    var qsrq = "";
                    var zzrq = "";
                    i = i.substring(6); //获取i
                    if (i == "h") {
                        qsrq = document.getElementById("tbQsrq").value;
                        zzrq = document.getElementById("tbZzrq").value;
                    } else {
                        qsrq = document.getElementById("tbQsrq" + i).value;
                        zzrq = document.getElementById("tbZzrq" + i).value;
                    }
                    if ( $(this).val()!= "" && (qsrq == "" || zzrq == "")) {
                        alert('请填写起始日期和结束日期');
                        result = "false";
                    }
           });
           if (result == "false") {
                return false;
            }
          }

       
</script>

<body>
    <form id="form1" runat="server">

        <div id="divPage">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
                AsyncPostBackTimeout="600" />
            <div class="layout" style="font-weight:bold; font-size:25px; text-align:center; color:Black;">
                <asp:Label ID="lblTile" runat="server" Text="物料替代"></asp:Label>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">编号</span><span class="spanControl"><asp:TextBox ID="tbBh"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                    <li><span class="spanLabel" runat="server">替代方式</span><span class="spanControl"><asp:DropDownList
                        ID="ddlTdfs" runat="server">
                        <asp:ListItem>物料对应替代</asp:ListItem>
                        <asp:ListItem>供应商系列替代</asp:ListItem>
                    </asp:DropDownList></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">物料名称</span><span class="spanControl"><asp:TextBox ID="tbMc"
                        runat="server" Width="90%"></asp:TextBox><br />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="200"
                            EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetWlmcList" ServicePath="~/GetContent.asmx"
                            TargetControlID="tbMc">
                        </ajaxToolkit:AutoCompleteExtender>
                        <asp:CustomValidator ID="CustomValidator1"  Display="Dynamic" ControlToValidate="tbMc" runat="server" ErrorMessage="已经存在相同的物料名称和替代方式" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                        </span></li><li><span class="spanLabel">日期</span><span class="spanControl"><asp:TextBox ID="tbJbrq"
                        runat="server" Width="90%" BackColor="Silver"></asp:TextBox></span> </li>
                </ul>
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
                    <td style="height: 28px"><select id="ddlKcfs">
                        <option selected="selected">请选择</option>
                        <option>可用</option>
                        <option>退货</option>
                        <option>呆滞</option>
                    </select>
                    </td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbCw" runat="server" TabIndex="32" Width="95%"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbZzrq" runat="server" TabIndex="32" Width="95%"></asp:TextBox></td>
                    <td style="height: 28px">
                        <asp:TextBox ID="tbQsrq" runat="server" TabIndex="32" Width="95%"></asp:TextBox>
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
                        <th style="height: 19px">
                            物料编号</th>
                        <th style="height: 19px">
                            物料名称</th>
                        <th style="height: 19px">
                            供应商代码</th>
                        <th style="height: 19px">
                            供应商名称</th>
                        <th style="height: 19px">
                            规格</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            
           
        </div>
        <asp:HiddenField ID="bl" runat="server" Value="0" />
        <div style="text-align: center; margin-top: 10px; margin-bottom:20px">
            <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline-block; background-color: #4B97E3;
                width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                text-decoration: none; margin: 0 auto; text-align: center" OnClick="btnTj_Click" OnClientClick="return checkAll()">提交</asp:LinkButton>
            <asp:LinkButton ID="lblReturn" runat="server" Style="display: inline-block; background-color: #4B97E3;
                width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                text-decoration: none; margin: 0 auto; text-align: center" PostBackUrl="~/cgxt/wlReplaceList.aspx" >返回列表</asp:LinkButton>
                
        </div>
        <div style="text-align:center;  border:1px solid; width:600px; margin:0 auto;"> 说明： 
                <br />
                1、物料对应替代：指单个物料明确规格的替代 供应商系列替代：指2个供应商的相同物料的对应规格替代 
                <br />
                2、替代编号为“0”时，和其他所有替代编号涉及的物料做替代 替代编号相同的物料为互相替代<br />
                3、终止日期小于当前日期即终止替代关系</div>
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
