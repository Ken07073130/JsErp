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

public partial class tcjhEdit : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "", editType = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {
        xh = Request["xh"].ToString();
        if (!IsPostBack) {
            getData();
            bind();
        }
    }

    public void getData() {
        sqlcon.Open();
        string sqlstr = " select * from dbo.js_tcjh where psdbh='" + xh + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            sdr.Read();
            tbPsdbh.Text = sdr["psdbh"].ToString();
            ddlZt.SelectedValue = sdr["zt"].ToString();
            //变更状态 正常/变更中/已变更
            if (!sdr["bgzt"].ToString().Equals("变更中")) {
                cbBgzt.Enabled = false;
            }
            tbDjlx.Text = sdr["djlx"].ToString();

        }
        sqlcon.Close();
    }

    public void bind() {
        lbTczs.Text = "0";
        sqlcon.Open();
        string sqlstr = " select * from dbo.js_tcjh_list where psdbh='"+xh+"'";
        SqlDataAdapter sda = new SqlDataAdapter(sqlstr, sqlcon);
        DataSet ds = new DataSet();
        sda.Fill(ds, "js_tcjh_list");
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "djlsh" };
        GridView1.DataBind();
        sqlcon.Close();
    }


    //添加投产计划信息
    protected void lbAddtr_Click(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "insert into dbo.js_tcjh_list ( psdbh, tczt, ph, jhs, plpc, scjhrq )"
                     + " values ('"+tbPsdbh.Text+"','"+ddlTczt.Text+"','"+tbPh.Text+"','"+tbJhs.Text+"','"+tbPlpc.Text+"','"+tbScjhrq.Text+"')";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        //重新绑定
        bind();



        ddlTczt.SelectedIndex = 0;
        tbPh.Text = "";
        tbJhs.Text = "";
        tbScjhrq.Text = "";
        tbPlpc.Text = "";
    }

    //变更状态
    protected void lbSubmit_Click(object sender, EventArgs e) {
        sqlcon.Open();
        string bgztString=cbBgzt.Checked?"bgzt='已变更'":"";
        if (!bgztString.Equals("")) {
            bgztString = "," + bgztString;
        }
        string sqlstr=" update dbo.js_tcjh set zt='"+ddlZt.Text+"' "+bgztString+" where psdbh='"+tbPsdbh.Text+"'";
        Cmd=new SqlCommand(sqlstr,sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        Response.Redirect("tcjhList.aspx");
    }

    //删除行
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        sqlcon.Open();
        string sqlstr = " delete from dbo.js_tcjh_list where djlsh=" + GridView1.DataKeys[e.RowIndex].Value;
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            DataRowView drv = e.Row.DataItem as DataRowView;
            int zs = Convert.ToInt32(lbTczs.Text);
            int jhs=Convert.ToInt32(drv["jhs"].ToString());
            lbTczs.Text = Convert.ToString(zs + jhs);
        }
    }
}
