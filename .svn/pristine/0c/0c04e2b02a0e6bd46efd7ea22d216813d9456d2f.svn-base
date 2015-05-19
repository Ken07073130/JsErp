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

public partial class stcd_bzcd : System.Web.UI.Page
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
        string sql = "SELECT [mrbh],"
		            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)   then cm +' '+ CONVERT(NVARCHAR(10),dj ) +'元'   END) as  'z1',"
		            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+1 then cm +' '+ CONVERT(NVARCHAR(10),dj ) +'元'   END) as  'z2',"
		            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+2 then cm +' '+ CONVERT(NVARCHAR(10),dj ) +'元'  end) as  'z3',"
		            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+3 then cm +' '+ CONVERT(NVARCHAR(10),dj ) +'元'  end) as  'z4',"
		            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+4 then cm +' '+ CONVERT(NVARCHAR(10),dj ) +'元'  end) as  'z5',"
	                +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+5 then cm +' '+ CONVERT(NVARCHAR(10),dj ) +'元'  end) as  'z6'"
	                +"FROM js_mrcd GROUP BY [mrbh]";
        myda = new SqlDataAdapter(sql, sqlcon);
        myds = new DataSet();
        
        myda.Fill(myds, "js_mrcd");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "z1" };
        GridView1.DataBind();

        sql = " SELECT lx,"
            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)   then sl END) as  'z1',"
            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+1 then sl END) as  'z2',"
            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+2 then sl end) as  'z3',"
            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+3 then sl end) as  'z4',"
            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+4 then sl end) as  'z5',"
            +"max(case when rq=DATEADD(wk, DATEDIFF(wk,0,getdate()), 0)+5 then sl end) as  'z6'"
            +"FROM dbo.js_mrsttj  GROUP BY lx";
        myda = new SqlDataAdapter(sql, sqlcon);
        myds = new DataSet();
        myda.Fill(myds, "js_mrsttj");
        GridView2.DataSource = myds;
        GridView2.DataKeyNames = new string[] { "lx" };
        GridView2.DataBind();








        sqlcon.Close();
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (DataControlRowType.DataRow == e.Row.RowType)
        //{
        //    e.Row.Cells[1].Text = e.Row.Cells[1].Text + "元";
        //    e.Row.Cells[2].Text = e.Row.Cells[2].Text + "份";
            
        //}

        //if (e.Row.RowType == DataControlRowType.Footer)
        //{
        //    e.Row.Cells[0].Text = "合计数量：";
        //    // dt即数据源DataTable  
        //    e.Row.Cells[2].Text = myds.Tables[0].Compute("sum(sl)", "").ToString() + "份";
        //}  

    }


}
