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

public partial class btdEdit : System.Web.UI.Page {
    string UserName = "";
    string GroupID = "";
    public string xh = "";
    string lb = "", editType = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e) {
  
    }

   
    public void bind() {
      
    }


    //添加投产计划信息
    protected void lbAddtr_Click(object sender, EventArgs e) {
        sqlcon.Open();
        string sqlstr = "";//"insert into dbo.js_tcjh_list ( psdbh, tczt, ph, jhs, plpc, scjhrq )"
                     //+ " values ('"+tbPsdbh.Text+"','"+ddlTczt.Text+"','"+tbPh.Text+"','"+tbJhs.Text+"','"+tbPlpc.Text+"','"+tbScjhrq.Text+"')";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        Cmd.ExecuteNonQuery();
        sqlcon.Close();

        //重新绑定
        bind();



    }

    //变更状态
    protected void lbSubmit_Click(object sender, EventArgs e) {
       
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
        /*if (e.Row.RowType == DataControlRowType.DataRow) {
            DataRowView drv = e.Row.DataItem as DataRowView;
           // int zs = Convert.ToInt32(lbTczs.Text);
            int jhs=Convert.ToInt32(drv["jhs"].ToString());
            lbTczs.Text = Convert.ToString(zs + jhs);
        }*/
    }
}
