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

public partial class ddfhList : System.Web.UI.Page {
    string UserName = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
           // Session.Add("username", "吴锦涛");
            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            }
            else {
                Response.Redirect("Login.aspx");
            }

            bind();
        }


    }


    public void bind() {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = "select *,'' dyzt from dbo.js_ddfhH where '" + Session["UserName"].ToString() + "'=ywy or charindex('样品综合评审单-商务经理审核','"+Session["GroupNames"].ToString()+"')>0 order by djlsh desc";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_ddfhH");

        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "BH" };
        GridView1.DataBind();


        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        string sqlDelMain = "delete from js_ddfhH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        string sqlDelSons = "delete from js_ddfh_fhlbH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        SqlTransaction sqlTran = sqlcon.BeginTransaction();
        try {
            sqlcom = new SqlCommand(sqlDelMain, sqlcon);
            sqlcom.Transaction = sqlTran;
            sqlcom.ExecuteNonQuery();
            sqlcom = new SqlCommand(sqlDelSons, sqlcon);
            sqlcom.Transaction = sqlTran;
            sqlcom.ExecuteNonQuery();
            sqlTran.Commit();
        }
        catch (Exception exp) {
            sqlTran.Rollback();
            Response.Write(exp.Message);
        }
        finally {
            sqlcon.Close();
            sqlTran.Dispose();
        }

        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("ddfhEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=EDIT&editType=" + ddlHqzt.Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {

        /*if (e.Row.RowType == DataControlRowType.DataRow) {
            LinkButton btnDel = (LinkButton)e.Row.Cells[2].Controls[0];//删除
            btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");
            LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];
            CheckBox cb = e.Row.FindControl("CheckBox1") as CheckBox;
            //只有已完成的项才能勾选打印
            if (e.Row.Cells[9].Text.Equals("已完成")) {
                cb.Enabled = true;
            }
            else {
                cb.Enabled = false;
            }
            if (ddlHqzt.Text.Equals("全部")) {
                btnEdit.Text = "查看";
                btnDel.Enabled = false;
            }
            else {
                sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
                sqlcon.Open();
                String sqlstr = "select dbo.js_func_hasgroup('收料单','" + Session["username"].ToString() + "','','收料员') qx ";
                SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
                SqlDataReader sdr = cmd.ExecuteReader();
                if (sdr.HasRows) {
                    while (sdr.Read()) {
                        if ("1" == sdr["qx"].ToString()) {
                            btnDel.Enabled = true;//只有发起人有删除权限
                        }
                        else {
                            btnDel.Enabled = false;//不是发起人不能删除单据
                        }
                    }
                }

                sdr.Close();
                sqlcon.Close();
            }

        }


        // 行颜色转换
        if (e.Row.RowType == DataControlRowType.DataRow) {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["slzt"].ToString();
            if (result == "已完成") {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC");
                //cb.Enabled = true;
            }

        }*/
    }

    protected void tjbd_Click(object sender, EventArgs e) {
        /*sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        String sqlstr = "select dbo.js_func_hasgroup('收料单','" + Session["username"].ToString() + "','','收料员') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("1" == sdr["qx"].ToString()) {
                    Response.Redirect("sldEdit.aspx?lb=ADD&editType=1");//只有发起人才能新建表单
                }
                else {
                    Response.Write("<script>alert('您没有添加收料单的权限!');</script>");
                }
            }
        }
        sqlcon.Close();
        sdr.Close();
        bind();*/
        Response.Redirect("ddfhEdit.aspx?lb=ADD");//只有发起人才能新建表单
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void btnCX_Click(object sender, EventArgs e) {
        bind();
    }




}
