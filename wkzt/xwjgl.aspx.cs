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


public partial class wkzt_xwjgl : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);
    DataSet ds;
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
                if (GroupID.IndexOf("hasgroup(文控文件维护员)") == -1)
                {
                    Response.Write("<script>alert('你没有权限使用这项功能!');history.go(-1);</script>");
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }

            GetDir(ConfigurationManager.AppSettings["StartingPath"]);
            sqlcon.Open();
            this.createDataSet();
            this.InitTree(TreeView1.Nodes, "0");
            sqlcon.Close();

            
        }

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
            tmpNode.Value = drv["ID"].ToString();
            tmpNode.Text = drv["FileName"].ToString();
            //tmpNode.NavigateUrl = "../" + drv["URL"].ToString();
            //tmpNode.NavigateUrl = drv["URL"].ToString();
            //if (drv["ID"].ToString() == "0")
            //{
            //    tmpNode.Expanded = true;
            //}
            //else
            //{
            tmpNode.Expanded = false;
            //}
            //                            //默认收拢
            Nds.Add(tmpNode);
            this.InitTree(tmpNode.ChildNodes, tmpNode.Value);
        }
    }

    private DataSet createDataSet()
    { 
        //oprate='显示' and 
        string sqlstr = "SELECT * FROM [WK_FileGroup]  ";
        SqlDataAdapter cmdSelect = new SqlDataAdapter(sqlstr, sqlcon);
        ds = new DataSet();
        cmdSelect.Fill(ds, "WK_FileGroup");
        return ds;

    }


    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
    {
        string path = "";
        path = TreeView1.SelectedNode.Text;
        if (TreeView1.SelectedNode.Parent != null)
        {
            path = TreeView1.SelectedNode.Parent.Text +"\\"+path ;
            if ( TreeView1.SelectedNode.Parent.Parent != null )
            {
                path = TreeView1.SelectedNode.Parent.Parent.Text + "\\" + path;
                if (TreeView1.SelectedNode.Parent.Parent.Parent != null)
                {
                    path = TreeView1.SelectedNode.Parent.Parent.Parent.Text + "\\" + path;
                }
            }
        }
       
        path = ConfigurationManager.AppSettings["StartingPath"]+"\\" + path;

        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("mc"));
        table.Columns.Add(new DataColumn("FullName"));

        DirectoryInfo dires = new DirectoryInfo(path);
        FileInfo[] files = dires.GetFiles();
        foreach (FileInfo f in files)
        {
            DataRow sourseRow = table.NewRow();
            sourseRow["mc"] = f.Name;
            sourseRow["FullName"] = f.FullName;
            //sourseRow["xz"] = "";
            //sourseRow["gxrq"] = f.LastWriteTime;
            //sourseRow["dx"] = f.Length / 1024 + "KB";
            //获取文件后缀名
            //char[] delimiterChars = { '.', '\\' };
            //string[] Mystr = Path.GetExtension(f.Name.ToString()).Split(delimiterChars);
            //hzm = Mystr[Mystr.Length - 1];
            ////根据后缀名获取图标
            //sourseRow["ImgURL"] = "../images/file/" + hzm + ".gif";
            table.Rows.Add(sourseRow);

        }
        ListBox1.DataSource = table;
        ListBox1.DataTextField = "mc";
        ListBox1.DataValueField = "FullName";
        ListBox1.DataBind();
       // Response.Write("<script>alert('" + TreeView1.SelectedNode.Text + "')</script>");
    }


    public void GetDir(string path)
    {

        string id = "";
        DirectoryInfo dires = new DirectoryInfo(path);
        Hashtable HT = new Hashtable();
        sqlcon.Open();
        string sqlstr = "select * from WK_FileGroup where  SecondFileID=0";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            HT.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
        }
        sdr.Close();



        DirectoryInfo[] dir = dires.GetDirectories();
        foreach (DirectoryInfo d in dir)
        {
            int s = 0;                          //s=0表示初始状态,默认没有相同的文件夹
            foreach (DictionaryEntry H in HT)  //遍历文件夹是否在数据库里面有记录
            {
                if (H.Value.ToString() == d.Name)
                {
                    id = H.Key.ToString();
                    s = 1;                      //找到同名的文件夹就该s状态为1
                    break;
                }
            }

            if (s == 0)                        //如果没有找到相同的文件夹,则向数据库中插入新的文件夹名
            {
                sqlstr = "insert into WK_FileGroup (FileName,FirstFileID,SecondFileID,ParentID)  SELECT '" + d.Name + "',max(FirstFileID,) +1 ,0,0 from WK_FileGroup ";   //插入新文件夹名
                sqlcom = new SqlCommand(sqlstr, sqlcon);
                sqlcom.ExecuteNonQuery();


                sqlstr = "select ID from WK_FileGroup where  SecondFileID=0 and FileName='" + d.Name + "'";     //取得新文件夹的编号
                Cmd = new SqlCommand(sqlstr, sqlcon);
                sdr = Cmd.ExecuteReader();
                while (sdr.Read())
                {
                    id = sdr["ID"].ToString().Trim();
                }
                sdr.Close();

            }

            DirectoryInfo dires_z = new DirectoryInfo(path + "\\" + d);
            DirectoryInfo[] dir_z = dires_z.GetDirectories();
            Hashtable HT_z = new Hashtable();
            string id_z = "";
            sqlstr = "select * from WK_FileGroup where  SecondFileID !=0 and FirstFileID="+ id ;
            Cmd = new SqlCommand(sqlstr, sqlcon);
            sdr = Cmd.ExecuteReader();
            while (sdr.Read())
            {
                HT_z.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
            }
            sdr.Close();

            foreach (DirectoryInfo d_z in dir_z)
            {
                int s_z = 0;                          //s=0表示初始状态,默认没有相同的文件夹
                foreach (DictionaryEntry H_z in HT_z)  //遍历文件夹是否在数据库里面有记录
                {
                    if (H_z.Value.ToString() == d_z.Name)
                    {
                        id_z = H_z.Key.ToString();
                        s_z = 1;                      //找到同名的文件夹就该s状态为1
                        break;
                    }
                }

                if (s_z == 0)                        //如果没有找到相同的文件夹,则向数据库中插入新的文件夹名
                {
                    sqlstr = "insert into WK_FileGroup (FileName,FirstFileId,SecondFileID,ParentID) select '" + d_z.Name + "'," + id + ", max(SecondFileID)+1," + id + " from WK_FileGroup ";   //插入新文件夹名
                    sqlcom = new SqlCommand(sqlstr, sqlcon);
                    sqlcom.ExecuteNonQuery();


                    sqlstr = "select * from WK_FileGroup where  FirstFileID=" + id + " and FileName='" + d_z.Name + "'";     //取得新文件夹的编号
                    Cmd = new SqlCommand(sqlstr, sqlcon);
                    sdr = Cmd.ExecuteReader();
                    while (sdr.Read())
                    {
                        id_z = sdr["ID"].ToString().Trim();
                    }
                    sdr.Close();

                }

                DirectoryInfo dires_s = new DirectoryInfo(path + "\\" + d +"\\" + d_z);
                DirectoryInfo[] dir_s = dires_s.GetDirectories();
                Hashtable HT_s = new Hashtable();
                string id_s = "";
                sqlstr = "select * from WK_FileGroup where  SecondFileID !=0 and FirstFileID=" + id_z;
                Cmd = new SqlCommand(sqlstr, sqlcon);
                sdr = Cmd.ExecuteReader();
                while (sdr.Read())
                {
                    HT_s.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
                }
                sdr.Close();

                foreach (DirectoryInfo d_s in dir_s)
                {
                    int s_s = 0;                          //s=0表示初始状态,默认没有相同的文件夹
                    foreach (DictionaryEntry H_s in HT_s)  //遍历文件夹是否在数据库里面有记录
                    {
                        if (H_s.Value.ToString() == d_s.Name)
                        {
                            id_s = H_s.Key.ToString();
                            s_s = 1;                      //找到同名的文件夹就该s状态为1
                            break;
                        }
                    }

                    if (s_s == 0)                        //如果没有找到相同的文件夹,则向数据库中插入新的文件夹名
                    {
                        sqlstr = "insert into WK_FileGroup (FileName,FirstFileId,SecondFileID,ParentID) select '" + d_s.Name + "'," + id_z + ", max(SecondFileID)+1," + id_z + " from WK_FileGroup ";   //插入新文件夹名
                        sqlcom = new SqlCommand(sqlstr, sqlcon);
                        sqlcom.ExecuteNonQuery();


                        sqlstr = "select * from WK_FileGroup where  FirstFileID=" + id_z + " and FileName='" + d_s.Name + "'";     //取得新文件夹的编号
                        Cmd = new SqlCommand(sqlstr, sqlcon);
                        sdr = Cmd.ExecuteReader();
                        while (sdr.Read())
                        {
                            id_s = sdr["ID"].ToString().Trim();
                        }
                        sdr.Close();

                    }
                    DirectoryInfo dires_ss = new DirectoryInfo(path + "\\" + d + "\\" + d_z +"\\"+ d_s );
                    DirectoryInfo[] dir_ss = dires_ss.GetDirectories();
                    Hashtable HT_ss = new Hashtable();
                    //string id_ss = "";
                    sqlstr = "select * from WK_FileGroup where  SecondFileID !=0 and FirstFileID=" + id_s;
                    Cmd = new SqlCommand(sqlstr, sqlcon);
                    sdr = Cmd.ExecuteReader();
                    while (sdr.Read())
                    {
                        HT_ss.Add(sdr["ID"].ToString().Trim(), sdr["FileName"].ToString().Trim());
                    }
                    sdr.Close();

                    foreach (DirectoryInfo d_ss in dir_ss)
                    {
                        int s_ss = 0;                          //s=0表示初始状态,默认没有相同的文件夹
                        foreach (DictionaryEntry H_ss in HT_ss)  //遍历文件夹是否在数据库里面有记录
                        {
                            if (H_ss.Value.ToString() == d_ss.Name)
                            {
                                //id_ss = H_s.Key.ToString();
                                s_ss = 1;                      //找到同名的文件夹就该s状态为1
                                break;
                            }
                        }

                        if (s_ss == 0)                        //如果没有找到相同的文件夹,则向数据库中插入新的文件夹名
                        {
                            sqlstr = "insert into WK_FileGroup (FileName,FirstFileId,SecondFileID,ParentID) select '" + d_ss.Name + "'," + id_s + ", max(SecondFileID)+1," + id_s + " from WK_FileGroup ";   //插入新文件夹名
                            sqlcom = new SqlCommand(sqlstr, sqlcon);
                            sqlcom.ExecuteNonQuery();


                            //sqlstr = "select * from WK_FileGroup where  FirstFileID=" + id_z + " and FileName='" + d_s.Name + "'";     //取得新文件夹的编号
                            //Cmd = new SqlCommand(sqlstr, sqlcon);
                            //sdr = Cmd.ExecuteReader();
                            //while (sdr.Read())
                            //{
                            //    id_s = sdr["ID"].ToString().Trim();
                            //}
                            //sdr.Close();

                        }
                    }
                }



            }




        }
        sqlcon.Close();

    }

    protected void B_JT_Click(object sender, EventArgs e)
    {
        FileInfo file;
        sqlcon.Open();
        string sqlstr = "";

        for (int i = 0; i < ListBox1.Items.Count; i++)
        {
            if (ListBox1.Items[i].Selected)
            {
                file = new FileInfo(ListBox1.Items[i].Value);
                sqlstr = "insert into WK_UpFile (FileName,FullName,FileType,InDate,CDate) values ('" + ListBox1.Items[i].Text + "','" + ListBox1.Items[i].Value + "','" + RadioButton1.SelectedValue + "',getdate(),getdate()) ";   //插入新文件夹名
                sqlcom = new SqlCommand(sqlstr, sqlcon);
                sqlcom.ExecuteNonQuery();
            }

        }

        sqlcon.Close();
        Response.Write("<script>alert('提交成功!')</script>");
    }

    protected void RodioChange(object sender, EventArgs e)
    {

    }
}
