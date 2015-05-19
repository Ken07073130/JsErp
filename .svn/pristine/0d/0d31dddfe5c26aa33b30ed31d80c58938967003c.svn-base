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
        string sql = "SELECT id, convert(varchar(10),rq,120) rq, lx,sl FROM js_mrsttj order by id desc";
        SqlDataAdapter myda = new SqlDataAdapter(sql, sqlcon);
        DataSet myds = new DataSet();
        myda.Fill(myds, "js_mrsttj");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "id" };
        GridView1.DataBind();
        sqlcon.Close();
    }

    protected void B_TJ_Click(object sender, EventArgs e)
    {
        string sl = T_SL.Text.Trim();
        string lx = T_LX.Text.Trim();
        string  rq = T_RQ.Text.Trim();
        if (sl == "")//如果单价是则写入0
        {
            sl = "0";
        }

        string sqlstr = "insert into js_mrsttj (lx,sl ,rq) values ( '"+ lx +"'," + sl + ",'" + rq + "')  ";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        T_SL.Text = "";

        bind();

    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "delete js_mrsttj  where id=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "";
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
        string sl = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("T_slEdit")).Text;
        string lx = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("T_lxEdit")).Text;
        string rq = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("T_rqEdit")).Text;
        if (sl == "") //如果单价是则写入0
        {
            sl = "0";
        }


        string strUpdate = "UPDATE js_mrsttj set sl=" + sl + ",lx='" + lx + "',rq='" + rq + "' where id=" + id;

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

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (DataControlRowType.DataRow == e.Row.RowType)
        {
            e.Row.Cells[1].Text = e.Row.Cells[1].Text + "人";


        }

        //if (e.Row.RowType == DataControlRowType.Footer)
        //{
        //    e.Row.Cells[0].Text = "合计数量：";
        //    // dt即数据源DataTable  
        //    e.Row.Cells[2].Text = myds.Tables[0].Compute("sum(sl)", "").ToString() + "份";
        //}  

    }

}
