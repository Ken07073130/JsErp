<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cgdEdit.aspx.cs" Inherits="cgdEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>采购单</title>
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
        //转变行颜色,js触发tbWlbh的值 tbwlbh值改变从而触发后台tbWlbh_TextChanged
        function changeRowColor(aa) {
            document.getElementById('tbWlbh').value = aa;
            obj1 = document.getElementById('tbWlbh');
            if (obj1.fireEvent) {
                obj1.fireEvent('onchange');
            }
            else {
                obj1.onchange();
            }

        }
        function getwlxx() {
            var data = "{'wlxx':{'Ckbh':'','Wlbh':'" + $("#tblyWlbh").val() + "','Wlmc':'','Gg':'ddhg','Wlpc':'" + "" + "','Sl':'1','Dw':'pcs','Sx':'ycl','Gys':'" + $("#tbGysdm").val() + "'}}";
            $.ajax({
                type: "POST",
                url: "../GetContent.asmx/GetGysWlxxArrayList",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function (json) {
                    $(json).each(function () {
                        var trHtml = "<tr><td sytle='width:100px;text-align:center'>" + this.Wlbh + "</td><td sytle='width:150px'>" + this.Wlmc + 
                                   "</td><td sytle='width:100px'>" + this.Gg + "</td></tr>";

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
                        $("#tblyWlbh").val(($(this).find("td")[0]).innerHTML);
                        document.getElementById('lblWlmc').innerHTML=($(this).find("td")[1]).innerHTML;
                        document.getElementById('lblGG').innerHTML=($(this).find("td")[2]).innerHTML;
                        $("#dialog-form").dialog("close");
                        document.getElementById("tblyWlbh").focus();
                    }); 


                },
                error: function (error) {
                    alert("调用出错" + error.responseText);
                }

            });

        }

        function pageReload(){
            $("#tblyWlbh").keypress(function (e) {
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
    
        //计算价格 数量ID,单价ID,金额lblID,金额textboxID
        function callJg(slID,djID,jeID,jetbID){
          var sl=parseFloat(document.getElementById(slID).value);
          var dj=parseFloat(document.getElementById(djID).value);
          document.getElementById(jeID).innerHTML=(sl*dj).toFixed(2);
          document.getElementById(jetbID).value=(sl*dj).toFixed(2);
          callJe();
          
        }
        
        //计算总金额 所有以tbJe结尾的控件的合
        function callJe(){
            var sum=0;
             $('[id$=tbJe]').each(function(){sum=sum+$(this).val()*1});
             document.getElementById("tbJehj").value=sum;
        }
        
        
        function confirmOperate(mess){
          if(confirm(mess)){
             return true;
          } else {
             return false;
          }
        }
   

       
       
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
                AsyncPostBackTimeout="600" EnableScriptGlobalization="true" EnableScriptLocalization="true" />

            <script type="text/javascript" language="javascript">
                Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler); 
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler); 
                function BeginRequestHandler(sender, args) 
                { 
                    var elem = args.get_postBackElement(); 
                    pageReload();
                    getwlxx();
                } 

                function EndRequestHandler(sender, args) 
                { 
                    pageReload();
                    getwlxx();
                } 

                function getwlxx() {
                    var data = "{'wlxx':{'Ckbh':'','Wlbh':'" + $("#tblyWlbh").val() + "','Wlmc':'','Gg':'ddhg','Wlpc':'" + "" + "','Sl':'1','Dw':'pcs','Sx':'ycl','Gys':'" + $("#tbGysdm").val() + "'}}";
                    $.ajax({
                        type: "POST",
                        url: "../GetContent.asmx/GetGysWlxxArrayList",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        data: data,
                        success: function (json) {
                            $(json).each(function () {
                                var trHtml = "<tr><td sytle='width:100px;text-align:center'>" + this.Wlbh + "</td><td sytle='width:150px'>" + this.Wlmc + 
                                           "</td><td sytle='width:100px'>" + this.Gg + "</td></tr>";

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
                                $("#tblyWlbh").val(($(this).find("td")[0]).innerHTML);
                                document.getElementById('lblWlmc').innerHTML=($(this).find("td")[1]).innerHTML;
                                document.getElementById('lblGG').innerHTML=($(this).find("td")[2]).innerHTML;
                                $("#dialog-form").dialog("close");
                                document.getElementById("tblyWlbh").focus();
                            }); 


                        },
                        error: function (error) {
                            alert("调用出错" + error.responseText);
                        }

                    });

                }

                function pageReload(){
                    $("#tblyWlbh").keypress(function (e) {
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

            </script>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div id="divPage">
                        <div style="font-size: 25px; text-align: center; font-weight: bold">
                            采购单<asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage=""
                                OnServerValidate="CustomValidator1_ServerValidate" ></asp:CustomValidator></div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">订单号</span><span class="spanControl"><asp:TextBox ID="tbBh"
                                    runat="server" Width="90%"></asp:TextBox></span> </li>
                                <li><span class="spanLabel">订单日期</span><span class="spanControl"><asp:TextBox ID="tbJbrq"
                                    runat="server" Width="90%" ReadOnly="true"></asp:TextBox></span> </li>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">供应商</span><span class="spanControl"><asp:TextBox ID="tbGysmc"
                                    runat="server" Width="90%" AutoPostBack="True" OnTextChanged="tbGysmc_TextChanged"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="200"
                                        CompletionSetCount="25" EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetGysdmList"
                                        ServicePath="~/GetContent.asmx" TargetControlID="tbGysmc">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </span></li>
                                <li><span class="spanLabel">交货工厂</span><span class="spanControl"><asp:DropDownList
                                    ID="ddlJhgc" runat="server">
                                    <asp:ListItem Value="1">新桥工厂</asp:ListItem>
                                    <asp:ListItem Value="2">东洲工厂</asp:ListItem>
                                </asp:DropDownList></span> </li>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">采购人</span><span class="spanControl"><asp:TextBox ID="tbCgr"
                                    runat="server" Width="90%" BackColor="Silver" ReadOnly="True"></asp:TextBox></span>
                                </li>
                                <li><span class="spanLabel">价格单位</span><span class="spanControl"><asp:DropDownList
                                    ID="ddlJgdw" runat="server">
                                    <asp:ListItem Selected="True" Value="￥">人民币</asp:ListItem>
                                    <asp:ListItem Value="＄">美元</asp:ListItem>
                                    <asp:ListItem Value="￥(JPY)">日元</asp:ListItem>
                                    <asp:ListItem Value="€">欧元</asp:ListItem>
                                </asp:DropDownList></span> </li>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li><span class="spanLabel">金额合计</span><span class="spanControl"><asp:TextBox ID="tbJehj"
                                    runat="server" Width="90%" AutoPostBack="True" OnTextChanged="tbJehj_TextChanged"
                                    CausesValidation="True"></asp:TextBox><br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="金额只能为数字,且最多为两位小数"
                                        ControlToValidate="tbJehj" Display="Dynamic" ValidationExpression="^\d+(\.\d{1,2})?$">
                                    </asp:RegularExpressionValidator></span> </li>
                                <li><span class="spanLabel">大写</span><span class="spanControl"><asp:TextBox ID="tbJedx"
                                    runat="server" Width="90%"></asp:TextBox></span> </li>
                            </ul>
                        </div>
                        <div class="layout">
                            <ul>
                                <li style="width: 760px;">替换3.1验收条款，校验标准按需方提供<asp:TextBox ID="tbJybz" runat="server"
                                    Width="65%"></asp:TextBox></li></ul>
                        </div>
                    </div>
                    <div>
                    </div>
                    <!--IE8要在gridView的外面在套一层DIV 这样才能居中-->
                    <div style="width: 1100px; margin: 0 auto;">
                        <div style="width: 1000px; margin: 0 auto;">
                            <div>
                                采购来源</div>
                            <div>
                                单据类型：<asp:Label ID="lblDjlx" runat="server" Text="其他"></asp:Label>
                                物料编号：<asp:TextBox ID="tblyWlbh" runat="server"></asp:TextBox>
                                数量：<asp:TextBox ID="tbSl" runat="server"></asp:TextBox>
                                物料名称：<label id="lblWlmc"></label>
                                规格：<label id="lblGG"></label>
                                <asp:Button ID="btnAddTr" runat="server" Text="添加物料" OnClick="btnAddTr_Click" OnClientClick="return confirmOperate('添加会重新生成采购列表,确定添加?')" />
                            </div>
                            <div>
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    Style="text-align: center" Font-Names="Verdana" Font-Size="12px" EmptyDataText="暂无物料采购需求"
                                    Width="100%" AllowSorting="True" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging"
                                    EmptyDataRowStyle-BackColor="#40e0d0" GridLines="None" ForeColor="#333333">
                                    <RowStyle ForeColor="#333333" BackColor="#F7F6F3" BorderStyle="Solid" BorderWidth="1px" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="选择">
                                            <HeaderTemplate>
                                                <asp:Button ID="btnDel" runat="server" Text="删除" OnClick="btnDel_Click" OnClientClick="return confirmOperate('删除会重新生成采购列表,确定删除?')" />
                                            </HeaderTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="cbDel" runat="server" />
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbDel" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle Width="3%" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="BH" HeaderText="编号">
                                            <ItemStyle Width="5%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DJLX" HeaderText="单据类型">
                                            <ItemStyle Width="5%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TLDH" HeaderText="单号">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TLBB" HeaderText="版本">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="WLBH" HeaderText="物料编号">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="WLMC" HeaderText="物料名称">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="GG" HeaderText="规格">
                                            <ItemStyle Width="15%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DW" HeaderText="单位">
                                            <ItemStyle Width="5%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="JHSL" HeaderText="数量">
                                            <ItemStyle Width="12%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="djlsh">
                                            <ControlStyle CssClass="hidden" />
                                            <FooterStyle CssClass="hidden" />
                                            <HeaderStyle CssClass="hidden" />
                                            <ItemStyle CssClass="hidden" />
                                        </asp:BoundField>
                                    </Columns>
                                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                    <PagerStyle ForeColor="White" HorizontalAlign="Center" BackColor="#284775" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <EmptyDataRowStyle BackColor="Turquoise" />
                                    <EditRowStyle BackColor="#999999" />
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                </asp:GridView>
                            </div>
                            <div>
                                采购列表(双击行追踪该行的采购来源)</div>
                            <div>
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    Style="text-align: center" Font-Names="Verdana" Font-Size="12px" EmptyDataText="暂无采购列表"
                                    Width="100%" AllowSorting="True" PageSize="50" OnPageIndexChanging="GridView2_PageIndexChanging"
                                    EmptyDataRowStyle-BackColor="#40e0d0" GridLines="Vertical" ForeColor="Black"
                                    BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
                                    OnRowDataBound="GridView2_RowDataBound">
                                    <RowStyle BackColor="#F7F7DE" BorderStyle="Solid" BorderWidth="1px" />
                                    <Columns>
                                        <asp:BoundField DataField="BH" HeaderText="编号">
                                            <ItemStyle Width="3%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="WLBH" HeaderText="物料编号">
                                            <ItemStyle Width="6%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="WLMC" HeaderText="物料名称">
                                            <ItemStyle Width="6%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="GG" HeaderText="规格">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DW" HeaderText="单位">
                                            <ItemStyle Width="4%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ZSL" HeaderText="需求数量" DataFormatString="{0:F}">
                                            <ItemStyle Width="5%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="KCSL" HeaderText="库存数量" DataFormatString="{0:F}">
                                            <ItemStyle Width="4%" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="采购数量" ItemStyle-Width="5%">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSl" runat="server" Width="95%"></asp:TextBox></EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="tbSl" runat="server" Width="95%"></asp:TextBox></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="单价" ItemStyle-Width="5%">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbDj" runat="server" Width="95%"></asp:TextBox></EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="tbDj" runat="server" Width="95%"></asp:TextBox></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="金额" ItemStyle-Width="5%">
                                            <EditItemTemplate>
                                                <asp:Label ID="lblJe" runat="server"></asp:Label>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblJe" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="到货日期" ItemStyle-Width="6%">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbDhrq" runat="server" Width="95%" /></EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="tbDhrq" runat="server" Width="95%" />
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" TargetControlID="tbDhrq" runat="server"
                                                    Format="yyyy-MM-dd">
                                                </ajaxToolkit:CalendarExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="备注" ItemStyle-Width="5%">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbBz" runat="server" Width="95%" /></EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="tbBz" runat="server" Width="95%" /></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="djlsh">
                                            <ControlStyle CssClass="hidden" />
                                            <FooterStyle CssClass="hidden" />
                                            <HeaderStyle CssClass="hidden" />
                                            <ItemStyle CssClass="hidden" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="金额" ItemStyle-Width="5%">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbJe" runat="server" Width="95%"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="tbJe" runat="server" Width="95%"></asp:TextBox>
                                            </ItemTemplate>
                                            <ControlStyle CssClass="hidden" />
                                            <FooterStyle CssClass="hidden" />
                                            <HeaderStyle CssClass="hidden" />
                                            <ItemStyle CssClass="hidden" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCC99" />
                                    <PagerStyle ForeColor="Black" HorizontalAlign="Right" BackColor="#F7F7DE" />
                                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                    <EmptyDataRowStyle BackColor="Turquoise" />
                                    <AlternatingRowStyle BackColor="White" />
                                </asp:GridView>
                            </div>
                        </div>
                        <div style="text-align: center; width: 760px; margin: 0 auto;">
                            <br />
                            <asp:LinkButton ID="lbtnOK" runat="server" Style="display: block; background-color: #4B97E3;
                                width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                                text-decoration: none; margin: 0 auto;" OnClick="btnTj_Click">提交</asp:LinkButton>
                        </div>
                    </div>
                    <!--隐藏的控件放在这里-->
                    <div style="display: none">
                        <asp:TextBox ID="tbGysdm" runat="server"></asp:TextBox>
                        <asp:TextBox ID="tbWlbh" runat="server" AutoPostBack="true" OnTextChanged="tbWlbh_TextChanged"></asp:TextBox>
                        <asp:TextBox ID="tbLxr" runat="server" BackColor="Silver" ReadOnly="true"></asp:TextBox>
                        <asp:TextBox ID="tbJhfs" runat="server" BackColor="Silver" ReadOnly="true"></asp:TextBox>
                        <asp:TextBox ID="tbJhdd" runat="server" ReadOnly="true"></asp:TextBox></div>
                </ContentTemplate>
            </asp:UpdatePanel>
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
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
