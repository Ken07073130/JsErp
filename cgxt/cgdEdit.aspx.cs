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

public partial class cgdEdit : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "",editType="";
    string urlGysdm = "";
    int[] gridView1Index;
    int[] gridView2Index;
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {
        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"].Trim();
        editType = Request.QueryString["editType"];
        //序号是0代表是将要生成的订单 类别修改为新增
        if (xh.Equals("0")) {
           
            lb = "ADD";
        }
        urlGysdm = Request.QueryString["gysdm"];
        //采购来源单据 列位置 [0.物料编号(wlbh)],[1.单据流水号(djlsh)]
        gridView1Index = new int[] { 5, 10 };

        //采购列表单据 列位置 [0.单据流水号(djlsh)],[1.物料编号(wlbh)]
        gridView2Index = new int[] { 12, 1 };
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
            if ("EDIT" == lb.Trim()) {
                getData();

                //查看的单据不能提交
                if (editType.Equals("查看")) {
                    lbtnOK.Visible = false;
                }
            }

        }
    }

    


    //编号变了 同步修改采购列表和采购来源的编号
    public void syncBh() {
        sqlcon.Open();
        string cgdbh = "";
        string sqlstr = "select bh from js_cgdH where djlsh=" + xh;
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                cgdbh = sdr["bh"].ToString();
            }
        }
        sdr.Close();
        //编号改变了需要同步
        if (!tbBh.Text.Equals(cgdbh)) {
            sqlstr = "update dbo.js_cgd_cglyH set CGDBH='" + tbBh.Text + "' where CGDBH='" + cgdbh + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlstr = "update dbo.js_cgd_cglbH set CGDBH='" + tbBh.Text + "' where CGDBH='" + cgdbh + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
        }
        sqlcon.Close();
    }

    //填写供应商后生成采购来源
    public void bulidCgly(string gysdm) {
        sqlcon.Open();
        //删除采购来源的相关信息
        string sqlDel = "delete from dbo.js_cgd_cglyH where CGDBH='" + tbBh.Text + "'";
        //新建采购来源的相关信息
        string sqlAdd = " insert  into dbo.js_cgd_cglyH(CGDBH,DjState,BH,TLDH,TLBB,DJLX,WLBH,JHSL) "
                      + " select  '" + tbBh.Text + "','',row_number() over ( partition by '' order by b.BH ),a.BH,a.BB,'套料单',b.WLBH,b.JHSL "
                      + " from    dbo.js_tldH a,dbo.js_tldwzxhdeH b,dbo.js_xyclbmH c "
                      + " where    b.CGXQ=1 and b.TDZT in (0,2) and b.CGZT=0 and a.sfbg=0 " //套料单数据筛选条件 采购需求=1(需采购) 替代状态=0(原始)或者2(替代物料) 采购状态=0(未采购) ,且不能为已变更过的单据(sfbg=0)
                      + " and a.PSDBH=b.PSDBH and b.WLBH=c.wlbh and c.gysbh='" + gysdm + "'";

        SqlTransaction sqlTran = sqlcon.BeginTransaction();
        try {
            Cmd = new SqlCommand(sqlDel, sqlcon);
            Cmd.Transaction = sqlTran;
            Cmd.ExecuteNonQuery();
            Cmd = new SqlCommand(sqlAdd, sqlcon);
            Cmd.Transaction = sqlTran;
            Cmd.ExecuteNonQuery();
            sqlTran.Commit();
        }
        catch (Exception ex) {
            sqlTran.Rollback();
            ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + ex.Message + "')</script>");
        }
        finally {
            sqlTran.Dispose();
            sqlcon.Close();
        }

        //生成后重新绑定数据集
        bind();

        bulidCglb();

    }

    //生成采购列表
    public void bulidCglb() {
        sqlcon.Open();
        //删除采购列表的相关信息
        string sqlDel = "delete from dbo.js_cgd_cglbH where CGDBH='" + tbBh.Text + "'";
        //根据采购来源的生成采购列表的相关信息
        string sqlAdd = " insert into dbo.js_cgd_cglbH (CGDBH,DjState,BH,WLBH,ZSL) "
                       + " select '" + tbBh.Text + "','',row_number() over (partition by '' order by WLBH),WLBH,sum(JHSL) from dbo.js_cgd_cglyH where CGDBH='" + tbBh.Text + "' group by CGDBH,WLBH ";


        SqlTransaction sqlTran = sqlcon.BeginTransaction();
        try {
            Cmd = new SqlCommand(sqlDel, sqlcon);
            Cmd.Transaction = sqlTran;
            Cmd.ExecuteNonQuery();
            Cmd = new SqlCommand(sqlAdd, sqlcon);
            Cmd.Transaction = sqlTran;
            Cmd.ExecuteNonQuery();
            sqlTran.Commit();
        }
        catch (Exception ex) {
            sqlTran.Rollback();
            ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + ex.Message + "')</script>");
        }
        finally {
            sqlTran.Dispose();
            sqlcon.Close();
        }

        //生成后重新绑定数据集
        bind();

        //绑定采购列表
        cglbBind();
    }


    #region  GridView1 GridView2 功能代码区
    public void bind() {
        string sqlStr = "";
        sqlStr = "select a.CGDBH,a.DjLsh,a.bh,a.TLDH,a.TLBB,a.DJLX,a.WLBH,a.JHSL,b.wlmc,b.lsmxx gg,b.dw from dbo.js_cgd_cglyH a,dbo.js_xyclbmH b  where a.WLBH=b.wlbh and a.CGDBH='" + tbBh.Text + "' order by a.BH";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_cgd_cglyH");

        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "djlsh" };
        GridView1.DataBind();
        sqlcon.Close();

    }

    //采购列表GridView数据填充
    public void cglbBind() {
        string sqlstr = "select  a.djlsh,a.BH,a.WLBH,b.wlmc,b.gg,b.dw,a.ZSL,c.kcsl,a.SL,a.DJ,a.JE,a.DHRQ,a.BZ,a.cgdbh "
                    + "    from    dbo.js_cgd_cglbH a "
                    + "    left join dbo.v_wlxx b on a.WLBH=b.wlbh "
                    + "    left join (select Mate_ID,isnull(sum(QMSL),0) kcsl from dbo.ST_KCMXH where Stor_ID='0001' and KJYM=dbo.js_func_getKjym() group by Mate_ID) c on a.WLBH=c.Mate_ID "
                    + "    where a.CGDBH='" + tbBh.Text + "'";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataAdapter myda = new SqlDataAdapter(sqlstr, sqlcon);
        DataSet myds = new DataSet();
        myda.Fill(myds, "js_cgd_cglbH");
        GridView2.DataSource = myds;
        GridView2.DataKeyNames = new string[] { "djlsh" };
        GridView2.DataBind();


        //根据结果填充 采购数量/单价/金额/到货日期/备注
        for (int i = 0; i < GridView2.Rows.Count; i++) {
            TextBox sl = GridView2.Rows[i].FindControl("tbSl") as TextBox;
            TextBox dj = GridView2.Rows[i].FindControl("tbDj") as TextBox;
            TextBox je = GridView2.Rows[i].FindControl("tbJe") as TextBox;
            Label lblJe = GridView2.Rows[i].FindControl("lblJe") as Label;
            TextBox dhrq = GridView2.Rows[i].FindControl("tbDhrq") as TextBox;
            TextBox bz = GridView2.Rows[i].FindControl("tbBz") as TextBox;
            DataRowView drv = myds.Tables["js_cgd_cglbH"].DefaultView[i];
            sl.Text = drv["sl"].ToString();
            dj.Text = drv["dj"].ToString();
            je.Text = drv["je"].ToString();
            lblJe.Text = drv["je"].ToString();
            dhrq.Text = Convert.ToDateTime(drv["dhrq"]).ToString("yyyy-MM-dd");
            bz.Text = drv["bz"].ToString();

        }
        sqlcon.Close();
    }

    //套料单对应材料变为已采购
    public bool tldZtUpdate() {
        string tldh = "";
        string wlbh = "";
        string bb = "";
        string sqlUpdate = "";
        bool result = false;
        for (int i = 0; i < GridView1.Rows.Count; i++) {
            tldh = GridView1.Rows[i].Cells[3].Text;
            bb = GridView1.Rows[i].Cells[4].Text;
            wlbh = GridView1.Rows[i].Cells[5].Text;
            if (!String.IsNullOrEmpty(tldh)) {
                sqlUpdate = sqlUpdate + "select PSDBH,BB,'" + wlbh + "' wlbh from dbo.js_tldH where BH='" + tldh + "' and BB='" + bb + "' union all ";
            }
        }

        if (!sqlUpdate.Equals("")) {
            sqlUpdate = "update js_tldwzxhdeH set CGZT=1 from ( " + sqlUpdate.Substring(0, sqlUpdate.Length - 10)
                       + ") a where js_tldwzxhdeH.PSDBH=a.PSDBH and TLBB=a.BB and js_tldwzxhdeH.WLBH=a.wlbh";
            sqlcon.Open();
            Cmd = new SqlCommand(sqlUpdate, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }
        result = true;
        return result;
        


    }

    //采购列表 采购数量/单价/金额/到货日期/备注 的提交
    public bool cglbUpdate() {
        bool result = false;
        string sqlUpdate = "update dbo.js_cgd_cglbH set sl=a.sl,dj=a.dj,je=a.je,dhrq=a.dhrq,bz=a.bz from (";
        int djlsh = 0;
        string sl = "";
        string dj = "";
        string je = "";
        string dhrq = "";
        string bz = "";

        for (int i = 0; i < GridView2.Rows.Count; i++) {
            djlsh = Convert.ToInt32(GridView2.Rows[i].Cells[gridView2Index[0]].Text);
            sl = (GridView2.Rows[i].FindControl("tbSl") as TextBox).Text;
            dj = (GridView2.Rows[i].FindControl("tbDj") as TextBox).Text;
            je = (GridView2.Rows[i].FindControl("tbJe") as TextBox).Text;
            dhrq = (GridView2.Rows[i].FindControl("tbDhrq") as TextBox).Text;
            bz = (GridView2.Rows[i].FindControl("tbBz") as TextBox).Text;

            sqlUpdate = sqlUpdate + " select " + djlsh + " djlsh,'" + (sl.Equals("") ? "0.00" : sl) + "' sl,'"
                + (dj.Equals("") ? "0.00" : dj) + "' dj,'" + (je.Equals("") ? "0.00" : je) + "' je,'" + dhrq + "' dhrq,'" + bz + "' bz union all";
        }
        sqlUpdate = sqlUpdate.Substring(0, sqlUpdate.Length - 10);
        sqlUpdate = sqlUpdate + " ) a where js_cgd_cglbH.DjLsh=a.djlsh ";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlUpdate, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        result = true;
        return result;

    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }


    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;

    }


    //给gridview2添加点击事件
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e) {
        // e.Row.Attributes.Add("onclick", "alert('"+e.Row.Cells[gridView2Index[1]].Text+"')");
        if (e.Row.Cells[0].Text != "暂无采购列表") {
            //双击行追踪该行的采购来源
            e.Row.Attributes["ondblclick"] = "changeRowColor('" + e.Row.Cells[gridView2Index[1]].Text + "')";
            //给tbSl和tbDj赋予onchange事件 计算金额
            if (e.Row.FindControl("tbSl") != null) {
                TextBox tbSl = e.Row.FindControl("tbSl") as TextBox;
                TextBox tbDj = e.Row.FindControl("tbDj") as TextBox;
                Label lblJe = e.Row.FindControl("lblJe") as Label;
                TextBox tbJe = e.Row.FindControl("tbJe") as TextBox;
                //js CallJg(数量ID,单价ID,金额LblID,金额TextID)  因为不能直接给leblID赋值,通过隐藏的tbJe
                tbSl.Attributes["onchange"] = "callJg('" + tbSl.ClientID + "','" + tbDj.ClientID + "','" + lblJe.ClientID + "','" + tbJe.ClientID + "')";
                tbDj.Attributes["onchange"] = "callJg('" + tbSl.ClientID + "','" + tbDj.ClientID + "','" + lblJe.ClientID + "','" + tbJe.ClientID + "')";
            }
        }
    }


    //根据隐藏控件tbWlbh的值改变GridView1和GridView2的行颜色
    protected void tbWlbh_TextChanged(object sender, EventArgs e) {
        string wlbh = tbWlbh.Text;
        if (wlbh.Length > 0) {
            //GridView2变色
            for (int i = 0; i < GridView2.Rows.Count; i++) {
                if (GridView2.Rows[i].Cells[gridView2Index[1]].Text.Equals(wlbh)) {
                    GridView2.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#FF9966");
                }
                else {
                    if (i % 2 == 0) {
                        GridView2.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F7F7DE");
                    }
                    else {
                        GridView2.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF");
                    }
                }
            }

            //GirdView1变色
            for (int i = 0; i < GridView1.Rows.Count; i++) {
                if (GridView1.Rows[i].Cells[gridView1Index[0]].Text.Equals(wlbh)) {
                    GridView1.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#FF9966");
                }
                else {
                    if (i % 2 == 0) {
                        GridView1.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F7F6F3");
                    }
                    else {
                        GridView1.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF");
                    }
                }
            }
        }

    }

    //添加物料
    protected void btnAddTr_Click(object sender, EventArgs e) {
        string sqlstr = "insert into dbo.js_cgd_cglyH (CGDBH,DjState,BH,TLDH,TLBB,DJLX,WLBH,JHSL) "
              + "select '" + tbBh.Text + "','',max(bh)+1,'其他','1.0','其他','" + tblyWlbh.Text + "','" + tbSl.Text + "' from js_cgd_cglyH where CGDBH='" + tbBh.Text + "'";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        tbSl.Text = "";
        tblyWlbh.Text = "";
        //重新刷新来源表
        bind();
        //重新生成采购列表
        bulidCglb();
    }

    //删除来源里选择的行
    protected void btnDel_Click(object sender, EventArgs e) {
        string djlsh = "";
        for (int i = 0; i < GridView1.Rows.Count; i++) {
            //选择列被选中的
            if ((GridView1.Rows[i].FindControl("cbDel") as CheckBox).Checked) {
                djlsh = djlsh + GridView1.Rows[i].Cells[gridView1Index[1]].Text + ",";
            }
        }
        if (!djlsh.Equals("")) {
            sqlcon.Open();
            djlsh = djlsh.Substring(0, djlsh.Length - 1);
            string sqlstr = "delete from js_cgd_cglyH where djlsh in (" + djlsh + ")";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();

            //重新刷新来源表
            bind();
            //重新生成采购列表
            bulidCglb();
        }
    }


    #endregion

    #region 数字小写转换中文大写代码区
    //小写金额转换大写金额 
    //@intPart 要转换金额的整数部分 @floatPart 要转换金额的小数部分
    public String transforAomount(int intPart, int floatPart) {
        string result = "";
        string floatPartResult = "";

        //金额不能大于一千万
        if (intPart >= 10000000) {
            result = "金额大于一千万，暂不转换";
        }
        else {
            //1.整数部分
            //如果传进来的数据超过4位数, 分成两部分,万元以上的和万元以下的
            if (intPart / 10000 > 0) {
                result = transforNum(intPart / 10000) + "万" + transforNum(intPart % 10000);
            }
            else {
                result = transforNum(intPart);
            }

            //2.小数部分
            //没有小数部分
            if (floatPart == 0) {
                floatPartResult = "整";
            }
            else {
                string[] je = new string[] { "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" };
                //分的部分
                int ys = floatPart % 10;
                if (ys != 0) {
                    floatPartResult = je[ys] + "分";
                }
                //角的部分
                floatPart = floatPart / 10;
                floatPartResult = je[floatPart] + (floatPart == 0 ? "" : "角") + floatPartResult;
            }

            //整数部分+小数部分
            if (result.Equals("")) {
                result = floatPartResult;
            }
            else {
                result = result + "圆" + floatPartResult;
            }
        }
        return result;
    }

    //转换的函数
    public String transforNum(int intPart) {
        //壹贰叁肆伍陆柒捌玖
        //亿 仟 佰 拾 万 仟 佰 拾 
        string result = "";
        int i = 0;
        string[] dw = new string[] { "", "拾", "佰", "仟", "万", "拾万", "佰万" };
        string[] je = new string[] { "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" };
        int[] jg = new int[20];
        while (intPart > 0) {
            //获取余数
            int ys = intPart % 10;

            //1.个位数为零时则不用处理 2.余数是零但且上一位余数也是零时不处理
            if ((i == 0 && ys == 0) || (i > 0 && jg[i - 1] == 0 && ys == 0)) {
                result = "" + result;
            }
            else {
                result = je[ys] + ((ys == 0) ? "" : dw[i]) + result;
            }
            intPart = intPart / 10;
            jg[i] = ys;
            i++;
        }
        return result;
    }

    #endregion

    //小写转大写
    protected void tbJehj_TextChanged(object sender, EventArgs e) {
        int intPart = 0;
        int floatPart = 0;
        tbJehj.Text = Convert.ToDouble(tbJehj.Text).ToString("F2");
        //找到 . 的位置
        int pointIndex = tbJehj.Text.IndexOf(".");
        if (pointIndex > 0) {
            intPart = Convert.ToInt32(tbJehj.Text.Substring(0, pointIndex));
            floatPart = Convert.ToInt32(tbJehj.Text.Substring(pointIndex + 1, 2));
        }
        else {
            intPart = Convert.ToInt32(tbJehj.Text);
        }
        tbJedx.Text = transforAomount(intPart, floatPart);
    }

    //获取其他表关联数据
    public void getRelationImformation() {
        string sqlStr = "select a.GYSMC from dbo.js_gysglH a where a.GYSDM='" + tbGysdm.Text + "'";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                tbGysmc.Text = sdr["GYSMC"].ToString();
            }
        }
        sdr.Close();
        sqlcon.Close();
    }



    protected void btnTj_Click(object sender, EventArgs e) {
        if (Page.IsValid) {
            //更新采购列表的数据
            cglbUpdate();

            //根据采购来源更新套料单的采购状态为1(已采购)
            tldZtUpdate();

            if ("ADD" == lb) {
                if (addData()) {
                    Response.Redirect("cgdList.aspx");
                }
            }
            else if ("EDIT" == lb) {
                if (editData()) { //编辑数据成功后
                    //Response.Write("<script>alert('提交成功!');</script>");
                    Response.Redirect("cgdList.aspx");
                }
            }
        }
        

    }


    #region 增删改差模块
    //新增时设置默认值
    public void setDefault() {
        DateTime dtSysDate = DateTime.Now;
        tbJbrq.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbCgr.Text = Session["UserName"].ToString();
        //自动生成编号 规则 PO#年月日+该供应商的第几张单子
        if (!urlGysdm.Equals("-999")) {
            tbGysdm.Text = urlGysdm;
            sqlcon.Open();
            string sqlstr = "select  'PO#' +'"+tbGysdm.Text+"'+'#' + convert(varchar(10), getdate(), 12) + '-' + right('000'+convert(varchar(5),isnull(max(substring(bh,len(bh)-2,3)),'000')+1),3) bh from    dbo.js_cgdH where   GYSDM = '" + urlGysdm + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader(); 
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    tbBh.Text = sdr["bh"].ToString();
                }
            }
            sdr.Close();
            sqlcon.Close();

            //获取关联信息
            getRelationImformation();
            //生成采购来源
            bulidCgly(tbGysdm.Text);
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
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '采购单' ";
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



        addSQLSring = "insert into js_cgdH ("
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
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '采购单' ";
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
        sqlstr = "select * from dbo.js_cgdH where djlsh='" + xh + "'";
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

        //获取关联表的信息
        getRelationImformation();

        //绑定GridView1数据
        bind();

        //绑定GridView2数据
        cglbBind();

        //手动触发tbJehj.Text事件
        EventArgs e = new EventArgs();
        if (!tbJehj.Text.Equals("")) {
            tbJehj_TextChanged(tbJehj, e);
        }
    }


    //更新数据
    public Boolean editData() {
        Boolean result = false;


        //编号不一样需要同步子表
        syncBh();


        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from   dbo.js_controlEnable where   djmc = '采购单'";
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
        editSQLSring = "update js_cgdH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where djlsh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();



        result = true;
        return result;
    }

    #endregion


    protected void tbGysmc_TextChanged(object sender, EventArgs e) {
        if (tbGysmc.Text.Length > 0 && tbGysmc.Text.IndexOf(" ") > 0) {
            tbGysdm.Text = tbGysmc.Text.Substring(0, 2);
            //如果有供应商代码且采购单编号不为空,生成采购来源
            if (tbGysdm.Text.Length == 2 && tbBh.Text.Length > 0)
                bulidCgly(tbGysdm.Text);
        }

    }




    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args) {
        sqlcon.Open();
        string sqlstr = "select dbo.js_func_gysbtx('" + tbGysdm.Text.Trim() + "') result";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();

        if (sdr.HasRows) {
            while (sdr.Read()) {
                if (sdr["result"].ToString().Equals("pass")) {
                    args.IsValid = true;
                }
                else {
                    args.IsValid = false;
                    string errorMessage = sdr["result"].ToString();
                    System.Web.UI.ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "", "alert('" + errorMessage + "')",true);
                }
            }
        }
        sdr.Close();
        sqlcon.Close();
    }
}
