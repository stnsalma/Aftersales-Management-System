using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using WSMS.Module;
using System.IO;
using WSMS.Helpers;
using WSMS.DAL;
using System.Web.Script.Serialization;

namespace WSMS
{
    public partial class StockReconciliationForTSO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = CommonHelper.GetSiteHost(false);

            if (Session["LOGGED_IN_USERS"] == null)
            {
                Response.Redirect(url + "Login.aspx", true);
            }

        }

        public static Int64 UserID
        {
            get
            {
                try
                {
                    return LoginHelper.LoggedInUsers.RepUserID;
                }
                catch (Exception ex)
                {

                    return 0;
                }

            }
        }
        private static Int64 UserIDQueryString
        {
            get
            {
                return CommonHelper.QueryStringInt("userID");
            }
        }


        [WebMethod]
        public static string LoadAreaStockReconciliation(string UserID, string SearchBy1)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                StockReconciliation userControl = (StockReconciliation)page.LoadControl("~/Module/StockReconciliation.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
                userControl.SearchBy1 = SearchBy1;

                page.Controls.Add(userControl);

                StringWriter textWriter = new StringWriter();
                HttpContext.Current.Server.Execute(page, textWriter, false);
                return textWriter.ToString();
            }
            catch (Exception ex)
            {
                return "err";
            }
        }
        [WebMethod]
        public static string LoadDisplayEntry(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                DisplayProductEntryByTso userControl = (DisplayProductEntryByTso)page.LoadControl("~/Module/DisplayProductEntryByTso.ascx");
                userControl.EnableViewState = false;
                DisplayProductEntryByTso.UserID = UserID;
                userControl.SearchBy = SearchBy;

                page.Controls.Add(userControl);

                StringWriter textWriter = new StringWriter();
                HttpContext.Current.Server.Execute(page, textWriter, false);
                return textWriter.ToString();
            }
            catch (Exception ex)
            {
                return "err";
            }
        }

        [WebMethod]
        public static string LoadDayWiseDealerSales(string UserID, string SearchByDealer, string SearchBySalesDate)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                DayWiseDealerSalesEntryFromTSO userControl = (DayWiseDealerSalesEntryFromTSO)page.LoadControl("~/Module/DayWiseDealerSalesEntryFromTSO.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
                userControl.SearchByDealer = SearchByDealer;
                userControl.SearchBySalesDate = SearchBySalesDate;

                page.Controls.Add(userControl);

                StringWriter textWriter = new StringWriter();
                HttpContext.Current.Server.Execute(page, textWriter, false);
                return textWriter.ToString();
            }
            catch (Exception ex)
            {
                return "err";
            }
        }

        //[WebMethod]
        //public static string InserttblStockReconciliation(string DealerName, string DealerCode, string itemArray, string AddedBy)
        //{
        //    string msg = "";
        //    string[] ItemArray = null;
        //    if (itemArray.Count() > 0)
        //    {
        //        ItemArray = itemArray.Remove(itemArray.Count() - 2, 2).Split(';');

        //    }
        //    Int64 stock_ID = 0;
        //    if (itemArray.Count() > 0)
        //    {
        //        for (int i = 0; i < ItemArray.Count(); i++)
        //        {
        //            string data = ItemArray[i];
        //            if (data.StartsWith(","))
        //            {
        //                data = data.Remove(0, 1);
        //            }
        //            if (data.EndsWith(","))
        //            {
        //                data = data.Remove(data.Count() - 1, 1);
        //            }
        //            string[] Items = data.Split(',');
        //            stock_ID = DataAccessHelper.InserttblStockReconciliation(DealerName, DealerCode,AddedBy, Items[0].ToString(), Int64.Parse(Items[1]), Int64.Parse(Items[2]));
        //        }

        //    }


        //    if (stock_ID >= 0)
        //    {
        //        msg = "success";
        //    }

        //    else
        //        msg = "Data can not be saved";
        //    return msg;
        //}
        [WebMethod]
        public static string InserttblStockReconciliation(string DealerName, string DealerCode, string itemArray, string AddedBy)
        {
            string msg = "";
            string[] ItemArray = null;
            Int64 stock_ID = 0;
            if (itemArray.Count() > 0)
            {
                ItemArray = itemArray.Remove(itemArray.Count() - 2, 2).Split(';');
                for (int i = 0; i < ItemArray.Count(); i++)
                {
                    string data = ItemArray[i];
                    if (data.StartsWith(","))
                    {
                        data = data.Remove(0, 1);
                    }
                    //if (data.EndsWith(","))
                    //{
                    //    data = data.Remove(data.Count() - 1, 1);
                    //}
                    string[] Items = data.Split(',');
                    stock_ID = DataAccessHelper.InserttblStockReconciliation(DealerName, DealerCode, AddedBy, Items[0].ToString(), Items[1].ToString(), Items[2].ToString());
                }
            }

            //if (itemArray.Count()> 0)
            //{
            //    for (int i = 0; i < ItemArray.Count(); i++)
            //    {
            //        string data = ItemArray[i];
            //        if (data.StartsWith(","))
            //        {
            //            data = data.Remove(0, 1);
            //        }
            //        if (data.EndsWith(","))
            //        {
            //            data = data.Remove(data.Count() - 1, 1);
            //        }
            //        string[] Items = data.Split(',');
            //        stock_ID = DataAccessHelper.InserttblStockReconciliation(DealerName, DealerCode, AddedBy, Items[0].ToString(), Int64.Parse(Items[1]), Int64.Parse(Items[2]));
            //    }

            //}


            if (stock_ID >= 0)
            {
                msg = "success";
            }

            else
                msg = "Data can not be saved";
            return msg;
        }
        [WebMethod]
        public static string InsertIntotblDisplayProduct(string IMEI_1, string IMEI_2, string Model, string DealerCode, string DisplayDate, string AddedBy)
        {
            string msg = "";

            Int64 dis_id = DataAccessHelper.InsertIntotblDisplayProduct(IMEI_1, IMEI_2, Model, DealerCode, DisplayDate, AddedBy);

            if (dis_id >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string InsertIntotblDealerSales(string DealerCode, string SalesDate, string itemArray, string AddedBy)
        {
            string msg = "";
            string[] ItemArray = null;
            Int64 stock_ID = 0;
            if (itemArray.Count() > 0)
            {
                ItemArray = itemArray.Remove(itemArray.Count() - 2, 2).Split(';');
                for (int i = 0; i < ItemArray.Count(); i++)
                {
                    string data = ItemArray[i];
                    if (data.StartsWith(","))
                    {
                        data = data.Remove(0, 1);
                    }

                    string[] Items = data.Split(',');
                    stock_ID = DataAccessHelper.InsertIntotblDealerSales(DealerCode, SalesDate, AddedBy, Items[0].ToString(), Items[1].ToString());
                }
            }

            if (stock_ID >= 0)
            {
                msg = "success";
            }

            else
                msg = "Data can not be saved";
            return msg;
        }

        public static String DDLDealerName
        {
            get
            {

                string ss = "<select class=\"ddl-dealer\" style=\"width:199px\" id=\"ddldealer\" >" +
                            "<option value=\"0\" selected=\"selected\">---- Select Dealer Name ----</option>";

                DataSet ds = new DataSet();

                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID.ToString())).FirstOrDefault();

                string queryString = "select PlazaAndRSMCode,Organaization_Name from WSMS.ReplaceMentdb.PlazaAndRSM where ZoneID not in (1,7,13,19,40) and ZoneID='" + user.ZoneID + "' order by Organaization_Name";

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
        }
    }
}