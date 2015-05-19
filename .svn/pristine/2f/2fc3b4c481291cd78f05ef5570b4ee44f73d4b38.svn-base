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

public partial class nonProductEdit : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "";
    string djlx = "";
    string editType = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {

        xh = Request.QueryString["xh"];
        djlx = Request.QueryString["djlx"];
        lb = Request.QueryString["lb"].Trim();
        tbLx.Text = djlx;
        tbGroupNames.Text = Session["GroupNames"].ToString();
        editType = Request.QueryString["editType"];
        lblReturn.PostBackUrl = "~/cgxt/nonProductList.aspx?djlx=" + tbLx.Text;
        fillList();

        if (djlx.Equals("SLD")) {
            lblTile.Text = "收料单";
        }
        else if (djlx.Equals("LLD")) {
            lblTile.Text = "领料单";
        }
        else {
            lblTile.Text = "退料单";
        }
        if (!IsPostBack) {
            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else {
                Response.Redirect("Login.aspx");
            }

            if ("ADD" == lb) {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb) {
                getData();
            }

        }
    }

    public int getExistsCount() {
        sqlcon.Open();
        string sqlstr = " select count(*) ts from dbo.js_fscclglH where GG='" + tbGG.Text + "' ";
        int ts = 0;
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {

                ts = Convert.ToInt32(sdr["ts"].ToString());
            }
        }
        sqlcon.Close();
        return ts;
    }

    //填充大类
    public void fillList() {
        string wllb = ddlWllb.SelectedValue;
        ddlWllb.Items.Clear();
        ddlWllb.Items.Add(new ListItem("请选择", "0"));
        sqlcon.Open();
        //填充大类
        string sqlStr = "select WZMC,XL from dbo.js_wzflbH where dl='000'";
        Cmd = new SqlCommand(sqlStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                ddlWllb.Items.Add(new ListItem(sdr["wzmc"].ToString(), sdr["xl"].ToString()));
            }
        }
        ddlWllb.SelectedValue = wllb;
        sqlcon.Close();

    }

    //根据大类填充物资名称
    protected void ddlWllb_SelectedIndexChanged(object sender, EventArgs e) {
        //填充小类
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlConn.Open();
        string sqlstr = "select  WZMC,XL from dbo.js_wzflbH where dl='" + ddlWllb.SelectedValue + "'";
        Cmd = new SqlCommand(sqlstr, sqlConn);
        SqlDataReader sdr1 = Cmd.ExecuteReader();
        ddlWlmc.Items.Clear();
        ddlWlmc.Items.Add(new ListItem("请选择", "0"));
        if (sdr1.HasRows) {
            while (sdr1.Read()) {
                ddlWlmc.Items.Add(new ListItem(sdr1["WZMC"].ToString(), sdr1["XL"].ToString()));
            }
        }

        sqlConn.Close();
    }

    //结束执行存储过程
    /*public void execProc() {
        sqlcon.Open();
        //执行存储过程js_sp_cgxtkccl @bh=单子的编号 @djlx=sld
        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = new SqlCommand();
        da.SelectCommand.Connection = sqlcon;
        da.SelectCommand.CommandText = "js_sp_cgxtkccl";
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        da.SelectCommand.Parameters.AddWithValue("@bh", tbBh.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@djlx", tbLx.Text.Trim().ToUpper());
        da.SelectCommand.ExecuteNonQuery();
        sqlcon.Close();

    }*/

    protected void btnTj_Click(object sender, EventArgs e) {
        lbtnOK.Enabled = false;
        //不存在同规格的物料 生成物料
        if (tbWlbh.Text.Equals("") && getExistsCount() <= 0) {
            sqlcon.Open();
            string sqlstr = "select right('0000'+convert(varchar(10),isnull(max(substring(WLBH,9,4)),0)+1),4) xh from dbo.js_fscclglH where substring(WLBH,1,8)='13" + ddlWllb.SelectedValue + ddlWlmc.SelectedValue + "'  ";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    tbWlbh.Text = "13" + ddlWllb.SelectedValue + ddlWlmc.SelectedValue + sdr["xh"].ToString();
                }
            }
            sqlcon.Close();

        }

        if ("ADD" == lb) {
            if (addData()) {
                Response.Redirect("nonProductEdit.aspx?lb=ADD&djlx=" + tbLx.Text + "&editType=会签中");
            }
        }
        else if ("EDIT" == lb) {
            if (editData()) { //编辑数据成功后
                //Response.Write("<script>alert('提交成功!');</script>");
                //Response.Redirect("nonProductEdit.aspx?lb=Edit&djlx=" + tbLx.Text + "&editType=会签中");
                Response.Redirect("nonProductList.aspx?djlx=" + djlx);
            }
        }

    }



    //新增时设置默认值
    public void setDefault() {
        DateTime dtSysDate = DateTime.Now;
        tbJbrq.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbCzr.Text = UserName;
        tbLx.Text = djlx;
    }




    //新增数据
    public Boolean addData() {

        sqlcon.Open();
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String addSQLSring = "";
        System.Text.StringBuilder zd = new System.Text.StringBuilder();
        System.Text.StringBuilder zdz = new System.Text.StringBuilder();
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '非生产材料管理'  ";
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



        addSQLSring = "insert into js_fscclglH ("
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select "
                   + zdz.ToString().Substring(0, zdz.Length - 1);
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
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '非生产材料管理' ";
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
        sqlstr = "select * from dbo.js_fscclglH where djlsh='" + xh + "'";
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
                        //物料名称需要物料类别进行二级关联
                        if (strZd.ToUpper().Equals("WLMC")) {
                            ddlWllb_SelectedIndexChanged(ddlWllb, new EventArgs());
                        }
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



    }




    //更新数据
    public Boolean editData() {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from   dbo.js_controlEnable where   djmc = '非生产材料管理'";
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
        editSQLSring = "update js_fscclglH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where djlsh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();





        result = true;
        return result;
    }



    protected void tbGG_TextChanged(object sender, EventArgs e) {
        sqlcon.Open();
        int ts = 0;
        //查找规格是否存在
        string sqlStr = "select count(*) ts from dbo.js_fscclglH where GG='" + tbGG.Text + "' and djlx='SLD'";
        Cmd = new SqlCommand(sqlStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                ts = Convert.ToInt32(sdr["ts"].ToString());
            }
        }
        sdr.Close();

        //能匹配到 说明是已存在的物料 进行信息匹配
        if (ts > 0) {
            sqlStr = "select top 1 * from js_fscclglH where GG='" + tbGG.Text + "' and djlx='SLD'";
            Cmd = new SqlCommand(sqlStr, sqlcon);
            sdr = Cmd.ExecuteReader();
            if(sdr.HasRows){
                while (sdr.Read()) {
                    tbWlbh.Text = sdr["wlbh"].ToString();
                    ddlWllb.SelectedValue = sdr["wllb"].ToString();
                    ddlWllb_SelectedIndexChanged(ddlWllb, new EventArgs());
                    ddlWlmc.SelectedValue = sdr["wlmc"].ToString();

                }
            }
            sdr.Close();
        }
        sqlcon.Close();
    }
}
