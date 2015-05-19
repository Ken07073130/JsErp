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

public partial class User : System.Web.UI.Page
{
    string UserName = "";
    string GroupID  = "";
    string UserID   = "";
    string OID      = "";
    SqlConnection sqlcon;
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
                OID = Session["OID"].ToString();
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
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);  //链接数据库
        sqlcon.Open();
        string sqlstr = "select * from STUsers where uGroup=0 and UnUsed=0 and UserID='" + UserID + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())   //判断数据库中是否有相关记录  
        {
            L_ID.Text   = sdr["UserID"].ToString().Trim();
            L_Name.Text = sdr["UserName"].ToString().Trim();
            L_ms.Text   = sdr["UserDesc"].ToString().Trim();
        }
        sdr.Close();

        sqlstr = "SELECT UserName,OID FROM STUsers where OID in (SELECT GroupID FROM STUserGroup where UserID =" + OID + ")";
        SqlDataAdapter Rs = new SqlDataAdapter(sqlstr, sqlcon);
        DataSet rd = new DataSet();
        Rs.Fill(rd);
        C_Group.DataSource = rd.Tables[0];
        C_Group.DataTextField = "UserName";
        C_Group.DataValueField = "OID";
        C_Group.DataBind();
        sqlcon.Close();

        foreach (ListItem li in C_Group.Items)
        {
            li.Selected = true;                    //等于true就表示钩选啦. 
            li.Enabled = false;

        }



    }

    protected void tjbd_Click(object sender, ImageClickEventArgs e)
    {

    }
}
