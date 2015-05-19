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

public partial class wzflEdit : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    protected void Page_Load(object sender, EventArgs e) {
        //采购来源单据 列位置 [0.物料编号(wlbh)],[1.单据流水号(djlsh)]
        if (!IsPostBack) {
            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else {
                Response.Redirect("~/Login.aspx");
            }

            getData();

        }
    }

    //判断是否已经是存在的
    public bool wzExists() {
        sqlcon.Open();
        string sqlstr = "select count(*) ts from js_wzflbH where dl='" + tbDl.Text + "' and xl='" + tbXl.Text + "' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                int ts = Convert.ToInt32(sdr["ts"].ToString());
                if (ts > 0) {
                    return false;
                }
            }
        }

        sqlcon.Close();
        return true;
    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) {
        this.GridView1.PageIndex = e.NewPageIndex;
        getData();
    }


    protected void btnAddTr_Click(object sender, EventArgs e) {
        //没有相同的物资进行添加
        if (wzExists()) {
            addData();
            getData();
        }
        //有相同的物资 报错
        else {
            System.Web.UI.ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('存在相同的大类和小类的物料，请检查')", true);
        }
    }


    //新增数据
    public Boolean addData() {
        sqlcon.Open();
        Boolean result = false;
        string sqlStr = " insert into dbo.js_wzflbH ( WZMC, DL, XL ) values ('" + tbWzmc.Text.Trim() + "','" + tbDl.Text.Trim() + "','" + tbXl.Text.Trim() + "')";
        Cmd = new SqlCommand(sqlStr, sqlcon);
        Cmd.ExecuteNonQuery();

        sqlcon.Close();
        tbWzmc.Text = "";
        tbDl.Text = "";
        tbXl.Text = "";
        result = true;
        return result;
    }

    //获取数据
    public void getData() {
        sqlcon.Open();
        string sqlstr = "select  DjLsh ,WZMC , DL ,XL from dbo.js_wzflbH order by dl,xl";
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlcon);
        DataSet ds = new DataSet();
        sda.Fill(ds, "js_wzflbH");
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "djlsh" };
        GridView1.DataBind();
        sqlcon.Close();
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        sqlcon.Open();
        string sqlstr = "delete from js_wzflbH where djlsh=" + GridView1.DataKeys[e.RowIndex].Value.ToString();
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        getData();
    }

    //根据大类寻找最小的小类
    protected void tbDl_TextChanged(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "select right('000'+convert(varchar(3),max(convert(int,XL))+1),3) xl from dbo.js_wzflbH where DL='" + tbDl.Text + "'  ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                tbXl.Text = sdr["xl"].ToString();
            }
        }

        sqlcon.Close();
    }
}
