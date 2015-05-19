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

public partial class thdList : System.Web.UI.Page
{
    string UserName = "";
    string GroupNames = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    string djlx = "";
    protected void Page_Load(object sender, EventArgs e) {
       
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
        sqlStr = " select djlsh,BH,case when gc='1' then '新桥工厂' when gc='2' then '东洲工厂' else  '' end GC,GYSMC,PH,WLMC,GG,sl+'('+DW+')' sl from dbo.js_thdH " +
                 "    where ('超级用户'='" + GroupNames + "' or charindex('退货单-IQC','" + GroupNames + "')>0 )" +
                 "     or (charindex('退货单-采购员','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or CGHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('退货单-仓管员','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or CKHQZT='" + ddlHqzt.Text + "' )) ";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_thdH");

        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "djlsh" };
        GridView1.DataBind();

        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        string sqlstr = "delete from js_thdH where djlsh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("thdEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=EDIT");
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {

        if (e.Row.RowType == DataControlRowType.DataRow) {
            LinkButton btnDel = (LinkButton)e.Row.Cells[9].Controls[0];//删除
            btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(物料名称: " + (e.Row.Cells[2].Text) + " 吗)'); ");
        }

    }

    protected void tjbd_Click(object sender, EventArgs e) {
        Response.Redirect("thdEdit.aspx?lb=ADD&editType=&djlx="+djlx);//只有发起人才能新建表单

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void ddlHqzt_SelectedIndexChanged(object sender, EventArgs e) {
        bind();
    }
}
