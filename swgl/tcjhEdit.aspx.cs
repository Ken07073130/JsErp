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

public partial class swgl_tcjhEdit : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string ddlsh = "";
    int newrow = 0;
    SqlConnection sqlcon;
    SqlCommand sqlcom;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            ddlsh = Request.QueryString["ddlsh"];
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();
        }
        else
        {
            Response.Redirect("Login.aspx");
        }

        bind();


    }

    public void bind()
    {
        string sqlStr = "";
        string djlsh = "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcon.Open();
        SqlCommand Cmd;
        SqlDataReader sdr;
        sqlStr = "select * from [erp_js_data0704].[dbo].[js_tcjhH] where ddlsh='" + ddlsh +"'";
        Cmd = new SqlCommand(sqlStr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            djlsh           = sdr["djlsh"].ToString().Trim();
            T_DXXH.Text     = sdr["DXXH"].ToString().Trim();
            T_XHDM.Text     = sdr["XHDM"].ToString().Trim();
            T_KHDM.Text     = sdr["khdm"].ToString().Trim();
            T_packXH.Text   = sdr["PACKXH"].ToString().Trim();
            T_DDLSH.Text    = sdr["DDLSH"].ToString().Trim();
           
            T_KHXH.Text     = sdr["KHXH"].ToString().Trim();
            T_DDZSL.Text    = sdr["DDZSL"].ToString().Trim();
            T_PCZSL.Text    = sdr["PCZSL"].ToString().Trim();
            T_LRR.Text      = sdr["LLR"].ToString().Trim();
            T_LRRQ.Text     = sdr["LRRQ"].ToString().Trim();
                

        }
        sdr.Close();
        


        sqlStr = //"select  '新增' bh,null jbrq,null khdm,null FQR,null FQSHR,null FQRHQZT,null FQBMHQZT,null SWBHQZT,null  XMFZRHQZT,null  ZFZRHQZT" +
            //" union all " +
                 "select * FROM [erp_js_data0704].[dbo].[js_tcjhB] where djlsh="+ djlsh+" order by DjBth  ";

        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        
        myda.Fill(myds, "js_tcjhB");

        GV_BT.DataSource = myds;
        GV_BT.DataKeyNames = new string[] { "DjBth" };
        GV_BT.DataBind();


        sqlStr = //"select  '新增' bh,null jbrq,null khdm,null FQR,null FQSHR,null FQRHQZT,null FQBMHQZT,null SWBHQZT,null  XMFZRHQZT,null  ZFZRHQZT" +
            //" union all " +
                 "select * FROM [erp_js_data0704].[dbo].[js_tcjhF] where djlsh=" + djlsh + " order by DjFth  ";

        myda = new SqlDataAdapter(sqlStr, sqlcon);
        myds = new DataSet();
        myda.Fill(myds, "js_tcjhF");

        GV_FT.DataSource = myds;
        GV_FT.DataKeyNames = new string[] { "DjFth" };
        GV_FT.DataBind();





        sqlcon.Close();

    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string sqlstr = "update  js_mfypjysH set  isDel=1,bh='(删除)'+bh where bh=" + GV_BT.DataKeys[e.RowIndex].Value.ToString() + "";
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        bind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Response.Redirect("tcjhEdit.aspx");
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow) {
        //    LinkButton btnEdit = (LinkButton)e.Row.Cells[1].Controls[0];//编辑
        //    LinkButton btnDel  = (LinkButton)e.Row.Cells[2].Controls[0];//删除
        //    if (ddlHqzt.Text != "会签中"){//只有会签中的记录才能更改
        //        btnEdit.Text = "查看";
        //        btnDel.Enabled = false;
        //    } else if ("会签中"==ddlHqzt.Text){
        //        btnEdit.Text = "编辑";
        //        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
        //        sqlcon.Open();
        //        String sqlstr = "select dbo.js_func_hasgroup('样品建议书','"+Session["username"].ToString()+"','','发起人') qx ";
        //        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        //        SqlDataReader sdr = cmd.ExecuteReader();
        //        if (sdr.HasRows) {
        //            while (sdr.Read()) {
        //                if ("1" == sdr["qx"].ToString()){
        //                    btnDel.Enabled = true;//只有发起人有删除权限
        //                }
        //                else {
        //                    btnDel.Enabled = false;//不是发起人不能删除单据
        //                }
        //            }
        //        }
        //        sqlcon.Close();
        //        sdr.Close();
        //        btnDel.Attributes.Add("onclick ", "return confirm( '确定删除记录(编号: " + (e.Row.Cells[0].Text) + " 吗)'); "); 

        //    }


        //}
        //foreach (TableCell tc in e.Row.Cells)
        //{
        //    tc.Attributes["style"] = "border-color:Black";
        //}
    }

    protected void tjbd_Click(object sender, EventArgs e)
    {
        sqlcon.Open();
        String sqlstr = "select dbo.js_func_hasgroup('样品建议书','" + Session["username"].ToString() + "','','发起人') qx ";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = cmd.ExecuteReader();
        if (sdr.HasRows)
        {
            while (sdr.Read())
            {
                if ("1" == sdr["qx"].ToString())
                {
                    Response.Redirect("ypjysEdit.aspx?lb=ADD");//只有发起人才能新建表单
                }
                else
                {
                    Response.Write("<script>alert('您没有添加样品建议书的权限!');</script>");
                }
            }
        }
        sqlcon.Close();
        sdr.Close();
        bind();

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GV_BT.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void lbtnAddRow_Click(object sender, EventArgs e)
    {
        DataTable table = GetGridViewData();
        DataRow newRow = table.NewRow();
        newRow["DjBth"] = newrow + 1;
        table.Rows.Add(newRow);
        GV_BT.DataSource = table;
        GV_BT.DataBind();
    }

    private DataTable GetGridViewData()
    {
        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("DjBth"));
        table.Columns.Add(new DataColumn("DJXH"));
        table.Columns.Add(new DataColumn("DDH"));
        table.Columns.Add(new DataColumn("DDSL"));
        table.Columns.Add(new DataColumn("DJSJ"));
        table.Columns.Add(new DataColumn("PSDH"));
        foreach (GridViewRow row in GV_BT.Rows)
        {
            DataRow sourseRow = table.NewRow();
             
            sourseRow["DjBth"]  = row.Cells[1].Text;
            sourseRow["DJXH"] = ((TextBox)row.Cells[2].FindControl("DJXH")).Text;// row.Cells[2].Text; //((TextBox)row.Cells[3].FindControl("txtName")).Text;
            sourseRow["DDH"]    = row.Cells[3].Text; //((TextBox)row.Cells[4].FindControl("txtUsuallyResults")).Text;
            sourseRow["DDSL"]   = row.Cells[4].Text; //((TextBox)row.Cells[5].FindControl("txtExamResults")).Text;
            sourseRow["DJSJ"]   = row.Cells[5].Text;
            sourseRow["PSDH"]   = row.Cells[6].Text;
            table.Rows.Add(sourseRow);
            newrow = Int32.Parse ( row.Cells[1].Text.ToString());
        }
        return table;
    }

    protected void btnDeleteRow_Click(object sender, EventArgs e)
    {
        DataTable table = GetGridViewData();

        foreach (GridViewRow row in GV_BT.Rows)
        {
            if (((HtmlInputCheckBox)row.Cells[2].FindControl("chkRow")).Checked)
            {
                foreach (DataRow dtRow in table.Rows)
                {
                    if (dtRow["ID"].ToString() == row.Cells[0].Text)
                    {
                        table.Rows.Remove(dtRow);
                        break;
                    }
                }
            }
        }

        GV_BT.DataSource = table;
        GV_BT.DataBind();
    }

}
