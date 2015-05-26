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
using System.Text.RegularExpressions;

public partial class ypzhpsdList : System.Web.UI.Page {
    string UserName = "";
    string GroupNames = "";
    string ywynames = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e) {
        if (Session["username"] != null) {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupNames = Session["GroupNames"].ToString();
        }
        else {
            Response.Redirect("Login.aspx");
        }
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        //根据Session username获取对应的业务员的名字的集合
        //sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        string sqlstr = "select stuff((select ','+ywy from dbo.js_ywydyjsbry where jsbry='" + Session["username"].ToString() + "' for xml path('')),1,1,'') ywynames";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                ywynames = sdr["ywynames"].ToString();
            }
        }
        sdr.Close();
        sqlcon.Close();
        if (!IsPostBack) {

            divXh.Visible = GroupNames.IndexOf("销售人员") > 0 || GroupNames.IndexOf("超级用户") >= 0;
            //只有总负责人能看到业务员与技术人员对应关系按钮

            sqlcon.Open();
            sqlstr = "select dbo.js_func_hasgroup('样品综合评审单','" + Session["username"].ToString() + "','','总负责人审核') qx ";
            cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = cmd.ExecuteReader();
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    if ("1" == sdr["qx"].ToString()) {
                        aYwyLink.Visible = true;
                    }
                    else {
                        aYwyLink.Visible = false;
                    }
                }
            }
            sdr.Close();
            sqlcon.Close();



            //填充业务员
            //sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
            sqlcon.Open();
            sqlstr = "select ry from dbo.js_rsxxB a ,dbo.js_rsxxF b where a.BMID=b.SSBMID and b.DJMC='样品综合评审单' and DJSSYHZ='销售人员'";
            cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = cmd.ExecuteReader();
            if (sdr.HasRows) {
                ddlYwy.Items.Clear();
                ddlYwy.Items.Add("请选择");
                while (sdr.Read()) {
                    ddlYwy.Items.Add(sdr["ry"].ToString());
                }
            }
            sdr.Close();
            sqlcon.Close();

           // bind();
        }

    }

    public void bind() {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = //"select  '新增' bh,null jbrq,null khdm,null FQR,null FQSHR,null FQRHQZT,null FQBMHQZT,null SWBHQZT,null  XMFZRHQZT,null  ZFZRHQZT" +
            //" union all " +
                 "select bh,jbrq,DJLX," +
                    "  case when DJLX = '产品开发提案' " +
                    "  and YPJYS = '要' then cpsl+'('+DW+')' " +
                    "     when DJLX = '产品开发提案' " +
                    "          and YPJYS = '不要' then '×' " +
                    "     when djlx = '样品建议书' then cpsl+'('+DW+')' " +
                    "     else '' " +
                    " end ypjys , " +
                    " case when DJLX <> '规格书' " +
                    "          and GGSXQ = '要' then '√' " +
                    "     when DJLX <> '规格书' " +
                    "          and GGSXQ = '不要' then '×' " +
                    "     else '' " +
                    " end ggsxq,lchqzt,CPZT,khdm,KHXH,NBXH,CPSL+'('+SYDW+')' sl,xsry,case when LCHQZT='已完成' then 1 else 0 end hqsx,zzqk,swjlhqzt,case when WLWDYQ='True' then '×' else '√' end aszz,tdcs,swyjjq" +
                 " from    js_ypzhpsdH a" +
                 " where  JBRQ is not null and ('超级用户'='" + GroupNames + "'  " +
                 "     or a.xsry='" + UserName + "'" +
                 "     or (dbo.js_func_hasgroup('样品综合评审单','" + UserName + "',a.xsry,'')=1 and ('" + ddlHqzt.Text + "'='全部' or XSJLHQZT='" + ddlHqzt.Text + "')) " +
                 "     or (charindex('样品综合评审单-商务经理审核','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or SWJLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('样品综合评审单-商务经理审核','" + GroupNames + "')>0 and lchqzt='商务发样中') " +
                 "     or (charindex('样品综合评审单-总负责人审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZGHQZT='" + ddlHqzt.Text + "' )  and djlx<>'产品开发提案' ) " +
                 "     or (charindex('样品综合评审单-总工审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZGHQZT='" + ddlHqzt.Text + "' ) and djlx= '产品开发提案') " +
                 "     or (charindex('样品综合评审单-总经理助理审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZZHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('样品综合评审单-实验室审核','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or SYSHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (ZJDXGCS='" + UserName + "' and ('" + ddlHqzt.Text + "'='全部' or  DXHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (ZJGCS='" + UserName + "' and ('" + ddlHqzt.Text + "'='全部' or  PACKHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('样品综合评审单-工程师','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部'  ))   " +
                 "     or (charindex('样品综合评审单-查看组','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部'  ))  ) " +

               "  order by hqsx,jbrq desc,bh desc ";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_ypzhpsdH");


        GridView1.DataSource = myds;
        string filterStringDjlx = ddlDjlx.Text.Equals("全部") ? "" : "djlx='" + ddlDjlx.Text + "'";
        string filterStringKhdm = tbKhdmGl.Text.Equals("") ? "" : " and khdm like '%" + tbKhdmGl.Text + "%'";
        string filterStringYwy = ddlYwy.Text.Equals("请选择") ? "" : " and xsry='" + ddlYwy.Text + "'";
        string filterString = filterStringDjlx + filterStringKhdm + filterStringYwy;
        if (!filterString.Equals("")) {
            DataTable dt = (GridView1.DataSource as DataSet).Tables[0];
            filterString = filterString.Substring(0, 4).Equals(" and") ? filterString = filterString.Substring(4, filterString.Length - 4) : filterString;
            dt.DefaultView.RowFilter = filterString;
            GridView1.DataSource = dt;
        }
        GridView1.DataKeyNames = new string[] { "BH" };
        GridView1.DataBind();


        sqlcon.Close();

        //根据条件改变行颜色
        /*for (int i = 0; i < GridView1.Rows.Count; i++){
            //流程会签状态
            if ("已完成" == GridView1.Rows[i].Cells[4].Text) {
                GridView1.Rows[i].BackColor = System.Drawing.Color.Yellow;
            }
        }*/

    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        string lx = (GridView1.Rows[e.RowIndex].Cells[13].Controls[0] as LinkButton).Text;
        string sqlstr = "";
        sqlcon.Open();
        if (lx.Equals("删除")) {
            //删除单据
            sqlstr = "delete from js_ypzhpsdH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
            sqlcom = new SqlCommand(sqlstr, sqlcon);
            sqlcom.ExecuteNonQuery();

        }
        else if (lx.Equals("终止")) {
            //终止单据
            sqlstr = "update js_ypzhpsdH set LCHQZT='单据已终止',XSJLHQZT='-',SWJLHQZT='-',ZGHQZT='-',ZZHQZT='-',DXHQZT='-',PACKHQZT='-',SYSHQZT='-'  where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
            sqlcom = new SqlCommand(sqlstr, sqlcon);
            sqlcom.ExecuteNonQuery();
            //终止单据后进行邮件提醒
            //条件 实验室审核中
            if (GridView1.Rows[e.RowIndex].Cells[6].Text.Equals("实验室会签中")) {
                sqlstr = "insert into scm_data.dbo.Mail_MailRH ( DjLsh ,ServerSerialNumber  ,SenderAddress , RecipientAddress , "
                        + "  subject ,content ,MailType ,MailEncoding ,SendState ,CreateTime , UPdateTime ,ApplicationNumber ,CreateID )"
                        + "select x2.djlsh+row_number() over ( partition by djlsh order by djlsh),'02' , 'jswlsj@ftjt.net', x1.userdesc, "
                        + " '您即将评审的样品单已被业务员终止，请知悉!','业务员："+GridView1.Rows[e.RowIndex].Cells[8].Text+"，样品单号："+GridView1.Rows[e.RowIndex].Cells[0].Text+"','TEXT','GB2312' ,0, getdate(),getdate(),'Js_MM',147  "
                        + " from ( select userdesc from dbo.STUsers where UserName in ( "
                        + " select RY from dbo.js_rsxxH a,dbo.js_rsxxB b,dbo.js_rsxxF c  "
                        + " where a.DjLsh=b.BMID and a.DjLsh=c.SSBMID and b.BMID=c.SSBMID and c.DJMC='样品综合评审单' and c.DJSSYHZ='实验室审核' "
                        + " and a.bm='实验员' ) and  convert(varchar(100),UserDesc)<>'' ) x1, "
                        + " (select   max(DjLsh) djlsh from scm_data.dbo.Mail_MailRH) x2 ";
                sqlcom = new SqlCommand(sqlstr, sqlcon);
                sqlcom.ExecuteNonQuery();

            }

        }
        //  sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Close();
        bind();

    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e) {
        Response.Redirect("ypzhpsdEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=EDIT" + "&editType=" + ddlHqzt.Text + "&cklx=" + ((LinkButton)GridView1.Rows[e.NewEditIndex].Cells[1].Controls[0]).Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];//编辑
            LinkButton btnDel = (LinkButton)e.Row.Cells[13].Controls[0];//删除
            //只有会签中的记录才能更改
            if (ddlHqzt.Text != "会签中") {
                btnEdit.Text = "查看";
                btnDel.Enabled = false;
            }
            else if ("会签中" == ddlHqzt.Text) {
                btnEdit.Text = "编辑";
                sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
                sqlcon.Open();
                String sqlstr = "select dbo.js_func_hasgroup('样品综合评审单','" + Session["username"].ToString() + "','','销售人员') qx ";
                SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
                SqlDataReader sdr = cmd.ExecuteReader();
                if (sdr.HasRows) {
                    while (sdr.Read()) {
                        if ("1" == sdr["qx"].ToString()) {
                            btnDel.Enabled = true;//只有发起人有删除权限
                        }
                        else {
                            btnDel.Enabled = false;//不是发起人不能删除单据
                            btnDel.Enabled = GroupNames.IndexOf("样品综合评审单-销售经理审核") >= 0 && GroupNames.IndexOf("样品综合评审单-商务经理审核") >= 0;
                        }
                    }
                }



                sdr.Close();
                sqlcon.Close();
                btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");




            }

            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["lchqzt"].ToString();
            if (result == "退回业务员处理")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FF0033");
            else if (result == "单据已终止")
                btnDel.Enabled = false;
            else if (result == "已完成")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC");


            /*样品综合评审单商务签完后的修改控制
               1）商务签完前，业务可修改、删除
               2）商务签完后，业务部不可修改、删除，若需修改需“终止”此单，重新开单（这里需注意同客户同型号的控制）*/
            string swjlhqzt = drv["swjlhqzt"].ToString();
            if (swjlhqzt.Equals("已会签") && !(GroupNames.IndexOf("样品综合评审单-销售人员") < 0) && result != "退回业务员处理") {
                btnDel.Text = "终止";
                btnEdit.Text = "查看";
            }


        }
        foreach (TableCell tc in e.Row.Cells) {
            tc.Attributes["style"] = "border-color:Black";
        }



    }

    protected void tjbd_Click(object sender, EventArgs e) {
        sqlcon.Open();
        String sqlstr = "select dbo.js_func_hasgroup('样品综合评审单','" + Session["username"].ToString() + "','','销售人员') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("1" == sdr["qx"].ToString()) {
                    Response.Redirect("ypzhpsdEdit.aspx?lb=ADD");//只有发起人才能新建表单
                }
                else {
                    Response.Write("<script>alert('您没有添加样品综合评审单的权限!');</script>");
                }
            }
        }
        sqlcon.Close();
        sdr.Close();
        bind();

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void btnCX_Click(object sender, EventArgs e) {
        bind();
    }



    //根据条件生成EXCEL
    protected void btnExcel_Click(object sender, EventArgs e) {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        string conditionString = "";//条件语句
        if (!String.IsNullOrEmpty(tbQsrq.Text)) {
            conditionString = " and cast(jbrq as datetime)>=cast('" + tbQsrq.Text + "' as datetime)  ";
        }
        if (!String.IsNullOrEmpty(tbJsrq.Text)) {
            conditionString = conditionString + " and cast(jbrq as datetime)<=cast('" + tbJsrq.Text + "' as datetime) ";
        }
        if (!String.IsNullOrEmpty(tbKhdm.Text)) {
            conditionString = conditionString + " and khdm like '%" + tbKhdm.Text + "%'  ";
        }
        if (!String.IsNullOrEmpty(tbYwy.Text)) {
            conditionString = conditionString + " and xsry like '%" + tbYwy.Text + "%'  ";
        }
        sqlStr = "select bh,jbrq,DJLX,case when DJLX='产品开发提案' and YPJYS='要,' then '√' else '×' end ypjys,case when DJLX='产品开发提案' and GGSXQ='要,' then '√' else '×' end ggsxq,lchqzt,CPZT,khdm,KHXH,NBXH,CPSL+'('+SYDW+')' sl,xsry " +
                " from    js_ypzhpsdH a" +
                " where  '超级用户'='" + GroupNames + "'  " +
                "     or a.xsry='" + UserName + "'" +
                "     or (dbo.js_func_hasgroup('样品综合评审单','" + UserName + "',a.xsry,'')=1 and ('" + ddlHqzt.Text + "'='全部' or XSJLHQZT='" + ddlHqzt.Text + "')) " +
                "     or (charindex('样品综合评审单-商务经理审核','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or SWJLHQZT='" + ddlHqzt.Text + "' )) " +
                "     or (charindex('样品综合评审单-商务经理审核','" + GroupNames + "')>0 and lchqzt='商务发样中') " +
                "     or (charindex('样品综合评审单-总负责人审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZGHQZT='" + ddlHqzt.Text + "' )  and djlx<>'产品开发提案' ) " +
                "     or (charindex('样品综合评审单-总工审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZGHQZT='" + ddlHqzt.Text + "' ) and djlx= '产品开发提案') " +
                "     or (charindex('样品综合评审单-总经理助理审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZZHQZT='" + ddlHqzt.Text + "' )) " +
                "     or (charindex('样品综合评审单-实验室审核','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or SYSHQZT='" + ddlHqzt.Text + "' )) " +
                "     or (charindex('样品综合评审单-电芯工程师','" + GroupNames + "')>0 and charindex(a.xsry,'" + ywynames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or  DXHQZT='" + ddlHqzt.Text + "' )) " +
                "     or (ZJGCS='" + UserName + "' and ('" + ddlHqzt.Text + "'='全部' or  PACKHQZT='" + ddlHqzt.Text + "' )) " +
                "     or (charindex('样品综合评审单-工程师','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部'  ))   " +
                conditionString +
              "  order by djlx,jbrq desc,bh desc ";
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_ypzhpsdH");
        if (myds.Tables.Count == 0) {
            Response.Write("<script>alert('没有数据!');history.go(-1);</script>");
        }
        else {
            CreateExcel(myds, "样品综合查询.xls");
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

    protected void ddlDjlx_SelectedIndexChanged(object sender, EventArgs e) {
        bind();
    }




    protected void tbDxxh_TextChanged(object sender, EventArgs e) {
        sqlcon.Open();
        string errorMessage = "";
        string sqlstr = "select * from  dbo.['电芯规格表 $']  where 电芯型号=''";
        SqlCommand Cmd = new SqlCommand(sqlstr, sqlcon);
        int count = Convert.ToInt32(Cmd.ExecuteScalar());
        if (count > 0) {
            errorMessage = "系统中已存在该型号";
        }
        else {
            errorMessage = "系统中没有该型号";
            string xh = "";
            if (xh.Length == 6) {
                string CD = xh.Substring(0, 2).Replace("A", "10").Replace("A", "10").Replace("B", "11").Replace("C", "12").Replace("D", "13").Replace("E", "14").Replace("F", "15");
                string KD = xh.Substring(2, 2).Replace("A", "10").Replace("A", "10").Replace("B", "11").Replace("C", "12").Replace("D", "13").Replace("E", "14").Replace("F", "15");
                string HD = xh.Substring(4, 2).Replace("A", "10").Replace("A", "10").Replace("B", "11").Replace("C", "12").Replace("D", "13").Replace("E", "14").Replace("F", "15");

                sqlstr = "select stuff((select '\\n' + 电芯型号+ ','+bcrl+','+zxrl from ( select distinct 电芯型号,'标称容量:'+convert(varchar(200),[标称容量（mAh）]) bcrl,'最小容量:'+convert(varchar(200),[最小容量（mAh）]) zxrl from dbo.['电芯规格表 $'] " +
                       " where 电芯型号 is not null ) a where (" + CD + "<=substring(电芯型号,3,2)+5 and " + CD + ">=substring(电芯型号,3,2)-5) " +
                       " and (" + KD + "<=substring(电芯型号,5,2)+5 and " + KD + ">=substring(电芯型号,5,2)-5) " +
                       " and (" + HD + "<=dbo.js_func_replaceStr(substring(电芯型号,7,2))+5 and " + HD + ">=dbo.js_func_replaceStr(substring(电芯型号,7,2))-5)  for xml path('')),1,1,'') xh";
                Cmd = new SqlCommand(sqlstr, sqlcon);
                SqlDataReader sdr = Cmd.ExecuteReader();
                if (sdr.HasRows) {
                    while (sdr.Read()) {
                        errorMessage = "无该内部型号的电芯，\\n 系统为您找到相近的电芯型号：\\n" + sdr["xh"].ToString().Substring(1, sdr["xh"].ToString().Length - 1);
                    }
                }
            }

        }
        ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + errorMessage + "')</script>");
        sqlcon.Close();
    }


    //提取数字部门 例如FT302040P提取成302040
    public static decimal GetNumber(string str) {
        decimal result = 0;
        if (str != null && str != string.Empty) {
            // 正则表达式剔除非数字字符（不包含小数点.）
            str = Regex.Replace(str, @"[^\d.\d]", "");
            // 如果是数字，则转换为decimal类型
            if (Regex.IsMatch(str, @"^[+-]?\d*[.]?\d*$")) {
                result = decimal.Parse(str);
            }
        }
        return result;
    }
    protected void btnXhcx_Click(object sender, EventArgs e) {
        sqlcon.Open();
        string errorMessage = "";
        errorMessage = "系统中没有该型号";
        string HD = GetNumber(tbHd.Text).ToString().Length > 0 ? GetNumber(tbHd.Text).ToString() : "0";
        string KD = GetNumber(tbKd.Text).ToString().Length > 0 ? GetNumber(tbKd.Text).ToString() : "0";
        string GD = GetNumber(tbGd.Text).ToString().Length > 0 ? GetNumber(tbGd.Text).ToString() : "0";
        string HDWC = GetNumber(tbHdwc.Text).ToString().Length > 0 ? GetNumber(tbHdwc.Text).ToString() : "0";
        string KDWC = GetNumber(tbKdwc.Text).ToString().Length > 0 ? GetNumber(tbKdwc.Text).ToString() : "0";
        string GDWC = GetNumber(tbGdwc.Text).ToString().Length > 0 ? GetNumber(tbGdwc.Text).ToString() : "0";

        string sqlstr = " SELECT  STUFF(( SELECT  '\\n' + 电芯型号 + ',' + bcrl + ',' + zxrl "
                       + " FROM    ( SELECT  DISTINCT 电芯型号,[厚度（MAX）] hd,[宽度（MAX）] kd,[高度（MAX）] gd,'标称容量:'+convert(varchar(200),[标称容量（mAh）]) bcrl,'最小容量:'+convert(varchar(200),[最小容量（mAh）]) zxrl  FROM      dbo.['电芯规格表 $'] "
                       + "  WHERE     电芯型号 IS NOT NULL AND [厚度（MAX）] IS NOT NULL AND [宽度（MAX）] IS NOT NULL  AND [高度（MAX）] IS NOT NULL ) a "
                       + " WHERE   ( " + GD + " <= gd + " + GDWC + "  AND " + GD + " >= gd - " + GDWC + " )"
                       + " AND ( " + KD + " <= kd + " + KDWC + " AND " + KD + " >= kd - " + KDWC + " )"
                       + " AND ( " + HD + "<= hd + " + HDWC + " AND " + HD + " >=hd - " + HDWC + " )"
                       + " for XML PATH('') ), 1, 1, '') xh ";
        SqlCommand Cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if (sdr["xh"].ToString().Length > 0) {
                    errorMessage = "系统为您找到相近的电芯型号：\\n" + sdr["xh"].ToString().Substring(1, sdr["xh"].ToString().Length - 1);
                }
            }
        }
        sqlcon.Close();
        ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('" + errorMessage + "')</script>");

    }
    protected void lbQuery_Click(object sender, EventArgs e) {
        bind();
    }
}
