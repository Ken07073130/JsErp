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

public partial class index : System.Web.UI.Page {
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand cmd;
    SqlDataReader sdr;
    DataSet ds;
    string UserName = "";
    string GroupID = "";
    string OID = "";
    string IsAdministrator = "";
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {


            if (Session["username"] != null) {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                if (DateTime.Now.Hour < 12) {
                    lbWelCome.Text = "早上好，" + UserName;
                }
                else {
                    lbWelCome.Text = "下午好，" + UserName;
                }
                OID = Session["OID"].ToString();
                IsAdministrator = Session["IsAdministrator"].ToString();
                //填充一级目录
                fillDictionary();
                //填充二级目录
                fillSubDictionary();
            }
            else {
                Response.Redirect("Login.aspx");
            }
        }

        // logout.Attributes.Add("onclick", "javascript:return confirm('确定退出？')");
        // L_user.Text = "当前登录用户：" + Session["username"].ToString();
    }
    //填充一级目录
    public void fillDictionary() {
        blDictionary.Items.Add(new ListItem("文控中心", "SysManage/SubIndex/WelCome.aspx"));
        sqlcon.Open();
        string sqlstr = "";
        if (IsAdministrator == "1") {
            sqlstr = "select  * from [Erp_js_Sys].[dbo].[Tree] where   NodeLevel = 1 order by nodeID";
        }
        else {
            sqlstr = "SELECT *  FROM [Erp_js_Sys].[dbo].[Tree] where nodeLevel=1 and objectid in (SELECT [ObjectID]  FROM [erp_js_data0704].[dbo].[STPermission] where Permission=1 and  userid in (SELECT [GroupID]  FROM [erp_js_data0704].[dbo].[STUserGroup] 	where userid=(SELECT [OID]   FROM [erp_js_data0704].[dbo].[STUsers] where oid=" + OID + ")) )";
        }
        cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                blDictionary.Items.Add(new ListItem(sdr["nodeCaption"].ToString(), sdr["url"].ToString()));
            }
        }

        sdr.Close();
        sqlcon.Close();

    }

    //填充子目录
    public void fillSubDictionary() {
        InitBulletedList_wkgl();
        sqlcon.Open();
        string sqlstr = "";
        for (int i = 1; i < blDictionary.Items.Count; i++) {
            System.Web.UI.HtmlControls.HtmlGenericControl div1 = new HtmlGenericControl();
            div1.Attributes["class"] = "Menu Hide";//指定div样式

            //生成ul li列表 即二级目录
            BulletedList bl = new BulletedList();
            bl.Target = "main";
            bl.DisplayMode = System.Web.UI.WebControls.BulletedListDisplayMode.HyperLink;
            sqlstr = "select * from [Erp_js_Sys].[dbo].[Tree] where ParentID in ( select NodeID from [Erp_js_Sys].[dbo].[Tree] where NodeCaption='" + blDictionary.Items[i].Text + "')  ";
            cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = cmd.ExecuteReader();
            if (sdr.HasRows) {
                while (sdr.Read()) {
                    if (!blDictionary.Items[i].Text.Trim().Equals("电子审批流") && !sdr["url"].ToString().Equals(""))
                        bl.Items.Add(new ListItem(sdr["nodeCaption"].ToString(), sdr["url"].ToString()));
                }
            }
            sdr.Close();
            div1.Controls.Add(bl);
            divSubDictionary.Controls.Add(div1);
        }
        sqlcon.Close();
        /* sqlcon.Open();
     string sqlstr = "select  * from    [Erp_js_Sys].[dbo].[Tree] where   NodeLevel = 1 order by nodeID";
     cmd = new SqlCommand(sqlstr, sqlcon);
     sdr = cmd.ExecuteReader();
     if (sdr.HasRows) {
         while (sdr.Read()) {
             blDictionary.Items.Add(new ListItem(sdr["nodeCaption"].ToString(),sdr["url"].ToString()));
         }
     }
     sdr.Close();
     sqlcon.Close();*/

    }
    //文控菜单
    protected void InitBulletedList_wkgl() {
        System.Web.UI.HtmlControls.HtmlGenericControl div1 = new HtmlGenericControl();
        div1.Attributes["class"] = "Menu";//指定div样式
        //生成ul li列表 即二级目录
        BulletedList bl = new BulletedList();
        bl.Target = "main";
        bl.DisplayMode = System.Web.UI.WebControls.BulletedListDisplayMode.HyperLink;
        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1 || GroupID.IndexOf("hasgroup(文控文件维护员)") != -1 || GroupID.IndexOf("hasgroup(文控浏览)") != -1) {

            bl.Items.Add(new ListItem("最近更新", "wkzt/zjgx.aspx"));
            bl.Items.Add(new ListItem("文件管理", "wkzt/index_wk.aspx"));

        }

        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1 || GroupID.IndexOf("hasgroup(文控文件维护员)") != -1) {
            bl.Items.Add(new ListItem("新加文件管理", "wkzt/tjwj.aspx"));

        }
        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1) {

            bl.Items.Add(new ListItem("组权限管理", "wkzt/yhz.aspx"));
            bl.Items.Add(new ListItem("用户权限管理", "wkzt/yhgl.aspx"));

        }

        div1.Controls.Add(bl);
        divSubDictionary.Controls.Add(div1);
    }

    //退出登录
    protected void lbLoginOout_Click(object sender, EventArgs e) {
        if (Session != null) {
            Session.RemoveAll();
        }
        Response.Redirect("Login.aspx");
    }
}
