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

public partial class ConfigMenu : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            sqlcon.Open();
            this.createDataSet();
            this.InitTree(TreeView1.Nodes, "0");
            sqlcon.Close();
        }
    }

    protected void InitTree(TreeNodeCollection Nds, string parentID) //用递归方法动态生成节点  
    {
        DataView dv = new DataView();
        TreeNode tmpNode;
        dv.Table = ds.Tables[0];
        dv.RowFilter = "ParentID=" + "'" + parentID + "'";
        foreach (DataRowView drv in dv)
        {
            tmpNode = new TreeNode();
            tmpNode.Value = drv["NodeID"].ToString();
            tmpNode.Text = drv["NodeCaption"].ToString();
            tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            Nds.Add(tmpNode);
            this.InitTree(tmpNode.ChildNodes, tmpNode.Value);
        }
    }  

    private DataSet createDataSet()
    {
        
        string sqlstr = "SELECT *  FROM JS_Tree";
        SqlDataAdapter cmdSelect = new SqlDataAdapter(sqlstr, sqlcon);
        ds = new DataSet();
        cmdSelect.Fill(ds, "JS_Tree");
        
        return ds;

    } 



    protected void logout_Click(object sender, ImageClickEventArgs e)
    {

        Session.RemoveAll();
        Response.Redirect("Login.aspx");
    }
    public void bind()
    { }


    protected void C_Refresh_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void tjbd_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "update  js_ksd set  status=0 where xh=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Response.Redirect("ksdAjax.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=Edite");
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        foreach (TableCell tc in e.Row.Cells)
        {
            tc.Attributes["style"] = "border-color:Black";
        }
        if (e.Row.RowIndex != -1)
        {
            int id = GridView1.PageIndex * GridView1.PageSize + e.Row.RowIndex + 1;
            e.Row.Cells[0].Text = id.ToString();
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

}
