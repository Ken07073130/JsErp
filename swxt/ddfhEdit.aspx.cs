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
public partial class ddfhEdit : System.Web.UI.Page {
    string UserName = "";
    public string xh = "";
    string editType = "";
    string lb = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {
        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"].Trim();
        editType = Request.QueryString["editType"];
        tbGroupNames.Text = Session["GroupNames"].ToString();
        getFllist();
        if (!IsPostBack) {
            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                // GroupID = Session["GroupID"].ToString();
            }
            else {
                Response.Redirect("Login.aspx");
            }
            
            if ("ADD" == lb) {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb.Trim()) {
                getData();
            }
            controlEnable();
        }
    }






    //新增时同步增加发料明细列表
    public void AddFlList() {
        string sqlDel = "";
        string sqlAdd = "";

        int rowCount = Request["bl"] == null ? 0 : Convert.ToInt32(Request["bl"]);
        for (int i = 1; i <= rowCount; i++) {
            if (Request["tbPsdbh" + i] != null) {
                sqlAdd = sqlAdd + "select '" + tbBh.Text + "', '" + Request["tbXh" + i].ToString() + "', '" + Request["ddlCplx" + i].ToString() + "', '" + Request["ddlChxz" + i].ToString() + "', '"
                    + Request["tbDdh" + i].ToString() + "', '" + Request["tbGG" + i].ToString() + "', '" + Request["tbWlbh" + i].ToString() + "', '" + Request["tbSl" + i].ToString() + "', '" + Request["tbDw" + i].ToString() + "', case when '" + Request["tbJs" + i].ToString() + "'='' then null else '" + Request["tbJs" + i].ToString() + "' end, case when '" + Request["tbZje" + i].ToString() + "'='' then null else '" + Request["tbZje" + i].ToString() + "' end, '" + Request["tbBz" + i].ToString() + "', '" + Request["tbPsdbh" + i].ToString() + "'" + " union all ";
            }

        }
        if (Request["tbPsdbh"] != null && !Request["tbPsdbh"].ToString().Equals("")) {
            //   String imageUrl = "D:/用户目录/Documents/Visual Studio 2005/Projects/数据系统WEB版/cgxt/images/" + Request["tbWlbh"].Trim() + ".jpg";
            sqlAdd = sqlAdd + "select '" + tbBh.Text + "', '" + Request["tbXh"].ToString() + "', '" + Request["ddlCplx"].ToString() + "', '" + Request["ddlChxz"].ToString() + "', '"
                + Request["tbDdh"].ToString() + "', '" + Request["tbGG"].ToString() + "', '" + Request["tbWlbh"].ToString() + "', '" + Request["tbSl"].ToString() + "', '" + Request["tbDw"].ToString() + "', case when '" + Request["tbJs"].ToString() + "'='' then null else '" + Request["tbJs" ].ToString() + "' end, case when '" + Request["tbZje"].ToString() + "'='' then null else '" + Request["tbZje"].ToString() + "' end , '" + Request["tbBz"].ToString() + "', '" + Request["tbPsdbh"].ToString() + "'" + " union all ";
        }
        if (!sqlAdd.Equals("")) {
            sqlcon.Open();
            SqlTransaction sqlTran = sqlcon.BeginTransaction();
            try {
                sqlDel = "delete from dbo.js_ddfh_fhlbH where bh='" + tbBh.Text + "'";
                Cmd = new SqlCommand(sqlDel, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlAdd = "insert into dbo.js_ddfh_fhlbH ( BH ,xh , CPLX , CHXZ ,DDH , GG , WLBH ,SL ,DW ,JS , ZJE ,BZ , psdbh ) " + sqlAdd;
                sqlAdd = sqlAdd.Substring(0, sqlAdd.Length - 10);
                Cmd = new SqlCommand(sqlAdd, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlTran.Commit();

            }
            catch (Exception ex) {
                sqlTran.Rollback();
                throw ex;
            }
            finally {
                sqlcon.Close();
                sqlTran.Dispose();

            }
            sqlcon.Close();
        }
        //全部删除了
        else {
            sqlcon.Open();
            sqlDel = "delete from dbo.js_ddfh_fhlbH where bh='" + tbBh.Text + "'";
            Cmd = new SqlCommand(sqlDel, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }
    }

    //发送短信
    public void sendMessage() {
        sqlcon.Open();
        string sqlstr = "insert into dbo.js_shortMessage ( UserID, Message ) "
                      + "  select (select userid from dbo.STUsers  where UserName='" + tbYwy.Text + "'),'【数据系统】【订单发货】您好，您的订单'+(select stuff((select ','+b.DDH+'('+c.GGSXH+')'+'('+convert(varchar(20),SL)+DW+')' from dbo.js_ddfhH a,dbo.js_ddfh_fhlbH b,dbo.js_htpsb_newH c "
                      + "  where a.BH=b.BH and a.BH='"+tbBh.Text+"' and b.PSDBH=c.psdbh "
                      + "  for xml path('')),1,1,''))+'已发货,快递公司:'+'"+tbKdgs.Text+"'+',快递单号:'+'"+tbKddh.Text+"' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
    }

    protected void btnTj_Click(object sender, EventArgs e) {

        if ("ADD" == lb) {
            if (addData()) {
                sendMessage();
                Response.Redirect("ddfhList.aspx");
            }
        }
        else if ("EDIT" == lb) {
            if (editData()) { //编辑数据成功后
                //Response.Write("<script>alert('提交成功!');</script>");
                Response.Redirect("ddfhList.aspx");
            }
        }

    }


    //新增时设置默认值
    public void setDefault() {
        DateTime dtSysDate = DateTime.Now;
        tbJbrq.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbZdr.Text = Session["UserName"].ToString();

    }



    //获取同步的列表
    public void getFllist() {
        string readOnly = "";
        string groupNames = tbGroupNames.Text;
        //子表的个数
        int wlcount = 0;
        divFlqk.InnerHtml = "";
        divFlqk.InnerHtml = "  <table id='tab' width='1000px' cellspacing='0' align='center'>  <tr> "
                          + "  <th style='width: 5%; height: 28px;'>序号</th>"
                          + "  <th style='width: 7%; height: 28px;'>产品类型</th>"
                          + "  <th style='width: 8%; height: 28px;'>出货性质</th>"
                          + "  <th style='width: 12%; height: 28px;'>订单号</th>"
                          + "  <th style='width: 12%; height: 28px;'>名称及规格</th>"
                          + "  <th style='width: 10%; height: 28px;'>物料号</th>"
                          + "  <th style='width: 5%; height: 28px;'>数量</th>"
                          + "  <th style='width: 5%; height: 28px;'>单位</th>"
                          + "  <th style='width: 3%; height: 28px;'>件数</th>"
                          + "  <th style='width: 3%; height: 28px;'>总金额</th>"
                          + "  <th style='width: 8%; height: 28px;'>备注</th>"
                          + "  <th style='width: 5%; height: 28px;'>订单量</th>"
                          + "  <th style='width: 8%; height: 28px;'>规格书型号</th>"
                          + "  <th style='width: 5%; height: 28px;'>合同评审单号</th>"
                          + " <th style='width:50px; height: 28px;'><input id='bl_delete' type='button' value='删除' onclick='delTr2()' style='width:58px' " + (readOnly == "true" ? "disabled='disabled'" : "") + " /></th></tr>";



        string sqlstr = " select	a.DjLsh ,a.BH ,a.XH ,a.CPLX ,a.CHXZ ,a.DDH ,a.GG ,a.WLBH ,a.SL ,a.DW ,a.JS ,a.ZJE ,a.BZ ,a.PSDBH,b.ddsl ddl,b.ggsxh  "
                        + " from dbo.js_ddfh_fhlbH a left join dbo.js_htpsb_newH b on a.psdbh=b.psdbh where  BH='" + tbBh.Text + "'";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        int i = 1;
        if (sdr.HasRows) {
            while (sdr.Read()) {
                wlcount++;
                string optionCplx = "";
                string optionChxz = "";
                //下拉类型的选项确定
                if (sdr["cplx"].ToString().Equals("A品")) {
                    optionCplx = "<option>请选择</option> <option selected='selected'>A品</option> <option>B品</option>";
                }
                else if (sdr["cplx"].ToString().Equals("B品")) {
                    optionCplx = "<option>请选择</option> <option>A品</option> <option selected='selected'>B品</option>";
                }
                else {
                    optionCplx = "<option selected='selected'>请选择</option> <option >A品</option> <option>B品</option>";
                }

                //下拉类型的选项确定
                if (sdr["CHXZ"].ToString().Equals("正常出货")) {
                    optionChxz = "<option>请选择</option> <option selected='selected'>正常出货</option> <option>返补货</option>";
                }
                else if (sdr["CHXZ"].ToString().Equals("返补货")) {
                    optionChxz = "<option>请选择</option> <option>正常出货</option><option selected='selected'>返补货</option>";
                }
                else {
                    optionChxz = "<option selected='selected'>请选择</option> <option>正常出货</option> <option>返补货</option>";
                }



                divFlqk.InnerHtml = divFlqk.InnerHtml + "<tr>"
                          + "  <td><input  type='text' style='width:95%' name='tbXh" + i + "'   id='tbXh" + i + "'  value='" + sdr["XH"].ToString() + " '  /></td>"
                          + " <td> <select id='ddlCplx" + i + "' name='ddlCplx" + i + "'> " + optionCplx + "</select> </td> "
                          + " <td> <select id='ddlChxz" + i + "' name='ddlChxz" + i + "'> " + optionChxz + "</select> </td> "
                          + "  <td><input  type='text' style='width:95%' name='tbDdh" + i + "'   id='tbDdh" + i + "'  value='" + sdr["DDH"].ToString() + "'/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbGG" + i + "'   id='tbGG" + i + "'  value='" + sdr["GG"].ToString() + "'/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbWlbh" + i + "'   id='tbWlbh" + i + "'  value='" + sdr["WLBH"].ToString() + "'/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbSl" + i + "'   id='tbSl" + i + "'  value='" + sdr["SL"].ToString() + "'/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbDw" + i + "'   id='tbDw" + i + "'  value='" + sdr["DW"].ToString() + "'/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbJs" + i + "'   id='tbJs" + i + "' value='" + sdr["JS"].ToString() + "'  /></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbZje" + i + "'   id='tbZje" + i + "' value='" + sdr["ZJE"].ToString() + "'  /></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbBz" + i + "'   id='tbBz" + i + "' value='" + sdr["BZ"].ToString() + "'  /></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbDdl" + i + "'   id='tbDdl" + i + "' value='" + sdr["DDL"].ToString() + "'  /></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbGgsxh" + i + "'   id='tbGgsxh" + i + "' value='" + sdr["GGSXH"].ToString() + "'  /></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbPsdbh" + i + "'   id='tbPsdbh" + i + "' value='" + sdr["PSDBH"].ToString() + "'  /></td><td><input type='checkbox' name='ckb'  /></td></tr>";
                i++;

            }
        }
        divFlqk.InnerHtml = divFlqk.InnerHtml + " <tr>"
                          + "  <td><input  type='text' style='width:95%' name='tbXh'   id='tbXh'  value='' /></td>"
                          + " <td> <select id='ddlCplx' name='ddlCplx'> " + "<option selected='selected'>请选择</option> <option >A品</option> <option>B品</option>" + "</select> </td> "
                          + " <td> <select id='ddlChxz' name='ddlChxz'> " + "<option selected='selected'>请选择</option> <option>正常出货</option> <option>返补货</option>" + "</select> </td> "
                          + "  <td><input  type='text' style='width:95%' name='tbDdh'   id='tbDdh'  value=''/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbGG'   id='tbGG'  value='' /></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbWlbh'   id='tbWlbh'  value='' /></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbSl'   id='tbSl'  value=''/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbDw'   id='tbDw'  value=''/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbJs'   id='tbJs' value=''/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbZje'   id='tbZje' value=''/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbBz'   id='tbBz' value=''/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbDdl'   id='tbDdl' value=''/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbGgsxh'   id='tbGgsxh' value=''/></td>"
                          + "  <td><input  type='text' style='width:95%' name='tbPsdbh'   id='tbPsdbh' value=''/></td>"
                          + " <td><input id='bl_add' type='button' value='添加' onclick=\"addTr2(\'tab\', -1)\" style='width:58px'  /></td></tr></table>";

        //把i的值赋给bl
        if (i != 1) {
            bl.Value = Convert.ToString(i - 1);
        }

        wl.Value = wlcount.ToString();
        sdr.Close();
        sqlcon.Close();
    }


    //跳转到打印页面
    public void btnPrint_Click(object sender, EventArgs e) {
        Response.Redirect("cpkftaPrint.aspx?xh=" + tbBh.Text + " &lb=EDIT" + "&editType=全部");
    }

    //判断控件的可编辑情况
    public void controlEnable() {
        /*if (editType.Equals("全部")) {
            lbtnOK.Visible = false;
        }
        sqlcon.Open();
        String sqlstr = "select lx,mc, dbo.js_func_hasgroup(djmc,'" + Session["UserName"] + "','',qx) qx from dbo.js_controlEnable where djmc='收料单'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
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
        if (Session["username"].ToString().Equals(tbYwy.Text)) {
            lbtnOK.Visible = false;
        }

    }


    //新增数据
    public Boolean addData() {

        sqlcon.Open();
        //第一步获取编号   年 + 月 + 001,002...
        //tbXsrhqsj.Text = tbJbrq.Text;
        //编号  年+月+001
        String sqlStr = "select 'FHD-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                        + " from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 11, 3) as int) + 1 end max_init from   js_ddfhH  "
                        + "			where substring(convert(nvarchar(6), JBRQ, 112), 1, 6 )= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) "
                        + "      ) A ";
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
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '发货单' ";
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



        addSQLSring = "insert into js_ddfhH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_ddfhH";
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();


        AddFlList();
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
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '发货单' ";
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
        sqlstr = "select * from dbo.js_ddfhH where bh='" + xh + "'";
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
                            if (ddlTemp.Items[i].Value == sdr[strZd].ToString().Trim()) {
                                j = i;//把匹配到的索引赋给j
                                break;
                            }
                        }
                        if (0 == j) { //j=0说明数据库里的值没有匹配到，那么就自己把数据库的值加进去并选定
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

        getFllist();


        tbKhdm_TextChanged(tbKhdm, new EventArgs());




    }


    //更新数据
    public Boolean editData() {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from   dbo.js_controlEnable where   djmc = '发货单'";
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
        editSQLSring = "update js_ddfhH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        //子表的数据库操作
        AddFlList();

        result = true;
        return result;
       
    }




    protected void tbKhdm_TextChanged(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "select YWYGL,KHMC from dbo.js_khbmH where KHDM='" + tbKhdm.Text + "' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                tbYwy.Text = sdr["YWYGL"].ToString();
                if (tbShkh.Text.Equals("")) {
                    tbShkh.Text = sdr["KHMC"].ToString();
                }
            }
        }
        sdr.Close();
        sqlcon.Close();
    }
}
