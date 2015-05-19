using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Configuration;
using AJAX_JSON;
using System.Data.SqlClient;

/// <summary>
/// InsertContent 的摘要说明
/// </summary>
/// 
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
[System.Web.Script.Services.ScriptService]

public class InsertContent: System.Web.Services.WebService {

	public InsertContent()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    [WebMethod]
    public Hashtable InsertblpHashtable(blpJSON blp)
	{
		Hashtable hashtable = new Hashtable();
        blp.Bldm = "sdfsdfs";

        hashtable.Add("blp", blp);
		return hashtable;
	}

    [WebMethod]
    public int GetString()
    {
       // Hashtable hashtable = new Hashtable();
        //blp.Bldm ; 	
        //hashtable.Add("blp", blp);
        return 123;
    }

    [WebMethod]
    public List<wlxxJosn> GetwlxxArrayList(wlxxJosn wlxx)
	{
        List<wlxxJosn> arrayList = new List<wlxxJosn>();
        
        int i = 0;
        SqlConnection sqlcon;
        SqlCommand Cmd;
        SqlDataReader sdr;
        sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString);  //链接数据库
        sqlcon.Open();
        string sqlstr = "SELECT  VwXm0001 AS ckbh,VwXm0002 AS wlbh ,VwXm0003 AS wlmc ,VwXm0004 AS gg,VwXm0005 AS pc,VwXm0006,VwXm0007 AS dw,VwXm0014 AS qmsl FROM View_0335"
                        + " where VwXm0001='" + wlxx.Ckbh + "' and VwXm0014>0 and VwXm0003 like '%" + wlxx.Wlmc + "%' and  VwXm0002 like '%"+ wlxx.Wlbh +"%'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        while (sdr.Read())
        {
            wlxxJosn addwlxx = new wlxxJosn();
            addwlxx.Ckbh = sdr["ckbh"].ToString();
            addwlxx.Wlbh = sdr["wlbh"].ToString();
            addwlxx.Wlmc = sdr["wlmc"].ToString();
            addwlxx.Gg = sdr["gg"].ToString();
            addwlxx.Wlpc = sdr["pc"].ToString();
            addwlxx.Dw = sdr["dw"].ToString();
            addwlxx.Sl = sdr["qmsl"].ToString();
            arrayList.Add(addwlxx);

        }
        sqlcon.Close();
		return arrayList;
	}
}
