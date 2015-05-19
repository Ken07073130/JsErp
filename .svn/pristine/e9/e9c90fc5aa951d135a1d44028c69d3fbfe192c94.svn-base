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

public partial class ddfhPrint : System.Web.UI.Page
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
        String sqlstr = " select * from dbo.js_ddfhH a,dbo.js_ddfh_fhlbH b where a.BH=b.BH "
                       + conditionString;
        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlconn);
        //水晶报表里每张表都要设置一下数据集
            sda.Fill(ds, "myDataTable");


        myReport = new ReportDocument();
        string reportPath = Server.MapPath("~/swxt/rpt/ddfhPrint.rpt");
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
