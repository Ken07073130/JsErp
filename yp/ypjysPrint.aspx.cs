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

public partial class yp_ypjysPrint : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string xh = "";
    string lb = "";
    string editType = "";
    DataTable dt = new DataTable();
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;

    protected void Page_Load(object sender, EventArgs e)
    {
        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"];
        editType = Request.QueryString["editType"];
        if (!IsPostBack)
        {

            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            ViewState["dt"] = dt;

            if (Session["username"] != null)
            {
                ddlFqr.Items.Add(Session["username"].ToString());
                ddlFQSHR.Items.Add(" ");
                ddlFQSHR.Items.Add(Session["username"].ToString());
                ddlSwb.Items.Add(" ");
                ddlSwb.Items.Add(Session["username"].ToString());
                ddlZjl.Items.Add(" ");
                ddlZjl.Items.Add(Session["username"].ToString());
                ddlJsfzr.Items.Add(" ");
                ddlJsfzr.Items.Add(Session["username"].ToString());
                ddlZfzr.Items.Add(" ");
                ddlZfzr.Items.Add(Session["username"].ToString());
                ddlSys.Items.Add(" ");
                ddlSys.Items.Add(Session["username"].ToString());

                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            //sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString); 
            controlEnable();
            if ("ADD" == lb)
            {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb.Trim())
            {
                getData();
            }
        }
    }

    protected void btnTj_Click(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();
        }
        else
        {
            Response.Redirect("Login.aspx");
        }


        // 如果控件非空，那么上传文件
        if (fulFj.HasFile)
        {
            btnUpload_Click();
        }

        if ("ADD" == lb)
        {
            if (addData())
            {
                Response.Redirect("ypjysList2.aspx");
            }
        }
        else if ("EDIT" == lb)
        {
            if (editData())
            { //编辑数据成功后
                //Response.Write("<script>alert('提交成功!');</script>");
                Response.Redirect("ypjysList2.aspx");
            }
        }

    }


    //新增时设置默认值
    public void setDefault()
    {
        DateTime dtSysDate = DateTime.Now;
        tbJBRQ.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbFqrhqsj.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbLchqzt.Text = "业务领导审核中";
    }




    //上传文件
    protected void btnUpload_Click()
    {
        if (fulFj.HasFile)
        {
            String path = @"G:\数据系统共享\";
            String actualPath = path + fulFj.FileName;
            fileName.Text = fulFj.FileName;
            try
            {
                fulFj.SaveAs(actualPath);
                tbURL.Text = actualPath;
                //ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('上传成功!');</script>");
            }
            catch (Exception ex)
            {
                String errorMessage = "<script>alert('上传失败!" + ex.Message.Replace("\r\n", "") + "');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "", errorMessage);
            }

        }

    }

    //下载文件
    protected void btnDownLoad_Click(object sender, EventArgs e)
    {
        if (tbURL.Text.Length > 1)
        {
            Response.Clear();
            Response.Charset = "utf-8";//设置输出的编码
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.ContentType = "application/octet-stream";
            //fileName转换为UTF-8
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(fileName.Text, System.Text.Encoding.UTF8));
            Response.WriteFile(tbURL.Text);
            Response.Flush();
            Response.End();



        }

    }

    //快递查询
    protected void btnKdcx_Click(object sender, EventArgs e)
    {
        //Response.Redirect("http://www.baidu.com");
        // Response.Write("<script language='javascript'>window.open('" + "http://www.baidu.com" + "','','resizable=1,scrollbars=0,status=1,menubar=no,toolbar=no,location=no,     menu=no');</script>");
        string com = "";
        if (tbKdgs.Text.Equals("速尔") || tbKdgs.Text.Equals("速尔快递"))
        {
            com = "suer";
        }
        else if (tbKdgs.Text.Equals("全一") || tbKdgs.Text.Equals("全一快递"))
        {
            com = "quanyikuaidi";
        }
        string nu = tbKddh.Text.Trim();
        string url = "<script language='javascript'>window.open('"
                  + "http://www.kuaidi100.com/chaxun?com=" + com + "&nu=" + nu
                  + "','','resizable=1,scrollbars=1,status=1,menubar=no,toolbar=no,location=no,     menu=no');</script>";
        ClientScript.RegisterStartupScript(this.GetType(), "", url);
    }


    //跳转到打印页面
    public void btnPrint_Click(object sender, EventArgs e)
    {
        Response.Redirect("cpkftaPrint.aspx?xh=" + tbBh.Text + " &lb=EDIT" + "&editType=全部");
    }

    //判断控件的可编辑情况
    public void controlEnable()
    {
        /*sqlcon.Open();
        String sqlstr = "select lx,mc,case when '" + editType + "'='会签中' or '" + editType + "' = '' then dbo.js_func_hasgroup(djmc,'" + Session["UserName"] + "','',qx) else 0 end qx from dbo.js_controlEnable where djmc='样品建议书新'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                if ("TEXTBOX" == sdr["lx"].ToString())
                    //((TextBox)FindControl(sdr["mc"].ToString().Trim())).Attributes.Add("readonly","1" == sdr["qx"].ToString()?"false":"true"); 
                    ((TextBox)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                else if ("DROPDOWNLIST" == sdr["lx"].ToString())
                    ((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                else if ("CHECKBOX" == sdr["lx"].ToString())
                    ((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                else if ("CHECKBOXLIST" == sdr["lx"].ToString())
                    ((CheckBoxList)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
            }
        }
        sqlcon.Close();
        sdr.Close();*/

    }

    //新增数据
    public Boolean addData()
    {
        sqlcon.Open();
        //第一步获取编号   年 + 月 + 001,002...
        //编号  年+月+001
        String sqlStr = "select 'JSJYS-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                        + " from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 13, 3) as int) + 1 end max_init from   js_ypjysH  "
                        + "			where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) "
                        + "      ) A ";
        Cmd = new SqlCommand(sqlStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                tbBh.Text = sdr["bh"].ToString();
            }
        }
        sdr.Close();


        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String addSQLSring = "";
        System.Text.StringBuilder zd = new System.Text.StringBuilder();
        System.Text.StringBuilder zdz = new System.Text.StringBuilder();
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '样品建议书新' and charindex('发起人',qx)>0 ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                zd.Append(sdr["zd"].ToString());
                zd.Append(",");
                zdz.Append("'");
                if ("TEXTBOX" == sdr["lx"].ToString())
                {
                    zdz.Append(((TextBox)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOX" == sdr["lx"].ToString())
                {
                    zdz.Append(((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Checked);
                }
                else if ("DROPDOWNLIST" == sdr["lx"].ToString())
                {
                    zdz.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOXLIST" == sdr["lx"].ToString())
                {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++)
                    {
                        if (cblTemp.Items[i].Selected)
                        {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    zdz.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));//全部都没勾选时 空字符串 就substring(0,0)
                }
                zdz.Append("',");
            }
        }
        sdr.Close();



        addSQLSring = "insert into js_ypjysH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_ypjysH";
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        result = true;
        return result;
    }

    //获取数据
    public void getData()
    {
        sqlcon.Open();
        //Hash表:
        //ht_zddz 字段对照 存储 前台控件和后台字段名对应关系  KEY:数据库字段名 VALUE:控件名称
        //ht_lxdz 类型对照 前台控件和控件类型对照  KEY:数据库字段名 VALUE：控件类型
        Hashtable ht_zddz = new Hashtable();
        Hashtable ht_lxdz = new Hashtable();
        //ArrayList 存储后台数据库字段名字的列表
        ArrayList listZd = new ArrayList();
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '样品建议书新' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                listZd.Add(sdr["zd"].ToString().Trim());//将数据库字段名加入list
                ht_zddz.Add(sdr["zd"].ToString().Trim(), sdr["mc"].ToString().Trim());
                ht_lxdz.Add(sdr["zd"].ToString().Trim(), sdr["lx"].ToString().Trim());
            }
        }
        sdr.Close();
        sqlstr = "select * from dbo.js_ypjysH where bh='" + xh + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {//获取数据时，只有一条数据
                //循环表的所有数据库字段
                foreach (String strZd in listZd)
                {
                    if ("TEXTBOX" == (string)ht_lxdz[strZd])
                    {//根据对照表存储的字段类型进行不同类型的转换
                        ((TextBox)FindControl((string)ht_zddz[strZd])).Text = sdr[strZd].ToString().Trim();
                    }
                    else if ("CHECKBOX" == (string)ht_lxdz[strZd])
                    {
                        ((CheckBox)FindControl((string)ht_zddz[strZd])).Checked = ("True" == sdr[strZd].ToString());
                    }
                    else if ("DROPDOWNLIST" == (string)ht_lxdz[strZd])
                    {
                        DropDownList ddlTemp = (DropDownList)FindControl((string)ht_zddz[strZd]);
                        int j = 0;
                        for (int i = 0; i < ddlTemp.Items.Count; i++)
                        {
                            if (ddlTemp.Items[i].Text == sdr[strZd].ToString().Trim())
                            {
                                j = i;//把匹配到的索引赋给j
                                break;
                            }
                        }
                        if (0 == j)
                        { //j=0说明数据库里的值没有匹配到，那么就自己把数据库的值加进去并选定
                            ddlTemp.Items.Add(sdr[strZd].ToString().Trim());
                        }
                        ddlTemp.Text = sdr[strZd].ToString().Trim();
                    }
                    else if ("CHECKBOXLIST" == (string)ht_lxdz[strZd])
                    {
                        CheckBoxList cblTemp = (CheckBoxList)FindControl((string)ht_zddz[strZd]);
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
            }
        }
        sdr.Close();
        sqlcon.Close();
    }


    //更新数据
    public Boolean editData()
    {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from    dbo.js_controlEnable where   djmc = '样品建议书新'"
                      + " and dbo.js_func_hasgroup('样品建议书新','" + Session["UserName"] + "','',qx)=1 ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                editEqualSql.Append(sdr["zd"].ToString());
                editEqualSql.Append("='");
                if ("TEXTBOX" == sdr["lx"].ToString())
                {
                    editEqualSql.Append(((TextBox)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOX" == sdr["lx"].ToString())
                {
                    editEqualSql.Append(((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Checked);
                }
                else if ("DROPDOWNLIST" == sdr["lx"].ToString())
                {
                    editEqualSql.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOXLIST" == sdr["lx"].ToString())
                {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++)
                    {
                        if (cblTemp.Items[i].Selected)
                        {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    editEqualSql.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));
                }
                editEqualSql.Append("',");

            }
        }
        editSQLSring = "update js_ypjysH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();


        result = true;
        return result;
    }



}
