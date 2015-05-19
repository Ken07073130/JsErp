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

public partial class swgl_tcjhList : System.Web.UI.Page
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

    public void bind(){
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = //"select  '新增' bh,null jbrq,null khdm,null FQR,null FQSHR,null FQRHQZT,null FQBMHQZT,null SWBHQZT,null  XMFZRHQZT,null  ZFZRHQZT" +
                 //" union all " +
                 "select * FROM [erp_js_data0704].[dbo].[js_tcjhH] order by djlsh desc ";
               
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_tcjhH");
        
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "ddlsh" };
        GridView1.DataBind();

        sqlcon.Close();

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "update  js_mfypjysH set  isDel=1,bh='(删除)'+bh where bh=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e){
        Response.Redirect("tcjhEdit.aspx?ddlsh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString());
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow) {
        //    LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];//编辑
        //    LinkButton btnDel  = (LinkButton)e.Row.Cells[2].Controls[0];//删除
        //    if (ddlHqzt.Text != "会签中"){//只有会签中的记录才能更改
        //        btnEdit.Text = "查看";
        //        btnDel.Enabled = false;
        //    } else if ("会签中"==ddlHqzt.Text){
        //        btnEdit.Text = "编辑";
        //        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        //        sqlcon.Open();
        //        String sqlstr = "select dbo.js_func_hasgroup('样品建议书','"+Session["username"].ToString()+"','','发起人') qx ";
        //        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        //        SqlDataReader sdr = cmd.ExecuteReader();
        //        if (sdr.HasRows) {
        //            while (sdr.Read()) {
        //                if ("1" == sdr["qx"].ToString()){
        //                    btnDel.Enabled = true;//只有发起人有删除权限
        //                }
        //                else {
        //                    btnDel.Enabled = false;//不是发起人不能删除单据
        //                }
        //            }
        //        }
        //        sqlcon.Close();
        //        sdr.Close();
        //        btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); "); 

        //    }
           
            
        //}
        //foreach (TableCell tc in e.Row.Cells)
        //{
        //    tc.Attributes["style"] = "border-color:Black";
        //}
    }

    protected void tjbd_Click(object sender, EventArgs e)
    {
        sqlcon.Open();
        String sqlstr = "select dbo.js_func_hasgroup('样品建议书','" + Session["username"].ToString() + "','','发起人') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows){
            while (sdr.Read()){
                if ("1" == sdr["qx"].ToString()){
                    Response.Redirect("ypjysEdit.aspx?lb=ADD");//只有发起人才能新建表单
                }
                else{
                    Response.Write("<script>alert('您没有添加样品建议书的权限!');</script>");
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

    //protected void btnCX_Click(object sender, EventArgs e){
    //    bind();
    //}


}
