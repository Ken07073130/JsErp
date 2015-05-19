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

public partial class tgxx : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    string UserName = "";
    string GroupID = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            HF_glxx.Value = Request.QueryString["glxx"];
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                HF_glxx.Value = Session["IsAdministrator"].ToString();
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
            Bind();

        }

    }

    public void Bind()
    {
        sqlcon.Open();
        string sqlstr = "SELECT id,bt,rq,sry FROM [erp_js_data0704].[dbo].[js_tzxx]  order by id";
        SqlCommand sqlcom = new SqlCommand(sqlstr, sqlcon);   //调用存储过程
        SqlDataAdapter adapter = new SqlDataAdapter(sqlcom);      //数据适配器
        DataSet ds = new DataSet();                            //数据集
        
        adapter.Fill(ds, "js_tzxx");
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "ID" };    //绑定的字段名(显示的文字)
        GridView1.DataBind();
        sqlcon.Close();

    }



    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "wjlj")
        {
            string ID = e.CommandArgument.ToString();
            if (HF_glxx.Value == "1")
            {
                Response.Redirect("AddGGL.aspx?id=" + ID); //urlconvertor(dz).Substring(urlconvertor(dz).IndexOf("文控管理")));
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript'>window.open('ggl.aspx?ID=" + ID + "');</script>");
            }

        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        sqlcon.Open();
        string sqlstr = "delete from js_tzxx where ID=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "";
        SqlCommand sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        Bind();
    }

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        //e.Row.Cells[4].Visible = false;  //使第5列不可见,则将它的可见性设为false
        if (HF_glxx.Value != "1")
        {
            e.Row.Cells[3].Visible = false; //如果sfxz值等于0表示不能下载，隐藏下载按钮。
        }

        //可以根据需要设置更多的列
    }
}
