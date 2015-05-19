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

public partial class ggl : System.Web.UI.Page
{
    protected string nr = "";
    protected string bt = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HF_ID.Value = Request.QueryString["id"];
            Bind();

        }
    }

    protected void Bind()
    {
        sqlcon.Open();
        string sqlstr = "SELECT id,bt,nr from js_tzxx where id=" + HF_ID.Value;  //取出所有的通知标题
        SqlCommand Cmd = new SqlCommand(sqlstr, sqlcon);
        SqlDataReader sdr = Cmd.ExecuteReader();

        while (sdr.Read())
        {
            bt = sdr["bt"].ToString().Trim();
            nr = sdr["nr"].ToString();
        }
        sdr.Close();
        sqlcon.Close();
    }
}
