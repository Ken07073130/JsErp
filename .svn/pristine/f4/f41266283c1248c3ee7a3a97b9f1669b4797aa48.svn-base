using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;


/// <summary>
/// WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]

public class WebService : System.Web.Services.WebService {

    public WebService () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }



    [WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static AjaxControlToolkit.Slide[] GetSlides()
    {
        return new AjaxControlToolkit.Slide[] { 
            new AjaxControlToolkit.Slide("PPT/1jpg", "Blue Hills", "Go Blue"),
            new AjaxControlToolkit.Slide("PPT/2jpg", "Sunset", "Setting sun"),
            new AjaxControlToolkit.Slide("PPT/3jpg", "Winter", "Wintery..."),
            new AjaxControlToolkit.Slide("PPT/4jpg", "Water lillies", "Lillies in the water"),
            new AjaxControlToolkit.Slide("PPT/5jpg", "Sedona", "Portrait style picture")};
    }
    
}

