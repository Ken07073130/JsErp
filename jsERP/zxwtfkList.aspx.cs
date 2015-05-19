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

public partial class zxwtfkList : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();
        }
        else
        {
            Response.Redirect("Login.aspx");
        }

        bind();


    }

    public void bind()
    {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = //"select  '新增' bh,null jbrq,null khdm,null FQR,null FQSHR,null FQRHQZT,null FQBMHQZT,null SWBHQZT,null  XMFZRHQZT,null  ZFZRHQZT" +
            //" union all " +
                 " select BH,RQ,LCHQZT,XH,ZT,FZR,FQR,XGSFYX,FSGX,case when lchqzt='已完成' then 1 else 0 end ztxh from js_tzxwtfkH a " +
                 " where  ('" + ddlHqzt.Text + "'='全部' or a.FQR='" + UserName + "')" +
                 "     or (dbo.js_func_hasgroup('专项问题反馈','" + UserName + "',a.FQR,'质量经理审核')=1 and ('" + ddlHqzt.Text + "'='全部' or ZLBJLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (a.fzr='" + UserName + "' and ('" + ddlHqzt.Text + "'='全部' or FXRHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (dbo.js_func_hasgroup('专项问题反馈','" + UserName + "',a.FZR,'')=1 and ('" + ddlHqzt.Text + "'='全部' or FXRSHHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (dbo.js_func_hasgroup('专项问题反馈','" + UserName + "',a.FQR,'质量确认人')=1 and ('" + ddlHqzt.Text + "'='全部' or  ZLBQRRHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (dbo.js_func_hasgroup('专项问题反馈','" + UserName + "',a.FQR,'质量确认人')=1 and lchqzt='已完成') " +
                 "  order by ztxh,bh";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_tzxwtfkH");

        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "BH" };
        GridView1.DataBind();




        sqlcon.Close();

        //根据条件改变行颜色
        /*for (int i = 0; i < GridView1.Rows.Count; i++){
            //流程会签状态
            if ("已完成" == GridView1.Rows[i].Cells[4].Text) {
                GridView1.Rows[i].BackColor = System.Drawing.Color.Yellow;
            }
        }*/

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "delete from js_tzxwtfkH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();

        sqlstr = "delete from dbo.js_tzxwtfk_gsdcH where BH='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcom.ExecuteNonQuery();

        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Response.Redirect("zxwtfkEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=EDIT" + "&editType=" + ddlHqzt.Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];//编辑
            LinkButton btnDel = (LinkButton)e.Row.Cells[2].Controls[0];//删除
            if (ddlHqzt.Text != "会签中")
            {//只有会签中的记录才能更改
                btnEdit.Text = "查看";
                btnDel.Enabled = false;
            }
            else if ("会签中" == ddlHqzt.Text)
            {
                btnEdit.Text = "编辑";
                sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
                sqlcon.Open();
                String sqlstr = "select isnull(min(1),0) qx from js_tzxwtfkH where fqr='" + Session["username"].ToString() + "'";
                SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
                SqlDataReader sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        if ("1" == sdr["qx"].ToString())
                        {
                            btnDel.Enabled = true;//只有发起人有删除权限
                        }
                        else
                        {
                            btnDel.Enabled = false;//不是发起人不能删除单据
                        }
                    }
                }
                sqlcon.Close();
                sdr.Close();
                btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");

            }


        }
        foreach (TableCell tc in e.Row.Cells)
        {
            tc.Attributes["style"] = "border-color:Black";
        }


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["lchqzt"].ToString();
            /*if (result == "已完成(未发样)")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFCC");
            else }*/
            if (result == "已完成")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC");
        }
    }

    protected void tjbd_Click(object sender, EventArgs e)
    {
        sqlcon.Open();
        String sqlstr = "select dbo.js_func_hasgroup('专项问题反馈','" + Session["username"].ToString() + "','','发起人') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                if ("1" == sdr["qx"].ToString())
                {
                    Response.Redirect("zxwtfkEdit.aspx?lb=ADD");//只有发起人才能新建表单
                }
                else
                {
                    Response.Write("<script>alert('您没有添加专项问题反馈的权限!');</script>");
                }
            }
        }
        sqlcon.Close();
        sdr.Close();
        bind();

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void btnCX_Click(object sender, EventArgs e)
    {
        bind();
    }

}
