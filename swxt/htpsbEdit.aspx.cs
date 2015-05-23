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

public partial class htpsbEdit : System.Web.UI.Page {
    string lb = "";
    string bh = "";
    string editType = "";
    string bb = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {
        editType = Request.QueryString["editType"];
        bh = Request.QueryString["bh"];
        lb = Request.QueryString["lb"];
        
        if (!IsPostBack) {
            bb = Request.QueryString["bb"];
            if (Session["username"] != null) {
                tbUserName.Text = Session["username"].ToString();
                tbGroupName.Text = Session["groupnames"].ToString();
            }
            if ("ADD" == lb) {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb.Trim() || "CHANGE" == lb.Trim()) {
                getData();
                //先获取最大版本，之后填充之前的版本,即假如当前版本为1.3  需要往列表里加上1.2 1.1 1.0
                if ("EDIT" == lb.Trim()) {
                    string curBB = ddlBB.Text;
                    sqlcon.Open();
                    string sqlstr = "select max(bb) maxbb from dbo.v_htpsb where bh='" + bh + "'";
                    Cmd = new SqlCommand(sqlstr, sqlcon);
                    double maxBB = Convert.ToDouble(Cmd.ExecuteScalar());
                    sqlcon.Close();
                    ddlBB.Items.Clear();
                    while (maxBB >= 0.95) {
                        ddlBB.Items.Add(maxBB.ToString("0.0"));
                        maxBB = maxBB - 0.1;
                    }
                    ddlBB.SelectedValue = curBB;
                }
                //变更设置
                if ("CHANGE" == lb.Trim()) {

                    setChange();
                }
            }

        }
        controlEnable();

    }

    public void setDefault() {
        DateTime dt = DateTime.Now;
        tbBh.Text = "HT" + dt.ToString("yyyyMMddHHmmss");
        tbZbr.Text = Session["username"].ToString();
        tbJbrq.Text = dt.ToString("yyyy-MM-dd");
        ddlBB.Items.Add("1.0");
    }


    //发起人不通过变更可以更改某些基本信息而不改变流程
    //将不允许发起人变更的内容做禁用
    public void setFqrControlEnable() {
        for (int i = 0; i < this.Controls.Count; i++) {
            foreach (System.Web.UI.Control control in this.Controls[i].Controls) {
                if (control is TextBox)
                    (control as TextBox).Text = "";
            }
        }
        foreach (Control cl in this.Page.FindControl("Form1").Controls) {
            if (cl.GetType().ToString() == "System.Web.UI.WebControls.TextBox") {
                ((TextBox)cl).Text = "";
            }
        }
    }

    //变更相关设置
    public void setChange() {
        Double bb = Convert.ToDouble(ddlBB.Text.ToString());
        bb = bb + 0.1;//版本+0.1
        ddlBB.Items.Clear();
        ddlBB.Items.Add(bb.ToString());
        ddlBgly.SelectedIndex = 0;
        CompareValidator9.Enabled = true;
        CompareValidator10.Enabled = true;
        RequiredFieldValidator17.Enabled = true;
        tbChangeControl.Text = "";
    }

    //清空流程
    public void resetWorkFlow() {
        ddlPMCpsjg.SelectedIndex = 0;
        ddlPMChqzt.SelectedIndex = 0;

        ddlGcpsjg.SelectedIndex = 0;
        ddlGchqzt.SelectedIndex = 0;

        ddlPACKpsjg.SelectedIndex = 0;
        ddlPACKhqzt.SelectedIndex = 0;

        ddlGylpsjg.SelectedIndex = 0;
        ddlGylhqzt.SelectedIndex = 0;

        ddlSbpsjg.SelectedIndex = 0;
        ddlSbhqzt.SelectedIndex = 0;

        ddlZlpsjg.SelectedIndex = 0;
        ddlZlhqzt.SelectedIndex = 0;

        ddlZzpsjg.SelectedIndex = 0;
        ddlZzhqzt.SelectedIndex = 0;

        ddlSczjpsjg.SelectedIndex = 0;
        ddlSczjhqzt.SelectedIndex = 0;

        ddlZgpsjg.SelectedIndex = 0;
        ddlZghqzt.SelectedIndex = 0;

        ddlSwjlpsjg.SelectedIndex = 0;
        ddlSwjlhqzt.SelectedIndex = 0;


        tbPsjl.Text = "";
    }

