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

public partial class jgdlb : System.Web.UI.Page
{
    //SVN提交测试
    string UserName = "";
    string GroupID = "";
    string GroupName = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserName = Session["username"].ToString();   //取出session里面的相应用户权限
        //sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        //sqlcon.Open();
        //string sql = "SELECT djmc,djssyhz	FROM js_rsxxb  b left JOIN js_rsxxf f ON b.bmid=f.ssbmid WHERE ry='" + UserName + "' and djmc='质量投诉处理单'";
        //sqlcom = new SqlCommand(sql, sqlcon);
        //SqlDataReader sdr = sqlcom.ExecuteReader();
        //while (sdr.Read())
        //{
        //    GroupID += "hasgroup(" + sdr["djssyhz"].ToString().Trim() + ");";
        //}
        //sqlcon.Close();
        if (!IsPostBack)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            GroupName = Session["GroupNames"].ToString();
            bind();
            
        }
    }

    public void bind()
    {
        string sqlStr = "";
        string sqlshzt = "";
        if (ddlHqzt.Text == "未审核")
        {
            sqlshzt = " where (state is null or state='' )";
        }
        else if (ddlHqzt.Text == "已审核")
        {
            sqlshzt = " where  state='审核' )";
        }
        
        
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = "SELECT id,scrq,gc,wlbh,wlmc,gys,pc,gg,sl,dw,bz  FROM js_jgd order by id desc";
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_jgd");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "id" };
        GridView1.DataBind();
        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        string sqlstr = " delete  js_jgd  where id=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "     ";               
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowUpdating(object sender,GridViewUpdateEventArgs e)
    {
        string sqlstr = "js_sgrb_sh ";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.CommandType = CommandType.StoredProcedure;          //设置Command对象类型为存储过程  
        sqlcom.Parameters.Add("@TableID", SqlDbType.NVarChar, 20).Value = GridView1.DataKeys[e.RowIndex].Value.ToString();   //添加narchar(20)类型@Pname  
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();                                      //关闭连接  
        sqlcon.Dispose();     



        bind();
    }





    protected void tjbd_Click(object sender, EventArgs e)
    {
        GroupName = Session["GroupNames"].ToString();
        if (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("手工日报录入-") != -1)
        {
            Response.Redirect("jgd.aspx");
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
        //if (DataControlRowType.DataRow == e.Row.RowType || DataControlRowType.Header== e.Row.RowType )
        //{
        //    if (GroupID.IndexOf("hasgroup(商务客诉录入)") == -1 )
        //    {
        //    e.Row.Cells[7].Visible  = false;

        //    }
        //}


    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) 
    {
        if (DataControlRowType.DataRow == e.Row.RowType)
        {

            DataRowView DDR = e.Row.DataItem as DataRowView;

            HyperLink temp = e.Row.Cells[0].Controls[0] as HyperLink;
            if (temp != null)
            {
                //temp.NavigateUrl = string.Format(@"ksdAjax.aspx?lb=Edite&editType={0}&xh={1}", ddlHqzt.Text, GridView1.DataKeys[e.Row.RowIndex].Value.ToString());
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

        //this.BindGridView();
    }




    protected void b_Find_Click(object sender, EventArgs e)
    {

    }
}
