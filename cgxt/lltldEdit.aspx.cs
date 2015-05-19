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

public partial class lltldEdit : System.Web.UI.Page
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
        lblReturn.PostBackUrl = "~/cgxt/lltldList.aspx?djlx=" + tbLx.Text;

        if (djlx.Equals("LLD")) {
            lblTile.Text = "领料单";
            if (ddlCgyhqzt.Text.Equals("-")) {
                ddlCgyhqzt.Text = "会签中";
            }
        }
        else {
            lblTile.Text = "退料单";
            if (ddlIQChqzt.Text.Equals("-")) {
                ddlIQChqzt.Text = "会签中";
            }
        }
        getFllist();
        if (!IsPostBack) {
            //Initialization();
            ddlIQC.Items.Add("");
            ddlIQC.Items.Add(Session["username"].ToString());
            ddlCgy.Items.Add("");
            ddlCgy.Items.Add(Session["username"].ToString());
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
            controlEnable();

        }
    }

    //车间dropdownlist初始化
    /*public void Initialization() {
        String selectedText = ddlCj.Text;
        if (String.IsNullOrEmpty(selectedText)) {
            ddlCj.Items.Clear();
            sqlcon.Open();
            String sqlstr = "select CKDM+''+CKMC CKMC,CKDM from dbo.CKDMH ";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    ddlCj.Items.Add(new ListItem(sdr["CKMC"].ToString(),sdr["CKDM"].ToString()));
                }
            }
            sqlcon.Close();
        }
    }*/


    /*protected void tbWlmc_TextChanged(object sender, EventArgs e) {
        sqlcon.Open();
        String sqlstr = "select * From js_wlflbH where flmc='" + tbWlmc.Text + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {

            while (sdr.Read()) {
                tbFldm.Text = sdr["fldm"].ToString();
                tbDldm.Text = sdr["dldm"].ToString();
            }

        }
        sqlcon.Close();
    }*/

    //结束执行存储过程
    public void execProc() {
        sqlcon.Open();
        //执行存储过程js_sp_cgxtkccl @bh=单子的编号 @djlx=sld
        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = new SqlCommand();
        da.SelectCommand.Connection = sqlcon;
        da.SelectCommand.CommandText = "js_sp_cgxtkccl";
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        da.SelectCommand.Parameters.AddWithValue("@bh", tbBh.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@djlx", tbLx.Text.Trim().ToUpper());
        da.SelectCommand.Parameters.AddWithValue("@errorMessage", "");
        da.SelectCommand.ExecuteNonQuery();
        sqlcon.Close();

    }

    protected void btnTj_Click(object sender, EventArgs e) {
        //如果发料数量>=需求数量，那么修改完成状态
        /*if (!tbZFlsl.Text.Equals("") && !tbXqsl.Text.Equals("")) {
            if (Convert.ToDouble(tbZFlsl.Text) >= Convert.ToDouble(tbXqsl.Text)) {
                if (djlx.Equals("LLD")) {
                    tbLlzt.Text = "仓库已发料";
                }
            }
        }*/
        lbtnOK.Enabled = false;
        if ("ADD" == lb) {
            if (addData()) {
                Response.Redirect("lltldEdit.aspx?lb=ADD&djlx=" + tbLx.Text + "&editType=会签中");
            }
        }
        else if ("EDIT" == lb) {
            if (editData()) { //编辑数据成功后
                //Response.Write("<script>alert('提交成功!');</script>");
                //Response.Redirect("lltldEdit.aspx?lb=Edit&djlx=" + tbLx.Text + "&editType=会签中");
                Response.Redirect("lltldList.aspx?djlx="+djlx);
            }
        }

    }

    //新增时同步增加发料明细列表
    public bool AddFlList() {
        bool result = false;
        string sqlDel = "";
        string sqlAdd = "";
        if (Request["tbPh"] != null && !Request["tbPh"].ToString().Equals("")) {
            sqlAdd = sqlAdd + "select '" + tbBh.Text + "', '" + Request["tbPh"].ToString() + "', '" + Request["tbFlsl"].ToString() + "', '" + Request["tbKcl"].ToString() + "', '" + Request["ddlPzzk"].ToString() + "', '"
                + Request["ddlRkcz"].ToString() + "', '" + Request["tbCw"].ToString() + "', '" + Request["tbHjh"].ToString() + "', '" + Request["tbFlbz"].ToString() + "' union all ";
        }
        int rowCount = Convert.ToInt32(Request["bl"]);
        for (int i = 1; i <= rowCount; i++) {
            if (Request["tbPh" + i] != null) {
                sqlAdd = sqlAdd + "select '" + tbBh.Text + "', '" + Request["tbPh" + i].ToString() + "', '" + Request["tbFlsl" + i].ToString() + "', '" + Request["tbKcl" + i].ToString() + "', '" + Request["ddlPzzk" + i].ToString() + "', '"
                    + Request["ddlRkcz" + i].ToString() + "', '" + Request["tbCw" + i].ToString() + "', '" + Request["tbHjh" + i].ToString() + "', '" + Request["tbFlbz" + i].ToString() + "' union all ";
            }

        }
        if (!sqlAdd.Equals("")) {
            sqlcon.Open();
            SqlTransaction sqlTran = sqlcon.BeginTransaction();
            try {
                sqlDel = "delete from dbo.js_lltld_fllbH where bh='" + tbBh.Text + "'";
                Cmd = new SqlCommand(sqlDel, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlAdd = "insert into dbo.js_lltld_fllbH ( BH, PH, FLSL, KCL, PZZK,RKCZ, CW, HJH, BZ ) " + sqlAdd;
                sqlAdd = sqlAdd.Substring(0, sqlAdd.Length - 10);
                Cmd = new SqlCommand(sqlAdd, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlTran.Commit();

            }
            catch (Exception ex) {
                sqlTran.Rollback();
                ClientScript.RegisterStartupScript(this.GetType(), "", "alert('" + ex.Message + "')");
            }
            finally {
                sqlcon.Close();
                sqlTran.Dispose();

            }
            sqlcon.Close();
        }
        else {
            sqlcon.Open();
            sqlDel = "delete from dbo.js_lltld_fllbH where bh='" + tbBh.Text + "'";
            Cmd = new SqlCommand(sqlDel, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }
        result = true;
        return result;
    }

    /* public void dg(int i,int j,int count) {
         if (count < 10) {
             int t = i + j;
             tbLlzt.Text = tbLlzt.Text + ";" + count.ToString() + "=" + t;
             count++;
             dg(j, t, count);
            
         }
         else {
             tbLlzt.Text = tbLlzt.Text+Convert.ToString(i + j);
         }
      
    
     }*/

    //获取同步的列表
    public void getFllist() {
        string readOnly = "";
        string groupNames = tbGroupNames.Text;
        string phtkkcReadOnly = "";
        string pzkcReadOnly = "";
        string cwhjbzReadOnly = "";
        string tkTitle = "";
        if (tbLx.Text.Equals("LLD")) {
            //领料不显示退料的流程
            liIQC.Style.Add("display", "none");
            //显示需求数量
            liXqsl.Style.Add("display", "");
            tkTitle = "发料数量";
            if (groupNames.IndexOf("领料退料单-仓管员") >= 0 || groupNames.IndexOf("超级用户") >= 0) {
                phtkkcReadOnly = "";
                pzkcReadOnly = "";
                cwhjbzReadOnly = "";
            }
            else {
                phtkkcReadOnly = "readonly='readonly'";
                pzkcReadOnly = "readonly='readonly'";
                cwhjbzReadOnly = "readonly='readonly'";
            }
        }

        if (tbLx.Text.Equals("TLD")) {
            //显示退料的流程
            liIQC.Style.Add("display", "");
            //发料数量
            liXqsl.Style.Add("display", "none");
            //不显示需求数量
            liXqsl.Style.Add("display", "none");
            //显示成退料员
            spLly.InnerText = "退料员";

            spFlsl.InnerText = "退库数量";
            tkTitle = "退库数量";

            if (groupNames.IndexOf("领料退料单-领料退料员") >= 0 || groupNames.IndexOf("超级用户") >= 0 ||
               groupNames.IndexOf("领料退料单-仓管员") >= 0) {
                phtkkcReadOnly = "";
            }
            else {
                phtkkcReadOnly = "readonly='readonly'";
            }

            if (groupNames.IndexOf("领料退料单-IQC") >= 0 || groupNames.IndexOf("超级用户") >= 0) {
                pzkcReadOnly = "";
            }
            else {
                pzkcReadOnly = "readonly='readonly'";
            }

            if (groupNames.IndexOf("领料退料单-仓管员") >= 0 || groupNames.IndexOf("超级用户") >= 0) {
                cwhjbzReadOnly = "";
            }
            else {
                cwhjbzReadOnly = "readonly='readonly'";
            }
        }





        divFlqk.InnerHtml = "";
        divFlqk.InnerHtml = "<table id='tab' runat='server' width='1000px' cellspacing='0' align='center'>" + "<tr><th style='width:15%; height: 28px;'>批号</th>"
                          + "<th style='width:10%; height: 28px;'>" + tkTitle + "</th>"
                          + " <th style='width:15%; height: 28px;'>库存量</th>"
                          + " <th style='width:10%; height: 28px;'>品质状况</th>"
                          + " <th style='width:10%; height: 28px;'>入库操作</th>"
                          + " <th style='width:10%; height: 28px;'>仓位</th>"
                          + " <th style='width:10%; height: 28px;'>货架号</th>"
                          + " <th style='width:45%; height: 28px;'>备注</th>"
                          + " <th style='width:5%; height: 28px;'><input id='bl_delete' type='button' value='删除' onclick='delTr2()' style='width:58px' " + (readOnly == "true" ? "disabled='disabled'" : "") + " /></th></tr>";



        string sqlstr = "select PH,FLSL,KCL,PZZK,RKCZ,CW,HJH,BZ from dbo.js_lltld_fllbH where BH='" + tbBh.Text + "'";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        int i = 1;
        if (sdr.HasRows) {
            /*divFlqk.InnerHtml = divFlqk.InnerHtml + "<tr><td colspan='7' align='center' style='font-size:18px; font-weight:bold'>已添加列表<td></tr>" +
                 "<tr><td style='height: 39px'>批号</td><td style='height: 39px'>发料数量</td><td style='height: 39px'>库存量</td>"
                           + "<td style='height: 39px'>库位</td><td style='height: 39px'>仓位</td><td style='height: 39px'>品质状况</td>"
                           + "<td style='width: 120px'>备注</td><td style='width: 70px'></td> </tr>";*/
            string optionPzzk = "";
            string optionRKCZ = "";
            while (sdr.Read()) {
                if (sdr["pzzk"].ToString().Equals("合格")) {
                    optionPzzk = "<option>请选择</option> <option selected='selected'>合格</option> <option>不合格</option> <option>让步</option>";
                }
                else if (sdr["pzzk"].ToString().Equals("不合格")) {
                    optionPzzk = "<option>请选择</option> <option >合格</option> <option selected='selected'>不合格</option> <option>让步</option>";
                }
                else if (sdr["pzzk"].ToString().Equals("让步")) {
                    optionPzzk = "<option>请选择</option> <option >合格</option> <option>不合格</option> <option selected='selected'>让步</option>";
                }
                else {
                    optionPzzk = "<option selected='selected'>请选择</option> <option >合格</option> <option>不合格</option> <option >让步</option>";
                }

                if (sdr["RKCZ"].ToString().Equals("入库")) {
                    optionRKCZ = "<option>请选择</option> <option selected='selected'>入库</option> <option>退货</option> ";
                }
                else if (sdr["RKCZ"].ToString().Equals("退货")) {
                    optionRKCZ = "<option>请选择</option> <option >入库</option> <option selected='selected'>退货</option> ";
                }
                else {
                    optionRKCZ = "<option selected='selected'>请选择</option> <option >入库</option> <option>退货</option> ";
                }
                divFlqk.InnerHtml = divFlqk.InnerHtml + "<tr><td><input  type='text' " + phtkkcReadOnly + "  style='width:90%'  name='tbPh" + i + "'   id='tbPh" + i + "' value='" + sdr["PH"].ToString() + "' /></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + " style='width:90%' name='tbFlsl" + i + "'   id='tbFlsl" + i + "'  value='" + sdr["FLSL"].ToString() + " '  onchange='calZflsl()' /></td>"
                          + "  <td><input  type='text' readonly='readonly' style='width:90%' name='tbKcl" + i + "'   id='tbKcl" + i + "'  value='" + sdr["KCL"].ToString() + "'/></td>"
                    //+ "  <td><input  type='text' " + pzkcReadOnly + " style='width:90%' name='ddlPzzk" + i + "'   id='ddlPzzk" + i + "' value='" + sdr["PZZK"].ToString() + "'/></td>"
                          + " <td> <select id='ddlPzzk" + i + "' name='ddlPzzk" + i + "' " + pzkcReadOnly + " > " + optionPzzk + "</select> </td> "
                    // + "  <td><input  type='text' " + pzkcReadOnly + " style='width:90%' name='ddlRkcz" + i + "'   id='ddlRkcz" + i + "' value='" + sdr["KCFS"].ToString() + "'/></td>"
                          + " <td> <select id='ddlRkcz" + i + "' name='ddlRkcz" + i + "' " + pzkcReadOnly + " > " + optionRKCZ + "</select> </td> "

                          + "  <td><input  type='text' " + cwhjbzReadOnly + " style='width:90%' name='tbCw" + i + "'   id='tbCw" + i + "' value='" + sdr["CW"].ToString() + "'/></td>"
                          + "  <td><input  type='text' " + cwhjbzReadOnly + " style='width:90%' name='tbHjh" + i + "'   id='tbHjh" + i + "' value='" + sdr["HJH"].ToString() + "'/></td>"
                          + "  <td><input  type='text' " + cwhjbzReadOnly + " style='width:90%' name='tbFlbz" + i + "'   id='tbFlbz" + i + "' value='" + sdr["BZ"].ToString() + "'/></td>"
                          + " <td><input type='checkbox' name='ckb' " + (readOnly == "true" ? "disabled='disabled'" : "") + " /></td></tr>";
                i++;

            }
        }
        divFlqk.InnerHtml = divFlqk.InnerHtml + " <tr><td><input  type='text' " + phtkkcReadOnly + "  style='width:90%'  name='tbPh'   id='tbPh' value='' /></td>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:90%' name='tbFlsl'   id='tbFlsl'  value=''  onchange='calZflsl()' /></td>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:90%' name='tbKcl'   id='tbKcl'  value=''/></td>"
            //+ "  <td><input  type='text'  " + pzkcReadOnly + " style='width:90%' name='ddlPzzk'   id='ddlPzzk' value=''/></td>"
                          + " <td><select id='ddlPzzk' name='ddlPzzk' " + pzkcReadOnly + " > <option selected='selected'>请选择</option> <option>合格</option> <option>不合格</option> <option>让步</option></select> </td>"
            //+ "  <td><input  type='text'  " + pzkcReadOnly + " style='width:90%' name='ddlRkcz'   id='ddlRkcz' value=''/></td>"
                          + " <td style='height: 28px'><select id='ddlRkcz' name='ddlRkcz'><option selected='selected'>请选择</option><option>入库</option><option>退货</option></select></td>"
                          + "  <td><input  type='text'  " + cwhjbzReadOnly + " style='width:90%' name='tbCw'   id='tbCw' value=''/></td>"
                          + "  <td><input  type='text'  " + cwhjbzReadOnly + " style='width:90%' name='tbHjh'   id='tbHjh' value=''/></td>"
                          + "  <td><input  type='text'  " + cwhjbzReadOnly + " style='width:90%' name='tbFlbz'   id='tbFlbz' value=''/></td>"
                          + " <td><input id='bl_add' type='button' value='添加' onclick=\"addTr2(\'tab\', -1)\" style='width:58px' " + (readOnly == "true" ? "disabled='disabled'" : "") + " /></td></tr></table>";

        //把i的值赋给bl
        if (i != 1) {
            bl.Value = Convert.ToString(i - 1);
        }
        sdr.Close();
        sqlcon.Close();
    }

    public void getWlxx() {
        string sqlstr = " select a.wlbh,a.wlmc,d.flmc,b.GYSMC,a.lsmxx gg,a.dw from dbo.js_xyclbmH a "
                        + " left join dbo.js_wlflbH d on a.dlbh=d.fldm and d.dldm='0' "
                        + " left join dbo.js_gysglH b on a.gysbh=b.GYSDM "
                        + " where a.wlbh='" + tbWlbh.Text + "'";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                tbWlmc.Text = sdr["wlmc"].ToString();
                tbWlmc.BackColor = System.Drawing.ColorTranslator.FromHtml("#00FFFF");
                tbGys.Text = sdr["gysmc"].ToString();
                tbGys.BackColor = System.Drawing.ColorTranslator.FromHtml("#00FFFF");
                tbGg.Text = sdr["gg"].ToString();
                tbGg.BackColor = System.Drawing.ColorTranslator.FromHtml("#00FFFF");
                tbDw.Text = sdr["dw"].ToString();
                tbDw.BackColor = System.Drawing.ColorTranslator.FromHtml("#00FFFF");
            }
        }
        sdr.Close();
        sqlcon.Close();
    }

    //获取仓库名称
    public void getCkmc() {
        string sqlstr = "select CKDM,CKMC from dbo.CKDMH where CKDM='" + tbCjdm.Text + "'";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                tbCj.Text = sdr["CKMC"].ToString();
            }
        }
        sdr.Close();
        sqlcon.Close();
    }


    //新增时设置默认值
    public void setDefault() {
        DateTime dtSysDate = DateTime.Now;
        tbJbrq.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbZFlsl.Text = "0";
        if (djlx.Equals("LLD")) {
            tbLlzt.Text = "等待仓库发料";
            //  Button1.Attributes["disabled"] = "disabled";
        }
        else {
            tbLlzt.Text = "等待仓库退料";
        }
        tbLly.Text = UserName;
        tbLx.Text = djlx;
    }


    //跳转到打印页面
    public void btnPrint_Click(object sender, EventArgs e) {
        Response.Redirect("cpkftaPrint.aspx?xh=" + tbBh.Text + " &lb=EDIT" + "&editType=全部");
    }

    //判断控件的可编辑情况
    public void controlEnable() {
        if (editType.Equals("全部")) {
            lbtnOK.Visible = false;
        }

        sqlcon.Open();
        String sqlstr = "select lx,mc,dbo.js_func_hasgroup(djmc,'" + UserName + "','',qx) qx from dbo.js_controlEnable where djmc='领料退料单'";
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
        sdr.Close();

    }

  

    //新增数据
    public Boolean addData() {
        sqlcon.Open();
        //第一步获取编号   年 + 月 + 001,002...
        //tbXsrhqsj.Text = tbJbrq.Text;
        //编号  年+月+001
        String sqlStr = " select  '" + tbLx.Text + "' + csr_init +replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                       + " from    ( select    convert(nvarchar(6), getdate(), 112)  csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 11, 3) as int) + 1 "
                       + "                    end max_init from dbo.js_lltldH where   substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) and lx='" + tbLx.Text + "' "
                       + "        ) A ";
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
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '领料退料单' and charindex('领料退料员',qx)>0  ";
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



        addSQLSring = "insert into js_lltldH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_lltldH";
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
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '领料退料单' ";
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
        sqlstr = "select * from dbo.js_lltldH where bh='" + xh + "'";
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

        //获取物料信息
        getWlxx();
        //获取车间信息
        getCkmc();
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
        String sqlstr = " select  mc,lx,zd from   dbo.js_controlEnable where   djmc = '领料退料单'"
                      + " and dbo.js_func_hasgroup('领料退料单','" + Session["UserName"].ToString() + "','',qx)=1 ";
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
        editSQLSring = "update js_lltldH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        //发料列表
        if (AddFlList()) {
            //结束执行存储过程
            if (tbLlzt.Text.Equals("仓库已发料") || tbLlzt.Text.Equals("已完成")) {
                execProc();
            }
        }




        result = true;
        return result;
    }


}
