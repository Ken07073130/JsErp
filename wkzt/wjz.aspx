<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wjz.aspx.cs" Inherits="wkzt_wjz" Title="�Ŀع���-�û���Ȩ������" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>��ɫ��Դ����ϵͳ</title>


 <script language="javascript" type="text/javascript">
    //�Ȼ�ȡ���е�Checkbox
    var chkList = document.getElementsByName("CheckBox_ck1");
    var chkList2 = document.getElementsByName("CheckBox_ck2");
    var chkList3 = document.getElementsByName("CheckBox_xz1");
    var chkList4 = document.getElementsByName("CheckBox_xz2");
	window.onload = function()
	{
		//Ϊ����checkbox���onclick�¼��������Զ����¡���ѡ����
		for(var i=0; i<chkList.length; i++)
		{
			chkList[i].onclick = chkClick;
		}
		for(var i=0; i<chkList2.length; i++)
		{
			chkList2[i].onclick = chkClick;
		}
		for(var i=0; i<chkList3.length; i++)
		{
			chkList3[i].onclick = chkClick1;
		}
		for(var i=0; i<chkList4.length; i++)
		{
			chkList4[i].onclick = chkClick1;
		}
	}
	
	//checkbox��onclick�¼������ڸ��¡���ѡ����
	function chkClick1(){
		var checkedList = "";
		
		//��ȡ���б�ѡ�е���
		for(var i=0; i<chkList3.length; i++){
			if(chkList3[i].checked)
			{
				checkedList += chkList3[i].value + ",";
				
			}
		}
		
		
		 for(var i=0; i<chkList4.length; i++){
			if(chkList4[i].checked)
			{
			    
                for(var s=0;s<chkList3.length;s++)
                {
                    if (chkList3[s].value==chkList4[i].value.split("-")[0] && chkList3[s].checked==false )
                    {   
                        
                        chkList3[s].checked=true;
                        checkedList += chkList3[s].value + ",";
                        s=chkList3.length;
                    }
                }
			    
				checkedList += chkList4[i].value.split("-")[1] + ",";
				//alert(chkList2[i].value.split("-")[0]);
				
			}
		}
		
		  //��ѡ������б���ʾ������ѡ�����У�substring��������Ϊ��ȥ�����һ������
		document.getElementById('<%= HiddenField2.ClientID %>').value = checkedList.substring(0,checkedList.length-1);
		
	}
	
	function chkClick(){
		var checkedList = "";
		
		//��ȡ���б�ѡ�е���
		for(var i=0; i<chkList.length; i++){
			if(chkList[i].checked)
			{
				checkedList += chkList[i].value + ",";
				
			}
		}

		 for(var i=0; i<chkList2.length; i++){
			if(chkList2[i].checked)
			{
                for(var s=0;s<chkList.length;s++)
                {
                    if (chkList[s].value==chkList2[i].value.split("-")[0] && chkList[s].checked==false )
                    {   
                        chkList[s].checked=true;
                        checkedList += chkList[s].value + ",";
                        s=chkList.length;
                    }
                }
				checkedList += chkList2[i].value.split("-")[1] + ",";
				//alert(chkList2[i].value.split("-")[1]);
				//alert(checkedList);
			}
		}
		
				//��ѡ������б���ʾ������ѡ�����У�substring��������Ϊ��ȥ�����һ������
		document.getElementById('<%= HiddenField1.ClientID %>').value = checkedList.substring(0,checkedList.length-1);
		
		//alert(document.getElementById("HiddenField1").value);
	}
	
    function checkAll_ck()
    {
        var chkall=document.getElementById("CheckBoxAll_ck");
        if(chkall.checked)
        {
            var checkedList = "";
            for(var i=0;i<chkList.length;i++)
            {
                  chkList[i].checked=true;
                  checkedList += chkList[i].value + ",";
            }
            for(var i=0;i<chkList2.length;i++)
            {
                  chkList2[i].checked=true;
                  checkedList += chkList2[i].value.split("-")[1] + ",";
            }
            
            
            document.getElementById('<%= HiddenField1.ClientID %>').value = checkedList.substring(0,checkedList.length-1);
            //alert(document.getElementById("HiddenField1").value);
        }
        else
        {
            for(var i=0;i<chkList.length;i++){
                  chkList[i].checked=false;
                  }
            for(var i=0;i<chkList2.length;i++)
                  chkList2[i].checked=false;
            document.getElementById('<%= HiddenField1.ClientID %>').value="";
            
        }
    }
    
    function checkAll_xz()
    {
        var chkall=document.getElementById("CheckBoxAll_xz");
        if(chkall.checked)
        {
            var checkedList = "";
            for(var i=0;i<chkList3.length;i++)
            {
                  chkList3[i].checked=true;
                  checkedList += chkList3[i].value + ",";
            }
            for(var i=0;i<chkList4.length;i++)
            {
                  chkList4[i].checked=true;
                  checkedList += chkList4[i].value.split("-")[1] + ",";
            }
            
            
            document.getElementById('<%= HiddenField2.ClientID %>').value = checkedList.substring(0,checkedList.length-1);
            //alert(document.getElementById("HiddenField1").value);
        }
        else
        {
            for(var i=0;i<chkList3.length;i++){
                  chkList3[i].checked=false;
                  }
            for(var i=0;i<chkList4.length;i++)
                  chkList4[i].checked=false;
            document.getElementById('<%= HiddenField2.ClientID %>').value="";
            
        }
    }
    </script>
