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
using System.Reflection;
using System.Text.RegularExpressions;

public partial class jxkh_pz : System.Web.UI.Page 
{
    DataTable dt = new DataTable();
    string kjny ="";
    decimal sum_sbb = 0;
    decimal sum_gcb = 0;
    decimal sum_zlb = 0;
    decimal sum_gyl = 0;
    decimal sum_jsb = 0;
    decimal sum_zzb = 0;
    decimal sum_swb = 0;
    decimal sum_cwb = 0;
    decimal sum_xzb = 0;
    decimal sum_wab = 0;
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    string GroupName = "";
    string UserName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            GroupName = Session["GroupNames"].ToString();
            UserName = Session["UserName"].ToString();
            kjny = Request.QueryString["kjny"];     //取前页传过来的ID,
            if ((GroupName.IndexOf("超级用户") != -1) || GroupName.IndexOf("部门绩效考核-考核小组") != -1)
            {
                if (kjny == null || kjny == "")         //如果ID不为空则是编辑内容或查看内容
                {
                    sqlcon.Open();
                    string sqlstr = "SELECT kjym  FROM [erp_js_data0704].[dbo].[SYSKJYMH] WHERE djlsh>28 ORDER BY djlsh DESC ";
                    Cmd = new SqlCommand(sqlstr, sqlcon);
                    sdr = Cmd.ExecuteReader();
                    while (sdr.Read())
                    {
                        kjny = sdr["kjym"].ToString();
                        HF_kjny.Value = kjny;
                    }
                    sdr.Close();
                    sqlcon.Close();

                }
                else
                {
                    HF_kjny.Value = kjny;
                }
                Bind(kjny);
                string gxmc = Request.QueryString["gxmc"];

            }
            else
            {
                Response.Write("<script>alert('您没有编辑绩效考核规则的权限!'); window.location.href='jxkh_bmlr.aspx'; </script>");
            }

           
          
        }
       
    }

    protected void Bind(string k)
    {
        string sqlStr = "SELECT *  FROM js_jxkh_tj WHERE kjny='"+k+"'";
        SqlDataAdapter myda = new SqlDataAdapter(sqlStr, sqlcon);
        DataSet myds = new DataSet();
        sqlcon.Open();
        myda.Fill(myds, "js_jxkh_tj");
        GridView1.DataSource = myds;
        GridView1.DataKeyNames = new string[] { "id" };
        GridView1.DataBind();
        sqlcon.Close();
    }



    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        Bind(HF_kjny.Value);
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowIndex >= 0)
        {
            if (e.Row.Cells[3].Text != "&nbsp;")
            {
                sum_sbb += Convert.ToDecimal(e.Row.Cells[3].Text);
            }
            if (e.Row.Cells[4].Text != "&nbsp;")
            {
                sum_gcb += Convert.ToDecimal(e.Row.Cells[4].Text);
            }
            if (e.Row.Cells[5].Text != "&nbsp;")
            {
                sum_zlb += Convert.ToDecimal(e.Row.Cells[5].Text);
            }
            if (e.Row.Cells[6].Text != "&nbsp;")
            {
                sum_gyl += Convert.ToDecimal(e.Row.Cells[6].Text);
            }
            if (e.Row.Cells[7].Text != "&nbsp;")
            {
                sum_jsb += Convert.ToDecimal(e.Row.Cells[7].Text);
            }
            if (e.Row.Cells[8].Text != "&nbsp;")
            {
                sum_zzb += Convert.ToDecimal(e.Row.Cells[8].Text);
            }
            if (e.Row.Cells[9].Text != "&nbsp;")
            {
                sum_swb += Convert.ToDecimal(e.Row.Cells[9].Text);
            }
            if (e.Row.Cells[10].Text != "&nbsp;")
            {
                sum_cwb += Convert.ToDecimal(e.Row.Cells[10].Text);
            }
            if (e.Row.Cells[11].Text != "&nbsp;")
            {
                sum_xzb += Convert.ToDecimal(e.Row.Cells[11].Text);
            }
            if (e.Row.Cells[12].Text != "&nbsp;")
            {
                sum_wab += Convert.ToDecimal(e.Row.Cells[12].Text);
            }
           
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[1].Text = "合计得分：";
            sum_sbb += 100;
            sum_gcb += 100;
            sum_zlb += 100;
            sum_gyl += 100;
            sum_jsb += 100;
            sum_zzb += 100;
            sum_swb += 100;
            sum_cwb += 100;
            sum_xzb += 100;
            sum_wab += 100; 
            e.Row.Cells[3].Text = sum_sbb.ToString() ;
            e.Row.Cells[4].Text = sum_gcb.ToString() ;
            e.Row.Cells[5].Text = sum_zlb.ToString() ;
            e.Row.Cells[6].Text = sum_gyl.ToString() ;
            e.Row.Cells[7].Text = sum_jsb.ToString() ;
            e.Row.Cells[8].Text = sum_zzb.ToString() ;
            e.Row.Cells[9].Text = sum_swb.ToString() ;
            e.Row.Cells[10].Text = sum_cwb.ToString() ;
            e.Row.Cells[11].Text = sum_xzb.ToString() ;
            e.Row.Cells[12].Text = sum_wab.ToString() ;

        }

    }




}
