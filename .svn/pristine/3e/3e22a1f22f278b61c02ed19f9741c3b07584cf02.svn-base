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

public partial class chaxun_pcsj_p : System.Web.UI.Page
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
        sqlcon.Open();
        string sqlstr = "SELECT SCZMC  FROM SCZDMBH where SCZMC not in ('负极搅拌','正极搅拌')";
        sqlcom = new SqlCommand(sqlstr, sqlcon);   //调用存储过程
        SqlDataAdapter adapter = new SqlDataAdapter(sqlcom);      //数据适配器
        DataSet ds = new DataSet();                            //数据集
        adapter.Fill(ds, "SCZDMBH");
        gxmc.DataSource = ds;
        gxmc.DataTextField = "SCZMC";    //绑定的字段名(显示的文字)
        gxmc.DataValueField = "SCZMC";   //绑定的值
        gxmc.DataBind();

    }


    public void getbind()
    {
        string sql = "";
        string xmsql = "";
        if (pc.Text.Trim() != "")
        {
            xmsql += " and  scph ='" + pc.Text + "'";
        }

        if (xh.Text.Trim() != "")
        {
            xmsql += " and  xh ='" + xh.Text + "'";
        }
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString); //数据库连接
        sql = "SELECT B.CKMC 仓库名称 ,Mate_ID 物料代码,mate_name 物料名称,GGXH 型号,scph 批次,sum(QMSL)  结存数量  "
            + " FROM [erp_js_data0704].[dbo].[ST_KCMXH] A LEFT JOIN CKDMH B ON A.STOR_ID=B.CKDM   "
            + " where kjym=(select kjym FROM SYSKJYMH where djlsh =(SELECT MAX(djlsh) FROM SYSKJYMH )) and QMSL>0  and  left(Mate_ID,1)!='1'  and  stor_id in (" + C_pc + ")  " + xmsql
            + "  group by Mate_ID ,mate_name ,GGXH ,scph ,B.CKMC,STOR_ID order by STOR_ID  ";
        SqlCommand cmd = new SqlCommand(sql, conn);   //调用存储过程
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@ckdm", SqlDbType.VarChar, 2000);
        //cmd.Parameters["@ckdm"].Value = C_pc;
        SqlDataAdapter adapter = new SqlDataAdapter(cmd);      //数据适配器
        DataSet ds = new DataSet();                            //数据集

        adapter.Fill(ds, "ST_KCMXH");                         //接收返回记录集   
        //GridView1.DataSource = ds;
        //GridView1.DataBind();  
        if (ds.Tables.Count == 0)
        {
            Response.Write("<script>alert('没有数据!');history.go(-1);</script>");
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


    protected void check_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < gxmc.Items.Count; i++)
        {
            if (gxmc.Items[i].Selected)
            {
                if( (gxmc.Items[i].Value =="负极搅拌"))
                {
                    C_pc += "'1001',";
                }else if ((gxmc.Items[i].Value =="负极涂布"))
                {
                    C_pc += "'1101',";
                }else if ( gxmc.Items[i].Value == "负极分切")
                {
                    C_pc += "'1201',";
                }else if (gxmc.Items[i].Value == "负极铆接")
                {
                    C_pc += "'1501',";
                }else if (gxmc.Items[i].Value == "负极分小片")
                {
                    C_pc += "'1301',";
                }else if (gxmc.Items[i].Value == "巻绕")
                {
                    C_pc += "'4001',";
                }else if (gxmc.Items[i].Value == "封装")
                {
                    C_pc += "'5001',";
                }else if (gxmc.Items[i].Value == "注液")
                {
                    C_pc += "'5501',";
                }else if (gxmc.Items[i].Value == "正极搅拌")
                {
                    C_pc += "'2501',";
                }else if (gxmc.Items[i].Value == "正极涂布")
                {
                    C_pc += "'2601',";
                }else if (gxmc.Items[i].Value == "正极分切")
                {
                    C_pc += "'2701',";
                }else if (gxmc.Items[i].Value == "正极分小片")
                {
                    C_pc += "'2801',";
                }else if (gxmc.Items[i].Value == "正极铆接")
                {
                    C_pc += "'3001',";
                }else if (gxmc.Items[i].Value == "化成")
                {
                    C_pc += "'6001',";
                }else if (gxmc.Items[i].Value == "二封")
                {
                    C_pc += "'6501',";
                }else if (gxmc.Items[i].Value == "分容")
                {
                    C_pc += "'7001',";
                }else if (gxmc.Items[i].Value == "包装")
                {
                    C_pc += "'7002','7003',";
                }else if (gxmc.Items[i].Value == "Pack")
                {
                    C_pc += "'8001'";
                }else if (gxmc.Items[i].Value == "出货")
                {
                    C_pc += "'8501',";
                }

            }

        }
        C_pc =  C_pc.Substring(0,C_pc.Length-1).ToString (); 
        getbind();
    }

}
