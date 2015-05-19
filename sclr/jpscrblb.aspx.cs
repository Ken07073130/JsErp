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

public partial class jpscrblb : System.Web.UI.Page
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
        GroupName = Session["GroupNames"].ToString();
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
            
            bind();
            
        }
    }

    public void bind()
    {
        string sqlStr = "";
        string sqlshzt = "";
        System.Text.StringBuilder sqlgx = new System.Text.StringBuilder();

        
        if (GroupName.IndexOf("超级用户") == -1)
        {
            if (GroupName.IndexOf("手工日报录入-正极搅拌") != -1)
            {
                sqlgx.Append("'25',");
            }
            if (GroupName.IndexOf("手工日报录入-负极搅拌") != -1)
            {
                sqlgx.Append("'10',");
            }
            if (GroupName.IndexOf("手工日报录入-正极涂布") != -1)
            {
                sqlgx.Append("'26',");
            }
            if (GroupName.IndexOf("手工日报录入-负极涂布") != -1)
            {
                sqlgx.Append("'11',");
            }
            if (GroupName.IndexOf("手工日报录入-正极辊压分切") != -1)
            {
                sqlgx.Append("'27',");
            }
            if (GroupName.IndexOf("手工日报录入-负极辊压分切") != -1)
            {
                sqlgx.Append("'12',");
            }
            if (GroupName.IndexOf("手工日报录入-正极分小片") != -1)
            {
                sqlgx.Append("'28',");
            }
            if (GroupName.IndexOf("手工日报录入-负极分小片") != -1)
            {
                sqlgx.Append("'13',");
            }
            if (GroupName.IndexOf("手工日报录入-正极铆接") != -1)
            {
                sqlgx.Append("'30',");
            }
            if (GroupName.IndexOf("手工日报录入-负极铆接") != -1)
            {
                sqlgx.Append("'15',");
            }
            if (GroupName.IndexOf("手工日报录入-卷绕") != -1)
            {
                sqlgx.Append("'40',");
            }
            if (GroupName.IndexOf("手工日报录入-封装") != -1)
            {
                sqlgx.Append("'50',");
            }
            if (GroupName.IndexOf("手工日报录入-注液") != -1)
            {
                sqlgx.Append("'55',");
            }
            if (GroupName.IndexOf("手工日报录入-化成") != -1)
            {
                sqlgx.Append("'60',");
            }
            if (GroupName.IndexOf("手工日报录入-二封") != -1)
            {
                sqlgx.Append("'65',");
            }
            if (GroupName.IndexOf("手工日报录入-分选") != -1)
            {
                sqlgx.Append("'70',");
            }
            if (GroupName.IndexOf("手工日报录入-包装") != -1)
            {
                sqlgx.Append("75,");
            }
            if (GroupName.IndexOf("手工日报录入-PACK") != -1)
            {
                sqlgx.Append("'80',");
            }
            if (GroupName.IndexOf("手工日报录入-出货") != -1)
            {
                sqlgx.Append("'85',");
            }
        }

        if (sqlgx.Length > 0)
        {
            sqlshzt = "where gxbh in (" + sqlgx.ToString().Substring(0, sqlgx.Length - 1) + ")";

        }
        else if (GroupName.IndexOf("超级用户") != -1)
        {
            sqlshzt = "where  (1=1)";
        }
        else
        {
            sqlshzt = "where  gxbh in ('')";
        }

        if (ddlHqzt.Text == "未审核")
        {
            sqlshzt += " and (state is null or state='' )";
        }
        else if (ddlHqzt.Text == "已审核")
        {
            sqlshzt += " and  ( state='审核' )";
        }
            
        
        //else
        //{
        //    if (ddlHqzt.Text == "未审核")
        //    {
        //        sqlshzt = " where (state is null or state='' )";
        //    }
        //    else if (ddlHqzt.Text == "已审核")
        //    {
        //        sqlshzt = " where  ( state='审核' )";
        //    }
        //}
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);

        sqlStr = "SELECT id,lrr,scrq,scrq,xh,pc,gc,rl,gxmc,gxbh,fqts,(drsc1+drsc2+drsc3) AS drsc ,(drzc1+drzc2+drzc3+drzc4+drzc5+drzc6) AS drzc,bz,CASE State WHEN '审核' THEN '反审' ELSE '' END AS zt FROM js_sgrb  " + sqlshzt + " order by id desc";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_sgrb");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "id" };
        GridView1.DataBind();
        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        string sqlstr = " delete  js_sgrb  where id=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "     ";               
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowUpdating(object sender,GridViewUpdateEventArgs e)
    {
        string sqlstr = "js_sgrb_fs ";
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
        GroupName = Session["GroupNames"].ToString();
        if (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("手工日报录入-") != -1)
        {
            Response.Redirect("jpscrb.aspx");
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

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (DataControlRowType.DataRow == e.Row.RowType || DataControlRowType.Header == e.Row.RowType)
        {
            if (GroupName.IndexOf("超级用户") == -1 && GroupName.IndexOf("手工日报录入-审核组") == -1)
        
            {
                e.Row.Cells[9].Visible = false;

            }
        }


    }


    //public DataTable getDB()
    //{
    //    string sqlStr = "";

    //    sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);

    //    sqlStr = "select djlsh,lchqzt,tsbh,cpph,khdm,thsl,sdthrq,cpxh,chsl,chrq,swbhqzt,zlbhqzt,shhqzt,chtjhqzt from js_zltscldh "
    //            + "where  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','商务客诉录入')=1 and ('" + ddlHqzt.Text + "'='全部' or swbhqzt='" + ddlHqzt.Text + "' or chtjhqzt='" + ddlHqzt.Text + "'))"
    //            + "or  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','质量客诉录入')=1 and ('" + ddlHqzt.Text + "'='全部' or zlbhqzt='" + ddlHqzt.Text + "'))"
    //            + "or  (dbo.js_func_hasgroup('质量投诉处理单','" + UserName + "','','质量经理审核')=1 and ('" + ddlHqzt.Text + "'='全部' or shhqzt='" + ddlHqzt.Text + "'))"
    //            + "order by djlsh desc";


    //    SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
    //    DataTable dt=new DataTable();
    //    sqlcon.Open();
    //    myda.Fill(dt);
    //    //GridView1.DataSource = myds;
    //    //GridView1.DataKeyNames = new string[] { "djlsh" };
    //    //GridView1.DataBind();

    //    sqlcon.Close();

    //    return dt;


    //}

    protected void b_Find_Click(object sender, EventArgs e)
    {
        FindBind();
    }

    public void FindBind()
    {
        System.Text.StringBuilder FindSQL = new System.Text.StringBuilder();
        if (DD_Find_gx.SelectedItem.Text.Trim() != "")
        {
            FindSQL.Append(" and gxmc='" + DD_Find_gx.SelectedItem.Text.Trim() + "'");
        }
        if (tb_Find_pc.Text.Trim() != "")
        {
            FindSQL.Append("  and pc like '%" + tb_Find_pc.Text.Trim() + "%'");
        }
        if (tb_Find_xh.Text.Trim() != "")
        {
            FindSQL.Append("  and xh like '%" + tb_Find_xh.Text.Trim() + "%'");
        }
        string sqlshzt = "";
        if (ddlHqzt.Text == "未审核")
        {
            sqlshzt = " where (state is null or state='' )";
        }
        else if (ddlHqzt.Text == "已审核")
        {
            sqlshzt = " where  (state='审核' )";
        }
        else if (ddlHqzt.Text =="全部")
        {
            sqlshzt = " where  (1=1 )";
        }
     
            


        string sqlStr = "";

        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);

        sqlStr = " SELECT id,lrr,scrq,xh,pc,gc,rl,gxmc,gxbh,fqts,(drsc1+drsc2+drsc3)AS drsc ,(drzc1+drzc2+drzc3+drzc4+drzc5+drzc6) AS drzc,bz,CASE State WHEN '审核' THEN '反审' ELSE '审核' END AS zt FROM js_sgrb " + sqlshzt + " " + FindSQL + " order by id desc"; 
               


        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_sgrb");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "id" };
        GridView1.DataBind();

        sqlcon.Close();


    }

    protected void B_JCKJLR_Click(object sender, EventArgs e)
    {
        

    }
    protected void B_SH_Click(object sender, EventArgs e)
    {

        string sqlstr = "js_sgrb_sh ";

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            CheckBox cb = (CheckBox)GridView1.Rows[i].FindControl("chkItem");
            if (cb.Checked == true)
            {
                sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
                sqlcon.Open();
                sqlcom = new SqlCommand(sqlstr, sqlcon);
                sqlcom.CommandType = CommandType.StoredProcedure;          //设置Command对象类型为存储过程  
                int tableID = Int32.Parse(GridView1.DataKeys[i].Value.ToString().Trim());
                sqlcom.Parameters.Add("@TableID", SqlDbType.Int).Value =  tableID;   //添加narchar(20)类型@Pname  
                sqlcom.ExecuteNonQuery();
                sqlcon.Dispose();
                sqlcon.Close(); 
            }
        }
                                             //关闭连接  
        Response.Write("<script>alert('审核成功!');</script>");
        bind();
    }


    protected void B_sc_Click(object sender, EventArgs e)
    {
        string sqlStr = "";
        string sqlshzt = "";
        System.Text.StringBuilder sqlgx = new System.Text.StringBuilder();

        if (GroupName.IndexOf("超级用户") == -1)
        {
            if (GroupName.IndexOf("手工日报录入-正极搅拌") != -1)
            {
                sqlgx.Append("'25',");
            }
            if (GroupName.IndexOf("手工日报录入-负极搅拌") != -1)
            {
                sqlgx.Append("'10',");
            }
            if (GroupName.IndexOf("手工日报录入-正极涂布") != -1)
            {
                sqlgx.Append("'26',");
            }
            if (GroupName.IndexOf("手工日报录入-负极涂布") != -1)
            {
                sqlgx.Append("'11',");
            }
            if (GroupName.IndexOf("手工日报录入-正极辊压分切") != -1)
            {
                sqlgx.Append("'27',");
            }
            if (GroupName.IndexOf("手工日报录入-负极辊压分切") != -1)
            {
                sqlgx.Append("'12',");
            }
            if (GroupName.IndexOf("手工日报录入-正极分小片") != -1)
            {
                sqlgx.Append("'28',");
            }
            if (GroupName.IndexOf("手工日报录入-负极分小片") != -1)
            {
                sqlgx.Append("'13',");
            }
            if (GroupName.IndexOf("手工日报录入-正极铆接") != -1)
            {
                sqlgx.Append("'30',");
            }
            if (GroupName.IndexOf("手工日报录入-负极铆接") != -1)
            {
                sqlgx.Append("'15',");
            }
            if (GroupName.IndexOf("手工日报录入-卷绕") != -1)
            {
                sqlgx.Append("'40',");
            }
            if (GroupName.IndexOf("手工日报录入-封装") != -1)
            {
                sqlgx.Append("'50',");
            }
            if (GroupName.IndexOf("手工日报录入-注液") != -1)
            {
                sqlgx.Append("'55',");
            }
            if (GroupName.IndexOf("手工日报录入-化成") != -1)
            {
                sqlgx.Append("'60',");
            }
            if (GroupName.IndexOf("手工日报录入-二封") != -1)
            {
                sqlgx.Append("'65',");
            }
            if (GroupName.IndexOf("手工日报录入-分选") != -1)
            {
                sqlgx.Append("'70',");
            }
            if (GroupName.IndexOf("手工日报录入-包装") != -1)
            {
                sqlgx.Append("75,");
            }
            if (GroupName.IndexOf("手工日报录入-PACK") != -1)
            {
                sqlgx.Append("'80',");
            }
            if (GroupName.IndexOf("手工日报录入-出货") != -1)
            {
                sqlgx.Append("'85',");
            }
        }
        if (sqlgx.Length > 0)
        {
            sqlshzt = "where gxbh in (" + sqlgx.ToString().Substring(0, sqlgx.Length - 1) + ")";

        }
        else if (GroupName.IndexOf("超级用户") != -1)
        {
            sqlshzt = "where  (1=1)";
        }
        else
        {
            sqlshzt = "where  gxbh in ('')";
        }
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = "SELECT count(id) sl FROM js_sgrb  " + sqlshzt + "  and (state is null  or state ='') ";
        sqlcon.Open();
        int wsh = 0;
        SqlCommand Cmd = new SqlCommand(sqlStr, sqlcon);
        SqlDataReader sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            wsh = Convert.ToInt32(sdr["sl"].ToString());
        }
        sdr.Close();
        //if (wsh > 0)
        //{
        //    Response.Write("<script>alert('你有未审核的单据!');</script>");
        //    return;
        //}

        sqlStr = "INSERT INTO dbo.js_sgrb( xh,PACKxh,pc,qrjc1,qrjc2,qrjc3,qrjc4,gc,rl,gxmc,gxbh,fqts,lrr,lrrq,sclx) "
                + " SELECT  xh,PACKxh,pc,drjc1,drjc2,drjc3,drjc4,gc,rl,gxmc,gxbh,fqts,lrr,GETDATE(),sclx from js_sgrb  " + sqlshzt + " and scrq='" + TB_scrq.Text.Trim() + "' and ( drjc1<>0 or drjc2<>0 or drjc3<>0 or drjc4<>0 )  and (state ='审核')  ";
        sqlcom = new SqlCommand(sqlStr, sqlcon);
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void DD_Find_gx_SelectedIndexChanged(object sender, EventArgs e)
    {
        FindBind();
    }
}
