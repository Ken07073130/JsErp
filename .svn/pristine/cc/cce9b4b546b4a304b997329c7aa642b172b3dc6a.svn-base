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


public partial class jsERP_glym : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string OID = "";
    string IsAdministrator = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);  //链接数据库;
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

    public void bind()
    {
        if (IsAdministrator == "0")
        {
            //先读出页面中B开头的控件并且把控件都变成无效。
            int nPageControls = this.Page.Controls.Count;  //获取页面的控件
            for (int i = 0; i < nPageControls; i++)
            {
                foreach (Control ctl in this.Page.Controls[i].Controls)
                {
                    if (ctl.ID != null)
                    {
                        if (ctl.ID.ToString().Substring(0, 1) == "B")
                        {
                            ((HyperLink)this.Page.FindControl(ctl.ID.ToString())).Enabled = false;
                            ((HyperLink)this.Page.FindControl(ctl.ID.ToString())).CssClass = "button white";
                        }
                    }
                }
            }
            string ObjectID = "";
            //然后通过用户的权限读把有权限的链接变成有效。
            string sqlstr = "SELECT [ObjectID],[Object],[OwnerID]  FROM [Erp_js_Sys].[dbo].[ObjectRegister] where objectid in (SELECT [ObjectID]  FROM [erp_js_data0704].[dbo].[STPermission] where Permission=1 and  oprate='显示' and userid in (SELECT [GroupID]  FROM [erp_js_data0704].[dbo].[STUserGroup] where userid=(SELECT [OID]   FROM [erp_js_data0704].[dbo].[STUsers] where oid=" + OID + ")) )";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sqlcon.Open();
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                ObjectID = "B_" + sdr["ObjectID"].ToString().Trim();
                foreach (Control ctl in this.Page.Controls[3].Controls)
                {
                    if (ctl.ID != null && ObjectID == ctl.ID.ToString()) //
                    {
                        ((HyperLink)this.Page.FindControl(ObjectID)).Enabled = true;
                        ((HyperLink)this.Page.FindControl(ctl.ID.ToString())).CssClass = "button orange";
                        break;

                    }
                }
            }
            sqlcon.Close();
        }


        /*
        string userName = Session["username"].ToString();
        sqlcon.Open();
        string permissionStr = "select top 3 row_number() over ( partition by '' order by JBRQ ) xh,'样品建议书' djmc,'[' +BH+']' + '(' + convert(varchar(20),datediff(day, jbrq, getdate()) + 1) + '天)' ts,count(*) over (partition by '') zts from dbo.js_mfypjysH  a "
           + " where IsDel=0 and (dbo.js_func_hasgroup('样品建议书','" + userName + "',a.fqr,'')=1 and FQBMHQZT='会签中') "
           + " or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','商务经理审核')=1 and SWBHQZT='会签中') "
           + " or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','总经理审核')=1 and ZJLHQZT='会签中') "
           + " or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','技术负责人审核')=1 and XMFZRHQZT='会签中') "
           + " or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','实验室审核')=1 and SYSHQZT='会签中') "
           + " or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','总负责人审核')=1 and ZFZRHQZT='会签中') "
           /*+ " union all "
           + " select top 3 row_number() over ( partition by '' order by JBRQ ) xh,'产品开发提案书' djmc,'[' +BH+']' + '(' + convert(varchar(20),datediff(day, jbrq, getdate()) + 1) + '天)' ts,count(*) over (partition by '') zts from dbo.js_cpkftaH "
           + " where (dbo.js_func_hasgroup('产品开发提案书','" + UserName + "',XSR,'')=1 and XSJLHQZT='会签中') " 
           + " or (dbo.js_func_hasgroup('产品开发提案书','" + userName + "','','商务经理审核')=1 and SWJLHQZT='会签中') "
           + " or (dbo.js_func_hasgroup('产品开发提案书','" + userName + "','','总工审核')=1 and ZGHQZT='会签中') ";
        Cmd = new SqlCommand(permissionStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                if ("样品建议书" == sdr["djmc"].ToString()) {
                    lbYpjysTs.Text = "("+sdr["zts"].ToString()+")条未评审";
                    if ("1" == sdr["xh"].ToString()) {
                        lbYpjys1.Text = sdr["ts"].ToString();
                    } else if ("2" == sdr["xh"].ToString()){
                        lbYpjys2.Text = sdr["ts"].ToString();
                    } else if ("3" == sdr["xh"].ToString()){
                        lbYpjys3.Text = sdr["ts"].ToString();
                    }
                } else if ("产品开发提案书" == sdr["djmc"].ToString()){
                    lbCpkftasTs.Text = "(" + sdr["zts"].ToString() + ")条未评审";
                    if ("1" == sdr["xh"].ToString()){
                        lbCpkftas1.Text = sdr["ts"].ToString();
                    }
                    else if ("2" == sdr["xh"].ToString()){
                        lbCpkftas2.Text = sdr["ts"].ToString();
                    }
                    else if ("3" == sdr["xh"].ToString()){
                        lbCpkftas3.Text = sdr["ts"].ToString();
                    }
                }
            }
        }
        sdr.Close();
        sqlcon.Close();*/
    }
}
