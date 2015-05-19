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
using System.IO;
using System.Diagnostics;
using System.Data.SqlClient;



public partial class wkzt_ShowPDF : System.Web.UI.Page
{
    public string FileURL;
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    string UserID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string VirtualPath = "";
        string URL = Request.QueryString["URL"];     //获取前一页传递过来的需要打开的PDF文件的路径
        string StartingPath = ConfigurationManager.AppSettings["StartingPath"];
        string OpenURL = URL.Replace(StartingPath, StartingPath + "\\SWF");      //把路径转换成SWF文件所存放的文件夹
        string UserName = "";
        string GroupID = "";
        if (Session["username"] != null)
        {
            //先检查权限没有权限就返回
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            UserID = Session["UserID"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();
            if (GroupID.IndexOf("hasgroup(文控管理员)") == -1 && GroupID.IndexOf("hasgroup(文控文件维护员)") == -1 && GroupID.IndexOf("hasgroup(文控浏览)") == -1)
            {
                Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
            }
        }
        else
        {
            Response.Redirect("../Login.aspx");
        }


        OpenURL = OpenURL.Replace(".pdf", ".swf");
        if (PurviewJudge(OpenURL) == 1)
        {

            if (File.Exists(OpenURL))   //判断相对应的swf文件是否存在 存在的话直接转换为相对路径
            {  //绝对路径转换为相对路径后传给页面的变量
                VirtualPath = OpenURL.Replace(StartingPath, "..\\wk");
                FileURL = VirtualPath.Replace("\\", "//");
            }
            else
            {

                ConvertCmd(URL);   //不存在的话先转换一个swf文件  
                //绝对路径转换为相对路径后传给页面的变量
                VirtualPath = OpenURL.Replace(StartingPath, "..\\wk");
                FileURL = VirtualPath.Replace("\\", "//");
            }

        }
        else
        {
            Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
        }
    }

    private static void ConvertCmd(string url)
    {
        string fileName = Path.GetFileName(url);
        string StartingPath = ConfigurationManager.AppSettings["StartingPath"];      //获取文控系统的起始路径
        string path = url.Remove(url.LastIndexOf("\\"));
        using (Process p = new Process())
        {
            string cmdStr = HttpContext.Current.Server.MapPath("~/SWFTools/pdf2swf.exe");
            string savePath = path.Replace(StartingPath, StartingPath + "\\SWF");
            // @"""" 相当于一个双引号，之所以要加@"""" 就是为了防止要转换的过程中，文件夹名字带有空格，导致失败
            string sourcePath = @"""" + path + "\\" + fileName + @"""";
            string targetPath = @"""" + savePath + "\\" + fileName.Substring(0, fileName.LastIndexOf(".")) + ".swf" + @"""";
            string newFile = targetPath.Substring(1,targetPath.LastIndexOf("\\"));

            if (!Directory.Exists(newFile))//判断文件夹是否已经存在
            {
                Directory.CreateDirectory(newFile);//创建文件夹
            }

            string argsStr = "  -t " + sourcePath + " -s flashversion=9 -o " + targetPath;
            //调用新进程 进行转换
            ProcessStartInfo psi = new ProcessStartInfo(cmdStr, argsStr);
            p.StartInfo = psi;
            p.Start();
            p.WaitForExit();
        }
    }

    protected void logout_Click(object sender, ImageClickEventArgs e)
    {
        //清空session后返回到登录页。
        Session.RemoveAll();         
        Response.Redirect("Login.aspx");
    }

    public int   PurviewJudge(string path)
    {
        Hashtable HT_FileName = new Hashtable();
        Hashtable HT_ParentID = new Hashtable();
        int returnPJ = 0;
        string GradationID = "";
        string zqx = "";
        string wjjid = "";
        string tmp = path.Substring(path.IndexOf("\\SWF\\")+5);
        string Folder1 = tmp.Split('\\')[0].ToString();
        string Folder2 = tmp.Split('\\')[1].ToString();
        int tmpJS = Folder2.IndexOf(".swf");
        int wjjcs = 1;                          //文件夹层数默认情况下是1层
        if (tmpJS == -1)
        {
            wjjcs = 2;
        }

        sqlcon.Open();   //取出用户所在用户组里面的相应的用户权限
        string sqlstr = "SELECT wkqx  FROM [erp_js_data0704].[dbo].[STUsers] WHERE UserID='" + UserID + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            zqx = sdr["wkqx"].ToString().Trim();
        }
        sdr.Close();

        sqlstr = "SELECT GradationID from dbo.WK_UserGroup WHERE id in (" + zqx + ")";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            GradationID += sdr["GradationID"].ToString().Trim() + ";";
        }
        sdr.Close();
        GradationID = GradationID.Substring(0, GradationID.Length - 1);

        sqlstr = "SELECT [ID],[FileName],[FirstFileID],[ParentID] FROM [erp_js_data0704].[dbo].[WK_FileGroup] WHERE   FirstFileID !=1 AND FirstFileID != 2 and id in (" + GradationID.Replace(";", ",") + ")";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            HT_FileName.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
            HT_ParentID.Add(sdr["ID"].ToString().Trim(), sdr["ParentID"].ToString().Trim());
        }
        returnPJ = 0; //返回值是零表示没有权限查看本页面
        foreach (string id in HT_FileName.Keys)
        {
            if (HT_ParentID[id].ToString() == "0")
            {
                if (Folder1 == HT_FileName[id].ToString())
                {
                    returnPJ = 1;    //如果有权限则改为一
                    wjjid=id;
                    break;
                }
            }
        }

        if (wjjcs == 2)
        {
            returnPJ = 0;   //如果有第二层目录则把返回值重置为0
            foreach (string id in HT_FileName.Keys)
            {
                if (HT_ParentID[id].ToString() == wjjid)
                {
                    if (Folder2 == HT_FileName[id].ToString())
                    {
                        returnPJ = 1;  //如果有权限则改为一
                        break;
                    }
                }
            }
        }

        sdr.Close();
        sqlcon.Close();

        return returnPJ;

    }

}


