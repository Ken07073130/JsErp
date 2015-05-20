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

public partial class SysManage_SubIndex_Default : System.Web.UI.Page {
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand cmd = null;
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
            if (Session["groupnames"].ToString().Equals("超级用户")) {
                divCp.Visible = true;
            }

        }
        bind();
        bind_cp();

    }

    public void bind() {
        sqlcon.Open();
        string sqlstr = "select NodeCaption,URL,ParentID,nodeID  from Erp_js_Sys.dbo.Tree where URL is not null and URL<>'' and NodeLevel=2 ";
        //不为超级用户，需要附加条件
        if (!Session["IsAdministrator"].Equals("1")) {
            sqlstr = sqlstr + " and objectid in (  select  [ObjectID] "
                          + "                     from    [erp_js_data0704].[dbo].[STPermission] "
                          + "                     where   Permission = 1 "
                          + "                     and userid in ( select  [GroupID] "
                          + "                                     from    [erp_js_data0704].[dbo].[STUserGroup] "
                          + "                                     where   userid = " + Session["OID"].ToString() + " ) ) ";
        }
        //只有样品权限才能看到样品综合评审
        if (Session["groupnames"].ToString().IndexOf("样品综合评审") > 0 || Session["groupnames"].ToString().IndexOf("超级用户") >= 0) {
            sqlstr = sqlstr + "union all select '样品评审','yp/ypzhpsdList.aspx',0,0 ";
        }


        sqlstr = sqlstr + " order by 3,4 ";
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlcon);
        DataSet ds = new DataSet();
        sda.Fill(ds, "Tree");
        GridView1.DataSource = ds;
        GridView1.DataBind();
        sqlcon.Close();


    }


    //绑定菜单数据
    public void bind_cp() {
        sqlcon.Open();
        string sqlstr = "select CM from js_stcp where xq='" + System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetDayName(DateTime.Now.DayOfWeek) + "'";
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlcon);
        DataSet ds = new DataSet();
        sda.Fill(ds, "js_stcp");
        GridView2.DataSource = ds;
        GridView2.DataBind();
        sqlcon.Close();
    }

    //获取是星期几
    public string getDayOfWeek(int day) {
        string result = "";
        switch (day) {
            case 1: result = "星期一"; break;
            case 2: result = "星期二"; break;
            case 3: result = "星期三"; break;
            case 4: result = "星期四"; break;
            case 5: result = "星期五"; break;
            case 6: result = "星期六"; break;
            case 7: result = "星期日"; break;
        }
        return result;

    }
    protected void btnImpCp_Click(object sender, EventArgs e) {
        //输入的要导出的前N条数据
        int inputnum = 0;
        string strnum = tbWjlj.Text.Trim();
        int.TryParse(strnum, out inputnum);

        //Excel 中的数据集
        DataSet ds = null;
        //数据表
        DataTable dt = new DataTable();
        //连接字符串
        string strCon = string.Empty;
        //文件所在路径
        string strFilePath = tbWjlj.Text.Trim();
        if (strFilePath == "") {
            // MessageBox.Show("请选择一个Excel文件！");
            return;
        }
        //后缀名
        string strExt = strFilePath.Substring(strFilePath.LastIndexOf(".") + 1).ToLower();
        //判断文件后缀名
        if (strExt == "xls")// 2003格式
            {
            strCon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + strFilePath + ";Extended Properties='Excel 8.0;IMEX=1';Persist Security Info=True";
        }
        else if (strExt == "xlsx")  //2007或以上格式
            {
            strCon = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + strFilePath + ";Extended Properties='Excel 12.0;IMEX=1';Persist Security Info=True";
        }
        else {
            Response.Write("<script>alert('所选择文件非Excel文件，请重新选择!')</script>");
            return;
        }

        //Excel 连接实例化
        sqlcon.Open();
        System.Data.OleDb.OleDbConnection Conn = new System.Data.OleDb.OleDbConnection(strCon);
        SqlTransaction tran = sqlcon.BeginTransaction();
        try {
            //打开Excel的连接
            Conn.Open();
            string sheetName = tbSheetName.Text.Trim();
            //查询SQL语句 默认查询第一个工作表（默认总共三个）
            string strCom = "SELECT * FROM " + sheetName;
            if (inputnum != 0) {
                strCom = "SELECT  top " + inputnum + " * FROM " + sheetName;
            }
            //执行查询
            System.Data.OleDb.OleDbDataAdapter myCommand = new System.Data.OleDb.OleDbDataAdapter(strCom, Conn);
            ds = new DataSet();
            //将查询到的数据填充到DataSet中，并设置表名为第一个表单的名称“[Sheet1$]”
            myCommand.Fill(ds, sheetName);
            dt = ds.Tables[0];

            string sqlstr = String.Empty;

            sqlstr = "delete from js_stcp";
            cmd = new SqlCommand(sqlstr, sqlcon);
            cmd.Transaction = tran;
            cmd.ExecuteNonQuery();
            sqlstr = "";
            for (int j = 1; j <= 6; j++) {
                string xq = getDayOfWeek(j);
                for (int i = 2; i <= 11; i++) {
                    sqlstr = sqlstr + "select '" + xq + "','" + dt.Rows[i][j].ToString() + "'" + " union all ";
                }
            }
            if (!sqlstr.Equals("")) {
                sqlstr = "insert into js_stcp " + sqlstr.Substring(0, sqlstr.Length - 10);
            }
            cmd = new SqlCommand(sqlstr, sqlcon);
            cmd.Transaction = tran;
            cmd.ExecuteNonQuery();
            tran.Commit();
            ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('导入菜单成功')</script>");
        }
        catch (Exception ex) {
            //如果出现异常则显示异常信息。
            //  MessageBox.Show(ex.Message);
            tran.Rollback();
            ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + ex.Message + "')</script>");
        }
        finally {
            //关闭所有链接
            Conn.Close();
            sqlcon.Close();
            tran.Dispose();
        }
    }

    //
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            DataRowView drv = e.Row.DataItem as DataRowView;
            HyperLink hlURL = e.Row.FindControl("hlURL") as HyperLink;
            Label lbContent = e.Row.FindControl("lbContent") as Label;
            hlURL.NavigateUrl = "../../" + drv["URL"].ToString();
            //设置工作流中的待办内容
            workFlowSet(drv, lbContent);
        }
    }

    //工作流处理
    public void workFlowSet(DataRowView drv, Label lbContent) {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        con.Open();
        string UserName = Session["username"].ToString();
        string GroupNames = Session["groupnames"].ToString();
        /*单据：订单发货
         *待办内容：对业务员来说，需要知道最近10周的发货记录
         */
        string sqlstr = "";
        SqlDataReader sdr;
        if (drv["NodeCaption"].ToString().Trim().Equals("订单发货")) {
            sqlstr = "select count(*) sl,'换行'+shkh shkh from dbo.js_ddfhH a,dbo.View_0391 b "
                   + "  where a.KHDM=b.VwXm0002 and JBRQ>=getdate()-10 and b.VwXm0004='" + UserName + "' group by a.SHKH ";
            cmd = new SqlCommand(sqlstr, con);
            sdr = cmd.ExecuteReader();
            if (sdr.HasRows) {
                lbContent.Font.Size = 10;
                lbContent.Text = "近10日您的订单发货情况";
                while (sdr.Read()) {
                    lbContent.Text = lbContent.Text + sdr["shkh"].ToString().Replace("换行", "</br>") + ":" + sdr["sl"].ToString() + "单";
                }
            }
            sdr.Close();

        }
        /*单据：样品综合评审单
         *待办内容： 1.对业务员来说，需要知道最近1周前三单的流程状态
         *            2.对评审人员来说需要知道还有多少单据没会签
         */
        if (drv["NodeCaption"].ToString().Trim().Equals("样品评审")) {
            sqlstr = "select top 3 '换行'+ case when djlx='样品建议书' then '[样品]' when DJLX='产品开发提案' then '[提案]' else '[规格书]' end + ','"
                    + " +NBXH+','+LCHQZT nr "
                    + "from dbo.js_ypzhpsdH where JBRQ is not null and JBRQ>getdate()-10 "
                    + "and XSRY='" + UserName + "' and LCHQZT<>'已完成' and lchqzt<>'待业务反馈中' order by djlx desc ";
            cmd = new SqlCommand(sqlstr, con);
            sdr = cmd.ExecuteReader();
            //有数据说明为业务员
            if (sdr.HasRows) {
                lbContent.Font.Size = 10;
                lbContent.Text = "近10日您的单据会签状态(前3单)";
                while (sdr.Read()) {
                    lbContent.Text = lbContent.Text + sdr["nr"].ToString().Replace("换行", "</br>");
                }
            }
            else {
                sdr.Close();
                sqlstr = "select count(*)" +
                 " from    js_ypzhpsdH a" +
                 " where  JBRQ is not null and jbrq>=getdate()-10 and ( " +
                 "      (dbo.js_func_hasgroup('样品综合评审单','" + UserName + "',a.xsry,'')=1 and  XSJLHQZT='会签中') " +
                 "     or (charindex('样品综合评审单-商务经理审核','" + GroupNames + "')>0 and  SWJLHQZT='会签中') " +
                 "     or (charindex('样品综合评审单-商务经理审核','" + GroupNames + "')>0 and lchqzt='商务发样中') " +
                 "     or (charindex('样品综合评审单-总负责人审核','" + GroupNames + "')>0  and ZGHQZT='会签中'   and djlx<>'产品开发提案' ) " +
                 "     or (charindex('样品综合评审单-总工审核','" + GroupNames + "')>0  and  ZGHQZT='会签中' and djlx= '产品开发提案') " +
                 "     or (charindex('样品综合评审单-总经理助理审核','" + GroupNames + "')>0  and  ZZHQZT='会签中' ) " +
                 "     or (charindex('样品综合评审单-实验室审核','" + GroupNames + "')>0 and  SYSHQZT='会签中') " +
                 "     or (ZJDXGCS='" + UserName + "' and  DXHQZT='会签中') " +
                 "     or (ZJGCS='" + UserName + "' and   PACKHQZT='会签中' ) )";
                cmd = new SqlCommand(sqlstr, con);
                if (cmd.ExecuteScalar() != null && cmd.ExecuteScalar().ToString() != "" && Convert.ToInt32(cmd.ExecuteScalar()) > 0) {
                    lbContent.Text = "近10日待处理单据" + "(" + cmd.ExecuteScalar() + ")条";
                }

            }


        }
        /*单据：品质反馈表
         *待办内容： 1.接收人需要知道多少单子没签
         */
        if (drv["NodeCaption"].ToString().Trim().Equals("品质反馈表")) {
            sqlstr = "select count(*) from dbo.js_pzfkdH where  fkjsry='" + UserName + "' and  LCHQZT='回馈中' ";
            cmd = new SqlCommand(sqlstr, con);
            if (cmd.ExecuteScalar() != null && cmd.ExecuteScalar().ToString() != "" && Convert.ToInt32(cmd.ExecuteScalar()) > 0) {
                lbContent.Text = "待反馈单据" + "(" + cmd.ExecuteScalar() + ")条";
            }

        }

        /*单据：商务客诉单
        *待办内容： 1.接收人需要知道多少单子没签
        */
        if (drv["NodeCaption"].ToString().Trim().Equals("品质反馈表")) {
            sqlstr = "select count(*) from js_zltscldh "
              + "where (charindex('质量投诉处理单-质量客诉录入','" + GroupNames + "')>0 and zlbhqzt='会签中')"
              + "or  (charindex('质量投诉处理单-质量经理审核','" + GroupNames + "')>0 and shhqzt='会签中')";
            cmd = new SqlCommand(sqlstr, con);
            if (cmd.ExecuteScalar() != null && cmd.ExecuteScalar().ToString() != "" && Convert.ToInt32(cmd.ExecuteScalar()) > 0) {
                lbContent.Text = "待处理单据" + "(" + cmd.ExecuteScalar() + ")条";
            }

        }

        con.Close();

       





    }
}
