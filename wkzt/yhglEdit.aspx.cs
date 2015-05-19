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
using System.Net.Mail;

public partial class wkzt_yhglEdit : System.Web.UI.Page
{
    string UserName = "";
    string Group_ID = "";
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    SqlCommand Cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                Group_ID = Session["GroupID"].ToString();
                if (Group_ID.IndexOf("hasgroup(文控管理员)") == -1)
                {
                    Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }

            string id  = Request.QueryString["id"];
            sqlcon.Open();
            string sqlstr = "SELECT *  FROM [erp_js_data0704].[dbo].[STUsers] where oid =" + id + "";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                this.GROUPID.Value = sdr["wkqx"].ToString().Trim();
                //this.GroupName.Text = sdr["GroupName"].ToString().Trim();
                H_OID.Value = sdr["oid"].ToString().Trim();
            }
            sdr.Close();
            sqlcon.Close();

            bind();
        }
    }

    public void bind()
    {
        sqlcon.Open();
        string sqlstr = "SELECT ID,GroupName,GradationID=( CASE WHEN LEN(GradationID)>30 THEN SUBSTRING(GradationID,0,60)+'...' ELSE GradationID END  ),IsDownload=( CASE WHEN LEN(IsDownload)>30 THEN SUBSTRING(IsDownload,0,60)+'...' 	ELSE IsDownload END  )  FROM  [erp_js_data0704].[dbo].[WK_UserGroup] ";
        sqlcom = new SqlCommand(sqlstr, sqlcon);   //调用存储过程
        SqlDataAdapter adapter = new SqlDataAdapter(sqlcom);      //数据适配器
        DataSet ds = new DataSet();                            //数据集
        adapter.Fill(ds, "WK_UserGroup");
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "ID" };    //绑定的字段名(显示的文字)
        GridView1.DataBind();

    }




    protected void Button_Click(object sender, EventArgs e)
    {
        //TextBox zm = (TextBox)GridView1.FooterRow.FindControl("T_ZM");
        string sqlstr = "update [erp_js_data0704].[dbo].[STUsers] set wkqx='" + HiddenField1.Value + "'   where oid='" + H_OID.Value + "'";
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();
        SendEmail(H_OID.Value);
        Response.Write("<script>alert('权限设置成功!');self.location='yhgl.aspx';</script>");


    }


    private static void SendEmail(string UserID)
    {
        try
        {
            SqlConnection sqlcon_mail = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
            SqlCommand Cmd_mail;
            SqlDataReader sdr_mail;
            string sql_mail;
            string EmailSend = ConfigurationManager.AppSettings["EmailAddress"];
            string SendName = ConfigurationManager.AppSettings["FileName"];
            string toAddress = "";
            string UserName = "";
            MailAddress from;
            MailMessage mail;
            SmtpClient client;

            sqlcon_mail.Open(); //打开数据库的链接
            sql_mail = "select * from [erp_js_data0704].[dbo].[STUsers] where oid= " + UserID;
            Cmd_mail = new SqlCommand(sql_mail, sqlcon_mail);
            sdr_mail = Cmd_mail.ExecuteReader();
            while (sdr_mail.Read())
            {
                toAddress = sdr_mail["UserDesc"].ToString();
                UserName = sdr_mail["UserName"].ToString().Trim();
            }
            sdr_mail.Close();
            sqlcon_mail.Close();

            from = new MailAddress(EmailSend, SendName);
            //邮件的发件人
            mail = new MailMessage();
            //设置邮件的标题
            mail.Subject = "您的文控系统的权限已经被修改！";
            mail.From = from;
            mail.To.Add(toAddress);      //new MailAddress("jswt@ftjt.net"));


            //设置邮件的内容
            mail.Body = "您好" + UserName + "：</br></br>您的文控系统的权限已经被修改请登录后查看。</br>如有问题请于管理员联系！";


            

            //设置邮件的格式
            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.IsBodyHtml = true;
            //设置邮件的发送级别
            mail.Priority = MailPriority.Normal;
            mail.DeliveryNotificationOptions = DeliveryNotificationOptions.OnSuccess;

             client = new SmtpClient(ConfigurationManager.AppSettings["smtp"],25);
            //client.EnableSsl = true;
            //设置用于 SMTP 事务的主机的名称，填IP地址也可以了
            //client.Host = ConfigurationManager.AppSettings["smtp"];//"ftjt.net"; //
            //设置用于 SMTP 事务的端口，默认的是 25
            //client.Port = 25;
            client.UseDefaultCredentials = false;
            //这里才是真正的邮箱登陆名和密码，比如我的邮箱地址是 hbgx@hotmail， 我的用户名为 hbgx ，我的密码是 xgbh
            client.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["UserName"], ConfigurationManager.AppSettings["Password"]);
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            //都定义完了，正式发送了，很是简单吧！
            client.Send(mail);

            


        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
    }

}
