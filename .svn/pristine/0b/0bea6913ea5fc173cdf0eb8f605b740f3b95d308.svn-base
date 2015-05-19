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

public partial class kcmx : System.Web.UI.Page {
    SqlConnection sqlcon;
    protected void Page_Load(object sender, EventArgs e) {

    }

    protected void btnExcel_Click(object sender, EventArgs e) {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = " select case when Stor_ID='0001' then '原材料仓库' else '原材料退货仓' end 仓库,a.KJYM 会计年月,x.RKRQ 入库日期,datediff(day,x.rkrq,getdate())/30.00 库龄,a.DDH 订单号,x.WLLB 物料类别,a.Mate_ID 物料编号,x.WLMC 物料名称,x.GYSMC 供应商名称,x.GG 规格,a.scph 生产批号,x.DW 单位,"
                + "    a.QCSL 期初数量,a.RKSL 入库数量,a.tksl 退库数量,a.CKSL 领料数量,a.thsl 退货数量,a.QMSL 期末数量 from dbo.ST_KCMXH a, "
                + "    (select b.WLLB,c.WLBH,c.PH,c.CW,c.HJH,c.RKRQ,b.DDH,c.WLMC,b.GYSMC,c.GG,c.DW from dbo.js_sldH b,dbo.js_sld_fllbH c where b.BH=c.BH and c.RKZT='已入库' ) x "
                + "    where a.Mate_ID=x.WLBH and a.scph=x.PH and a.hjh=x.HJH and a.ckh=x.CW "
                + "    and Stor_ID in ('0001','9100') and KJYM='"+ddlKjny.Text+"' ";
        
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "ST_KCMXH");
        if (myds.Tables.Count == 0) {
            Response.Write("<script>alert('没有数据!');history.go(-1);</script>");
        }
        else {
            CreateExcel(myds, "仓库报表"+ddlKjny.Text+".xls");
        }


        sqlcon.Close();
    }


    public void CreateExcel(DataSet ds, string FileName) {
        HttpResponse resp;
        resp = Page.Response;
        //resp.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
        //resp.AppendHeader("Content-Disposition", "attachment;filename=" + FileName);

        resp.Charset = "UTF-8";//设置输出的编码
        resp.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
        resp.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(FileName, System.Text.Encoding.UTF8));
        string colHeaders = "", ls_item = "";

        //定义表对象与行对象，同时用DataSet对其值进行初始化 
        DataTable dt = ds.Tables[0];
        DataRow[] myRow = dt.Select();//可以类似dt.Select("id>10")之形式达到数据筛选目的
        int i = 0;
        int cl = dt.Columns.Count;

        //取得数据表各列标题，各标题之间以t分割，最后一个列标题后加回车符 
        for (i = 0; i < cl; i++) {
            if (i == (cl - 1))//最后一列，加n
            {
                colHeaders += dt.Columns[i].Caption.ToString() + "\n";
            }
            else {
                colHeaders += dt.Columns[i].Caption.ToString() + "\t";
            }

        }
        resp.Write(colHeaders);
        //向HTTP输出流中写入取得的数据信息 

        //逐行处理数据   
        foreach (DataRow row in myRow) {
            //当前行数据写入HTTP输出流，并且置空ls_item以便下行数据     
            for (i = 0; i < cl; i++) {
                if (i == (cl - 1))//最后一列，加n
                {
                    ls_item += row[i].ToString() + "\n";
                }
                else {
                    ls_item += row[i].ToString() + "\t";
                }

            }
            resp.Write(ls_item);
            ls_item = "";

        }
        resp.End();
    }

}
