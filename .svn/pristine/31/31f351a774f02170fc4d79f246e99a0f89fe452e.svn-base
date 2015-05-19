<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="yhglEdit.aspx.cs" Inherits="wkzt_yhglEdit" Title="文控管理-用户权限编辑" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>金色能源数据系统</title>


 <script language="javascript" type="text/javascript">
    //先获取所有的Checkbox
    var chkList = document.getElementsByName("CheckBox1");
	window.onload = function()
	{
		//为所有checkbox添加onclick事件处理，以自动更新“已选择的项”
		for(var i=0; i<chkList.length; i++)
		{
			chkList[i].onclick = chkClick;
		}
		
	}
	//checkbox的onclick事件，用于更新“已选择的项”
	function chkClick(){
		var checkedList = "";
		
		//获取所有被选中的项
		for(var i=0; i<chkList.length; i++){
			if(chkList[i].checked)
				checkedList += chkList[i].value + ",";
		}
				
		 
				//把选中项的列表显示到“已选择的项”中，substring在这里是为了去除最后一个逗号
		document.getElementById('<%= HiddenField1.ClientID %>').value = checkedList.substring(0,checkedList.length-1);

	}
    function checkAll()
    {
        var chkall=document.getElementById("CheckBoxAll");
        if(chkall.checked)
        {
            var checkedList = "";
            for(var i=0;i<chkList.length;i++)
            {
                  chkList[i].checked=true;
                  checkedList += chkList[i].value + ",";
            }
                       
            
            document.getElementById('<%= HiddenField1.ClientID %>').value = checkedList.substring(0,checkedList.length-1);
            //alert(document.getElementById("HiddenField1").value);
        }
        else
        {
            for(var i=0;i<chkList.length;i++){
                  chkList[i].checked=false;
                  }
             document.getElementById('<%= HiddenField1.ClientID %>').value ="";
            
        }
    }

    </script>
</head>
<body>
<form id="form1" runat="server" > 
  <div align="center">
   <p style=" font-size :large; font-weight :bold  ">用户权限管理</p> 
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="GROUPID" runat="server" />
    <asp:HiddenField ID="H_OID" runat="server" />
    <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns ="False" CellPadding="4" style="text-align: center"
         Font-Names="Verdana" Font-Size="12px"    emptydatatext="无记录"  
         Width="800px" GridLines="Horizontal"  ShowFooter ="True"   EmptyDataRowStyle-BackColor="#40e0d0" 
         BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" >
         <Columns >
                <asp:TemplateField>
                    <ItemTemplate>
                        <input name="CheckBox1" type="checkbox" value="<%#Eval("Id") %>"/>
                    </ItemTemplate>
                    <HeaderTemplate>
                         <input id="CheckBoxAll"  type="checkbox" onClick="checkAll()"  />
                    </HeaderTemplate>
                    <ItemStyle Width="3%" Wrap="False" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField  HeaderText ="ID">
                <ItemTemplate  >
                     <asp:Label ID ="ID" runat="server" Text ='<%# Eval("ID") %>'/>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Button ID="B_BC" runat="server" Text="保存"  OnClick="Button_Click"/>
                </FooterTemplate>
                <ItemStyle Width="5%"   />
            </asp:TemplateField>
            <asp:TemplateField  HeaderText ="组名">
                <ItemTemplate  >
                     <asp:Label ID ="zm"    runat="server" Text ='<%# Eval("GroupName") %>'/>
                </ItemTemplate>
                <ItemStyle Width="15%"   />
            </asp:TemplateField>
             <asp:BoundField DataField="GradationID" HeaderText="所属权限" >
                 <ItemStyle Width="30%" />
             </asp:BoundField>
           
         </Columns>
          
            <EmptyDataRowStyle BackColor="Turquoise" />
            <FooterStyle BackColor="White" ForeColor="#006699" />
            <RowStyle ForeColor="#333333" BackColor="White" />
            <PagerStyle BackColor="#006699" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
     </asp:GridView>
</div>
 </div>
     <script language="javascript" type="text/javascript">
        //先获取所有的Checkbox
        var ckList = document.getElementsByName("CheckBox1");
        var G_G = document.getElementById('<%= GROUPID.ClientID %>').value.toString(); 
        var checkedList = "";
        S=G_G.split(",");
        for(var i=0;i<ckList.length;i++)
        {
            for(var m=0;m<S.length;m++){

                if(ckList[i].value==S[m]){
                    ckList[i].checked=true;
                    checkedList += chkList[i].value + ",";
                    m=S.length;
                }
           }
        }
        document.getElementById('<%= HiddenField1.ClientID %>').value = checkedList.substring(0,checkedList.length-1);        
    </script>
</form>
</body>
</html>

