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

public partial class cpkftaPrint : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "";
    string editType = "";
    DataTable dt = new DataTable();
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;

    protected void Page_Load(object sender, EventArgs e) {
        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"];
        editType = Request.QueryString["editType"];
        tbDjlx.Text = Request.QueryString["djlx"];
        //规格书时特定的部分不可见
        if ("GGS" == tbDjlx.Text) {
            lblTitle.InnerText = "电子规格书";
            tableCpkfta.Visible = false;
            tdSwjl.InnerText = "电芯经理";
            tdZg.InnerText = "PACK经理";
            trGGS1.Visible = true;
            trGGS2.Visible = true;
            //trGGS3.Visible = true;
            trUlxx.Visible = false;
            //trKhxx.Visible = false;
            //trTdls.Visible = true;
            trZyx.Visible = false;
            trScqj.Visible = false;
            trScqjnr.Visible = false;
            CompareValidator7.Enabled = false;
            RequiredFieldValidator6.Enabled = false;
            CompareValidator2.Enabled = false;
            CompareValidator3.Enabled = false;
            CompareValidator4.Enabled = false;
            RequiredFieldValidator2.Enabled = false;
            CompareValidator6.Enabled = false;
            RequiredFieldValidator3.Enabled = false;
            CompareValidator5.Enabled = false;

        }
        if (!IsPostBack) {

            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            ViewState["dt"] = dt;

            if (Session["username"] != null) {
                ddlXsry.Items.Add(Session["username"].ToString());
                ddlXsjl.Items.Add("");
                ddlXsjl.Items.Add(Session["username"].ToString());
                ddlSwjl.Items.Add("");
                ddlSwjl.Items.Add(Session["username"].ToString());
                ddlZg.Items.Add("");
                ddlZg.Items.Add(Session["username"].ToString());
                ddlSys.Items.Add("");
                ddlSys.Items.Add(Session["username"].ToString());
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else {
                Response.Redirect("Login.aspx");
            }
            //sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString); 
            controlEnable();
            if ("ADD" == lb) {
                setDefault();//新增单据设置默认值
            }
            if ("EDIT" == lb.Trim()) {
                getData();
            }
        }
    }

    protected void btnTj_Click(object sender, EventArgs e) {
        if (Session["username"] != null) {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();
        }
        else {
            Response.Redirect("Login.aspx");
        }


        // 如果控件非空，那么上传文件
        if (fulFj.HasFile) {
            btnUpload_Click();
        }

        if (Page.IsValid) {
            //选择退回到业务员
            if ("是" == ddlSfxyth.Text) {
                tdcl();
                Response.Redirect("cpkftaList.aspx?djlx="+tbDjlx.Text);
            }
            if ("ADD" == lb) {
                if (addData()) {
                    Response.Redirect("cpkftaList.aspx?djlx=" + tbDjlx.Text);
                }
            }
            else if ("EDIT" == lb) {
                if (editData()) { //编辑数据成功后
                    //Response.Write("<script>alert('提交成功!');</script>");
                    Response.Redirect("cpkftaList.aspx?djlx="+tbDjlx.Text);
                }
            }
        }

    }

    //退单
    public void tdcl() {
        tbTdcs.Text = Convert.ToString(Convert.ToInt32(tbTdcs.Text) + 1);
        tbLsjl.Text = tbLsjl.Text + Environment.NewLine + "------------------------------------------"
            + Environment.NewLine + "第" + tbTdcs.Text + "次退单" + Environment.NewLine
            + "退单时间:" + DateTime.Now.ToString("yyyy-MM-dd") + "  退单人:" + Session["UserName"].ToString()
            + Environment.NewLine + "退单理由:" + tbTdly.Text;
           
        
        sqlcon.Open();
        string sqlstr = "update js_cpkftaH set xsryhqsj='',lsjl='" + tbLsjl.Text + "',tdcs='" + tbTdcs.Text + "',lchqzt='退回业务员处理' where bh='" + xh + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

    }

    //新增时设置默认值
    public void setDefault() {
        DateTime dtSysDate = DateTime.Now;
        tbJBRQ.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbXsryhqsj.Text = dtSysDate.ToString("yyyy-MM-dd");
        tbLchqzt.Text = "销售经理会签中";
        tbTdcs.Text = "0";
    }


    //如果选择需要样品建议书，那么同步信息到样品建议书
    public void ypjysSyn() {
        sqlcon.Open();
        //不存在的 进行insert操作
        string sqlstr = "insert into dbo.js_ypjysH ( DjLsh ,LCHQZT ,JBRQ , BH ,CPZT ,CPSL , CCH ,CCK , CCC ,KHXH ,KHDM ,ZYX ,YYLY ,NBXH ,BCRL ,ZXRL , NZ ,CHDY ,JECD , JEKD , "
                       + "     JEZXJ ,HPZXJ ,CPXWD , YSFS ,HPKD , HBYQ ,RZYQ ,CDDL , FDDL ,ZDSYDL ,  CXSJ ,CDWD ,FDWD ,JZDY , PACKFS ,PP , GG , GGNK ,DLGLICGG , DLGLICGGNK , "
                       + "     XGNK ,ICPPNK ,MOSGYQ ,MOSGNK ,NTCZZ ,BZ ,JD ,HOLDDL , TRIPDL ,QTYQ ,BREAKERWDKG ,QTGG ,FUSEBXS , CXWZ ,XG , WXLC ,XTGXCD , DZXQT ,LJQPP , LJQGG , "
                       + "     LJQNK ,DZMXS ,DZMXSNR ,DZMXX ,DZMXXNR ,PVCRSMYS ,QTYS ,SJKYS ,SJKCZ ,FHDJ , GYFS , SJKQTYQ ,SMJPP , GGXH ,NTWZ , QTPACKQJ ,BHBQTYQ , PMYQ ,CBBHFS ,CPBZFS , "
                       + "     SFQK ,ZZQK , SFKM ,YJJGDW ,YJJG , SYDW , SL,SYFS ,XXDZ,YPCSBG ,URL,FQR,CPKFTABH,DJCSY,DXCHFS,DXCHSL,DW,PACKCHFS,CBLQK,filename,SFXYUL,SFYTDXH,ULTDXH,CHDYMAX,BCDY) "
                       + "SELECT     (select isnull(max(djlsh),0)+1 from dbo.js_ypjysH), '产品开发提案同步', JBRQ, ( select 'JSJYS-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                       + "                        from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 13, 3) as int) + 1 end max_init from   js_ypjysH "
                       + " 		                where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) "
                       + "            ) A),CPZT, SYSL,CCH, CCK, CCC, KHXH, KHDM, ZYX, YYLY, NBXH, BCRL, ZXRL, NZ, CHDY, JECD, JEKD, "
                       + "           JEZXJ, HPZXJ, CPXWD, YSFS, HPKD, HBYQ, RZYQ, CDDL, FDDL, ZDSYDL,CXSJ, CDWD, FDWD, JZDY, PACKFS, PP, GG, GGNK, DLGLICGG, DLGLICGGNK, "
                       + "           XGNK, ICPPNK, MOSGYQ, MOSGNK, NTCZZ, BZ, JD, HOLDDL,TRIPDL, QTYQ,BREAKERWDKG, QTGG, FUSEBXS, CXWZ, XG, WXLC, XTGXCD, DZXQT,LJQPP, LJQGG,  "
                       + "           DZMXS, LJQNK, DZMXSNR, DZMXX, DZMXXNR, PVCRSMYS, QTYS, SJKYS, SJKCZ, FHDJ, GYFS, SMJPP, SJKQTYQ, GGXH, NTWZ, BHBQTYQ, QTPACKQJ, CBBHFS,PMYQ, CPBZFS, "
                       + "           SFQK, ZZQK, SFKM, YJJGDW, YJJG, SYDW, DXSL, SYFS, XXDZ, YPCSBG, URL, XSRY,BH,1,DXCHFS,SL,DW,PACKCHFS,CBLQK,filename,SFXYUL,SFYTDXH,ULTDXH,CHDYMAX,BCDY"
                       + "           FROM  js_cpkftaH where bh='" + tbBh.Text.Trim() + "' and not exists (select 1 from dbo.js_ypjysH where CPKFTABH='" + tbBh.Text.Trim() + "') ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();

        //存在的 执行update操作
        sqlstr = "update dbo.js_ypjysH set CPZT=a.CPZT ,CPSL=a.SYSL , CCH=a.CCH ,CCK=a.CCK , CCC=a.CCC ,KHXH=a.KHXH ,KHDM=a.KHDM ,ZYX=a.ZYX ,YYLY=a.YYLY ,NBXH=a.NBXH ,BCRL=a.BCRL ,ZXRL=a.ZXRL , NZ=a.NZ ,CHDY=a.CHDY ,JECD=a.JECD , JEKD=a.JEKD , "
                + "       JEZXJ=a.JEZXJ ,HPZXJ=a.HPZXJ ,CPXWD=a.CPXWD , YSFS=a.YSFS ,HPKD=a.HPKD , HBYQ=a.HBYQ ,RZYQ=a.RZYQ ,CDDL=a.CDDL , FDDL=a.FDDL ,ZDSYDL=a.ZDSYDL ,  CXSJ=a.CXSJ ,CDWD=a.CDWD ,FDWD=a.FDWD ,JZDY=a.JZDY , PACKFS=a.PACKCHFS ,PP=a.PP , GG=a.GG , GGNK=a.GGNK ,DLGLICGG=a.DLGLICGG , DLGLICGGNK=a.DLGLICGGNK , "
                + "       XGNK=a.XGNK ,ICPPNK=a.ICPPNK ,MOSGYQ=a.MOSGYQ ,MOSGNK=a.MOSGNK ,NTCZZ=a.NTCZZ ,BZ=a.BZ ,JD=a.JD ,HOLDDL=a.HOLDDL , TRIPDL=a.TRIPDL ,QTYQ=a.QTYQ ,BREAKERWDKG=a.BREAKERWDKG ,QTGG=a.QTGG ,FUSEBXS=a.FUSEBXS , CXWZ=a.CXWZ ,XG=a.XG , WXLC=a.WXLC ,XTGXCD=a.XTGXCD , DZXQT=a.DZXQT ,LJQPP=a.LJQPP , LJQGG=a.LJQGG , "
                + "       LJQNK=a.LJQNK ,DZMXS=a.DZMXS ,DZMXSNR=a.DZMXSNR ,DZMXX=a.DZMXX ,DZMXXNR=a.DZMXXNR ,PVCRSMYS=a.PVCRSMYS ,QTYS=a.QTYS ,SJKYS=a.SJKYS ,SJKCZ=a.SJKCZ ,FHDJ=a.FHDJ , GYFS=a.GYFS , SJKQTYQ=a.SJKQTYQ ,SMJPP=a.SMJPP , GGXH=a.GGXH ,NTWZ=a.NTWZ , QTPACKQJ=a.QTPACKQJ ,BHBQTYQ=a.BHBQTYQ , PMYQ=a.PMYQ ,CBBHFS=a.CBBHFS ,CPBZFS=a.CPBZFS , "
                + "       SFQK=a.SFQK ,ZZQK=a.ZZQK , SFKM=a.SFKM ,YJJGDW=a.YJJGDW ,YJJG=a.YJJG , SYDW=a.SYDW , SL=a.DXSL,SYFS=a.SYFS ,XXDZ=a.XXDZ,YPCSBG=a.YPCSBG ,URL=a.URL, DXCHFS=a.DXCHFS,DXCHSL=a.SL,PACKCHFS=a.PACKCHFS,CBLQK=a.CBLQK,filename=a.filename,SFXYUL=a.SFXYUL,SFYTDXH=a.SFYTDXH,ULTDXH=a.ULTDXH,CHDYMAX=a.CHDYMAX,BCDY=a.BCDY  "
                + "       from dbo.js_cpkftaH a where a.bh='" + tbBh.Text.Trim() + "' and js_ypjysH.CPKFTABH='" + tbBh.Text.Trim() + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();

        sqlcon.Close();

    }


    //上传文件
    protected void btnUpload_Click() {
        if (fulFj.HasFile) {
            String path = @"G:\数据系统共享\";
            String actualPath = path + fulFj.FileName;
            fileName.Text = fulFj.FileName;
            try {
                fulFj.SaveAs(actualPath);
                tbURL.Text = actualPath;
                //ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('上传成功!');</script>");
            }
            catch (Exception ex) {
                String errorMessage = "<script>alert('上传失败!" + ex.Message.Replace("\r\n", "") + "');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "", errorMessage);
            }

        }

    }

    //下载文件
    protected void btnDownLoad_Click(object sender, EventArgs e) {
        if (tbURL.Text.Length > 1) {
            Response.Clear();
            Response.Charset = "utf-8";//设置输出的编码
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.ContentType = "application/octet-stream";
            //fileName转换为UTF-8
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(fileName.Text, System.Text.Encoding.UTF8));
            Response.WriteFile(tbURL.Text);
            Response.Flush();
            Response.End();



        }

    }


    //跳转到打印页面
    public void btnPrint_Click(object sender, EventArgs e) {
        Response.Redirect("cpkftaPrint.aspx?xh=" + tbBh.Text + " &lb=EDIT" + "&editType=全部");
    }

    //判断控件的可编辑情况
    public void controlEnable() {
        sqlcon.Open();
        String sqlstr = "select lx,mc,case when '" + editType + "'='会签中' or '" + editType + "' = '' then dbo.js_func_hasgroup(djmc,'" + Session["UserName"] + "','',qx) else 0 end qx from dbo.js_controlEnable where djmc='产品开发提案'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("TEXTBOX" == sdr["lx"].ToString())
                    //((TextBox)FindControl(sdr["mc"].ToString().Trim())).Attributes.Add("readonly","1" == sdr["qx"].ToString()?"false":"true"); 
                    ((TextBox)FindControl(sdr["mc"].ToString().Trim())).ReadOnly = false;
                else if ("DROPDOWNLIST" == sdr["lx"].ToString())
                    ((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Enabled = true;
                else if ("CHECKBOX" == sdr["lx"].ToString())
                    ((CheckBox)FindControl(sdr["mc"].ToString().Trim())).Enabled = true;
                else if ("CHECKBOXLIST" == sdr["lx"].ToString())
                    ((CheckBoxList)FindControl(sdr["mc"].ToString().Trim())).Enabled = true;
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
        string sqlStr = "";
        if (tbDjlx.Text.Equals("CPKFTA")) {
             sqlStr = "select 'JSTA-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                            + " from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 12, 3) as int) + 1 end max_init from   js_cpkftaH  "
                            + "			where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) and  substring(BH,1,4)='JSTA' "
                            + "      ) A ";
        } else if (tbDjlx.Text.Equals("GGS")) {
             sqlStr = "select 'JSGGS-' + csr_init + replicate('0', 3 - len(max_init)) + cast(max_init as varchar(3)) bh "
                           + "  from   (  select substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) csr_init ,case when max(bh) is null then '001' else cast(substring(max(bh), 13, 3) as int) + 1 end max_init from   js_cpkftaH  "
                           + "           where substring(JBRQ,1,4)+substring(JBRQ,6,2)= substring(convert(nvarchar(6), getdate(), 112), 1, 6 ) and  substring(BH,1,5)='JSGGS' "
                           + "                   ) A ";
        }
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
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '产品开发提案' and charindex('销售人员',qx)>0 ";
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
                    zdz.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Text);
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
                zdz.Append("',");
            }
        }
        sdr.Close();



        addSQLSring = "insert into js_cpkftaH (djlsh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(djlsh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_cpkftaH";
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
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
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '产品开发提案' ";
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
        sqlstr = "select * from dbo.js_cpkftaH where bh='" + xh + "'";
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
                            if (ddlTemp.Items[i].Text == sdr[strZd].ToString().Trim()) {
                                j = i;//把匹配到的索引赋给j
                                break;
                            }
                        }
                        if (0 == j) { //j=0说明数据库里的值没有匹配到，那么就自己把数据库的值加进去并选定
                            ddlTemp.Items.Add(sdr[strZd].ToString().Trim());
                        }
                        ddlTemp.Text = sdr[strZd].ToString().Trim();
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

                }
            }
        }
        sdr.Close();
        sqlcon.Close();

    }


    //更新数据
    public Boolean editData() {
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from    dbo.js_controlEnable where   djmc = '产品开发提案'"
                      + " and dbo.js_func_hasgroup('产品开发提案','" + Session["UserName"] + "','',qx)=1 ";
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
                    editEqualSql.Append(((DropDownList)FindControl(sdr["mc"].ToString().Trim())).Text);
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
                editEqualSql.Append("',");

            }
        }
        editSQLSring = "update js_cpkftaH set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        if (ddlYpjys.Text.Equals("要")) {
            ypjysSyn();
        }

        result = true;
        return result;
    }


    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args) {
        args.IsValid = true;
        //电芯出货且为配组出货时  电芯数量>送样数量
        if (ddlDxchfs.Text.Equals("配组出货") && ddlCpzt.Text.Equals("电芯")) {
            if (Int32.Parse(tbDxsl.Text) < Int32.Parse(tbSysl.Text)) {
                args.IsValid = false;
            }
        }
    }
}
