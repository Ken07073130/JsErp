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

public partial class tldList : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e) {
        if (Session["username"] != null) {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();
        }
        else {
            Response.Redirect("~/Login.aspx");
        }

        bind();


    }

    public void bind() {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = "select a.psdbh,a.packxh,a.BH,a.JBRQ,TLZT,case when ( a.SCZT = '已生成' and cast(a.PSDBB as float) < cast(b.bb as float)) then '已生成需变更' else a.SCZT end SCZT ,b.khddh ddh,a.KHDM,a.DDL,a.TCL,a.DXXH,case when a.tlzt='请选择' then 0 else 1 end hqsx from dbo.js_tldH a left join  dbo.js_htpsb_newH b on a.PSDBH=b.psdbh  where SFBG=0 order by hqsx,tlzt,a.jbrq desc";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_tldH");

        GridView1.DataSource = myds;
        //查询过滤
        string filterStringPsdbh = tbPsdbh.Text.Equals("") ? "" : "and psdbh like '%" + tbPsdbh.Text.Trim() + "%'";
        string filterStringDxxh = tbDxxh.Text.Equals("") ? "" : "and dxxh like '%" + tbDxxh.Text.Trim() + "%'";
        string filterStringKhdm = tbKhdm.Text.Equals("") ? "" : "and khdm like '%" + tbKhdm.Text.Trim() + "%'";
        string filterString = filterStringPsdbh + filterStringDxxh + filterStringKhdm;
        if (!filterString.Equals("")) {
            DataTable dt = (GridView1.DataSource as DataSet).Tables[0];
            filterString = filterString.Substring(4, filterString.Length - 4);
            dt.DefaultView.RowFilter = filterString;
            GridView1.DataSource = dt;
        }


        GridView1.DataKeyNames = new string[] { "BH" };
        GridView1.DataBind();




        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        string sqlstr = "delete from js_tldH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("tldEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=EDIT");
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {

        if (e.Row.RowType == DataControlRowType.DataRow) {
            LinkButton btnDel = (LinkButton)e.Row.Cells[2].Controls[0];//删除
            btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");


        }


        // 行颜色转换
        if (e.Row.RowType == DataControlRowType.DataRow) {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["tlzt"].ToString();
            if (result == "已生成") 
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC");
            else if (result == "已生成需变更")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#CC0033");
        }
    }

    protected void tjbd_Click(object sender, EventArgs e) {

        Response.Redirect("tldEdit.aspx?lb=ADD");//只有发起人才能新建表单

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void lbQuery_Click(object sender, EventArgs e) {
        bind();
    }
}
