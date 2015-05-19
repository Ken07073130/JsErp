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

public partial class ypjysList : System.Web.UI.Page
{
    string UserName = "";
    string GroupNames = "";
    string ywynames = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupNames = Session["GroupNames"].ToString();
        }
        else
        {
            Response.Redirect("Login.aspx");
        }

        //只有总负责人能看到业务员与技术人员对应关系按钮
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        string sqlstr = "select dbo.js_func_hasgroup('样品建议书新','" + Session["username"].ToString() + "','','总负责人审核') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                if ("1" == sdr["qx"].ToString())
                {
                    aYwyLink.Visible = true;
                }
                else
                {
                    aYwyLink.Visible = false;
                }
            }
        }
        sdr.Close();
        sqlcon.Close();

        //根据Session username获取对应的业务员的名字的集合
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        sqlstr = "select stuff((select ','+ywy from dbo.js_ywydyjsbry where jsbry='" + Session["username"].ToString() + "' for xml path('')),1,1,'') ywynames";
        cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                ywynames = sdr["ywynames"].ToString();
            }
        }
        sdr.Close();
        sqlcon.Close();



        bind();


    }

    public void bind()
    {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlStr = //"select  '新增' bh,null jbrq,null khdm,null FQR,null FQSHR,null FQRHQZT,null FQBMHQZT,null SWBHQZT,null  XMFZRHQZT,null  ZFZRHQZT" +
            //" union all " +
                 "select  bh,jbrq,lchqzt,khdm,FQR,NBXH,CPSL+'('+SYDW+')' sl,SFQK,ZZQK,KHXH " +
                 " from    js_ypjysH a" +
                 " where  '超级用户'='" + GroupNames + "'  " +
                 "     or a.FQR='" + UserName + "'" +
                 "     or (dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'')=1 and ('" + ddlHqzt.Text + "'='全部' or FQBMHQZT='" + ddlHqzt.Text + "')) " +
                 "     or (charindex('样品建议书新-商务经理审核','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or SWBHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('样品建议书新-商务经理审核','" + GroupNames + "')>0 and lchqzt like '%已完成%') " +
                 "     or (charindex('样品建议书新-总经理助理审核','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or ZJLHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('样品建议书新-实验室审核','" + GroupNames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or SYSHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('样品建议书新-技术负责人审核','" + GroupNames + "')>0 and charindex(a.FQR,'" + ywynames + "')>0 and ('" + ddlHqzt.Text + "'='全部' or  XMFZRHQZT='" + ddlHqzt.Text + "' )) " +
                 "     or (charindex('样品建议书新-总负责人','" + GroupNames + "')>0  and ('" + ddlHqzt.Text + "'='全部' or  ZFZRHQZT='" + ddlHqzt.Text + "' ))   " +

          /*"     or (dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'商务经理审核')=1 and ('" + ddlHqzt.Text + "'='全部' or SWBHQZT='" + ddlHqzt.Text + "' )) " +
          "     or (dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'商务经理审核')=1 and lchqzt like '%已完成%') " +
          "     or (dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'总经理助理审核')=1 and ('" + ddlHqzt.Text + "'='全部' or ZJLHQZT='" + ddlHqzt.Text + "' )) " +
          "     or (dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'实验室审核')=1 and ('" + ddlHqzt.Text + "'='全部' or SYSHQZT='" + ddlHqzt.Text + "' )) " +
          "     or (dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'技术负责人审核')=1 and charindex(a.FQR,'"+ywynames+"')>0 and ('" + ddlHqzt.Text + "'='全部' or  XMFZRHQZT='" + ddlHqzt.Text + "' )) " +
          "     or (dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'总负责人审核')=1 and ('" + ddlHqzt.Text + "'='全部' or  ZFZRHQZT='" + ddlHqzt.Text + "' )) " +*/
                 "  order by jbrq desc,bh desc ";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_ypjysH");

        GridView1.DataSource = myds;
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


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "delete from js_ypjysH where bh='" + GridView1.DataKeys[e.RowIndex].Value.ToString() + "'";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Response.Redirect("ypjysEdit.aspx?xh=" + GridView1.DataKeys[e.NewEditIndex].Value.ToString() + " &lb=EDIT" + "&editType=" + ddlHqzt.Text);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];//编辑
            LinkButton btnDel = (LinkButton)e.Row.Cells[2].Controls[0];//删除
            if (ddlHqzt.Text != "会签中")
            {//只有会签中的记录才能更改
                btnEdit.Text = "查看";
                btnDel.Enabled = false;
            }
            else if ("会签中" == ddlHqzt.Text)
            {
                btnEdit.Text = "编辑";
                sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
                sqlcon.Open();
                String sqlstr = "select dbo.js_func_hasgroup('样品建议书新','" + Session["username"].ToString() + "','','发起人') qx ";
                SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
                SqlDataReader sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        if ("1" == sdr["qx"].ToString())
                        {
                            btnDel.Enabled = true;//只有发起人有删除权限
                        }
                        else
                        {
                            btnDel.Enabled = false;//不是发起人不能删除单据
                        }
                    }
                }



                sdr.Close();
                sqlcon.Close();
                btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); ");




            }


        }
        foreach (TableCell tc in e.Row.Cells)
        {
            tc.Attributes["style"] = "border-color:Black";
        }


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            System.Data.DataRowView drv = e.Row.DataItem as DataRowView;
            string result = drv["lchqzt"].ToString();
            if (result == "已完成(未发样)")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFCC");
            else if (result == "已完成(待反馈)")
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#99CCFF");
            }
            else if (result == "已完成")
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC");
        }
    }

    protected void tjbd_Click(object sender, EventArgs e)
    {
        sqlcon.Open();
        String sqlstr = "select dbo.js_func_hasgroup('样品建议书新','" + Session["username"].ToString() + "','','发起人') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                if ("1" == sdr["qx"].ToString())
                {
                    Response.Redirect("ypjysEdit.aspx?lb=ADD");//只有发起人才能新建表单
                }
                else
                {
                    Response.Write("<script>alert('您没有添加样品建议书新的权限!');</script>");
                }
            }
        }
        sqlcon.Close();
        sdr.Close();
        bind();

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void btnCX_Click(object sender, EventArgs e)
    {
        bind();
    }



    //根据条件生成EXCEL
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        string sqlStr = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        string conditionString = "";//条件语句
        if (!String.IsNullOrEmpty(tbQsrq.Text))
        {
            conditionString = " and cast(jbrq as datetime)>=cast('" + tbQsrq.Text + "' as datetime)  ";
        }
        if (!String.IsNullOrEmpty(tbJsrq.Text))
        {
            conditionString = conditionString + " and cast(jbrq as datetime)<=cast('" + tbJsrq.Text + "' as datetime) ";
        }
        if (!String.IsNullOrEmpty(tbKhdm.Text))
        {
            conditionString = conditionString + " and khdm like '%" + tbKhdm.Text + "%'  ";
        }
        if (!String.IsNullOrEmpty(tbYwy.Text))
        {
            conditionString = conditionString + " and fqr like '%" + tbYwy.Text + "%'  ";
        }
        sqlStr = "select  bh 编号,jbrq 日期,sfqk 收费情况,zzqk 制作情况,khdm 客户代码,khxh 客户型号,nbxh 内部型号,BCRL+'mAh' 标称容量," +
                 "CCH 厚度mm,CCK 宽度mm,CCC 长度mm,CPZT 成品状态,CPSL 成品数量,SYDW 单位,FQR 业务员,FHRQ 发货日期 ,FHSL 发货数量,FHDW 发样单位,CPKFTABH 提案编号,SCSYBH 首次订单,PSBZ 评审备注 " +
                 " from    js_ypjysH a" +
                 " where  (a.FQR='" + UserName + "'" +
                 "     or dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'')=1  " +
                 "     or dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'商务经理审核')=1 " +
                 "     or dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'总经理助理审核')=1 " +
                 "     or dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'实验室审核')=1 " +
                 "     or (dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'技术负责人审核')=1 and charindex(a.FQR,'" + ywynames + "')>0 ) " +
                 "     or dbo.js_func_hasgroup('样品建议书新','" + UserName + "',a.FQR,'总负责人审核')=1 )" +
                 conditionString +
                 "  order by jbrq,bh ";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_ypjysH");
        if (myds.Tables.Count == 0)
        {
            Response.Write("<script>alert('没有数据!');history.go(-1);</script>");
        }
        else
        {
            CreateExcel(myds, "样品建议书查询.xls");
        }


        sqlcon.Close();

    }


    public void CreateExcel(DataSet ds, string FileName)
    {
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
        for (i = 0; i < cl; i++)
        {
            if (i == (cl - 1))//最后一列，加n
            {
                colHeaders += dt.Columns[i].Caption.ToString() + "\n";
            }
            else
            {
                colHeaders += dt.Columns[i].Caption.ToString() + "\t";
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

}
