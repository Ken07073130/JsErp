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

public partial class btdEdit : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "", editType = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {
        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"].Trim();
        editType = Request.QueryString["editType"];
        if (!IsPostBack) {

            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                // GroupID = Session["GroupID"].ToString();
                tbUserName.Text = UserName;
            }
            else {
                Response.Redirect("Login.aspx");
            }

            if ("ADD" == lb) {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb.Trim()) {
                getData();
                bind();
            }
            controlEnable();
        }
    }

    //设置默认值
    public void setDefault() {
        DateTime dt = DateTime.Now;
        tbBh.Text = "BTD" + dt.ToString("yyyyMMddHHmmss");
        tbTc.Text = Session["username"].ToString();
        tbJbrq.Text = dt.ToString("yyyy-MM-dd");
        tbLchqzt.Text = "PMC会签中";
    }

    public void bind() {
        sqlcon.Open();
        string sqlstr = "select * from js_btd_list where btdbh='" + tbBh.Text + "'";
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlcon);
        DataSet ds = new DataSet();
        sda.Fill(ds, "js_btd_list");
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "djlsh" };
        GridView1.DataBind();
        sqlcon.Close();


        lbHjsl.Text = "0";
        int sl = 0;
        for (int i = 0; i < GridView1.Rows.Count; i++) {
            sl = sl + Convert.ToInt32(GridView1.Rows[i].Cells[2].Text);
        }
        lbHjsl.Text = sl.ToString();

    }


    //添加投产计划信息
    protected void lbAddtr_Click(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "insert into dbo.js_btd_list ( btdbh, blxm, sl, wtms)"
                      + " values ('" + tbBh.Text + "','" + tbBlxm.Text + "'," + tbSl.Text + ",'" + tbWtms.Text + "')";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        //重新绑定
        bind();

        tbSl.Text = "";
        tbBlxm.Text = "";
        tbWtms.Text = "";

      

    }

    //变更状态
    protected void lbSubmit_Click(object sender, EventArgs e) {
        if (Page.IsValid) {
            //流程完成需要同步数据到别的表
            if (tbLchqzt.Text.Equals("已完成")) {
                if (!synDj()) {
                    return;
                }
            }
            if ("ADD" == lb) {
                if (addData()) {
                    Response.Redirect("btdList.aspx");
                }
            }
            else if ("EDIT" == lb) {
                if (editData()) { //编辑数据成功后
                    setDc();
                    //Response.Write("<script>alert('提交成功!');</script>");
                    Response.Redirect("btdList.aspx");
                }
            }
        }

    }

    //删除行
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        sqlcon.Open();
        string sqlstr = " delete from dbo.js_btd_list where djlsh=" + GridView1.DataKeys[e.RowIndex].Value;
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            DataRowView drv = e.Row.DataItem as DataRowView;
            TextBox tbFsyy = e.Row.FindControl("tbFsyy") as TextBox;
            TextBox tbDc = e.Row.FindControl("tbDc") as TextBox;
            tbFsyy.Text = drv["fsyy"].ToString();
            tbDc.Text = drv["dc"].ToString();
            tbFsyy.ReadOnly =!( Session["Groupnames"].ToString().IndexOf("生产补投单-工程部审核") >= 0 || Session["Groupnames"].ToString().IndexOf("超级用户")>=0);
            tbDc.ReadOnly = !(Session["Groupnames"].ToString().IndexOf("生产补投单-工程部审核") >= 0 || Session["Groupnames"].ToString().IndexOf("超级用户")>=0);
        }
    }

    //工程部设置对策
    public bool setDc() {
        bool result = false;
        string sqlstr = "";
        for (int i = 0; i < GridView1.Rows.Count; i++) {
            sqlstr = sqlstr + " select " + GridView1.Rows[i].Cells[6].Text + " djlsh,'" + (GridView1.Rows[i].FindControl("tbFsyy") as TextBox).Text + "' fsyy,'" + (GridView1.Rows[i].FindControl("tbDc") as TextBox).Text + "' dc union all";
        }
        if (!sqlstr.Equals("")) {
            sqlstr = "UPDATE dbo.js_btd_list SET  fsyy=a.fsyy,dc=a.dc FROM ( " + sqlstr.Substring(0, sqlstr.Length - 10) + " ) a  WHERE js_btd_list.djlsh=a.djlsh";
            sqlcon.Open();
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }
        result = true;
        return result;
    }


    //判断控件的可编辑情况
    public void controlEnable() {
        sqlcon.Open();
        String sqlstr = "select lx,mc, dbo.js_func_hasgroup(djmc,'" + Session["UserName"] + "','',qx) qx from dbo.js_controlEnable where djmc='生产补投单'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("TEXTBOX" == sdr["lx"].ToString())
                    //((TextBox)FindControl(sdr["mc"].ToString().Trim())).Attributes.Add("readonly","1" == sdr["qx"].ToString()?"false":"true"); 
                    ((TextBox)FindControl(sdr["mc"].ToString().Trim())).ReadOnly = !("1" == sdr["qx"].ToString());
                else if ("DROPDOWNLIST" == sdr["lx"].ToString()) {
                    ((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                    ((DropDownList)FindControl(sdr["mc"].ToString().Trim())).ForeColor = System.Drawing.Color.Black;
                }
                else if ("CHECKBOX" == sdr["lx"].ToString())
                    ((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                else if ("CHECKBOXLIST" == sdr["lx"].ToString())
                    ((CheckBoxList)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
            }
        }
        sqlcon.Close();
        sdr.Close();

        string groupNames = Session["Groupnames"].ToString();

        //只有发起人能看到流程
        if (groupNames.IndexOf("生产补投单-发起人") >= 0 || groupNames.IndexOf("超级用户") >= 0) {
            divLc.Style.Add("display","");
        }

        //会签内容变色
        if (groupNames.IndexOf("生产补投单-PMC审核") >= 0) spanPMC.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-质量部审核") >= 0) spanZl.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-工程部审核") >= 0) spanGc.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-制造部审核") >= 0) spanZz.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-设备部审核") >= 0) spanSb.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-生产总监审核") >= 0) spanSczj.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-总工审核") >= 0) spanZg.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-供应链审核") >= 0) spanGyl.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-商务经理审核") >= 0) spanSwjl.Style.Add("background-color", "#FFFFCC");
        if (groupNames.IndexOf("生产补投单-总经理助理审核") >= 0) spanZjlzl.Style.Add("background-color", "#FFFFCC");


        //退回的单子打开时，需要重置选择状态
        if (tbLchqzt.Text.IndexOf("退回") >= 0) {
            if (tbLchqzt.Text.IndexOf("PMC") > 0) ddlPMCpsjg.SelectedIndex = 0;
            if (tbLchqzt.Text.IndexOf("质量") > 0) ddlZlpsjg.SelectedIndex = 0;
            if (tbLchqzt.Text.IndexOf("工程") > 0) ddlGcpsjg.SelectedIndex = 0;
            if (tbLchqzt.Text.IndexOf("制造") > 0) ddlZzpsjg.SelectedIndex = 0;
            if (tbLchqzt.Text.IndexOf("设备") > 0) ddlSbpsjg.SelectedIndex = 0;
            if (tbLchqzt.Text.IndexOf("生产总监") > 0) ddlSczjpsjg.SelectedIndex = 0;
            if (tbLchqzt.Text.IndexOf("总工") > 0) ddlZgpsjg.SelectedIndex = 0;
            if (tbLchqzt.Text.IndexOf("供应链") > 0) ddlGylpsjg.SelectedIndex = 0;
            if (tbLchqzt.Text.IndexOf("商务经理") > 0) ddlSwjlpsjg.SelectedIndex = 0;
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
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '生产补投单'  ";
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



        addSQLSring = "insert into js_btdH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_btdH";
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
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '生产补投单' ";
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
        sqlstr = "select * from dbo.js_btdH where bh='" + xh + "'";
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
            }
        }
        sdr.Close();
        sqlcon.Close();
    }


    //更新数据
    public Boolean editData() {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from    dbo.js_controlEnable where   djmc = '生产补投单'"
                      + " and dbo.js_func_hasgroup('生产补投单','" + Session["UserName"] + "','',qx)=1 ";
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
        editSQLSring = "update js_btdH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();


        result = true;
        return result;
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args) {
        sqlcon.Open();
        //校验客户代码
        string sqlstr = "";
        int count = 0;
        sqlstr = "select 1 from dbo.js_khbmH where KHDM='" + tbKhdm.Text + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        count = Convert.ToInt32(Cmd.ExecuteScalar());
        if (count != 1) {
            args.IsValid = false;
            CustomValidator1.ErrorMessage = "经校验，系统中无该客户代码，请检查客户代码是否填写正确";
            sqlcon.Close();
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
                sqlcon.Close();
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
                sqlcon.Close();
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
                sqlcon.Close();
                return;
            }
        }



        //校验规格书型号
        if (!tbGgsxh.Text.Equals("")) {
            sqlstr = "select 1 from dbo.View_0395 where VwXm0001='" + tbGgsxh.Text + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            count = Convert.ToInt32(Cmd.ExecuteScalar());
            if (count != 1) {
                args.IsValid = false;
                CustomValidator1.ErrorMessage = "经校验，系统中无该规格书型号，请检查规格书型号是否填写正确";
                sqlcon.Close();
                return;
            }
        }
       

        sqlcon.Close();

    }

    //完成的合同评审表需要同步其他单据
    //1.投产计划 
    //2.套料单
    public bool synDj() {
        bool result = false;
        sqlcon.Open();
        SqlTransaction sqlTran = sqlcon.BeginTransaction();
        int sl = 0;
        sl = Convert.ToInt32(tbZjyjbt.Text) + Convert.ToInt32(tbFjyjbt.Text) + Convert.ToInt32(tbDxyjbt.Text) + Convert.ToInt32(tbPackyjbt.Text);
        try {
            if (sl>0) {
                //投产计划
                string sqlstr = " if not exists(select 1 from js_tcjh where psdbh='" + tbBh.Text + "') "
                              + " insert into dbo.js_tcjh select '" + tbBh.Text + "','待投产','补投单','正常'  ";
                            // + " else  update dbo.js_tcjh set bgzt='变更中' where psdbh='" + tbBh.Text + "'";
                Cmd = new SqlCommand(sqlstr, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                //套料单 
                sqlstr = " if ( not exists (select 1 from js_tldH where  PSDBH='"+tbBh.Text+"') ) "
                              +  " insert into dbo.js_tldH (DjLsh, "
                              +  "        BH "
                              +  " ,BB,JBRQ,PSDBH,PSDBB,DJLX,KHDM,DDL,DXXH,BZXH,PACKXH) "
                              +  " select max(DjLsh)+1,  "
                              +  "         (select 'TLD-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh  "
                              +  "          from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 11, 3) as int) + 1 end max_init from   js_tldH  " 
                              +  "         	where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) ) A ) "
                              +  " ,'1.0',convert(varchar(10),getdate(),120),'"+tbBh.Text+"','1.0','补投单','"+tbKhdm.Text+"','"+sl.ToString()+"','"+tbNbdxxh.Text+"','"+tbNbbzxh.Text+"','"+tbNbpackxh.Text+"' from dbo.js_tldH ";
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
