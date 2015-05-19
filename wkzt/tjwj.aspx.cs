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
using System.IO;
using System.Diagnostics;
using System.Data.SqlClient;


public partial class wkzt_tjwj : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    string UserName = "";
    string GroupID = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                if (GroupID.IndexOf("hasgroup(文控管理员)") == -1 && GroupID.IndexOf("hasgroup(文控文件维护员)") == -1 )
                {
                    Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }


            bind();
            
        }

    }
    protected void bind()
    {
        //初始化页面读取跟目录下面的的文件夹
        string path = ConfigurationManager.AppSettings["StartingPath"];
        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("mc"));
        table.Columns.Add(new DataColumn("FullName"));

        if (RadioButton1.SelectedItem.Text == "新加文件")
        {
            LB_cs1.Items.Clear();
            LB_cs2.Items.Clear();
            LB_cs3.Items.Clear();
            LB_cs4.Items.Clear();
            CLB_Files.Items.Clear();
            DirectoryInfo dires = new DirectoryInfo(path);
            DirectoryInfo[] dir = dires.GetDirectories();
            foreach (DirectoryInfo d in dir)
            {
                if (d.ToString().Substring(0, 2) != "作废文件" && d.ToString() != "FlexPaper" && d.ToString() != "swf")
                {
                    DataRow sourseRow = table.NewRow();
                    sourseRow["mc"] = d.Name;
                    sourseRow["FullName"] = d.FullName;
                    table.Rows.Add(sourseRow);
                }
            }

        }
        else
        {
            LB_cs1.Items.Clear();
            LB_cs2.Items.Clear();
            LB_cs3.Items.Clear();
            LB_cs4.Items.Clear();
            CLB_Files.Items.Clear();
            DirectoryInfo dires = new DirectoryInfo(path);
            DirectoryInfo[] dir = dires.GetDirectories();
            foreach (DirectoryInfo d in dir)
            {
                if (d.ToString() == "作废文件" && d.ToString() != "FlexPaper" && d.ToString() != "swf")
                {
                    DataRow sourseRow = table.NewRow();
                    sourseRow["mc"] = d.Name;
                    sourseRow["FullName"] = d.FullName;
                    table.Rows.Add(sourseRow);
                }
            }
        }
        LB_cs1.DataSource = table;
        LB_cs1.DataTextField = "mc";
        LB_cs1.DataValueField = "FullName";
        LB_cs1.DataBind();
    }
    
    protected void RodioChange(object sender, EventArgs e)
    {
        bind();
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        FileInfo file;
        sqlcon.Open();
        string sqlstr = "";

        for (int i = 0; i < CLB_Files.Items.Count; i++)
        {
            if (CLB_Files.Items[i].Selected)
            {
                file = new FileInfo(CLB_Files.Items[i].Value);
                sqlstr = "insert into WK_UpFile (FileName,FullName,FileType,InDate,CDate) values ('" + CLB_Files.Items[i].Text + "','" + CLB_Files.Items[i].Value + "','" + RadioButton1.SelectedValue + "',getdate(),getdate()) ";   //插入新文件夹名
                sqlcom = new SqlCommand(sqlstr, sqlcon);
                sqlcom.ExecuteNonQuery();
            }

        }
        sqlcon.Close();
        
    }

    protected void LB_cs1_SelectedIndexChanged(object sender, EventArgs e)
    {
        LB_cs2.Items.Clear();
        LB_cs3.Items.Clear();
        LB_cs4.Items.Clear();
        CLB_Files.Items.Clear();
        LB_cs2.DataSource = GetDires(LB_cs1.SelectedValue);
        LB_cs2.DataTextField = "mc";
        LB_cs2.DataValueField = "FullName";
        LB_cs2.DataBind();

        CLB_Files.Items.Clear();
        CLB_Files.DataSource = GetFiles(LB_cs1.SelectedValue);
        CLB_Files.DataTextField = "mc";
        CLB_Files.DataValueField = "FullName";
        CLB_Files.DataBind();
    }
    protected void LB_cs2_SelectedIndexChanged(object sender, EventArgs e)
    {
        LB_cs3.Items.Clear();
        LB_cs4.Items.Clear();
        CLB_Files.Items.Clear();
        LB_cs3.DataSource = GetDires(LB_cs2.SelectedValue);
        LB_cs3.DataTextField = "mc";
        LB_cs3.DataValueField = "FullName";
        LB_cs3.DataBind();

        CLB_Files.Items.Clear();
        CLB_Files.DataSource = GetFiles(LB_cs2.SelectedValue);
        CLB_Files.DataTextField = "mc";
        CLB_Files.DataValueField = "FullName";
        CLB_Files.DataBind();
    }
    protected void LB_cs3_SelectedIndexChanged(object sender, EventArgs e)
    {
        LB_cs4.Items.Clear();
        CLB_Files.Items.Clear();
        LB_cs4.DataSource = GetDires(LB_cs3.SelectedValue);
        LB_cs4.DataTextField = "mc";
        LB_cs4.DataValueField = "FullName";
        LB_cs4.DataBind();

        CLB_Files.Items.Clear();
        CLB_Files.DataSource = GetFiles(LB_cs3.SelectedValue);
        CLB_Files.DataTextField = "mc";
        CLB_Files.DataValueField = "FullName";
        CLB_Files.DataBind();
    }
    protected void LB_cs4_SelectedIndexChanged(object sender, EventArgs e)
    {
        CLB_Files.Items.Clear();
        CLB_Files.DataSource = GetFiles(LB_cs4.SelectedValue);
        CLB_Files.DataTextField = "mc";
        CLB_Files.DataValueField = "FullName";
        CLB_Files.DataBind();
    }

    protected DataTable GetDires(string path)
    {

        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("mc"));
        table.Columns.Add(new DataColumn("FullName"));

        
        DirectoryInfo dires = new DirectoryInfo(path);
        DirectoryInfo[] dir = dires.GetDirectories();
        foreach (DirectoryInfo d in dir)
        {

            DataRow sourseRow = table.NewRow();
            sourseRow["mc"] = d.Name;
            sourseRow["FullName"] = d.FullName;
            table.Rows.Add(sourseRow);

        }

        return table;

    }

    protected DataTable GetFiles(string path)
    {

        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("mc"));
        table.Columns.Add(new DataColumn("FullName"));

        
        DirectoryInfo dires = new DirectoryInfo(path);
        FileInfo[] files = dires.GetFiles();
        foreach (FileInfo f in files)
        {

            DataRow sourseRow = table.NewRow();
            sourseRow["mc"] = f.Name;
            sourseRow["FullName"] = f.FullName;
            table.Rows.Add(sourseRow);

        }

        return table;

    }



    protected void Button2_Click(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "insert into js_wktxBOM values ('"+tbXh.Text+"','"+tbDebb.Text+"','"+ddlTxr.SelectedValue+"')";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        cmd.ExecuteNonQuery();
        tbDebb.Text = tbDebb.Text.Equals("临时") ? tbDebb.Text : Convert.ToDouble(tbDebb.Text).ToString("f1");
        lblLog.Text = "成功添加了 型号：" + tbXh.Text + "   版本：" + tbDebb.Text + "   提醒人：" + ddlTxr.SelectedItem;
        ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('添加成功')</script>");
        sqlcon.Close();
    }
}
