using System;
using System.IO;
using System.Net;
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

public partial class ywydyEdit : System.Web.UI.Page
{
    string UserName = "";
    string GroupID = "";
    string xh = "";
    string lb = "";
    string editType = "";
    DataTable dt = new DataTable();
    SqlConnection sqlcon=new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString) ;
    SqlCommand Cmd;
    SqlDataReader sdr;

    protected void Page_Load(object sender, EventArgs e)
    {
        //自定义验证控件返回为false的话不进行下面操作
        xh = Request.QueryString["xh"];
        lb = Request.QueryString["lb"];
        if (!IsPostBack)
        {

            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            ViewState["dt"] = dt;

            if (Session["username"] != null)
            {
                UserName = Session["username"].ToString();   //取出session里面的相应用户权限
                GroupID = Session["GroupID"].ToString();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            //sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["DatebaseConnection"].ConnectionString); 
            if ("EDIT" == lb.Trim())
            {
                getData();
            }
        }
    }

    protected void btnTj_Click(object sender, EventArgs e){
        if (Session["username"] != null){
            UserName = Session["username"].ToString();   //取出session里面的相应用户权限
            GroupID = Session["GroupID"].ToString();
        }
        else{
            Response.Redirect("Login.aspx");
        }

        //提交时判断自定义控件是否验证通过
        if (Page.IsValid)
        {
            if ("ADD" == lb)
            {
                if (addData())
                {
                    Response.Redirect("ywydyList.aspx");
                }
            }
            else if ("EDIT" == lb)
            {
                if (editData())
                { //编辑数据成功后
                    Response.Redirect("ywydyList.aspx");
                }
            }
        }
        
    }

    //新增数据
    public Boolean addData(){
        Boolean result = false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String addSQLSring ="";
        System.Text.StringBuilder zd= new System.Text.StringBuilder();
        System.Text.StringBuilder zdz= new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select mc,zd,lx from dbo.js_controlEnable where djmc = '业务员与技术部对应关系'";
        Cmd = new SqlCommand(sqlstr,sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                zd.Append(sdr["zd"].ToString());
                zd.Append(",");
                zdz.Append("'");
                if ("TEXTBOX" == sdr["lx"].ToString()){                    
                    zdz.Append(((TextBox)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl(sdr["mc"].ToString().Trim())).Text);           
                } else if ("CHECKBOX" == sdr["lx"].ToString()){
                    zdz.Append(((CheckBox)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl(sdr["mc"].ToString().Trim())).Checked);
                } else if ("DROPDOWNLIST" == sdr["lx"].ToString()){
                    zdz.Append(((DropDownList)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl(sdr["mc"].ToString().Trim())).Text);
                } else if ("CHECKBOXLIST" == sdr["lx"].ToString()){
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++){
                        if (cblTemp.Items[i].Selected)
                        {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    zdz.Append(strTemp.Substring(0, strTemp.Length > 0 ? strTemp.Length : 1 - 1));//全部都没勾选时 空字符串 就substring(0,0)
                }
                zdz.Append("',");
            }          
        }
        sdr.Close();
        addSQLSring = "insert into js_ywydyjsbry (bh,"
                   + zd.ToString().Substring(0, zd.Length - 1)
                   + ") select isnull(max(bh),0)+1,"
                   + zdz.ToString().Substring(0, zdz.Length - 1) + " from js_ywydyjsbry";
        Cmd = new SqlCommand(addSQLSring, sqlcon);
        Cmd.ExecuteNonQuery(); 
        sqlcon.Close();
        result = true;
        return result;
    }

    //获取数据
    public void getData() {
        sqlcon.Open();
        //Hash表:
        //ht_zddz 字段对照 存储 前台控件和后台字段名对应关系  KEY:数据库字段名 VALUE:控件名称
        //ht_lxdz 类型对照 前台控件和控件类型对照  KEY:数据库字段名 VALUE：控件类型
        Hashtable ht_zddz = new Hashtable();
        Hashtable ht_lxdz = new Hashtable();
        //ArrayList 存储后台数据库字段名字的列表
        ArrayList listZd = new ArrayList();
        String sqlstr = "select mc,zd,lx from dbo.js_controlEnable where djmc = '业务员与技术部对应关系' ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows) {
            while (sdr.Read()) {
                listZd.Add(sdr["zd"].ToString().Trim());//将数据库字段名加入list
                ht_zddz.Add(sdr["zd"].ToString().Trim(), sdr["mc"].ToString().Trim());
                ht_lxdz.Add(sdr["zd"].ToString().Trim(), sdr["lx"].ToString().Trim());        
            }
        }
        sdr.Close();
        sqlstr = "select * from dbo.js_ywydyjsbry where bh='" + xh + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows){
            while (sdr.Read()){//获取数据时，只有一条数据
                //循环表的所有数据库字段
                foreach (String strZd in listZd) {
                    if ("TEXTBOX"==(string)ht_lxdz[strZd]){//根据对照表存储的字段类型进行不同类型的转换
                        ((TextBox)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl((string)ht_zddz[strZd])).Text = sdr[strZd].ToString().Trim();
                    } else if ("CHECKBOX" == (string)ht_lxdz[strZd]){
                        ((CheckBox)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl((string)ht_zddz[strZd])).Checked = ("True"==sdr[strZd].ToString());
                    } else if ("DROPDOWNLIST" == (string)ht_lxdz[strZd]) {
                        DropDownList ddlTemp=(DropDownList)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl((string)ht_zddz[strZd]);
                        int j = 0;
                        for (int i = 0; i < ddlTemp.Items.Count; i++) {
                            if (ddlTemp.Items[i].Text == sdr[strZd].ToString().Trim()) {
                                j = i;//把匹配到的索引赋给j
                                break;
                            }
                        }
                        if (0 == j){ //j=0说明数据库里的值没有匹配到，那么就自己把数据库的值加进去并选定
                            ddlTemp.Items.Add(sdr[strZd].ToString().Trim());    
                        }
                        ddlTemp.Text = sdr[strZd].ToString().Trim();
                    } else if ("CHECKBOXLIST" == (string)ht_lxdz[strZd]){
                        CheckBoxList cblTemp = (CheckBoxList)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl((string)ht_zddz[strZd]);
                        //获取的值一一去匹配CHECKBOXLIST的值，若匹配上 则打勾
                        for(int i=0;i<cblTemp.Items.Count;i++){
                           if (sdr[strZd].ToString().Trim().IndexOf(cblTemp.Items[i].Text)!=-1){
                              cblTemp.Items[i].Selected = true;
                           }
                        }   
                    }

                }
            }
        }
        sdr.Close();
        sqlcon.Close();

    }


    //更新数据
    public Boolean editData() {
        Boolean result=false;
        //根据数据库  前台控件和后台数据库字段对照来自动生成插入语句
        String editSQLSring = "";
        System.Text.StringBuilder editEqualSql = new System.Text.StringBuilder();
        sqlcon.Open();
        String sqlstr = " select  mc,lx,zd from    dbo.js_controlEnable where   djmc = '业务员与技术部对应关系'"
                      + " and dbo.js_func_hasgroup('业务员与技术部对应关系','" + Session["UserName"] + "','',qx)=1 ";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        sdr = Cmd.ExecuteReader();
        if (sdr.HasRows){
            while (sdr.Read()){
                editEqualSql.Append(sdr["zd"].ToString());
                editEqualSql.Append("='");
                if ("TEXTBOX" == sdr["lx"].ToString()){
                    editEqualSql.Append(((TextBox)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl(sdr["mc"].ToString().Trim())).Text);
                } else if ("CHECKBOX" == sdr["lx"].ToString()){
                    editEqualSql.Append(((CheckBox)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl(sdr["mc"].ToString().Trim())).Checked);
                } else if ("DROPDOWNLIST" == sdr["lx"].ToString()){
                    editEqualSql.Append(((DropDownList)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl(sdr["mc"].ToString().Trim())).Text);
                } else if ("CHECKBOXLIST" == sdr["lx"].ToString()) {
                    String strTemp = "";
                    CheckBoxList cblTemp = (CheckBoxList)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl(sdr["mc"].ToString().Trim());
                    for (int i = 0; i < cblTemp.Items.Count; i++){
                        if (cblTemp.Items[i].Selected) {
                            strTemp = strTemp + cblTemp.Items[i].Text + ',';
                        }
                    }
                    editEqualSql.Append(strTemp.Substring(0, strTemp.Length>0?strTemp.Length:1 - 1));
                }
                editEqualSql.Append("',");

            }
        }
        editSQLSring = "update js_ywydyjsbry set "
                   + editEqualSql.ToString().Substring(0, editEqualSql.Length - 1)
                   + " where bh='" + xh + "'";
        sdr.Close();
        Cmd = new SqlCommand(editSQLSring, sqlcon);
        Cmd.ExecuteNonQuery();  
        sqlcon.Close();
        result = true;
        return result;
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        sqlcon.Open();
        string fzr = args.Value;
        string sqlstr = "select * from dbo.STUsers where UserName='" + fzr + "'";
        Cmd = new SqlCommand(sqlstr, sqlcon);
        int count = Convert.ToInt32(Cmd.ExecuteScalar());
        if (count > 0)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
        sqlcon.Close();
    }

}
