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

public partial class ksd_Print : System.Web.UI.Page
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
            Editebind();

            

        }
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
        String sqlstr = "select mc,zd,lx,bz,mrz from dbo.js_controlEnable where djmc = '质量投诉处理单'   and mc!='' and bz !='流程控制'";
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
                    //((TextBox)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl((string)ht_zddz[strZd])).Text
                    ((TextBox)this.FindControl((string)ht_zddz[strZd])).Text = sdr[strZd].ToString().Trim();
                }
                else if ("RadioButtonList" == (string)ht_lxdz[strZd])
                {
                    //((CheckBox)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl((string)ht_zddz[strZd])).Checked = ("True" == sdr[strZd].ToString());
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
                    CheckBoxList cblTemp = (CheckBoxList)this.Page.FindControl((string)ht_zddz[strZd]);
                    //获取的值一一去匹配CHECKBOXLIST的值，若匹配上 则打勾
                    for (int i = 0; i < cblTemp.Items.Count; i++)
                    {
                        if (sdr[strZd].ToString().Trim().IndexOf(cblTemp.Items[i].Text) != -1)
                        {
                            cblTemp.Items[i].Selected = true;
                        }
                    }
                }

            }



            if (sdr["swbqr"].ToString().Trim() != UserName)
            {
                this.G4.Visible = false;

            }

        }
        sqlcon.Close();
        sdr.Close();
    }



    protected void B_print_Click(object sender, EventArgs e)
    {
        sqlcon.Open();
        string UpdateSql = " UPDATE  dbo.js_zltscldH SET dyzt='已打印' WHERE tsbh='" + tb_tsbh.Text.Trim() + "'";
        Cmd = new SqlCommand(UpdateSql, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
    }
}
