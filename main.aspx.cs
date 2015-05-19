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


public partial class main : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    DataSet ds;
    string UserName = "";
    string GroupID = "";
    string OID = "";
    string IsAdministrator = "";


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

            sqlcon.Open();
            this.createDataSet();
            this.InitTree(TreeView1.Nodes, "11");
            TreeView1.Target = "main";
            TreeView2.Target = "main";
            sqlcon.Close();
            InitTree_wkgl();
        }

        logout.Attributes.Add("onclick", "javascript:return confirm('确定退出？')");
        L_user.Text = "当前登录用户：" + Session["username"].ToString();
    }
    protected void logout_Click(object sender, ImageClickEventArgs e)
    {

        Session.RemoveAll();
        Response.Redirect("Login.aspx");
    }

    protected void InitTree(TreeNodeCollection Nds, string parentID) //用递归方法动态生成节点  
    {
        DataView dv = new DataView();
        TreeNode tmpNode;
        string nodeCaption = "";
        dv.Table = ds.Tables[0];
        dv.RowFilter = "ParentID=" + "'" + parentID + "'";
        foreach (DataRowView drv in dv)
        {
            tmpNode = new TreeNode();
            tmpNode.Value = drv["NodeID"].ToString();
            nodeCaption = drv["NodeCaption"].ToString();
            //电子审批流要加未评审条数
            if ("电子审批流" == nodeCaption.Trim())
            {
                string userName = Session["username"].ToString();
                string sqlstr = " select psd,ts,sum(ts)  over (partition by '' ) zts from ( "
                                 + "            select '样品建议书' psd,count(*) ts  from dbo.js_mfypjysH a "
                                 + "                  where  IsDel=0 and (dbo.js_func_hasgroup('样品建议书','" + userName + "',a.fqr,'')=1 and FQBMHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','商务经理审核')=1 and SWBHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','总经理审核')=1 and ZJLHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','技术负责人审核')=1 and XMFZRHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','实验室审核')=1 and SYSHQZT='会签中') "
                                 + "                  or (dbo.js_func_hasgroup('样品建议书','" + userName + "','','总负责人审核')=1 and ZFZRHQZT='会签中') "
                                 + " ) x where ts<>0 ";
                //sqlcon.Open();
                SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
                SqlDataReader sdr = cmd.ExecuteReader();



                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        if (!sdr["zts"].ToString().Trim().Equals("0"))
                        {
                            nodeCaption = nodeCaption + "(" + sdr["zts"].ToString() + ")";

                            //总条数只需要执行一次
                            break;
                        }
                    }
                }
                sdr.Close();



                // sqlcon.Close();
            }
            tmpNode.Text = nodeCaption;
            tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            Nds.Add(tmpNode);
            this.InitTree(tmpNode.ChildNodes, tmpNode.Value);
        }
    }



    private DataSet createDataSet()
    { //oprate='显示' and 
        string sqlstr = "";
        if (IsAdministrator == "1")
        {
            sqlstr = "SELECT *  FROM [Erp_js_Sys].[dbo].[Tree]";
        }
        else
        {
            sqlstr = "SELECT *  FROM [Erp_js_Sys].[dbo].[Tree] where objectid in (SELECT [ObjectID]  FROM [erp_js_data0704].[dbo].[STPermission] where Permission=1 and  userid in (SELECT [GroupID]  FROM [erp_js_data0704].[dbo].[STUserGroup] 	where userid=(SELECT [OID]   FROM [erp_js_data0704].[dbo].[STUsers] where oid=" + OID + ")) )";
        }

        SqlDataAdapter cmdSelect = new SqlDataAdapter(sqlstr, sqlcon);
        ds = new DataSet();
        cmdSelect.Fill(ds, "Tree");
        return ds;

    }

    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
    {

    }
    protected void InitTree_wkgl()
    {
        TreeNode tmpNode;

        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1 || GroupID.IndexOf("hasgroup(文控文件维护员)") != -1 || GroupID.IndexOf("hasgroup(文控浏览)") != -1)
        {
            tmpNode = new TreeNode();
            tmpNode.Value = "1";
            tmpNode.Text = "最近更新";
            tmpNode.NavigateUrl = "wkzt/zjgx.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);

            tmpNode = new TreeNode();
            tmpNode.Value = "2";
            tmpNode.Text = "文件管理";
            tmpNode.NavigateUrl = "wkzt/index_wk.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);
        }

        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1 || GroupID.IndexOf("hasgroup(文控文件维护员)") != -1)
        {
            tmpNode = new TreeNode();
            tmpNode.Value = "3";
            tmpNode.Text = "新加文件管理";
            tmpNode.NavigateUrl = "wkzt/tjwj.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);

        }
        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1)
        {
            tmpNode = new TreeNode();
            tmpNode.Value = "4";
            tmpNode.Text = "组权限管理";
            tmpNode.NavigateUrl = "wkzt/yhz.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);

            tmpNode = new TreeNode();
            tmpNode.Value = "5";
            tmpNode.Text = "用户权限管理";
            tmpNode.NavigateUrl = "wkzt/yhgl.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);

        }


    }
}