    //变更后执行日志操作
    public bool change() {
        bool result = false;
        try {
            string sqlstr = "js_sp_htpsb_change";
            sqlcon.Open();
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.CommandType = CommandType.StoredProcedure;
            Cmd.Parameters.Add("@bh", SqlDbType.VarChar, 30);
            Cmd.Parameters.Add("@bb", SqlDbType.VarChar, 30);
            Cmd.Parameters.Add("@bgr", SqlDbType.VarChar, 30);
            Cmd.Parameters.Add("@bgly", SqlDbType.VarChar, 30);
            Cmd.Parameters.Add("@bgsm", SqlDbType.VarChar, 30);
            Cmd.Parameters["@bh"].Value = tbBh.Text;
            Cmd.Parameters["@bb"].Value = ddlBB.Text;
            Cmd.Parameters["@bgly"].Value = ddlBgly.Text;
            Cmd.Parameters["@bgsm"].Value = tbBgsm.Text;
            Cmd.Parameters["@bgr"].Value = Session["username"].ToString();
            Cmd.Parameters.Add("@errorMessage", SqlDbType.VarChar, 200);
            Cmd.Parameters.Add("@lsls", SqlDbType.VarChar, 800);
            Cmd.Parameters["@errorMessage"].Direction = ParameterDirection.Output;
            Cmd.Parameters["@lsls"].Direction = ParameterDirection.Output;
            SqlDataReader sdr = Cmd.ExecuteReader();
            sqlcon.Close();
            //3.2 若变更记录不为空，先获取历史信息在进行编辑操作editData
            if (Cmd.Parameters["@errorMessage"].Value.Equals("Pass")) {
                tbLsls.Text = Cmd.Parameters["@lsls"].Value.ToString();
                result = editData();

            }
            //3.1 若变更记录为空，则表明未变更信息，版本退化到上一版，并作编辑editData
            else if (Cmd.Parameters["@errorMessage"].Value.Equals("Back")) {
                double preBB = Convert.ToDouble(ddlBB.Text) - 0.1;
                ddlBB.Items.Clear();
                ddlBB.Items.Add(preBB.ToString("0.0"));
                result = editData();
            }
            else {
                ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + Cmd.Parameters["@errorMessage"].Value.ToString().Replace("'", "") + "')</script>");
            }


        }
        catch (Exception e) {
            //变更出错,删除变更版本
            if (sqlcon.State != ConnectionState.Open) {
                sqlcon.Open();
            }
            string sqlstr = "delete from js_htpsbH where bh='" + tbBh.Text + "' and bb='" + ddlBB.Text + "'";
            SqlCommand delCmd = new SqlCommand(sqlstr, sqlcon);
            delCmd.ExecuteNonQuery();
            Response.Write("<script>alert('变更程序出错,请联系管理员," + e.Message.Replace("'", "") + "')</script>");
        }
        finally {
            sdr.Close();
        }
        return result;
    }

    #region 增删改基本
    //判断控件的可编辑情况
    public void controlEnable() {
        if (editType != null && editType.Equals("1")) { //editType不能传中文,用1替代编辑
            editType = "编辑";
        }

        sqlcon.Open();
        String sqlstr = "select lx,mc,case when '" + editType + "'='编辑' or '" + editType + "' = '' then dbo.js_func_hasgroup(djmc,'" + Session["UserName"] + "','',qx) else 0 end qx from dbo.js_controlEnable where djmc='合同评审表'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("TEXTBOX" == sdr["lx"].ToString()) {
                    //((TextBox)FindControl(sdr["mc"].ToString().Trim())).Attributes.Add("readonly","1" == sdr["qx"].ToString()?"false":"true"); 
                    ((TextBox)FindControl(sdr["mc"].ToString().Trim())).ReadOnly = !("1" == sdr["qx"].ToString());
                }
                else if ("DROPDOWNLIST" == sdr["lx"].ToString()) {
                    string ddlVaule = ((DropDownList)FindControl(sdr["mc"].ToString().Trim())).SelectedValue;
                    if ("1" != sdr["qx"].ToString() && !sdr["mc"].Equals("ddlBB")) {
                        //只读的，只保留默认项目,除字段BB之外
                        ((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Items.Clear();
                        ((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Items.Add(ddlVaule);
                    }
                    //((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Enabled = ();

                   
                }
                else if ("CHECKBOX" == sdr["lx"].ToString())
                    ((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                else if ("CHECKBOXLIST" == sdr["lx"].ToString())
                    ((CheckBoxList)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
            }
        }
        sqlcon.Close();
        sdr.Close();

        ddlBB.Enabled = true;

        if (ddlBB.SelectedIndex != 0) {
            lbSubmit.Visible = false;
        }
        else {
            lbSubmit.Visible = true;
        }

        if (editType != null && editType.Equals("查看")) {
            lbSubmit.Visible = false;
        }
    

        //当前会签人员着色
        if (tbGroupName.Text.IndexOf("合同评审表-PMC审核") > 0) {
            divPMChq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-工程部审核") > 0) {
            spanGchq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-设备部审核") > 0) {
            spanSbhq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-制造部审核") > 0) {
            spanZzhq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-质量部审核") > 0) {
            spanZlhq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-PACK审核") > 0) {
            spanGchq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-供应链审核") > 0) {
            spanZlhq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-生产总监审核") > 0) {
            tbSczjbz.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFCC");
            liSczjhq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-总工审核") > 0) {
            tbZgbz.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFCC");
            liZghq.Style.Add("background-color", "#FFFFCC");
        }
        else if (tbGroupName.Text.IndexOf("合同评审表-商务经理审核") > 0) {
            tbSwjlbz.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFCC");
            liSwjlhq.Style.Add("background-color", "#FFFFCC");
        }

        //商务经理不能提前会签
        if (!ddlSwjlhqzt.Text.Equals("会签中")) {
            tbSwjlbz.ReadOnly = true;
            ddlSwjlpsjg.Enabled = false;
        }

        //流程会签部分除了发起人不能看到
        if (tbGroupName.Text.IndexOf("合同评审表-发起人") >= 0 || tbGroupName.Text.IndexOf("超级用户") >= 0) {
            aShowLc.Style.Add("display", "");
        }

        //变更的单据，变更的控件需要变色
        if (!tbChangeControl.Text.Equals("")) {
            string[] controls = tbChangeControl.Text.Split(',');
            for (int i = 1; i < controls.Length; i++) {
                (FindControl(controls[i]) as TextBox).BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFF99");
            }
        }

    }


    //新增数据
    public Boolean addData() {
        sqlcon.Open();
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String addSQLSring = "";
        System.Text.StringBuilder zd = new System.Text.StringBuilder();
        System.Text.StringBuilder zdz = new System.Text.StringBuilder();
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '合同评审表'  ";
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
                    zdz.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).SelectedValue);
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



        addSQLSring = "insert into js_htpsbH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_htpsbH";
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        result = true;
        return result;
    }



    //获取数据
    public void getData() {
        sqlcon.Open();
        //Hash表:
        //ht_zddz 字段对照 存储 前台控件和后台字段名对应关系  KEY:数据库字段名 VALUE:控件名称
        //ht_lxdz 类型对照 前台控件和控件类型对照  KEY:数据库字段名 VALUE：控件类型
        Hashtable ht_zddz = new Hashtable();
        Hashtable ht_lxdz = new Hashtable();
        //ArrayList 存储后台数据库字段名字的列表
        ArrayList listZd = new ArrayList();
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '合同评审表'  ";
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
        if (bb != null) {
            sqlstr = "select * from v_htpsb where bh='" + bh + "' and bb='" + bb + "'";
        }
        else {
            sqlstr = "select * from js_htpsbH where bh='" + bh + "'";
        }

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
                        int j = -1;
                        for (int i = 0; i < ddlTemp.Items.Count; i++) {
                            if (ddlTemp.Items[i].Value == sdr[strZd].ToString().Trim()) {
                                j = i;//把匹配到的索引赋给j
                                break;
                            }
                        }
                        if (-1 == j) { //j=0说明数据库里的值没有匹配到，那么就自己把数据库的值加进去并选定
                           ddlTemp.Items.Add(sdr[strZd].ToString().Trim());
                        }
                       // ddlTemp.Text = sdr[strZd].ToString().Trim();
                        ddlTemp.SelectedValue = sdr[strZd].ToString().Trim();
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
            }
        }
        sdr.Close();
        sqlcon.Close();


        EventArgs e = new EventArgs();
        //填充电芯容量和代码
        tbNbdxxh_TextChanged(tbNbdxxh, e);
        //填充业务员
        tbKhdm_TextChanged(tbKhdm, e);
    }


    //更新数据
    public Boolean editData() {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = "";
        //变更单发起人需要保存所有字段
        if ((Convert.ToDouble(ddlBB.Text) > 1.0) && tbGroupName.Text.IndexOf("合同评审表-发起人") >= 0) {
            sqlstr = " select  mc,lx,zd from   dbo.js_controlEnable where   djmc = '合同评审表' ";
        }
        else {
            sqlstr = " select  mc,lx,zd from   dbo.js_controlEnable where   djmc = '合同评审表' "
                       + " and dbo.js_func_hasgroup('合同评审表','" + Session["UserName"] + "','',qx)=1 ";
        }
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
                    editEqualSql.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).SelectedValue);
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
        editSQLSring = "update js_htpsbH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + bh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        result = true;
        return result;

    }
    #endregion

    protected void lbSubmit_Click(object sender, EventArgs e) {
        if (Page.IsValid) {
            //流程完成需要同步数据到别的表
            if (tbLchqzt.Text.Equals("已完成")) {
                if (!synDj()) {
                    return;
                }
            }

            if ("ADD" == lb || "COPY" == lb) {
                if (addData()) {
                    Response.Redirect("htpsbList.aspx");
                }
            }
            else if ("EDIT" == lb) {
                if (editData()) { //编辑数据成功后
                    Response.Redirect("htpsbList.aspx");
                }
            }
            //合同变更
            else if ("CHANGE" == lb) {
                //合同变更分为3种情况
                //   (1)更改重要字段  版本号+0.1 流程重置 tbWorkFlowFlag=1 需要写日志
                if (tbWorkFlowFlag.Text.Equals("1")) {
                    resetWorkFlow();
                }


                //1.新增数据到主表 addData()
                //2.在主表比较新旧评审单变化，写入日志
                //3.就老版本评审单放入历史表
                //   3.1 若变更记录为空，则表明未变更信息，版本退化到上一版，并作编辑editData
                //   3.2 若变更记录不为空，则更新变更信息editData
                if (addData()) {
                    if (change()) {
                        Response.Redirect("htpsbList.aspx");
                    }

                }


            }

        }
    }

    //进行各项校验
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args) {
        sqlcon.Open();
        string sqlstr = "";
        int count = 0;

        //非订单拆分的单子，不能有重复的 客户订单号+客户型号+规格书编号+规格书版本
        if (ddlDdcf.Text.Equals("否")) {
            sqlstr = " select count(*) from js_htpsbH where khddh='" + tbKhddh.Text + "' and KHXH='" + tbKhxh.Text + "' and ggsbh='" + tbGgsbh.Text + "' and ggsbb='" + tbGgsbb.Text + "' and ddcf='否' ";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            count = Convert.ToInt32(Cmd.ExecuteScalar());
            if (count == 1 && lb == "ADD") {
                args.IsValid = false;
                return;
            }
            else if (count >= 2 && lb != "ADD") {
                args.IsValid = false;
                return;
            }
            else {
                args.IsValid = true;
            }
        }

        //校验客户代码
        sqlstr = "select 1 from dbo.js_khbmH where KHDM='" + tbKhdm.Text + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        count = Convert.ToInt32(Cmd.ExecuteScalar());
        if (count != 1) {
            args.IsValid = false;
            CustomValidator1.ErrorMessage = "经校验，系统中无该客户代码，请检查客户代码是否填写正确";
            return;
        }


        //校验内部电芯型号
        if (!tbNbdxxh.Text.Equals("")) {
            sqlstr = "select 1 from dbo.js_dxxhH where nbdxxh='" + tbNbdxxh.Text + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            count = Convert.ToInt32(Cmd.ExecuteScalar());
            if (count != 1) {
                args.IsValid = false;
                CustomValidator1.ErrorMessage = "经校验，系统中无该内部电芯型号，请检查内部电芯型号是否填写正确";
                return;
            }
        }


        //校验内部PACK型号
        if (!tbNbpackxh.Text.Equals("")) {
            sqlstr = "select 1 from dbo.js_PACKxhxxH where PackXh='" + tbNbpackxh.Text + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            count = Convert.ToInt32(Cmd.ExecuteScalar());
            if (count != 1) {
                args.IsValid = false;
                CustomValidator1.ErrorMessage = "经校验，系统中无该内部PACK型号，请检查内部PACK型号是否填写正确";
                return;
            }

        }

        if (!tbNbbzxh.Text.Equals("")) {
            //校验内部包装型号
            sqlstr = "select 1 from dbo.js_dxxhH where nbdxxh='" + tbNbbzxh.Text + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            count = Convert.ToInt32(Cmd.ExecuteScalar());
            if (count != 1) {
                args.IsValid = false;
                CustomValidator1.ErrorMessage = "经校验，系统中无该内部包装型号，请检查内部包装型号是否填写正确";
                return;
            }
        }



        //校验规格书型号
        sqlstr = "select 1 from dbo.View_0395 where VwXm0001='" + tbGgsxh.Text + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        count = Convert.ToInt32(Cmd.ExecuteScalar());
        if (count != 1) {
            args.IsValid = false;
            CustomValidator1.ErrorMessage = "经校验，系统中无该规格书型号，请检查规格书型号是否填写正确";
            return;
        }


        sqlcon.Close();



    }

    //订单拆分
    protected void ddlDdcf_SelectedIndexChanged(object sender, EventArgs e) {
        if (ddlDdcf.Text.Equals("是")) {
            string curBH = tbBh.Text;
            string curDdsl = tbDdsl.Text;
            ddlDdcf.SelectedValue = "否";
            tbBh.Text = tbBh.Text = "HT" + DateTime.Now.ToString("yyyyMMddHHmmss");
            //拆分数量默认0，让其后面去做
            tbDdsl.Text = "0";
            if (addData()) {
                //赋回原值
                tbBh.Text = curBH;
                tbDdsl.Text = curDdsl;
                ddlDdcf.SelectedValue = "是";
            }
        }

        if (lb.Equals("CHANGE")) {
            tbWorkFlowFlag.Text = "1";
        }
    }

    //变更时判断是否需要清空流程
    protected void dropdownlistChange(object sender, EventArgs e) {
        if (lb.Equals("CHANGE")) {
            tbWorkFlowFlag.Text = "1";
        }
    }

    //版本查看
    protected void ddlBB_SelectedIndexChanged(object sender, EventArgs e) {
        bb = ddlBB.Text;
       // Response.Redirect("htpsbEdit.aspx?bh=" + tbBh.Text + " &bb=" + ddlBB.Text + "&lb=EDIT&editType=查看");
        getData();
    }

    //根据内部电芯型号，获取电芯型号的容量和代码
    protected void tbNbdxxh_TextChanged(object sender, EventArgs e) {

        sqlcon.Open();
        string sqlstr = " select convert(varchar(10),rl)+'mAh' dxrl,DM from dbo.js_dxxhH where nbdxxh='" + tbNbdxxh.Text + "' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            sdr.Read();
            tbDxrl.Text = sdr["dxrl"].ToString();
            tbDxdm.Text = sdr["DM"].ToString();
        }
        sqlcon.Close();
        sdr.Close();
    }

    //根据客户代码，获取业务员名称
    protected void tbKhdm_TextChanged(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = " select VwXm0004 ywy from dbo.View_0391 where VwXm0002='" + tbKhdm.Text + "' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            sdr.Read();
            tbYwy.Text = sdr["ywy"].ToString();
        }
        sqlcon.Close();
        sdr.Close();
    }

    //查看变更汇总
    protected void lbGetAllChange_Click(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "select stuff((select a.LSLS+char(10)+'**********************************************'+char(10) from dbo.v_htpsb a where a.bh='" + tbBh.Text + "' order by a.bb desc for xml path('')),1,1,'') log";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            sdr.Read();
            tbWorkFlowFlag.Text = sdr["log"].ToString().Replace("&#x0D", "");
            ClientScript.RegisterStartupScript(this.GetType(), "历史版本查看", "<script>showDialog('divAllLsls')</script>");
        }
        sqlcon.Close();
    }

    //完成的合同评审表需要同步其他单据
    //1.投产计划 
    public bool synDj() {
        bool result = false;
        sqlcon.Open();
        SqlTransaction sqlTran = sqlcon.BeginTransaction();
        string sqlstr = "";
        try {
            if (!tbTcsl.Text.Equals("")) {
                //投产计划
                sqlstr = " if not exists(select 1 from js_tcjh where psdbh='" + tbBh.Text + "') "
                             + " insert into dbo.js_tcjh select '" + tbBh.Text + "','待投产','订单','正常'  "
                             + " else  update dbo.js_tcjh set bgzt='变更中' where psdbh='" + tbBh.Text + "'";
                Cmd = new SqlCommand(sqlstr, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();

                //套料单 
                sqlstr = " if ( not exists (select 1 from js_tldH where  PSDBH='" + tbBh.Text + "') ) "
                              + " insert into dbo.js_tldH (DjLsh, "
                              + "        BH "
                              + " ,BB,JBRQ,PSDBH,PSDBB,DJLX,KHDM,DDL,DXXH,BZXH,PACKXH) "
                              + " select max(DjLsh)+1,  "
                              + "         (select 'TLD-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh  "
                              + "          from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 11, 3) as int) + 1 end max_init from   js_tldH  "
                              + "         	where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) ) A ) "
                              + " ,'1.0',convert(varchar(10),getdate(),120),'" + tbBh.Text + "','" + ddlBB.Text + "','订单','" + tbKhdm.Text + "','" + tbDdsl.Text + "','" + tbNbdxxh.Text + "','" + tbNbbzxh.Text + "','" + tbNbpackxh.Text + "' from dbo.js_tldH ";
                Cmd = new SqlCommand(sqlstr, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();

                sqlTran.Commit();


               
            }
          
          


            result = true;
        }
        catch (Exception ex) {
            sqlTran.Rollback();
            ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + ex.Message.Replace("'", "") + "')</script>");
        }
        finally {
            sqlTran.Dispose();
            sqlcon.Close();
        }


        return result;


    }
}
