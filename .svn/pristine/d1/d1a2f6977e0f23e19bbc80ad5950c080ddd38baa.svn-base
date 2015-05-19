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

public partial class zxwtfkEdit : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "";
    string editType = "";
    DataTable dt = new DataTable();
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {

        //sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);

        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"].Trim();
        editType = Request.QueryString["editType"];
        getGSDC();
        if (!String.IsNullOrEmpty(xh))
        {
            xh = xh.Trim();
        }
        if (!IsPostBack)
        {

            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            ViewState["dt"] = dt;

            if (Session["username"] != null)
            {
                ddlZlbjl.Items.Add(Session["username"].ToString());
                ddlZlbqrr.Items.Add(Session["username"].ToString());
                ddlFxr.Items.Add(Session["username"].ToString());
                ddlFxrsh.Items.Add(Session["username"].ToString());
                ddlFqr.Items.Add(Session["username"].ToString());
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

    protected void getGSDC()
    {
        sqlcon.Open();
        //记录select默认选项的的html
        string optionString = "";
        string controlReadOnly = "";
        string controlDisabled = "";
        string sqlstr = "select  b.fzr fxr,a.bh,GSDC,a.FZR,YJSSRQ,SSZK,SSWCRQ from js_tzxwtfk_gsdcH a,js_tzxwtfkH b where a.BH=b.BH and a.bh='" + xh + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        int i = 1;//记录条数
        SqlDataReader sdr = Cmd.ExecuteReader();
        dtb.InnerHtml = "";
        dtb.InnerHtml = "<table id='tableExists' ><tr id='trHeader1'><td width='64' bgcolor='#96E0E2'>改善对策</td>"
                        + "<td width='98' bgcolor='#96E0E2'>负责人</td><td width='92' bgcolor='#96E0E2'>预计实施日期</td><td width='75' bgcolor='#96E0E2'>实施状况</td>"
                        + "<td width='153' bgcolor='#96E0E2'>实施完成日期</td><td width='57' align='center' bgcolor='#96E0E2'><a href='javascript:void(0);'><img src='images/zxwtfk_tjgsdc.jpg' onclick='insertExistsRow()' /></a></td> </tr>";

        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                controlReadOnly = sdr["fxr"].ToString().Trim() == Session["username"].ToString().Trim() ? " " : " readonly='readonly'";
                controlDisabled = sdr["fxr"].ToString().Trim() == Session["username"].ToString().Trim() ? " " : " disabled='disabled'";
                /*dtb.InnerHtml = dtb.InnerHtml + "<label>"+i+"</label> "
                                              + "<input id = 'ipBH" + i + "' type = '' value='" + sdr["bh"].ToString() + "' runat = 'server' onclick='alert11()' />"
                                              + "<input id = 'ipGSDC" + i + "' type = '' value='" + sdr["gsdc"].ToString() + "' runat = 'server'/>"
                                              + "<input id = 'ipFZR" + i + "' type = '' value='" + sdr["fzr"].ToString() + "' runat = 'server'/>"
                                              + "<input id = 'ipYJSSRQ" + i + "' type = '' value='" + sdr["yjssrq"].ToString() + "' runat = 'server'/>"
                                              + "<input id = 'ipSSZK" + i + "' type = '' value='" + sdr["sszk"].ToString() + "' runat = 'server'/>"
                                              + "<input id = 'ipSSWCRQ" + i + "' type = '' value='" + sdr["sswcrq"].ToString() + "' runat = 'server'/>"
                                              + "</br>";*/

                //默认选中
                if (sdr["SSZK"].ToString() == "未实施")
                {
                    optionString = " <option selected='selected'>未实施</option> <option>进行中</option> <option>已实施</option>  ";
                }
                else if (sdr["SSZK"].ToString() == "进行中")
                {
                    optionString = " <option >未实施</option> <option selected='selected'>进行中</option>  <option>已实施</option>  ";
                }
                else if (sdr["SSZK"].ToString() == "已实施")
                {
                    optionString = " <option >未实施</option> <option >进行中</option>  <option selected='selected'>已实施</option>  ";
                }
                dtb.InnerHtml = dtb.InnerHtml + "<tr> "
                                              + "<td><textarea name='txtGSDC" + i + "'id='txtGSDC" + i + "' cols='50' rows='3' " + controlReadOnly + "  >" + sdr["GSDC"].ToString() + "</textarea></td>"
                                              + "<td><input name='txtFZR" + i + "' id='txtFZR" + i + "' type='text' size='10' " + controlReadOnly + " value='" + sdr["fzr"].ToString() + "'/></td>"
                                              + "<td><input name='txtYJSSRQ" + i + "' id='txtYJSSRQ" + i + "' type='text' size='12' " + controlReadOnly + "  value='" + sdr["YJSSRQ"].ToString() + "'/></td> "
                                              + "<td><select onchange='sszkChange(this)' name='txtSSZK" + i + "' id='txtSSZK" + i + "' " + controlDisabled + " >" + optionString + "</selected></td> "
                                              + "<td><input name='txtSSWCRQ" + i + "' id='txtSSWCRQ" + i + "' type='text' size='20' " + controlReadOnly + " value='" + sdr["SSWCRQ"].ToString() + "'/></td> "
                                              + "<td><div align='center' style='width:40px'><a href='javascript:;' onclick=\"deleteExistsRow(this)\">删除</a></div> </td>"
                                              + "</tr> ";
                i++;
            }

            txtTRLastIndex.Value = i.ToString();
        }
        dtb.InnerHtml = dtb.InnerHtml + "</table>";
        sqlcon.Close();

    }


    //上传文件
    protected void btnUpload_Click()
    {
        if (fulFj.HasFile)
        {
            String path = @"G:\数据系统附件\专项问题反馈\";
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


    //跳转到打印页面
    public void btnPrint_Click(object sender, EventArgs e)
    {
        Response.Redirect("zxwtfkPrint.aspx?xh=" + tbBH.Text + " &lb=EDIT" + "&editType=全部");
    }


    protected void tjbd_Click()
    {
        string sqlstr = "insert into js_tzxwtfk_gsdcH (BH,GSDC,FZR,YJSSRQ,SSZK,SSWCRQ) ";
        // Response.Write(Request["txtName1"].ToString() + "<br/>");
        for (int i = 1; i <= 15; i++)
        {
            if (Request["txtGSDC" + i] != null)
            {
                sqlstr = sqlstr + "select '" + xh + "'"
                                                           + ", '" + Request["txtGSDC" + i].ToString() + "'"
                                                           + ", '" + Request["txtFZR" + i].ToString() + "'"
                                                           + ", '" + Request["txtYJSSRQ" + i].ToString() + "'"
                                                           + ", '" + Request["txtSSZK" + i].ToString() + "'"
                                                           + ", '" + Request["txtSSWCRQ" + i].ToString() + "'"
                                                           + " union all ";
            }
        }

        sqlstr = sqlstr.Substring(0, sqlstr.Length - 10);


        //先删除旧数据 在插入新数据 在事务中执行
        sqlcon.Open();
        SqlTransaction sqlTran = sqlcon.BeginTransaction();
        try
        {
            string sqlstr_del = "delete from js_tzxwtfk_gsdcH where bh='" + xh + "'";
            Cmd = new SqlCommand(sqlstr_del, sqlcon);
            Cmd.Transaction = sqlTran;
            Cmd.ExecuteNonQuery();
            //如果专项改善提案的改善对策区域为空 那么sqlstr的length=52
            //改善对策不为空的区域 才可以执行insert操作
            if (sqlstr.Length != 52)
            {
                Cmd = new SqlCommand(sqlstr, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();

            }
            sqlTran.Commit();

        }
        catch (Exception exp)
        {
            Response.Write(exp.Message);
            //  sqlTran.Rollback();
        }
        finally
        {
            sqlcon.Close();
            sqlTran.Dispose();
        }


        //刷新数据
        getGSDC();




    }


    //新增时设置默认值,如没有可注释
    public void setDefault()
    {
        DateTime dtSysDate = DateTime.Now;
        tbRQ.Text = dtSysDate.ToShortDateString();
        tbFqrhqsj.Text = dtSysDate.ToShortDateString();
        //编号  年+月+001
        String sqlStr = "select 'ZX'+csr_init + replicate('0', 4 - len(max_init)) + cast(max_init as varchar(4)) bh"
                      + "   from   ( select    substring(convert(nvarchar(4), getdate(), 112), 1, 6 ) csr_init ,"
                      + "                      case when max(bh) is null then '001' else cast(substring(max(bh), 7,4) as int) + 1 end max_init "
                      + "            from      js_tzxwtfkH "
                      + "          ) A";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                tbBH.Text = sdr["bh"].ToString();
            }
        }
        // tbDjcsy.Text = "1";
        tbLchqzt.Text = "质量经理审核中";
        sdr.Close();
        sqlcon.Close();
    }

    //退回处理
    public void thcl()
    {
        //退回部门不为空 那么进行流程变更处理
        ddlFxr.Items.Add(" ");
        ddlZlbjl.Items.Add(" ");
        ddlFxrsh.Items.Add(" ");
        ddlZlbqrr.Items.Add(" ");
        if (ddlThbm.Text.Equals("质量部经理"))
        {
            ddlZlbjl.Text = " ";
            ddlZLBJLHQZT.Text = "会签中";
            ddlFxr.Text = " ";
            ddlFXRHQZT.Text = "-";
            ddlFxrsh.Text = " ";
            ddlFXRSHHQZT.Text = "-";
            ddlZlbqrr.Text = " ";
            ddlZLBQRRHQZT.Text = "-";
            tbLchqzt.Text = "退回单据(质量部经理重新评审)";
        }
        else if (ddlThbm.Text.Equals("分析人"))
        {
            ddlFxr.Text = " ";
            ddlFXRHQZT.Text = "会签中";
            ddlFxrsh.Text = " ";
            ddlFXRSHHQZT.Text = "-";
            ddlZlbqrr.Text = " ";
            ddlZLBQRRHQZT.Text = "-";
            tbLchqzt.Text = "退回单据(分析人重填)";
        }
        else if (ddlThbm.Text.Equals("分析人审核"))
        {
            ddlFxrsh.Text = " ";
            ddlFXRSHHQZT.Text = "会签中";
            ddlZlbqrr.Text = " ";
            ddlZLBQRRHQZT.Text = "-";
            tbLchqzt.Text = "退回单据(分析人审核重填)";
        }
    }


    protected void btnTj_Click(object sender, EventArgs e)
    {

        if (Session["username"].ToString().Trim() == ddlFxr.Text.Trim() || ddlFxr.Text.Trim().Equals(""))
        {
            tjbd_Click();
        }
        if (!ddlThbm.Text.Equals("-")) { thcl(); }//执行退回处理


        // 如果控件非空，那么上传文件
        if (fulFj.HasFile)
        {
            btnUpload_Click();
        }


        if (Page.IsValid)//自定义验证控件有效后才能进行剩余操作
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

            if ("ADD" == lb)
            {
                if (addData())
                {
                    Response.Redirect("zxwtfkList.aspx");
                }
            }
            else if ("EDIT" == lb)
            {
                if (editData())
                { //编辑数据成功后
                    //Response.Write("<script>alert('提交成功!');</script>");

                    Response.Redirect("zxwtfkList.aspx");
                }
            }
        }


    }


    //判断控件的可编辑情况
    public void controlEnable()
    {
        sqlcon.Open();
        String sqlstr = "select lx,mc,case when '" + editType + "'='会签中' or '" + editType + "' = '' then dbo.js_func_hasgroup(djmc,'" + Session["UserName"] + "','',qx) else 0 end qx from dbo.js_controlEnable where djmc='专项问题反馈'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                if ("TEXTBOX" == sdr["lx"].ToString())
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
        sdr.Close();

        //特殊控件需要只读，但是仍旧是readonly的
        //controlReadOnly();

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
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '专项问题反馈' and charindex('发起人',qx)>0 ";
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
        addSQLSring = "insert into js_tzxwtfkH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_tzxwtfkH";
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
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '专项问题反馈' ";
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
        sqlstr = "select * from dbo.js_tzxwtfkH where bh='" + xh + "'";
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
        String sqlstr = " select  mc,lx,zd from    dbo.js_controlEnable where   djmc = '专项问题反馈'"
                      + " and dbo.js_func_hasgroup('专项问题反馈','" + Session["UserName"] + "','',qx)=1 ";
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
        editSQLSring = "update js_tzxwtfkH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        result = true;
        return result;
    }


    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        sqlcon.Open();
        string fzr = args.Value;
        string sqlstr = "select * from dbo.STUsers where UserName='" + fzr + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        int count = Convert.ToInt32(Cmd.ExecuteScalar());
        if (count > 0)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
        sqlcon.Close();
    }
}
