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
using System.CodeDom;
using System.CodeDom.Compiler;
using Microsoft.CSharp;
using System.Text;
using System.Reflection;
using System.Text.RegularExpressions;

public partial class jxkh_bmlr : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    string id ="";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlConnection sqlcon1 = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlConnection sqlcon2 = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlCommand Cmd_z;
    SqlCommand Cmd_x;
    SqlDataReader sdr;
    SqlDataReader sdr_z;
    SqlDataReader sdr_x;
    string GroupName = "";
    string UserName = "";
    static string jsgs = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
        
            GroupName = Session["GroupNames"].ToString();
            UserName = Session["UserName"].ToString();
            id = Request.QueryString["id"];     //取前页传过来的ID,
            sqlcon.Open();
            string sqlstr = "SELECT * FROM [erp_js_data0704].[dbo].[js_jxkh_kjny]  WHERE shzt IN ('审核','待审核') order by id desc";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                
                DDL_KJYM.Items.Add(sdr["kjny"].ToString());
            }
            sdr.Close();
            sqlcon.Close();
            Bind();
            string gxmc = Request.QueryString["gxmc"];
        }
          
        
       
    }
    protected void B_BLJL_Click(object sender, EventArgs e)
    {

    }
    protected void Bind()
    {
        GroupName = Session["GroupNames"].ToString();
        UserName = Session["UserName"].ToString();
        HtmlTableRow tr;
        HtmlTableCell td;
        int lcount = 0;
        string kjym = "";
        sqlcon.Open();
        kjym = DDL_KJYM.SelectedValue;

        string sqlstr = "SELECT * FROM [erp_js_data0704].[dbo].[js_jxkh_kjny]  WHERE shzt='待审核' and  kjny='" + kjym + "'";

        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            if ((GroupName.IndexOf("超级用户") != -1) || GroupName.IndexOf("部门绩效考核-考核小组") != -1)
            {
                B_save.Enabled = true;
                B_sh.Enabled = true;
                B_sh.Visible = true;
            }
            else
            {
                B_save.Enabled = true;
                B_sh.Visible = false;
            }
            
        }
        else
        {
            if ((GroupName.IndexOf("超级用户") != -1) || GroupName.IndexOf("部门绩效考核-考核小组") != -1)
            {
                B_save.Enabled = false;
                B_sh.Enabled = false;
                B_sh.Visible = true;
            }
            else
            {
                B_save.Enabled = false;
                B_sh.Visible = false;
            }
            
        }
        sdr.Close();

        sqlstr = "SELECT * FROM [erp_js_data0704].[dbo].[js_jxkh_kjny]  WHERE  kjny='" + kjym + "'";

        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            TB_cwb.Text = sdr["cwb_bz"].ToString().Trim();
            TB_sbb.Text = sdr["sbb_bz"].ToString().Trim();
            TB_gcb.Text = sdr["gcb_bz"].ToString().Trim();
            TB_zlb.Text = sdr["zlb_bz"].ToString().Trim();
            TB_gyl.Text = sdr["gyl_bz"].ToString().Trim();
            TB_jsb.Text = sdr["jsb_bz"].ToString().Trim();
            TB_swb.Text = sdr["swb_bz"].ToString().Trim();
            TB_xzb.Text = sdr["xzb_bz"].ToString().Trim();
            TB_wab.Text = sdr["wab_bz"].ToString().Trim();
            TB_zzb.Text = sdr["zzb_bz"].ToString().Trim();
            TB_zjlms.Text = sdr["zjlms_bz"].ToString().Trim();
            TB_khxz.Text = sdr["khxz_bz"].ToString().Trim();
        }
        sdr.Close();

        sqlstr = "SELECT b.id bid, a.sjmc,a.fid as  fid ,a.xxbh AS  xxbh,cast((sz) as float) as sz,dw,a.lrbm lrbm FROM js_jxkh_xmsx  a LEFT JOIN dbo.js_jxkh_bmlr b ON a.fid = b.fid AND a.xxbh = b.xxbh AND b.kjny='" + kjym + "' WHERE  a.fid  IN (SELECT id FROM js_jxkh_zbsx WHERE zbsx='yx' )AND a.lrbm <>'zjlms' and a.lrbm <>'khxz' ";   //报废品的数据取出
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            lcount++;
            tr = new HtmlTableRow();
            td = new HtmlTableCell();
            string infostate = "";
            if (sdr["sz"].ToString() != null && sdr["sz"].ToString() !="" )  //告诉后台保存的时候是添加还是修改
            {
                infostate = "<input type='hidden' name='bczt" + lcount.ToString() + "' id='bczt" + lcount.ToString() + "' value='update' /> ";
            }else{
                infostate = "<input type='hidden' name='bczt" + lcount.ToString() + "' id='bczt" + lcount.ToString() + "' value='insert' /> ";
            }
            string tmp_sz = sdr["sz"].ToString().Trim();
            if (sdr["dw"].ToString().Trim() == "%" && tmp_sz!="")
            {
                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz) * 100) ;
                tmp_sz = tmp_sz.Substring(0, tmp_sz.Length - 3) + "%";
            }

            td.InnerHtml = " <input type='hidden' name='xxbh" + lcount.ToString() + "' id='xxbh" + lcount.ToString() + "' value='" + sdr["xxbh"].ToString().Trim() + "' />  <input type='hidden' name='sjmc" + lcount.ToString() + "' id='sjmc" + lcount.ToString() + "' value='" + sdr["sjmc"].ToString().Trim() + "' /> <input type='hidden' name='bid" + lcount.ToString() + "' id='bid" + lcount.ToString() + "' value='" + sdr["bid"].ToString().Trim() + "' />  " + infostate
                         + " <input type='hidden' name='fid" + lcount.ToString() + "' id='fid" + lcount.ToString() + "' value='" + sdr["fid"].ToString().Trim() + "' /> "
                         + "  " + sdr["sjmc"].ToString().Trim() + "</td>"
                         + "  <td width='150px'><input  type='text'   style='width:95%' name='TB_sz" + lcount.ToString() + "'   id='TB_sz" + lcount.ToString() + "'  value='" + tmp_sz + "'/></td>"
                         + "  <td>   " + sdr["dw"].ToString().Trim() + "";

            tr.Cells.Add(td);
            if ((sdr["lrbm"].ToString().Trim() == "cwb") && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-财务部经理") != -1))
            {
                tab_cwb.Rows.Insert(1, tr);
                TB_cwb.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "sbb" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-设备部经理") != -1))
            {
                tab_sbb.Rows.Insert(1, tr);
                TB_sbb.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "gcb" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-工程部经理") != -1))
            {
                tab_gcb.Rows.Insert(1, tr);
                TB_gcb.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "zlb" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-质量部经理") != -1))
            {
                tab_zlb.Rows.Insert(1, tr);
                TB_zlb.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "gyl" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-供应链经理") != -1))
            {
                tab_gyl.Rows.Insert(1, tr);
                TB_gyl.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "jsb" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-技术部经理") != -1))
            {
                tab_jsb.Rows.Insert(1, tr);
                TB_jsb.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "zzb" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-制造部经理") != -1))
            {
                tab_zzb.Rows.Insert(1, tr);
                TB_zzb.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "swb" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-商务部经理") != -1))
            {
                tab_swb.Rows.Insert(1, tr);
                TB_swb.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "xzb" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-行政部经理") != -1))
            {
                tab_xzb.Rows.Insert(1, tr);
                TB_xzb.Visible = true;
            }
            else if (sdr["lrbm"].ToString().Trim() == "wab" && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-网安部经理") != -1))
            {
                tab_wab.Rows.Insert(1, tr);
                TB_wab.Visible = true;
            }

        }
        sdr.Close();

        

        sqlstr = "SELECT sjmc,a.fid as  fid ,a.xxbh AS  xxbh,dw,a.lrbm lrbm,(SELECT [khbm]  FROM [erp_js_data0704].[dbo].[js_jxkh_zbsx] WHERE id =fid) khbm  FROM js_jxkh_xmsx a  WHERE  a.fid  IN (SELECT id FROM js_jxkh_zbsx WHERE zbsx='yx' ) AND (a.lrbm ='zjlms' or a.lrbm ='khxz') order by a.fid,a.sjmc  desc ";   //报废品的数据取出
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            lcount++;
            tr = new HtmlTableRow();
            td = new HtmlTableCell();
            string khbm = sdr["khbm"].ToString();

            sqlcon1.Open();
            sqlstr = "SELECT sjmc, "
                    + " max(CASE dybm when'sbb'then cast((sz) as float) ELSE 0 end)sbb,"
                    +" max(CASE dybm when'sbb'then id ELSE 0 end)sbbid,  "
                    + " max(CASE dybm when'gcb'then cast((sz) as float) ELSE 0 end)gcb,"
                    +" max(CASE dybm when'gcb'then id ELSE 0 end)gcbid,"
                    + " max(CASE dybm when'zlb'then cast((sz) as float) ELSE 0 end)zlb, "
                    +" max(CASE dybm when'zlb'then id ELSE 0 end)zlbid, "
                    + " max(CASE dybm when'gyl'then cast((sz) as float) ELSE 0 end)gyl, "
                    +" max(CASE dybm when'gyl'then id ELSE 0 end)gylid,"
                    + " max(CASE dybm when'jsb'then cast((sz) as float) ELSE 0 end)jsb, "
                    +" max(CASE dybm when'jsb'then id ELSE 0 end)jsbid, "
                    + " max(CASE dybm when'zzb'then cast((sz) as float) ELSE 0 end)zzb, "
                    +" max(CASE dybm when'zzb'then id ELSE 0 end)zzbid, "
                    + " max(CASE dybm when'swb'then cast((sz) as float) ELSE 0 end)swb, "
                    +" max(CASE dybm when'swb'then id ELSE 0 end)swbid, "
                    + " max(CASE dybm when'cwb'then cast((sz) as float) ELSE 0 end)cwb, "
                    +" max(CASE dybm when'cwb'then id ELSE 0 end)cwbid, "
                    + " max(CASE dybm when'xzb'then cast((sz) as float) ELSE 0 end)xzb, "
                    +" max(CASE dybm when'xzb'then id ELSE 0 end)xzbid, "
                    + " max(CASE dybm when'wab'then cast((sz) as float) ELSE 0 end)wab , "
                    +" max(CASE dybm when'wab'then id ELSE 0 end)wabid  "
                    +" FROM [erp_js_data0704].[dbo].[js_jxkh_bmlr] WHERE  kjny='"+ kjym +"'  and sjmc='" + sdr["sjmc"].ToString().Trim() + "'  GROUP BY sjmc ";   //报废品的数据取出
            Cmd_z = new SqlCommand(sqlstr, sqlcon1);
            sdr_z = Cmd_z.ExecuteReader();
            if (sdr_z.HasRows)
            {
                while (sdr_z.Read())
                {
                    string tmp_sbb_sz = sdr_z["sbb"].ToString().Trim();
                    string tmp_gcb_sz = sdr_z["gcb"].ToString().Trim();
                    string tmp_zlb_sz = sdr_z["zlb"].ToString().Trim();
                    string tmp_gyl_sz = sdr_z["gyl"].ToString().Trim();
                    string tmp_jsb_sz = sdr_z["jsb"].ToString().Trim();
                    string tmp_zzb_sz = sdr_z["zzb"].ToString().Trim();
                    string tmp_swb_sz = sdr_z["swb"].ToString().Trim();
                    string tmp_cwb_sz = sdr_z["cwb"].ToString().Trim();
                    string tmp_xzb_sz = sdr_z["xzb"].ToString().Trim();
                    string tmp_wab_sz = sdr_z["wab"].ToString().Trim();
                    if (sdr["dw"].ToString().Trim() == "%" )
                    {
                        if (tmp_sbb_sz != "0")
                        {
                            tmp_sbb_sz = Convert.ToString(decimal.Parse(tmp_sbb_sz) * 100);
                            tmp_sbb_sz = tmp_sbb_sz.Substring(0, tmp_sbb_sz.Length - 3) + "%";
                        }
                        if (tmp_gcb_sz != "0")
                        {
                            tmp_gcb_sz = Convert.ToString(decimal.Parse(tmp_gcb_sz) * 100);
                            tmp_gcb_sz = tmp_gcb_sz.Substring(0, tmp_gcb_sz.Length - 3) + "%";
                        }
                        if (tmp_zlb_sz != "0")
                        {
                            tmp_zlb_sz = Convert.ToString(decimal.Parse(tmp_zlb_sz) * 100);
                            tmp_zlb_sz = tmp_zlb_sz.Substring(0, tmp_zlb_sz.Length - 3) + "%";
                        }
                        if (tmp_gyl_sz != "0")
                        {
                            tmp_gyl_sz = Convert.ToString(decimal.Parse(tmp_gyl_sz) * 100);
                            tmp_gyl_sz = tmp_gyl_sz.Substring(0, tmp_gyl_sz.Length - 3) + "%";
                        }
                        if (tmp_jsb_sz != "0")
                        {
                            tmp_jsb_sz = Convert.ToString(decimal.Parse(tmp_jsb_sz) * 100);
                            tmp_jsb_sz = tmp_jsb_sz.Substring(0, tmp_jsb_sz.Length - 3) + "%";
                        }
                        if (tmp_zzb_sz != "0")
                        {
                            tmp_zzb_sz = Convert.ToString(decimal.Parse(tmp_zzb_sz) * 100);
                            tmp_zzb_sz = tmp_zzb_sz.Substring(0, tmp_zzb_sz.Length - 3) + "%";
                        }
                        if (tmp_swb_sz != "0")
                        {
                            tmp_swb_sz = Convert.ToString(decimal.Parse(tmp_swb_sz) * 100);
                            tmp_swb_sz = tmp_swb_sz.Substring(0, tmp_swb_sz.Length - 3) + "%";
                        }
                        if (tmp_cwb_sz != "0")
                        {
                            tmp_cwb_sz = Convert.ToString(decimal.Parse(tmp_cwb_sz) * 100);
                            tmp_cwb_sz = tmp_cwb_sz.Substring(0, tmp_cwb_sz.Length - 3) + "%";
                        }
                        if (tmp_xzb_sz != "0")
                        {
                            tmp_xzb_sz = Convert.ToString(decimal.Parse(tmp_xzb_sz) * 100);
                            tmp_xzb_sz = tmp_xzb_sz.Substring(0, tmp_xzb_sz.Length - 3) + "%";
                        }
                        if (tmp_wab_sz != "0")
                        {
                            tmp_wab_sz = Convert.ToString(decimal.Parse(tmp_wab_sz) * 100);
                            tmp_wab_sz = tmp_wab_sz.Substring(0, tmp_wab_sz.Length - 3) + "%";
                        }

                    }
                     
                    td.InnerHtml = " <input type='hidden' name='xxbh" + lcount.ToString() + "' id='xxbh" + lcount.ToString() + "' value='" + sdr["xxbh"].ToString().Trim() + "' />   <input type='hidden' name='bczt" + lcount.ToString() + "' id='bczt" + lcount.ToString() + "' value='update' /> "
                         + " <input type='hidden' name='fid" + lcount.ToString() + "' id='fid" + lcount.ToString() + "' value='" + sdr["fid"].ToString().Trim() + "' /><input type='hidden' name='sjmc" + lcount.ToString() + "' id='sjmc" + lcount.ToString() + "' value='" + sdr["sjmc"].ToString().Trim() + "' />  "
                         + "  " + sdr["sjmc"].ToString().Trim() + "</td>"
                         + "  <td width='60px'><input type='hidden' name='sbbid" + lcount.ToString() + "' id='sbbid" + lcount.ToString() + "' value='" + sdr_z["sbbid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("sbb") == -1) ? "disabled='false'" : "") + "   style='width:95%' name='TB_sz_sbb" + lcount.ToString() + "'   id='TB_sz_sbb" + lcount.ToString() + "'  value='" + tmp_sbb_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='gcbid" + lcount.ToString() + "' id='gcbid" + lcount.ToString() + "' value='" + sdr_z["gcbid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("gcb") == -1) ? "disabled='false'" : "") + "  style='width:95%' name='TB_sz_gcb" + lcount.ToString() + "'   id='TB_sz_gcb" + lcount.ToString() + "'  value='" + tmp_gcb_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='zlbid" + lcount.ToString() + "' id='zlbid" + lcount.ToString() + "' value='" + sdr_z["zlbid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("zlb") == -1) ? "disabled='false'" : "") + "   style='width:95%' name='TB_sz_zlb" + lcount.ToString() + "'   id='TB_sz_zlb" + lcount.ToString() + "'  value='" + tmp_zlb_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='gylid" + lcount.ToString() + "' id='gylid" + lcount.ToString() + "' value='" + sdr_z["gylid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("gyl") == -1) ? "disabled='false'" : "") + "  style='width:95%' name='TB_sz_gyl" + lcount.ToString() + "'   id='TB_sz_gyl" + lcount.ToString() + "'  value='" + tmp_gyl_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='jsbid" + lcount.ToString() + "' id='jsbid" + lcount.ToString() + "' value='" + sdr_z["jsbid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("jsb") == -1) ? "disabled='false'" : "") + "  style='width:95%' name='TB_sz_jsb" + lcount.ToString() + "'   id='TB_sz_jsb" + lcount.ToString() + "'  value='" + tmp_jsb_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='zzbid" + lcount.ToString() + "' id='zzbid" + lcount.ToString() + "' value='" + sdr_z["zzbid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("zzb") == -1) ? "disabled='false'" : "") + "  style='width:95%' name='TB_sz_zzb" + lcount.ToString() + "'   id='TB_sz_zzb" + lcount.ToString() + "'  value='" + tmp_zzb_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='swbid" + lcount.ToString() + "' id='swbid" + lcount.ToString() + "' value='" + sdr_z["swbid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("swb") == -1) ? "disabled='false'" : "") + "  style='width:95%' name='TB_sz_swb" + lcount.ToString() + "'   id='TB_sz_swb" + lcount.ToString() + "'  value='" + tmp_swb_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='cwbid" + lcount.ToString() + "' id='cwbid" + lcount.ToString() + "' value='" + sdr_z["cwbid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("cwb") == -1) ? "disabled='false'" : "") + "  style='width:95%' name='TB_sz_cwb" + lcount.ToString() + "'   id='TB_sz_cwb" + lcount.ToString() + "'  value='" + tmp_cwb_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='xzbid" + lcount.ToString() + "' id='xzbid" + lcount.ToString() + "' value='" + sdr_z["xzbid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("xzb") == -1) ? "disabled='false'" : "") + "  style='width:95%' name='TB_sz_xzb" + lcount.ToString() + "'   id='TB_sz_xzb" + lcount.ToString() + "'  value='" + tmp_xzb_sz + "'/></td>"
                         + "  <td width='60px'><input type='hidden' name='wabid" + lcount.ToString() + "' id='wabid" + lcount.ToString() + "' value='" + sdr_z["wabid"].ToString().Trim() + "' />  <input  type='text' " + ((khbm.IndexOf("wab") == -1) ? "disabled='false'" : "") + "n    style='width:95%' name='TB_sz_wab" + lcount.ToString() + "'   id='TB_sz_wab" + lcount.ToString() + "'  value='" + tmp_wab_sz + "'/></td>"
                         + "  <td width='60px'>   " + sdr["dw"].ToString().Trim() + "";
                }
            }
            else
            {
                sdr_z.Close();
                sqlstr = "SELECT *  FROM [erp_js_data0704].[dbo].js_jxkh_xmsx WHERE sjmc='" + sdr["sjmc"].ToString() + "' ";   //报废品的数据取出
                Cmd_z = new SqlCommand(sqlstr, sqlcon1);
                sdr_z = Cmd_z.ExecuteReader();
                while (sdr_z.Read())
                {
                    td.InnerHtml = " <input type='hidden' name='xxbh" + lcount.ToString() + "' id='xxbh" + lcount.ToString() + "' value='" + sdr["xxbh"].ToString().Trim() + "' />   <input type='hidden' name='bczt" + lcount.ToString() + "' id='bczt" + lcount.ToString() + "' value='insert' /> "
                         + " <input type='hidden' name='fid" + lcount.ToString() + "' id='fid" + lcount.ToString() + "' value='" + sdr["fid"].ToString().Trim() + "' /><input type='hidden' name='sjmc" + lcount.ToString() + "' id='sjmc" + lcount.ToString() + "' value='" + sdr["sjmc"].ToString().Trim() + "' />  "
                         + "  " + sdr["sjmc"].ToString().Trim() + "</td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_sbb" + lcount.ToString() + "'  " + ((khbm.IndexOf("sbb") == -1) ? " disabled='false'" : "") + "   id='TB_sz_sbb" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_gcb" + lcount.ToString() + "'  " + ((khbm.IndexOf("gcb") == -1) ? " disabled='false' " : "") + "   id='TB_sz_gcb" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_zlb" + lcount.ToString() + "'  " + ((khbm.IndexOf("zlb") == -1) ? " disabled='false' " : "") + "   id='TB_sz_zlb" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_gyl" + lcount.ToString() + "'  " + ((khbm.IndexOf("gyl") == -1) ? " disabled='false' " : "") + "   id='TB_sz_gyl" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_jsb" + lcount.ToString() + "'  " + ((khbm.IndexOf("jsb") == -1) ? " disabled='false' " : "") + "   id='TB_sz_jsb" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_zzb" + lcount.ToString() + "'  " + ((khbm.IndexOf("zzb") == -1) ? " disabled='false' " : "") + "   id='TB_sz_zzb" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_swb" + lcount.ToString() + "'  " + ((khbm.IndexOf("swb") == -1) ? " disabled='false' " : "") + "   id='TB_sz_swb" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_cwb" + lcount.ToString() + "'  " + ((khbm.IndexOf("cwb") == -1) ? " disabled='false' " : "") + "   id='TB_sz_cwb" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_xzb" + lcount.ToString() + "'  " + ((khbm.IndexOf("xzb") == -1) ? " disabled='false' " : "") + "   id='TB_sz_xzb" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'><input  type='text'   style='width:95%' name='TB_sz_wab" + lcount.ToString() + "'  " + ((khbm.IndexOf("wab") == -1) ? " disabled='false' " : "") + "   id='TB_sz_wab" + lcount.ToString() + "'  value=''/></td>"
                         + "  <td width='60px'>   " + sdr["dw"].ToString().Trim() + "";
                }
            }
            sdr_z.Close();
            sqlcon1.Close();
            

            tr.Cells.Add(td);
            if ((sdr["lrbm"].ToString().Trim() == "zjlms") && (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 || GroupName.IndexOf("部门绩效考核-总经理秘书") != -1))
            {
                tab_zjlms.Rows.Insert(1, tr);
                TB_zjlms.Visible = true;
            }
            else if ((sdr["lrbm"].ToString().Trim() == "khxz")&& (GroupName.IndexOf("超级用户") != -1 || GroupName.IndexOf("部门绩效考核-考核小组") != -1 ))
            {
                tab_khxz.Rows.Insert(1, tr);
                TB_khxz.Visible = true;
            }

        }

        l.Value = lcount.ToString();
        sdr.Close();
        
        
    }
    


    protected void AddDate()   //添加记录
    {
        GroupName = Session["GroupNames"].ToString();
        UserName = Session["UserName"].ToString();
        sqlcon.Open();   //添加主要信息
        string kjym = "";
        kjym = DDL_KJYM.SelectedValue;
        string sqlstr = " INSERT INTO js_jxkh_bmlr(fid,kjny,xxbh,sz,dybm,sjmc) ";
        string sqlstr1 = "";
        string srz = "";
        for (int i = 1; i <= System.Int32.Parse(l.Value); i++)
        {
            if (Request["fid" + i] != null)
            {
                if (Request["bczt" + i].ToString() == "insert")
                {
                    if (Request["TB_sz" + i] != null && Request["TB_sz" + i].ToString()!="")
                    {
                        string tmp_sz = Request["TB_sz" + i].ToString();
                        if (tmp_sz.IndexOf("%") != -1)
                        {
                            tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'','" + Request["sjmc" + i].ToString() + "'  union all";
                        }
                        else
                        {
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + Request["TB_sz" + i].ToString() + ",'','" + Request["sjmc" + i].ToString() + "'  union all";
                        }
                        
                    }
                    else
                    {
                        if (Request["TB_sz_sbb" + i] != null && Request["TB_sz_sbb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_sbb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'sbb','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                        if (Request["TB_sz_gcb" + i] != null && Request["TB_sz_gcb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_gcb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'gcb','" + Request["sjmc" + i].ToString() + "' union all";
                        } 
                        if (Request["TB_sz_zlb" + i] != null && Request["TB_sz_zlb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_zlb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'zlb','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                        if (Request["TB_sz_gyl" + i] != null && Request["TB_sz_gyl" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_gyl" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'gyl','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                        if (Request["TB_sz_jsb" + i] != null && Request["TB_sz_jsb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_jsb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'jsb','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                        if (Request["TB_sz_zzb" + i] != null && Request["TB_sz_zzb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_zzb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'zzb','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                        if (Request["TB_sz_swb" + i] != null && Request["TB_sz_swb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_swb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'swb','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                        if (Request["TB_sz_cwb" + i] != null && Request["TB_sz_cwb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_cwb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'cwb','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                        if (Request["TB_sz_xzb" + i] != null && Request["TB_sz_xzb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_xzb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'xzb','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                        if (Request["TB_sz_wab" + i] != null && Request["TB_sz_wab" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_wab" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'wab','" + Request["sjmc" + i].ToString() + "' union all";
                        }
                    }
                }
                else if (Request["bczt" + i].ToString() == "update" )
                {

                    if (Request["TB_sz" + i] != null && Request["TB_sz" + i].ToString() != "")
                    {
                        string tmp_sz = Request["TB_sz" + i].ToString();
                        if (tmp_sz.IndexOf("%") != -1)
                        {
                            tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                        }
                        sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["bid" + i].ToString() + " ";
                        Cmd = new SqlCommand(sqlstr1, sqlcon);
                        Cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        if (Request["TB_sz_sbb" + i] != null && Request["TB_sz_sbb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_sbb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["sbbid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["j" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'sbb','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["sbbid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_gcb" + i] != null && Request["TB_sz_gcb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_gcb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["gcbid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'gcb','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["gcbid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_zlb" + i] != null && Request["TB_sz_zlb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_zlb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["zlbid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'zlb','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["zlbid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_gyl" + i] != null && Request["TB_sz_gyl" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_gyl" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["gylid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'gyl','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["gylid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_jsb" + i] != null && Request["TB_sz_jsb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_jsb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["jsbid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'jsb','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["jsbid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_zzb" + i] != null && Request["TB_sz_zzb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_zzb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["zzbid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'zzb','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["zzbid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_swb" + i] != null && Request["TB_sz_swb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_swb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["swbid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'swb','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["swbid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_cwb" + i] != null && Request["TB_sz_cwb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_cwb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["cwbid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'cwb','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["cwbid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_xzb" + i] != null && Request["TB_sz_xzb" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_xzb" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["xzbid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'xzb','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["xzbid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                        if (Request["TB_sz_wab" + i] != null && Request["TB_sz_wab" + i].ToString() != "")
                        {
                            string tmp_sz = Request["TB_sz_wab" + i].ToString();
                            if (tmp_sz.IndexOf("%") != -1)
                            {
                                tmp_sz = Convert.ToString(decimal.Parse(tmp_sz.Substring(0, tmp_sz.Length - 1)) / 100);
                            }
                            if (Request["wabid" + i].ToString() == "0")
                            {
                                sqlstr += " select  " + Request["fid" + i].ToString() + ",'" + kjym + "','" + Request["xxbh" + i].ToString() + "'," + tmp_sz + ",'wab','" + Request["sjmc" + i].ToString() + "' union all";
                            }
                            else
                            {
                                sqlstr1 = " update js_jxkh_bmlr set  sz=" + tmp_sz + " where id= " + Request["wabid" + i].ToString() + " ";
                                Cmd = new SqlCommand(sqlstr1, sqlcon);
                                Cmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
        }
            
         
        
        if (sqlstr.Trim().Length >= 80)
        {
            sqlstr = sqlstr.Substring(0, sqlstr.Length - 10);
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            
        }


        sqlstr1 = " update js_jxkh_kjny set  sbb_bz='" + TB_sbb.Text.Trim() + "', gcb_bz='" + TB_gcb.Text.Trim() + "',zlb_bz='" + TB_zlb.Text.Trim() + "',gyl_bz='" + TB_gyl.Text.Trim() + "',jsb_bz='" + TB_jsb.Text.Trim() + "',zzb_bz='" + TB_zzb.Text.Trim() + "',xzb_bz='" + TB_xzb.Text.Trim() + "',cwb_bz='" + TB_cwb.Text.Trim() + "',swb_bz='" + TB_swb.Text.Trim() + "',wab_bz='" + TB_wab.Text.Trim() + "',zjlms_bz='" + TB_zjlms.Text.Trim() + "',khxz_bz='" + TB_khxz.Text.Trim() + "'     where kjny = '" + kjym + "' ";
        Cmd = new SqlCommand(sqlstr1, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

    }

    public void SHContent()
    {
        GroupName = Session["GroupNames"].ToString();
        UserName = Session["UserName"].ToString();
        int xms=0;
        int lrs=0;
        string kjym = "";
        sqlcon.Open();
        kjym = DDL_KJYM.SelectedValue;
        string df = "";//公式计算得分
       //先比较需要输入的数据和已经填写的数据数量是否一致   --暂时只想到这个比较笨的办法
        string sqlstr = "SELECT COUNT(DISTINCT sjmc) xms FROM js_jxkh_bmlr WHERE kjny='" + kjym + "' and fid IN (SELECT id FROM js_jxkh_zbsx WHERE zbsx='yx')";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            xms=Convert.ToInt32(sdr["xms"].ToString());
        }
        sdr.Close();
        sqlstr = "SELECT COUNT(DISTINCT sjmc ) lrs FROM js_jxkh_xmsx WHERE fid IN (SELECT id FROM js_jxkh_zbsx WHERE zbsx='yx')";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            lrs=Convert.ToInt32(sdr["lrs"].ToString());
        }
        sdr.Close();

        if (lrs == xms) //如果数量一致则开始计算
        {
            sqlstr = "SELECT * FROM js_jxkh_zbsx WHERE zbsx='yx' ";   //取出正在执行的考核条件
            string sqlstrxm = "";
            string khfw = "";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                Hashtable hsh_khbm = new Hashtable(); //  创建存放需要考核的部门列表
                string[] khbm = sdr["khbm"].ToString().Split(',');  //取出需要考核的部门信息存入哈希表
                for (int i = 0; i < khbm.Length; i++)
                {
                    hsh_khbm.Add(khbm[i].ToString(), "");
                }
                khfw = sdr["zbjb"].ToString();
                Hashtable hshTable = new Hashtable(); //  创建哈希表 
                Hashtable hst_dbm = new Hashtable(); //  创建哈希表 
                string gs = sdr["gs"].ToString();
                string pattern = "\\[\\w+\\]";                        //用正则表达式取出计算公式中的变量
                sqlstrxm = "";
                MatchCollection results = Regex.Matches(gs, pattern);
                for (int i = 0; i < results.Count; i++)
                {
                    sqlstrxm += "'" + results[i].ToString() + "' ,";
                    if (hshTable.Contains(results[i].ToString()) == false)
                    {
                        hshTable.Add(results[i].ToString(), "");
                    }
                }
                sqlstrxm = sqlstrxm.Substring(0, sqlstrxm.Length - 1);
                if (sdr["gzbh"].ToString().Trim() == "A" || (sdr["gzbh"].ToString().Trim() == "B"))
                {
                    sqlcon1.Open();
                    string zzdf = "";
                    string khgz = "";
                    string tsgz = "";

                    ArrayList list_gz = new ArrayList();
                    js_khgzA gzA = new js_khgzA();
                    sqlstr = "select * from js_jxkh_gz WHERE fid =" + sdr["id"].ToString() + " order by fs desc"; //去数据库中取出相应的变量的数值
                    Cmd_z = new SqlCommand(sqlstr, sqlcon1);
                    sdr_z = Cmd_z.ExecuteReader();
                    while (sdr_z.Read())
                    {
                        khgz = sdr_z["gzlx"].ToString();
                        if (khgz == "B")
                        {
                            js_jxkh_gz gz = new js_jxkh_gz();
                            gz.Id = Int32.Parse(sdr_z["id"].ToString());
                            gz.Fid = Int32.Parse(sdr_z["fid"].ToString());
                            gz.Gzmc = sdr_z["gzmc"].ToString();
                            gz.Gzlx = sdr_z["gzlx"].ToString();
                            gz.Gzdx = sdr_z["gzdx"].ToString();
                            if (sdr_z["gzdx"].ToString() == "附加规则")
                            {
                                tsgz = "附加规则";
                            }
                            gz.Gz1 = sdr_z["gz1"].ToString();
                            gz.Gz2 = sdr_z["gz2"].ToString();
                            if (sdr_z["sz1"] != null && sdr_z["sz1"].ToString() != "")
                            {
                                gz.Sz1 = Double.Parse(sdr_z["sz1"].ToString());
                            }
                            if (sdr_z["sz2"] != null && sdr_z["sz2"].ToString() != "")
                            {
                                gz.Sz2 = Double.Parse(sdr_z["sz2"].ToString());
                            }
                            gz.Dw1 = sdr_z["dw1"].ToString();
                            gz.Dw2 = sdr_z["dw2"].ToString();
                            gz.Dygs = sdr_z["dygs"].ToString();
                            gz.Fs = Double.Parse(sdr_z["fs"].ToString());
                            gz.Gx = sdr_z["gx"].ToString();
                            list_gz.Add(gz);
                        }
                        else if (khgz == "A")
                        {
                            if (sdr_z["gz1"].ToString() == "考核幅度")
                            {
                                gzA.Khfd = Int32.Parse(sdr_z["fs"].ToString());
                            }
                            else if (sdr_z["gz1"].ToString() == "最高分")
                            {
                                gzA.Zgf = Int32.Parse(sdr_z["fs"].ToString());
                            }
                            else if (sdr_z["gz1"].ToString() == "最低分")
                            {
                                gzA.Zdf = Int32.Parse(sdr_z["fs"].ToString());
                            }
                            else if (sdr_z["gz1"].ToString() == "发货金额高出")
                            {
                                gzA.Fhjegy = Int32.Parse(sdr_z["fs"].ToString());
                            }
                            else if (sdr_z["gz1"].ToString() == "考核分小于")
                            {
                                gzA.Khfxy = Int32.Parse(sdr_z["fs"].ToString());
                            }
                            else if (sdr_z["gz1"].ToString() == "补足")
                            {
                                gzA.Bz = Int32.Parse(sdr_z["fs"].ToString());
                            }
                        }

                    }

                    if (khgz == "A")
                    {

                        sqlcon2.Open();
                        sqlstr = "select * from js_jxkh_bmlr where kjny='"+ kjym +"' and  xxbh in (" + sqlstrxm + ")"; //去数据库中取出相应的变量的数值
                        Cmd_x = new SqlCommand(sqlstr, sqlcon2);
                        sdr_x = Cmd_x.ExecuteReader();
                        decimal ydchje = 0;
                        while (sdr_x.Read())
                        {
                            if (sdr_x["xxbh"].ToString() == "[A013]")
                            {
                                ydchje = Convert.ToDecimal(sdr_x["sz"].ToString());
                            }
                            hshTable[sdr_x["xxbh"].ToString()] = sdr_x["sz"].ToString();
                        }

                        for (int i = 0; i < results.Count; i++)
                        {
                            gs = gs.Replace(results[i].ToString(), hshTable[results[i].ToString()].ToString());
                        }
                        gs = gs + " *" + gzA.Khfd.ToString();
                        sdr_x.Close();

                        DataTable dt = new DataTable();
                        df = dt.Compute(gs, "").ToString();

                        if (ydchje > gzA.Fhjegy)
                        {
                            if (Double.Parse(df) < gzA.Khfxy)
                            {
                                df = "10";
                            }
                        }
                        else
                        {
                            if (Double.Parse(df) > gzA.Zgf)
                            {
                                df = "30";
                            }
                            else if (Double.Parse(df) < gzA.Zdf)
                            {
                                df = "-30";
                            }
                        }
                        sqlstr = "insert into js_jxkh_tj (kjny,khxm,khfw," + sdr["khbm"].ToString() + ") select '" + kjym + "','" + sdr["zbmc"].ToString() + "','" + sdr["jbmc"].ToString() + "'"; //去数据库中取出相应的变量的数值
                        for (int i = 0; i < sdr["khbm"].ToString().Split(',').Length; i++)
                        {
                            sqlstr += "," + df;
                        }
                        Cmd_z = new SqlCommand(sqlstr, sqlcon2);
                        Cmd_z.ExecuteNonQuery();
                        sqlcon2.Close();


                    }
                    else if (khgz == "B")
                    {
                        if (khfw == "gsj" || khfw == "bmj") //如果考核范围是部门级或者公司级的只要计算一次公式然后把数据写到需要考核的部门就可以。
                        {
                            sqlcon2.Open();
                            sqlstr = "select * from js_jxkh_bmlr where kjny='"+ kjym +"' and xxbh in (" + sqlstrxm + ")"; //去数据库中取出相应的变量的数值
                            Cmd_x = new SqlCommand(sqlstr, sqlcon2);
                            sdr_x = Cmd_x.ExecuteReader();
                            while (sdr_x.Read())
                            {
                                hshTable[sdr_x["xxbh"].ToString()] = sdr_x["sz"].ToString();
                            }

                            for (int i = 0; i < results.Count; i++)
                            {
                                gs = gs.Replace(results[i].ToString(), hshTable[results[i].ToString()].ToString());
                            }

                            sdr_x.Close();
                            sqlcon2.Close();
                            DataTable dt = new DataTable();
                            df = dt.Compute(gs, "").ToString();

                            jsgs = "";
                            for (int i = 0; i < list_gz.Count; i++)
                            {
                                if (((js_jxkh_gz)list_gz[i]).Gz1 == "" && ((js_jxkh_gz)list_gz[i]).Gz2 != "")
                                {
                                    jsgs = df + ((js_jxkh_gz)list_gz[i]).Gz2 + ((js_jxkh_gz)list_gz[i]).Sz2 + "?" + ((js_jxkh_gz)list_gz[i]).Fs + ":99999";
                                }
                                else if (((js_jxkh_gz)list_gz[i]).Gz2 == "" && ((js_jxkh_gz)list_gz[i]).Gz1 != "")
                                {
                                    jsgs = df + ((js_jxkh_gz)list_gz[i]).Gz1 + ((js_jxkh_gz)list_gz[i]).Sz1 + "?" + ((js_jxkh_gz)list_gz[i]).Fs + ":99999";
                                }
                                else if (((js_jxkh_gz)list_gz[i]).Gz2 != "" && ((js_jxkh_gz)list_gz[i]).Gz1 != "")
                                {
                                    jsgs = df + ((js_jxkh_gz)list_gz[i]).Gz1 + ((js_jxkh_gz)list_gz[i]).Sz1 + ((js_jxkh_gz)list_gz[i]).Gx + df + ((js_jxkh_gz)list_gz[i]).Gz2 + ((js_jxkh_gz)list_gz[i]).Sz2 + "?" + ((js_jxkh_gz)list_gz[i]).Fs + ":99999";
                                }
                                if (CaclSalay() != "99999")
                                {
                                    zzdf = CaclSalay();
                                    i = list_gz.Count;
                                }
                            }
                            sdr_z.Close();
                            if (zzdf != "" && zzdf != "99999")
                            {
                                sqlstr = "insert into js_jxkh_tj (kjny,khxm,khfw," + sdr["khbm"].ToString() + ") select '" + kjym + "','" + sdr["zbmc"].ToString() + "','" + sdr["jbmc"].ToString() + "'"; //去数据库中取出相应的变量的数值
                                for (int i = 0; i < sdr["khbm"].ToString().Split(',').Length; i++)
                                {
                                    sqlstr += "," + zzdf;
                                }
                                Cmd_z = new SqlCommand(sqlstr, sqlcon1);
                                Cmd_z.ExecuteNonQuery();
                            }
                        }
                        else if (khfw == "gfj")
                        {
                            for (int n = 0; n < khbm.Length; n++)
                            {
                                sqlcon2.Open();
                                //初始化变量
                                for (int i = 0; i < results.Count; i++)
                                {
                                    hshTable[results[i].ToString()] = "0";
                                }
                                sqlstr = "select * from js_jxkh_bmlr where kjny='" + kjym + "' and  dybm='" + khbm[n] + "' and  xxbh in (" + sqlstrxm + ")"; //去数据库中取出相应的变量的数值
                                Cmd_x = new SqlCommand(sqlstr, sqlcon2);
                                sdr_x = Cmd_x.ExecuteReader();
                                while (sdr_x.Read())
                                {
                                    hshTable[sdr_x["xxbh"].ToString()] = sdr_x["sz"].ToString();
                                }

                                string gs_tmp = gs;

                                for (int i = 0; i < results.Count; i++)
                                {
                                    if (tsgz == "附加规则")
                                    {
                                        for (int s = 0; s < list_gz.Count; s++)
                                        {
                                            if (((js_jxkh_gz)list_gz[s]).Gzdx == "附加规则" && results[i].ToString() == ((js_jxkh_gz)list_gz[s]).Dygs)
                                            {
                                                if (hshTable[((js_jxkh_gz)list_gz[s]).Dygs].ToString() == "")
                                                {
                                                    hshTable[((js_jxkh_gz)list_gz[s]).Dygs] = "( 0 *" + ((js_jxkh_gz)list_gz[s]).Fs + ")";
                                                }
                                                else
                                                {
                                                    hshTable[((js_jxkh_gz)list_gz[s]).Dygs] = "(" + hshTable[((js_jxkh_gz)list_gz[s]).Dygs].ToString() + "*" + ((js_jxkh_gz)list_gz[s]).Fs + ")";
                                                }
                                                gs_tmp = gs_tmp.Replace(results[i].ToString(), hshTable[results[i].ToString()].ToString());
                                                s = list_gz.Count;
                                            }

                                        }
                                    }

                                }


                                sdr_x.Close();
                                sqlcon2.Close();
                                DataTable dt = new DataTable();
                                df = dt.Compute(gs_tmp, "").ToString();

                                jsgs = "";
                                for (int i = 0; i < list_gz.Count; i++)
                                {
                                    if (((js_jxkh_gz)list_gz[i]).Gzdx == "zt")
                                    {
                                        if (((js_jxkh_gz)list_gz[i]).Gz1 == "" && ((js_jxkh_gz)list_gz[i]).Gz2 != "")
                                        {
                                            jsgs = df + ((js_jxkh_gz)list_gz[i]).Gz2 + ((js_jxkh_gz)list_gz[i]).Sz2 + "?" + ((js_jxkh_gz)list_gz[i]).Fs + ":99999";
                                        }
                                        else if (((js_jxkh_gz)list_gz[i]).Gz2 == "" && ((js_jxkh_gz)list_gz[i]).Gz1 != "")
                                        {
                                            jsgs = df + ((js_jxkh_gz)list_gz[i]).Gz1 + ((js_jxkh_gz)list_gz[i]).Sz1 + "?" + ((js_jxkh_gz)list_gz[i]).Fs + ":99999";
                                        }
                                        else if (((js_jxkh_gz)list_gz[i]).Gz2 != "" && ((js_jxkh_gz)list_gz[i]).Gz1 != "")
                                        {
                                            jsgs = df + ((js_jxkh_gz)list_gz[i]).Gz1 + ((js_jxkh_gz)list_gz[i]).Sz1 + ((js_jxkh_gz)list_gz[i]).Gx + df + ((js_jxkh_gz)list_gz[i]).Gz2 + ((js_jxkh_gz)list_gz[i]).Sz2 + "?" + ((js_jxkh_gz)list_gz[i]).Fs + ":99999";
                                        }
                                        if (CaclSalay() != "99999")
                                        {
                                            zzdf = CaclSalay();
                                            i = list_gz.Count;
                                        }
                                    }
                                }
                                hsh_khbm[khbm[n]] = zzdf;
                            }
                            sdr_z.Close();
                            sqlstr = "insert into js_jxkh_tj (kjny,khxm,khfw," + sdr["khbm"].ToString() + ") select '" + kjym + "','" + sdr["zbmc"].ToString() + "','" + sdr["jbmc"].ToString() + "'"; //去数据库中取出相应的变量的数值
                            for (int i = 0; i < sdr["khbm"].ToString().Split(',').Length; i++)
                            {
                                sqlstr += "," + hsh_khbm[khbm[i]].ToString();
                            }
                            Cmd_z = new SqlCommand(sqlstr, sqlcon1);
                            Cmd_z.ExecuteNonQuery();


                        }

                    }
                    sqlcon1.Close();
                }
                else if (sdr["gzbh"].ToString().Trim() == "C")
                {
                    Hashtable hst_zzdf = new Hashtable(); //  创建哈希表
                    sqlcon1.Open();

                    foreach (DictionaryEntry hsh in hshTable) //ht为一个Hashtable实例
                    {
                        sqlstr = "select * from js_jxkh_bmlr WHERE kjny='" + kjym + "' and xxbh ='" + hsh.Key.ToString() + "' "; //取出所有需要计算的列表

                        Cmd_z = new SqlCommand(sqlstr, sqlcon1);
                        sdr_z = Cmd_z.ExecuteReader();
                        hst_dbm.Clear();
                        while (sdr_z.Read())
                        {
                            hst_dbm.Add(sdr_z["dybm"].ToString(), sdr_z["sz"].ToString());
                        }
                        sdr_z.Close();
                        string zzdf = "";
                        Hashtable hst_pdtj = new Hashtable(); //  创建哈希表


                        sqlstr = "select * from js_jxkh_gz WHERE fid =" + sdr["id"].ToString() + " AND dygs='" + hsh.Key.ToString() + "' order by fs desc"; //去数据库中取出相应的变量的数值
                        Cmd_z = new SqlCommand(sqlstr, sqlcon1);
                        sdr_z = Cmd_z.ExecuteReader();
                        while (sdr_z.Read())
                        {
                            hst_pdtj.Add(sdr_z["id"].ToString(), "[XXX]" + sdr_z["gz1"].ToString() + sdr_z["sz1"].ToString() + "?" + sdr_z["fs"].ToString() + ":99999");
                        }



                        foreach (DictionaryEntry de in hst_dbm) //ht为一个Hashtable实例
                        {
                            foreach (DictionaryEntry pdtj in hst_pdtj)
                            {
                                jsgs = pdtj.Value.ToString().Replace("[XXX]", de.Value.ToString());
                                zzdf = CaclSalay();
                                if (zzdf != "99999")
                                {
                                    zzdf = CaclSalay();
                                    if (hst_zzdf.Contains(de.Key.ToString()) == false)
                                    {
                                        hst_zzdf.Add(de.Key.ToString(), zzdf);
                                    }
                                    else
                                    {
                                        hst_zzdf[de.Key.ToString()] = Int32.Parse(hst_zzdf[de.Key.ToString()].ToString()) + Int32.Parse(zzdf);
                                    }

                                    break;
                                }
                            }
                        }
                        sdr_z.Close();

                    }
                    sqlstr = "insert into js_jxkh_tj (kjny,khxm,khfw,sbb,gcb,zlb,gyl,jsb,zzb,swb,cwb,xzb,wab) values ( '"+ kjym +"','" + sdr["zbmc"].ToString() + "','" + sdr["jbmc"].ToString() + "','" + (hst_zzdf.Contains("sbb") == true ? hst_zzdf["sbb"].ToString() : "0") + "','" + (hst_zzdf.Contains("gcb") == true ? hst_zzdf["gcb"].ToString() : "0") + "','" + (hst_zzdf.Contains("zlb") == true ? hst_zzdf["zlb"].ToString() : "0") + "','" + (hst_zzdf.Contains("gyl") == true ? hst_zzdf["gyl"].ToString() : "0") + "','" + (hst_zzdf.Contains("jsb") == true ? hst_zzdf["jsb"].ToString() : "0") + "','" + (hst_zzdf.Contains("zzb") == true ? hst_zzdf["zzb"].ToString() : "0") + "','" + (hst_zzdf.Contains("swb") == true ? hst_zzdf["swb"].ToString() : "0") + "','" + (hst_zzdf.Contains("cwb") == true ? hst_zzdf["cwb"].ToString() : "0") + "','" + (hst_zzdf.Contains("xzb") == true ? hst_zzdf["xzb"].ToString() : "0") + "','" + (hst_zzdf.Contains("wab") == true ? hst_zzdf["wab"].ToString() : "0") + "')"; //去数据库中取出相应的变量的数值
                    Cmd_z = new SqlCommand(sqlstr, sqlcon1);
                    Cmd_z.ExecuteNonQuery();
                    sqlcon1.Close();

                }
                else if (sdr["gzbh"].ToString().Trim() == "N")
                {

                    sqlstr = "insert into js_jxkh_tj (kjny,khxm,khfw";
                    sqlstrxm = "SELECT '" + kjym + "','" + sdr["zbmc"].ToString() + "', '" + sdr["jbmc"].ToString() + "' ";
                    for (int i = 0; i < khbm.Length; i++)
                    {
                        sqlstr += " ,"+ khbm[i];
                        sqlstrxm += ", max(CASE dybm when'" + khbm[i] + "'then sz ELSE 0 end)" + khbm[i];
                    }

                    sqlstr += ")  " + sqlstrxm + "  FROM [erp_js_data0704].[dbo].[js_jxkh_bmlr] WHERE  kjny='" + kjym + "'  and  xxbh in (SELECT [gs]  FROM [js_jxkh_zbsx] WHERE zbmc='" + sdr["zbmc"].ToString() + "')  GROUP BY sjmc ";                        
                        //去数据库中取出相应的变量的数值
                    sqlcon1.Open();
                    Cmd_z = new SqlCommand(sqlstr,sqlcon1);
                    Cmd_z.ExecuteNonQuery();
                    sqlcon1.Close();
                    
                }

            }
            sqlcon2.Open();
            sqlstr = "update js_jxkh_kjny set shzt='审核' where shzt='待审核'   "; //把会计年月中的待审核改为审核
            Cmd_z = new SqlCommand(sqlstr, sqlcon2);
            Cmd_z.ExecuteNonQuery();

            sqlstr = "update js_jxkh_kjny set shzt='待审核' where id =(select top 1 id from js_jxkh_kjny where shzt is null or shzt='' order by id )   "; //把下个会计年月改为待审核
            Cmd_z = new SqlCommand(sqlstr, sqlcon2);
            Cmd_z.ExecuteNonQuery();
            sqlcon2.Close();


            Response.Write("<script>alert('审核成功!'); window.location.href='jxkh_bmlr.aspx'; </script>");
        }
        else
        {
            Response.Write("<script>alert('审核信息填写不完整，审核失败!');window.location.href='jxkh_bmlr.aspx'; </script>");
        }

        
        sdr.Close();
        sqlcon.Close();
       
    }

    protected void B_save_Click(object sender, EventArgs e)
    {
        AddDate();
        Response.Write("<script>alert('保存成功!'); window.location.href='jxkh_bmlr.aspx'; </script>");
    }

    protected void B_sh_Click(object sender, EventArgs e)
    {
        SHContent();

        
    }

    public static string CaclSalay()
    {
        //string formula = "应发工资=基本工资 + if(奖金>500,500,奖金)+if(考勤扣款>200,200,考勤扣款)";
        //formula = formula.Replace("应发工资=", "");
        //formula = formula.Replace("if(", "(");
        //formula = formula.Replace(",奖金", ":奖金");
        //formula = formula.Replace(",考勤扣款", ":考勤扣款");
        //formula = formula.Replace(",", "?");
        string formula = jsgs;
        ICodeCompiler compiler = new CSharpCodeProvider().CreateCompiler();
        CompilerParameters cp = new CompilerParameters();
        cp.ReferencedAssemblies.Add("system.dll");

        cp.GenerateExecutable = false;
        cp.GenerateInMemory = true;
        StringBuilder str = new StringBuilder();
        str.Append("using System; \n");
        str.Append("public class Formula { \n");

        str.AppendFormat("    public string GetSalay()");
        str.Append("{");
        str.AppendFormat("        return Convert.ToString({0}); ", formula);
        str.Append("}\n");
        str.Append("}");

        CompilerResults cr = compiler.CompileAssemblyFromSource(cp, str.ToString());
        if (cr.Errors.HasErrors)
        {
            Console.WriteLine("编译错误：");
            foreach (CompilerError err in cr.Errors)
            {
                Console.WriteLine(err.ErrorText);
            }
        }
       
        Assembly a = cr.CompiledAssembly;
        object compiled = a.CreateInstance("Formula");
        MethodInfo m = compiled.GetType().GetMethod("GetSalay");
        return (string)m.Invoke(compiled, new object[] {});

    }


    public class js_jxkh_gz
    {

        private  int id;
        public int Id
        {
            get { return id; }
            set { id = value; }
        }

	    private  int fid;
        public int Fid
        {
            get { return fid; }
            set { fid = value; }
        }

	    private String gzmc;
        public String Gzmc
        {
            get { return gzmc; }
            set { gzmc = value; }
        }

	    private String gzlx;
        public String Gzlx
        {
            get { return gzlx; }
            set { gzlx = value; }
        }
	    private String gzdx;
        public String Gzdx
        {
            get { return gzdx; }
            set { gzdx = value; }
        }
	    private String gz1;
        public String Gz1
        {
            get { return gz1; }
            set { gz1 = value; }
        }
	    private String gz2;
        public String Gz2
        {
            get { return gz2; }
            set { gz2 = value; }
        }
	    private double sz1;
        public double Sz1
        {
            get { return sz1; }
            set { sz1 = value; }
        }
	    private double sz2;
        public double Sz2
        {
            get { return sz2; }
            set { sz2 = value; }
        }
	    private String dw1;
        public String Dw1
        {
            get { return dw1; }
            set { dw1 = value; }
        }
	    private String dw2;
        public String Dw2
        {
            get { return dw2; }
            set { dw2 = value; }
        }
	    private String gx;
        public String Gx
        {
            get { return gx; }
            set { gx = value; }
        }

        private double fs;
        public double Fs
        {
            get { return fs; }
            set { fs = value; }
        }


	    private String dygs;
        public String Dygs
        {
            get { return dygs; }
            set { dygs = value; }
        }


 
    }


    public class js_khgzA
    {
        private int khfd;
        public int Khfd
        {
            get { return khfd; }
            set { khfd = value; }
        }
        private int zgf;
        public int Zgf
        {
            get { return zgf; }
            set { zgf = value; }
        }
        private int zdf;
        public int Zdf
        {
            get { return zdf; }
            set { zdf = value; }
        }
        private int fhjegy;
        public int Fhjegy
        {
            get { return fhjegy; }
            set { fhjegy = value; }
        }
        private int khfxy;
        public int Khfxy
        {
            get { return khfxy; }
            set { khfxy = value; }
        }
        private int bz;
        public int Bz
        {
            get { return bz; }
            set { bz = value; }
        }
    }
    protected void DDL_KJYM_OnTextChanged(object sender, EventArgs e)
    {
        Bind();
    }
}
