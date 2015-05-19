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

public partial class zlrb : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string C_gxbl = "";
    string C_gxpj = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    SqlDataReader sdr;
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
        string sqlstr = "SELECT SCZMC  FROM SCZDMBH ";
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
        
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString); //数据库连接
        SqlCommand cmd = new SqlCommand("js_GetZlrb", conn);   //调用存储过程

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@gxbl", SqlDbType.VarChar, 200);
        cmd.Parameters.Add("@gxpj", SqlDbType.VarChar, 200);
        cmd.Parameters.Add("@pc", SqlDbType.VarChar, 50);
        cmd.Parameters.Add("@xh", SqlDbType.VarChar, 50);
        cmd.Parameters.Add("@kssj", SqlDbType.VarChar,50);
        cmd.Parameters.Add("@jssj", SqlDbType.VarChar,50);
        cmd.Parameters["@gxbl"].Value = C_gxbl;
        cmd.Parameters["@gxpj"].Value = C_gxpj;
        cmd.Parameters["@pc"].Value = pc.Text;
        cmd.Parameters["@xh"].Value = xh.Text;
        cmd.Parameters["@kssj"].Value = ksrq.Text;
        cmd.Parameters["@jssj"].Value = jsrq.Text;

        SqlDataAdapter adapter = new SqlDataAdapter(cmd);      //数据适配器

        DataSet ds = new DataSet();                            //数据集

        adapter.Fill(ds, "View_0339");                         //接收返回记录集   
        //GridView1.DataSource = ds;
        //GridView1.DataBind();  
        if (ds.Tables.Count   == 0)
        {
            Response.Write("<script>alert('没有数据!');history.go(-1);</script>");
        }
        else
        {
            CreateExcel(ds, "pcsj_r.xls");
        }
        
    }

    public void getbind_p()
    {

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString); //数据库连接
        SqlCommand cmd = new SqlCommand("js_Getscrb_ap", conn);   //调用存储过程

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@pc", SqlDbType.VarChar, 50);
        cmd.Parameters["@pc"].Value = pc.Text;

        SqlDataAdapter adapter = new SqlDataAdapter(cmd);      //数据适配器

        DataSet ds = new DataSet();                            //数据集

            adapter.Fill(ds, "View_0396");                         //接收返回记录集   
        //GridView1.DataSource = ds;
        //GridView1.DataBind();  
        if (ds.Tables.Count == 0)
        {
            Response.Write("<script>alert('没有数据!');history.go(-1);</script>");
        }
        else
        {
            CreateExcel(ds, "pcsj_p.xls");
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
        if (arcx.Checked==true )
        {
            for (int i = 0; i < gxmc.Items.Count; i++)
            {
                if (gxmc.Items[i].Selected)
                {
                    if (C_gxbl != "")
                    {
                        C_gxbl += " ," + gxmc.Items[i].Value + " ";
                        C_gxpj += ",'" + gxmc.Items[i].Value + "' ";
                    }
                    else
                    {
                        C_gxbl += " '" + gxmc.Items[i].Value + " ";
                        C_gxpj += " '" + gxmc.Items[i].Value + "'";
                    }
                }
            }
            C_gxbl += "'";
            C_gxpj += "";
            getbind();
        }
        else
        {
            getbind_p();
        }
    }
}
