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

public partial class cgdListDel : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else {
                Response.Redirect("Login.aspx");
            }

            bind();
        }


    }

    public void bind() {
        string groupNames = Session["GroupNames"].ToString();
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = " select a.*,b.GYSMC from dbo.js_cgdH a left join dbo.js_gysglH b on a.GYSDM=b.GYSDM order by a.GYSDM,JBRQ desc ";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_cgdH");

        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "DJLSH" };
        GridView1.DataBind();


        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        string sqlDel = "delete from js_cgdH where djlsh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        SqlCommand cmd = new SqlCommand(sqlDel, sqlcon);
        cmd.ExecuteNonQuery();
        sqlcon.Close();

        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("cgdEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString()+"&lb=EDIT&editType=" + ddlHqzt.Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {

        if (e.Row.RowType == DataControlRowType.DataRow) {
            LinkButton btnDel = (LinkButton)e.Row.Cells[2].Controls[0];//删除
            btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");
            LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];
            if (ddlHqzt.Text.Equals("已审核")) {
                btnEdit.Text = "查看";
                btnDel.Enabled = false;
            }
            /*else {
                sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
                sqlcon.Open();
                String sqlstr = "select dbo.js_func_hasgroup('领料退料单','" + Session["username"].ToString() + "','','领料退料员') qx ";
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
            }*/




        }


        /* 行颜色转换
        if (e.Row.RowType == DataControlRowType.DataRow) {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["llzt"].ToString();
            if (result == "已完成")
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
        Response.Redirect("cgdEdit.aspx?lb=ADD&editType=" + ddlHqzt.Text);//只有发起人才能新建表单



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
}
