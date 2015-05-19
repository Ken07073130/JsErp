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

public partial class wkzt_wjz : System.Web.UI.Page
{

    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    SqlCommand sqlcom;
    SqlCommand Cmd;
    SqlDataReader sdr;
    string UserName = "";
    string GroupID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
                if (GroupID.IndexOf("hasgroup(文控管理员)") == -1)
                {
                    Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }


            string kslj = this.Page.Request.ApplicationPath;
            kslj = System.AppDomain.CurrentDomain.BaseDirectory;
            string xh = Request.QueryString["xh"];
            sqlcon.Open();
            string sqlstr = "SELECT *  FROM [erp_js_data0704].[dbo].[WK_UserGroup] where id ="+ xh +"";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                this.G_Gradation.Value = sdr["GradationID"].ToString().Trim();
                this.G_Gradation1.Value = sdr["IsDownload"].ToString().Trim();
                this.GroupName.Text = sdr["GroupName"].ToString().Trim();
                H_ID.Value = sdr["ID"].ToString().Trim();
            }
            sdr.Close();
            sqlcon.Close();

            GetDir(ConfigurationManager.AppSettings["StartingPath"]);
        }
    }


    public void GetDir(string path)
    {
        
        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("mc"));
        table.Columns.Add(new DataColumn("FullName"));
        table.Columns.Add(new DataColumn("xz"));
        table.Columns.Add(new DataColumn("ck"));
        table.Columns.Add(new DataColumn("ImgURL"));
        string id = "";
        DirectoryInfo dires = new DirectoryInfo(path);
        Hashtable HT = new Hashtable();
        string fileID = "";
        sqlcon.Open();
        string sqlstr = "select * from WK_FileGroup where  SecondFileID=0" ;
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            HT.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
            //id = sdr["ID"].ToString().Trim();
            
        }
        sdr.Close();

        DirectoryInfo[] dir = dires.GetDirectories();
        foreach (DirectoryInfo d in dir)
        {
            int s = 0;                          //s=0表示初始状态,默认没有相同的文件夹
            foreach (DictionaryEntry H in HT)  //遍历文件夹是否在数据库里面有记录
            {
                                       
                if (H.Value.ToString () == d.Name)
                {
                    id = H.Key.ToString ();
                    s = 1;                      //找到同名的文件夹就该s状态为1
                }

            }

            if (s == 0)                        //如果没有找到相同的文件夹,则向数据库中插入新的文件夹名
            {
                sqlstr = "insert into WK_FileGroup (FileName,FirstFileID,SecondFileID,ParentID)  SELECT '" + d.Name + "',max(FirstFileID) +1 ,0,0 from WK_FileGroup ";   //插入新文件夹名
                sqlcom = new SqlCommand(sqlstr, sqlcon);
                sqlcom.ExecuteNonQuery();

                sqlstr = "select * from WK_FileGroup where  SecondFileID=0 and FileName='" + d.Name + "'";     //取得新文件夹的编号
                Cmd = new SqlCommand(sqlstr, sqlcon);
                sdr = Cmd.ExecuteReader();
                while (sdr.Read())
                {
                    fileID = sdr["FirstFileID"].ToString().Trim();
                    id = sdr["ID"].ToString().Trim();                      
                }
                sdr.Close(); 
                
            }

            DataRow sourseRow = table.NewRow();
            sourseRow["mc"] = d.Name;
            sourseRow["FullName"] = d.FullName;
            sourseRow["xz"] = id;
            sourseRow["ck"] = id;
            sourseRow["ImgURL"] = "../images/file/folder.gif";
            table.Rows.Add(sourseRow);




        }
        sqlcon.Close();
        //DataRow newRow = table.NewRow();
        
        //table.Rows.Add(newRow);
        GridView1.DataSource = table;
        GridView1.DataBind();
    }



    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string dz = ((LinkButton)sender).CommandArgument;
        if (File.Exists(dz))
        {
            if (Path.GetExtension(dz).Equals(".swf") || Path.GetExtension(dz).Equals(".pdf"))
            {
                Response.Redirect("ShowPDF.aspx?URL=" + dz); //urlconvertor(dz).Substring(urlconvertor(dz).IndexOf("文控管理")));
            }
            else
            {
                string fileName = "aaa" + Path.GetExtension(dz);//客户端保存的文件名 
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
        else if (Directory.Exists(dz))
        {
            //是文件夹
            GetDir(dz);
        }

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
            //GridView GridView2 = (GridView)e.Row.FindControl("gvInnerItem");
            //if (GridView2 != null)
            //{
            //    int id = Convert.ToInt32(GridView1.DataKeys[e.Row.RowIndex].Value);
            //    GridView2.DataSource ;
            //    GridView2.DataBind();
            //}
        //}
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Hashtable HT = new Hashtable();
            string fileID = "";
            string id = "";
            string id2 = "";
            DataTable table = new DataTable();
            table.Columns.Add(new DataColumn("mc"));
            table.Columns.Add(new DataColumn("FullName"));
            table.Columns.Add(new DataColumn("xz"));
            table.Columns.Add(new DataColumn("ck"));
            table.Columns.Add(new DataColumn("ImgURL"));
            string lj = e.Row.Cells[1].Text.ToString().Trim();
            string FileName = lj.Substring(lj.LastIndexOf ("\\")+1);
            string FirstID = "";
            sqlcon.Open();
            string sqlstr = "select * from WK_FileGroup where ParentID in (SELECT id FROM WK_FileGroup where secondfileid=0 and filename='" + FileName + "') and secondfileid !=0";
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                FirstID = sdr["parentid"].ToString().Trim();
                HT.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
            }
            sdr.Close();

            if (FirstID == "")
            {
                sqlstr = "SELECT id,firstfileid  FROM WK_FileGroup where secondfileid=0 and filename='" + FileName + "'";
                Cmd = new SqlCommand(sqlstr, sqlcon);
                sdr = Cmd.ExecuteReader();
                while (sdr.Read())
                {
                    FirstID = sdr["id"].ToString().Trim();
                    //FirstID = sdr["firstfileid"].ToString().Trim();

                }
                sdr.Close();
            }
            


            DirectoryInfo dires = new DirectoryInfo(lj);

            DirectoryInfo[] dir = dires.GetDirectories();
            foreach (DirectoryInfo d in dir)
            {
                int s = 0;                          //s=0表示初始状态,默认没有相同的文件夹
                foreach (DictionaryEntry H in HT)  //遍历文件夹是否在数据库里面有记录
                {

                    if (H.Value.ToString() == d.Name)
                    {
                        id2 = H.Key.ToString();
                        s = 1;                      //找到同名的文件夹就该s状态为1
                        break;
                    }

                }

                if (s == 0)                        //如果没有找到相同的文件夹,则向数据库中插入新的文件夹名
                {
                    sqlstr = "insert into WK_FileGroup (FileName,FirstFileId,SecondFileID,ParentID) select '" + d.Name + "'," + FirstID + ", max(SecondFileID)+1," + FirstID + " from WK_FileGroup ";   //插入新文件夹名
                    sqlcom = new SqlCommand(sqlstr, sqlcon);
                    sqlcom.ExecuteNonQuery();

                    sqlstr = "select * from WK_FileGroup where  FirstFileID="+ FirstID +" and FileName='" + d.Name + "'";     //取得新文件夹的编号
                    Cmd = new SqlCommand(sqlstr, sqlcon);
                    sdr = Cmd.ExecuteReader();
                    while (sdr.Read())
                    {
                        id2 = sdr["id"].ToString().Trim();
                        fileID = sdr["SecondFileID"].ToString().Trim();
                    }
                    sdr.Close();
                }

                DataRow sourseRow = table.NewRow();
                sourseRow["mc"] = d.Name;
                sourseRow["FullName"] = d.FullName;
                sourseRow["xz"] = id + "-" + id2;
                sourseRow["ck"] = id + "-" + id2;
                sourseRow["ImgURL"] = "../images/file/folder.gif";
                table.Rows.Add(sourseRow);


            }
            sqlcon.Close();
            
            //DataRow newRow = table.NewRow();
            //table.Rows.Add(newRow);

            GridView Grd = e.Row.Cells[0].FindControl("GridView2") as GridView;
            Grd.DataSource = table;
            Grd.DataBind();


        }
    }

    protected void B_TJ_Click(object sender, EventArgs e)
    {
        string sqlstr = "update WK_UserGroup set GradationID='" + HiddenField1.Value.Replace(",", ";") + "',IsDownload ='" + HiddenField2.Value.Replace(",", ";") + "'  where ID= " + H_ID.Value + "";   //更新权限信息
        sqlcon.Open();
        sqlcom = new SqlCommand(sqlstr, sqlcon);
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();

        Response.Write("<script>alert('权限设置成功!');self.location='yhz.aspx';</script>");


    }
}
