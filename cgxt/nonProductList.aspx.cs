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

public partial class nonProductList : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    string djlx = "";
    protected void Page_Load(object sender, EventArgs e) {
        //获取单据类型
        djlx = Request["djlx"];
        if (djlx.Equals("SLD")) {
            lblTitle.Text = "收料单列表";
            lbtnAdd.Text = "添加收料单";

        }
        else if (djlx.Equals("LLD")) {
            lblTitle.Text = "领料单列表";
            lbtnAdd.Text = "添加领料单";

        }
        else if (djlx.Equals("TLD")) {
            lblTitle.Text = "退料单列表";
            lbtnAdd.Text = "添加退料单";

        }
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
        sqlStr = "  select  a.DjLsh,DjState,DJLX,JBRQ,BM,case when GC='1' then '新桥工厂' else '东洲工厂' end GC,WLBH,c.WZMC dlmc,b.WZMC,GG,SL,DW,GYS,KCL,CW,HJH,BZ,JE from "
                 + " dbo.js_fscclglH a left join dbo.js_wzflbH b on a.WLLB=b.DL and a.WLMC=b.XL left join dbo.js_wzflbH c on a.WLLB=c.XL and c.DL='000' where "
                 +" djlx='" + djlx + "' order by a.djlsh desc";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_fscclglH");

        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "djlsh" };
        GridView1.DataBind();

        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        string sqlstr = "delete from js_fscclglH where djlsh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("nonProductEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=EDIT&djlx="+djlx);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {

        if (e.Row.RowType == DataControlRowType.DataRow) {
            LinkButton btnDel = (LinkButton)e.Row.Cells[9].Controls[0];//删除
            btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(物料名称: " + (e.Row.Cells[2].Text) + " 吗)'); ");
        }

    }

    protected void tjbd_Click(object sender, EventArgs e) {
        Response.Redirect("nonProductEdit.aspx?lb=ADD&editType=全部&djlx="+djlx);//只有发起人才能新建表单

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
}
