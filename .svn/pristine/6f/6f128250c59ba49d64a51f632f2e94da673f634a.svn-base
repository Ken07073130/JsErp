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
using System.Reflection;
using System.Text.RegularExpressions;

public partial class jxkh_pz : System.Web.UI.Page 
{
    DataTable dt = new DataTable();
    string id ="";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    string GroupName = "";
    string UserName = "";
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
            HF_id.Value = "";
            if ((GroupName.IndexOf("超级用户") != -1) || GroupName.IndexOf("部门绩效考核-考核小组") != -1)
            {
                if (id != null && id != "")         //如果ID不为空则是编辑内容或查看内容
                {
                    HF_id.Value = id;
                    Editebind(id);

                }
                else
                {
                    Bind();
                    HF_id.Value = "ADD";
                }
                string gxmc = Request.QueryString["gxmc"];

            }
            else
            {
                Response.Write("<script>alert('您没有编辑绩效考核规则的权限!'); window.location.href='jxkh_bmlr.aspx'; </script>");
            }

            
          
        }
       
    }
    protected void B_BLJL_Click(object sender, EventArgs e)
    {

    }
    protected void Bind()
    {
        
    }
    protected void AddDate()   //添加记录
    {
        UserName = Session["UserName"].ToString();
        string khbm = "";
        string f_khbm = "";
        string sqlstr1 = "";
        string jsgs = TB_jsgs1.Text.Trim();
        for (int i = 0; i < CB_khbm.Items.Count; i++)  //读取多选空的内容 考核部门1
        {
            if (CB_khbm.Items[i].Selected)
            {
                khbm += CB_khbm.Items[i].Value +",";
            }
        }
        if (khbm != "")
        {
            khbm = khbm.Substring(0, khbm.Length - 1).ToString();
        }

        for (int i = 0; i < CB_f_khbm.Items.Count; i++)  //读取多选空的内容 考核部门2
        {
            if (CB_f_khbm.Items[i].Selected)
            {
                f_khbm += CB_f_khbm.Items[i].Value + ",";
            }
        }
        if (f_khbm != "")
        {
            f_khbm = f_khbm.Substring(0, f_khbm.Length - 1).ToString();
        }
        

        string maxid = "";
        string sqlstr = " INSERT INTO js_jxkh_zbsx(zbmc,zbjb,jbmc,zbsx,khbm,f_khbm,zbxgll,gzlx,gzbh,gs) values ( "
                      + " '" + TB_zbmc.Text.Trim() + "','" + DDL_zbjb.SelectedValue.Trim() + "','" + DDL_zbjb.SelectedItem.Text.Trim() + "', "
                      + " '" + DDL_zbsx.SelectedValue.Trim() + "','" + khbm + "','" + f_khbm + "','" + TB_zbxgll.Text.Trim() + "','" + DDL_khgz.SelectedItem.Text.Trim() + "','" + DDL_khgz.SelectedValue.Trim() + "' ,"
                      + " '" + TB_jsgs1.Text.Trim() + "') ";
        sqlcon.Open();   //添加主要信息
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        
        sqlstr = "select max(id) maxid from js_jxkh_zbsx";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            maxid = sdr["maxid"].ToString();
        }
        sdr.Close();

        
        sqlstr = "INSERT INTO dbo.js_jxkh_xmsx (fid,sjmc,mrz,dw,lrbm,xxbh) ";   
        

        if (TB_xmmc.Text.Trim() != "" )
        {
            sqlstr = sqlstr + "select " + maxid + ""
                       + ", '" + TB_xmmc.Text.Trim() + "'"
                       + ", '" + TB_mrz.Text.Trim() + "'"
                       + ", '" + TB_dw.Text.Trim() + "'"
                       + ", '" + DDL_lrbm.Text.Trim() + "'"
                       + ", '" + TB_xxbh.Text.Trim() + "'"
                       + " union all ";
        }
        for (int i = 1; i <= 15; i++)
        {
            if (Request["TB_xmmc" + i] != null)
            {
                sqlstr = sqlstr + "select " + maxid + ""
                       + ", '" + Request["TB_xmmc" + i].ToString().Trim() + "'"
                       + ", '" + Request["TB_mrz" + i].ToString().Trim() + "'"
                       + ", '" + Request["TB_dw" + i].ToString().Trim() + "'"
                       + ", '" + Request["DDL_lrbm" + i].ToString().Trim() + "'"
                       + ", '" + Request["TB_xxbh" + i].ToString().Trim() + "'"
                       + " union all ";
            }

        }

        if (sqlstr.Trim().Length >= 80)
        {
            sqlstr = sqlstr.Substring(0, sqlstr.Length - 10);
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
        }

        if (DDL_khgz.Text == "A")
        {
            if (TB_khfd.Text.Trim()!="")
            {
                sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,dw1,fs)";
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '考核幅度'"
                            + ", '分/点'"
                            + ", " + TB_khfd.Text.Trim() + ""
                            + " union all ";
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '最高分'"
                            + ", '分'"
                            + ", " + TB_zgf.Text.Trim() + ""
                            + " union all ";
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '最低分'"
                            + ", '分'"
                            + ", " + TB_zdf.Text.Trim() + ""
                            + " union all ";
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '发货金额高出'"
                            + ", '万'"
                            + ", " + TB_zhgc.Text.Trim() + ""
                            + " union all ";
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '考核分小于'"
                            + ", '分'"
                            + ", " + TB_khfxy.Text.Trim() + ""
                            + " union all ";
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '补足'"
                            + ", '分'"
                            + ", " + TB_bz.Text.Trim() + "";

            }
            
            //sqlstr1 = sqlstr1.Substring(0, sqlstr1.Length - 10);
            Cmd = new SqlCommand(sqlstr1, sqlcon);
            Cmd.ExecuteNonQuery();
            
        }
        else if (DDL_khgz.Text == "B")
        {
            sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,gz2,sz1,sz2,dw1,dw2,gx,fs)";
            string sz1 = "0";
            string sz2 = "0";
            if (TB_df51.Text.Trim() != "")
            {
                sz1 = "0";
                sz2 = "0";
                if (TB_sz51.Text.Trim() != "")
                {
                    sz1 = TB_sz51.Text.Trim();
                }
                if (TB_sz52.Text.Trim() != "")
                {
                    sz2 = TB_sz52.Text.Trim();
                }
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '" + DDL_gz51.Text.Trim() + "'"
                            + ", '" + DDL_gz52.Text.Trim() + "'"
                            + ", " + sz1 + ""
                            + ", " + sz2 + ""
                            + ", '" + TB_dw51.Text.Trim() + "'"
                            + ", '" + TB_dw52.Text.Trim() + "'"
                            + ", '" + DDL_gx51.Text.Trim() + "'"
                            + ", " + TB_df51.Text.Trim() + ""
                            + " union all ";
            }

            for (int i = 1; i <= 15; i++)
            {
                if (Request["TB_df51" + i] != null)
                {
                    sz1 = "0";
                    sz2 = "0";
                    if (Request["TB_sz51" + i].ToString() != "")
                    {
                        sz1 = Request["TB_sz51" + i].ToString();
                    }
                    if (Request["TB_sz52" + i].ToString() != "")
                    {
                        sz2 = Request["TB_sz52" + i].ToString();
                    }
                    sqlstr1 = sqlstr1 + "select " + maxid + ""
                           + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                           + ", '" + DDL_khgz.Text.Trim() + "'"
                           + ", 'zt'"
                           + ", '" + Request["DDL_gz51" + i].ToString().Trim() + "'"
                           + ", '" + Request["DDL_gz52" + i].ToString().Trim() + "'"
                           + ", " + sz1 + ""
                           + ", " + sz2 + ""
                           + ", '" + Request["TB_dw51" + i].ToString().Trim() + "'"
                           + ", '" + Request["TB_dw52" + i].ToString().Trim() + "'"
                           + ", '" + Request["DDL_gx51" + i].ToString().Trim() + "'"
                           + ", " + Request["TB_df51" + i].ToString().Trim() + ""
                           + " union all ";
                }
            }

            if (sqlstr1.Trim().Length >= 80)
            {
                sqlstr1 = sqlstr1.Substring(0, sqlstr1.Length - 10);
                Cmd = new SqlCommand(sqlstr1, sqlcon);
                Cmd.ExecuteNonQuery();
            }
            sqlstr1 = "";
            if (TB_zhs61.Text.Trim() != "")
            {
                sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,fs,dw1)";
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", '附加规则'"
                            + ", '"+ TB_dj61.Text.Trim() +"'"
                            + ", " + TB_zhs61.Text.Trim() + ""
                            + ", '" + TB_dw61.Text.Trim() + "'"
                            + " union all ";
            }

            for (int i = 1; i <= 15; i++)
            {
                if (Request["TB_zhs61" + i] != null)
                {
                    sqlstr1 = sqlstr1 + "select " + maxid + ""
                           + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                           + ", '" + DDL_khgz.Text.Trim() + "'"
                           + ", '附加规则'"
                           + ", '" + Request["TB_dj61" + i].ToString().Trim() + "'"
                           + ", '" + Request["TB_zhs61" + i].ToString().Trim() + "'"
                           + ", '" + Request["TB_dw61" + i].ToString().Trim() + "'"
                           + " union all ";
                }
            }
            if (sqlstr1.Trim().Length >= 80)
            {
                sqlstr1 = sqlstr1.Substring(0, sqlstr1.Length - 10);
                Cmd = new SqlCommand(sqlstr1, sqlcon);
                Cmd.ExecuteNonQuery();
            }
        }

        else if (DDL_khgz.Text == "C")
        {
            sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,sz1,dw1,fs,dygs)";
            if (TB_df21.Text.Trim() != "")
            {
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '" + DDL_gz21.Text.Trim() + "'"
                            + ", "  + TB_sz21.Text.Trim() + ""
                            + ", '" + TB_dw21.Text.Trim() + "'" 
                            + ", "  + TB_df21.Text.Trim() + ""
                            + ", '" + TB_dygs1.Text.Trim() + "'"
                            + " union all ";
            }
            for (int i = 1; i <= 15; i++)
            {
                if (Request["TB_df21" + i] != null) 
                {
                    sqlstr1 = sqlstr1 + "select " + maxid + ""
                           + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                           + ", '" + DDL_khgz.Text.Trim() + "'"
                           + ", 'zt'"
                           + ", '" + Request["DDL_gz21" + i].ToString().Trim() + "'"
                           + ",  " + Request["TB_sz21" + i].ToString().Trim() + ""
                           + ", '" + Request["TB_dw21" + i].ToString().Trim() + "'"
                           + ",  " + Request["TB_df21" + i].ToString().Trim() + ""
                           + ", '" + TB_dygs1.Text.Trim() + "'"
                           + " union all ";
                }
            }
            if (sqlstr1.Trim().Length >= 80)
            {
                sqlstr1 = sqlstr1.Substring(0, sqlstr1.Length - 10);
                Cmd = new SqlCommand(sqlstr1, sqlcon);
                Cmd.ExecuteNonQuery();
            }

            sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,sz1,dw1,fs,dygs)";
            if (TB_df41.Text.Trim() != "")
            {
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'ft'"
                            + ", '" + DDL_gz41.Text.Trim() + "'"
                            + ", "  + TB_sz41.Text.Trim() + ""
                            + ", '" + TB_dw41.Text.Trim() + "'"
                            + ", "  + TB_df41.Text.Trim() + ""
                            + ", '" + TB_dygs1.Text.Trim() + "'"
                            + " union all ";
            }

            for (int i = 1; i <= 15; i++)
            {
                if (Request["TB_df41" + i] != null)
                {
                    sqlstr1 = sqlstr1 + "select " + maxid + ""
                           + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                           + ", '" + DDL_khgz.Text.Trim() + "'"
                           + ", 'ft'"
                           + ", '" + Request["DDL_gz41" + i].ToString().Trim() + "'"
                           + ",  " + Request["TB_sz41" + i].ToString().Trim() + ""
                           + ", '" + Request["TB_dw41" + i].ToString().Trim() + "'"
                           + ",  " + Request["TB_df41" + i].ToString().Trim() + ""
                           + ", '" + TB_dygs1.Text.Trim() + "'"
                           + " union all ";
                }
            }
            if (sqlstr1.Trim().Length >= 80)
            {
                sqlstr1 = sqlstr1.Substring(0, sqlstr1.Length - 10);
                Cmd = new SqlCommand(sqlstr1, sqlcon);
                Cmd.ExecuteNonQuery();
            }

        }

        sqlcon.Close();
    }

    public void Editebind(string id)
    {
        sqlcon.Open();  
        //添加主要信息
        string sqlstr = "select *  from js_jxkh_zbsx where id= "+id;
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            
            TB_zbmc.Text = sdr["zbmc"].ToString();
            TB_jsgs1.Text = sdr["gs"].ToString();
            TB_zbxgll.Text = sdr["zbxgll"].ToString();
            DDL_zbjb.Items.FindByValue(sdr["zbjb"].ToString().Trim()).Selected = true;
            DDL_zbsx.Items.FindByValue(sdr["zbsx"].ToString().Trim()).Selected = true;
            DDL_khgz.Items.FindByValue(sdr["gzbh"].ToString().Trim()).Selected = true;
            //获取的值一一去匹配CHECKBOXLIST的值，若匹配上 则打勾
            for (int i = 0; i < CB_khbm.Items.Count; i++)
            {
                if (sdr["khbm"].ToString().IndexOf(CB_khbm.Items[i].Value) != -1)
                {
                    CB_khbm.Items[i].Selected = true;
                }
            }
            for (int i = 0; i < CB_f_khbm.Items.Count; i++)
            {
                if (sdr["f_khbm"].ToString().IndexOf(CB_f_khbm.Items[i].Value) != -1)
                {
                    CB_f_khbm.Items[i].Selected = true;
                }
            }

        }
        sdr.Close();
        //添加
        HtmlTableRow tr;
        HtmlTableCell td;
        int lcount = 0;
        sqlstr = "SELECT *  FROM js_jxkh_xmsx WHERE fid= " + id;
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            lcount++;
            tr = new HtmlTableRow();
            td = new HtmlTableCell();

            td.InnerHtml = " <input type='hidden' name='xmsx" + lcount + "' id='xmsx" + lcount + "' value='" + sdr["id"].ToString().Trim() + "' /> <input  type='text'  style='width:95%' name='TB_xmmc" + lcount + "'   id='TB_xmmc" + lcount + "'  value='" + sdr["sjmc"].ToString() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='TB_mrz" + lcount + "'   id='TB_mrz" + lcount + "'  value='" + sdr["mrz"].ToString() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='TB_dw" + lcount + "'   id='TB_dw" + lcount + "' value='" + sdr["dw"].ToString() + "' /></td>"
                        + "  <td><select   style='width:95%' name='DDL_lrbm" + lcount + "' ID='DDL_lrbm" + lcount + "'  ><option></option><option value='sbb'>设备部</option><option value='gcb'>工程部</option><option value='zlb'>质量部</option> <option value='gyl'>供应链管理部</option> <option value='jsb'>技术部</option><option value='zzb'>制造部</option>  <option value='swb'>商务部</option><option value='cwb'>财务部</option>    <option value='xzb'>行政部</option><option value='wab'>网络安防部</option><option value='scb'>市场部</option><option value='zjlms'>总经理秘书</option><option value='khxz'>考核小组</option>   </select> <script>document.getElementById('DDL_lrbm" + lcount + "').value='" + sdr["lrbm"].ToString().Trim() + "';</script> </td> "
                        + "  <td><input  type='text'  style='width:95%' name='TB_xxbh" + lcount + "'   id='TB_xxbh" + lcount + "' value='" + sdr["xxbh"].ToString() + "' readonly />"
                        + "  <td><input type='checkbox' name='ckb'    value='xmsx" + lcount + "'   />";

            tr.Cells.Add(td);
            tab.Rows.Insert(2,tr);
        }
        bl.Value=lcount.ToString();
        sdr.Close();


        lcount = 0;
        int llcount = 0;
        sqlstr = "SELECT * FROM js_jxkh_gz WHERE fid ="+ id +" order by id desc";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            if (DDL_khgz.SelectedItem.Value == "A")
            {
                if (sdr["gz1"].ToString() == "考核幅度")
                {
                    TB_khfd.Text = sdr["fs"].ToString();
                }
                else if (sdr["gz1"].ToString() == "最高分")
                {
                    TB_zgf.Text = sdr["fs"].ToString();
                }
                else if (sdr["gz1"].ToString() == "最低分")
                {
                    TB_zdf.Text = sdr["fs"].ToString();
                }
                else if (sdr["gz1"].ToString() == "发货金额高出")
                {
                    TB_zhgc.Text = sdr["fs"].ToString();
                }
                else if (sdr["gz1"].ToString() == "考核分小于")
                {
                    TB_khfxy.Text = sdr["fs"].ToString();
                }
                else if (sdr["gz1"].ToString() == "补足")
                {
                    TB_bz.Text = sdr["fs"].ToString();
                }
            }
            else if (DDL_khgz.SelectedItem.Value == "B")
            {
                if (sdr["gzdx"].ToString() == "zt")
                {
                    lcount++;
                    tr = new HtmlTableRow();
                    td = new HtmlTableCell();
                    td.InnerHtml = "  <input type='hidden' name='gzB" + lcount + "' id='gzB" + lcount + "' value='" + sdr["id"].ToString().Trim() + "' />  <select  style='width:95%'  name='DDL_gz51" + lcount + "' ID='DDL_gz51" + lcount + "'  ><option></option><option value='>'>＞</option><option value='>='>≥</option><option value='=='>=</option> <option value='<='>≤</option> <option value='<'>＜</option> </select> <script>document.getElementById('DDL_gz51" + lcount + "').value='" + sdr["gz1"].ToString().Trim() + "';</script> </td>  "
                                + "  <td><input  type='text'  style='width:95%' name='TB_sz51" + lcount + "'   id='TB_sz51" + lcount + "'  value='" + sdr["sz1"].ToString() + "'/></td>"
                                + "  <td><input  type='text'  style='width:95%' name='TB_dw51" + lcount + "'   id='TB_dw51" + lcount + "' value='" + sdr["dw1"].ToString() + "' /></td>"
                                + "  <td> <select   style='width:95%' name='DDL_gx51" + lcount + "' ID='DDL_gx51" + lcount + "'  ><option></option><option value='&&'>and</option><option value='||'>or</option> <script>document.getElementById('DDL_gx51" + lcount + "').value='" + sdr["gx"].ToString().Trim() + "';</script> </select> </td>  "
                                + "  <td> <select   style='width:95%' name='DDL_gz52" + lcount + "' ID='DDL_gz52" + lcount + "'  ><option></option><option value='>'>＞</option><option value='>='>≥</option><option value='=='>=</option> <option value='<='>≤</option> <option value='<'>＜</option> </select> <script>document.getElementById('DDL_gz52" + lcount + "').value='" + sdr["gz2"].ToString().Trim() + "';</script></td>  "
                                + "  <td><input  type='text'  style='width:95%' name='TB_sz52" + lcount + "'   id='TB_sz52" + lcount + "' value='" + sdr["sz2"].ToString() + "'/></td>"
                                + "  <td><input  type='text'  style='width:95%' name='TB_dw52" + lcount + "'   id='TB_dw52" + lcount + "' value='" + sdr["dw2"].ToString() + "'/></td>"
                                + "  <td><input  type='text'  style='width:95%' name='TB_df51" + lcount + "'   id='TB_df51" + lcount + "' value='" + sdr["fs"].ToString() + "'/></td>"
                                + "  <td><input type='checkbox' name='ckb'   value='gzB" + lcount + "' />";
                    tr.Cells.Add(td);
                    tab1.Rows.Insert(1, tr);
                    gz1.Value = lcount.ToString();
                }
                else
                {
                    llcount++;
                    tr = new HtmlTableRow();
                    td = new HtmlTableCell();
                    td.InnerHtml = " <input type='hidden' name='gz_B_fj" + llcount + "' id='gz_B_fj" + llcount + "' value='" + sdr["id"].ToString().Trim() + "' />   <input  type='text'  style='width:95%' name='TB_dj61" + llcount + "'   id='TB_dj61" + llcount + "'  value='" + sdr["gz1"].ToString() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='TB_zhs61" + llcount + "'   id='TB_zhs61" + llcount + "' value='" + sdr["fs"].ToString() + "' /></td>"
                        + "  <td><input  type='text'  style='width:95%' name='TB_dw61" + llcount + "'   id='TB_dw61" + llcount + "' value='" + sdr["dw1"].ToString() + "'/></td>"
                        + "  <td><input  type='text'  style='width:95%' name='TB_dyz61" + llcount + "'   id='TB_dyz61" + llcount + "' value='" + sdr["dygs"].ToString() + "'/></td>"
                        + "  <td><input type='checkbox' name='ckb'  value='gz_B_fj" + llcount + "' />";
                    tr.Cells.Add(td);
                    tab6.Rows.Insert(1, tr);
                    gz6.Value = llcount.ToString();
                    CB_sfta.Checked = true;
                }

            }
            else if (DDL_khgz.SelectedItem.Value == "C")
            {
                if (sdr["gzdx"].ToString() == "zt")
                {
                    lcount++;
                    tr = new HtmlTableRow();
                    td = new HtmlTableCell();
                    td.InnerHtml = "<input type='hidden' name='gz_C_zt" + lcount + "' id='gz_C_zt" + lcount + "' value='" + sdr["id"].ToString().Trim() + "' />   <select   style='width:95%' name='DDL_gz21" + lcount + "' ID='DDL_gz21" + lcount + "'  ><option></option><option value='>'>＞</option><option value='>='>≥</option><option value='=='>=</option> <option value='<='>≤</option> <option value='<'>＜</option> </select> <script>document.getElementById('DDL_gz21" + lcount + "').value='" + sdr["gz1"].ToString().Trim() + "';</script></td>  "
                        +"  <td><input  type='text'  style='width:95%' name='TB_sz21"+ lcount +"'   id='TB_sz21"+ lcount +"'  value='"+ sdr["sz1"].ToString() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw21"+ lcount +"'   id='TB_dw21"+ lcount +"' value='"+ sdr["dw1"].ToString() +"' /></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_df21"+ lcount +"'   id='TB_df21"+ lcount +"' value='"+ sdr["fs"].ToString() +"'/></td>"
                        + "  <td><input type='checkbox' name='ckb'  value='gz_C_zt" + lcount + "'/>";
                    tr.Cells.Add(td);
                    tab2.Rows.Insert(2, tr);
                    gz2.Value = lcount.ToString();
                    TB_dygs1.Text=sdr["dygs"].ToString();
                }
                else
                {
                    llcount++;
                    tr = new HtmlTableRow();
                    td = new HtmlTableCell();
                    td.InnerHtml = "<input type='hidden' name='gz_C_ft" + llcount + "' id='gz_C_ft" + llcount + "' value='" + sdr["id"].ToString().Trim() + "' />   <select   style='width:95%' name='DDL_gz41" + llcount + "' ID='DDL_gz41" + llcount + "'  ><option></option><option value='>'>＞</option><option value='>='>≥</option><option value='=='>=</option> <option value='<='>≤</option> <option value='<'>＜</option> </select> <script>document.getElementById('DDL_gz41" + llcount + "').value='" + sdr["gz1"].ToString().Trim() + "';</script></td>  "
                        +"  <td><input  type='text'  style='width:95%' name='TB_sz41"+ llcount +"'   id='TB_sz41"+ llcount +"'  value='"+ sdr["sz1"].ToString() +"'/></td>"
                        +"  <td><input  type='text'  style='width:95%' name='TB_dw41"+ llcount +"'   id='TB_dw41"+ llcount +"' value='"+ sdr["dw1"].ToString() +"' /></td>"
                        + "  <td><input  type='text'  style='width:95%' name='TB_df41" + llcount + "'   id='TB_df41" + llcount + "' value='" + sdr["fs"].ToString() + "'/></td>"
                        + "  <td><input type='checkbox' name='ckb' value='gz_C_ft" + llcount + "'/>";
                    tr.Cells.Add(td);
                    tab4.Rows.Insert(2, tr);
                    gz4.Value = llcount.ToString();
                    TB_dygs2.Text = sdr["dygs"].ToString();
                }

            }
        }



        sdr.Close();

        sqlcon.Close();
    }


    public void EditContent(string EditID)
    {
        UserName = Session["UserName"].ToString();
        string khbm = "";
        string f_khbm = "";
        string sqlstr1 = "";
        string jsgs = TB_jsgs1.Text.Trim();
        for (int i = 0; i < CB_khbm.Items.Count; i++)  //读取多选空的内容 考核部门1
        {
            if (CB_khbm.Items[i].Selected)
            {
                khbm += CB_khbm.Items[i].Value + ",";
            }
        }
        if (khbm != "")
        {
            khbm = khbm.Substring(0, khbm.Length - 1).ToString();
        }

        for (int i = 0; i < CB_f_khbm.Items.Count; i++)  //读取多选空的内容 考核部门2
        {
            if (CB_f_khbm.Items[i].Selected)
            {
                f_khbm += CB_f_khbm.Items[i].Value + ",";
            }
        }
        if (f_khbm != "")
        {
            f_khbm = f_khbm.Substring(0, f_khbm.Length - 1).ToString();
        }


        string maxid = "";
        string sqlstr = " update  js_jxkh_zbsx set zbmc='" + TB_zbmc.Text.Trim() + "',zbjb='" + DDL_zbjb.SelectedValue.Trim() + "',jbmc='" + DDL_zbjb.SelectedItem.Text.Trim() + "',zbsx='" + DDL_zbsx.SelectedValue.Trim() + "',khbm ='" + khbm + "',  "
                      +" f_khbm='" + f_khbm + "',zbxgll='" + TB_zbxgll.Text.Trim() + "',gzlx='" + DDL_khgz.SelectedItem.Text.Trim() + "',gzbh='" + DDL_khgz.SelectedValue.Trim() + "',gs='" + TB_jsgs1.Text.Trim() + "' where id ="+ EditID + "";
        sqlcon.Open();   //更新主要信息
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();


        if (TB_xmmc.Text.Trim() != "")
        {
            AJAX_JSON.bhxxJosn bhxx = new AJAX_JSON.bhxxJosn();
            bhxx.Bhxx_max = HF_bhxx_max.Value;
            GetContent getc= new GetContent();
            TB_xxbh.Text =getc.Getjxkh_bhxx(bhxx);
            sqlstr = " INSERT INTO dbo.js_jxkh_xmsx (fid,sjmc,mrz,dw,lrbm,xxbh)   select " + EditID + ""
                       + ", '" + TB_xmmc.Text.Trim() + "'"
                       + ", '" + TB_mrz.Text.Trim() + "'"
                       + ", '" + TB_dw.Text.Trim() + "'"
                       + ", '" + DDL_lrbm.Text.Trim() + "'"
                       + ", '" + TB_xxbh.Text.Trim() + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
        }

        for (int i = 1; i <= 15; i++)
        {
            if (Request["TB_xmmc" + i] != null)
            {
                if (Request["xmsx" + i] == null)
                {
                    sqlstr = "INSERT INTO dbo.js_jxkh_xmsx (fid,sjmc,mrz,dw,lrbm,xxbh)   select " + EditID + ""
                           + ", '" + Request["TB_xmmc" + i].ToString().Trim() + "'"
                           + ", '" + Request["TB_mrz" + i].ToString().Trim() + "'"
                           + ", '" + Request["TB_dw" + i].ToString().Trim() + "'"
                           + ", '" + Request["DDL_lrbm" + i] + "'"
                           + ", '" + Request["TB_xxbh" + i].ToString().Trim() + "'";
                    Cmd = new SqlCommand(sqlstr, sqlcon);
                    Cmd.ExecuteNonQuery();
                }
                else
                {
                    sqlstr = "update js_jxkh_xmsx set  "
                           + "sjmc= '" + Request["TB_xmmc" + i].ToString().Trim() + "'"
                           + ",mrz=  '" + Request["TB_mrz" + i].ToString().Trim() + "'"
                           + ",dw=  '" + Request["TB_dw" + i].ToString().Trim() + "'"
                           + ",lrbm=  '" + Request["DDL_lrbm" + i] + "'"
                           + ",xxbh=  '" + Request["TB_xxbh" + i].ToString().Trim() + "'"
                           + "  where id =" + Request["xmsx" + i].ToString().Trim() + "";
                    Cmd = new SqlCommand(sqlstr, sqlcon);
                    Cmd.ExecuteNonQuery(); 
                }
            }

        }

        if (DDL_khgz.SelectedItem.Value == "A")
        {
            sqlstr = "update js_jxkh_gz set fs=" + TB_khfd.Text.Trim() + "  where fid =" + EditID + " and gz1='考核幅度'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlstr = "update js_jxkh_gz set fs=" + TB_zgf.Text.Trim() + "  where fid =" + EditID + " and gz1='最高分'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlstr = "update js_jxkh_gz set fs=" + TB_zdf.Text.Trim() + "  where fid =" + EditID + " and gz1='最低分'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlstr = "update js_jxkh_gz set fs=" + TB_zhgc.Text.Trim() + "  where fid =" + EditID + " and gz1='发货金额高出'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlstr = "update js_jxkh_gz set fs=" + TB_khfxy.Text.Trim() + "  where fid =" + EditID + " and gz1='考核分小于'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlstr = "update js_jxkh_gz set fs=" + TB_bz.Text.Trim() + "  where fid =" + EditID + " and gz1='补足'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();
        }
        else if (DDL_khgz.SelectedItem.Value == "B")
        {
            string sz1 = "0";
            string sz2 = "0";
            

            for (int i = 1; i <= 15; i++)
            {
                if (Request["TB_df51" + i] != null)
                {
                    if (Request["gzB" + i] == null)
                    {
                        sz1 = "0";
                        sz2 = "0";
                        if (Request["TB_sz51" + i].ToString().Trim() != "")
                        {
                            sz1 = Request["TB_sz51" + i].ToString().Trim();
                        }
                        if (Request["TB_sz52" + i].ToString().Trim() != "")
                        {
                            sz2 = Request["TB_sz52" + i].ToString().Trim();
                        }

                        sqlstr1 = " insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,gz2,sz1,sz2,dw1,dw2,gx,fs) select " + EditID + ""
                               + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                               + ", '" + DDL_khgz.Text.Trim() + "'"
                               + ", 'zt'"
                               + ", '" + Request["DDL_gz51" + i] + "'"
                               + ", '" + Request["DDL_gz52" + i] + "'"
                               + ", " + sz1 + ""
                               + ", " + sz2 + ""
                               + ", '" + Request["TB_dw51" + i].ToString().Trim() + "'"
                               + ", '" + Request["TB_dw52" + i].ToString().Trim() + "'"
                               + ", '" + Request["DDL_gx51" + i] + "'"
                               + ", " + Request["TB_df51" + i].ToString().Trim() + "";
                        Cmd = new SqlCommand(sqlstr1, sqlcon);
                        Cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        sz1 = "0";
                        sz2 = "0";
                        if (Request["TB_sz51" + i].ToString() != "")
                        {
                            sz1 = Request["TB_sz51" + i].ToString();
                        }
                        if (Request["TB_sz52" + i].ToString() != "")
                        {
                            sz2 = Request["TB_sz52" + i].ToString();
                        }

                        sqlstr1 = "update js_jxkh_gz  set "
                               + " gzmc= '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                               + ",gzlx='" + DDL_khgz.Text.Trim() + "'"
                               + ",gzdx= 'zt'"
                               + ",gz1= '" + Request["DDL_gz51" + i] + "'"
                               + ",gz2='" + Request["DDL_gz52" + i] + "'"
                               + ",sz1= " + sz1 + ""
                               + ",sz2= " + sz2 + ""
                               + ",dw1='" + Request["TB_dw51" + i].ToString().Trim() + "'"
                               + ",dw2= '" + Request["TB_dw52" + i].ToString().Trim() + "'"
                               + ",gx='" + Request["DDL_gx51" + i] + "'"
                               + ",fs=" + Request["TB_df51" + i].ToString().Trim() + ""
                               + " where id=" + Request["gzB" + i].ToString().Trim() + "";
                        Cmd = new SqlCommand(sqlstr1, sqlcon);
                        Cmd.ExecuteNonQuery();
                    }
                }
            }
            if (TB_df51.Text.Trim() != "")
            {
                sz1 = "0";
                sz2 = "0";
                if (TB_sz51.Text.Trim() != "")
                {
                    sz1 = TB_sz51.Text.Trim();
                }
                if (TB_sz52.Text.Trim() != "")
                {
                    sz2 = TB_sz52.Text.Trim();
                }

                sqlstr1 = " insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,gz2,sz1,sz2,dw1,dw2,gx,fs) select " + EditID + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '" + DDL_gz51.Text.Trim() + "'"
                            + ", '" + DDL_gz52.Text.Trim() + "'"
                            + ", " + sz1 + ""
                            + ", " + sz2 + ""
                            + ", '" + TB_dw51.Text.Trim() + "'"
                            + ", '" + TB_dw52.Text.Trim() + "'"
                            + ", '" + DDL_gx51.Text.Trim() + "'"
                            + ", " + TB_df51.Text.Trim() + "";
                Cmd = new SqlCommand(sqlstr1, sqlcon);
                Cmd.ExecuteNonQuery();
            }


            if (CB_sfta.Checked)
            {
                

                for (int i = 1; i <= 15; i++)
                {
                    if (Request["TB_zhs61" + i] != null)
                    {
                        if (Request["gz_B_fj" + i] == null)
                        {
                            sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,fs,dw1,dygs)" + "select " + EditID + ""
                                   + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                                   + ", '" + DDL_khgz.Text.Trim() + "'"
                                   + ", '附加规则'"
                                   + ", '" + Request["TB_dj61" + i].ToString().Trim() + "'"
                                   + ", '" + Request["TB_zhs61" + i].ToString().Trim() + "'"
                                   + ", '" + Request["TB_dw61" + i].ToString().Trim() + "'"
                                   + ", '" + Request["TB_dyz61" + i].ToString().Trim() + "'";
                            Cmd = new SqlCommand(sqlstr1, sqlcon);
                            Cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            sqlstr1 = "update js_jxkh_gz  set dygs='" + Request["TB_dyz61" + i].ToString().Trim() + "', gzmc ='" + DDL_khgz.SelectedItem.Text.Trim() + "',gzlx ='" + DDL_khgz.Text.Trim() + "' ,gzdx ='附加规则',gz1= '" + Request["TB_dj61" + i].ToString().Trim() + "',fs =" + Request["TB_zhs61" + i].ToString().Trim() + ",dw1='" + Request["TB_dw61" + i].ToString() + "'  where id =" + Request["gz_B_fj" + i].ToString().Trim() + "";
                            Cmd = new SqlCommand(sqlstr1, sqlcon);
                            Cmd.ExecuteNonQuery();
                        }
                    }
                   

                }
                if (TB_zhs61.Text.Trim() != "")
                {
                    sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,fs,dw1,dygs)" + "select " + EditID + ""
                                + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                                + ", '" + DDL_khgz.Text.Trim() + "'"
                                + ", '附加规则'"
                                + ", '" + TB_dj61.Text.Trim() + "'"
                                + ", " + TB_zhs61.Text.Trim() + ""
                                + ", '" + TB_dw61.Text.Trim() + "'"
                                + ", '" + TB_dyz61.Text.Trim() + "'";
                    Cmd = new SqlCommand(sqlstr1, sqlcon);
                    Cmd.ExecuteNonQuery();
                }
            }
        }
        else if (DDL_khgz.SelectedItem.Value == "C")
        {

            
            for (int i = 1; i <= 15; i++)
            {
                if (Request["TB_df21" + i] != null)
                {

                    if (Request["gz_C_zt" + i] == null)
                    {
                        sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,sz1,dw1,fs,dygs)  select " + EditID + ""
                           + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                           + ", '" + DDL_khgz.Text.Trim() + "'"
                           + ", 'zt'"
                           + ", '" + Request["DDL_gz21" + i]+ "'"
                           + ",  " + Request["TB_sz21" + i].ToString().Trim() + ""
                           + ", '" + Request["TB_dw21" + i].ToString().Trim() + "'"
                           + ",  " + Request["TB_df21" + i].ToString().Trim() + ""
                           + ", '" + TB_dygs1.Text.Trim() + "'";
                        Cmd = new SqlCommand(sqlstr1, sqlcon);
                        Cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        sqlstr1 = "update js_jxkh_gz set gzmc='" + DDL_khgz.SelectedItem.Text.Trim() + "',gzlx='" + DDL_khgz.Text.Trim() + "',gzdx= 'zt',gz1= '" + Request["DDL_gz21" + i].ToString() + "',sz1=" + Request["TB_sz21" + i].ToString().Trim() + ",dw1= '" + Request["TB_dw21" + i].ToString().Trim() + "',fs=" + Request["TB_df21" + i].ToString().Trim() + ",dygs ='" + TB_dygs1.Text.Trim() + "' where id = " + Request["gz_C_zt" + i].ToString().Trim() + "";
                        Cmd = new SqlCommand(sqlstr1, sqlcon);
                        Cmd.ExecuteNonQuery();
                    }
                }
            }
            if (TB_df21.Text.Trim() != "")
            {
                sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,sz1,dw1,fs,dygs)   select " + EditID + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'zt'"
                            + ", '" + DDL_gz21.Text.Trim() + "'"
                            + ", " + TB_sz21.Text.Trim() + ""
                            + ", '" + TB_dw21.Text.Trim() + "'"
                            + ", " + TB_df21.Text.Trim() + ""
                            + ", '" + TB_dygs1.Text.Trim() + "'";
                Cmd = new SqlCommand(sqlstr1, sqlcon);
                Cmd.ExecuteNonQuery();
            }



            for (int i = 1; i <= 15; i++)
            {
                if (Request["TB_df41" + i] != null)
                {
                    if (Request["gz_C_ft" + i]==null)
                    {
                        sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,sz1,dw1,fs,dygs)    select " + EditID + ""
                           + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                           + ", '" + DDL_khgz.Text.Trim() + "'"
                           + ", 'ft'"
                           + ", '" + Request["DDL_gz41" + i] + "'"
                           + ",  " + Request["TB_sz41" + i].ToString().Trim() + ""
                           + ", '" + Request["TB_dw41" + i].ToString().Trim() + "'"
                           + ",  " + Request["TB_df41" + i].ToString().Trim() + ""
                           + ", '" + TB_dygs2.Text.Trim() + "'";
                        Cmd = new SqlCommand(sqlstr1, sqlcon);
                        Cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        sqlstr1 = "update  js_jxkh_gz  set gzmc='" + DDL_khgz.SelectedItem.Text.Trim() + "',gzlx='" + DDL_khgz.Text.Trim() + "',gzdx= 'ft',gz1='" + Request["DDL_gz41" + i].ToString().Trim() + "',sz1=" + Request["TB_sz41" + i].ToString().Trim() + ",dw1= '" + Request["TB_dw41" + i].ToString().Trim() + "',fs=" + Request["TB_df41" + i].ToString().Trim() + ",dygs ='" + TB_dygs2.Text.Trim() + "' where id=" + Request["gz_C_ft" + i].ToString().Trim() + "";
                        Cmd = new SqlCommand(sqlstr1, sqlcon);
                        Cmd.ExecuteNonQuery();
                    }
                    
                }
            }

            if (TB_df41.Text.Trim() != "")
            {
                sqlstr1 = "insert into js_jxkh_gz (fid,gzmc,gzlx,gzdx,gz1,sz1,dw1,fs,dygs)   select " + EditID + ""
                            + ", '" + DDL_khgz.SelectedItem.Text.Trim() + "'"
                            + ", '" + DDL_khgz.Text.Trim() + "'"
                            + ", 'ft'"
                            + ", '" + DDL_gz41.Text.Trim() + "'"
                            + ", " + TB_sz41.Text.Trim() + ""
                            + ", '" + TB_dw41.Text.Trim() + "'"
                            + ", " + TB_df41.Text.Trim() + ""
                            + ", '" + TB_dygs2.Text.Trim() + "'";
                Cmd = new SqlCommand(sqlstr1, sqlcon);
                Cmd.ExecuteNonQuery();
            }

          
        }


    }

    protected void B_save_Click(object sender, EventArgs e)
    {
        if (HF_id.Value == "ADD")
        {
            AddDate();
        }
        else
        {
            EditContent(HF_id.Value);
        }

        Response.Write("<script>alert('提交成功!');window.location.href='jxkh_bmlr_lb.aspx'; </script>");
    }







}
