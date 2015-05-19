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

public partial class cpkftaList : System.Web.UI.Page {
    string UserName = "";
    string GroupNames = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    string djlx = "";
    protected void Page_Load(object sender, EventArgs e) {
        djlx = Request.QueryString["djlx"];
        if (djlx.Equals("GGS")){
            tdTitle.InnerText = "电子规格书列表";
            lblTdys.Visible = true;
            lblTdysTitle.Visible = true;
            lblYwyyxg.Visible = true;
            lblYwyyxgTitle.Visible = true;
            lbTjbd.Text = "添加电子规格书";
        }
        if (Session["username"] != null) {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupNames = Session["GroupNames"].ToString();
        }
        else {
            Response.Redirect("~/Login.aspx");
        }

        bind();


    }

    public void bind() {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        //产品开发提案
        if (djlx.Equals("CPKFTA")) {
            sqlStr = "select bh,jbrq,lchqzt,khxh,khdm,xsry,KHXH,CPZT,BCRL+'mAh' BCRL,nbxh " +
                     " from dbo.js_cpkftaH a " +
                     " where  substring(bh,1,4)='JSTA' and ('超级用户'='" + GroupNames + "'  or  a.XSRY='" + UserName + "'" +
                     "     or (dbo.js_func_hasgroup('产品开发提案','" + UserName + "',a.XSRy,'')=1 and ('" + ddlHqzt.Text + "'='全部' or XSJLHQZT='" + ddlHqzt.Text + "')) " +
                     "     or (charindex('产品开发提案-商务经理审核','" + GroupNames + "'  )>0 and ('" + ddlHqzt.Text + "'='全部' or SWJLHQZT='" + ddlHqzt.Text + "' )) " +
                     "     or (charindex('产品开发提案-总工审核','" + GroupNames + "'  )>0 and ('" + ddlHqzt.Text + "'='全部' or ZGHQZT='" + ddlHqzt.Text + "' )) " +
                     "     or (charindex('产品开发提案-工程师','" + GroupNames + "'  )>0   and ('" + ddlHqzt.Text + "'='全部') ) ) " +
                     "  order by jbrq desc,bh desc";

        } 
        //规格书
        else if (djlx.Equals("GGS")){
            sqlStr = "select bh,jbrq,lchqzt,khxh,khdm,xsry,KHXH,CPZT,BCRL+'mAh' BCRL,nbxh " +
                       " from dbo.js_cpkftaH a " +
                       " where  substring(bh,1,5)='JSGGS' and ('超级用户'='" + GroupNames + "'  or  a.XSRY='" + UserName + "'" +
                       "     or (dbo.js_func_hasgroup('产品开发提案','" + UserName + "',a.XSRy,'')=1 and ('" + ddlHqzt.Text + "'='全部' or XSJLHQZT='" + ddlHqzt.Text + "')) " +
                       "     or (charindex('电子规格书-电芯工程师','" + GroupNames + "'  )>0 and ('" + ddlHqzt.Text + "'='全部' or SWJLHQZT='" + ddlHqzt.Text + "' )) " +
                       "     or (charindex('电子规格书-PACK工程师','" + GroupNames + "'  )>0 and ('" + ddlHqzt.Text + "'='全部' or ZGHQZT='" + ddlHqzt.Text + "' )) " +
                       "     or (charindex('产品开发提案-实验室审核','" + GroupNames + "'  )>0   and ('" + ddlHqzt.Text + "'='全部' or SYSHQZT='" + ddlHqzt.Text + "' )) )" +
                       "  order by jbrq desc,bh desc";
        }

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_cpkftaH");

        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "BH" };
        GridView1.DataBind();

        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        string sqlstr = "delete from js_cpkftaH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("cpkftaEdit.aspx?djlx="+djlx+"&xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=EDIT" + "&editType=" + ddlHqzt.Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];//编辑
            LinkButton btnDel = (LinkButton)e.Row.Cells[2].Controls[0];//删除
            if (ddlHqzt.Text != "会签中") {//只有会签中的记录才能更改
                btnEdit.Text = "查看";
                btnDel.Enabled = false;
            }
            else if ("会签中" == ddlHqzt.Text) {
                btnEdit.Text = "编辑";
                sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
                sqlcon.Open();
                String sqlstr = "select dbo.js_func_hasgroup('产品开发提案','" + Session["username"].ToString() + "','','销售人员') qx ";
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
                sqlcon.Close();
                sdr.Close();
                btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");

            }


        }
        foreach (TableCell tc in e.Row.Cells) {
            tc.Attributes["style"] = "border-color:Black";
        }


        if (e.Row.RowType == DataControlRowType.DataRow) {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["lchqzt"].ToString();
            if (result == "已完成") {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC");
            } else if (result=="退回业务员处理"){
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
            }else if (result == "业务员已修改") {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#CCFFFF");
            }
        }
    }

    protected void tjbd_Click(object sender, EventArgs e) {
        sqlcon.Open();
        String sqlstr = "select dbo.js_func_hasgroup('产品开发提案','" + Session["username"].ToString() + "','','销售人员') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("1" == sdr["qx"].ToString()) {
                    Response.Redirect("cpkftaEdit.aspx?djlx="+djlx+"&lb=ADD");//只有发起人才能新建表单
                }
                else {
                    Response.Write("<script>alert('您没有添加产品开发提案书的权限!');</script>");
                }
            }
        }
        sqlcon.Close();
        sdr.Close();
        bind();

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void btnCX_Click(object sender, EventArgs e) {
        bind();
    }

}
