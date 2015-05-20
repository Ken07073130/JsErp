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



    }

    //变更状态
    protected void lbSubmit_Click(object sender, EventArgs e) {
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

        }
    }

    //工程部设置对策
    public bool setDc() {
        bool result = false;
        string sqlstr = "";
        for (int i = 0; i < GridView1.Rows.Count; i++) {
            sqlstr =sqlstr+ " select " + GridView1.Rows[i].Cells[6].Text + " djlsh,'" + (GridView1.Rows[i].FindControl("tbFsyy") as TextBox).Text + "' fsyy,'" + (GridView1.Rows[i].FindControl("tbDc") as TextBox).Text + "' dc union all";
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

}
