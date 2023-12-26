using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using WSMS.DAL;

namespace WSMS.Module
{
    public partial class DealerHistory : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        public String UserID { get; set; }
        public String SearchBy { get; set; }

        private void LoadData()
        {
            //DataTable dt = new DataTable();
            rptrServicePending.DataSource = GetStockDetails2(UserID, SearchBy);
            rptrServicePending.DataBind();
        }
        static DataSet ds = null;

        public static DataSet GetStockDetails2(string UserID, string SearchBy)
        {
            if (SearchBy != "undefined" && UserID != null)
            {
                ds = new DataSet();
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string queryString = "select BarCode,BarCode2,Model,ProductType from RBSYNERGY.dbo.tblBarCodeInv where ProductType='Cell Phone' and (BarCode='" + SearchBy + "' or BarCode2='" + SearchBy + "' )";


                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 5000;
                adapter.Fill(ds, "StockReconService1");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return ds;
                }
                else
                    return null;
            }
            else
                return null;
        }

      
        public  String DDLDealerName
        {
            get
            {


                string ss = "<select class=\"ddl-dealer\" style=\"width:255px\" id=\"ddldealer\" >" +
                            "<option value=\"0\" selected=\"selected\">------------- Select Dealer Name -------------</option>";

                DataSet ds = new DataSet();

                WSMSDataContext contx = new WSMSDataContext();
               RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                if (user !=null && (user.ZoneID == 7 || user.ZoneID == 1 || user.ZoneID == 13 || user.ZoneID == 19))
                {
                    string queryString = "select DealerCode,DealerName,DealerType from RBSYNERGY.dbo.tblDealerInfo where DealerType='Plaza' order by DealerName";

                    SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                    SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                    adapter.Fill(ds, "model");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            string opt = "<option value=\"" + dr[0] + "\"> " + dr[1] + "</option>";
                            ss += opt;
                        }
                    }
                    ss = ss + "</select>";
                    return ss;
                }
                else
                {
                    string queryString1 = "select DealerCode,DealerName,DealerType from RBSYNERGY.dbo.tblDealerInfo where DealerType in ('Dealer','Electronics') order by DealerName";

                        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                        SqlDataAdapter adapter = new SqlDataAdapter(queryString1, connection);

                        adapter.Fill(ds, "model");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow dr in ds.Tables[0].Rows)
                            {
                                string opt = "<option value=\"" + dr[0] + "\"> " + dr[1] + "</option>";
                                ss += opt;
                            }
                        }
                        ss = ss + "</select>";
                        return ss;
                }

              
            }
        }

        //public static String MonitorName
        //{
        //    get
        //    {


        //        string ss = "<select class=\"ddl-monitor\" style=\"width:255px\" id=\"ddlmonitor\" >" +
        //                    "<option value=\"0\" selected=\"selected\">------------- Select Monitor -------------</option>";

        //        DataSet ds = new DataSet();

        //        // WSMSDataContext contx = new WSMSDataContext();
        //        // RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

        //        string queryString = "select RepUserName,RepUserFullName,RepUserID,ZoneID from wsms.ReplaceMentdb.RepUsers where RepRoleID=4 and ZoneID in (7,19,1,13)";

        //        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
        //        SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

        //        adapter.Fill(ds, "model");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            foreach (DataRow dr in ds.Tables[0].Rows)
        //            {
        //                string opt = "<option value=\"" + dr[0] + "\"> " + dr[1] + "</option>";
        //                ss += opt;
        //            }
        //        }
        //        ss = ss + "</select>";
        //        return ss;
        //    }
        //}
    }
}