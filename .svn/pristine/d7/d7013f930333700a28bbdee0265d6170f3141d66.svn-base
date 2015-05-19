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

public partial class AddGGL : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    string UserName = "";
    string GroupID = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            HF_ID.Value  = Request.QueryString["ID"];
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
            if (HF_ID.Value != "")
            {
                Bind();
                
            }

        }

    }
    protected void Bind()
    {
        sqlcon.Open();
        string sqlstr = "SELECT id,bt,nr from js_tzxx where id=" + HF_ID.Value;  //取出所有的通知标题
        SqlCommand Cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = Cmd.ExecuteReader();

        while (sdr.Read())
        {
            TB_tzbt.Text = sdr["bt"].ToString().Trim();
            this.editor_id.Text = sdr["nr"].ToString();
        }
        sdr.Close();
        sqlcon.Close();
    }
    protected void DDL_tzbt_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void B_TJ_Click(object sender, EventArgs e)
    {
        sqlcon.Open();   //添加新内容
        string sqlstr = "";
        string tsxx = "";
        if (HF_ID.Value != "")
        {
            sqlstr = "update  js_tzxx  set bt='" + TB_tzbt.Text + "',nr='" + editor_id.Text + "',rq=getdate()  where id =" + HF_ID.Value;
            tsxx = "信息修改成功！";
        }
        else
        {
            sqlstr = "insert js_tzxx (bt,nr,rq,sry) values ('" + TB_tzbt.Text + "','" + editor_id.Text + "',getdate(),'" + UserName + "')";
            tsxx = "信息发布成功！";
        }
        
        SqlCommand Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        Response.Write("<script>alert('" + tsxx + "');self.location='tgxx.aspx';</script>");
        
    }
}
