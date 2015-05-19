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

public partial class wlReplaceEdit : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {

        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"];
        getFllist();
        if (!IsPostBack) {
            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else {
                Response.Redirect("~/Login.aspx");
            }

            if ("ADD" == lb) {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb) {
                getData();
            }
            controlEnable();

        }
    }


    protected void btnTj_Click(object sender, EventArgs e) {
        if (Page.IsValid) {
            lbtnOK.Enabled = false;
            if ("ADD" == lb) {
                if (addData()) {
                    Response.Redirect("wlReplaceList.aspx");
                }
            }
            else if ("EDIT" == lb) {
                if (editData()) { //编辑数据成功后
                    //Response.Write("<script>alert('提交成功!');</script>");
                    Response.Redirect("wlReplaceList.aspx");
                }
            }
        }

    }

    //新增替代列表
    public void AddFlList() {
        string sqlDel = "";
        string sqlAdd = "";
        if (Request["tbTdbh"] != null && !Request["tbTdbh"].ToString().Equals("")) {
            sqlAdd = sqlAdd + "select " + tbBh.Text + ", '" + Request["tbTdbh"].ToString() + "', '" + Request["tbGysdm"].ToString()
                            + "', '" + Request["tbWlbh"].ToString() + "', '" + Request["tbQsrq"].ToString() + "', '" + Request["tbZzrq"].ToString() + "' union all ";
        }
        for (int i = 1; i <= 100; i++) {
            if (Request["tbWlbh" + i] != null) {
                sqlAdd = sqlAdd + "select " + tbBh.Text + ", '" + Request["tbTdbh" + i].ToString() + "', '" + Request["tbGysdm" + i].ToString()
                          + "', '" + Request["tbWlbh" + i].ToString() + "', '" + Request["tbQsrq" + i].ToString() + "', '" + Request["tbZzrq" + i].ToString() + "' union all ";
            }

        }
        if (!sqlAdd.Equals("")) {
            sqlcon.Open();
            SqlTransaction sqlTran = sqlcon.BeginTransaction();
            try {
                sqlDel = "delete from dbo.js_wlReplace_tdlbH where djlsh='" + tbBh.Text + "'";
                Cmd = new SqlCommand(sqlDel, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlAdd = "insert into dbo.js_wlReplace_tdlbH( DjLsh ,TDBH ,GYSDM ,WLBH ,QSRQ ,ZZRQ ) " + sqlAdd;
                sqlAdd = sqlAdd.Substring(0, sqlAdd.Length - 10);
                Cmd = new SqlCommand(sqlAdd, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlTran.Commit();

            }
            catch (Exception ex) {
                sqlTran.Rollback();
            }
            finally {
                sqlcon.Close();
                sqlTran.Dispose();

            }
            sqlcon.Close();
        }
        else {
            sqlcon.Open();
            sqlDel = "delete from dbo.js_wlReplace_tdlbH where djlsh='" + tbBh.Text + "' ";
            Cmd = new SqlCommand(sqlDel, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }
    }



    //获取替代列表
    public void getFllist() {
        divFlqk.InnerHtml = "";
        divFlqk.InnerHtml = "<table id='tab' runat='server' width='1000px' cellspacing='0' align='center'>"
                          + "<tr>"
                          + "<th style='width:5%; height: 28px;'>替代编号</th>"
                          + " <th style='width:5%; height: 28px;'>供应商代码</th>"
                          + " <th style='width:12%; height: 28px;'>供应商名称</th>"
                          + " <th style='width:8%; height: 28px;'>物料代码</th>"
                          + " <th style='width:10%; height: 28px;'>物料名称</th>"
                          + " <th style='width:10%; height: 28px;'>规格</th>"
                          + " <th style='width:5%; height: 28px;'>起始日期</th>"
                          + " <th style='width:5%; height: 28px;'>结束日期</th>"
                          + " <th style='width:5%; height: 28px;'><input id='bl_delete' type='button' value='删除' onclick='delTr2()' style='width:58px' /></th></tr>";



        string sqlstr = "select a.TDBH,a.GYSDM,c.GYSMC,a.WLBH,a.QSRQ,a.ZZRQ,b.wlmc,b.lsmxx gg"
                       + " from    dbo.js_wlReplace_tdlbH a left join  js_xyclbmH b on a.WLBH=b.wlbh left join js_gysglH c on a.GYSDM=c.GYSDM "
                       + " where   a.djlsh='" + tbBh.Text + "' order by convert(float,a.TDBH)";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        int i = 1;
        if (sdr.HasRows) {
            while (sdr.Read()) {
                divFlqk.InnerHtml = divFlqk.InnerHtml + "<tr><td><input  type='text'  style='width:90%'  name='tbTdbh" + i + "'   id='tbTdbh" + i + "' value='" + sdr["Tdbh"].ToString() + "' /></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbGysdm" + i + "'   id='tbGysdm" + i + "'  value='" + sdr["Gysdm"].ToString() + " ' /></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbGysmc" + i + "'   id='tbGysmc" + i + "'  value='" + sdr["Gysmc"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbWlbh" + i + "'   id='tbWlbh" + i + "' value='" + sdr["WLBH"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbWlmc" + i + "'   id='tbWlmc" + i + "' value='" + sdr["WLMC"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbGG" + i + "'   id='tbGG" + i + "' value='" + sdr["GG"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbQsrq" + i + "'   id='tbQsrq" + i + "' value='" + sdr["QSRQ"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbZzrq" + i + "'   id='tbZzrq" + i + "' value='" + sdr["ZZRQ"].ToString() + "'/></td>"
                          + " <td><input type='checkbox' name='ckb' /></td></tr>";
                i++;

            }
        }
        divFlqk.InnerHtml = divFlqk.InnerHtml + " <tr><td><input  type='text'  style='width:90%'  name='tbTdbh'   id='tbTdbh' value='' /></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbGysdm'   id='tbGysdm'  value='' /></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbGysmc'   id='tbGysmc'  value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbWlbh'   id='tbWlbh' value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbWlmc'   id='tbWlmc' value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbGG'   id='tbGG' value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbQsrq'   id='tbQsrq' value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbZzrq'   id='tbZzrq' value=''/></td>"
                          + " <td><input id='bl_add' type='button' value='添加' onclick=\"addTr2(\'tab\', -1)\" style='width:58px' /></td></tr></table>";

        //把i的值赋给bl
        if (i != 1) {
            bl.Value = Convert.ToString(i - 1);
        }
        sdr.Close();
        sqlcon.Close();
    }




    //新增时设置默认值
    public void setDefault() {
        DateTime dtSysDate = DateTime.Now;
        tbJbrq.Text = dtSysDate.ToString("yyyy-MM-dd");
    }


    //判断控件的可编辑情况
    public void controlEnable() {

        sqlcon.Open();
        String sqlstr = "select lx,mc,1 qx from dbo.js_controlEnable where djmc='物料替代表'";
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


        tbBh.ReadOnly = true;
        tbJbrq.ReadOnly = true;
        if (lb.Equals("EDIT")) {
            tbMc.ReadOnly = true;
            tbMc.BackColor = System.Drawing.Color.Silver;
            ddlTdfs.Enabled = false;
        }
        sqlcon.Close();
        sdr.Close();

    }


    //新增数据
    public Boolean addData() {
        sqlcon.Open();
        //第一步获取编号   年 + 月 + 001,002...
        //tbXsrhqsj.Text = tbJbrq.Text;
        //编号  年+月+001
        String sqlStr = "select isnull(max(DjLsh),0)+1 bh  from dbo.js_wlReplaceH ";
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
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '物料替代表' ";
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



        addSQLSring = "insert into js_wlReplaceH ("
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select "
                   + zdz.ToString().Substring(0, zdz.Length - 1);
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();


        //增加附表
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
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '物料替代表' ";
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
        sqlstr = "select * from dbo.js_wlReplaceH where djlsh='" + xh + "'";
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

        //获取发料详细列表
        getFllist();
    }




    //更新数据
    public Boolean editData() {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from   dbo.js_controlEnable where   djmc = '物料替代表' ";
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
        editSQLSring = "update js_wlReplaceH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where djlsh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        //发料列表
        AddFlList();





        result = true;
        return result;
    }

    //验证是否存在相同的 物料名称+替代方式
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args) {
        //只在新增时验证
        if (lb.Equals("ADD")) {
            string tdfs = ddlTdfs.Text;
            string sqlstr = "select count(1) ts from dbo.js_wlReplaceH where WLMC='" + args.Value + "' and TDFS='" + tdfs + "'";
            int ts = 0;
            sqlcon.Open();
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    ts = Convert.ToInt32(sdr["ts"].ToString());
                }
                //条数大于0则验证不通过
                if (ts > 0) {
                    args.IsValid = false;
                }
            }
        
        }
       
        sdr.Close();
        sqlcon.Close();
    }
}
