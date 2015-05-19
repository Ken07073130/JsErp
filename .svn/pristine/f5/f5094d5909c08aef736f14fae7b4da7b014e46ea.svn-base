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

public partial class wkzt_yhz : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                if (GroupID.IndexOf("hasgroup(文控管理员)") == -1)
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
        sqlcon.Open();
        string sqlstr = "SELECT ID,GroupName,GradationID=( CASE WHEN LEN(GradationID)>30 THEN SUBSTRING(GradationID,0,30)+'...' ELSE GradationID END  ), IsDownload  =( CASE WHEN LEN(IsDownload)>30 THEN SUBSTRING(IsDownload,0,30)+'...' 	ELSE IsDownload END  )FROM  [erp_js_data0704].[dbo].[WK_UserGroup] ";
        sqlcom = new SqlCommand(sqlstr, sqlcon);   //调用存储过程
        SqlDataAdapter adapter = new SqlDataAdapter(sqlcom);      //数据适配器
        DataSet ds = new DataSet();                            //数据集
        adapter.Fill(ds, "WK_UserGroup");
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "ID" };    //绑定的字段名(显示的文字)
        GridView1.DataBind();

    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "delete from WK_UserGroup where ID=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Response.Redirect("wjz.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() );
    }


    protected void Button_Click(object sender, EventArgs e)
    {
        TextBox zm = (TextBox)GridView1.FooterRow.FindControl("T_ZM");
        string sqlstr = "insert into WK_UserGroup ( GroupName ) values ('" + zm.Text + " ')";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();

    }


}
