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
using System.Data.SqlClient;

public partial class wkzt_SearchFile : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string GradationID = "";
    string IsDownload = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string SearchFile = Request.QueryString["Searchfile"];
            string SearchPath = Request.QueryString["SearchPath"];
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                UserID.Value = Session["UserID"].ToString();
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

            SearchGetDir(SearchFile, SearchPath);
        }
    }


    public void SearchGetDir(string _SearchFile,string _Path)
    {
        string hzm = "";
        int wjcs = 0;
        DirectoryInfo dires;
        FileInfo[] files;
        Hashtable HT_FileName = new Hashtable();
        //先判断需要查询的路径是在几层目录下面
        string[] Count_Path = _Path.Split('\\');
        if (Count_Path.Length == 2)  
        {
            wjcs = 0;   //表示在根目录下
        }
        else if (Count_Path.Length == 3)
        {
            wjcs = 1;   //表示在第一层目录下
        }
        else if (Count_Path.Length > 3)
        {
            wjcs = 2;   //表示在第二以上
        }
        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("mc"));
        table.Columns.Add(new DataColumn("FullName"));
        table.Columns.Add(new DataColumn("xz"));
        table.Columns.Add(new DataColumn("gxrq"));
        table.Columns.Add(new DataColumn("dx"));
        table.Columns.Add(new DataColumn("ImgURL"));
        //如果已经在两层目录下面的话直接查询，不用判断权限了
        if (wjcs == 2)
        {
            //跟目录文件路径+根目录下有权限查看的文件夹下查询需要搜索的关键字
            dires = new DirectoryInfo(_Path); 
            //开始查询，只查询当前文件夹下的内容，不包含子文件夹的内容
            files = dires.GetFiles("*" + _SearchFile + "*", SearchOption.AllDirectories);

            //遍历查询出来的内容来写入列表
            foreach (FileInfo f in files)
            {
                DataRow sourseRow = table.NewRow();
                string qzm = "";  //前缀名
                if (f.FullName.IndexOf("文控管理\\作废文件") != -1)
                {
                    qzm = "【作废】";
                }

                //if (f.Name.Length > 53)
                //{
                //    sourseRow["mc"] = qzm + f.Name.Substring(0, 53 - qzm.Length) + "...";
                //}
                //else
                //{
                    sourseRow["mc"] = qzm + f.Name;
                //}
                sourseRow["FullName"] = f.FullName;
                sourseRow["xz"] = "";
                sourseRow["gxrq"] = f.LastWriteTime;
                sourseRow["dx"] = f.Length / 1024 + "KB";
                //获取文件后缀名
                char[] delimiterChars = { '.', '\\' };
                string[] Mystr = Path.GetExtension(f.Name.ToString()).Split(delimiterChars);
                hzm = Mystr[Mystr.Length - 1];
                //根据后缀名获取图标


                sourseRow["ImgURL"] = "../images/file/" + hzm + ".gif";
                table.Rows.Add(sourseRow);
            }
        }
        else
        {
            SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
            sqlcon.Open();   //取出用户所在用户组里面的相应的用户权限
            string sqlstr = "SELECT GradationID,IsDownload from dbo.WK_UserGroup WHERE CHARINDEX(CONVERT(VARCHAR(10),id),(SELECT wkqx  FROM [erp_js_data0704].[dbo].[STUsers] WHERE UserID='" + UserID.Value + "'))>0";
            SqlCommand Cmd = new SqlCommand(sqlstr, sqlcon);
            SqlDataReader sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                GradationID += sdr["GradationID"].ToString().Trim() + ";";
                IsDownload += sdr["IsDownload"].ToString().Trim() + ";";
            }
            sdr.Close();
            //去掉最后的分号
            GradationID = GradationID.Substring(0, GradationID.Length - 1);
            IsDownload = IsDownload.Substring(0, IsDownload.Length - 1);


            //取出有权限打开的文件夹的名字
            sqlstr = "SELECT [ID],[FileName],[FirstFileID],[ParentID] FROM [erp_js_data0704].[dbo].[WK_FileGroup] WHERE   FirstFileID !=1 AND FirstFileID != 2 and id in (" + GradationID.Replace(";", ",") + ")  order by ParentID asc";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {

                if (sdr["ParentID"].ToString().Trim() == "0")    //如果ParentID=0就是跟目录下的文件夹
                {
                    //把这一层有权限的文件夹和对于的ID写到哈希表里面以供在下一层目录查询的时候对照权限。
                    HT_FileName.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
                    //如果是根目录下才开始搜索相应的文件
                    if (wjcs == 0)  //0表示在跟目录下
                    {
                        //跟目录文件路径+根目录下有权限查看的文件夹下查询需要搜索的关键字
                        dires = new DirectoryInfo(ConfigurationManager.AppSettings["StartingPath"] + "\\" + sdr["FileName"].ToString().Trim());
                        if (Directory.Exists(dires.FullName) == true)//如果文件夹存在才看
                        {
                            //开始查询，只查询当前文件夹下的内容，不包含子文件夹的内容
                            files = dires.GetFiles("*" + _SearchFile + "*", SearchOption.TopDirectoryOnly);

                            //遍历查询出来的内容来写入列表
                            foreach (FileInfo f in files)
                            {
                                DataRow sourseRow = table.NewRow();
                                string qzm = "";  //前缀名
                                if (f.FullName.IndexOf("文控管理\\作废文件") != -1)
                                {
                                    qzm = "【作废】";
                                }

                                //if (f.Name.Length > 53)
                                //{
                                //    sourseRow["mc"] = qzm + f.Name.Substring(0, 53 - qzm.Length) + "...";
                                //}
                                //else
                                //{
                                sourseRow["mc"] = qzm + f.Name;
                                //}
                                sourseRow["FullName"] = f.FullName;
                                sourseRow["xz"] = "";
                                sourseRow["gxrq"] = f.LastWriteTime;
                                sourseRow["dx"] = f.Length / 1024 + "KB";
                                //获取文件后缀名
                                char[] delimiterChars = { '.', '\\' };
                                string[] Mystr = Path.GetExtension(f.Name.ToString()).Split(delimiterChars);
                                hzm = Mystr[Mystr.Length - 1];
                                //根据后缀名获取图标


                                sourseRow["ImgURL"] = "../images/file/" + hzm + ".gif";
                                table.Rows.Add(sourseRow);


                            }
                        }
                    }
                        
                }
                else
                {
                    foreach (DictionaryEntry H_f in HT_FileName)  //遍历文件夹是否在数据库里面有记录
                    {
                        if (H_f.Key.ToString() == sdr["ParentID"].ToString().Trim())
                        {
                            //拼出需要查询的文件路径
                            dires = new DirectoryInfo(ConfigurationManager.AppSettings["StartingPath"] + "\\" + H_f.Value.ToString() + "\\" + sdr["FileName"].ToString().Trim());
                            //开始查询查询当前文件夹下所有文件的内容，包含子文件夹的内容。
                            if (Directory.Exists(dires.FullName ) == true)//如果文件夹存在才看
                            {

                                files = dires.GetFiles("*" + _SearchFile + "*", SearchOption.AllDirectories);
                                //遍历出所有的文件
                                foreach (FileInfo f in files)
                                {
                                    DataRow sourseRow = table.NewRow();
                                    string qzm = "";  //前缀名
                                    if (f.FullName.IndexOf("文控管理\\作废文件") != -1)
                                    {
                                        qzm = "【作废】";
                                    }

                                    //if (f.Name.Length > 53)
                                    //{
                                    //    sourseRow["mc"] = qzm + f.Name.Substring(0, 53 - qzm.Length) + "...";
                                    //}
                                    //else
                                    //{
                                    sourseRow["mc"] = qzm + f.Name;
                                    //}
                                    sourseRow["FullName"] = f.FullName;
                                    sourseRow["xz"] = "";
                                    sourseRow["gxrq"] = f.LastWriteTime;
                                    sourseRow["dx"] = f.Length / 1024 + "KB";
                                    //获取文件后缀名
                                    char[] delimiterChars = { '.', '\\' };
                                    string[] Mystr = Path.GetExtension(f.Name.ToString()).Split(delimiterChars);
                                    hzm = Mystr[Mystr.Length - 1];
                                    //根据后缀名获取图标

                                    sourseRow["ImgURL"] = "../images/file/" + hzm + ".gif";
                                    table.Rows.Add(sourseRow);


                                }
                                break;
                            }
                        }

                    }
                }
                
            }

            sdr.Close();
            sqlcon.Close();
        }
        DataRow newRow = table.NewRow(); 
        table.Rows.Add(newRow);
        GridView1.DataSource = table;
        GridView1.DataBind();
        

    }








    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[4].Visible = false;  //使第5列不可见,则将它的可见性设为false
        //可以根据需要设置更多的列
    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "wjlj")
        {
            string dz = e.CommandArgument.ToString () ;
            //string dz = ((LinkButton)sender).CommandArgument;
            string FullName = "";
            if (dz.LastIndexOf("||") > 0)
            {
                FullName = dz.Substring(0, dz.LastIndexOf("||"));
            }
            else
            {
                FullName = dz;
            }

                if (Path.GetExtension(dz).Equals(".swf") || Path.GetExtension(dz).Equals(".pdf"))
                {
                    Response.Redirect("ShowPDF.aspx?URL=" + dz); //urlconvertor(dz).Substring(urlconvertor(dz).IndexOf("文控管理")));
                }
                else
                {
                    string fileName = Path.GetFileName(dz); //客户端保存的文件名 
                    string filePath = dz;//路径

                    //以字符流的形式下载文件 
                    FileStream fs = new FileStream(filePath, FileMode.Open);
                    byte[] bytes = new byte[(int)fs.Length];
                    fs.Read(bytes, 0, bytes.Length);
                    fs.Close();
                    Response.ContentType = "application/octet-stream";
                    //通知浏览器下载文件而不是打开 
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
                    Response.BinaryWrite(bytes);
                    Response.Flush();
                    Response.End();
                }

           
            }
        }

    protected void SearchClick(object sender, EventArgs e)
    {
        SearchGetDir(SearchName.Text.Trim(), ConfigurationManager.AppSettings["StartingPath"]);
    }
}
