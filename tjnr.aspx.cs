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

public partial class tjnr : System.Web.UI.Page
{
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    private void BindData()
    {
        DataTable dt = CreateTable();
        DataRow dr = dt.NewRow();
        dr["yy"] = "hello";
        dr["line"] = 0;
        dt.Rows.Add(dr);

        GridView1.DataSource = dt.DefaultView;
        GridView1.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack)
        //{
        //    BindData();
        //}

        if (!IsPostBack)
        {

            bind();

        }

    }

    //创建一个表
    private DataTable CreateTable()
    {
        DataTable dt = new DataTable("mytable");
        DataColumn dc = new DataColumn("yy", System.Type.GetType("System.String"));
        dt.Columns.Add(dc);

        dc = new DataColumn("line", System.Type.GetType("System.Int32"));
        dt.Columns.Add(dc);

        return dt;
    }

    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        DataTable dt = CreateTable();
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (e.NewSelectedIndex == int.Parse(GridView1.DataKeys[gvr.RowIndex][0].ToString()))//插入行的位置
            {
                DataRow dr = dt.NewRow();
                dr["yy"] = "";
                dr["line"] = e.NewSelectedIndex;
                dt.Rows.Add(dr);

                dr = dt.NewRow();
                TextBox tb = (TextBox)gvr.Cells[1].FindControl("TextBox1");
                dr["yy"] = tb.Text;
                dr["line"] = e.NewSelectedIndex + 1;
                dt.Rows.Add(dr);
            }
            else if (e.NewSelectedIndex < int.Parse(GridView1.DataKeys[gvr.RowIndex][0].ToString()))//插入行之后
            {
                DataRow dr = dt.NewRow();
                TextBox tb = (TextBox)gvr.Cells[1].FindControl("TextBox1");
                dr["yy"] = tb.Text;
                dr["line"] = int.Parse(GridView1.DataKeys[gvr.RowIndex][0].ToString()) + 1;
                dt.Rows.Add(dr);
            }
            else//插入行之前
            {
                DataRow dr = dt.NewRow();
                TextBox tb = (TextBox)gvr.Cells[1].FindControl("TextBox1");
                dr["yy"] = tb.Text;
                dr["line"] = GridView1.DataKeys[gvr.RowIndex][0].ToString();
                dt.Rows.Add(dr);
            }
        }

        //重新绑定
        DataView dv = dt.DefaultView;
        dv.Sort = "line";//指定排序字段
        GridView1.DataSource = dv;
        GridView1.DataBind();

    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "delete from js_lcbqxkz where xh=" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    public void bind()
    {
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        string sqlStr = "select * from js_lcbqxkz";
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_lcbqxkz");

        GridView1.DataSource = myds;

        if (myds.Tables[0].Rows.Count == 0)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("XH");
            dt.Columns.Add("bzxh");
            dt.Columns.Add("yhz");
            dt.Columns.Add("zdmc");
            dt.Columns.Add("zj");
            dt.Columns.Add("xg");
            dt.Columns.Add("sc");
            dt.Columns.Add("xsfs");
            dt.Columns.Add("dxfs");
            dt.Columns.Add("shqx");
            dt.Columns.Add("ys");
            dt.Rows.Add(dt.NewRow());
            GridView1.DataSource = dt;

            GridView1.DataKeyNames = new string[] { "xh" };
            GridView1.DataBind();
            int columnCount = dt.Columns.Count;
            GridView1.Rows[0].Cells.Clear();
            GridView1.Rows[0].Cells.Add(new TableCell());
            GridView1.Rows[0].Cells[0].ColumnSpan = columnCount;
            GridView1.Rows[0].Cells[0].Text = "没有记录";
            GridView1.Rows[0].Cells[0].Style.Add("text-align", "center");
        }
        else
        {
            GridView1.DataKeyNames = new string[] { "xh" };
            GridView1.DataBind();
        }



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

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


    protected void tjh_Click(object sender, EventArgs e)
    {

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
}
