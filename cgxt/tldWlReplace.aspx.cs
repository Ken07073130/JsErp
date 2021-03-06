﻿using System;
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


public partial class tldWlReplace : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {

        // xh = Request.QueryString["xh"];
        // lb = Request.QueryString["lb"];
        tbBh.Text = Request.QueryString["bh"];
        tbWldm.Text = Request.QueryString["wlbh"];
        tbBB.Text = Request.QueryString["bb"];
        tbPsdbh.Text = Request.QueryString["psdbh"];
        getFllist();
       
    }


    protected void btnTj_Click(object sender, EventArgs e) {
        lbtnOK.Enabled = false;
        if (AddFlList()) {
            ClientScript.RegisterStartupScript(this.GetType(), "", "<script>window.opener.location.href=window.opener.location.href;window.close();</script>");
        }
        else {
            lbtnOK.Enabled = true;
        }
       


    }

    //新增替代列表
    public bool AddFlList() {

        string sqlDel = "";
        string sqlAdd = "";

        //获取 型号 万只消耗定额 计划数量 采购需求
        string sqlstr = "select XH,WZXHDE,jhsl,CGXQ,GX from js_tldwzxhdeH where PSDBH='" + tbPsdbh.Text + "' and TLBB='" + tbBB.Text + "' and WLBH='" + tbWldm.Text + "' and bh='" + tbBh.Text + "' ";
        string xh = "";
        string wzxhde = "";
        string jhsl = "";
        string cgxq = "";
        string gx = "";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                xh = sdr["xh"].ToString();
                wzxhde = sdr["wzxhde"].ToString();
                jhsl = sdr["jhsl"].ToString();
                cgxq = sdr["cgxq"].ToString().Equals("True")?"1":"0";
                gx = sdr["gx"].ToString();
            }
        }
        sqlcon.Close();
        sdr.Close();

        if (Request["tbWlbh"] != null && !Request["tbWlbh"].ToString().Equals("")) {
            sqlAdd = sqlAdd + "select '" + tbBh.Text + "', '" +tbPsdbh.Text + "', '" + tbBB.Text
                            + "', '"+xh+"', '" + Request["tbWlbh"].ToString() + "','替代"+tbWldm.Text+"','" + Request["tbSl"].ToString() + "',0,2,'"+gx+"'  union all ";
        }
        for (int i = 1; i <= 100; i++) {
            if (Request["tbWlbh" + i] != null) {
                sqlAdd = sqlAdd + "select '" + tbBh.Text + "', '" + tbPsdbh.Text + "', '" + tbBB.Text
                               + "', '" + xh + "', '" + Request["tbWlbh" + i].ToString() + "','替代" + tbWldm.Text + "','" + Request["tbSl" + i] + "',0,2,'" + gx + "'  union all ";
            }

        }
        if (!sqlAdd.Equals("")) {
            sqlcon.Open();
            SqlTransaction sqlTran = sqlcon.BeginTransaction();
            try {
                
                sqlDel = "delete from dbo.js_tldwzxhdeH where PSDBH='"+tbPsdbh.Text+"' and TLBB='"+tbBB.Text+"' and bh='"+tbBh.Text+"'";
                Cmd = new SqlCommand(sqlDel, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlAdd = "insert into dbo.js_tldwzxhdeH (BH,PSDBH,TLBB,XH,WLBH,WZXHDE,JHSL,CGXQ,TDZT,GX) " 
                        + "select  '"+tbBh.Text+"','"+tbPsdbh.Text+"','"+tbBB.Text+"','"+xh+"','"+tbWldm.Text+"','"+wzxhde+"','"+jhsl+"',"+cgxq+",1,'"+gx+"' union all "
                        + sqlAdd;
                sqlAdd = sqlAdd.Substring(0, sqlAdd.Length - 10);
                Cmd = new SqlCommand(sqlAdd, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlTran.Commit();

            }
            catch (Exception ex) {
                sqlTran.Rollback();
                ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存出错，请联系开发人员')</script>");
                return false;
            }
            finally {
                sqlcon.Close();
                sqlTran.Dispose();

            }
        }
        else {
            sqlcon.Open();
            sqlDel = "delete from dbo.js_tldwzxhdeH where djlsh='" + tbBh.Text + "' ";
            Cmd = new SqlCommand(sqlDel, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }
        return true;
    }



    //获取替代列表
    public void getFllist() {
        divFlqk.InnerHtml = "";
        divFlqk.InnerHtml = "<table id='tab' runat='server' width='1000px' cellspacing='0' align='center'>"
                          + "<tr>"
                          + "<th style='width:10%; height: 28px;'>物料代码</th>"
                          + " <th style='width:10%; height: 28px;'>物料名称</th>"
                          + " <th style='width:6%; height: 28px;'>供应商代码</th>"
                          + " <th style='width:8%; height: 28px;'>供应商名称</th>"
                          + " <th style='width:20%; height: 28px;'>规格</th>"
                          + " <th style='width:5%; height: 28px;'>单位</th>"
                          + " <th style='width:5%; height: 28px;'>数量</th>"
                          + " <th style='width:5%; height: 28px;'><input id='bl_delete' type='button' value='删除' onclick='delTr2()' style='width:58px' /></th></tr>";



        string sqlstr = "   select a.WLBH,a.JHSL SL,b.wlmc,b.lsmxx gg,b.dw,b.gysbh,b.gysmc from dbo.js_tldwzxhdeH a "
                      + "     left join dbo.js_xyclbmH b on a.WLBH=b.wlbh "
                      + "     where PSDBH='" + tbPsdbh.Text + "' and TLBB='" + tbBB.Text + "' and BH=" + tbBh.Text + " and a.wlbh<>'" + tbWldm.Text + "' ";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        int i = 1;
        if (sdr.HasRows) {
            while (sdr.Read()) {
                divFlqk.InnerHtml = divFlqk.InnerHtml + "<tr><td><input  type='text'  style='width:90%'  name='tbWlbh" + i + "'   id='tbWlbh" + i + "' value='" + sdr["Wlbh"].ToString() + "' /></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbWlmc" + i + "'   id='tbWlmc" + i + "'  value='" + sdr["Wlmc"].ToString() + " ' /></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbGysbh" + i + "'   id='tbGysbh" + i + "'  value='" + sdr["Gysbh"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbGysmc" + i + "'   id='tbGysmc" + i + "' value='" + sdr["Gysmc"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbGG" + i + "'   id='tbGG" + i + "' value='" + sdr["GG"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbDw" + i + "'   id='tbDw" + i + "' value='" + sdr["DW"].ToString() + "'/></td>"
                          + "  <td><input  type='text'  style='width:90%' name='tbSl" + i + "'   id='tbSl" + i + "' value='" + sdr["SL"].ToString() + "'/></td>"
                          + " <td><input type='checkbox' name='ckb' /></td></tr>";
                i++;

            }
        }
        divFlqk.InnerHtml = divFlqk.InnerHtml + " <tr><td><input  type='text'  style='width:90%'  name='tbWlbh'   id='tbWlbh' value='' /></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbWlmc'   id='tbWlmc'  value='' /></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbGysbh'   id='tbGysbh'  value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbGysmc'   id='tbGysmc' value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbGG'   id='tbGG' value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbDw'   id='tbDw' value=''/></td>"
                          + "  <td><input  type='text' style='width:90%' name='tbSl'   id='tbSl' value=''/></td>"
                          + " <td><input id='bl_add' type='button' value='添加' onclick=\"addTr2(\'tab\', -1)\" style='width:58px' /></td></tr></table>";

        //把i的值赋给bl
        if (i != 1) {
            bl.Value = Convert.ToString(i - 1);
        }
        sdr.Close();
        sqlcon.Close();
    }


    

  
}
