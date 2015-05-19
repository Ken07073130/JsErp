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
using ThoughtWorks.QRCode.Codec;

public partial class sldEdit : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string editType = "";
    string lb = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {
        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"].Trim();
        editType = Request.QueryString["editType"];

        tbGroupNames.Text = Session["GroupNames"].ToString();
        getFllist();
        if (!IsPostBack) {
            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                ddlIQC.Items.Add("");
                ddlIQC.Items.Add(Session["username"].ToString());
                ddlCgy.Items.Add("");
                ddlCgy.Items.Add(Session["username"].ToString());
            }
            else {
                Response.Redirect("Login.aspx");
            }
            controlEnable();
            if ("ADD" == lb) {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb.Trim()) {
                getData();
            }

        }
    }

    //结束执行存储过程
    public bool execProc() {
        bool result = false;
        sqlcon.Open();
        try {
            //执行存储过程js_sp_cgxtkccl @bh=单子的编号 @djlx=sld
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand();
            da.SelectCommand.Connection = sqlcon;
            da.SelectCommand.CommandText = "js_sp_cgxtkccl";
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            da.SelectCommand.Parameters.AddWithValue("@bh", tbBh.Text.Trim());
            da.SelectCommand.Parameters.AddWithValue("@djlx", "SLD");
            da.SelectCommand.Parameters.AddWithValue("@errorMessage", "");
            da.SelectCommand.ExecuteNonQuery();
            result = true;
        }
        catch (Exception ex) {
            //ClientScript.egisterStartupScript(this.GetType(), "", );
            //UpdatePanel里
            string errorMessage = "执行js_sp_cgxtkccl错误:" + ex.Message;
            errorMessage = errorMessage.Replace("\r\n", "");
            System.Web.UI.ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('" + errorMessage + "')", true);
        }
        finally {
            sqlcon.Close();
        }
        return result;


    }



    //生成二维码
    public Boolean bulidQRcode() {
        try {
            QRCodeEncoder qrCodeEncoder = new QRCodeEncoder();
            //基本设置
            qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;//编码方式
            qrCodeEncoder.QRCodeScale = 4;//大小
            qrCodeEncoder.QRCodeVersion = 7;//符号版本
            qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;//纠错能力

            //生成二维码的内容
            if (!tbWlbh.Text.Trim().Equals("")) {
                String bh = tbWlbh.Text.Trim();
                System.Drawing.Image myimg = qrCodeEncoder.Encode(bh);
                string path = Server.MapPath("") + "\\images\\" + bh + ".jpg";
                myimg.Save(path, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            for (int i = 1; i <= 10; i++) {
                if (Request["tbWlbh" + i] != null && !Request["tbWlbh" + i].Trim().Equals("")) {
                    String bh = Request["tbWlbh" + i].Trim();
                    System.Drawing.Image myimg = qrCodeEncoder.Encode(bh);
                    string path = Server.MapPath("") + "\\images\\" + bh + ".jpg";
                    myimg.Save(path, System.Drawing.Imaging.ImageFormat.Jpeg);
                }
            }


            return true;
        }
        catch (Exception ex) {

            return false;
        }

    }

    //新增时同步增加发料明细列表
    public void AddFlList() {
        string sqlDel = "";
        string sqlAdd = "";
        string imageUrl = "";
       
        int rowCount = Request["bl"] == null ? 0 : Convert.ToInt32(Request["bl"]);
        for (int i = 1; i <= rowCount; i++) {
            if (Request["tbWlbh" + i] != null) {
                //        String imageUrl = "D:\\用户目录\\Documents\\Visual Studio 2005\\Projects\\数据系统WEB版\\cgxt\\images\\" + Request["tbWlbh" + i].Trim() + ".jpg";
                sqlAdd = sqlAdd + "select '" + tbBh.Text + "', '" + Request["tbWlbh" + i].ToString() + "', '" + Request["tbWlmc" + i].ToString() + "', '" + Request["tbGG" + i].ToString() + "', '"
                    + Request["tbPh" + i].ToString() + "', '" + Request["tbSl" + i].ToString() + "', '" + Request["tbDw" + i].ToString() + "', '" + Request["tbCw" + i].ToString() + "', '" + Request["tbHjh" + i].ToString() + "', '" + Request["ddlPzzk" + i].ToString() + "', '" + Request["ddlRkcz" + i].ToString() + "', '" + Request["tbSm" + i].ToString() + "', '" + Request["rkzt" + i].ToString() + "', '" + Request["tbRkrq" + i].ToString() + "', '" + Request["tbJyrq" + i].ToString() + "', '" + Request["tbJe" + i].ToString() + "' " + " union all ";
            }

        }
        if (Request["tbWlbh"] != null && !Request["tbWlbh"].ToString().Equals("")) {
            //   String imageUrl = "D:/用户目录/Documents/Visual Studio 2005/Projects/数据系统WEB版/cgxt/images/" + Request["tbWlbh"].Trim() + ".jpg";
            sqlAdd = sqlAdd + "select '" + tbBh.Text + "', '" + Request["tbWlbh"].ToString() + "', '" + Request["tbWlmc"].ToString() + "', '" + Request["tbGG"].ToString() + "', '"
                + Request["tbPh"].ToString() + "', '" + Request["tbSl"].ToString() + "', '" + Request["tbDw"].ToString() + "', '" + Request["tbCw"].ToString() + "', '" + Request["tbHjh"].ToString() + "', '" + Request["ddlPzzk"].ToString() + "', '" + Request["ddlRkcz"].ToString() + "', '" + Request["tbSm"].ToString() + "', '未入库', '" + Request["tbRkrq"].ToString() + "', '" + Request["tbJyrq"].ToString() + "', '" + Request["tbJe"].ToString() + "' " + " union all ";
        }
        if (!sqlAdd.Equals("")) {
            sqlcon.Open();
            SqlTransaction sqlTran = sqlcon.BeginTransaction();
            try {
                sqlDel = "delete from dbo.js_sld_fllbH where bh='" + tbBh.Text + "'";
                Cmd = new SqlCommand(sqlDel, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlAdd = "insert into dbo.js_sld_fllbH ( BH,WLBH,WLMC,GG,PH,SL,DW,CW,HJH,PZZK,RKCZ,SM,RKZT,RKRQ,JYRQ,JE) " + sqlAdd;
                sqlAdd = sqlAdd.Substring(0, sqlAdd.Length - 10);
                Cmd = new SqlCommand(sqlAdd, sqlcon);
                Cmd.Transaction = sqlTran;
                Cmd.ExecuteNonQuery();
                sqlTran.Commit();

            }
            catch (Exception ex) {
                sqlTran.Rollback();
                throw ex;
            }
            finally {
                sqlcon.Close();
                sqlTran.Dispose();

            }
            sqlcon.Close();
        }
        //全部删除了
        else {
            sqlcon.Open();
            sqlDel = "delete from dbo.js_sld_fllbH where bh='" + tbBh.Text + "'";
            Cmd = new SqlCommand(sqlDel, sqlcon);
            Cmd.ExecuteNonQuery();
            sqlcon.Close();
        }
    }


    protected void btnTj_Click(object sender, EventArgs e) {
        /*生成二维码  暂时不用 考虑以后生成条码
        if (bulidQRcode()) {

        }
        else {
            return;
        }*/

        if ("ADD" == lb) {
            if (addData()) {
                Response.Redirect("sldList.aspx");
            }
        }
        else if ("EDIT" == lb) {
            if (editData()) { //编辑数据成功后
                //Response.Write("<script>alert('提交成功!');</script>");
                Response.Redirect("sldList.aspx");
            }
        }

    }


    //新增时设置默认值
    public void setDefault() {
        DateTime dtSysDate = DateTime.Now;
        tbJbrq.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbSlzt.Text = "未完成";
        tbSly.Text = Session["UserName"].ToString();

    }



    //获取同步的列表
    public void getFllist() {
        string readOnly = "";
        string groupNames = tbGroupNames.Text;
        string phtkkcReadOnly = "";
        string pzkcReadOnly = "";
        string cwhjbzReadOnly = "";
        string trReadOnly = "";
        string trReadOnly_Selected = "";
        string trReadOnly_Style = "";
        //子表的个数
        int wlcount = 0;

        if (groupNames.IndexOf("收料单-收料员") >= 0 || groupNames.IndexOf("超级用户") >= 0 ||
           groupNames.IndexOf("收料单-仓管员") >= 0) {
            phtkkcReadOnly = "";
        }
        else {
            phtkkcReadOnly = "readonly='readonly'";
        }

        if (groupNames.IndexOf("收料单-IQC") >= 0 || groupNames.IndexOf("超级用户") >= 0) {
            pzkcReadOnly = "";
        }
        else {
            pzkcReadOnly = "disabled='disabled'";
        }

        if (groupNames.IndexOf("收料单-仓管员") >= 0 || groupNames.IndexOf("超级用户") >= 0) {
            cwhjbzReadOnly = "";
        }
        else {
            cwhjbzReadOnly = "readonly='readonly'";
        }





        divFlqk.InnerHtml = "";
        divFlqk.InnerHtml = "  <table id='tab' width='1100' cellspacing='0' align='center'>  <tr> "
                          + "  <th style='width: 145px; height: 28px;'>物料编号</th>"
                          + "  <th style='width: 145px; height: 28px;'>物料名称</th>"
                          + "  <th style='width: 178px; height: 28px;'>规格</th>"
                          + "  <th style='width: 140px; height: 28px;'>批号</th>"
                          + "  <th style='width: 2%; height: 28px;'>数量</th>"
                          + "  <th style='width: 2%; height: 28px;'>金额</th>"
                          + "  <th style='width: 2%; height: 28px;'>单位</th>"
                          + "  <th style='width: 2%; height: 28px;'>仓位</th>"
                          + "  <th style='width: 2%; height: 28px;'>货架号</th>"
                          + "  <th style='width: 2%; height: 28px;'>品质状况</th>"
                          + "  <th style='width: 2%; height: 28px;'>入库操作</th>"
            //+ "  <th style='width: 70px; height: 28px;'>说明</th>"
                          + "  <th style='display:none; height: 28px;'>校验日期</th>"
                          + "  <th style='display:none; height: 28px;'>入库日期</th>"
                          + " <th style='width:70px; height: 28px;'><input id='bl_delete' type='button' value='删除' onclick='delTr2()' style='width:58px' " + (readOnly == "true" ? "disabled='disabled'" : "") + " /></th></tr>";



        string sqlstr = "select  BH,WLBH,WLMC,GG,PH,SL,DW,CW,HJH,PZZK,RKCZ,SM,RKZT,RKRQ,JYRQ,RKRQ,JE from js_sld_fllbH where BH='" + tbBh.Text + "'";
        sqlcon.Open();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        int i = 1;
        if (sdr.HasRows) {
            /*divFlqk.InnerHtml = divFlqk.InnerHtml + "<tr><td colspan='7' align='center' style='font-size:18px; font-weight:bold'>已添加列表<td></tr>" +
                 "<tr><td style='height: 39px'>批号</td><td style='height: 39px'>发料数量</td><td style='height: 39px'>库存量</td>"
                           + "<td style='height: 39px'>库位</td><td style='height: 39px'>仓位</td><td style='height: 39px'>品质状况</td>"
                           + "<td style='width: 120px'>备注</td><td style='width: 70px'></td> </tr>";*/
            string optionPzzk = "";
            string optionKcfs = "";
            while (sdr.Read()) {
                wlcount++;
                //已入库的行不能再次进行编辑
                if (sdr["rkzt"].ToString().Equals("已入库") || sdr["rkzt"].ToString().Equals("已退货")) {
                    trReadOnly = "readonly=readonly";
                    trReadOnly_Selected = "disabled='disabled'";
                    trReadOnly_Style = "style='background-color:gray;'";
                }
                else {
                    trReadOnly = "";
                    trReadOnly_Selected = "";
                    trReadOnly_Style = "";
                }

                if (sdr["pzzk"].ToString().Equals("合格")) {
                    optionPzzk = "<option>请选择</option> <option selected='selected'>合格</option> <option>不合格</option> <option>让步</option>";
                }
                else if (sdr["pzzk"].ToString().Equals("不合格")) {
                    optionPzzk = "<option>请选择</option> <option >合格</option> <option selected='selected'>不合格</option> <option>让步</option>";
                }
                else if (sdr["pzzk"].ToString().Equals("让步")) {
                    optionPzzk = "<option>请选择</option> <option >合格</option> <option>不合格</option> <option selected='selected'>让步</option>";
                }
                else {
                    optionPzzk = "<option selected='selected'>请选择</option> <option >合格</option> <option>不合格</option> <option >让步</option>";
                }

                if (sdr["RKCZ"].ToString().Equals("入库")) {
                    optionKcfs = "<option>请选择</option> <option selected='selected'>入库</option> <option>退货</option> ";
                }
                else if (sdr["RKCZ"].ToString().Equals("退货")) {
                    optionKcfs = "<option>请选择</option> <option >入库</option> <option selected='selected'>退货</option> ";
                }
                else {
                    optionKcfs = "<option selected='selected'>请选择</option> <option >入库</option> <option>退货</option> ";
                }
                divFlqk.InnerHtml = divFlqk.InnerHtml + "<tr " + trReadOnly_Style + ">"
                          + "  <td><input  type='text' " + phtkkcReadOnly + trReadOnly + " style='width:95%' name='tbWlbh" + i + "'   id='tbWlbh" + i + "'  value='" + sdr["WLBH"].ToString() + " '  /></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + trReadOnly + " style='width:95%' name='tbWlmc" + i + "'   id='tbWlmc" + i + "'  value='" + sdr["WLMC"].ToString() + "'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + trReadOnly + " style='width:95%' name='tbGG" + i + "'   id='tbGG" + i + "'  value='" + sdr["GG"].ToString() + "' title='" + sdr["GG"].ToString() + "'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + trReadOnly + " style='width:95%' name='tbPh" + i + "'   id='tbPh" + i + "'  value='" + sdr["PH"].ToString() + "'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + trReadOnly + " style='width:50px' name='tbSl" + i + "'   id='tbSl" + i + "'  value='" + sdr["SL"].ToString() + "'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + trReadOnly + " style='width:50px' name='tbJe" + i + "'   id='tbJe" + i + "'  value='" + sdr["JE"].ToString() + "'/></td>"
                          + "  <td><input  type='text' " + phtkkcReadOnly + trReadOnly + " style='width:50px' name='tbDw" + i + "'   id='tbDw" + i + "'  value='" + sdr["DW"].ToString() + "'/></td>"
                          + "  <td><input  type='text' " + cwhjbzReadOnly + trReadOnly + " style='width:50px' name='tbCw" + i + "'   id='tbCw" + i + "' value='" + sdr["CW"].ToString() + "'  onchange='rkztChange(this)' /></td>"
                          + "  <td><input  type='text' " + cwhjbzReadOnly + trReadOnly + " style='width:50px' name='tbHjh" + i + "'   id='tbHjh" + i + "' value='" + sdr["HJH"].ToString() + "'   onchange='rkztChange(this)' /></td>"
                          + " <td> <select id='ddlPzzk" + i + "' name='ddlPzzk" + i + "' onchange='rkztChange(this)'  " + pzkcReadOnly + trReadOnly_Selected + " > " + optionPzzk + "</select> </td> "
                          + " <td> <select id='ddlRkcz" + i + "' name='ddlRkcz" + i + "' onchange='rkztChange(this)'  " + pzkcReadOnly + trReadOnly_Selected + " > " + optionKcfs + "</select> </td> "
                          + "  <td style='display:none' ><input  type='text'  style='display:none;width:50px' name='tbRkrq" + i + "'   id='tbRkrq" + i + "' value='" + sdr["RKRQ"].ToString() + "'  /></td>"
                          + "  <td style='display:none' ><input  type='text'  style='display:none;width:50px' name='tbJyrq" + i + "'   id='tbJyrq" + i + "' value='" + sdr["JYRQ"].ToString() + "'  /></td>"
                          + " <td><input id='rkzt" + i + "' name='rkzt" + i + "' type='text' style='width:55%;font-size:9px;' readonly='readonly' value='" + sdr["RKZT"].ToString() + "'/><input type='checkbox' name='ckb' " + trReadOnly_Selected + " /></td></tr>"
                          + "<tr><td colspan='12' valign='middle' id='tdSm" + i + "' style='display:none'>退货说明<textarea style='width:97%' rows='4' cols='25' class='text' id='tbSm" + i + "' name='tbSm" + i + "'>" + sdr["SM"].ToString() + "</textarea></td></tr>";
                i++;

            }
        }
        divFlqk.InnerHtml = divFlqk.InnerHtml + " <tr>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:95%' name='tbWlbh'   id='tbWlbh'  value='' /></td>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:95%' name='tbWlmc'   id='tbWlmc'  value=''/></td>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:95%' name='tbGG'   id='tbGG'  value='' /></td>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:95%' name='tbPh'   id='tbPh'  value=''/></td>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:50px' name='tbSl'   id='tbSl'  value='' /></td>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:50px' name='tbJe'   id='tbJe'  value='' /></td>"
                          + "  <td><input  type='text'  " + phtkkcReadOnly + " style='width:50px' name='tbDw'   id='tbDw'  value=''/></td>"
                          + "  <td><input  type='text'  " + cwhjbzReadOnly + " style='width:50px' name='tbCw'   id='tbCw' value=''/></td>"
                          + "  <td><input  type='text'  " + cwhjbzReadOnly + " style='width:50px' name='tbHjh'   id='tbHjh' value=''/></td>"
                          + " <td><select id='ddlPzzk' name='ddlPzzk' > <option selected='selected'>请选择</option> <option>合格</option> <option>不合格</option> <option>让步</option></select> </td>"
                          + " <td style='height: 28px'><select id='ddlRkcz' name='ddlRkcz'><option selected='selected'>请选择</option><option>入库</option><option>退货</option> </select></td>"
                          + "  <td style='display:none'><input  type='text'  " + cwhjbzReadOnly + " style='width:90%' name='tbSm'   id='tbSm' value=''/></td>"
                          + "  <td style='display:none' ><input  type='text'   style='display:none;width:50px;' name='tbRkrq'   id='tbRkrq'  value=''/></td>"
                          + "  <td style='display:none' ><input  type='text'   style='display:none;width:50px;' name='tbJyrq'   id='tbJyrq'  value=''/></td>"
                          + " <td><input id='bl_add' type='button' value='添加' onclick=\"addTr2(\'tab\', -1)\" style='width:58px' " + (readOnly == "true" ? "disabled='disabled'" : "") + " /></td></tr></table>";

        //把i的值赋给bl
        if (i != 1) {
            bl.Value = Convert.ToString(i - 1);
        }

        wl.Value = wlcount.ToString();
        sdr.Close();
        sqlcon.Close();
    }


    //跳转到打印页面
    public void btnPrint_Click(object sender, EventArgs e) {
        Response.Redirect("cpkftaPrint.aspx?xh=" + tbBh.Text + " &lb=EDIT" + "&editType=全部");
    }

    //判断控件的可编辑情况
    public void controlEnable() {
        if (editType.Equals("全部")) {
            lbtnOK.Visible = false;
        }
        sqlcon.Open();
        String sqlstr = "select lx,mc, dbo.js_func_hasgroup(djmc,'" + Session["UserName"] + "','',qx) qx from dbo.js_controlEnable where djmc='收料单'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("TEXTBOX" == sdr["lx"].ToString())
                    //((TextBox)FindControl(sdr["mc"].ToString().Trim())).Attributes.Add("readonly","1" == sdr["qx"].ToString()?"false":"true"); 
                    ((TextBox)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                else if ("DROPDOWNLIST" == sdr["lx"].ToString())
                    ((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                else if ("CHECKBOX" == sdr["lx"].ToString())
                    ((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
                else if ("CHECKBOXLIST" == sdr["lx"].ToString())
                    ((CheckBoxList)FindControl(sdr["mc"].ToString().Trim())).Enabled = ("1" == sdr["qx"].ToString());
            }
        }
        sqlcon.Close();
        sdr.Close();

    }


    //新增数据
    public Boolean addData() {

        sqlcon.Open();
        //第一步获取编号   年 + 月 + 001,002...
        //tbXsrhqsj.Text = tbJbrq.Text;
        //编号  年+月+001
        String sqlStr = "select 'SLD-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                        + " from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 11, 3) as int) + 1 end max_init from   js_sldH  "
                        + "			where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) "
                        + "      ) A ";
        Cmd = new SqlCommand(sqlStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                tbBh.Text = sdr["bh"].ToString();
            }
        }
        sdr.Close();

        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String addSQLSring = "";
        System.Text.StringBuilder zd = new System.Text.StringBuilder();
        System.Text.StringBuilder zdz = new System.Text.StringBuilder();
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '收料单' and charindex('收料员',qx)>0  ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                zd.Append(sdr["zd"].ToString());
                zd.Append(",");
                zdz.Append("'");
                if ("TEXTBOX" == sdr["lx"].ToString()) {
                    zdz.Append(((TextBox)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOX" == sdr["lx"].ToString()) {
                    zdz.Append(((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Checked);
                }
                else if ("DROPDOWNLIST" == sdr["lx"].ToString()) {
                    zdz.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).SelectedValue);
                }
                else if ("CHECKBOXLIST" == sdr["lx"].ToString()) {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++) {
                        if (cblTemp.Items[i].Selected) {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    zdz.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));//全部都没勾选时 空字符串 就substring(0,0)
                }
                //有无订单号
                else if (sdr["zd"].ToString().Equals("rblDdh")) {
                    zdz.Append(rblDdh.SelectedValue);
                }
                zdz.Append("',");
            }
        }
        sdr.Close();



        addSQLSring = "insert into js_sldH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_sldH";
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();


        AddFlList();
        result = true;
        return result;
    }

    //获取数据
    public void getData() {


        sqlcon.Open();
        //Hash表:
        //ht_zddz 字段对照 存储 前台控件和后台字段名对应关系  KEY:数据库字段名 VALUE:控件名称
        //ht_lxdz 类型对照 前台控件和控件类型对照  KEY:数据库字段名 VALUE：控件类型
        Hashtable ht_zddz = new Hashtable();
        Hashtable ht_lxdz = new Hashtable();
        //ArrayList 存储后台数据库字段名字的列表
        ArrayList listZd = new ArrayList();
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '收料单' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                listZd.Add(sdr["zd"].ToString().Trim());//将数据库字段名加入list
                ht_zddz.Add(sdr["zd"].ToString().Trim(), sdr["mc"].ToString().Trim());
                ht_lxdz.Add(sdr["zd"].ToString().Trim(), sdr["lx"].ToString().Trim());
            }
        }
        sdr.Close();
        sqlstr = "select * from dbo.js_sldH where bh='" + xh + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {//获取数据时，只有一条数据
                //循环表的所有数据库字段
                foreach (String strZd in listZd) {
                    if ("TEXTBOX" == (string)ht_lxdz[strZd]) {//根据对照表存储的字段类型进行不同类型的转换
                        ((TextBox)FindControl((string)ht_zddz[strZd])).Text = sdr[strZd].ToString().Trim();
                    }
                    else if ("CHECKBOX" == (string)ht_lxdz[strZd]) {
                        ((CheckBox)FindControl((string)ht_zddz[strZd])).Checked = ("True" == sdr[strZd].ToString());
                    }
                    else if ("DROPDOWNLIST" == (string)ht_lxdz[strZd]) {
                        DropDownList ddlTemp = (DropDownList)FindControl((string)ht_zddz[strZd]);
                        int j = 0;
                        for (int i = 0; i < ddlTemp.Items.Count; i++) {
                            if (ddlTemp.Items[i].Value == sdr[strZd].ToString().Trim()) {
                                j = i;//把匹配到的索引赋给j
                                break;
                            }
                        }
                        if (0 == j) { //j=0说明数据库里的值没有匹配到，那么就自己把数据库的值加进去并选定
                            ddlTemp.Items.Add(sdr[strZd].ToString().Trim());
                        }
                        // ddlTemp.Text = sdr[strZd].ToString().Trim();
                        ddlTemp.SelectedValue = sdr[strZd].ToString().Trim();
                    }
                    else if ("CHECKBOXLIST" == (string)ht_lxdz[strZd]) {
                        CheckBoxList cblTemp = (CheckBoxList)FindControl((string)ht_zddz[strZd]);
                        //获取的值一一去匹配CHECKBOXLIST的值，若匹配上 则打勾
                        for (int i = 0; i < cblTemp.Items.Count; i++) {
                            if (sdr[strZd].ToString().Trim().IndexOf(cblTemp.Items[i].Text) != -1) {
                                cblTemp.Items[i].Selected = true;
                            }
                        }
                    }
                    //RadioButtonList rblDdh赋值
                    else if (strZd.Equals("rblDdh")) {
                        rblDdh.SelectedValue = sdr[strZd].ToString();
                    }

                }
            }
        }
        sdr.Close();
        sqlcon.Close();

        getFllist();




    }


    //更新数据
    public Boolean editData() {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from   dbo.js_controlEnable where   djmc = '收料单'"
                      + " and dbo.js_func_hasgroup('收料单','" + Session["UserName"] + "','',qx)=1 ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                editEqualSql.Append(sdr["zd"].ToString());
                editEqualSql.Append("='");
                if ("TEXTBOX" == sdr["lx"].ToString()) {
                    editEqualSql.Append(((TextBox)FindControl(sdr["mc"].ToString().Trim())).Text);
                }
                else if ("CHECKBOX" == sdr["lx"].ToString()) {
                    editEqualSql.Append(((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Checked);
                }
                else if ("DROPDOWNLIST" == sdr["lx"].ToString()) {
                    editEqualSql.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).SelectedValue);
                }
                else if ("CHECKBOXLIST" == sdr["lx"].ToString()) {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++) {
                        if (cblTemp.Items[i].Selected) {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    editEqualSql.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));
                }
                else if (sdr["zd"].ToString().Equals("rblDdh")) {
                    editEqualSql.Append(rblDdh.SelectedValue);
                }
                editEqualSql.Append("',");

            }
        }
        editSQLSring = "update js_sldH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        //子表的数据库操作
        AddFlList();

        //执行存储过程进行入仓
        result = execProc();

        return result;
    }

    protected void tbGysdm_TextChanged(object sender, EventArgs e) {
        if (tbGysdm.Text.Length >= 2) {
            tbGysdm.Text = tbGysdm.Text.Substring(0, 2);
            string sqlStr = "select gysmc from dbo.js_gysglH where GYSDM='" + tbGysdm.Text + "' and SFYX='有效'";
            sqlcon.Open();
            Cmd = new SqlCommand(sqlStr, sqlcon);
            sdr = Cmd.ExecuteReader();
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    tbGysmc.Text = sdr["gysmc"].ToString();
                }
            }
            sdr.Close();
            sqlcon.Close();
        }

    }

    //订单号变更后去填充供应商代码 供应商名称
    protected void tbDdh_TextChanged(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "select * from dbo.js_cgdH where bh='" + tbDdh.Text + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                tbGysdm.Text = sdr["gysdm"].ToString();
            }
        }
        sqlcon.Close();
        //根据供应商代码获取供应商名称
        tbGysdm_TextChanged(sender, e);
    }
}
