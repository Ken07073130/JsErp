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

public partial class jgd : System.Web.UI.Page
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
            if (GroupName.IndexOf("物料加工单-铝塑膜分切") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("铝塑膜分切", "50"));
            }
            if (GroupName.IndexOf("物料加工单-正极耳点焊") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("正极耳点焊", "15"));
            }
            if (GroupName.IndexOf("物料加工单-负极耳点焊") != -1)
            {
                DDL_gxmc.Items.Add(new ListItem("负极耳点焊", "15"));
            }
            
        }
    }
    protected void AddDate()   //添加记录
    {
        UserName = Session["UserName"].ToString();
        string maxid = "";
        string sqlstr1 = "";
        string sqlstr = " INSERT INTO js_jgd(scrq,gc,gxmc,gxbh,wlbh,wlmc,gys,pc,gg,sl,dw,bz,qryz,qrwz,drzr,drsc,drzc,dryz,drwz,lrrq,lrr) values"
                        + " ( '" + TB_rq.Text.Trim() + "','" + DDL_gc.SelectedValue.Trim() + "','" + DDL_gxmc.SelectedItem.Text.Trim() + "','" + DDL_gxmc.SelectedValue.Trim() + "','" + TB_wlbh.Text.Trim() + "','" + TB_wlmc.Text.Trim() + "','" + TB_gys.Text.Trim() + "', '" + TB_pc.Text.Trim() + "','" + TB_gg.Text.Trim() + "'," + TB_sl.Text.Trim() + ",  "
                        + " '" + TB_dw.Text.Trim() + "','" + TB_bz.Text.Trim() + "'," + TB_qryz.Text.Trim() + " ," + TB_qrwz.Text.Trim() + " ," + TB_drzr.Text.Trim() + " ," + TB_drsc.Text.Trim() + " ," + TB_drzc.Text.Trim() + " ," + TB_dryz.Text.Trim() + ","
                        + " " + TB_drwz.Text.Trim() + ",getdate(),'" + UserName + "')";
        sqlcon.Open();   //添加主要信息
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();

        sqlstr = "select max(id) maxid from js_jgd";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            maxid = sdr["maxid"].ToString();
        }
        sdr.Close();
        sqlstr1 = "INSERT INTO dbo.js_jgd_wl ( fid,wlbh,wlmc,pc,gys,gg,sl,dw ) ";  //添加物料消耗信息

        if (TB_wlbh_t.Text.Trim() != "" && TB_sl_t.Text.Trim()!="")
        {
            sqlstr1 = sqlstr1 + "select " + maxid   + ""
                      + ", '" + TB_wlbh_t.Text.Trim() + "'"
                      + ", '" + TB_wlmc_t.Text.Trim() + "'"
                      + ", '" + TB_wlpc_t.Text.Trim() + "'"
                      + ", '" + TB_gys_t.Text.Trim()  + "'"
                      + ", '" + TB_gg_t.Text.Trim()   + "'"
                      + ",  " + TB_sl_t.Text.Trim()   + ""
                      + ", '" + TB_dw_t.Text.Trim()   + "'"
                      + " union all ";
        }

        for (int i = 1; i <= 15; i++)
        {
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
                       + " union all ";
            }
        }
        if (sqlstr1.Trim().Length >= 75)
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
        String sqlstr = "SELECT *,CONVERT(varchar(10) , scrq, 120 ) as rq   FROM js_jgd where id=" + id;   //主表的数据取出
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            TB_rq.Text = sdr["rq"].ToString().Trim();
            DDL_gc.Items.FindByText(sdr["gc"].ToString().Trim()).Selected = true;
            DDL_gxmc.Items.FindByText(sdr["gxmc"].ToString().Trim()).Selected = true;
            DDL_gxmc.Enabled = false;
            TB_wlbh.Text = sdr["wlbh"].ToString().Trim();
            TB_wlmc.Text = sdr["wlmc"].ToString().Trim();
            TB_gys.Text = sdr["gys"].ToString().Trim();
            TB_pc.Text = sdr["pc"].ToString().Trim();
            TB_gg.Text = sdr["gg"].ToString().Trim();
            TB_sl.Text = sdr["sl"].ToString().Trim();
            TB_dw.Text = sdr["dw"].ToString().Trim();
            TB_bz.Text = sdr["bz"].ToString().Trim();
            TB_qryz.Text = sdr["qryz"].ToString().Trim();
            TB_qrwz.Text = sdr["qrwz"].ToString().Trim();
            TB_drzr.Text = sdr["drzr"].ToString().Trim();
            TB_drsc.Text = sdr["drsc"].ToString().Trim();
            TB_drzc.Text = sdr["drzc"].ToString().Trim();
            TB_dryz.Text = sdr["dryz"].ToString().Trim();
            TB_drwz.Text = sdr["drwz"].ToString().Trim();
        
            if (GroupName.IndexOf("生产日报录入-" + sdr["gxmc"].ToString() + "录入") == -1 && GroupName.IndexOf("超级用户") == -1)
            {
                //禁止主表中的内容是编辑
                TB_rq.Enabled = false;
                DDL_gc.Enabled = false;
                DDL_gxmc.Enabled = false;
                TB_wlbh.Enabled = false;
                TB_wlmc.Enabled = false;
                TB_gys.Enabled = false;
                TB_pc.Enabled = false;
                TB_gg.Enabled = false;
                TB_sl.Enabled = false;
                TB_dw.Enabled = false;
                TB_bz.Enabled = false;
                TB_qryz.Enabled = false;
                TB_qrwz.Enabled = false;
                TB_drzr.Enabled = false;
                TB_drsc.Enabled = false;
                TB_drzc.Enabled = false;
                TB_dryz.Enabled = false;
                TB_drwz.Enabled = false;
                //禁止两张子表中的内容编辑
                Show = "disabled='false'";
                TB_wlbh_t.Enabled = false;
                TB_wlmc_t.Enabled = false;
                TB_wlpc_t.Enabled = false;
                TB_gys_t.Enabled = false;
                TB_gg_t.Enabled = false;
                TB_sl_t.Enabled = false;
                TB_dw_t.Enabled = false;
                wl_add.Enabled = false;
                wl_delete.Enabled = false;

            }
        }

        
        sdr.Close();
        HtmlTableRow tr;
        HtmlTableCell td;

        int wlcount = 0;
        sqlstr = "SELECT *  FROM js_jgd_wl where fid=" + id;   //消耗物料的数据取出
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            wlcount++;
            tr = new HtmlTableRow();
            td = new HtmlTableCell();
            td.InnerHtml = " <input type='hidden' name='wl" + wlcount.ToString() + "' id='wl" + wlcount.ToString() + "' value='" + sdr["id"].ToString().Trim() + "' /> "
                        + " <input  type='text' " + Show + "  style='width:95%' name='TB_wlbh" + wlcount + "'   id='TB_wlbh" + wlcount + "' value='" + sdr["wlbh"].ToString().Trim() + "'/></td> "
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_wlmc" + wlcount + "'   id='TB_wlmc" + wlcount + "' value='" + sdr["wlmc"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_wlpc" + wlcount + "'   id='TB_wlpc" + wlcount + "' value='" + sdr["pc"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_gys" + wlcount + "'  id='TB_gys" + wlcount + "' value='" + sdr["gys"].ToString().Trim() + "'/></td>"
                        + " <td><input  type='text' " + Show + "  style='width:95%' name='TB_gg" + wlcount + "'  id='TB_gg" + wlcount + "' value='" + sdr["gg"].ToString().Trim() + "'/></td>"
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
        string sqlstr = " UPDATE dbo.js_jgd SET scrq='" + TB_rq.Text.Trim() + "',gc='" + DDL_gc.SelectedValue.Trim() + "',wlbh='"+ TB_wlbh.Text.Trim() +"',wlmc='"+ TB_wlmc.Text.Trim() +"'"
                        +",gys='"+ TB_gys.Text.Trim()+"',pc='"+ TB_pc.Text.Trim()+"',gg='"+ TB_gg.Text.Trim() +"',sl="+ TB_sl.Text.Trim() +",dw='"+ TB_dw.Text.Trim() +"',bz='"+ TB_bz.Text.Trim() +"'"
                        +",qryz='"+ TB_qryz.Text.Trim() +"',qrwz='"+ TB_qrwz.Text.Trim() +"',drzr='"+ TB_drzr.Text.Trim()+"',drsc='"+ TB_drsc.Text.Trim()+"',drzc='"+ TB_drzc.Text.Trim() +"'"
                        +",dryz='"+ TB_dryz.Text.Trim() +"',drwz='"+ TB_drwz.Text.Trim() +"',lrrq=getdate(),lrr='" + UserName + "'"
                        + " WHERE ID =  "+ EditID ;
        sqlcon.Open();   //添加主要信息
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();

        


        if (TB_wlbh_t.Text.Trim() != "" && TB_sl_t.Text.Trim() != "")
        {
            sqlstr = "INSERT INTO dbo.js_jgd_wl ( fid, wlbh, wlmc, pc, gys, gg, sl, dw ) ";  //添加物料消耗信息
            sqlstr = sqlstr + "select " + HF_id.Value + ""
                      + ", '" + TB_wlbh_t.Text.Trim() + "'"
                      + ", '" + TB_wlmc_t.Text.Trim() + "'"
                      + ", '" + TB_wlpc_t.Text.Trim() + "'"
                      + ", '" + TB_gys_t.Text.Trim() + "'"
                      + ", '" + TB_gg_t.Text.Trim() + "'"
                      + ",  " + TB_sl_t.Text.Trim() + ""
                      + ", '" + TB_dw_t.Text.Trim() + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery();

        }

        for (int i = 1; i <= 15; i++)
        {
            if (Request["TB_wlbh" + i] != null)
            {
                if (Request["wl" + i] != null && Request["wl" + i].ToString() != "") //ID编号不为空表示是修改记录，为空表示新增记录
                {
                    sqlstr1 = " update js_jgd_wl set "
                       + "  wlbh='" + Request["TB_wlbh" + i].ToString() + "'"
                       + ", wlmc='" + Request["TB_wlmc" + i].ToString() + "'"
                       + ", pc='" + Request["TB_wlpc" + i].ToString() + "'"
                       + ", gys='" + Request["TB_gys" + i].ToString() + "'"
                       + ", gg='" + Request["TB_gg" + i].ToString() + "'"
                       + ", sl= " + Request["TB_sl" + i].ToString() + ""
                       + ", dw='" + Request["TB_dw" + i].ToString() + "'"
                       + "  where id =" + Request["wl" + i].ToString() + "";
                }
                else
                {
                    sqlstr1 = "INSERT INTO dbo.js_jgd_wl ( fid, wlbh, wlmc, pc, gys, gg, sl, dw )"
                            + "select " + HF_id.Value + ""
                            + ", '" + Request["TB_wlbh" + i].ToString() + "'"
                            + ", '" + Request["TB_wlmc" + i].ToString() + "'"
                            + ", '" + Request["TB_wlpc" + i].ToString() + "'"
                            + ", '" + Request["TB_gys" + i].ToString() + "'"
                            + ", '" + Request["TB_gg" + i].ToString() + "'"
                            + ",  " + Request["TB_sl" + i].ToString() + ""
                            + ", '" + Request["TB_dw" + i].ToString() + "'";
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
        }
        else
        {
            EditContent(HF_id.Value);
        }

        Response.Write("<script>alert('提交成功!');self.location='jgd.aspx?gxmc="+DDL_gxmc.SelectedItem.Text+"';</script>");
    }

  

}
