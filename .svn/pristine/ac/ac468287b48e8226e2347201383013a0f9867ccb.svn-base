<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wzflEdit.aspx.cs" Inherits="wzflEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>采购单</title>
    <link rel="stylesheet" type="text/css" href="css/common.css" />
        
    <script type="text/javascript">
        function refreshParent(){
          window.opener.location.href=window.opener.location.href;
          window.close();
        }
        
        function padLeft(str, lenght) {
            if (str.length >= lenght)
                return str;
            else
                return padLeft("0" + str, lenght);
        }
        
        //自动去除非数字，数字自动补成3位
        function formatCon(controlName){
          var num=0;
          if(controlName=="dl"){
            num=padLeft(document.getElementById('tbDl').value,3);
            document.getElementById('tbDl').value=num;
          } else if(controlName=='xl'){
            num=padLeft(document.getElementById('tbXl').value,3);
            document.getElementById('tbXl').value=num;
          }
          
        }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"
                AsyncPostBackTimeout="600" EnableScriptGlobalization="true" EnableScriptLocalization="true" />
               
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <!--IE8要在gridView的外面在套一层DIV 这样才能居中-->
                    <div style="width: 600px; margin: 0 auto;">
                        <div style="width: 600px; margin: 0 auto;">
                            <div>
                                物资名称：<asp:TextBox ID="tbWzmc" runat="server" Width="88px" ></asp:TextBox>
                                大类：<asp:TextBox ID="tbDl" runat="server" Width="89px" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onblur="formatCon('dl')" MaxLength="3" AutoPostBack="True" OnTextChanged="tbDl_TextChanged"></asp:TextBox>
                                小类：<asp:TextBox ID="tbXl" runat="server" Width="86px" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onblur="formatCon('xl')" MaxLength="3"></asp:TextBox>
                                <asp:Button ID="btnAddTr" runat="server" Text="添加物料" OnClick="btnAddTr_Click"/>
                            </div>
                            <div> 
                                &nbsp;</div>
                            <div>
                                物资列表</div>
                            <div>
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    Style="text-align: center" Font-Names="Verdana" Font-Size="12px" EmptyDataText="暂无物资列表"
                                    Width="100%" AllowSorting="True" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging"
                                    EmptyDataRowStyle-BackColor="#40e0d0" GridLines="Vertical" ForeColor="Black"
                                    BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" OnRowDeleting="GridView1_RowDeleting" >
                                    <RowStyle BackColor="#F7F7DE" BorderStyle="Solid" BorderWidth="1px" />
                                    <Columns>
                                        <asp:BoundField DataField="WZMC" HeaderText="物资名称">
                                            <ItemStyle Width="30%" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="DL" HeaderText="大类">
                                            <ItemStyle Width="30%" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="XL" HeaderText="小类">
                                            <ItemStyle Width="30%" />
                                        </asp:BoundField>
                                     
                                        <asp:BoundField DataField="djlsh" >
                                            <ControlStyle CssClass="hidden" />
                                            <FooterStyle CssClass="hidden" />
                                            <HeaderStyle CssClass="hidden" />
                                            <ItemStyle CssClass="hidden" />
                                        </asp:BoundField>
                                        <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ItemStyle-Width="10%"  />
                                     
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
                        <div style="text-align: center; width: 600px; margin: 0 auto;">
                            <br />
                            <asp:LinkButton ID="lbtnOK" runat="server" Style="display: block; background-color: #4B97E3;
                                width: 105px; height: 30px; color: white; font-size: 15px; line-height: 30px;
                                text-decoration: none; margin: 0 auto;" OnClientClick="refreshParent()">返回并更新</asp:LinkButton>
                        </div>
                    </div>
                    <!--隐藏的控件放在这里-->
                    <div style="display: none">
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
       
    </form>
</body>
</html>
