<%@ Page Language="C#" AutoEventWireup="true" CodeFile="thdEdit.aspx.cs" Inherits="thdEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>退货单</title>
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
    .hover{
        cursor:pointer;
        background-color:#bcd4ec;  
       
    }   /*这里是鼠标经过时的颜色*/ 
    
     </style>

    <script type="text/javascript">
        function getwlxx() {
            var data = "{'wlxx':{'Ckbh':'','Wlbh':'" + $("#tbWlbh").val() + "','Wlmc':'','Gg':'ddhg','Wlpc':'" + "" + "','Sl':'1','Dw':'pcs','Sx':'ycl','Gys':'','Ckbh':'0001'}}";
            $.ajax({
                type: "POST",
                url: "../GetContent.asmx/GetPCArrayList",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function (json) {
                    $(json).each(function () {
                        var trHtml = "<tr><td sytle='width:100px;text-align:center'>" + this.Wlbh + "</td><td sytle='width:150px'>" + this.Wlmc 
                                    + "</td><td sytle='width:100px'>" + this.Gg + "</td><td sytle='width:100px'>" + this.Wlpc + "</td><td sytle='width:100px'>"
                                    + this.Sl+ "</td><td sytle='width:100px'>" + this.Gysmc+"</td><td sytle='display:none'>" + this.Dw
                                    +"</td><td sytle='display:none'>" + this.Cw+"</td><td sytle='display:none'>" + this.Hjh +"</td></tr>";

                        var $tr = $("#wlxx tbody");
                      
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
                        $("#tbGG").val(($(this).find("td")[2]).innerHTML);
                        $("#tbPh").val(($(this).find("td")[3]).innerHTML);
                        $("#tbSl").val(($(this).find("td")[4]).innerHTML);
                        $("#tbGysmc").val(($(this).find("td")[5]).innerHTML);
                        $("#tbDw").val(($(this).find("td")[6]).innerHTML);
                        $("#tbCw").val(($(this).find("td")[7]).innerHTML);
                        $("#tbHjh").val(($(this).find("td")[8]).innerHTML);
                       // document.getElementById('lblWlmc').innerHTML=($(this).find("td")[1]).innerHTML;
                       // document.getElementById('lblGG').innerHTML=($(this).find("td")[2]).innerHTML;
                        $("#dialog-form").dialog("close");
                    }); 


                },
                error: function (error) {
                    alert("调用出错" + error.responseText);
                }

            });

        }

        function pageReload(){
            $("#tbWlbh").keypress(function (e) {
                if (e.which == 32) {

                    getwlxx();
                    $("#dialog-form").dialog("open");
                    $("#wlxx").show();
                }
            });
            
            allFields = $( [] ),
		    tips = $( ".validateTips" );
		    
            $("#dialog-form").dialog({
                autoOpen: false,
                height: 400,
                width: 860,
                modal: true,
                buttons: {
                   /* "保存": function () {
                        var bValid = true;
                        if ($("#wlxx").is(":visible") == true) {
                            duoxuan("wlxx_dx");
                        }
                        if ($("#blxx").is(":visible") == true) {
                            duoxuan("blxx_dx");
                        }
                        $(this).dialog("close");
                    },*/
                    取消: function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                    $('#wlxx tbody tr').remove();   //关闭窗口的时候清空记录
                    allFields.val("").removeClass("ui-state-error");

                }
            });
        
        }
        $(function () {
          pageReload();
        });
    
   

       
       
    
    </script>

    <script type="text/javascript">
       //采购会签状态变更
       function cgclChange(){
          if(document.getElementById('ddlCgcl').value.length!='请选择'){
              var sysDate=new Date(); 
              document.getElementById('tbCghqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
              document.getElementById('ddlCghqzt').value="已会签";
              document.getElementById('tbCg').value=document.getElementById('tbUserName').value;
              if("-"==document.getElementById('ddlCkhqzt').value){
                   document.getElementById('ddlCkhqzt').value="会签中";
                   document.getElementById('tbLchqzt').value="仓库会签中";
              }    
          }
       }
       
       //仓库会签状态变更
       function ckclChange(){
          
          if(document.getElementById('ddlCkcl').value!='请选择'){
              var sysDate=new Date(); 
              document.getElementById('tbCk').value=document.getElementById('tbUserName').value;
              document.getElementById('tbCkhqsj').value=sysDate.getFullYear()+"-"+(sysDate.getMonth()+1)+"-"+sysDate.getDate()+" "+sysDate.getHours()+":"+sysDate.getMinutes()+":"+ sysDate.getSeconds(); 
              document.getElementById('ddlCkhqzt').value="已会签";
              document.getElementById('tbLchqzt').value="已完成";
          }
       }      
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="divPage">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
                AsyncPostBackTimeout="600" />
            <div class="layout" style="font-weight: bold; font-size: 25px; text-align: center;
                color: Black;">
                <asp:Label ID="lblTile" runat="server" Text="IQC不合格处置单"></asp:Label>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">处置方式</span><span class="spanControl"><asp:DropDownList
                        ID="ddlCzfs" runat="server">
                        <asp:ListItem>退货</asp:ListItem>
                        <asp:ListItem>特采</asp:ListItem>
                    </asp:DropDownList>&nbsp; </span></li>
                    <li><span class="spanLabel" id="spLly" runat="server">流程状态</span><span class="spanControl"><asp:TextBox
                        ID="tbLchqzt" runat="server"></asp:TextBox></span></li></ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">单号</span><span class="spanControl">
                        <asp:TextBox ID="tbBh" runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">订单号</span><span class="spanControl"><asp:TextBox ID="tbDdh"
                        runat="server" Width="90%"></asp:TextBox></span></li></ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">工厂</span><span class="spanControl"><asp:DropDownList
                        ID="ddlGc" runat="server">
                        <asp:ListItem Value="1">新桥工厂</asp:ListItem>
                        <asp:ListItem Value="2">东洲工厂</asp:ListItem>
                    </asp:DropDownList></span> </li>
                    <li><span class="spanLabel">日期</span><span class="spanControl"><asp:TextBox ID="tbJbrq"
                        runat="server" Width="90%"></asp:TextBox></span></li></ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">物料编号</span><span class="spanControl"><asp:TextBox ID="tbWlbh"
                        runat="server" Width="90%"></asp:TextBox>
                    </span></li>
                    <li><span class="spanLabel">物料名称</span><span class="spanControl"><asp:TextBox ID="tbWlmc"
                        runat="server" Width="90%"></asp:TextBox></span></li></ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 760px;"><span class="spanLabel">规格</span><span class="spanControl"
                        style="width: 600px;"><asp:TextBox ID="tbGG" runat="server" Width="95%"></asp:TextBox>&nbsp;
                    </span></li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">供应商名称</span><span class="spanControl"><asp:TextBox ID="tbGysmc"
                        runat="server" Width="90%"></asp:TextBox></span></li><li><span class="spanLabel">批号</span><span
                            class="spanControl"><asp:TextBox ID="tbPh" runat="server" Width="90%"></asp:TextBox></span></li></ul>
            </div>
            <div class="layout">
                <ul>
                    <li><span class="spanLabel">数量</span><span class="spanControl"><asp:TextBox ID="tbSl"
                        runat="server" Width="90%"></asp:TextBox></span></li><li><span class="spanLabel">单位</span><span
                            class="spanControl"><asp:TextBox ID="tbDw" runat="server" Width="90%"></asp:TextBox></span></li></ul>
            </div>
            <div class="layout">
                <ul>
                    <li id="liXqsl" runat="server"><span class="spanLabel">仓位</span><span class="spanControl"><asp:TextBox
                        ID="tbCw" runat="server" Width="90%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel" id="spFlsl" runat="server">货架号</span><span class="spanControl"><asp:TextBox
                        ID="tbHjh" runat="server" Width="90%"></asp:TextBox></span> </li>
                </ul>
            </div>
            <div class="layout">
                <ul>
                    <li style="width: 760px;"><span class="spanLabel">不合格说明</span><span class="spanControl"
                        style="width: 600px;">
                        <asp:TextBox ID="tbBhgsm" runat="server" Width="95%" Rows="3" TextMode="MultiLine"></asp:TextBox></span></li></ul>
            </div>
            <div class="layout" style="margin-top: 20px;">
                <ul>
                    <li><span class="spanLabel">采购处理</span><span class="spanControl"><asp:DropDownList
                        ID="ddlCgcl" runat="server" onchange="cgclChange()">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>换补货</asp:ListItem>
                        <asp:ListItem>退货扣款</asp:ListItem>
                    </asp:DropDownList><asp:TextBox ID="tbCg" runat="server" Width="28%"></asp:TextBox>
                        <asp:TextBox ID="tbCghqsj" runat="server" Width="28%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel">退货日期</span><span class="spanControl"><asp:TextBox ID="tbThrq"
                        runat="server" Width="90%"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd"
                            TargetControlID="tbThrq">
                        </ajaxToolkit:CalendarExtender>
                    </span></li>
                </ul>
            </div>
            <div class="layout" style="margin-top: 5px;">
                <ul>
                    <li><span class="spanLabel">仓库</span><span class="spanControl"><asp:DropDownList
                        ID="ddlCkcl" runat="server" onchange="ckclChange()">
                        <asp:ListItem>请选择</asp:ListItem>
                        <asp:ListItem>已出库</asp:ListItem>
                        <asp:ListItem>已报废</asp:ListItem>
                    </asp:DropDownList>
                        <asp:TextBox ID="tbCk" runat="server" Width="30%"></asp:TextBox>
                        <asp:TextBox ID="tbCkhqsj" runat="server" Width="30%"></asp:TextBox></span> </li>
                    <li><span class="spanLabel" runat="server">出库日期</span><span class="spanControl"><asp:TextBox
                        ID="tbCkrq" runat="server" Width="90%"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd"
                            TargetControlID="tbCkrq">
                        </ajaxToolkit:CalendarExtender>
                    </span></li>
                </ul>
            </div>
            <div style="text-align: center; margin-top: 10px;">
                <asp:LinkButton ID="lbtnOK" runat="server" Style="display: inline-block; background-color: #4B97E3;
                    width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                    text-decoration: none; margin: 0 auto; text-align: center" OnClick="btnTj_Click"
                    OnClientClick="return checkAll()">提交</asp:LinkButton>
                <asp:LinkButton ID="lblReturn" runat="server" Style="display: inline-block; background-color: #4B97E3;
                    width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                    text-decoration: none; margin: 0 auto; text-align: center" CausesValidation="false">返回列表</asp:LinkButton>
            </div>
            <div style="">
                <asp:TextBox ID="tbLx" runat="server" Style="display: none"></asp:TextBox>
                <asp:TextBox ID="tbGroupNames" runat="server" Style="display: none"></asp:TextBox>
                <input id="tbUserName" type="text" value="<%=Session["username"] %>" />
                采购状态
                <asp:DropDownList ID="ddlCghqzt" runat="server">
                    <asp:ListItem>会签中</asp:ListItem>
                    <asp:ListItem>已会签</asp:ListItem>
                </asp:DropDownList>仓库状态
                <asp:DropDownList ID="ddlCkhqzt" runat="server">
                    <asp:ListItem>-</asp:ListItem>
                    <asp:ListItem>会签中</asp:ListItem>
                    <asp:ListItem>已会签</asp:ListItem>
                </asp:DropDownList><asp:TextBox ID="tbIQC" runat="server" Width="30%"></asp:TextBox><asp:TextBox
                    ID="tbIQChqsj" runat="server" Width="30%"></asp:TextBox></div>
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
                            规格</th>
                        <th>
                            批次</th>
                        <th>
                            数量</th>
                        <th>
                            供应商</th>
                        <th>
                            单位</th>
                        <th>
                            仓位</th>
                        <th>
                            货架号</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
