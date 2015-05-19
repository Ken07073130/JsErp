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
using System.Data.OleDb;
using CrystalDecisions.CrystalReports.Engine;
using System.Data.SqlClient;
public partial class cgdPrint : System.Web.UI.Page
{
    string bh = "";

    ReportDocument myReport;
    protected void Page_Load(object sender, EventArgs e)
    {
        //显示为已打印
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        string sqlstr = "update js_cgdH set dyzt=1 where bh='" + Request.QueryString["bh"].Replace("*", "#")+"'";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        cmd.ExecuteNonQuery();
        sqlcon.Close();
    }

    //可以选择工厂地址
    public void fillGc() {
        ddlGc.Items.Clear();
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        string sqlstr = "select  GCMC , GCDZ from    js_gcxxH order by gcdm";
        SqlCommand cmd = new SqlCommand(sqlstr,sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                ddlGc.Items.Add(new ListItem(sdr["GCMC"].ToString(), sdr["GCDZ"].ToString()));
            }
        }
        sdr.Close();
        sqlcon.Close();
       
    }

    //VS2008必须放到Page_Init中
    private void Page_Init(object sender, EventArgs e)
    {
        fillGc();
        //URL传不了符号：# 传进来的是*
        bh = Request.QueryString["bh"];
        bh = bh.Replace("*", "#");
        myReport = new ReportDocument();
        ConfigureCrystalReports();
    }

    private void ConfigureCrystalReports()
    {
        SqlConnection sqlconn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlconn.Open();
        string conditionString = "";
        if (!String.IsNullOrEmpty(Request["bh"].ToString()))
        {
            conditionString = " and charindex(a.bh,'" + Request["bh"].ToString() + "')>0";
        }


        
        /*String sqlstr = "select  a.JBRQ,case when a.GC='1' then '新桥工厂' else '东洲工厂' end gc,c.CKMC cjdm,a.WLBH,d.wlmc IQC,d.lsmxx LX,a.ZFLSL,d.dw IQCHQZT, "
                       + "            stuff((select ','+e.PH+'('+e.FLSL+')' from js_lltld_fllbH e where e.BH=b.BH),1,1,'') CGY  "//批号+(数量) 
                       + "    from    js_lltldH a , "
                       + "            dbo.js_lltld_fllbH b, "
                       + "            dbo.CKDMH c,  "   //获取仓库名称
                       + "            dbo.js_xyclbmH d  "//获取物料详细信息
                       + "    where   a.BH = b.BH  and a.CJDM=c.CKDM and a.WLBH=d.wlbh "
                       + conditionString 
                       + "    group by  b.BH,a.JBRQ,c.CKMC,a.WLBH,d.wlmc,d.lsmxx,a.ZFLSL,d.dw,a.gc ";*/
       string sqlstr = "select  convert(varchar(20), row_number() over ( partition by a.DjLsh order by a.DjLsh )) xh , "
                      + "c.DH1 + '  ' + c.DH2 DH ,c.LXR LXR_N ,'浙江富阳市迎宾北路251号' JHDD ,convert(varchar(2), datepart(m, DHRQ)) + '月'+ convert(varchar(2), datepart(d, DHRQ)) + '日' DHRQ_N, "
                      + "e.GYSMC DGDW,e.DZ dwdz,e.DH1 dwdh,e.CZ dwcz,e.KHH dwkhh,e.ZH dwzh,e.SH dwsh,e.YB dwyb,c.jhfs jhfs_n, "
                      + " case when JGDW='￥' then '(人民币)' when JGDW='＄' then '(美元)' when JGDW='￥(JPY)' then '(日元)' when JGDW='€' then '(欧元)' else '' end bz_N,* "
                      + " from    dbo.js_cgdH a ,"
                      + " dbo.js_cgd_cglbH b ,"
                      + " dbo.js_gysglH c ,"
                      + " dbo.js_xyclbmH d,"
                      + " dbo.js_gysglH e "
                      + " where   a.BH = b.CGDBH "
                      + " and a.BH = '"+bh+"' "
                      + " and a.GYSDM = c.GYSDM "
                      + " and b.WLBH = d.wlbh "
                      + " and e.GYSDM='00' ";

        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlconn);
        //水晶报表里每张表都要设置一下数据集
        sda.Fill(ds, "myDataTable");
        //sda.Fill(ds, "js_cgd_cglbH");
        // sda.Fill(ds, "js_gysglH");
        //sda.Fill(ds, "js_xyclbmH");
        //  sda.Fill(ds, "js_lltld_fllbH");
        //  sda.Fill(ds, "CKDMH");
        //  sda.Fill(ds, "js_xyclbmH");


        /*
        //连接字串
        String connstr = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\CrZen\testall.mdb;";
        OleDbDataAdapter da = new OleDbDataAdapter();
        OleDbConnection cn = new OleDbConnection(connstr);
        //
        da = new OleDbDataAdapter("SELECT * From RPT_CR_TEST1", cn);
        //创建我们的DataSet1实例
        DataSet dt1 = new DataSet();
        //填充dt1
        //注意：表名mytable必须与我们在xsd设计的表名称一致。
        //本例中数据库的表实际名称为RPT_CR_TEST1，而最终是以mytable为准的
        //使用 PUSH模式的优点就在此，可以自由组合SQL
        //前提是表名称和字段名（需要在SQL中使用as别名的方式跟xsd中设计的字段名一致）都要一致
        da.Fill(dt1, "mytable");*/

       // ReportDocument myReport = new ReportDocument();
        string reportPath = Server.MapPath("~/cgxt/rpt/cgdPrint.rpt");
        myReport.Load(reportPath);

       

        //绑定数据集，注意，一个报表用一个数据集。

        myReport.SetDataSource(ds);
        //初始化参数 需要放在SetDataSource之后
        myReport.SetParameterValue("gcdz", ddlGc.SelectedValue);
        CrystalReportViewer1.ReportSource = myReport;
        sqlconn.Close();

    }

    private void Page_Unload(object sender, EventArgs e)
    {
        myReport.Dispose();
        CrystalReportViewer1.Dispose();
      
    }




    protected void ddlGc_SelectedIndexChanged(object sender, EventArgs e)
    {
        ConfigureCrystalReports();
    }
}
