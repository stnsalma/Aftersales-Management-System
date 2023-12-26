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
    public partial class DayWiseDealerSalesEntryFromTSO : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            LoadData1();

        }

        public String UserID { get; set; }
        public String SearchByDealer { get; set; }
        public String SearchBySalesDate { get; set; }

        private void LoadData1()
        {
            rptDayWise.DataSource = GetStockDetails1(UserID, SearchByDealer, SearchBySalesDate);
            rptDayWise.DataBind();

            rptDayWiseC.DataSource = GetStockDetails2(UserID, SearchByDealer, SearchBySalesDate);
            rptDayWiseC.DataBind();
       
            if (rptDayWise.Items.Count == 0 && SearchByDealer != "undefined" && SearchBySalesDate.Length != 0)
            {

                DataSet ds = new DataSet();

                string queryString = "select ProductType,ProductModel as Model1,Category1,Category2,Inactive from RBSYNERGY.dbo.tblProductMaster where inActive=0 and ProductType='Cell Phone'  order by Model1 ";


                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 5000;
                adapter.Fill(ds, "StockReconService321");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    rptDayWise1.DataSource = ds;
                    rptDayWise1.DataBind();
                }
            }

        }
        static DataSet ds = null;

        public static DataSet GetStockDetails1(string UserID, string SearchByDealer, string SearchBySalesDate)
        {
            if (SearchByDealer != "undefined" && UserID != null && SearchBySalesDate.Length != 0)
            {

                ds = new DataSet();
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string queryString = "select tbs.SalesID,tbs.DealerCode,tbs.Model as Model1,tbs.SalesDate,tbs.AddedDate,tbs.Quantity  from RBSYNERGY.IMEIReplacementMaster.tblDealerSales tbs where DealerCode='000' ";

              
                if (SearchByDealer != "undefined" && SearchBySalesDate.Length != 0)
                {
                     queryString = String.Format(
                            @"SELECT tbs.SalesID,tbs.DealerCode,tbs.Model as Model1,tbs.SalesDate,tbs.Quantity,tbs.AddedDate  FROM RBSYNERGY.IMEIReplacementMaster.tblDealerSales  tbs
                        WHERE tbs.AddedDate IN (SELECT MAX(AddedDate) FROM RBSYNERGY.IMEIReplacementMaster.tblDealerSales where DealerCode='" +
                            SearchByDealer + "' and cast(CONVERT(varchar(8), SalesDate, 112) AS datetime) between '" + SearchBySalesDate + @" 00:00:00' And '" + SearchBySalesDate + @" 23:59:59' GROUP BY Model) order by Model1 ");

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

        public static DataSet GetStockDetails2(string UserID, string SearchByDealer, string SearchBySalesDate)
        {
            if (SearchByDealer != "undefined" && UserID != null && SearchBySalesDate.Length != 0)
            {

                ds = new DataSet();
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string queryString = "select top 1 AddedDate from RBSYNERGY.IMEIReplacementMaster.tblDealerSales  where DealerCode ='" + SearchByDealer + "' and cast(CONVERT(varchar(8), SalesDate, 112) AS datetime) between '" + SearchBySalesDate + @" 00:00:00' And '" + SearchBySalesDate + @" 23:59:59' order by AddedDate desc";

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
    }
}