using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class ksdAjax : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string editType = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);  //链接数据库
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }

            
            djxh.Value = Request.QueryString["xh"];
            czlb.Value  = Request.QueryString["lb"];
            HF_username.Value = UserName;
            editType = Request.QueryString["editType"];
            if (czlb.Value == "Edite")
            {
                //((HtmlTable)this.FindControl("BZ")).Visible = true;
                Editebind();
                controlEnable();

            } if (czlb.Value == "Add")
            {
                //((HtmlTable)this.FindControl("BZ")).Visible = true;
                setDefault();//新增单据设置默认值

            }
            

        }
        B_tj.Attributes.Add("onclick", "javascript:return confirm('确定提交？')");
        B_print.Attributes.Add("onclick", "this.form.target='_newName'");
    }

    //新增时设置默认值
    public void setDefault()
    {
        hqzt.Value = "商务客诉录入中";
        tb_swbqr.Text = UserName;
        tb_qrrq.Text = DateTime.Today.ToString();
    }

    public void Editebind()
    {
        sqlcon.Open();
        //Hash表:
        //ht_zddz 字段对照 存储 前台控件和后台字段名对应关系  KEY:数据库字段名 VALUE:控件名称
        //ht_lxdz 类型对照 前台控件和控件类型对照  KEY:数据库字段名 VALUE：控件类型
        //ht_lxdz 类型对照 前台控件和控件类型对照  KEY:数据库字段名 VALUE：字段所属的步骤
        Hashtable ht_zddz = new Hashtable();
        Hashtable ht_lxdz = new Hashtable();
        Hashtable ht_hqzt = new Hashtable();
        //ArrayList 存储后台数据库字段名字的列表
        ArrayList listZd = new ArrayList();
        //ArrayList 存储控制表单流程字段的列表
        ArrayList listBzlc = new ArrayList();
        String sqlstr = "select mc,zd,lx,bz,mrz from dbo.js_controlEnable where djmc = '质量投诉处理单'   and mc!=''";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                listZd.Add(sdr["zd"].ToString().Trim());//将数据库字段名加入list
                ht_zddz.Add(sdr["zd"].ToString().Trim(), sdr["mc"].ToString().Trim());
                ht_lxdz.Add(sdr["zd"].ToString().Trim(), sdr["lx"].ToString().Trim());
                if (sdr["bz"].ToString().Trim()=="流程控制")
                {
                    listBzlc.Add(sdr["zd"].ToString().Trim());
                    ht_hqzt.Add(sdr["zd"].ToString().Trim(), sdr["mrz"].ToString().Trim());
                }
            }
        }
        sdr.Close();

        sqlstr = "select * from js_zltscldh where djlsh='" + djxh.Value + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            foreach (String strZd in listZd)
            {
                if ("TEXTBOX" == (string)ht_lxdz[strZd])
                {//根据对照表存储的字段类型进行不同类型的转换
                    //((TextBox)this.FindControl((string)ht_zddz[strZd])).Text
                    ((TextBox)this.FindControl((string)ht_zddz[strZd])).Text = sdr[strZd].ToString().Trim();
                }
                else if ("RadioButtonList" == (string)ht_lxdz[strZd])
                {
                    //((CheckBox)this.FindControl((string)ht_zddz[strZd])).Checked = ("True" == sdr[strZd].ToString());
                    RadioButtonList RBlTemp = (RadioButtonList)this.FindControl((string)ht_zddz[strZd]);
                    int j = 99;
                    for (int i = 0; i < RBlTemp.Items.Count; i++)
                    {
                        if (RBlTemp.Items[i].Text == sdr[strZd].ToString().Trim())
                        {
                            j = i;//把匹配到的索引赋给j
                            break;
                        }
                    }
                    if (99 == j && sdr[strZd].ToString().Trim()!="")
                    { //j=0说明数据库里的值没有匹配到，那么就自己把数据库的值加进去并选定
                        RBlTemp.Items.Add(sdr[strZd].ToString().Trim());
                    }
                    RBlTemp.Text = sdr[strZd].ToString().Trim();
                }
                else if ("DropDownList" == (string)ht_lxdz[strZd])
                {
                    DropDownList ddlTemp = (DropDownList)this.FindControl((string)ht_zddz[strZd]);
                    ddlTemp.ClearSelection(); 
                    //匹配数据库内的数据控件中是否存在
                     if (ddlTemp.Items.FindByText(sdr[strZd].ToString().Trim()) ==null &&　sdr[strZd].ToString().Trim() != "") 
                     {//不存在的话判断这个值是否为空不为空的话添加这个值
                        ddlTemp.Items.Add(sdr[strZd].ToString().Trim());
                     }
                    ddlTemp.Items.FindByText(sdr[strZd].ToString().Trim()).Selected = true;
                     
                    
                }
                else if ("CheckBoxList" == (string)ht_lxdz[strZd])
                {
                    CheckBoxList cblTemp = (CheckBoxList)this.FindControl((string)ht_zddz[strZd]);
                    //获取的值一一去匹配CHECKBOXLIST的值，若匹配上 则打勾
                    for (int i = 0; i < cblTemp.Items.Count; i++)
                    {
                        if (sdr[strZd].ToString().Trim().IndexOf(cblTemp.Items[i].Text) != -1)
                        {
                            cblTemp.Items[i].Selected = true;
                        }
                    }
                }
                else if ("Label" == (string)ht_lxdz[strZd])
                {//根据对照表存储的字段类型进行不同类型的转换
                    //((TextBox)this.FindControl((string)ht_zddz[strZd])).Text
                    ((Label)this.FindControl((string)ht_zddz[strZd])).Text = sdr[strZd].ToString().Trim();
                }
            }

            foreach (String strBzlc in listBzlc)   //读取当前的会签状态
            {
                if (sdr[strBzlc].ToString().Trim() == "会签中")
                {
                    hqzt.Value += (string)ht_hqzt[strBzlc] + ",";        
                }
                if (sdr["swbqr"].ToString().Trim() != UserName) //不是单据的发起人不能修改流程状态
                {
                    ((DropDownList)this.FindControl((string)ht_zddz[strBzlc])).Enabled = false;
                    B_Change.Enabled = false;
                }

            }
            if (hqzt.Value.Length > 0)
            {
                hqzt.Value = hqzt.Value.Substring(0, hqzt.Value.Length - 1);
            }
            


            if (sdr["swbqr"].ToString().Trim() != UserName)
            {
                this.G4.Visible = false;

            }

        }
        sqlcon.Close();
        sdr.Close();
    }


    //判断控件的可编辑情况
    public void controlEnable()
    {
        sqlcon.Open();
        String sqlstr = "select lx,mc,case when '" + editType + "'='会签中' or '" + editType + "' = '' then dbo.js_func_hasgroup(djmc,'" + Session["username"].ToString() + "','',qx) else 0 end qx,bz from dbo.js_controlEnable where djmc='质量投诉处理单' and  mc!='' and bz!='流程控制'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                if (hqzt.Value.IndexOf(sdr["bz"].ToString().Trim())!=-1)//    (hqzt.Value == "商务客诉录入中") || (hqzt.Value == "质量分析录入中") || (hqzt.Value == "质量经理审核中") || (hqzt.Value == "商务材耗统计中"))
                {//只有在会签过程中才去判断控件是否可以编辑
                    if ("TEXTBOX" == sdr["lx"].ToString())
                        //((TextBox)this.FindControl(sdr["mc"].ToString().Trim())).Attributes.Add("readonly","1" == sdr["qx"].ToString()?"false":"true"); 
                        ((TextBox)this.FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                    else if ("DropDownList" == sdr["lx"].ToString())
                        ((DropDownList)this.FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                    else if ("RadioButtonList" == sdr["lx"].ToString())
                        ((RadioButtonList)this.FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                    else if ("CheckBoxList" == sdr["lx"].ToString())
                        ((CheckBoxList)this.FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                }
                else
                {//否则所有的控件都不能编辑
                    if ("TEXTBOX" == sdr["lx"].ToString())
                        //((TextBox)this.FindControl(sdr["mc"].ToString().Trim())).Attributes.Add("readonly","1" == sdr["qx"].ToString()?"false":"true"); 
                        ((TextBox)this.FindControl(sdr["mc"].ToString().Trim())).Enabled = false;
                    else if ("DropDownList" == sdr["lx"].ToString())
                        ((DropDownList)this.FindControl(sdr["mc"].ToString().Trim())).Enabled = false;
                    else if ("RadioButtonList" == sdr["lx"].ToString())
                        ((RadioButtonList)this.FindControl(sdr["mc"].ToString().Trim())).Enabled = false;
                    else if ("CheckBoxList" == sdr["lx"].ToString())
                        ((CheckBoxList)this.FindControl(sdr["mc"].ToString().Trim())).Enabled = false;
                }
            }
        }
        sqlcon.Close();
        sdr.Close();

    }

    //新增数据
    public Boolean addData()
    {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String addSQLSring = "";
        System.Text.StringBuilder zd = new System.Text.StringBuilder();
        System.Text.StringBuilder zdz = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select mc,zd,lx,zdlx from dbo.js_controlEnable where djmc = '质量投诉处理单' and charindex('商务客诉录入',qx)>0 and  mc!='' and bz='" + hqzt.Value + "' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                zd.Append(sdr["zd"].ToString());
                zd.Append(",");
                if (sdr["zdlx"].ToString() == "nvarchar")
                {
                    zdz.Append("'");
                }
                
                if ("TEXTBOX" == sdr["lx"].ToString())
                {
                    if (sdr["zdlx"].ToString() != "nvarchar" && ((TextBox)this.FindControl(sdr["mc"].ToString().Trim())).Text.Trim() == "")
                    {
                        zdz.Append("0");
                    }
                    else
                    {
                        zdz.Append(((TextBox)this.FindControl(sdr["mc"].ToString().Trim())).Text);
                    }
                    
                }
                else if ("RadioButtonList" == sdr["lx"].ToString())
                {
                    //zdz.Append(((RadioButtonList)this.FindControl(sdr["mc"].ToString().Trim())).Checked);
                    RadioButtonList cblTemp = (RadioButtonList)this.FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++)
                    {
                        if (cblTemp.Items[i].Selected)
                        {
                            zdz.Append(cblTemp.Items[i].Text); 
                        }
                    }
                }
                else if ("DropDownList" == sdr["lx"].ToString())
                {
                    zdz.Append(((DropDownList)this.FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CheckBoxList" == sdr["lx"].ToString())
                {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)this.FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++)
                    {
                        if (cblTemp.Items[i].Selected)
                        {
                            strTemp = strTemp + cblTemp.Items[i].Text + '并';
                        }
                    }
                    zdz.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));//全部都没勾选时 空字符串 就substring(0,0)
                }
                if (sdr["zdlx"].ToString() == "nvarchar")
                {
                    zdz.Append("'");
                }
                zdz.Append(",");
            }
        }
        sdr.Close();


        addSQLSring = "insert into js_zltscldh (djlsh,lchqzt,swbhqzt,zlbhqzt,shhqzt,chtjhqzt,dqzt,thyfdw,bfdccbdw,fgfjfydw,rgfydw,bccldw,xcclfydw,pcfydw,hjzssdw,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,'未完成','已会签','会签中','-','-','质量分析录入中','￥','￥','￥','￥','￥','￥','￥','￥',"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_zltscldh";
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        //更新单据流水号
        string UpdateDjlsh = " UPDATE dbo.STDjLsh SET DjLsh=(SELECT MAX(djlsh)+1 FROM dbo.js_zltscldH) WHERE djname='js_zltscld'";
        Cmd = new SqlCommand(UpdateDjlsh, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        result = true;
        return result;
    }


    //更新数据
    public Boolean editData()
    {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        string sql_hqzt = "";
        if (hqzt.Value.Split(',').Length > 1)
        {
            sql_hqzt = "bz in ('" + hqzt.Value.Split(',')[0] + "','" + hqzt.Value.Split(',')[1] + "') ";
        }
        else
        {
            sql_hqzt = "bz in ('" + hqzt.Value + "') ";

        }
        String sqlstr = " select  mc,lx,zd,zdlx from dbo.js_controlEnable where   djmc = '质量投诉处理单'"
                      + " and dbo.js_func_hasgroup('质量投诉处理单','" + Session["UserName"] + "','',qx)=1 and  mc!='' and " + sql_hqzt;
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                editEqualSql.Append(sdr["zd"].ToString());
                editEqualSql.Append("=");
                if (sdr["zdlx"].ToString() == "nvarchar")
                {
                    editEqualSql.Append("'");
                }
                if ("TEXTBOX" == sdr["lx"].ToString())
                {//如果是数字输入为空的情况下则写入0
                    if (sdr["zdlx"].ToString() != "nvarchar" && ((TextBox)this.FindControl(sdr["mc"].ToString().Trim())).Text.Trim() == "")
                    {
                        editEqualSql.Append("0");
                    }
                    else
                    {
                        editEqualSql.Append(((TextBox)this.FindControl(sdr["mc"].ToString().Trim())).Text);
                    }
                    
                }
                else if ("RadioButtonList" == sdr["lx"].ToString())
                {
                    //editEqualSql.Append(((CheckBox)this.FindControl(sdr["mc"].ToString().Trim())).Checked);
                    RadioButtonList cblTemp = (RadioButtonList)this.FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++)
                    {
                        if (cblTemp.Items[i].Selected)
                        {
                            editEqualSql.Append(cblTemp.Items[i].Text);
                        }
                    }
                }
                else if ("DropDownList" == sdr["lx"].ToString())
                {
                    editEqualSql.Append(((DropDownList)this.FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CheckBoxList" == sdr["lx"].ToString())
                {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)this.FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++)
                    {
                        if (cblTemp.Items[i].Selected)    
                        {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    editEqualSql.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));
                }
                if (sdr["zdlx"].ToString() == "nvarchar")
                {
                    editEqualSql.Append("'");
                }
                editEqualSql.Append(",");

            }
        }

        //检查会签状态看是否达到更改会签状态的标准
        if (hqzt.Value == "质量分析录入中")
        {//如果是质量分析录入中中判断质量部完成状态是否是“已完成”
            if (dd_zlbwczt.Text == "已完成")
            {//如果质量部完成状态是“已完成”则判断下一步工序“质量部经理审核”是否为“-”
                editEqualSql.Append("zlbhqzt='已会签',");
                if (DD_shhqzt.Text == "-")
                {
                    editEqualSql.Append("shhqzt='会签中',dqzt='质量经理审核中',");
                }
                else if ( DD_shhqzt.Text == "已会签")
                {
                    editEqualSql.Append("dqzt='会签完成',");
                }
            }
        }
        else if (hqzt.Value == "质量经理审核中")
        {//如果是质量经理审核中中判断质量部完成状态是否是“审核通过”
            if (dd_shzt.Text == "审核通过")
            {//如果质量经理审核中审核结果为“审核通过”则完成质量经理审核中
                editEqualSql.Append("shhqzt='已会签', ");
                if (DD_chtjhqzt.Text == "-")
                {
                    editEqualSql.Append("chtjhqzt='会签中',dqzt='商务材耗统计中',");
                }
                else if (DD_chtjhqzt.Text == "已会签")
                {
                    editEqualSql.Append("dqzt='会签完成',");
                }

            }
            else if(dd_shzt.Text=="审核不通过")
            {//如果质量经理会审核结果为“审核不通过”则退回质量部重新分析
                editEqualSql.Append("shhqzt='-',zlbhqzt='会签中',dqzt='质量分析录入中',zlbwczt='',");
            }
        }
        else if (hqzt.Value == "商务材耗统计中")
        {//如果合计损失不等于0则会签完成
            if (tb_hjzss.Text.Trim() != "0" && tb_hjzss.Text.Trim() != "0.00")
            {//如果前面的审核都是“已会签”则完成这次会签活动。
                editEqualSql.Append("chtjhqzt='已会签',");
                
                if (DD_swbhqzt.Text == "已会签" && DD_zlbhqzt.Text == "已会签" && DD_shhqzt.Text == "已会签")
                {
                    editEqualSql.Append("lchqzt='已完成',dqzt='会签完成',");
                }
            }
        }
        else if (hqzt.Value == "商务客诉录入中")
        {
            editEqualSql.Append("swbhqzt='已会签',");
            if (DD_zlbhqzt.Text == "已会签")
            {
                editEqualSql.Append("dqzt='会签完成',");
            }


            
        }
        editSQLSring = "update js_zltscldh set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where djlsh='" + djxh.Value + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        result = true;
        return result;
    }





    protected void B_print_Click(object sender, EventArgs e)
    {
        Response.Redirect("ksdPrint.aspx?xh="+djxh.Value+"");
    }


    protected void B_tj_Click(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();
        }
        else
        {
            Response.Redirect("../Login.aspx");
        }

        if (czlb.Value == "Add")
        {
            if (addData())
            {  //添加单据
                //Response.Redirect("ksdlb.aspx");
                Response.Write("<script>alert('添加单据成功!');self.location='ksdlb.aspx';</script>");
            }
        }
        else if (czlb.Value == "Edite")
        {
            
            if (editData())
            { //编辑数据成功后
                Response.Write("<script>alert('提交成功!');self.location='ksdlb.aspx';</script>");
                //Response.Redirect("ksdlb.aspx");
            }
        }
    }
    protected void B_Change_Click(object sender, EventArgs e)
    {
        String editSQLSring = "";
        string lczt = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd,zdlx from dbo.js_controlEnable where   djmc = '质量投诉处理单'"
                      + " and mc!='' and bz='流程控制'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                editEqualSql.Append(sdr["zd"].ToString());
                editEqualSql.Append("='");
                if ("DropDownList" == sdr["lx"].ToString())
                {
                    string zt = ((DropDownList)this.FindControl(sdr["mc"].ToString().Trim())).SelectedItem.Text;
                    editEqualSql.Append(zt);
                    if (zt == "会签中")
                    {
                        lczt = ((DropDownList)this.FindControl(sdr["mc"].ToString().Trim())).SelectedValue  ;
                    }
                    
                }
                editEqualSql.Append("',");
            }
        }

        editEqualSql.Append(" dqzt='" + lczt + "',");
        editSQLSring = "update js_zltscldh set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where djlsh='" + djxh.Value + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        Response.Write("<script>alert('会签状态成功!');self.location='ksdlb.aspx';</script>");

    }
}