</head>
<body>
<form id="form1" runat="server" >


     <div align="center">
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="G_Gradation" runat="server" />
    <asp:HiddenField ID="G_Gradation1" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
    <asp:HiddenField ID="H_ID" runat="server" />
         <div style =" text-align:center" >  <p> <asp:Label ID="GroupName" runat="server" Font-Bold="True" Font-Size="Large"></asp:Label> </p> </div>
        <asp:GridView ID="GridView1" runat="server"    AutoGenerateColumns="False" Width="800px" OnRowCommand="GridView1_RowCommand" Font-Names="Verdana" Font-Size="12px" 
        OnRowDataBound="GridView1_RowDataBound" CellPadding="3" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"  >
             <Columns >
            <asp:TemplateField HeaderText="�ļ�������" >
                <ItemTemplate  > 
                    <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("ImgURL") %>' />
                     <asp:Label ID ="mc2"    runat="server" Text ='<%# Eval("mc") %>'/>
                </ItemTemplate>
                <ItemStyle Width="200px"  HorizontalAlign ="Left" />
            </asp:TemplateField> 
                 <asp:BoundField DataField="FullName" HeaderText="�ļ���·��" >
                     <ItemStyle Width="400px"  HorizontalAlign="Left"   />
                 </asp:BoundField>
                 
                 
                 
                 <asp:TemplateField >
                    <ItemTemplate  >
                    
                        <input name="CheckBox_ck1" type="checkbox" value="<%#Eval("ck") %>"/>
                    </ItemTemplate>
                    <HeaderTemplate >
                         <input id="CheckBoxAll_ck"   type="checkbox" onclick="checkAll_ck()"  />
                         �鿴Ȩ��
                    </HeaderTemplate>
                    <ItemStyle Width="100px" HorizontalAlign ="Center"  />
                 </asp:TemplateField>
                 
               <asp:TemplateField >
                    <ItemTemplate>
                   <input name="CheckBox_xz1" type="checkbox" value="<%#Eval("xz") %>"/>
                    </ItemTemplate>
                    <HeaderTemplate >
                         <input id="CheckBoxAll_xz"  type="checkbox" onclick="checkAll_xz()"  />
                         ����Ȩ��
                    </HeaderTemplate>
                    <ItemStyle Width="100px" Wrap="False" HorizontalAlign="Center" />
                </asp:TemplateField>
                  <asp:TemplateField >
                 
                  <ItemTemplate>    
                  <tr> <td colspan ="4" align="right"  >
                 
                            <asp:GridView ShowHeader="false" ID="GridView2"  align="right" runat="server"  AutoGenerateColumns="False"   
                             Width="780"  Font-Names="Verdana" Font-Size="12px"   CellPadding="3"  BackColor="White" BorderColor="#CCCCCC" BorderStyle="None">
                                <Columns>
                                 <asp:TemplateField HeaderText="�ļ�������" >
                                    <ItemTemplate  >��
                                        <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("ImgURL") %>' />
                                         <asp:Label ID ="mc2"    runat="server" Text ='<%# Eval("mc") %>'/>
                                    </ItemTemplate>
                                    <ItemStyle Width="194px"  HorizontalAlign ="Left" />
                                </asp:TemplateField> 
