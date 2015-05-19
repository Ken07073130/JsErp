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

public partial class sclr_jsscrbcx : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string C_pc = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
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
    }

    public void bind()
    {


        qsrq.Text = DateTime.Now.ToString("yyyy-MM-dd");
        jsrq.Text = DateTime.Now.ToString("yyyy-MM-dd");

    }


    public void getbind()
    {
        string sql = "";
        string xmsql = "";
        if (pc.Text.Trim() != "")
        {
            xmsql += " and  pc ='" + pc.Text + "'";
        }

        if (xh.Text.Trim() != "")
        {
            xmsql += " and  xh ='" + xh.Text + "'";
        }
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString); //数据库连接
        sql = "SELECT CONVERT(varchar(10) , scrq, 120 ) as 生产日期,[xh] as 电芯型号,[rl] as 容量,[pc] as 生产批次,"
            + "[tb_z_sc] as 涂布_正极_生产,[tb_z_zc] as 涂布_正极_转出,[tb_z_dmjc] as 涂布_正极_单面结存,[tb_z_bf] as 涂布_正极_报废,[tb_z_hgl] as 涂布_正极_涂布合格率,[tb_z_cy] as 涂布_正极_差异, "
            + "[tb_f_sc] as 涂布_负极_生产,[tb_f_zc] as 涂布_负极_转出,[tb_f_dmjc] as 涂布_负极_单面结存,[tb_f_bf] as 涂布_负极_报废,[tb_f_hgl] as 涂布_负极_涂布合格率,[tb_f_cy] as 涂布_负极_差异,"
            + "[fq_z_qrjc] as 分切_正极_前日结存,[fq_z_zr] as 分切_正极_转入,[fq_z_sc] as 分切_正极_生产,[fq_z_hgzc] as 分切_正极_合格转出,[fq_z_rk] as 分切_正极_入库,[fq_z_drjc] as 分切_正极_当日结存,[fq_z_bf] as 分切_正极_报废,[fq_z_cy] as 分切_正极_差异,"
            + "[fq_f_qrjc] as 分切_负极_前日结存,[fq_f_zr] as 分切_负极_转入,[fq_f_sc] as 分切_负极_生产,[fq_f_hgzc] as 分切_负极_合格转出,[fq_f_rk] as 分切_负极_入库,[fq_f_drjc] as 分切_负极_当日结存,[fq_f_bf] as 分切_负极_报废,[fq_f_cy] as 分切_负极_差异,"
            + "[fxp_z_qryz] as 分小片_正极_前日已制,[fxp_z_qrwz] as 分小片_正极_前日未制,[fxp_z_zrhg] as 分小片_正极_转入合格,[fxp_z_zrbhg] as 分小片_正极_转入不合格,[fxp_z_schg] as 分小片_正极_生产合格,[fxp_z_scbhg] as 分小片_正极_生产不合格,[fxp_z_zchg] as 分小片_正极_转出合格,[fxp_z_zcbhg] as 分小片_正极_转出不合格,[fxp_z_dryz] as 分小片_正极_当日已制,[fxp_z_drwz] as 分小片_正极_当日未制,[fxp_z_bf] as 分小片_正极_报废,[fxp_z_cy] as 分小片_正极_差异,"
            + "[fxp_f_qryz] as 分小片_负极_当日已制,[fxp_f_qrwz] as 分小片_负极_前日未制,[fxp_f_zrhg] as 分小片_负极_转入合格,[fxp_f_zrbhg] as 分小片_负极_转入不合格,[fxp_f_schg] as 分小片_负极_生产合格,[fxp_f_scbhg] as 分小片_负极_生产不合格,[fxp_f_zchg] as 分小片_负极_转出合格,[fxp_f_zcbhg] as 分小片_负极_转出不合格,[fxp_f_dryz] as 分小片_负极_当日已制,[fxp_f_drwz] as 分小片_负极_当日未制,[fxp_f_bf] as 分小片_负极_报废,[fxp_f_cy] as 分小片_负极_差异,"
            + "[mj_z_qryz] as 铆接_正极_前日已制,[mj_z_qrwz] as 铆接_正极_前日未制,[mj_z_zrhg] as 铆接_正极_转入合格,[mj_z_zrbhg] as 铆接_正极_转入不合格,[mj_z_schg] as 铆接_正极_生产合格,[mj_z_scbhg] as 铆接_正极_生产不合格,[mj_z_zchg] as 铆接_正极_转出合格,[mj_z_zcbhg] as 铆接_正极_转出不合格,[mj_z_drzy] as 铆接_正极_当日已制,[mj_z_drwz] as 铆接_正极_当日未制,[mj_z_bf] as 铆接_正极_报废,[mj_z_cy] as 铆接_正极_差异,"
            + "[mj_f_qryz] as 铆接_负极_前日已制,[mj_f_qrwz] as 铆接_负极_前日未制,[mj_f_zrhg] as 铆接_负极_转入合格,[mj_f_zrbhg] as 铆接_负极_转入不合格,[mj_f_schg] as 铆接_负极_生产合格,[mj_f_scbhg] as 铆接_负极_生产不合格,[mj_f_zchg] as 铆接_负极_转出合格,[mj_f_zcbhg] as 铆接_负极_转出不合格,[mj_f_drzy] as 铆接_负极_当日已制,[mj_f_drwz] as 铆接_负极_当日未制,[mj_f_bf] as 铆接_负极_报废,[mj_f_cy] as 铆接_负极_差异,"
            + "[jr_qrjpz] as 卷绕_前日结存正极片,[jr_qrjpf] as 卷绕_前日结存负极片,[jr_qrhgjx] as 卷绕_前日结存合格卷芯,[jr_qrbhgjx] as 卷绕_前日结存不合格卷芯,[jr_zrz] as 卷绕_转入正极,[jr_zrf] as 卷绕_转入负极,[jr_schg] as 卷绕_生产合格,[jr_scbhg] as 卷绕_生产不合格,[jr_zc] as 卷绕_转出,[jr_drjpz] as 卷绕_当日结存正极片,[jr_drjpf] as 卷绕_当日结存负极片,[jr_drhgjx] as 卷绕_当日结存合格卷芯,[jr_drbhgjx] as 卷绕_当日结存不合格卷芯,[jr_bfz] as 卷绕_报废正极片,[jr_bff] as 卷绕_报废负极片,[jr_cyz] as 卷绕_差异正极片,[jr_cyf] as 卷绕_报废负极片,"
            + "[fz_qryz] as 封装_前日已制,[fz_qrwz] as 封装_前日未制,[fz_zrhg] as 封装_转入合格,[fz_zrbhg] as 封装_转入不合格,[fz_schg] as 封装_生产合格,[fz_scbhg] as 封装_生产不合格,[fz_zchg] as 封装_转出合格,[fz_zcbhg] as 封装_转出不合格,[fz_dryz] as 封装_当日已制,[fz_drwz] as 封装_当日未制,[fz_bf] as 封装_报废,[fz_cy] as 封装_差异,"
            + "[zy_qryz] as 注液_前日已制,[zy_qrwz] as 注液_前日未制,[zy_zrhg] as 注液_转入合格,[zy_zrbhg] as 注液_转入不合格,[zy_schg] as 注液_生产合格,[zy_scbhg] as 注液_生产不合格,[zy_zchg] as 注液_转出合格,[zy_zcbhg] as 注液_转出不合格,[zy_dryz] as 注液_当日已制,[zy_drwz] as 注液_当日未制,[zy_bf] as 注液_报废,[zy_cy] as 注液_差异,"
            + "[hc_qryz] as 化成_前日已制,[hc_qrwz] as 化成_前日已制,[hc_zrhg] as 化成_转入合格,[hc_zrbhg] as 化成_转入不合格,[hc_schg] as 化成_生产合格,[hc_scbhg] as 化成_生产不合格,[hc_zchg] as 化成_转出合格,[hc_zcbhg] as 化成_转出不合格,[hc_dryz] as 化成_当日已制,[hc_drwz] as 化成_当日未制,[hc_bf] as 化成_报废,[hc_cy] as 化成_差异,"
            + "[fk_qryz] as 二封_前日已制,[fk_qrwz] as 二封_前日已制,[fk_zrhg] as 二封_转入合格,[fk_zrbhg] as 二封_转入不合格,[fk_schg] as 二封_生产合格,[fk_scbhg] as 二封_生产不合格,[fk_zchg] as 二封_转出合格,[fk_zcbhg] as 二封_转出不合格,[fk_dryz] as 二封_当日已制,[fk_drwz] as 二封_当日未制,[fk_bf] as 二封_报废,[fk_cy] as 二封_报废,"
            + "[fx_qrhg] as 分选_前日合格,[fx_qrbhg] as 分选_前日不合格,[fx_qrwz] as 分选_前日未制,[fx_zrhg] as 分选_转入合格 ,[fx_zrbhg] as 分选_转入不合格,[fx_schg] as 分选_生产合格,[fx_scbhg] as 分选_生产不合格,[fx_sccf] as 分选_生产重分,[fx_zchg] as 分选_转出合格,[fx_zcbhg] as 分选_转出不合格,[fx_jchg] as 分选_结存合格,[fx_jcbhg] as 分选_结存不合格,[fx_jcwz] as 分选_结存未制,[fx_bf] as 分选_报废,[fx_cy] as 分选_差异,"
            + "[bz_qrhg] as 包装_前日合格,[bz_qrbhg] as 包装_前日不合格,[bz_qrwz] as 包装_前日未制,[bz_zrfxhg] as 包装_分选转入合格,[bz_zrfxbhg] as 包装_分选转入不合格,[bz_zrPACK] as 包装_PACK转入,[bz_zrcpk] as 包装_成品库转入,[bz_schg] as 包装_生产合格,[bz_scbhg] as 包装_生产返修,[bz_zcch] as 包装_转出到出货,[bz_zcPACK] as 包装_转出到PACK,[bz_zcfx] as 包装_转出到分选,[bz_zcA] as 包装_A品入库,[bz_zcAE] as 包装_AE品入库,[bz_zcB] as 包装_B品入库,[bz_jchg]as 包装_结存合格,[bz_jcbhg] as 包装_结存不合格,[bz_jcwz] as 包装_结存未制,[bz_bf] as 包装_报废,[bz_cy] as 包装_差异,"
            + "[p_qrhg]  as PACK_前日合格,[p_qrbhg] as PACK_前日不合格,[p_qrwz] as PACK_前日未制,[p_zrchxhg] as PACK_出货线转入合格,[p_zrchxbhg] as PACK_出货线转入不合格,[p_zrcpk] as PACK_成品库转入,[p_schg] as PACK_生产合格,[p_scbhg] as PACK_生产不合格,[p_zcfh] as PACK_转至发货合格,[p_zcA] as PACK_A品入库,[p_zcAE] as PACK_AE品入库,[p_zcB] as PACK_B品入库,[p_jchg] as PACK_结存合格,[p_jcbhg] as PACK_结存不合格,[p_jcwz] as PACK_结存未制,[p_bf] as PACK_报废,[p_cy] as PACK_差异,"
            + "[fh_qrjc] as 发货_前日结存 ,[fh_zrbz] as 发货_包装转入,[fh_zrpack] as 发货_PACK转入,[fh_fh] as 发货_发货,[fh_fhB] as 发货_B品发货,[fh_fhbh] as 发货_补货,[fh_fhbp] as 发货_备品,[fh_ktfx] as 发货_客退返修,[fh_drjc] as 发货_当日结存,[fh_cy] as 发货_差异"
            + " FROM [js_sgrbZ] where scrq between '" + qsrq.Text.Trim() + " 00:00:00' and '" + jsrq.Text.Trim() + " 23:59:59' ";
        SqlCommand cmd = new SqlCommand(sql, conn);   //调用存储过程
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@ckdm", SqlDbType.VarChar, 2000);
        //cmd.Parameters["@ckdm"].Value = C_pc;
        SqlDataAdapter adapter = new SqlDataAdapter(cmd);      //数据适配器
        DataSet ds = new DataSet();                            //数据集

        adapter.Fill(ds, "js_sgrbZ");                         //接收返回记录集   
        //GridView1.DataSource = ds;
        //GridView1.DataBind();  
        if (ds.Tables.Count == 0)
        {
            Response.Write("<script>alert('没有数据!');history.go(_1);</script>");
        }
        else
        {
            CreateExcel(ds, "cpjc.xls");
        }

    }

    public void CreateExcel(DataSet ds, string FileName)
    {
        HttpResponse resp;
        resp = Page.Response;
        resp.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
        resp.AppendHeader("Content-Disposition", "attachment;filename=" + FileName);

        string colHeaders = "", ls_item = "";

        //定义表对象与行对象，同时用DataSet对其值进行初始化 
        DataTable dt = ds.Tables[0];
        DataRow[] myRow = dt.Select();//可以类似dt.Select("id>10")之形式达到数据筛选目的
        int i = 0;
        int s = 0;
        int cl = dt.Columns.Count;
        string sz = "";

        //取得数据表各列标题，各标题之间以t分割，最后一个列标题后加回车符 
        for (s = 0; s < 3; s++)
        {
            for (i = 0; i < cl; i++)
            {
                sz = dt.Columns[i].Caption.ToString();

                if ( s==0)
                {

                    if (i == (cl - 1))//最后一列，加n
                    {
                        colHeaders += sz.Split('_')[s].ToString() + "\n";
                    }
                    else
                    {
                        colHeaders += sz.Split('_')[s].ToString() + "\t";
                    }
                }
                else if( s==1)
                {
                    if (sz.Split('_').Length == 3)
                    {
                        if (i == (cl - 1))//最后一列，加n
                        {
                            colHeaders += sz.Split('_')[s].ToString() + "\n";
                        }
                        else
                        {
                            colHeaders += sz.Split('_')[s].ToString() + "\t";
                        }
                    }
                    else
                    {
                        if (i == (cl - 1))//最后一列，加n
                        {
                            colHeaders += "  " + "\n";
                        }
                        else
                        {
                            colHeaders += " " + "\t";
                        }
                    }
                }
                else if (s == 2)
                {
                    if (sz.Split('_').Length == 3)
                    {
                        if (i == (cl - 1))//最后一列，加n
                        {
                            colHeaders += sz.Split('_')[s].ToString() + "\n";
                        }
                        else
                        {
                            colHeaders += sz.Split('_')[s].ToString() + "\t";
                        }
                    }
                    else if (sz.Split('_').Length == 2)
                    {
                        if (i == (cl - 1))//最后一列，加n
                        {
                            colHeaders += sz.Split('_')[1].ToString() + "\n";
                        }
                        else
                        {
                            colHeaders += sz.Split('_')[1].ToString() + "\t";
                        }
                    }else
                    {
                        if (i == (cl - 1))//最后一列，加n
                        {
                            colHeaders += "  " + "\n";
                        }
                        else
                        { 
                            colHeaders += " " + "\t";
                        }
                    }
                }
            }
        }
        resp.Write(colHeaders);
        //向HTTP输出流中写入取得的数据信息 

        //逐行处理数据   
        foreach (DataRow row in myRow)
        {
            //当前行数据写入HTTP输出流，并且置空ls_item以便下行数据     
            for (i = 0; i < cl; i++)
            {
                if (i == (cl - 1))//最后一列，加n
                {

                    ls_item += row[i].ToString() + "\n";

                }
                else
                {
                    ls_item += row[i].ToString() + "\t";

                }

            }
            resp.Write(ls_item);
            ls_item = "";

        }
        resp.End();
    }


    protected void check_Click(object sender, EventArgs e)
    {
       
        getbind();
    }
}
