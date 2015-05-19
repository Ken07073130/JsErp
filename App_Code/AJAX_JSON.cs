﻿using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// AJAX_JSON 的摘要说明
/// </summary>
/// 
namespace AJAX_JSON
{
    public class blpJSON
    {
        private String blmc;
        public String Blmc
        {
            get { return blmc; }
            set { blmc = value; }
        }

        private String bldm;
        public String Bldm
        {
            get { return bldm; }
            set { bldm = value; }
        }

        private int blsl;
        public int Blsl
        {
            get { return blsl; }
            set { blsl = value; }
        }

        private String blbz;
        public String Blbz
        {
            get { return blbz; }
            set { blbz = value; }
        }
        private String bllb;
        public String Bllb
        {
            get { return bllb; }
            set { bllb = value; }
        }
    }

    public class wlxxJosn
    {
        private String ckbh;
        public String Ckbh
        {
            get { return ckbh; }
            set { ckbh = value; }
        }

        private String wlbh;
        public String Wlbh
        {
            get { return wlbh; }
            set { wlbh = value; }
        }

        private String wlmc;
        public String Wlmc
        {
            get { return wlmc; }
            set { wlmc = value; }
        }

        private String wlpc;
        public String Wlpc
        {
            get { return wlpc; }
            set { wlpc = value; }
        }


        private String gys;
        public String Gys
        {
            get { return gys; }
            set { gys = value; }
        }

        private String gysmc;
        public String Gysmc {
            get { return gysmc; }
            set { gysmc = value; }
        }

        private String gg;
        public String Gg
        {
            get { return gg; }
            set { gg = value; }
        }
        private String sl;
        public String Sl
        {
            get { return sl; }
            set { sl = value; }
        }
        private String dw;
        public String Dw
        {
            get { return dw; }
            set { dw = value; }
        }

        private String flmc;
        public String Flmc {
            get { return flmc; }
            set { flmc = value; }
        }
        private String sx;
        public String Sx
        {
            get { return sx; }
            set { sx = value; }
        }

        private String cw;
        public String Cw {
            get { return cw; }
            set { cw = value; }
        }

        private String hjh;
        public String Hjh {
            get { return hjh; }
            set { hjh = value; }
        }

        private String pzzk;
        public String Pzzk {
            get { return pzzk; }
            set { pzzk = value; }
        }

        private String rkcz;
        public String Rkcz {
            get { return rkcz; }
            set { rkcz = value; }
        }
    }

    public class sgrb_bel_Josn
    {
        private String id;
        public String Id
        {
            get { return id; }
            set { id = value; }
        }

        private String wlid;
        public String Wlid
        {
            get { return wlid; }
            set { wlid = value; }
        }

        private String blid;
        public String Blid
        {
            get { return blid; }
            set { blid = value; }
        }
    }

    public class bhxxJosn
    {
        private String bhxx1;
        public String Bhxx1
        {
            get { return bhxx1; }
            set { bhxx1 = value; }
        }

        private String bhxx_max;
        public String Bhxx_max
        {
            get { return bhxx_max; }
            set { bhxx_max = value; }
        }
    }

    public class jxkh_del_Josn
    {
        private String table;
        public String Table
        {
            get { return table; }
            set { table = value; }
        }

        private String sqlstr;
        public String Sqlstr
        {
            get { return sqlstr; }
            set { sqlstr = value; }
        }
    }



    //电芯信息
    public class dxxx_Josn
    {
        private String xh;
        public String Xh
        {
            get { return xh; }
            set { xh = value; }
        }

        private String pc;
        public String Pc
        {
            get { return pc; }
            set { pc = value; }
        }

        private String rl;
        public String Rl
        {
            get { return rl; }
            set { rl = value; }
        }
    }

    //仓库信息
    public class CkxxJosn {
        private String ckdm;
        private String ckmc;

        public String Ckdm {
            get {
                return ckdm;
            }
            set {
                ckdm = value;
            }
        }
        
         

        public String Ckmc {
            get {
                return ckmc;
            }
            set {
                ckmc = value;
            }
        }


    }

    //合同评审单
    public class htpsdJosn {
        private String psdbh;
        private String ddh;
        private String ggsxh;
        private String ddl;

        public String Ddh {
            get {
                return ddh;
            }
            set {
                ddh = value;
            }
        }



        public String Psdbh {
            get {
                return psdbh;
            }
            set {
                psdbh = value;
            }
        }

        public String Ggsxh {
            get {
                return ggsxh;
            }
            set {
                ggsxh = value;
            }
        }

        public String Ddl {
            get {
                return ddl;
            }
            set {
                ddl = value;
            }
        }
    
    }



}
