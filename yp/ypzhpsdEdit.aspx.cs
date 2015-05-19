﻿using System;
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
using System.Text.RegularExpressions;

public partial class ypzhpsdEdit : System.Web.UI.Page {
    string UserName = "";
    string GroupNames = "";
    public string xh = "";
    string lb = "";
    string editType = "";
    string cklx = "";
    public string djlx = "";
    DataTable dt = new DataTable();
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;

    protected void Page_Load(object sender, EventArgs e) {
        /*string message = "";
        int sum=0;
        string tempStr="";
        for (int i = 1; i <= 10;i++ ){
            sum=sum+i;
            tempStr = "";
            for (int j = 0; j <= i;j++ ){
                tempStr = tempStr+ j + "+";
            }
            tempStr = tempStr.Substring(0, tempStr.Length - 1) + "=" + sum;
            sqlcon.Open();
            string sqlstr = "insert into dbo.js_shortMessage ( UserID, Message ) values  ( 'wujt', '"+tempStr+"')";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }*/
        string lcVisible = Session["GroupNames"].ToString().IndexOf("超级用户") >= 0 ? "" : "none";
        trLc1.Style.Add("display", lcVisible);
        trLc2.Style.Add("display", lcVisible);
        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"];
        editType = Request.QueryString["editType"];
        cklx = Request.QueryString["cklx"];

        zjgcs();
        //djlx = Request.QueryString["djlx"];
        //tbDjlx.Text = Request.QueryString["djlx"];
        if (!IsPostBack) {

            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            ViewState["dt"] = dt;
            if (Session["username"] != null) {
                ddlXsry.Items.Add(Session["username"].ToString());
                ddlXsjl.Items.Add("");
                ddlXsjl.Items.Add(Session["username"].ToString());
                ddlSwjl.Items.Add("");
                ddlSwjl.Items.Add(Session["username"].ToString());
                ddlZg.Items.Add("");
                ddlZg.Items.Add(Session["username"].ToString());
                ddlZz.Items.Add("");
                ddlZz.Items.Add(Session["username"].ToString());
                ddlDx.Items.Add("");
                ddlDx.Items.Add(Session["username"].ToString());
                ddlPack.Items.Add("");
                ddlPack.Items.Add(Session["username"].ToString());
                ddlSys.Items.Add("");
                ddlSys.Items.Add(Session["username"].ToString());

                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupNames = Session["GroupNames"].ToString();

            }
            else {
                Response.Redirect("Login.aspx");
            }
            //sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString); 
            controlEnable();
            if ("ADD" == lb) {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb.Trim()) {
                getData();
            }
            if ("COPY" == lb.Trim()) {
                getData();
                setCopy();
            }


            //当有发起人权限而没有无限制组权限时，激活限制项目
            if (!(GroupNames.IndexOf("样品综合评审单-销售人员") < 0) && (GroupNames.IndexOf("样品综合评审单-无限制组") < 0)) {
                RangeValidator1.Enabled = true;
                CustomValidator1.Enabled = true;
            }
        }
    }

    protected void btnTj_Click(object sender, EventArgs e) {
        if (Session["username"] != null) {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupNames = Session["GroupNames"].ToString();
        }
        else {
            Response.Redirect("Login.aspx");
        }


        // 如果控件非空，那么上传文件
        if (fulFj.HasFile) {
            btnUpload_Click();
        }

        if (Page.IsValid) {
            //选择退回到业务员
            if ("是" == ddlSfxyth.Text) {
                tdcl();
                Response.Redirect("ypzhpsdList.aspx");
            }
            if ("ADD" == lb || "COPY" == lb) {
                if (addData()) {
                    Response.Redirect("ypzhpsdList.aspx");
                }
            }
            else if ("EDIT" == lb) {
                if (editData()) { //编辑数据成功后
                    //Response.Write("<script>alert('提交成功!');</script>");
                    Response.Redirect("ypzhpsdList.aspx");
                }
            }
        }

    }

    public void zjgcs() {
        sqlcon.Open();
        String sqlstr = "";

        string zjgcs = ddlZjgcs.Text;
        string zjdxgcs = ddlZjdxgcs.Text;

        //电芯填写的信息行给PACK显示
        if (Session["GroupNames"].ToString().IndexOf("PACK工程师") < 0 || Session["GroupNames"].ToString().IndexOf("超级用户") < 0 || Session["GroupNames"].ToString().IndexOf("电芯工程师") < 0) {
            trDxxx.Style.Add("display", "none");
        }

        //填充PACK工程师
        sqlstr = "select RY from js_rsxxH a,dbo.js_rsxxB b where a.DjLsh=b.BMID and a.bm='PACK工程师'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            ddlZjgcs.Items.Clear();
            ddlZjgcs.Items.Add("请选择");
            while (sdr.Read()) {
                ddlZjgcs.Items.Add(sdr["ry"].ToString());
            }

        }
        if (lb.Equals("ADD")) {
            ddlZjgcs.Text = "宋威";
        }
        else {
            ddlZjgcs.Text = zjgcs;
        }
        sdr.Close();


