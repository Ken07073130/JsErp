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

public partial class lltldPrint : System.Web.UI.Page
{
    ReportDocument myReport;
    protected void Page_Load(object sender, EventArgs e) {

    }

    //VS2008必须放到Page_Init中
    private void Page_Init(object sender, EventArgs e) {
        myReport = new ReportDocument();
        ConfigureCrystalReports();
    }

    private void ConfigureCrystalReports()
    {
        SqlConnection sqlconn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlconn.Open();
        string conditionString = "";
        if (!String.IsNullOrEmpty(Request["bh"].ToString())) {
            conditionString = " and charindex(a.bh,'" + Request["bh"].ToString() + "')>0";
        }
        String sqlstr =  "select case when min(a.LX)='LLD' then '领 料 单' else '退 料 单' end llzt, "
		               + "    min(a.CGY) cgy, "
		               + "    (select CKMC from dbo.CKDMH where CKDM=a.CJDM) CGYHQSJ, "
		               + "    (select flmc from dbo.js_wlflbH where fldm=(select dlbh from dbo.js_xyclbmH where wlbh=a.WLBH) and dldm=0 ) BH, "
		               + "    min(a.LLY) lly,  "
                       + " a.JBRQ,case when a.GC='1' then '新桥工厂' else '东洲工厂' end gc,c.CKMC cjdm,a.WLBH,d.wlmc IQC,d.lsmxx LX,sum(convert(float,b.flsl)) zflsl,d.dw IQCHQZT, "
                       + "           stuff( (select ','+e.PH+'('+e.FLSL+')' from dbo.js_lltld_fllbH e where e.BH=a.bh for xml path('')), 1, 1, '') IQCHQSJ  "//批号+(数量) 
                       + "    from    js_lltldH a left join "
                       + "            dbo.js_lltld_fllbH b on a.bh=b.bh, "
                       + "            dbo.CKDMH c,  "   //获取仓库名称
                       + "            dbo.js_xyclbmH d  "//获取物料详细信息
                       + "    where   a.CJDM=c.CKDM and a.WLBH=d.wlbh "
                       + conditionString 
                       + "    group by  a.BH,a.JBRQ,c.CKMC,a.WLBH,d.wlmc,d.lsmxx,d.dw,a.gc,a.cjdm ";
        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlconn);
        //水晶报表里每张表都要设置一下数据集
            sda.Fill(ds, "js_lltldH");


        myReport = new ReportDocument();
        string reportPath = Server.MapPath("~/cgxt/rpt/lltldPrint.rpt");
        myReport.Load(reportPath);

        //绑定数据集，注意，一个报表用一个数据集。
        myReport.SetDataSource(ds);


        //设置纸张
        int rawKind = 1; //记录标识自定义纸张的ID
        //枚举出所有的打印纸尺寸 
        int i = 0;
        System.Drawing.Printing.PrintDocument doc = new System.Drawing.Printing.PrintDocument();
        ddlZz.Items.Clear();
        ddlDyj.Items.Clear();
        while (!(i == doc.PrinterSettings.PaperSizes.Count)) {
            ddlZz.Items.Add(doc.PrinterSettings.PaperSizes[i].PaperName);
            if (doc.PrinterSettings.PaperSizes[i].PaperName == "24x14") {
                rawKind = doc.PrinterSettings.PaperSizes[i].RawKind;
            }
            i++;
        }
        foreach (string printer in System.Drawing.Printing.PrinterSettings.InstalledPrinters) {
            ddlDyj.Items.Add(printer);
        }

        CrystalDecisions.Shared.PageMargins margins;
        margins = myReport.PrintOptions.PageMargins;
        myReport.PrintOptions.PaperSize = (CrystalDecisions.Shared.PaperSize)rawKind;
        TextBox1.Text = "纸张:" + rawKind.ToString();





        CrystalReportViewer1.ReportSource = myReport;





        sqlconn.Close();

    }

    private void Page_Unload(object sender, EventArgs e) {
        myReport.Dispose();
        CrystalReportViewer1.Dispose();
    }




}
