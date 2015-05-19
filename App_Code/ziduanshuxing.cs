using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// ziduanshuxing 的摘要说明
/// </summary>
public class ziduanshuxing
{
	public ziduanshuxing()	{}

    public ziduanshuxing(String zdm,String sfxr,String sfxs)   
    {
        this.Zdm = zdm;     //字段名
        this.Sfxr = sfxr;   //是否写入
        this.Sfxs = sfxs;   //是否可见
    }

    private String zdm;
    public String Zdm   
    {
        get { return zdm; }
        set { zdm = value; }   
    }

    private String sfxr;
    public String Sfxr   
    {
        get { return sfxr; }
        set { sfxr = value; }   
    }

    private String sfxs;
    public String Sfxs   
    {
        get { return sfxs; }
        set { sfxs = value; }   
    }


}
