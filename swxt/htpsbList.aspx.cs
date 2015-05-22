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

public partial class htpsbList : System.Web.UI.Page {
    string UserName = "";
    string GroupNames = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e) {
        if (Session["username"] != null) {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupNames = Session["groupnames"].ToString();



        }
        else {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack) {
            bind();
            workFlowBind();
            //发起人可以查看会签流程
            if (GroupNames.IndexOf("合同评审表-发起人") >= 0 || GroupNames.IndexOf("超级用户") >= 0) {
                aShowWorkFlow.Visible = true;
            }

            //初始化Cookie
            if (Request.Cookies[""] == null) {
                initCookie();
            }
            //初始化cbTitleList
            initCbTitleList();
            cblTitleList_SelectedIndexChanged(cblTitleList, e);


        }


    }


    //初始化Cookie
    public HttpCookie initCookie() {
        HttpCookie hc = Response.Cookies["htpsbTitleList"];
        if (hc.Value == null) {
            hc.Value = "BH,BB,JBRQ,GGSXH,KHXH,KHDM,DDSL,KHDDH,NBDXXH,NBPACKXH,GGSBH,GGSBB,";
            hc.Expires = DateTime.Now.AddDays(365);
            Response.Cookies.Add(hc);
        }
        return hc;
    }

    //初始化选择列
    public void initCbTitleList() {
        HttpCookie hc = Request.Cookies["htpsbTitleList"];
        if (hc != null) {
            string[] titleList = hc.Value.Split(',');
            for (int i = 0; i < cblTitleList.Items.Count; i++) {
                cblTitleList.Items[i].Selected = (titleList as IList).Contains(cblTitleList.Items[i].Value);
            }
        }
    }

    public void bind() {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        string conditionString = "";
        //销售人员语句做特殊处理
        if (GroupNames.IndexOf("销售人员") > 0) {
            conditionString = conditionString + " or (charindex('" + UserName + "',dbo.js_func_getYwyLeaders(b.VwXm0004,'销售人员'))>0)";
        }
        sqlStr = "select convert(varchar(10),a.jbrq,120) jbrq,*,case when lchqzt='已完成' then 1 else 0 end hqsx,convert(varchar(10),jbrq,120) jbrq1,convert(varchar(20),ddsl)+'('+dw+')' ddsl1  from js_htpsbH a,view_0391 b where a.khdm=b.VwXm0002 and " +
                 "   ('超级用户'='" + GroupNames + "'  " +
                 "     or a.zbr='" + UserName + "'" +
                 conditionString +
                 "     or (charindex('合同评审表-PMC审核','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or PMCHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-工程部审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or GCHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-设备部审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or SBHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-制造部审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZZHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-质量部审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-PACK审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or PACKHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-供应链审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or GYLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-生产总监审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or SCZJHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-总工审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZGHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-商务经理审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or SWJLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('合同评审表-查看组','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' )) )" +
                 "  order by hqsx,jbrq desc ";


        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_htpsbH");

        GridView1.DataSource = myds;
        //查询过滤
        string filterStringBh = tbBh.Text.Equals("") ? "" : "and bh like '%" + tbBh.Text.Trim() + "%'";
        string filterStringKhddh = tbKhddh.Text.Equals("") ? "" : "and khddh like '%" + tbKhddh.Text.Trim() + "%'";
        string filterStringKhdm = tbKhdm.Text.Equals("") ? "" : "and khdm like '%" + tbKhdm.Text.Trim() + "%'";
        string filterStringKhdxh = tbKhxh.Text.Equals("") ? "" : "and khxh like '%" + tbKhxh.Text.Trim() + "%'";
        string filterStringNbdxxh = tbNbdxxh.Text.Equals("") ? "" : "and nbdxxh like '%" + tbNbdxxh.Text.Trim() + "%'";
        string filterStringNbpackxh = tbNbpackxh.Text.Equals("") ? "" : "and nbPACKXH like '%" + tbNbpackxh.Text.Trim() + "%'";
        string filterStringNbbzxh = tbNbbzxh.Text.Equals("") ? "" : "and Nbbzxh like '%" + tbNbbzxh.Text.Trim() + "%'";
        string filterStringGgsbh = tbGgsbh.Text.Equals("") ? "" : "and ggsbh like '%" + tbGgsbh.Text.Trim() + "%'";
        string filterStringGgsbb = tbGgsbb.Text.Equals("") ? "" : "and ggsbb like '%" + tbGgsbb.Text.Trim() + "%'";
        string filterString = filterStringBh + filterStringKhddh + filterStringKhdm + filterStringKhdxh
                             + filterStringNbdxxh + filterStringNbpackxh + filterStringNbbzxh + filterStringGgsbh + filterStringGgsbb;
        if (!filterString.Equals("")) {
            DataTable dt = (GridView1.DataSource as DataSet).Tables[0];
            filterString = filterString.Substring(4, filterString.Length - 4);
            dt.DefaultView.RowFilter = filterString;
            GridView1.DataSource = dt;
        }




        GridView1.DataKeyNames = new string[] { "BH", "BB" };
        GridView1.DataBind();


        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        SqlTransaction sqlTran = sqlcon.BeginTransaction();
        try {
            string sqlDelMain = "insert into js_htpsb_history select * from js_htpsbH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
            sqlcom = new SqlCommand(sqlDelMain, sqlcon);
            sqlcom.Transaction = sqlTran;
            sqlcom.ExecuteNonQuery();

            string sqlUpdateHitstory = "insert into js_htpsb_history select * from js_htpsbH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
            sqlcom = new SqlCommand(sqlDelMain, sqlcon);
            sqlcom.Transaction = sqlTran;
            sqlcom.ExecuteNonQuery();

            sqlTran.Commit();
        }
        catch (Exception exp) {
            sqlTran.Rollback();
           // Response.Write(exp.Message);
            ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('删除错误"+exp.Message.Replace("'","")+"')</script>");
        }
        finally {
            sqlcon.Close();
            sqlTran.Dispose();
        }

        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("htpsbEdit.aspx?bh=" + GridView1.DataKeys[e.NewEditIndex]["BH"].ToString() + " &bb=" + GridView1.DataKeys[e.NewEditIndex]["BB"].ToString() + "&lb=EDIT&editType=" + ((LinkButton)GridView1.Rows[e.NewEditIndex].Cells[2].Controls[0]).Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {

        if (e.Row.RowType == DataControlRowType.DataRow) {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            LinkButton btnDel = (LinkButton)e.Row.Cells[3].Controls[0];//删除
            btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");
            LinkButton btnEdit = (LinkButton)e.Row.Cells[2].Controls[0];
            TableCell cellChange = e.Row.Cells[1];
            CheckBox cb = e.Row.FindControl("cbPrint") as CheckBox;
            //已打印过的单据设置为√
            if (drv["dyzt"].ToString().Length > 0) {
                cb.Text = "√";
            }
            if (ddlHqzt.Text.Equals("全部")) {
                btnEdit.Text = "查看";
                btnDel.Enabled = false;
                cellChange.Enabled = false;
            }
            else {
                if (GroupNames.IndexOf("合同评审表-发起人") >= 0) {
                    //发起人确定提交的单子不能编辑
                    if (!drv["lchqzt"].ToString().Equals("单据建立中")) {
                        btnEdit.Text = "查看";
                    }
                    btnDel.Enabled = true;//只有发起人有删除权限
                    cellChange.Enabled = true;//只有发起人有变更权限
                }
                else {
                    btnDel.Enabled = false;//不是发起人不能删除单据
                    cellChange.Enabled = false;//不是发起人不能变更
                }
            }

            //行颜色转换,变更中的单子标色
            //未完成且版本>1.0为变更单
            if (!drv["lchqzt"].ToString().Equals("已完成") && Convert.ToDouble(drv["bb"].ToString()) == 1.0) {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#CCFFFF");
            }
            if (!drv["lchqzt"].ToString().Equals("已完成") && Convert.ToDouble(drv["bb"].ToString()) > 1.0) {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFF99");
            }
            if (drv["lchqzt"].ToString().IndexOf("不同意生产") >= 0) {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#CC3333");
            }


        }
    }

    protected void tjbd_Click(object sender, EventArgs e) {
        Response.Redirect("htpsbEdit.aspx?lb=ADD");//只有发起人才能新建表单
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void lbQuery_Click(object sender, EventArgs e) {
        bind();
    }
    protected void ddlHqzt_SelectedIndexChanged(object sender, EventArgs e) {
        bind();
    }

    //业务查看会签状态
    public void workFlowBind() {
        sqlcon.Open();
        string sqlstr = "select  ggsxh,khdm,pmchqzt ,gchqzt ,sbhqzt ,zlhqzt ,zzhqzt,packhqzt , gylhqzt , sczjhqzt ,zghqzt ,swjlhqzt from dbo.js_htpsbH where   lchqzt <> '已完成'";
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlcon);
        DataSet ds = new DataSet();
        sda.Fill(ds, "js_htpsbH");
        GridView2.DataSource = ds;
        GridView2.DataBind();
        GridView2.DataKeyNames = new String[] { "BH" };
        sqlcon.Close();

    }

    //会签中单元格着色
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            //对应GridView的列，按照gridview列顺序排位，如果不需要标记的为""
            string[] a = { "", "", "pmchqzt", "gchqzt", "sbhqzt", "zlhqzt", "zzhqzt", "packhqzt", "gylhqzt", "sczjhqzt", "zghqzt", "swjlhqzt" };
            for (int i = 0; i < a.Length; i++) {
                //a[i]不为空,即只能有效字段
                if (!a[i].Equals("")) {
                    if (drv[a[i]].ToString().Equals("会签中")) {
                        e.Row.Cells[i].Style.Add("color", "white");
                        e.Row.Cells[i].Style.Add("background-color", "Red");
                    }
                }
            }
        }
    }

    //打印单据
    protected void lbPrint_Click(object sender, EventArgs e) {
        //打印列
        string bhList = "";
        for (int i = 0; i < GridView1.Rows.Count; i++) {
            CheckBox cbPrint = GridView1.Rows[i].FindControl("cbPrint") as CheckBox;
            if (cbPrint.Checked) {
                bhList = bhList + GridView1.Rows[i].Cells[5].Text + ",";
            }
        }


        if (!bhList.Equals("")) {
            sqlcon.Open();
            string sqlstr = "update js_htpsbH set dyzt=isnull(dyzt,'')+'" + Session["username"].ToString() + "'+'-'+'" + DateTime.Now.ToString("yyyy-MM-dd") + "'+';' where charindex(bh,'" + bhList + "')>0 ";
            sqlcom = new SqlCommand(sqlstr, sqlcon);
            sqlcom.ExecuteNonQuery();
            sqlcon.Close();
            Response.Write("<script>window.open('rpt/htpsbPrint.aspx?bh=" + bhList + "','_blank')</script>");
        }


    }

    //列表变更，重填COOKIE，列隐藏还是显示
    protected void cblTitleList_SelectedIndexChanged(object sender, EventArgs e) {
        string titleLists = "";
        for (int i = 0; i < cblTitleList.Items.Count; i++) {
            if (cblTitleList.Items[i].Selected) {
                titleLists = titleLists + cblTitleList.Items[i].Value + ",";
            }
        }

        HttpCookie hc = Response.Cookies["htpsbTitleList"];
        hc.Value = titleLists;
        hc.Expires = DateTime.Now.AddDays(365);
        Response.AppendCookie(hc);

        string[] titleList = titleLists.Split(',');
        for (int i = 0; i < cblTitleList.Items.Count; i++) {
            if ((titleList as IList).Contains(cblTitleList.Items[i].Value)) {
                GridView1.Columns[i + 5].Visible = true;
            }
            else {
                GridView1.Columns[i + 5].Visible = false;
            }
        }

    }




}
