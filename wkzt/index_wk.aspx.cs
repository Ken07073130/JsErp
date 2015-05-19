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

public partial class wkzt_index_wk : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand Cmd;
    SqlDataReader sdr;
    string UserName = "";
    string GroupID = "";
    string GradationID = "";
    string IsDownload = "";
    string sx = "";
    //string OldID = "";
    string ParentID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ParentID  = Request.QueryString["ParentID"];
            WJCC.Value = Request.QueryString["WJCC"];
            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                UserID.Value = Session["UserID"].ToString();
                if (GroupID.IndexOf("hasgroup(文控管理员)") == -1 && GroupID.IndexOf("hasgroup(文控文件维护员)") == -1 && GroupID.IndexOf("hasgroup(文控浏览)") == -1)
                {
                    Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
                }
                
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
            
            

            BindGetDir(ConfigurationManager.AppSettings["StartingPath"]); 
            NowPath.Value = ConfigurationManager.AppSettings["StartingPath"];
        }
    }


    public void BindGetDir(string path)
    {
        if ( WJCC.Value=="")    //文件的ParentID 在没有找到的情况下默认是0 文件层数WJCC也是0
        {
            ParentID = "0";     
            WJCC.Value = "0";
        }

        Hashtable HT_FileName = new Hashtable();


        string hzm ="";
        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("mc"));
        table.Columns.Add(new DataColumn("FullName"));
        table.Columns.Add(new DataColumn("xz"));
        table.Columns.Add(new DataColumn("gxrq"));
        table.Columns.Add(new DataColumn("dx"));
        table.Columns.Add(new DataColumn("ImgURL"));
        table.Columns.Add(new DataColumn("OID"));
        if (WJCC.Value != "0")       //如果文件夹层数不是0需要有回到上级目录的连接
        {
            DataRow sourseRow_ht = table.NewRow();
            sourseRow_ht["mc"] = "[根目录]";
            sourseRow_ht["FullName"] = ConfigurationManager.AppSettings["StartingPath"] + "||0";
            sourseRow_ht["xz"] = "";
            sourseRow_ht["gxrq"] = "";
            sourseRow_ht["dx"] = "";
            sourseRow_ht["ImgURL"] = "../images/file/folder.small.gif";
            sourseRow_ht["OID"] = "0";
            table.Rows.Add(sourseRow_ht);

            DataRow sourseRow_ht1 = table.NewRow();
            sourseRow_ht1["mc"] = "[后退]";
            sourseRow_ht1["FullName"] = path.Remove(path.LastIndexOf("\\")) + "||-";
            sourseRow_ht1["xz"] = "";
            sourseRow_ht1["gxrq"] = "";
            sourseRow_ht1["dx"] = "";
            sourseRow_ht1["ImgURL"] = "../images/file/folder.small.gif";
            sourseRow_ht1["OID"] = OldID.Value;
            table.Rows.Add(sourseRow_ht1);

        }

        //DirectoryInfo dires = new DirectoryInfo(path);
        //DirectoryInfo[] dir = dires.GetDirectories();
        DirectoryInfo[] dir = new GetDirectorie_rq().GetDirectorie(path);
        
        string zqx = ""; //用户所属的用户组
        sqlcon.Open();   //取出用户所在用户组里面的相应的用户权限
        string sqlstr = "SELECT wkqx  FROM [erp_js_data0704].[dbo].[STUsers] WHERE UserID='" + UserID.Value + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            zqx = sdr["wkqx"].ToString().Trim();
        }
        sdr.Close();

        sqlstr = "SELECT GradationID,IsDownload from dbo.WK_UserGroup WHERE id in (" + zqx + ")";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            GradationID += sdr["GradationID"].ToString().Trim() + ";";
            IsDownload += sdr["IsDownload"].ToString().Trim() + ";";
        }
        sdr.Close();
        GradationID = GradationID.Substring(0, GradationID.Length - 1);
        IsDownload = IsDownload.Substring(0, IsDownload.Length - 1);

        string[] isdown = IsDownload.Split(';');
        if (WJCC.Value == "0" || WJCC.Value == "1" || (WJCC.Value == "2" && sx == "+"))     //只有在第一层第二层和从第二层到第三层的时候才判断下载权限，其他时间全部按照上次权限开始。
        {
            sfxz.Value = "0";     //是否下载权限 0表示不能下载 1表示可以下载
            foreach (string IsD in isdown)
            {
                if (IsD == ParentID)
                {
                    sfxz.Value = "1";
                    break;
                }
            }
        }

        if (WJCC.Value =="0" || WJCC.Value=="1")     //如果在文件夹的第一层或者第二层需取出用户相对应的权限来控制
        {
         


            sqlstr = "SELECT [ID],[FileName],[FirstFileID],[ParentID] FROM [erp_js_data0704].[dbo].[WK_FileGroup] WHERE  ParentID=" + ParentID + " AND FirstFileID !=1 AND FirstFileID != 2 and id in (" + GradationID.Replace(";", ",") + ")";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                HT_FileName.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
            }
            sdr.Close();

            foreach (DirectoryInfo d in dir)
            {
                foreach (DictionaryEntry H_f in HT_FileName)  //遍历文件夹是否在数据库里面有记录
                {
                    if (H_f.Value.ToString() == d.Name)
                    {
                        DataRow sourseRow = table.NewRow();
                        sourseRow["mc"] = d.Name;
                        sourseRow["FullName"] = d.FullName + "||+";
                        sourseRow["xz"] = "";
                        sourseRow["gxrq"] = d.LastWriteTime;
                        sourseRow["dx"] = "";
                        sourseRow["ImgURL"] = "../images/file/folder.gif";
                        sourseRow["OID"] = H_f.Key ;
                        table.Rows.Add(sourseRow);
                        break;
                    }
                }
            }
        }
        else
        {


            foreach (DirectoryInfo d in dir)      
            {
                DataRow sourseRow = table.NewRow();
                sourseRow["mc"] = d.Name;
                sourseRow["FullName"] = d.FullName + "||+";
                sourseRow["xz"] = "";
                sourseRow["gxrq"] = d.LastWriteTime;
                sourseRow["dx"] = "";
                sourseRow["ImgURL"] = "../images/file/folder.gif";
                sourseRow["OID"] = "99999";
                table.Rows.Add(sourseRow);
                
            }
        }


        if (WJCC.Value != "0")    //如果不在跟目录则需要把文件夹中包含的文件也取出来。
        {
            //FileInfo[] files = dires.GetFiles();
            FileInfo[] files = new GetFile_rq().GetFiles(path);
            foreach (FileInfo f in files)
            {
                DataRow sourseRow = table.NewRow();
                //if (f.Name.Length  > 53)         //文件名超过53个字符的长度则截断后用"..."表示，使每条记录都是只有一行
                //{
                //    sourseRow["mc"] = f.Name.Substring(0, 53) + "...";
                //}
                //else
                //{
                    sourseRow["mc"] = f.Name;
                //}
                
                sourseRow["FullName"] = f.FullName;
                if (sfxz.Value == "1")    //下载权限是1表示有下载权限否则则没有。
                {
                    sourseRow["xz"] = "下载";
                }
                else
                {
                    sourseRow["xz"] = "";
                }
               
                sourseRow["gxrq"] = f.LastWriteTime;
                sourseRow["dx"] = f.Length / 1024 + "KB";
                //获取文件后缀名
                char[] delimiterChars = { '.', '\\' };
                string[] Mystr = Path.GetExtension(f.Name.ToString()).Split(delimiterChars);
                hzm = Mystr[Mystr.Length - 1];
                //根据后缀名获取图标
                string tmpPath="../images/file/" + hzm + ".gif";
                string tmpRootDir = Server.MapPath("../images/file/" + hzm + ".gif");
                if (!File.Exists(tmpRootDir))//判断图标文件是否已经存在
                {
                    tmpPath="../images/file/other.gif";//不存在则用为止文件的图标
                }
                sourseRow["ImgURL"] = tmpPath;
                table.Rows.Add(sourseRow);


            }
        }


        GridView1.DataSource = table;
        GridView1.DataBind();
        sqlcon.Close();


    }



    //protected void LinkButton1_Click(object sender, EventArgs e)
    //{
        
        
    //}


    private string urlconvertor(string imagesurl1)
    {
        string tmpRootDir = Server.MapPath(System.Web.HttpContext.Current.Request.ApplicationPath.ToString());//获取程序根目录
        string imagesurl2 = imagesurl1.Replace(tmpRootDir, ""); //转换成相对路径
        imagesurl2 = imagesurl2.Replace(@"\", @"/");
        //imagesurl2 = imagesurl2.Replace(@"Aspx_Uc/", @"");
        return imagesurl2;
    }



    /* 文件上传
    protected void Button1_Click1(object sender, EventArgs e)
    {
        string currentpath = "/upfiles/"; //这是上传后的图片路径
        string filepath = Server.MapPath(currentpath); //文件夹名，以日期为文件夹名，图片所在这个地方
        HttpPostedFile userPostedFile = Request.Files["File1"];
        if (userPostedFile.ContentLength > 0)
        {
            string file_name = System.DateTime.Now.ToString("yyyyMMddHHmmss"); //新文件名
            string sPath = System.DateTime.Now.ToString("yyyy-MM-dd"); //创建日期文件夹
            string file_ext = System.IO.Path.GetFileName(userPostedFile.FileName).Split('.')[1];
            string ext = userPostedFile.ContentType; //获取文件类型
            if (ext == "image/pjpeg" || ext == "image/gif" || ext == "image/x-png")
            {
                string sPath2 = filepath + sPath;
                if (!Directory.Exists(sPath2)) //判断日期文件夹是否存在
                {
                    Directory.CreateDirectory(sPath2);//创建日期文件夹
                }
                string fpath = filepath + sPath + "\\" + file_name + "." + file_ext;
                string uploadpath = currentpath + sPath + "/" + file_name + "." + file_ext;
                userPostedFile.SaveAs(fpath);
                Label1.Text = uploadpath;
            }
            else
            {
                Label1.Text = "文件格式不正确";
            }
        }
    }
      */
    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[4].Visible = false;  //使第5列不可见,则将它的可见性设为false
        //if (sfxz.Value == "0")
        //{
        //    e.Row.Cells[1].Visible = false; //如果sfxz值等于0表示不能下载，隐藏下载按钮。
        //}

        //可以根据需要设置更多的列
    }
    protected void SearchClick(object sender, EventArgs e)
    {
        string SearchPath = "";
        //ContentPlaceHolder c = (ContentPlaceHolder)this.FindControl("ContentPlaceHolder1");
        HiddenField t2 = NowPath;
        if (t2.Value != null)
        {
            SearchPath = t2.Value;
        }
        Response.Redirect("SearchFile.aspx?Searchfile=" + SearchName.Text.Trim() + "&SearchPath=" + SearchPath);
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
             if (File.Exists(FullName))
            {
                if (Path.GetExtension(dz).Equals(".swf") || Path.GetExtension(dz).Equals(".pdf"))
                {
                    if (RB_tc.Checked == true)   //选择新窗口显示还是跳转显示
                    {
                        //Response.Write("<script>window.open('ShowPDF.aspx?URL=" + dz.Replace("\\", "\\\\") + "')</script>");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript'>window.open('ShowPDF.aspx?URL=" + dz.Replace("\\", "\\\\") + "');</script>");
                        
                    }
                    else
                    {
                        Response.Redirect("ShowPDF.aspx?URL=" + dz); //urlconvertor(dz).Substring(urlconvertor(dz).IndexOf("文控管理")));
                    }

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
            else if (Directory.Exists(FullName))
            {
                sx = dz.Substring(dz.LastIndexOf("||") + 2);
                //是文件夹
                if (sx == "+")   //+表示进入下一层目录
                {
                    WJCC.Value = Convert.ToString(Int32.Parse(WJCC.Value.Trim()) + 1);     //文件夹层数加一   
                    GridViewRow gvrow = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);    //获取当前点击的行
                    int index = gvrow.RowIndex;
                    //GridViewRow row = GridView1.Rows[5];
                    ParentID=GridView1.Rows[index].Cells[4].Text.ToString();
                    if (WJCC.Value == "1")   //在第二次ParentID一定是0
                    {
                        OldID.Value = GridView1.Rows[index].Cells[4].Text.ToString();
                    }


                }
                else if (sx == "-")  //-表示返回上一层目录
                {
                    WJCC.Value = Convert.ToString(Int32.Parse(WJCC.Value.Trim()) - 1);        //文件夹层数减一
                    if (WJCC.Value == "1") //如果返回到第二次目录的时候把OLDID复制给ParentID
                    {
                        ParentID = OldID.Value;
                    }
                    else if (WJCC.Value == "0")
                    {
                        ParentID = "0";
                    }
                }
                else if (sx == "0") //0表示返回跟目录
                {
                    WJCC.Value = "0";
                    ParentID = "0";
                }


                NowPath.Value = FullName;
                BindGetDir(FullName);
            }
        }
        else if (e.CommandName == "wjxz")
        {
            string dz = e.CommandArgument.ToString();
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
            if (File.Exists(FullName))
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


}
