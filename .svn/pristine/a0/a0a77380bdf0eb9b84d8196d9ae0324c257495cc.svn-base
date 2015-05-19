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

public partial class UserEdit : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string UserID = "";
    string OldPwd = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                UserID = Session["UserID"].ToString();
                L_ID.Text = UserID;
                L_Name.Text =UserName ;
                sqlcon.Open();
                string sqlstr = "select * from STUsers where uGroup=0 and UnUsed=0 and UserID='" + L_ID.Text  + "'";
                SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows) {
                    sdr.Read();
                    T_PhoneNo.Text = sdr["phoneNo"].ToString();
                }
                sqlcon.Close();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }


        }
    }

    protected void tjbd_Click(object sender, EventArgs e)
    {

    }

    protected void save_Click(object sender, EventArgs e)
    {

        if (T_CheckPwd.Text.Trim() != "" && T_NewPwd.Text.Trim() != "")
        {
            if (T_NewPwd.Text.Trim() != T_CheckPwd.Text.Trim())
            {
                Response.Write("<script>alert('两次密码输入不相同!');</script>");
                return;
            }
             //链接数据库
            sqlcon.Open();
            string sqlstr = "select * from STUsers where uGroup=0 and UnUsed=0 and UserID='" + L_ID.Text  + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())   //判断数据库中是否有相关记录  
            {
                OldPwd = sdr["Password"].ToString().Trim();
            }
            sdr.Close();

            if (OldPwd == T_OldPwd.Text.Trim())
            {
                sqlstr = "update  STUsers set Password='" + T_NewPwd.Text.Trim() + " ' phoneNo='"+T_PhoneNo.Text.Trim()+"'  where uGroup=0 and UnUsed=0 and UserID='" + L_ID.Text + "'";
                Cmd = new SqlCommand(sqlstr, sqlcon);
                Cmd.ExecuteNonQuery();

            }
            else
            {
                Response.Write("<script>alert('旧密码输入错误!');</script>");
                return;
            }
            sqlcon.Close();
            Response.Write("<script>alert('密码修改成功!');</script>");

        }
        else
        {
            sqlcon.Open();
            string sqlstr = "update  STUsers set phoneNo='" + T_PhoneNo.Text.Trim() + "'  where uGroup=0 and UnUsed=0 and UserID='" + L_ID.Text + "'";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            Cmd.ExecuteNonQuery(); 
            sqlcon.Close();
            Response.Write("<script>alert('新密码为空，本次没有修改密码，手机号修改成功');</script>");
            return;
        }

    }
    protected void tjbd_Click(object sender, ImageClickEventArgs e)
    {

    }
}
