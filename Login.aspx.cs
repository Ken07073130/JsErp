using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Login : System.Web.UI.Page
{
    private static SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);   
    }


    protected void Login_Click(object sender, ImageClickEventArgs e)
    {
        SqlCommand Cmd;
        SqlDataReader sdr;
        string sql;
        string OID = "";
        string GroupID = "";
        if (this.txt_username.Equals("") == false)   //判断用户名是否为空
        {
            con.Open();
            sql = "select * from STUsers where uGroup=0 and UnUsed=0 and UserID='" + this.txt_username.Text.ToString() + "' and Password ='" + this.txt_pwd.Text.ToString() + "'";
            Cmd = new SqlCommand(sql, con);
            sdr = Cmd.ExecuteReader();
            if (sdr.HasRows)   //判断数据库中是否有相关记录  
            {
                while (sdr.Read())
                {
                    OID = sdr["OID"].ToString();
                    Session.Add("OID", sdr["OID"].ToString().Trim());
                    Session.Add("UserID", sdr["UserID"].ToString().Trim());
                    Session.Add("UserName", sdr["UserName"].ToString().Trim());
                    Session.Add("IsAdministrator", sdr["IsAdministrator"].ToString().Trim());

                }
            }
            else
            {
                this.msg.Text = "用户名或密码错误！";
            }
            sdr.Close();


            if (OID != "")
            {
                sql = "SELECT * FROM STUsers where OID in (SELECT GroupID FROM STUserGroup where UserID =" + OID + ")";
                Cmd = new SqlCommand(sql, con);
                sdr = Cmd.ExecuteReader();
                while (sdr.Read())
                {
                    GroupID += "hasgroup(" + sdr["UserName"].ToString().Trim() + ");";
                }
                Session.Add("GroupID", GroupID);
                sdr.Close();

                //如果是超级用户 那么GroupName=超级用户 否则就从数据库里查询权限
                sql = "select case when min(RY) is null then (select djmc+'-'+DJSSYHZ+',' from js_rsxxB a,dbo.js_rsxxF b where a.BMID=b.SSBMID and a.RY='"+Session["UserName"].ToString()+"' for xml path('') "
                    + ") else '超级用户' end GroupNames from dbo.js_rsxxB where BMID=48 and RY='"+Session["UserName"].ToString()+"'";
                Cmd = new SqlCommand(sql,con);
                sdr = Cmd.ExecuteReader();
                while (sdr.Read()) {
                    Session.Add("GroupNames", sdr["GroupNames"].ToString());
                }
              //  Response.Redirect("index.aspx");
                Response.Write("<script>window.open('index.aspx','_top')</script>");
            }


            con.Close();
        }
        

    }
}
