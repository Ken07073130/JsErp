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

public partial class stcd_cdgl : System.Web.UI.Page
{
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    string UserName = "";
    string GroupID = "";
    string IsAdministrator = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                IsAdministrator = Session["IsAdministrator"].ToString();
                if (GroupID.IndexOf("hasgroup(食堂菜单管理)") == -1 && IsAdministrator != "1" )
                {
                    Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
            bind();
        }
    }
    public void bind()
    {
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        string sql = "SELECT id, convert(varchar(10),rq,120) rq,cm,dj,sl FROM js_mrcd order by id desc";
        SqlDataAdapter myda = new SqlDataAdapter(sql, sqlcon);
        DataSet myds = new DataSet();
        myda.Fill(myds, "js_mrcd");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "id" };
        GridView1.DataBind();
        sqlcon.Close();
    }

    protected void B_TJ_Click(object sender, EventArgs e)
    {
        string  cm = T_CM.Text.Trim();
        string  dj = T_DJ.Text.Trim();
        string  sl = T_SL.Text.Trim();
        string  rq = T_RQ.Text.Trim();
        if (dj == "")//如果单价是则写入0
        {
            dj = "0";
        }
        if (sl == "") //如果数量是空则写入0
        {
            sl = "0";
        }
        string sqlstr = "insert into js_mrcd (cm,dj,sl,rq,mrbh ) select '" + cm + "'," + dj + "," + sl + ",'" + rq + "', count(*)+1 as mrbh from js_mrcd where rq ='" + rq + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        T_CM.Text = "";
        T_DJ.Text = "0.00";
        T_SL.Text = "300";
        bind();

    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "delete   js_mrcd  where id=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        bind();
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string id = GridView1.DataKeys[e.RowIndex].Value.ToString();
        string cm = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("T_cmEdit")).Text;
        string dj = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("T_djEdit")).Text;
        string sl = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("T_slEdit")).Text;
        string rq = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("T_rqEdit")).Text;
        if (dj == "") //如果单价是则写入0
        {
            dj = "0";
        }
        if (sl == "") //如果数量是空则写入0
        {
            sl = "0";
        }

        string strUpdate = "UPDATE js_mrcd set cm='" + cm + "',dj=" + dj + ",sl="+ sl +",rq='"+ rq +"' where id=" + id;

        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(strUpdate, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        GridView1.EditIndex = -1;
        bind();

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void logout_Click(object sender, ImageClickEventArgs e)
    {
        //清空session后返回到登录页。
        Session.RemoveAll();
        Response.Redirect("../Login.aspx");
    }


}
