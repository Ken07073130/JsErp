﻿using System;
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
            sqlcon.Close();
            InitTree_wkgl();
        }
        logout.Attributes.Add("onclick", "javascript:return confirm('确定退出？')");
        L_user.Text = "当前登录用户："+Session["username"].ToString(); 
    }
    protected void logout_Click(object sender, ImageClickEventArgs e)
    {

        Session.RemoveAll();
        Response.Redirect("../Login.aspx");
    }

    protected void InitTree(TreeNodeCollection Nds, string parentID) //用递归方法动态生成节点  
    {
        DataView dv = new DataView();
        TreeNode tmpNode;
        dv.Table = ds.Tables[0];
        dv.RowFilter = "ParentID=" + "'" + parentID + "'";
        foreach (DataRowView drv in dv)
        {
            tmpNode = new TreeNode();
            tmpNode.Value = drv["NodeID"].ToString();
            tmpNode.Text = drv["NodeCaption"].ToString();
            tmpNode.NavigateUrl = "../"+drv["URL"].ToString();
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            Nds.Add(tmpNode);
            this.InitTree(tmpNode.ChildNodes, tmpNode.Value);
        }
    }

    protected void InitTree_wkgl() 
    {
        TreeNode tmpNode;
        
        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1 || GroupID.IndexOf("hasgroup(文控文件维护员)") != -1 || GroupID.IndexOf("hasgroup(文控浏览)") != -1)
        {
            tmpNode = new TreeNode();
            tmpNode.Value = "1";
            tmpNode.Text = "最近更新";
            tmpNode.NavigateUrl = "zjgx.aspx" ;
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);

            tmpNode = new TreeNode();
            tmpNode.Value = "2";
            tmpNode.Text = "文件管理";
            tmpNode.NavigateUrl = "index_wk.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);
        }

        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1 || GroupID.IndexOf("hasgroup(文控文件维护员)") != -1 )
        {
            tmpNode = new TreeNode();
            tmpNode.Value = "3";
            tmpNode.Text = "新加文件管理";
            tmpNode.NavigateUrl = "tjwj.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);

        }
        if (GroupID.IndexOf("hasgroup(文控管理员)") != -1)
        {
            tmpNode = new TreeNode();
            tmpNode.Value = "4";
            tmpNode.Text = "组权限管理";
            tmpNode.NavigateUrl = "yhz.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);

            tmpNode = new TreeNode();
            tmpNode.Value = "5";
            tmpNode.Text = "用户权限管理";
            tmpNode.NavigateUrl = "yhgl.aspx";
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            tmpNode.Expanded = false;                              //默认收拢
            this.TreeView2.Nodes.Add(tmpNode);

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

}