<%--                            <asp:BoundField DataField="mc" HeaderText="�ļ�������" >
                                    <ItemStyle Width="25%"   HorizontalAlign="Left" />
                                </asp:BoundField>--%>
                                 <asp:BoundField DataField="FullName" HeaderText="�ļ���·��" >
                                     <ItemStyle Width="394px"  HorizontalAlign="Left"   />
                                 </asp:BoundField> 

                                 <asp:TemplateField  >
                                    <ItemTemplate>
                                        <input name="CheckBox_ck2" type="checkbox" value="<%#Eval("ck") %>"  onclick="chkClick1()" />
                                    </ItemTemplate>
                                    <ItemStyle Width="98px" Wrap="False" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                 
                               <asp:TemplateField >
                                    <ItemTemplate>
                                        <input name="CheckBox_xz2" type="checkbox" value="<%#Eval("xz") %>" onclick="chkClick1()" />
                                    </ItemTemplate>
                                    <ItemStyle Width="94px" Wrap="False" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                </Columns> 
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <RowStyle ForeColor="#000066" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                            </asp:GridView> 
                         </td></tr>
                   </ItemTemplate>
                   
                </asp:TemplateField>


               
             </Columns>
              
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <RowStyle ForeColor="#000066" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
         </asp:GridView>
        <asp:Button ID="B_TJ" runat="server" Text="�ύ" OnClick="B_TJ_Click" />
        <script language="javascript" type="text/javascript">
        //�Ȼ�ȡ���е�Checkbox
        var ckList = document.getElementsByName("CheckBox_ck1");
        var G_G = document.getElementById( '<%= G_Gradation.ClientID %>').value.toString(); 

        S=G_G.split(";");
        for(var i=0;i<ckList.length;i++)
        {
            for(var m=0;m<S.length;m++){

                if(ckList[i].value==S[m]){
                    ckList[i].checked=true;
                    m=S.length;
                }
             
           }
        }
        var ckList2 = document.getElementsByName("CheckBox_ck2");
        for(var i=0;i<ckList2.length;i++)
        {
            for(var m=0;m<S.length;m++){
                var ss=ckList2[i].value
                si=ss.split("-");
                //document.write(S[m]+"<br/>"); //�ָ����ַ���� 
                if(si[1]==S[m]){
                    ckList2[i].checked=true;
                    m=S.length;
                }
             
           }
        }
        document.getElementById('<%= HiddenField1.ClientID %>').value = document.getElementById('<%= G_Gradation.ClientID %>').value.toString(); 
        var ckList3 = document.getElementsByName("CheckBox_xz1");
        var G_G1 = document.getElementById('<%= G_Gradation1.ClientID %>').value.toString(); 
        S1=G_G1.split(";");
        for(var i=0;i<ckList3.length;i++)
        {
            for(var m=0;m<S1.length;m++){

                if(ckList3[i].value==S1[m]){
                    ckList3[i].checked=true;
                    m=S.length;
                }
             
           }
        }
        var ckList4 = document.getElementsByName("CheckBox_xz2");
        for(var i=0;i<ckList4.length;i++)
        {
            for(var m=0;m<S1.length;m++){
                var ss=ckList4[i].value
                si=ss.split("-");
                //document.write(S[m]+"<br/>"); //�ָ����ַ���� 
                if(si[1]==S1[m]){
                    ckList4[i].checked=true;
                    m=S1.length;
                }
             
           }
        }
         document.getElementById('<%= HiddenField2.ClientID %>').value = document.getElementById('<%= G_Gradation1.ClientID %>').value.toString(); 
    </script>
    </div> 
</form>
</body>
</html>

