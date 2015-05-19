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

public partial class controlRefList : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    string djmc;
    protected void Page_Load(object sender, EventArgs e)
    {
    
 
        if (!IsPostBack) {
           djmc = Request.QueryString["djmc"];
           ddlDjmc.Items.Add("全部");
           sqlcon=new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
           sqlcon.Open();
           String sqlstr="select distinct djmc from dbo.js_controlEnable ";
           sqlcom = new SqlCommand(sqlstr,sqlcon);
           SqlDataReader sdr=sqlcom.ExecuteReader();
           if (sdr.HasRows) {
               while (sdr.Read()) {
                   ddlDjmc.Items.Add(sdr["djmc"].ToString().Trim());
               }
           }
           ddlDjmc.SelectedIndex = 1;
           sqlcon.Close();
           sdr.Close();
           
        }

        if (Session["username"] != null)
        {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();

        }
        else
        {
            Response.Redirect("Login.aspx");
        }
        if (!String.IsNullOrEmpty(djmc)){
            ddlDjmc.Text = djmc;
        }
        bind();

        
    }

    public void bind(){
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = //"select  '新增' bh,null jbrq,null khdm,null FQR,null FQSHR,null FQRHQZT,null FQBMHQZT,null SWBHQZT,null  XMFZRHQZT,null  ZFZRHQZT" +
            //" union all " +
                 "select * from dbo.js_controlEnable " +
                 " where ('" + ddlDjmc.Text + "'='全部'  or djmc='" + ddlDjmc.Text + "') order by djmc,lx desc";
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_controlEnable");
        
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "djmc","zd" };
        GridView1.DataBind();

        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "delete from js_controlEnable where djmc='" + GridView1.DataKeys[e.RowIndex]["djmc"].ToString() + "' and zd='" + GridView1.DataKeys[e.RowIndex]["zd"].ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e){
        Response.Redirect("controlRefEdit.aspx?djmc=" + GridView1.DataKeys[e.NewEditIndex]["djmc"].ToString() + "&zd=" + GridView1.DataKeys[e.NewEditIndex]["zd"].ToString() + " &lb=EDIT");
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow){
            LinkButton btnDel = (LinkButton)e.Row.Cells[1].Controls[0];//删除     
            btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(单据: " + (e.Row.Cells[2].Text) + " 字段：" + (e.Row.Cells[6].Text) + " 吗)'); ");
        }
        foreach (TableCell tc in e.Row.Cells)
        {
            tc.Attributes["style"] = "border-color:Black";
        }
    }

    protected void tjbd_Click(object sender, EventArgs e)
    {
        Response.Redirect("controlRefEdit.aspx?lb=ADD"+"&djmc=" + ddlDjmc.Text.ToString().Trim());//只有发起人才能新建表单
        bind();

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void btnCX_Click(object sender, EventArgs e){
        bind();
    }

}