        //填充电芯工程师
        sqlstr = "select RY from js_rsxxH a,dbo.js_rsxxB b where a.DjLsh=b.BMID and a.bm='产品开发工程师'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            ddlZjdxgcs.Items.Clear();
            ddlZjdxgcs.Items.Add("请选择");
            while (sdr.Read()) {
                ddlZjdxgcs.Items.Add(sdr["ry"].ToString());
            }

        }
        sdr.Close();

        //找到对应的电芯工程师
        if (lb.Equals("ADD")) {
            sqlstr = "select jsbry from dbo.js_ywydyjsbry where ywy='" + ddlXsry.Text + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    ddlZjdxgcs.Text = sdr["jsbry"].ToString();
                }

            }
        }
        else {
            ddlZjdxgcs.Text = zjdxgcs;
        }
        sqlcon.Close();
        sdr.Close();

    }

    //退单
    public void tdcl() {
        tbTdcs.Text = Convert.ToString(Convert.ToInt32(tbTdcs.Text) + 1);
        tbLsjl.Text = tbLsjl.Text + Environment.NewLine + "------------------------------------------"
            + Environment.NewLine + "第" + tbTdcs.Text + "次退单" + Environment.NewLine
            + "退单时间:" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "  退单人:" + Session["UserName"].ToString()
            + Environment.NewLine + "退单理由:" + tbTdly.Text;


        sqlcon.Open();
        string sqlstr = "update js_ypzhpsdH set xsryhqsj='',lsjl='" + tbLsjl.Text + "',tdcs='" + tbTdcs.Text + "',lchqzt='退回业务员处理' where bh='" + xh + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlstr = "insert into dbo.js_shortMessage ( UserID, Message ) select UserID,'【数据系统】您有一条样品综合评审单被退回。退单人：" + Session["UserName"].ToString() + "。退单时间:" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' from dbo.STUsers where UserName='" + ddlXsry.Text + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

    }

    //新增时设置默认值
    public void setDefault() {
        DateTime dtSysDate = DateTime.Now;
        tbJBRQ.Text = dtSysDate.ToString("yyyy-MM-dd HH:mm:ss");
        tbXsryhqsj.Text = dtSysDate.ToString("yyyy-MM-dd HH:mm:ss");
        tbLchqzt.Text = "销售经理会签中";
        tbTdcs.Text = "0";
        tbLclx.Text = "产品开发提案";
        pageShow();
        //   ddlDjlx_TextChanged
        //  ddl

    }

    //复制单据初始化
    public void setCopy() {
        DateTime dtSysDate = DateTime.Now;
        tbJBRQ.Text = dtSysDate.ToString("yyyy-MM-dd HH:mm:ss");
        tbXsryhqsj.Text = dtSysDate.ToString("yyyy-MM-dd HH:mm:ss");
        tbBh.Text = "";
        tbLchqzt.Text = "销售经理会签中";
        tbTdcs.Text = "0";
        tbLsjl.Text = "";
        String[] strTextBoxNull = new String[] { "tbXsjlhqsj", "tbSwjlhqsj","tbZghqsj","tbZzhqsj","tbDxhqsj",
                                                    "tbPackhqsj","tbSyshqsj"};
        String[] strDropDownListNull = new String[] { "ddlXsjl", "ddlXsjlhqzt",
                                                      "ddlSwjl", "ddlSwjlhqzt",
                                                      "ddlZg","ddlZghqzt",
                                                      "ddlZz","ddlZzhqzt",
                                                      "ddlDx","ddlDxhqzt",
                                                      "ddlPack","ddlPackhqzt",
                                                      "ddlSys","ddlSyshqzt"
                                                     };
        for (int i = 0; i < strTextBoxNull.Length; i++) {
            ((TextBox)FindControl(strTextBoxNull[i])).Text = "";
        }
        for (int i = 0; i < strDropDownListNull.Length; i++) {
            ((DropDownList)FindControl(strDropDownListNull[i])).SelectedIndex = 0;
        }
        //   pageShow();
        //   ddlDjlx_TextChanged
        //  ddl

    }



    //上传文件
    protected void btnUpload_Click() {
        if (fulFj.HasFile) {
            String path = @"G:\数据系统共享\";
            String actualPath = path + fulFj.FileName;
            fileName.Text = fulFj.FileName;
            try {
                fulFj.SaveAs(actualPath);
                tbURL.Text = actualPath;
                //ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('上传成功!');</script>");
            }
            catch (Exception ex) {
                String errorMessage = "<script>alert('上传失败!" + ex.Message.Replace("\r\n", "") + "');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "", errorMessage);
            }

        }

    }

    //下载文件
    protected void btnDownLoad_Click(object sender, EventArgs e) {
        if (tbURL.Text.Length > 1) {
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

    public void btnKdcx_Click(object sender, EventArgs e) {

    }
    //跳转到打印页面
    public void btnPrint_Click(object sender, EventArgs e) {
        Response.Redirect("cpkftaPrint.aspx?djlx=" + tbDjlx.Text + "xh=" + tbBh.Text + " &lb=EDIT" + "&editType=全部");
    }

    //判断控件的可编辑情况
    public void controlEnable() {
        sqlcon.Open();
        String sqlstr = "select lx,mc,case when '" + editType + "'='会签中' or '" + editType + "' = '' then dbo.js_func_hasgroup(djmc,'" + Session["UserName"] + "','',qx) else 0 end qx from dbo.js_controlEnable where djmc='样品综合评审单'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("TEXTBOX" == sdr["lx"].ToString()) {
                    //((TextBox)FindControl(sdr["mc"].ToString().Trim())).Attributes.Add("readonly","1" == sdr["qx"].ToString()?"false":"true"); 
                    ((TextBox)FindControl(sdr["mc"].ToString().Trim())).ReadOnly = !("1" == sdr["qx"].ToString());
                }
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

        if (cklx != null && cklx.Equals("查看")) {
            iBtnOK.Visible = false;
        }
    }

    //新增数据
    public Boolean addData() {
        sqlcon.Open();
        //第一步获取编号   年 + 月 + 001,002...
        //tbXsrhqsj.Text = tbJbrq.Text;
        //编号  年+月+001
        string sqlStr = "";
        if (ddlDjlx.Text.Equals("产品开发提案")) {
            sqlStr = "select 'JSTA-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                           + " from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 12, 3) as int) + 1 end max_init from   js_ypzhpsdH  "
                           + "			where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) and  substring(BH,1,4)='JSTA' "
                           + "      ) A ";
        }
        else if (ddlDjlx.Text.Equals("规格书申请单")) {
            sqlStr = "select 'JSGGS-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                          + "  from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 13, 3) as int) + 1 end max_init from   js_ypzhpsdH  "
                          + "           where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) and  substring(BH,1,5)='JSGGS' "
                          + "                   ) A ";
        }
        else if (ddlDjlx.Text.Equals("样品建议书")) {
            sqlStr = "select 'JSJYS-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                          + "  from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 13, 3) as int) + 1 end max_init from   js_ypzhpsdH  "
                          + "           where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) and  substring(BH,1,5)='JSJYS' "
                          + "                   ) A ";
        }
        Cmd = new SqlCommand(sqlStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                tbBh.Text = sdr["bh"].ToString();
            }
        }
        sdr.Close();



        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String addSQLSring = "";
        System.Text.StringBuilder zd = new System.Text.StringBuilder();
        System.Text.StringBuilder zdz = new System.Text.StringBuilder();
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '样品综合评审单' and charindex('销售人员',qx)>0 ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                zd.Append(sdr["zd"].ToString());
                zd.Append(",");
                zdz.Append("'");
                if ("TEXTBOX" == sdr["lx"].ToString()) {
                    zdz.Append(((TextBox)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOX" == sdr["lx"].ToString()) {
                    zdz.Append(((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Checked);
                }
                else if ("DROPDOWNLIST" == sdr["lx"].ToString()) {
                    zdz.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOXLIST" == sdr["lx"].ToString()) {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++) {
                        if (cblTemp.Items[i].Selected) {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    zdz.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));//全部都没勾选时 空字符串 就substring(0,0)
                }
                zdz.Append("',");
            }
        }
        sdr.Close();



        addSQLSring = "insert into js_ypzhpsdH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ",ypjys,ggsxq) select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + ",'" + rbYpjys.Text + "','" + rbGGSXQ.Text + "' from js_ypzhpsdH";
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        result = true;
        return result;
    }

    //获取数据
    public void getData() {
        //填充转交业务员列表
        //zjgcs();

        sqlcon.Open();
        //Hash表:
        //ht_zddz 字段对照 存储 前台控件和后台字段名对应关系  KEY:数据库字段名 VALUE:控件名称
        //ht_lxdz 类型对照 前台控件和控件类型对照  KEY:数据库字段名 VALUE：控件类型
        Hashtable ht_zddz = new Hashtable();
        Hashtable ht_lxdz = new Hashtable();
        //ArrayList 存储后台数据库字段名字的列表
        ArrayList listZd = new ArrayList();
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '样品综合评审单' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                listZd.Add(sdr["zd"].ToString().Trim());//将数据库字段名加入list
                ht_zddz.Add(sdr["zd"].ToString().Trim(), sdr["mc"].ToString().Trim());
                ht_lxdz.Add(sdr["zd"].ToString().Trim(), sdr["lx"].ToString().Trim());
            }
        }
        sdr.Close();
        sqlstr = "select * from dbo.js_ypzhpsdH where bh='" + xh + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {//获取数据时，只有一条数据
                //循环表的所有数据库字段
                foreach (String strZd in listZd) {
                    if ("TEXTBOX" == (string)ht_lxdz[strZd]) {//根据对照表存储的字段类型进行不同类型的转换
                        ((TextBox)FindControl((string)ht_zddz[strZd])).Text = sdr[strZd].ToString().Trim();
                    }
                    else if ("CHECKBOX" == (string)ht_lxdz[strZd]) {
                        ((CheckBox)FindControl((string)ht_zddz[strZd])).Checked = ("True" == sdr[strZd].ToString());
                    }
                    else if ("DROPDOWNLIST" == (string)ht_lxdz[strZd]) {
                        DropDownList ddlTemp = (DropDownList)FindControl((string)ht_zddz[strZd]);
                        int j = 0;
                        for (int i = 0; i < ddlTemp.Items.Count; i++) {
                            if (ddlTemp.Items[i].Text == sdr[strZd].ToString().Trim()) {
                                j = i;//把匹配到的索引赋给j
                                break;
                            }
                        }
                        if (0 == j) { //j=0说明数据库里的值没有匹配到，那么就自己把数据库的值加进去并选定
                            ddlTemp.Items.Add(sdr[strZd].ToString().Trim());
                        }
                        ddlTemp.Text = sdr[strZd].ToString().Trim();
                    }
                    else if ("CHECKBOXLIST" == (string)ht_lxdz[strZd]) {
                        CheckBoxList cblTemp = (CheckBoxList)FindControl((string)ht_zddz[strZd]);
                        //获取的值一一去匹配CHECKBOXLIST的值，若匹配上 则打勾
                        for (int i = 0; i < cblTemp.Items.Count; i++) {
                            if (sdr[strZd].ToString().Trim().IndexOf(cblTemp.Items[i].Text) != -1) {
                                cblTemp.Items[i].Selected = true;
                            }
                        }
                    }

                }
                rbYpjys.Items[0].Selected = sdr["ypjys"].ToString().Equals("要");
                rbYpjys.Items[1].Selected = sdr["ypjys"].ToString().Equals("不要");
                rbGGSXQ.Items[0].Selected = sdr["ggsxq"].ToString().Equals("要");
                rbGGSXQ.Items[1].Selected = sdr["ggsxq"].ToString().Equals("不要");
            }
        }
        sdr.Close();
        sqlcon.Close();



        lbSave.Visible = ddlSwjlhqzt.Text.Equals("-") || ddlSwjlhqzt.Text.Equals("会签中");

        EventArgs e = new EventArgs();
        ddlCpzt_SelectedIndexChanged(ddlCpzt, e);
        ddlDjlx_SelectedIndexChanged(ddlDjlx, e);
        rbYpjys_SelectedIndexChanged(rbYpjys, e);
        if (!lb.Equals("COPY")) {

            ddlDjlx.Enabled = false;

        }





        getSyjd();
        pageShow();


        //超级用户显示流程
        //trLc1.Visible = GroupNames.IndexOf("超级用户") >= 0;
        //trLc2.Visible = GroupNames.IndexOf("超级用户") >= 0;

    }


    //更新数据
    public Boolean editData() {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from    dbo.js_controlEnable where   djmc = '样品综合评审单'"
                      + " and dbo.js_func_hasgroup('样品综合评审单','" + Session["UserName"] + "','',qx)=1 ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                editEqualSql.Append(sdr["zd"].ToString());
                editEqualSql.Append("='");
                if ("TEXTBOX" == sdr["lx"].ToString()) {
                    editEqualSql.Append(((TextBox)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOX" == sdr["lx"].ToString()) {
                    editEqualSql.Append(((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Checked);
                }
                else if ("DROPDOWNLIST" == sdr["lx"].ToString()) {
                    editEqualSql.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOXLIST" == sdr["lx"].ToString()) {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++) {
                        if (cblTemp.Items[i].Selected) {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    editEqualSql.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));
                }
                editEqualSql.Append("',");
            }

        }
        editSQLSring = "update js_ypzhpsdH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + ",ypjys='" + rbYpjys.Text + "',ggsxq='" + rbGGSXQ.Text + "' "
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();


        result = true;
        return result;
    }


    public void pageShow() {
        if (tbLclx.Text.Equals("样品建议书")) {
            divNav.Visible = true;
            trKhxxGGS.Visible = true;
            //trKhxxGGS1.Visible = true;
            trZzps.Visible = true;
            lbDxsl.Visible = true;
            tbYpxx.Visible = true;
            trYqjhjq.Visible = true;
        }
        else {
            divNav.Visible = false;
            trKhxxGGS.Visible = false;
            //trKhxxGGS1.Visible = false;
            trZzps.Visible = false;
            lbDxsl.Visible = false;
            tbYpxx.Visible = false;
            // tdZg.InnerText = "总工";
            trYqjhjq.Visible = false;
        }


        if (tbLclx.Text.Equals("产品开发提案")) {
            trGcsps.Visible = false;
            trGGS1.Visible = false;
            trGGS2.Visible = false;
            trGGS4.Visible = false;
            trPackgcs.Visible = false;
            trScqj.Visible = true;
            trScqjnr.Visible = true;
        }
        else {
            trGcsps.Visible = true;
            trGGS1.Visible = true;
            trGGS2.Visible = true;
            trGGS4.Visible = true;
            trPackgcs.Visible = true;
            trScqj.Visible = false;
            trScqjnr.Visible = false;
        }

        if (tbLclx.Text.Equals("规格书") && !ddlDjlx.Text.Equals("产品开发提案")) {

            trKhxxKhxh.Visible = false;
            trUlxx.Visible = false;
            trZyx.Visible = false;
        }
        else {
            trKhxxKhxh.Visible = true;
            trUlxx.Visible = true;
            trZyx.Visible = true;
        }

        //开发提案  业务不能填写内部型号 由实验室填写
        if (ddlDjlx.Text.Equals("产品开发提案")) {
            tbNbxh.ReadOnly = !(GroupNames.IndexOf("样品综合评审单-实验室审核") > 0);
            RequiredFieldValidator14.Enabled = GroupNames.IndexOf("样品综合评审单-实验室审核") > 0;
        }
        else {
            tbNbxh.ReadOnly = false;
            RequiredFieldValidator14.Enabled = true;
        }

    }


    protected void cblYpjys_SelectedIndexChanged(object sender, EventArgs e) {
        if (ddlDjlx.Text.Equals("产品开发提案")) {

            setLclx();
        }
    }
    protected void cblGgsxq_SelectedIndexChanged(object sender, EventArgs e) {
        if (ddlDjlx.Text.Equals("产品开发提案")) {
            setLclx();
        }
    }

    //设置
    public void setLclx() {
        /*if (cblGgsxq.Items[0].Selected) {
            //同时需要样品建议书
            if (cblYpjys.Items[0].Selected) {

                tbLclx.Text = "样品建议书";
            }
            else {
                tbLclx.Text = "规格书";
            }
        }
        else {
            if (cblYpjys.Items[0].Selected) {
                tbLclx.Text = "样品建议书";
            }
            else {
                tbLclx.Text = "产品开发提案";
            }
        }*/
        if (rbGGSXQ.Text.Equals("要")) {
            //同时需要样品建议书
            if (rbYpjys.Text.Equals("要")) {
                tbLclx.Text = "样品建议书";
            }
            else {
                tbLclx.Text = "规格书";
            }
        }
        else {
            if (rbYpjys.Text.Equals("要")) {
                tbLclx.Text = "样品建议书";
            }
            else {
                tbLclx.Text = "产品开发提案";
            }
        }
        pageShow();
    }


    //自定义验证
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args) {
        if (ddlDjlx.Text.Equals("样品建议书")) {
            sqlcon.Open();
            string dxxh = args.Value;
            string errorMessage = "";
            string sqlstr = "select count(*) from dbo.js_ypzhpsdH where ZZDXXH='" + dxxh + "' or ZZPACKXH='" + dxxh + "'";
            int count = -1;
            //单据类型样品建议书且出货方式不为PACK的需要验证是否存在该电芯型号 
            if (ddlCpzt.Text.Equals("电芯")) {
                Cmd = new SqlCommand(sqlstr, sqlcon);
                count = Convert.ToInt32(Cmd.ExecuteScalar());
                if (count > 0) {
                    args.IsValid = true;
                }
                else {
                    args.IsValid = false;
                    errorMessage = "该型号未曾开发过，请于技术部沟通确认，或返回“添加单据”界面查询已开发或相近的型号";

                    /*string xh = GetNumber(tbNbxh.Text.Substring(0, 8)).ToString();
                    if (xh.Length == 6) {
                        string CD = xh.Substring(0, 2).Replace("A", "10").Replace("A", "10").Replace("B", "11").Replace("C", "12").Replace("D", "13").Replace("E", "14").Replace("F", "15");
                        string KD = xh.Substring(2, 2).Replace("A", "10").Replace("A", "10").Replace("B", "11").Replace("C", "12").Replace("D", "13").Replace("E", "14").Replace("F", "15");
                        string HD = xh.Substring(4, 2).Replace("A", "10").Replace("A", "10").Replace("B", "11").Replace("C", "12").Replace("D", "13").Replace("E", "14").Replace("F", "15");
                        sqlstr = "select stuff((select '\\n' + 电芯型号+ ','+bcrl+','+zxrl from ( select distinct 电芯型号,'标称容量:'+convert(varchar(200),[标称容量（mAh）]) bcrl,'最小容量:'+convert(varchar(200),[最小容量（mAh）]) zxrl from dbo.['电芯规格表 $'] " +
                               " where 电芯型号 is not null ) a where (" + CD + "<=substring(电芯型号,3,2)+5 and " + CD + ">=substring(电芯型号,3,2)-5) " +
                               " and (" + KD + "<=substring(电芯型号,5,2)+5 and " + KD + ">=substring(电芯型号,5,2)-5) " +
                               " and (" + HD + "<=dbo.js_func_replaceStr(substring(电芯型号,7,2))+5 and " + HD + ">=dbo.js_func_replaceStr(substring(电芯型号,7,2))-5)  for xml path('')),1,1,'') xh";
                        Cmd = new SqlCommand(sqlstr, sqlcon);
                        sdr = Cmd.ExecuteReader();
                        if (sdr.HasRows) {
                            while (sdr.Read()) {
                                errorMessage = "无该内部型号的电芯，请将单据变更为开发提案，\\n 系统为您找到相近的电芯型号：\\n" + sdr["xh"].ToString();
                            }
                        }
                    }*/

                }
            }



            //针对免费样品 有2种情况不能提交
            //1.同客户同型号免费样品相隔15天内，不能提交。  销售经理会签中表明为新建的单子 只有新建的时候需要验证
            if (args.IsValid && ddlXsjlhqzt.Text.Equals("会签中")) {
                if (tbBh.Text.Equals("")) {
                    sqlstr = "select count(*) from dbo.js_ypzhpsdH where JBRQ>getdate()-15 and KHDM='" + tbKhdm.Text + "'  and DJLX='样品建议书' and NBXH= '" + dxxh + "' and lchqzt<>'业务员保存' and lchqzt<>'单据已终止' ";
                }
                //有编号的要排除自己
                else {
                    sqlstr = "select count(*) from dbo.js_ypzhpsdH where JBRQ>getdate()-15 and KHDM='" + tbKhdm.Text + "'  and DJLX='样品建议书' and NBXH= '" + dxxh + "' and lchqzt<>'业务员保存' and lchqzt<>'单据已终止' and bh<>'" + tbBh.Text + "' ";

                }
                Cmd = new SqlCommand(sqlstr, sqlcon);
                count = Convert.ToInt32(Cmd.ExecuteScalar());
                if (count >= 1) {
                    args.IsValid = false;
                    errorMessage = "同客户同型号样品相隔15天内，不能提交";
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + errorMessage + "')</script>");
                }
                else {
                    args.IsValid = true;
                }
            }


            //2.客户代码后增加“合作关系”选项（已合作/未合作），必填。控制“未合作”客户最多只有5次免费样品机会，第6次开始免费样品单不能提交。
            if (args.IsValid) {
                sqlstr = "select count(*) from dbo.js_ypzhpsdH where DJLX='样品建议书' and SFQK='免费样品' and HZGX='未合作' and KHDM='" + tbKhdm.Text + "' and lchqzt<>'业务员保存' and lchqzt<>'单据已终止' ";
                Cmd = new SqlCommand(sqlstr, sqlcon);
                count = Convert.ToInt32(Cmd.ExecuteScalar());
                if (count > 5) {
                    args.IsValid = false;
                    errorMessage = "未合作的客户最多只有5次免费送样机会，多于5次请选择收费样品";
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + errorMessage + "')</script>");
                }
                else {
                    args.IsValid = true;
                }
            }



            sqlcon.Close();



        }
    }

    //提取数字部门 例如FT302040P提取成302040
    public static decimal GetNumber(string str) {
        decimal result = 0;
        if (str != null && str != string.Empty) {
            // 正则表达式剔除非数字字符（不包含小数点.）
            str = Regex.Replace(str, @"[^\d.\d]", "");
            // 如果是数字，则转换为decimal类型
            if (Regex.IsMatch(str, @"^[+-]?\d*[.]?\d*$")) {
                result = decimal.Parse(str);
            }
        }
        return result;
    }
    /*protected void tbNbxh_TextChanged(object sender, EventArgs e) {
        if (ddlDjlx.Text.Equals("样品建议书")) {
            sqlcon.Open();
            string sqlstr = "select top 1 [标称容1量（mAh）] bcrl,[最小容量（mAh）] zxrl,[极耳中心距（±2)] jezxj,极耳宽度 jekd,[厚度（MAX）] hd, " +
                 "[宽度（MAX）] kd,[高度（MAX）] gd,[电芯内阻(mΩ)] nz from dbo.['电芯规格表 $'] where 电芯型号='" + tbNbxh.Text + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    if (tbBcrl.Text.Equals("")) {
                        tbBcrl.Text = sdr["bcrl"].ToString();
                    }
                    if (tbZxrl.Text.Equals("")) {
                        tbZxrl.Text = sdr["zxrl"].ToString();
                    }
                    if (tbJezxj.Text.Equals("")) {
                        tbJezxj.Text = sdr["jezxj"].ToString();
                    }
                    if (tbJekd.Text.Equals("")) {
                        tbJekd.Text = sdr["jekd"].ToString();
                    }

                    if (tbCCH.Text.Equals("")) {
                        tbCCH.Text = sdr["hd"].ToString();
                    }
                    if (tbCCK.Text.Equals("")) {
                        tbCCK.Text = sdr["kd"].ToString();
                    }
                    if (tbCCC.Text.Equals("")) {
                        tbCCC.Text = sdr["gd"].ToString();
                    }
                    if (tbNz.Text.Equals("")) {
                        tbNz.Text = sdr["nz"].ToString();
                    }
                }
            }
            sqlcon.Close();
        }
    }*/
    protected void rbYpjys_SelectedIndexChanged(object sender, EventArgs e) {
        if (ddlDjlx.Text.Equals("产品开发提案")) {
            setLclx();
        }
    }
    protected void lbSave_Click(object sender, EventArgs e) {
        if (Session["username"] != null) {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupNames = Session["GroupNames"].ToString();
        }
        else {
            Response.Redirect("Login.aspx");
        }


        // 如果控件非空，那么上传文件
        if (fulFj.HasFile) {
            btnUpload_Click();
        }

        if ("是" == ddlSfxyth.Text) {
            tdcl();
            Response.Redirect("ypzhpsdList.aspx");
        }
        if (ddlXsjlhqzt.Text.Equals("会签中")) {
            tbLchqzt.Text = "业务员保存";
            tbXsryhqsj.Text = "";
            ddlXsjlhqzt.Text = "-";
        }
        if ("ADD" == lb || "COPY" == lb) {
            if (addData()) {
                Response.Redirect("ypzhpsdEdit.aspx?xh=" + tbBh.Text + " &lb=EDIT" + "&editType=会签中");
            }
        }
        else if ("EDIT" == lb) {
            if (editData()) { //编辑数据成功后
                //Response.Write("<script>alert('提交成功!');</script>");
                Response.Redirect("ypzhpsdEdit.aspx?xh=" + tbBh.Text + " &lb=EDIT" + "&editType=会签中");
            }
        }

    }
    protected void ddlDjlx_SelectedIndexChanged(object sender, EventArgs e) {
        if (ddlDjlx.Text.Equals("产品开发提案")) {
            tbLclx.Text = "产品开发提案";
            //  cblQtdj.Visible = true;
            //cblYpjys.Visible=true;
            //cblGgsxq.Visible = true;
            rbYpjys.Visible = true;
            RequiredFieldValidator66.Enabled = true;
            tdZg.InnerText = "总工";

            tbNbxh.ReadOnly = !(GroupNames.IndexOf("样品综合评审单-实验室审核") > 0);
        }
        else {
            //   cblQtdj.Visible = false;
            //   cblQtdj.Items[0].Selected = false;
            //   cblQtdj.Items[1].Selected = false;
            // cblYpjys.Visible = false;
            // cblYpjys.Visible = false;
            // cblYpjys.Items[0].Selected = false;
            // cblYpjys.Items[1].Selected = false;
            // cblGgsxq.Items[0].Selected = false;
            // cblGgsxq.Items[1].Selected = false;
            rbYpjys.Visible = false;

            RequiredFieldValidator66.Enabled = false;
            tdZg.InnerText = "总负责人";
            tbNbxh.ReadOnly = false;
        }

        if (ddlDjlx.Text.Equals("样品建议书")) {
            tbLclx.Text = "样品建议书";
            trKhxxGGS1.Visible = true;
            trXh.Visible = false;
        }
        else {
            trKhxxGGS1.Visible = false;
            trXh.Visible = true;
        }

        if (ddlDjlx.Text.Equals("规格书申请单")) {
            divYpjys.Visible = false;
            divGgs.Visible = false;
            tbLclx.Text = "规格书";
        }
        else {
            divYpjys.Visible = true;
            divGgs.Visible = true;
        }

        pageShow();
    }
    protected void ddlCpzt_SelectedIndexChanged(object sender, EventArgs e) {
        if (ddlCpzt.Text.Equals("电芯")) {
            //样品建议书 实验室填写型号
            if (ddlDjlx.Text.Equals("样品建议书"))
                trXh.Visible = false;

            tablePackyq.Visible = false;
        }
        else {
            tablePackyq.Visible = true;

            if (ddlDjlx.Text.Equals("样品建议书"))
                trXh.Visible = true;
        }
    }


    //编辑数据时获取实验进度
    public void getSyjd() {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = "select TABH,SZSL,FZR,RQ,SYJD from dbo.js_syjdbH where TABH='" + tbBh.Text.Trim() + "' order by convert(datetime,rq)";
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_syjdbH");

        GridView1.DataSource = myds;
        GridView1.DataBind();
        sqlcon.Close();
    }


    //“已合作”“未合作”不要业务员填写，在填写“客户代码”时自动判断（该客户代码在“客户代码表”中有为“已合作”）
    protected void tbKhdm_TextChanged(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "select count(*) from dbo.js_khbmH where KHDM='" + tbKhdm.Text + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        if (Convert.ToInt32(Cmd.ExecuteScalar()) > 0) {
            ddlHzgx.SelectedIndex = 1;//1 已合作
        }
        else {
            ddlHzgx.SelectedIndex = 2;//2 未合作
        }
        sqlcon.Close();
    }

    /*
     “制作情况”选择“无库存需制样”时，系统发出提醒邮件（单次提醒）
       提醒人：业务员、商务、电芯工程师（PACK工程师），总负责人
       邮件主题：FT303066P(型号)样品“无库存需制样”提醒
       邮件正文：
               单号****：
                   制作情况：无库存需制样
                   实验室评审交期：*****
     
     */
    protected void ddlZzqk_SelectedIndexChanged(object sender, EventArgs e) {
        /*if (ddlZzqk.Text.Equals("无库存需制样") && tbLchqzt.Text.Equals("实验室会签中")) {
            sqlcon.Open();
            string sqlstr = "insert into scm_data.dbo.Mail_MailRH ( DjLsh ,ServerSerialNumber  ,SenderAddress , RecipientAddress , "
                        + "  subject ,content ,MailType ,MailEncoding ,SendState ,CreateTime , UPdateTime ,ApplicationNumber ,CreateID )"
                        + " select  max(djlsh)+1 ,'02' , 'jswlsj@ftjt.net' , (select UserDesc from dbo.STUsers where UserName='" + ddlXsry.Text + "' ),'"+tbNbxh.Text+"样品【无库存需制样】提醒' , "
                        + "'<div>单号："+tbBh.Text+"</div><div>制作情况:无库存需制样</div><div>实验室评审交期:"+tbSwyjjq.Text+"</div>' , 'TEXT','GB2312' ,0, getdate(),getdate(),'Js_MM',147 "
                        + " from scm_data.dbo.Mail_MailRH";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();

        
        }*/
        if (ddlZzqk.Text.Equals("无库存需制样") && tbLchqzt.Text.Equals("实验室会签中")) {
            sqlcon.Open();
            string sqlstr = " insert into dbo.js_shortMessage ( UserID, Message ) "
                           + " select UserID,'【数据系统】【样品单】无库存需制样提醒:('+'"+tbNbxh.Text+"'+')'+'无库存需制样,实验室评审交期:'+'"+tbSwyjjq.Text+"' from dbo.STUsers where UserName='" + ddlXsry.Text.Trim() + "' "
                           + " union all "
                           + " select UserID,'【数据系统】【样品单】无库存需制样提醒:('+'" + tbNbxh.Text + "'+')'+'无库存需制样,实验室评审交期:'+'" + tbSwyjjq.Text + "' from dbo.STUsers where UserName='" + ddlSwjl.Text.Trim() + "' ";
            if (!ddlDx.Text.Trim().Equals("")) {
                sqlstr = sqlstr + " union all "
                       + " select UserID,'【数据系统】【样品单】无库存需制样提醒:('+'" + tbNbxh.Text + "'+')'+'无库存需制样,实验室评审交期:'+'" + tbSwyjjq.Text + "' from dbo.STUsers where UserName='" + ddlDx.Text.Trim() + "' ";

            }
            if (!ddlPack.Text.Trim().Equals("")) {
                sqlstr = sqlstr + " union all "
                       + " select UserID,'【数据系统】【样品单】无库存需制样提醒:('+'" + tbNbxh.Text + "'+')'+'无库存需制样,实验室评审交期:'+'" + tbSwyjjq.Text + "' from dbo.STUsers where UserName='" + ddlPack.Text.Trim() + "' ";

            }
            if (!ddlZg.Text.Trim().Equals("")) {
                sqlstr = sqlstr + " union all "
                                + " select UserID,'【数据系统】【样品单】无库存需制样提醒:('+'" + tbNbxh.Text + "'+')'+'无库存需制样,实验室评审交期:'+'" + tbSwyjjq.Text + "' from dbo.STUsers where UserName='" + ddlZg.Text.Trim() + "' ";

            }

            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }

    }

    /*增加一个“物料未到延期”的选项或勾选（实验室填，放在交期附近），同时显示在list中，勾选后通过短信发送给业务员让其知晓。
    短信内容：FT303066P(型号)的样品制作交期有延迟，请知悉。*/
    protected void cbWlwdyq_CheckedChanged(object sender, EventArgs e) {
        if (cbWlwdyq.Checked) {
            sqlcon.Open();
            string sqlstr = "    insert into dbo.js_shortMessage ( UserID, Message ) "
                         + "     select (select UserID from dbo.STUsers where UserName='" + ddlXsry.Text + "'),'" + tbNbxh.Text + "的样品制作交期有延迟，请知悉。' ";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }
    }
}
