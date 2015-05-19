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

public partial class wkzt_zjgx : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
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
                if (GroupID.IndexOf("hasgroup(文控管理员)") == -1 && GroupID.IndexOf("hasgroup(文控文件维护员)") == -1 && GroupID.IndexOf("hasgroup(文控浏览)") == -1)
                {
                    Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
            bind();
            bind2();
        }
    }

    public void bind()
    {
        sqlcon.Open();
        string sqlstr = "SELECT [FileName],[FullName],[InDate] FROM [WK_UpFile] where filetype='今日新加文件' and   InDate>GETDATE()-5 order by indate desc";
        sqlcom = new SqlCommand(sqlstr, sqlcon);                    //调用存储过程
        SqlDataAdapter adapter = new SqlDataAdapter(sqlcom);        //数据适配器
        DataSet ds = new DataSet();                                 //数据集
        adapter.Fill(ds, "WK_UpFile");
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "FullName" };       //绑定的字段名(显示的文字)
        GridView1.DataBind();

        sqlcon.Close();

    }

    public void bind2()
    {
        sqlcon.Open();
        string sqlstr = "SELECT [FileName],[FullName],[InDate] FROM [WK_UpFile] where filetype='今日删除文件' and  InDate>GETDATE()-5 order by indate desc";
        sqlcom = new SqlCommand(sqlstr, sqlcon);   //调用存储过程
        SqlDataAdapter adapter = new SqlDataAdapter(sqlcom);      //数据适配器
        DataSet ds = new DataSet();                            //数据集
        adapter.Fill(ds, "WK_UpFile");
        GridView2.DataSource = ds;
        GridView2.DataKeyNames = new string[] { "FullName" };    //绑定的字段名(显示的文字)
        GridView2.DataBind();
        sqlcon.Close();

    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string dz = ((LinkButton)sender).CommandArgument;
        if (File.Exists(dz))
        {
            if (Path.GetExtension(dz).Equals(".swf") || Path.GetExtension(dz).Equals(".pdf"))
            {
                Response.Redirect("ShowPDF.aspx?URL=" + dz); //urlconvertor(dz).Substring(urlconvertor(dz).IndexOf("文控管理")));
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

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView2.PageIndex = e.NewPageIndex;
        bind2();
    }
}
