using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections;

/// <summary>
/// wenjianpaixu 的摘要说明
/// </summary>
    public class wenjianpaixu : IComparer
    {
        int IComparer.Compare(Object o1, Object o2)
        {
            FileInfo fi1 = o1 as FileInfo;
            FileInfo fi2 = o2 as FileInfo;
            return fi2.LastWriteTime.CompareTo(fi1.LastWriteTime);
        }
    }


    public class GetFile_rq
    {
        public FileInfo[] GetFiles(string path)
        {
            DirectoryInfo di = new DirectoryInfo(path);
            FileInfo[] files = di.GetFiles();
            wenjianpaixu fc = new wenjianpaixu();
            Array.Sort(files, fc);
            return files;
        }
    }

    public class wenjianjiapaixu : IComparer
    {
        int IComparer.Compare(Object o1, Object o2)
        {
            DirectoryInfo fi1 = o1 as DirectoryInfo;
            DirectoryInfo fi2 = o2 as DirectoryInfo;
            return fi2.LastWriteTime.CompareTo(fi1.LastWriteTime);
        }
    }

    public class GetDirectorie_rq
    {
        public DirectoryInfo[] GetDirectorie(string path)
        {
            DirectoryInfo di = new DirectoryInfo(path);
            DirectoryInfo[] dir = di.GetDirectories();
            wenjianjiapaixu fc = new wenjianjiapaixu();
            Array.Sort(dir, fc);
            return dir;
        }
    }
 
