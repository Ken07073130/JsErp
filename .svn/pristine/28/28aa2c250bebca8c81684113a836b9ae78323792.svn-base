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

public partial class cgdList : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon;
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else {
                Response.Redirect("Login.aspx");
            }

            ViewState["SortOrder"] = "default";
            ViewState["OrderDire"] = "ASC";
           

            bind();
        }
      

    }

    //填充弹出框
    public void drawDetails(Table tb,Label lb,string gysdm) {
        SqlConnection sqlcon_detail = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon_detail.Open();
        string sqlstr = "select GYSDM,GYSMC,JBRQ,a.BH,a.BB,c.wlmc,b.JHSL,c.dw from dbo.js_tldH a,dbo.js_tldwzxhdeH b left join dbo.v_wlxx c on b.WLBH=c.wlbh "
                         + " where CGXQ=1 and TDZT<>1 and CGZT=0 and sfbg=0 and a.PSDBH=b.PSDBH and a.BB=b.TLBB and GYSDM='" + gysdm + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon_detail);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows) {
            TableHeaderRow tr_h = new TableHeaderRow();
            TableHeaderCell td_h_bh = new TableHeaderCell();
            TableHeaderCell td_h_tlrq = new TableHeaderCell();
            TableHeaderCell td_h_tldh = new TableHeaderCell();
            TableHeaderCell td_h_bb = new TableHeaderCell();
            TableHeaderCell td_h_wlmc = new TableHeaderCell();
            TableHeaderCell td_h_sl = new TableHeaderCell();
            TableHeaderCell td_h_dw = new TableHeaderCell();

            td_h_bh.Text = "编号";
            td_h_tlrq.Text = "套料日期";
            td_h_tldh.Text = "套料单号";
            td_h_bb.Text = "版本";
            td_h_wlmc.Text = "物料名称";
            td_h_sl.Text = "数量";
            td_h_dw.Text = "单位";
            tr_h.Cells.Add(td_h_bh);
            tr_h.Cells.Add(td_h_tlrq);
            tr_h.Cells.Add(td_h_tldh);
            tr_h.Cells.Add(td_h_bb);
            tr_h.Cells.Add(td_h_wlmc);
            tr_h.Cells.Add(td_h_sl);
            tr_h.Cells.Add(td_h_dw);

            tb.Rows.Add(tr_h);
            while (sdr.Read()) {
                /* +" <tr><th style='width:5%; height: 28px;'>编号</th>"
                                              + " <th style='width:10%; height: 28px;'>套料日期</th>"
                                              + " <th style='width:15%; height: 28px;'>套料单号</th>"
                                              + " <th style='width:10%; height: 28px;'>版本</th>"
                                              + " <th style='width:10%; height: 28px;'>物料名称</th>"
                                              + " <th style='width:10%; height: 28px;'>数量</th>"
                                              + " <th style='width:10%; height: 28px;'>单位</th></tr>";*/

                TableRow tr = new TableRow();
                TableCell td_bh = new TableCell();
                TableCell td_tlrq = new TableCell();
                TableCell td_tldh = new TableCell();
                TableCell td_bb = new TableCell();
                TableCell td_wlmc = new TableCell();
                TableCell td_sl = new TableCell();
                TableCell td_dw = new TableCell();

                td_bh.Text = "1";
                td_tlrq.Text = sdr["JBRQ"].ToString();
                td_tldh.Text = sdr["BH"].ToString();
                td_bb.Text = sdr["BB"].ToString();
                td_wlmc.Text = sdr["wlmc"].ToString();
                td_sl.Text = sdr["JHSL"].ToString();
                td_dw.Text = sdr["dw"].ToString();


                tr.Cells.Add(td_bh);
                tr.Cells.Add(td_tlrq);
                tr.Cells.Add(td_tldh);
                tr.Cells.Add(td_bb);
                tr.Cells.Add(td_wlmc);
                tr.Cells.Add(td_sl);
                tr.Cells.Add(td_dw);
                tb.Rows.Add(tr);

            }

        }
        sqlcon_detail.Close();
        lb.Attributes["onmousemove"] = "showDiv('" + tb.ClientID + "')";
        lb.Attributes["onmouseout"] = "hideDiv('" + tb.ClientID + "')";
    }

    public void bind() {
        string groupNames = Session["GroupNames"].ToString();
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = "select 0 djlsh,'编号未生成' bh,c.GYSDM,c.GYSMC,convert(varchar(30),sum(convert( float,JHSL))) +'('+ min(c.dw)+ ')' sl,'' dw,'' JBRQ,'未生成' sczt from dbo.js_tldH a,dbo.js_tldwzxhdeH b left join dbo.v_wlxx c on b.WLBH=c.wlbh "
                + "   where CGXQ=1 and TDZT<>1 and CGZT=0 and sfbg=0 and GYSDM is not null "
                + "   and a.PSDBH=b.PSDBH and a.BB=b.TLBB "
                + "   group by c.GYSDM,c.GYSMC "
                + "   union all "
                + "   select a.djlsh,a.BH ,a.GYSDM,b.GYSMC,case when dyzt=0 then '未打印' else '已打印' end  sl,'' dw,JBRQ,case when sfzx=1 then '已注销' else '已生成' end sczt  from dbo.js_cgdH a left join dbo.js_gysglH b on a.GYSDM=b.GYSDM ";
               // + "   order by sczt,GYSDM,BH ";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_cgdH");
        if (ViewState["SortOrder"].ToString() == "default") {
            myds.Tables[0].DefaultView.Sort = "sczt,GYSDM,BH ";
        }
        else {
            myds.Tables[0].DefaultView.Sort = ViewState["SortOrder"] + " " + ViewState["OrderDire"];
        }
        if (ViewState["fliter"] != null) {
            myds.Tables[0].DefaultView.RowFilter = ViewState["fliter"].ToString();
        }
      
        //要排序必须绑定DefaultView
        GridView1.DataSource = myds.Tables[0].DefaultView;
        GridView1.DataKeyNames = new string[] { "DJLSH" };
        GridView1.DataBind();


        sqlcon.Close();


    }

    

    //注销单据
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        SqlTransaction sqlTran = sqlcon.BeginTransaction();
        try {
            //更新标记为已注销
            string sqlDel = "update js_cgdH set sfzx=1 where djlsh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
            SqlCommand cmd = new SqlCommand(sqlDel, sqlcon);
            cmd.Transaction = sqlTran;
            cmd.ExecuteNonQuery();

            //更新套料单的相应物料为未套料
            string sqlUpdate =  "    update dbo.js_tldwzxhdeH set CGZT=0 "
                              + " from (    "
	                          + "    select b.TLDH,b.WLBH from dbo.js_cgdH a,dbo.js_cgd_cglyH b "
                              + "    where a.BH=b.CGDBH and a.DjLsh=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + " ) x "
                              + " where exists ( "
                              + "     select 1 from dbo.js_tldH a where js_tldwzxhdeH.PSDBH=a.PSDBH and TLBB=a.BB and a.SFBG=0 "
                              + "       and a.BH=x.TLDH and js_tldwzxhdeH.WLBH=x.WLBH "
                              + " ) " ;
            cmd = new SqlCommand(sqlUpdate, sqlcon);
            cmd.Transaction = sqlTran;
            cmd.ExecuteNonQuery();
            sqlTran.Commit();
        }
        catch (Exception ex) {
            sqlTran.Rollback();
        }
        finally {

            sqlcon.Close();
        }
       
       
        
       

        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("cgdEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + "&lb=EDIT&editType=" + (GridView1.Rows[e.NewEditIndex].Cells[1].Controls[0] as LinkButton).Text + "&gysdm=" + GridView1.Rows[e.NewEditIndex].Cells[3].Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {

        if (e.Row.RowType == DataControlRowType.DataRow) {
            e.Row.Cells[0].Attributes["onmousemove"] = "showDiv('div" + e.Row.Cells[3].Text + "')";
            e.Row.Cells[0].Attributes["onmouseout"] = "hideDiv('div" + e.Row.Cells[3].Text + "')";
            Table tb = e.Row.FindControl("Table1") as Table;
            Label lb = e.Row.FindControl("lblDetail") as Label;
            LinkButton btnEdit = e.Row.Cells[1].Controls[0] as LinkButton;
            LinkButton btnDel = e.Row.Cells[11].Controls[0] as LinkButton;
            Button btnPrint = e.Row.FindControl("btnPrint") as Button;
            btnDel.Attributes.Add("onclick ", "return confirm( '确定注销采购单(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");
           // sqlcon.Open();

            btnDel.Visible = false;
            btnPrint.Visible = false;
            if (e.Row.Cells[8].Text.Equals("未生成")) {
                drawDetails(tb, lb, e.Row.Cells[3].Text);
                btnEdit.Text = "生成订单";
            }
            else if (e.Row.Cells[8].Text.Equals("已注销")) {
                btnEdit.Text = "查看";
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FF6666");
            }
            else {
                btnDel.Visible = true;
                btnPrint.Visible = true;
                if (e.Row.Cells[5].Text.Equals("已打印")){
                    btnEdit.Text = "查看";
                } else {
                    btnEdit.Text = "编辑";
                }
            }
            
            string bh = e.Row.Cells[0].Text.Replace("#", "*");
            btnPrint.OnClientClick = "printCgd('" + bh + "')";

        }



        /* 行颜色转换
        if (e.Row.RowType == DataControlRowType.DataRow) {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["llzt"].ToString();
            if (result == "注销")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC");
        }*/
    }

    protected void tjbd_Click(object sender, EventArgs e) {
        /*sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        String sqlstr = "select dbo.js_func_hasgroup('领料退料单','" + Session["username"].ToString() + "','','领料退料员') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("1" == sdr["qx"].ToString()) {
                    Response.Redirect("lltldEdit.aspx?lb=ADD" + "&djlx=" + djlx + "&editType=" + ddlHqzt.Text);//只有发起人才能新建表单
                }
                else {
                    Response.Write("<script>alert('您没有添加领料退料单的权限!');</script>");
                }
            }
        }
        sqlcon.Close();
        sdr.Close();
        bind();*/
        //Response.Redirect("cgdEdit.aspx?lb=ADD&editType=" + ddlHqzt.Text+"&gysdm=-999");//只有发起人才能新建表单



    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void btnCX_Click(object sender, EventArgs e) {
        bind();
    }
    protected void btnPrint_Click(object sender, EventArgs e) {
        string bhList = "";
        for (int i = 0; i < GridView1.Rows.Count; i++) {
            CheckBox chk = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            string bh1 = GridView1.DataKeys[i].Value.ToString();
            if (chk.Checked == true) {
                string bh = GridView1.DataKeys[i].Value.ToString();
                bhList = bhList + "," + bh;
            }

        }

        Response.Write("<script>window.open('rpt/lltldPrint.aspx?bh=" + bhList + "','_blank')</script>");
    }
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e) {
       
        string sPage = e.SortExpression;
         
        if (ViewState["SortOrder"].ToString() == sPage) {

            if (ViewState["OrderDire"].ToString() == "Desc")

                ViewState["OrderDire"] = "ASC";

            else

                ViewState["OrderDire"] = "Desc";

        }
        else {
            ViewState["SortOrder"] = e.SortExpression;

        }

        bind();

    }
    protected void tbGysdm_TextChanged(object sender, EventArgs e) {
        if (tbGysdm.Text.Trim().Equals("")) {
            ViewState["fliter"] = null;
        }
        else {
            ViewState["fliter"] = "gysdm like '%" + tbGysdm.Text + "%' or gysmc like '%" + tbGysdm.Text + "%'";
        }
        bind();
    }
}
