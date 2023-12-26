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
    public partial class StockReconciliation : System.Web.UI.UserControl
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData1();

        }

        public String UserID { get; set; }
        public String SearchBy1 { get; set; }


        private void LoadData1()
        {
            rptrStockRecon1.DataSource = GetStockDetails1(UserID, SearchBy1);
            rptrStockRecon1.DataBind();
            rptrStockRecon2.DataSource = GetStockDetails2(UserID, SearchBy1);
            rptrStockRecon2.DataBind();

          
            if (rptrStockRecon1.Items.Count == 0 && SearchBy1 != "undefined" )
            {
                DataSet ds = new DataSet();
                string queryString = "select ProductType,ProductModel as Model,Category1,Category2,Inactive from RBSYNERGY.dbo.tblProductMaster where inActive=0 and ProductType='Cell Phone' order by Model ";


                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 5000;
                adapter.Fill(ds, "StockReconService21");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    rptrStockRecon.DataSource = ds;
                    rptrStockRecon.DataBind();
                }
            }

        }
        static DataSet ds = null;
        public static DataSet GetStockDetails2(string UserID, string SearchBy1)
        {
            if (SearchBy1 != "undefined" && UserID != null)
            {
                ds = new DataSet();
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string queryString = "  select top 1 AddedDate from RBSYNERGY.IMEIReplacementMaster.tblStockReconciliation where DealerCode='" + SearchBy1 + "' order by AddedDate desc";
               

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

        public static DataSet GetStockDetails1(string UserID, string SearchBy1)
        {
            if (SearchBy1 != "undefined" && UserID != null)
            {
                ds = new DataSet();
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string queryString ="SELECT *  FROM RBSYNERGY.IMEIReplacementMaster.tblStockReconciliation  where DealerCode='000' ";

                if (SearchBy1 != "undefined")
                {
                    queryString = String.Format(
                           @" SELECT *  FROM RBSYNERGY.IMEIReplacementMaster.tblStockReconciliation  WHERE AddedDate IN (SELECT MAX(AddedDate) FROM RBSYNERGY.IMEIReplacementMaster.tblStockReconciliation where DealerCode='" + SearchBy1 + "' GROUP BY Model) order by Model");

                }

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
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    LoadData1();

        //}

        //public String UserID { get; set; }
        //public String SearchBy1 { get; set; }


        //private void LoadData1()
        //{
        //    rptrStockRecon1.DataSource = GetStockDetails1(UserID, SearchBy1);
        //    rptrStockRecon1.DataBind();

        //    if (rptrStockRecon1.DataSource == null)
        //    {

        //        DataSet ds = new DataSet();
        //        string queryString = "select ProductType,ProductModel,Category1,Category2,Inactive from RBSYNERGYTEST.dbo.tblProductMaster where inActive=0 and ProductType='Cell Phone' ";


        //        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
        //        SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

        //        adapter.SelectCommand.CommandTimeout = 5000;
        //        adapter.Fill(ds, "StockReconService21");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            rptrStockRecon.DataSource = ds; 
        //            rptrStockRecon.DataBind();
        //        }
        //    }

        //}
        //static DataSet ds = null;    
        //public static DataSet GetStockDetails1(string UserID, string SearchBy1)
        //{
        //    if (SearchBy1 != "undefined" && UserID != null)
        //    {
        //        ds = new DataSet();
        //        WSMSDataContext contx = new WSMSDataContext();
        //        RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

        //        string queryString = " SELECT *  FROM RBSYNERGYTEST.IMEIReplacementMaster.tblStockReconciliation  WHERE AddedDate IN (SELECT MAX(AddedDate) FROM RBSYNERGYTEST.IMEIReplacementMaster.tblStockReconciliation where DealerCode='" + SearchBy1 + "' GROUP BY Model)";

        //        if (queryString.Length == 0)
        //        {
        //            return null;
        //        }

        //        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
        //        SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

        //        adapter.SelectCommand.CommandTimeout = 5000;
        //        adapter.Fill(ds, "StockReconService1");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            return ds;
        //        }
        //        else
        //            return null;
        //    }
        //    else
        //        return null;
        //}
        //public static String DDLDealerName
        //{
        //    get
        //    {

        //        string ss = "<select class=\"ddl-dealer\" style=\"width:255px\" id=\"ddldealer\" >" +
        //                    "<option value=\"0\" selected=\"selected\">------------- Select Dealer Name -------------</option>";

        //        DataSet ds = new DataSet();

        //        WSMSDataContext contx = new WSMSDataContext();

        //        string queryString = "select PlazaAndRSMCode,Organaization_Name from WSMS.ReplaceMentdb.PlazaAndRSM where ZoneID not in (1,7,13,19,40) order by PlazaAndRSMCode";

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

        //private void LoadData()
        //{
        //    rptrStockRecon.DataSource = GetStockDetails(UserID, SearchBy1);
        //    rptrStockRecon.DataBind();
        //}
        //public static DataSet GetStockDetails(string UserID, string SearchBy1)
        //{
        //    if (SearchBy1 == "undefined" && UserID != null)
        //    {
        //        ds = new DataSet();
        //        WSMSDataContext contx = new WSMSDataContext();
        //        RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

        //        string queryString = "select ProductType,ProductModel,Category1,Category2,Inactive from RBSYNERGYTEST.dbo.tblProductMaster where inActive=0 and ProductType='Cell Phone' ";

        //        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
        //        SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

        //        adapter.SelectCommand.CommandTimeout = 5000;
        //        adapter.Fill(ds, "StockReconService");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            return ds;
        //        }
        //        else
        //            return null;
        //    }

        //    else
        //        return null;
        //}
    }
}