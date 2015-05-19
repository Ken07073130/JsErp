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

public partial class stcd_cd : System.Web.UI.Page
{
    SqlConnection sqlcon;
    SqlDataAdapter myda;
    DataSet myds; 
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            bind();
        }
    }

    public void bind()
    {
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        if (rq.Text == "")
        {
            DateTime dt = DateTime.Now;
            rq.Text = dt.ToShortDateString().ToString();
        }
        string sql = "SELECT *	FROM js_mrcd where rq ='" + rq.Text + "'";
        myda = new SqlDataAdapter(sql, sqlcon);
        myds = new DataSet();
        
        myda.Fill(myds, "js_mrcd");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "cm" };
        GridView1.DataBind();
        sqlcon.Close();
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (DataControlRowType.DataRow == e.Row.RowType)
        {
            e.Row.Cells[1].Text = e.Row.Cells[1].Text + "元";
            e.Row.Cells[2].Text = e.Row.Cells[2].Text + "份";
            
        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = "合计数量：";
            // dt即数据源DataTable  
            e.Row.Cells[2].Text = myds.Tables[0].Compute("sum(sl)", "").ToString() + "份";
        }  

    }

    protected void B_qyt_Click(object sender, EventArgs e)
    {
        DateTime dt = Convert.ToDateTime(rq.Text);

        rq.Text = dt.AddDays(-1).ToShortDateString().ToString();
        bind();
    }
    protected void B_hyt_Click(object sender, EventArgs e)
    {
        DateTime dt = Convert.ToDateTime(rq.Text) ;
        rq.Text = dt.AddDays(+1).ToShortDateString().ToString();
        bind();

    }
    protected void B_bz_Click(object sender, EventArgs e)
    {
        Response.Redirect("bzcd.aspx");
    }
}
