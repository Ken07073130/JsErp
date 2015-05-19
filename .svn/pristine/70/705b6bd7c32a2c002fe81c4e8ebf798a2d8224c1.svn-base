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

public partial class sclr_jpscrb : System.Web.UI.Page
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
            HF_id.Value ="";
            if (id != null && id != "")         //如果ID不为空则是编辑内容或查看内容
            {
                HF_id.Value = id;
                Editebind(id);

            }
            else
            {
                TB_rq.Text = Request.QueryString["dqrq"]; 
                Bind();
            }
            string gxmc = Request.QueryString["gxmc"];
            if (gxmc!= null )
            {
                DDL_gxmc.Items.FindByText(gxmc).Selected = true;
            }
        }
       
    }
    protected void B_BLJL_Click(object sender, EventArgs e)
    {

    }
    protected void Bind()
    {
        if (GroupName.IndexOf("超级用户") == -1 )
        {
            DDL_gxmc.Items.Clear();
            if (GroupName.IndexOf("手工日报录入-正极搅拌") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("正极搅拌", "25"));
            }
            if (GroupName.IndexOf("手工日报录入-负极涂布") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("负极搅拌", "10"));
            }
            if (GroupName.IndexOf("手工日报录入-负极搅拌") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("正极涂布", "26"));
            }
            if (GroupName.IndexOf("手工日报录入-负极涂布") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem( "负极涂布","11"));
            }
            if (GroupName.IndexOf("手工日报录入-正极辊压分切") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("正极分切", "27"));
            }
            if (GroupName.IndexOf("手工日报录入-负极辊压分切") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("负极分切","12"));
            }
            if (GroupName.IndexOf("手工日报录入-正极分小片") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem( "正极分小片","28"));
            }
            if (GroupName.IndexOf("手工日报录入-负极分小片") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem( "负极分小片","13"));
            }
            if (GroupName.IndexOf("手工日报录入-正极铆接") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("正极铆接","30"));
            }
            if (GroupName.IndexOf("手工日报录入-负极铆接") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("负极铆接","15"));
            }
            if (GroupName.IndexOf("手工日报录入-卷绕") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("巻绕", "40"));
            }
            if (GroupName.IndexOf("手工日报录入-封装") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("封装","50"));
            }
            if (GroupName.IndexOf("手工日报录入-注液") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("注液","55"));
            }
            if (GroupName.IndexOf("手工日报录入-化成") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("化成","60"));
            }
            if (GroupName.IndexOf("手工日报录入-二封") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("二封","65"));
            }
            if (GroupName.IndexOf("手工日报录入-分选") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("分选","70"));
            }
            if (GroupName.IndexOf("手工日报录入-包装") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("包装","75"));
            }
            if (GroupName.IndexOf("手工日报录入-PACK") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("PACK","80"));
            }
            if (GroupName.IndexOf("手工日报录入-出货") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("出货","85"));
            }
        }
        

    }
    protected void AddDate()   //添加记录
    {
        UserName = Session["UserName"].ToString();
        string maxid = "";
        string sqlstr1 = "";
        string sqlstr = " INSERT INTO dbo.js_sgrb(scrq,xh,pc,gc,rl,gxmc,gxbh,fqts,cy1,cy2,qrjc1,qrjc2,qrjc3,qrjc4,drzr1,drzr2,drzr3,drzr4,drsc1,drsc2,drsc3,drzc1,drzc2,drzc3,drzc4,drzc5,drzc6,drjc1,drjc2,drjc3,drjc4,bfsl1,bfsl2,lrrq,lrr,packxh,bz,sclx,zj,hgp,fp,dzp,bmlq,dclp) values"
                        + " ( '" + TB_rq.Text.Trim() + "','" + TB_xh.Text.Trim() + "','" + TB_pc.Text.Trim() + "','" + DDL_gc.Text.Trim() + "','" + TB_rl.Text.Trim() + "', '" + DDL_gxmc.SelectedItem.Text.Trim() + "','" + DDL_gxmc.SelectedValue.Trim() + "','" + TB_fqts.Text.Trim() + "',  "
                        + " " + TB_cy1.Text.Trim() + "," + TB_cy2.Text.Trim() + "," + TB_qrjc1.Text.Trim() + " ," + TB_qrjc2.Text.Trim() + " ," + TB_qrjc3.Text.Trim() + " ," + TB_qrjc4.Text.Trim() + " ," + TB_drzr1.Text.Trim() + " ," + TB_drzr2.Text.Trim() + ","
                        + " " + TB_drzr3.Text.Trim() + "," + TB_drzr4.Text.Trim() + "," + TB_drsc1.Text.Trim() + " ," + TB_drsc2.Text.Trim() + "," + TB_drsc3.Text.Trim() + " ," + TB_drzc1.Text.Trim() + " ," + TB_drzc2.Text.Trim() + " ,"
                        + " " + TB_drzc3.Text.Trim() + " ," + TB_drzc4.Text.Trim() + " ," + TB_drzc5.Text.Trim() + " ," + TB_drzc6.Text.Trim() + " ," + TB_drjc1.Text.Trim() + " ," + TB_drjc2.Text.Trim() + " ," + TB_drjc3.Text.Trim() + "," + TB_drjc4.Text.Trim() + ","
                        + " " + TB_bfsl1.Text.Trim() + "," + TB_bfsl2.Text.Trim() + ",getdate(),'" + UserName + "','" + TB_PACK.Text.Trim() + "','" + TB_bz.Text.Trim() + "','" + DDL_sclx.SelectedValue.Trim() + "',"+HF_ZJ.Value +","+ HF_HGP.Value +","+ HF_FP.Value +","+ HF_DZP.Value +","+ HF_BMLQ.Value +","+ HF_DCLP.Value +" )";
        sqlcon.Open();   //添加主要信息
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();

        sqlstr = "select max(id) maxid from js_sgrb";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            maxid = sdr["maxid"].ToString();
        }
        sdr.Close();

        sqlstr = "INSERT INTO dbo.js_sgrb_bljl ( fid, bldm, blmc,bllb, blsl, blbz ) ";    //添加不良信息
        sqlstr1 = "INSERT INTO dbo.js_sgrb_wlxh ( fid, wlbh, wlmc, wlpc, gys, gg, sl, dw,sx,qmsl ) ";  //添加物料消耗信息

        if (TB_blmc.Text.Trim() != "" && TB_blsl.Text.Trim()!="")
        {
            sqlstr = sqlstr + "select " + maxid + ""
                       + ", '" + TB_bldm.Text.Trim() + "'"
                       + ", '" + TB_blmc.Text.Trim() + "'"
                       + ", '" + TB_bllb.Text.Trim() + "'"
                       + ", "  + TB_blsl.Text.Trim() + ""
                       + ", '" + TB_blbz.Text.Trim() + "'"
                       + " union all ";
        }
        if (TB_wlbh.Text.Trim() != "" && TB_sl.Text.Trim()!="")
        {
            sqlstr1 = sqlstr1 + "select " + maxid   + ""
                      + ", '" + TB_wlbh.Text.Trim() + "'"
                      + ", '" + TB_wlmc.Text.Trim() + "'"
                      + ", '" + TB_wlpc.Text.Trim() + "'"
                      + ", '" + TB_gys.Text.Trim()  + "'"
                      + ", '" + TB_gg.Text.Trim()   + "'"
                      + ",  " + TB_sl.Text.Trim()   + ""
                      + ", '" + TB_dw.Text.Trim()   + "'"
                      + ", '" + DDL_sx.SelectedValue.ToString() + "'"
                      + ", " + TB_qmsl.Text.Trim() + ""
                      + " union all ";
        }

        for (int i = 1; i <= 25; i++)
        {
            if (Request["TB_blmc" + i] != null)
            {
                sqlstr = sqlstr + "select " + maxid + ""
                       + ", '" + Request["TB_bldm" + i].ToString() + "'"
                       + ", '" + Request["TB_blmc" + i].ToString() + "'"
                       + ", '" + Request["TB_bllb" + i].ToString() + "'"
                       + ", "  + Request["TB_blsl" + i].ToString() + ""
                       + ", '" + Request["TB_blbz" + i].ToString() + "'"
                       + " union all ";
            }
            if (Request["TB_wlbh" + i] != null)
            {
                sqlstr1 = sqlstr1 + "select " + maxid + ""
                       + ", '" + Request["TB_wlbh" + i].ToString() + "'"
                       + ", '" + Request["TB_wlmc" + i].ToString() + "'"
                       + ", '" + Request["TB_wlpc" + i].ToString() + "'"
                       + ", '" + Request["TB_gys" + i].ToString() + "'"
                       + ", '" + Request["TB_gg" + i].ToString() + "'"
                       + ",  " + Request["TB_sl" + i].ToString() + ""
                       + ", '" + Request["TB_dw" + i].ToString() + "'"
                       + ", '" + Request["DDL_sx" + i] + "'"
                       + ", " + Request["TB_qmsl" + i] + ""
                       + " union all ";
            }
        }

        if (sqlstr.Trim().Length >= 70)
        {
            sqlstr = sqlstr.Substring(0, sqlstr.Length - 10);
            
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();

        }
        if (sqlstr1.Trim().Length >= 80)
        {
            sqlstr1 = sqlstr1.Substring(0, sqlstr1.Length - 10);
            Cmd = new SqlCommand(sqlstr1, sqlcon);
            Cmd.ExecuteNonQuery();
        }
        sqlcon.Close();

    }

    public void Editebind(string id)
    {
        string Show = "";
        sqlcon.Open();
        String sqlstr = "SELECT *,CONVERT(varchar(10) , scrq, 120 ) as rq   FROM js_sgrb where id=" + id;   //主表的数据取出
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {

            TB_rq.Text = sdr["rq"].ToString().Trim(); 
            DDL_gc.Items.FindByText(sdr["gc"].ToString().Trim()).Selected = true;
            DDL_gxmc.Items.FindByText(sdr["gxmc"].ToString().Trim()).Selected = true;
            if (sdr["sclx"].ToString().Trim() != null && sdr["sclx"].ToString().Trim() != "")
            {
                DDL_sclx.Items.FindByText(sdr["sclx"].ToString().Trim()).Selected = true;
            }
            DDL_gxmc.Enabled = false;
            TB_xh.Text = sdr["xh"].ToString().Trim();
            TB_pc.Text = sdr["pc"].ToString().Trim();
            TB_rl.Text = sdr["rl"].ToString().Trim();
            TB_fqts.Text = sdr["fqts"].ToString().Trim();
            TB_bfsl1.Text = sdr["bfsl1"].ToString().Trim();
            TB_bfsl2.Text = sdr["bfsl2"].ToString().Trim();
            TB_cy1.Text = sdr["cy1"].ToString().Trim();
            TB_cy2.Text = sdr["cy2"].ToString().Trim();
            TB_qrjc1.Text = sdr["qrjc1"].ToString().Trim();
            TB_qrjc2.Text = sdr["qrjc2"].ToString().Trim();
            TB_qrjc3.Text = sdr["qrjc3"].ToString().Trim();
            TB_qrjc4.Text = sdr["qrjc4"].ToString().Trim();
            TB_drzr1.Text = sdr["drzr1"].ToString().Trim();
            TB_drzr2.Text = sdr["drzr2"].ToString().Trim();
            TB_drzr3.Text = sdr["drzr3"].ToString().Trim();
            TB_drzr4.Text = sdr["drzr4"].ToString().Trim();
            TB_drsc1.Text = sdr["drsc1"].ToString().Trim();
            TB_drsc2.Text = sdr["drsc2"].ToString().Trim();
            TB_drsc3.Text = sdr["drsc3"].ToString().Trim();
            TB_drzc1.Text = sdr["drzc1"].ToString().Trim();
            TB_drzc2.Text = sdr["drzc2"].ToString().Trim();
            TB_drzc3.Text = sdr["drzc3"].ToString().Trim();
            TB_drzc4.Text = sdr["drzc4"].ToString().Trim();
            TB_drzc5.Text = sdr["drzc5"].ToString().Trim();
            TB_drzc6.Text = sdr["drzc6"].ToString().Trim();
            TB_drjc1.Text = sdr["drjc1"].ToString().Trim();
            TB_drjc2.Text = sdr["drjc2"].ToString().Trim();
            TB_drjc3.Text = sdr["drjc3"].ToString().Trim();
            TB_drjc4.Text = sdr["drjc4"].ToString().Trim();

            HF_ZJ.Value = sdr["ZJ"].ToString().Trim();
            HF_HGP.Value = sdr["HGP"].ToString().Trim();
            HF_FP.Value= sdr["FP"].ToString().Trim();
            HF_BMLQ.Value= sdr["BMLQ"].ToString().Trim();
            HF_DZP.Value= sdr["DZP"].ToString().Trim();
            HF_DCLP.Value = sdr["DCLP"].ToString().Trim();

            if (GroupName.IndexOf("手工日报录入-" + sdr["gxmc"].ToString()) != -1 && GroupName.IndexOf("超级用户") == -1  && sdr["State"].ToString().Trim() == "审核")
            { 
                //禁止主表中的内容是编辑
                TB_rq.Enabled=false;
                DDL_gc.Enabled=false;
                DDL_gxmc.Enabled = false;
                TB_xh.Enabled=false;
                TB_pc.Enabled=false;
                TB_rl.Enabled=false;
                TB_fqts.Enabled=false;
                TB_bfsl1.Enabled=false;
                TB_bfsl2.Enabled=false;
                TB_cy1.Enabled=false;
                TB_cy2.Enabled=false;
                TB_qrjc1.Enabled = false;
                TB_qrjc2.Enabled = false;
                TB_qrjc3.Enabled = false;
                TB_qrjc4.Enabled = false;
                TB_drzr1.Enabled = false;
                TB_drzr2.Enabled = false;
                TB_drzr3.Enabled = false;
                TB_drzr4.Enabled = false;
                TB_drsc1.Enabled = false;
                TB_drsc2.Enabled = false;
                TB_drsc3.Enabled = false;
                TB_drzc1.Enabled = false;
                TB_drzc2.Enabled = false;
                TB_drzc3.Enabled = false;
                TB_drzc4.Enabled = false;
                TB_drzc5.Enabled = false;
                TB_drzc6.Enabled = false;
                TB_drjc1.Enabled = false;
                TB_drjc2.Enabled = false;
                TB_drjc3.Enabled = false;
                TB_drjc4.Enabled = false;
                B_save.Enabled = false;
                TB_bz.Enabled = false;
                DDL_sx.Enabled = false;
                //禁止两张子表中的内容编辑
                Show = "disabled='false'";
                TB_bldm.Enabled = false;
                TB_blmc.Enabled = false;
                TB_blsl.Enabled = false;
                TB_blbz.Enabled = false;
                bl_delete.Enabled = false;
                bl_add.Enabled = false;
                TB_wlbh.Enabled = false;
                TB_wlmc.Enabled = false;
                TB_wlpc.Enabled = false;
                TB_gys.Enabled = false;
                TB_gg.Enabled = false;
                TB_sl.Enabled = false;
                TB_dw.Enabled = false;
                wl_add.Enabled = false;
                wl_delete.Enabled = false;
                
            }
            
        }
        sdr.Close();
        HtmlTableRow tr;
        HtmlTableCell td;
        int blcount=0;
        sqlstr = "SELECT * FROM js_sgrb_bljl where fid=" + id;   //报废品的数据取出
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            blcount ++; 
            tr = new HtmlTableRow();
            td = new HtmlTableCell();

            td.InnerHtml = " <input type='hidden' name='bl" + blcount.ToString() + "' id='bl" + blcount.ToString() + "' value='" + sdr["id"].ToString().Trim() + "' /> "
                        + "  <input  type='text'  " + Show + "  style='width:95%' name='TB_bldm" + blcount.ToString() + "'   id='TB_bldm" + blcount.ToString() + "'  value='" + sdr["bldm"].ToString().Trim() + "'/></td>"
                        + "  <td><input  type='text'  " + Show + "  style='width:95%' name='TB_bllb" + blcount.ToString() + "'   id='TB_bllb" + blcount.ToString() + "'  value='" + sdr["bllb"].ToString().Trim() + "'/></td>"
                        + "  <td><input  type='text'  "+ Show +"  style='width:95%' name='TB_blmc" + blcount.ToString() + "'   id='TB_blmc" + blcount.ToString() + "' value='" + sdr["blmc"].ToString().Trim() + "' /></td>"
                        + "  <td><input  type='text' " + Show + " onchange='bfjs();' style='width:95%' name='TB_blsl" + blcount.ToString() + "'   id='TB_blsl" + blcount.ToString() + "' value='" + sdr["blsl"].ToString().Trim() + "'/></td>"
                        + "  <td><input  type='text' " + Show + "  style='width:95%' name='TB_blbz" + blcount.ToString() + "'   id='TB_blbz" + blcount.ToString() + "' value='" + sdr["blbz"].ToString().Trim() + "'/></td> "
                        + "  <td><input  type='checkbox' " + Show + "name='ckb' value='bl" + blcount.ToString() + "'  />"; 
            tr.Cells.Add(td);
            tab.Rows.Insert(1,tr);
        }
        bl.Value = blcount.ToString();
        sdr.Close();

        int wlcount = 0;
        sqlstr = "SELECT *  FROM js_sgrb_wlxh where fid=" + id;   //消耗物料的数据取出
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            wlcount++;
            tr = new HtmlTableRow();
            td = new HtmlTableCell();
            td.InnerHtml = " <input type='hidden' name='wl" + wlcount.ToString() + "' id='wl" + wlcount.ToString() + "' value='" + sdr["id"].ToString().Trim() + "' /> "
                        + "  <select " + Show + "  style='width:95%' name='DDL_sx" + wlcount + "' ID='DDL_sx" + wlcount + "'  ><option></option><option value='返料'>返料</option><option value='正极报废'>正极报废</option> <option value='负极报废'>负极报废</option><option value='材料报废'>材料报废</option><option value='混批转入'>混批转入</option> </select>   <script>document.getElementById('DDL_sx" + wlcount + "').value='" + sdr["sx"].ToString().Trim() + "';</script></td> "
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_wlbh" + wlcount + "'   id='TB_wlbh" + wlcount + "' value='" + sdr["wlbh"].ToString().Trim() + "'/></td> "
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_wlmc" + wlcount + "'   id='TB_wlmc" + wlcount + "' value='" + sdr["wlmc"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_wlpc" + wlcount + "'   id='TB_wlpc" + wlcount + "' value='" + sdr["wlpc"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_gys" + wlcount + "'  id='TB_gys" + wlcount + "' value='" + sdr["gys"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_gg" + wlcount + "'  id='TB_gg" + wlcount + "' value='" + sdr["gg"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_qmsl" + wlcount + "'  id='TB_qmsl" + wlcount + "' value='" + sdr["qmsl"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_sl" + wlcount + "'  id='TB_sl" + wlcount + "' value='" + sdr["sl"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_dw" + wlcount + "'  id='TB_dw" + wlcount + "' value='" + sdr["dw"].ToString().Trim() + "'/></td>"
                        + " <td><input type='checkbox'" + Show + " name='ckb' value='wl" + wlcount + "'  />"; 
            tr.Cells.Add(td);
            tab1.Rows.Insert(1, tr);
        }
        wl.Value = wlcount.ToString();
        sdr.Close();
        sqlcon.Close();

    }


    public void EditContent(string EditID)
    {
        UserName = Session["UserName"].ToString();
        string sqlstr1 = "";
        string sqlstr = " UPDATE dbo.js_sgrb SET scrq='" + TB_rq.Text.Trim() + "',xh='" + TB_xh.Text.Trim() + "',pc='" + TB_pc.Text.Trim() + "',gc='" + DDL_gc.Text.Trim() + "',rl='" + TB_rl.Text.Trim() + "',gxmc='" + DDL_gxmc.SelectedItem.Text.Trim() + "',  "
                        + " gxbh='" + DDL_gxmc.SelectedValue.Trim() + "',fqts='" + TB_fqts.Text.Trim() + "',cy1=" + TB_cy1.Text.Trim() + ",cy2=" + TB_cy2.Text.Trim() + ",qrjc1=" + TB_qrjc1.Text.Trim() + ",qrjc2=" + TB_qrjc2.Text.Trim() + ",qrjc3=" + TB_qrjc3.Text.Trim() + " ,"
                        + " qrjc4=" + TB_qrjc4.Text.Trim() + ",drzr1=" + TB_drzr1.Text.Trim() + " ,drzr2=" + TB_drzr2.Text.Trim() + ",drzr3=" + TB_drzr3.Text.Trim() + ",drzr4=" + TB_drzr4.Text.Trim() + ",drsc1=" + TB_drsc1.Text.Trim() + ",drsc2=" + TB_drsc2.Text.Trim() + ", "
                        + " drsc3=" + TB_drsc3.Text.Trim() + ",drzc1=" + TB_drzc1.Text.Trim() + ",drzc2 =" + TB_drzc2.Text.Trim() + ",drzc3=" + TB_drzc3.Text.Trim() + " ,drzc4=" + TB_drzc4.Text.Trim() + ",drzc5=" + TB_drzc5.Text.Trim() + " ,drzc6=" + TB_drzc6.Text.Trim() + ","
                        + " drjc1=" + TB_drjc1.Text.Trim() + ",drjc2=" + TB_drjc2.Text.Trim() + ",drjc3=" + TB_drjc3.Text.Trim() + ",drjc4=" + TB_drjc4.Text.Trim() + ",bfsl1= " + TB_bfsl1.Text.Trim() + ",bfsl2=" + TB_bfsl2.Text.Trim() + ",lrrq=getdate(),lrr='" + UserName + "',"
                        + " bz='" + TB_bz.Text.Trim() + "' ,sclx='" + DDL_sclx.SelectedValue.Trim() + "',zj="+ HF_ZJ.Value +",hgp="+ HF_HGP.Value +",fp="+ HF_FP.Value +",dzp="+ HF_DZP.Value +",bmlq="+ HF_BMLQ.Value +",dclp="+ HF_DCLP.Value +"  "
                        + " WHERE ID =  "+ EditID ;
        sqlcon.Open();   //添加主要信息
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();

        


        if (TB_blmc.Text.Trim() != "" && TB_blsl.Text.Trim() != "")
        {
            sqlstr = "INSERT INTO dbo.js_sgrb_bljl ( fid, bldm, blmc,bllb, blsl, blbz ) ";    //添加不良信息
            sqlstr = sqlstr + "select " + HF_id.Value + ""
                       + ", '" + TB_bldm.Text.Trim() + "'"
                       + ", '" + TB_blmc.Text.Trim() + "'"
                       + ", '" + TB_bllb.Text.Trim() + "'"
                       + ", " + TB_blsl.Text.Trim() + ""
                       + ", '" + TB_blbz.Text.Trim() + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();

        }

        if (TB_wlbh.Text.Trim() != "" && TB_sl.Text.Trim() != "")
        {
            sqlstr = "INSERT INTO dbo.js_sgrb_wlxh ( fid, wlbh, wlmc, wlpc, gys, gg, sl, dw,sx,qmsl ) ";  //添加物料消耗信息
            sqlstr = sqlstr + "select " + HF_id.Value + ""
                      + ", '" + TB_wlbh.Text.Trim() + "'"
                      + ", '" + TB_wlmc.Text.Trim() + "'"
                      + ", '" + TB_wlpc.Text.Trim() + "'"
                      + ", '" + TB_gys.Text.Trim() + "'"
                      + ", '" + TB_gg.Text.Trim() + "'"
                      + ",  " + TB_sl.Text.Trim() + ""
                      + ", '" + TB_dw.Text.Trim() + "'"
                      +", '" + DDL_sx.SelectedValue.Trim() + "'"
                      +", " + TB_qmsl.Text.Trim() + "";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();

        }

        for (int i = 1; i <= 25; i++)
        {
            if (Request["TB_blmc" + i] != null)
            {
                if (Request["bl" + i] != null && Request["bl" + i].ToString() != "") //ID编号不为空表示是修改记录，为空表示新增记录
                {
                    sqlstr = " update js_sgrb_bljl set "
                           + " bldm= '" + Request["TB_bldm" + i].ToString() + "'"
                           + ",blmc= '" + Request["TB_blmc" + i].ToString() + "'"
                           + ",bllb= '" + Request["TB_bllb" + i].ToString() + "'"
                           + ",blsl=  " + Request["TB_blsl" + i].ToString() + " "
                           + ",blbz= '" + Request["TB_blbz" + i].ToString() + "'"
                           + " where  id=" + Request["bl" + i].ToString() + "";
                }
                else
                {
                    sqlstr = "INSERT INTO dbo.js_sgrb_bljl ( fid, bldm, blmc,bllb, blsl, blbz )"
                           + "select " + HF_id.Value + ""
                           + ", '" + Request["TB_bldm" + i].ToString() + "'"
                           + ", '" + Request["TB_blmc" + i].ToString() + "'"
                           + ", '" + Request["TB_bllb" + i].ToString() + "'"
                           + ",  " + Request["TB_blsl" + i].ToString() + ""
                           + ", '" + Request["TB_blbz" + i].ToString() + "'";
                }
                Cmd = new SqlCommand(sqlstr, sqlcon);
                Cmd.ExecuteNonQuery();
            }

            if (Request["TB_wlbh" + i] != null)
            {
                if (Request["wl" + i] != null && Request["wl" + i].ToString() != "") //ID编号不为空表示是修改记录，为空表示新增记录
                {
                    sqlstr1 = " update js_sgrb_wlxh set "
                       + "  wlbh='" + Request["TB_wlbh" + i].ToString() + "'"
                       + ", wlmc='" + Request["TB_wlmc" + i].ToString() + "'"
                       + ", wlpc='" + Request["TB_wlpc" + i].ToString() + "'"
                       + ", gys='" + Request["TB_gys" + i].ToString() + "'"
                       + ", gg='" + Request["TB_gg" + i].ToString() + "'"
                       + ", sl= " + Request["TB_sl" + i].ToString() + ""
                       + ", dw='" + Request["TB_dw" + i].ToString() + "'"
                       + ", sx='" + Request["DDL_sx" + i] + "'"
                       + ", qmsl=" + Request["TB_qmsl" + i] + ""
                       + "  where id =" + Request["wl" + i].ToString() + "";
                }
                else
                {
                    sqlstr1 = "INSERT INTO dbo.js_sgrb_wlxh ( fid, wlbh, wlmc, wlpc, gys, gg, sl, dw,sx,qmsl )"
                            + "select " + HF_id.Value + ""
                            + ", '" + Request["TB_wlbh" + i].ToString() + "'"
                            + ", '" + Request["TB_wlmc" + i].ToString() + "'"
                            + ", '" + Request["TB_wlpc" + i].ToString() + "'"
                            + ", '" + Request["TB_gys" + i].ToString() + "'"
                            + ", '" + Request["TB_gg" + i].ToString() + "'"
                            + ",  " + Request["TB_sl" + i].ToString() + ""
                            + ", '" + Request["TB_dw" + i].ToString() + "'"
                            + ", '" + Request["DDL_sx" + i] + "'"
                            + ", " + Request["TB_qmsl" + i] + "";
                }

                Cmd = new SqlCommand(sqlstr1, sqlcon);
                Cmd.ExecuteNonQuery();
            }
        }

        sqlcon.Close();
    }

    protected void B_save_Click(object sender, EventArgs e)
    {
        if (HF_id.Value == "")
        {
            AddDate();
            Response.Write("<script>alert('提交成功!');self.location='jpscrb.aspx?gxmc=" + DDL_gxmc.SelectedItem.Text + "&&dqrq=" + TB_rq.Text.Trim() + "';</script>");
        }
        else
        {
            EditContent(HF_id.Value);
            Response.Write("<script>alert('提交成功!');self.location='jpscrb.aspx?id=" + HF_id.Value + "';</script>");
        }

        
    }

    //public bool DataSetToExcel(DataSet dataSet, bool isShowExcle)
    //{
    //    DataTable dataTable = dataSet.Tables[0];
    //    int rowNumber = dataTable.Rows.Count;//不包括字段名 
    //    int columnNumber = dataTable.Columns.Count;
    //    int colIndex = 0;

    //    if (rowNumber == 0)
    //    {
    //        return false;
    //    }

    //    //建立Excel对象 
    //    Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();
    //    //excel.Application.Workbooks.Add(true); 
    //    Microsoft.Office.Interop.Excel.Workbook workbook = excel.Workbooks.Add(Microsoft.Office.Interop.Excel.XlWBATemplate.xlWBATWorksheet);
    //    Microsoft.Office.Interop.Excel.Worksheet worksheet = (Microsoft.Office.Interop.Excel.Worksheet)workbook.Worksheets[1];
    //    excel.Visible = isShowExcle;
    //    //Microsoft.Office.Interop.Excel.Worksheet worksheet = (Microsoft.Office.Interop.Excel.Worksheet)excel.Worksheets[1]; 
    //    Microsoft.Office.Interop.Excel.Range range;

    //    //生成字段名称 
    //    foreach (DataColumn col in dataTable.Columns)
    //    {
    //        colIndex++;
    //        excel.Cells[1, colIndex] = col.ColumnName;
    //    }

    //    object[,] objData = new object[rowNumber, columnNumber];

    //    for (int r = 0; r < rowNumber; r++)
    //    {
    //        for (int c = 0; c < columnNumber; c++)
    //        {
    //            objData[r, c] = dataTable.Rows[r][c];
    //        }
    //        //Application.DoEvents(); 
    //    }

    //    // 写入Excel 
    //    range = worksheet.get_Range(excel.Cells[2, 1], excel.Cells[rowNumber + 1, columnNumber]);
    //    //range.NumberFormat = "@";//设置单元格为文本格式 
    //    range.Value2 = objData;
    //    worksheet.get_Range(excel.Cells[2, 1], excel.Cells[rowNumber + 1, 1]).NumberFormat = "yyyy-m-d h:mm";

    //    return true;
    //} 



    protected void B_last_Click(object sender, EventArgs e)
    {

        string id = "";
        sqlcon.Open();   //打开数据库连接
        string sqlstr = "select top 1 id from js_sgrb where id < " + HF_id.Value + "  order by id desc";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            id = sdr["id"].ToString();
        }
        sdr.Close();
        sqlcon.Close();
        if (id == "")
        {
            Response.Write("<script>alert('提交成功!')已经最前一页！;</script>");
        }
        else
        {
            Response.Write("<script>self.location='jpscrb.aspx?id=" + id + "';</script>");
        }
       
    }
    protected void B_next_Click(object sender, EventArgs e)
    {
        string id = "";
        sqlcon.Open();   //打开数据库连接
        string sqlstr = "select top 1 id from js_sgrb where id > " + HF_id.Value + "  order by id asc";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            id = sdr["id"].ToString();
        }
        sdr.Close();
        sqlcon.Close();
        if (id == "")
        {
            Response.Write("<script>alert('提交成功!')已经最后一页！;</script>");
        }
        else
        {
            Response.Write("<script>self.location='jpscrb.aspx?id=" + id + "';</script>");
        }
        
    }
}
