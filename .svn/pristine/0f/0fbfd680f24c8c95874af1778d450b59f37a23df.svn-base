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

public partial class main : System.Web.UI.MasterPage
{
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    DataSet ds;
    string UserName = "";
    string GroupID = "";
    string GroupNames = ""; //权限组  人事信息权限
    string OID = "";
    string IsAdministrator = "";
    string divPsClosed = "display";//记录cookie 右下角提醒是否被关闭

    protected void Page_Load(object sender, EventArgs e)
    {
        //右下角提醒关闭cookie
        /*if (Request.Cookies["divPsClosed"] != null){
            if (Request.Cookies["divPsClosed"].Values.ToString().Equals("closed")){
                divPsClosed = "none";//不显示
            }
            else {
                divPsClosed = "display";//显示
            }
        }*/
        if (!IsPostBack)
        {
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                GroupNames = Session["GroupNames"].ToString();
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
            sqlcon.Close();
            InitTree_wkgl();
        }

        logout.Attributes.Add("onclick", "javascript:return confirm('确定退出？')");
        L_user.Text = "当前登录用户："+Session["username"].ToString(); 
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
            if ("电子审批流" == nodeCaption.Trim()) {
                string userName = Session["username"].ToString();
                string sqlstr = " select psd,ts,sum(ts)  over (partition by '' ) zts from ( " +
                                     " select  '样品建议书' psd,count(*) ts " +
                                     " from    js_ypjysH a" +
                                     " where  '超级用户'='" + GroupNames + "'  " +
                                     "     or a.FQR='" + UserName + "'" +
                                     "     or (dbo.js_func_hasgroup('样品建议书','" + UserName + "',a.FQR,'')=1 and FQBMHQZT='会签中') " +
                                     "     or (charindex('样品建议书新-商务经理审核','" + GroupNames + "')>0 and SWBHQZT='会签中' ) " +
                                     "     or (charindex('样品建议书新-商务经理审核','" + GroupNames + "')>0 and lchqzt like '%已完成%') " +
                                     "     or (charindex('样品建议书新-总经理助理审核','" + GroupNames + "')>0  and ZJLHQZT='会签中' ) " +
                                     "     or (charindex('样品建议书新-实验室审核','" + GroupNames + "')>0 and SYSHQZT='会签中' ) " +
                                     //暂时不加业务员的对应关系
                                     "     or (charindex('样品建议书新-技术负责人审核','" + GroupNames + "')>0 and XMFZRHQZT='会签中' ) " +
                                     "     or (charindex('样品建议书新-总负责人','" + GroupNames + "')>0  and ZFZRHQZT='会签中' )   " +
                                     "  union all " +
                                     "  select '产品开发提案' psd,count(*) ts " +
                                     " from dbo.js_cpkftaH a " +
                                     " where  '超级用户'='" + GroupNames + "'  or  a.XSRY='" + UserName + "'" +
                                     "     or (dbo.js_func_hasgroup('产品开发提案','" + UserName + "',a.XSRy,'')=1 and XSJLHQZT='会签中') " +
                                     "     or (charindex('产品开发提案-商务经理审核','" + GroupNames + "'  )>0 and SWJLHQZT='会签中' ) " +
                                     "     or (charindex('产品开发提案-总工审核','" + GroupNames + "'  )>0 and ZGHQZT='会签中' ) " +
                                     "     or (charindex('产品开发提案-工程师','" + GroupNames + "'  )>0  ) " +

                               " ) x where ts<>0 ";
                //sqlcon.Open();
                SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
                SqlDataReader sdr = cmd.ExecuteReader();


               
                if (sdr.HasRows) {
                    while (sdr.Read()) {
                        if (!sdr["zts"].ToString().Trim().Equals("0")){
                            nodeCaption = nodeCaption + "(" + sdr["zts"].ToString() + ")";
                            divDjshMessage.Style.Add("display", divPsClosed);
                            //总条数只需要执行一次
                            break;
                        }
                    }
                }
                sdr.Close();

                //填充未评审条数的框
                /*
                SqlDataAdapter myda = new SqlDataAdapter(sqlstr, sqlcon);
                DataSet myds = new DataSet();
                myda.Fill(myds);
                GridView1.DataSource = myds;
                GridView1.DataBind();*/


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
        if (IsAdministrator=="1")
        {
            sqlstr = "SELECT *  FROM [Erp_js_Sys].[dbo].[Tree]";
        }else{
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
