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
        string groupNames = Session["GroupNames"].ToString();
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = "select * from js_btdH";



        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_btdH");
        GridView1.DataSource = myds;

        //查询过滤
        string filterStringKhdm = tbKhdm.Text.Equals("") ? "" : "and khdm like '%" + tbKhdm.Text.Trim() + "%'";
        string filterStringNbdxxh = tbNbdxxh.Text.Equals("") ? "" : "and nbdxxh like '%" + tbNbdxxh.Text.Trim() + "%'";
        string filterStringNbpackxh = tbNbpackxh.Text.Equals("") ? "" : "and nbpackxh like '%" + tbNbpackxh.Text.Trim() + "%'";
        string filterStringKhddh = tbKhddh.Text.Equals("") ? "" : "and khddh like '%" + tbKhddh.Text.Trim() + "%'";
        string filterString = filterStringKhdm + filterStringNbdxxh + filterStringNbpackxh + filterStringKhddh;
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
        /*if (e.Row.RowType == DataControlRowType.DataRow) {
            DataRowView drv = e.Row.DataItem as DataRowView;
            //
            if (drv["bgzt"].ToString().Equals("变更中")) {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFF99");
            
            }
        }

        /*if (e.Row.RowType == DataControlRowType.DataRow) {
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
}
