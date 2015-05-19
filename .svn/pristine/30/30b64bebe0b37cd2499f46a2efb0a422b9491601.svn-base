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
using System.IO;

public partial class menu_iframe : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string OID = "";
    string IsAdministrator = "";
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                OID = Session["OID"].ToString();
                IsAdministrator = Session["IsAdministrator"].ToString();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            bind();
        }
    }

    protected void bind()
    {
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        string sqlStr = " select psd,ts,sum(ts)  over (partition by '' ) zts from ( "
                                 + "            select '样品建议书' psd,count(*) ts  from dbo.js_mfypjysH a "
                                 + "                  where  IsDel=0 and (dbo.js_func_hasgroup('样品建议书','" + UserName + "',a.fqr,'')=1 and FQBMHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + UserName + "','','商务经理审核')=1 and SWBHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + UserName + "','','总经理审核')=1 and ZJLHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + UserName + "','','技术负责人审核')=1 and XMFZRHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + UserName + "','','实验室审核')=1 and SYSHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + UserName + "','','总负责人审核')=1 and ZFZRHQZT='会签中') "
                                 + " ) x where ts<>0 ";
        //填充未评审条数的框
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        myda.Fill(myds);
        GridView1.DataSource = myds;
        GridView1.DataBind();


        sqlcon.Open();
        sqlStr = "SELECT TOP 7  FileName=( CASE WHEN LEN(FileName)>30 THEN SUBSTRING(FileName,0,30)+'...' ELSE FileName END  ),TipShow=[FileName],[FullName],[InDate] FROM [WK_UpFile] where filetype='今日新加文件' order by indate desc";
        sqlcom = new SqlCommand(sqlStr, sqlcon);   //调用存储过程
        SqlDataAdapter adapter = new SqlDataAdapter(sqlcom);      //数据适配器
        DataSet ds = new DataSet();                            //数据集
        adapter.Fill(ds, "WK_UpFile");
        GridView3.DataSource = ds;
        GridView3.DataKeyNames = new string[] { "FullName" };    //绑定的字段名(显示的文字)
        GridView3.DataBind();


        sqlStr = "SELECT TOP 7 sid='#'+convert(varchar(5),id),bt,rq from js_tzxx  order by id desc";
        sqlcom = new SqlCommand(sqlStr, sqlcon);   //调用存储过程
        adapter = new SqlDataAdapter(sqlcom);      //数据适配器
        ds = new DataSet();                            //数据集
        adapter.Fill(ds, "js_tzxx");
        GridView2.DataSource = ds;
        GridView2.DataKeyNames = new string[] { "sid" };    //绑定的字段名(显示的文字)
        GridView2.DataBind();

        sqlcon.Close();
        //公告栏右上角连接属性设置
        if (IsAdministrator == "1")
        {
            HL_TZLJ.Text = "公告管理";
            HL_TZLJ.NavigateUrl = "tgxx.aspx?glxx=1";
        }
        else
        {
            HL_TZLJ.Text = "更多信息";
            HL_TZLJ.NavigateUrl = "tgxx.aspx?glxx=0";
        }
        if (IsAdministrator == "1")
        {
            HL_stcd.Text = "食堂菜单管理";
            HL_stcd.NavigateUrl = "stcd/cdgl.aspx";
        }
        


    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string dz = ((LinkButton)sender).CommandArgument;
        if (File.Exists(dz))
        {
            if (Path.GetExtension(dz).Equals(".swf") || Path.GetExtension(dz).Equals(".pdf"))
            {
                Response.Redirect("wkzt/ShowPDF.aspx?URL=" + dz); //urlconvertor(dz).Substring(urlconvertor(dz).IndexOf("文控管理")));
            }
            else
            {
                string fileName = Path.GetFileName(dz);//Path.GetExtension(dz);//客户端保存的文件名 
                string filePath = dz;//路径

                //以字符流的形式下载文件 
                FileStream fs = new FileStream(filePath, FileMode.Open);
                byte[] bytes = new byte[(int)fs.Length];
                fs.Read(bytes, 0, bytes.Length);
                fs.Close();
                Response.ContentType = "application/octet-stream";
                //通知浏览器下载文件而不是打开 
                Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();
            }
        }
    }

}
