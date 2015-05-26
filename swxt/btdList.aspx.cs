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

public partial class btdList : System.Web.UI.Page {
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



            bind();
        }


    }


    public void bind() {
        string GroupNames = Session["GroupNames"].ToString();
        UserName = Session["UserName"].ToString();
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = "select convert(varchar(10),jbrq,120) jbrq,case when lchqzt='已完成' then 1 else 0 end hqsx,* from js_btdH where " +
                 "   ('超级用户'='" + GroupNames + "'  " +
                 "     or tc='" + UserName + "'" +
                 "     or (charindex('生产补投单-PMC审核','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or PMCHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-质量部审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-工程部审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or GCHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-制造部审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZZHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-设备部审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or SBHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-生产总监审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or SCZJHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-总工审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZGHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-供应链审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or GYLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-商务经理审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or SWJLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('生产补投单-总经理助理审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZJLZLHQZT='" + ddlHqzt.Text + "' ))  " +
                 "     or (charindex('生产补投单-查看组','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' )) )" +
                 "  order by hqsx,jbrq desc ";



        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_btdH");
        GridView1.DataSource = myds;

        //查询过滤
        string filterStringKhdm = tbKhdm.Text.Equals("") ? "" : "and khdm like '%" + tbKhdm.Text.Trim() + "%'";
        string filterStringNbdxxh = tbNbdxxh.Text.Equals("") ? "" : "and nbdxxh like '%" + tbNbdxxh.Text.Trim() + "%'";
        string filterStringNbpackxh = tbNbpackxh.Text.Equals("") ? "" : "and nbpackxh like '%" + tbNbpackxh.Text.Trim() + "%'";
        string filterString = filterStringKhdm + filterStringNbdxxh + filterStringNbpackxh;
        if (!filterString.Equals("")) {
            DataTable dt = (GridView1.DataSource as DataSet).Tables[0];
            filterString = filterString.Substring(4, filterString.Length - 4);
            dt.DefaultView.RowFilter = filterString;
            GridView1.DataSource = dt;
        }

        GridView1.DataKeyNames = new string[] { "bh" };
        GridView1.DataBind();


        sqlcon.Close();


    }




    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("btdEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + "&lb=EDIT&editType=" + (GridView1.Rows[e.NewEditIndex].Cells[1].Controls[0] as LinkButton).Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];
            if (ddlHqzt.Text != "会签中") {
                btnEdit.Text = "查看";
            }
            else if ("会签中" == ddlHqzt.Text) {
                btnEdit.Text = "编辑";
            }



        }



        /* 行颜色转换
        if (e.Row.RowType == DataControlRowType.DataRow) {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["llzt"].ToString();
            if (result == "注销")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC");
        }*/
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void lbQuery_Click(object sender, EventArgs e) {
        bind();
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
        Response.Redirect("btdEdit.aspx?lb=ADD");//只有发起人才能新建表单
    }

    //删除行
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        string sqlstr = "delete from js_btdH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        cmd.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }
    protected void ddlHqzt_SelectedIndexChanged(object sender, EventArgs e) {
        bind();
    }
}
