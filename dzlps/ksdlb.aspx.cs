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

public partial class ksdlb : System.Web.UI.Page
{
    //SVN提交测试
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserName = Session["username"].ToString();   //取出session里面的相应用户权限
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        string sql = "SELECT djmc,djssyhz	FROM js_rsxxb  b left JOIN js_rsxxf f ON b.bmid=f.ssbmid WHERE ry='" + UserName + "' and djmc='质量投诉处理单'";
        sqlcom = new SqlCommand(sql, sqlcon);
        SqlDataReader sdr = sqlcom.ExecuteReader();
        while (sdr.Read())
        {
            GroupID += "hasgroup(" + sdr["djssyhz"].ToString().Trim() + ");";
        }
        sqlcon.Close();
        if (!IsPostBack)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            bind();
            
        }


    }

    public void bind()
    {
        string sqlStr = "";
        
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);

        sqlStr = "select djlsh,lchqzt,tsbh,thsl,sdthrq,cpph,khdm,cpxh,chsl,chrq,swbhqzt,zlbhqzt,shhqzt,chtjhqzt,dqzt,dyzt from js_zltscldh "
                + "where  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','商务客诉录入')=1 and ('" + ddlHqzt.Text + "'='全部' or swbhqzt='" + ddlHqzt.Text + "' or chtjhqzt='" + ddlHqzt.Text + "'))"
                + "or  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','质量客诉录入')=1 and ('" + ddlHqzt.Text + "'='全部' or zlbhqzt='" + ddlHqzt.Text + "'))"
                + "or  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','质量经理审核')=1 and ('" + ddlHqzt.Text + "'='全部' or shhqzt='" + ddlHqzt.Text + "'))"
                +"order by djlsh desc";
       
        
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_zltscldh");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "djlsh" };
        GridView1.DataBind();

        sqlcon.Close();


    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "delete   js_zltscldh  where djlsh=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }


    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    foreach (TableCell tc in e.Row.Cells)
    //    {
    //        tc.Attributes["style"] = "border-color:Black";
    //    }
    //    if (e.Row.RowIndex != -1)
    //    {
    //        int id = GridView1.PageIndex * GridView1.PageSize + e.Row.RowIndex + 1;
    //        e.Row.Cells[0].Text = id.ToString();
    //    }
    //}

    protected void tjbd_Click(object sender, EventArgs e)
    {
        if (GroupID.IndexOf("hasgroup(商务客诉录入)") != -1)
        {
            Response.Redirect("ksdAjax.aspx?lb=Add");
        }
        else
        {
            Response.Write("<script>alert('您没有新建客诉单的权利!');</script>");
        }
        bind();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (DataControlRowType.DataRow == e.Row.RowType || DataControlRowType.Header== e.Row.RowType )
        {
            if (GroupID.IndexOf("hasgroup(商务客诉录入)") == -1 )
            {
                e.Row.Cells[8].Visible  = false;

            }
        }


    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) 
    {
        if (DataControlRowType.DataRow == e.Row.RowType)
        {

            DataRowView DDR = e.Row.DataItem as DataRowView;

            HyperLink temp = e.Row.Cells[0].Controls[0] as HyperLink;
            if (temp != null)
            {
                temp.NavigateUrl = string.Format(@"ksdAjax.aspx?lb=Edite&editType={0}&xh={1}", ddlHqzt.Text, GridView1.DataKeys[e.Row.RowIndex].Value.ToString());
            }

           
        }

    }


    protected void C_Refresh_Click(object sender, ImageClickEventArgs e)
    {

    }
 
    protected void btnCX_Click(object sender, EventArgs e)
    {
        bind();
    }

    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        // 从事件参数获取排序数据列
        string sortExpression = e.SortExpression.ToString();

        // 假定为排序方向为“顺序”
        string sortDirection = "ASC";

        // “ASC”与事件参数获取到的排序方向进行比较，进行GridView排序方向参数的修改
        if (sortExpression == this.GridView1.Attributes["SortExpression"])
        {
            //获得下一次的排序状态
            sortDirection = (this.GridView1.Attributes["SortDirection"].ToString() == sortDirection ? "DESC" : "ASC");
        }

        // 重新设定GridView排序数据列及排序方向
        this.GridView1.Attributes["SortExpression"] = sortExpression;
        this.GridView1.Attributes["SortDirection"] = sortDirection;

        this.BindGridView();
    }

    private void BindGridView()
    {
        // 获取GridView排序数据列及排序方向
        string sortExpression = this.GridView1.Attributes["SortExpression"];
        string sortDirection = this.GridView1.Attributes["SortDirection"];

        // 调用业务数据获取方法
        DataTable dtBind = this.getDB();

        // 根据GridView排序数据列及排序方向设置显示的默认数据视图
        if ((!string.IsNullOrEmpty(sortExpression)) && (!string.IsNullOrEmpty(sortDirection)))
        {
            dtBind.DefaultView.Sort = string.Format("{0} {1}", sortExpression, sortDirection);
        }

        // GridView绑定并显示数据
        this.GridView1.DataSource = dtBind;
        this.GridView1.DataBind();
    }


    public DataTable getDB()
    {
        string sqlStr = "";

        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);

        sqlStr = "select djlsh,lchqzt,tsbh,cpph,khdm,thsl,sdthrq,cpxh,chsl,chrq,swbhqzt,zlbhqzt,shhqzt,chtjhqzt from js_zltscldh "
                + "where  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','商务客诉录入')=1 and ('" + ddlHqzt.Text + "'='全部' or swbhqzt='" + ddlHqzt.Text + "' or chtjhqzt='" + ddlHqzt.Text + "'))"
                + "or  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','质量客诉录入')=1 and ('" + ddlHqzt.Text + "'='全部' or zlbhqzt='" + ddlHqzt.Text + "'))"
                + "or  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','质量经理审核')=1 and ('" + ddlHqzt.Text + "'='全部' or shhqzt='" + ddlHqzt.Text + "'))"
                + "order by djlsh desc";


        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataTable dt=new DataTable();
        sqlcon.Open();
        myda.Fill(dt);
        //GridView1.DataSource = myds;
        //GridView1.DataKeyNames = new string[] { "djlsh" };
        //GridView1.DataBind();

        sqlcon.Close();

        return dt;


    }

    protected void b_Find_Click(object sender, EventArgs e)
    {
        FindBind();
    }

    public void FindBind()
    {
        System.Text.StringBuilder FindSQL = new System.Text.StringBuilder();
        if (DD_Find_dqzt.SelectedItem.Text.Trim() != "")
        {
            FindSQL.Append(" and dqzt='"+ DD_Find_dqzt.SelectedItem.Text.Trim() +"'");
        }
        if (tb_Find_cpxh.Text.Trim() != "")
        {
            FindSQL.Append("  and cpxh like '%" + tb_Find_cpxh.Text.Trim() +"%'");
        }
        if(tb_Find_khdm.Text.Trim()!="")
        {
            FindSQL.Append("  and khdm like '%" + tb_Find_khdm.Text.Trim() + "%'");
        }


        string sqlStr = "";

        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);

        sqlStr = "select djlsh,lchqzt,tsbh,cpph,khdm,thsl,sdthrq,cpxh,chsl,chrq,swbhqzt,zlbhqzt,shhqzt,chtjhqzt,dqzt,dyzt from js_zltscldh "
                + "where  ((dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','商务客诉录入')=1 and ('" + ddlHqzt.Text + "'='全部' or swbhqzt='" + ddlHqzt.Text + "' or chtjhqzt='" + ddlHqzt.Text + "'))"
                + "or  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','质量客诉录入')=1 and ('" + ddlHqzt.Text + "'='全部' or zlbhqzt='" + ddlHqzt.Text + "'))"
                + "or  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','质量经理审核')=1 and ('" + ddlHqzt.Text + "'='全部' or shhqzt='" + ddlHqzt.Text + "')))"
                + FindSQL.ToString()
                + "order by djlsh desc";


        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_zltscldh");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "djlsh" };
        GridView1.DataBind();

        sqlcon.Close();


    }
}
