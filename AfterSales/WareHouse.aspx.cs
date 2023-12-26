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
    public partial class WareHouse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
        public static string LoadWareHouseRequest(string UserID, string SearchByDate)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                WareHouseApproval userControl = (WareHouseApproval)page.LoadControl("~/Module/WareHouseApproval.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
                userControl.SearchByDate = SearchByDate;

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
        public static string ReceiveInsertWareHouseApproval(string RequestID, string IMEI_1, string IMEI_2, string WAppStatus, string Reason, string AddedBy)
        {
            string msg = "";

            Int64 request_value1 = DataAccessHelper.ReceiveInsertWareHouseApproval(Int64.Parse(RequestID),IMEI_1,IMEI_2, WAppStatus, Reason, AddedBy);

            if (request_value1 >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string DeclineInsertWareHouseApproval(string RequestID, string WAppStatus, string Reason, string AddedBy)
        {
            string msg = "";

            Int64 request_value1 = DataAccessHelper.DeclineInsertWareHouseApproval(Int64.Parse(RequestID), WAppStatus, Reason, AddedBy);

            if (request_value1 >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string LoadHandsetFromWastageMgt(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                HandsetFromWastageMgtToWarehouse userControl = (HandsetFromWastageMgtToWarehouse)page.LoadControl("~/Module/HandsetFromWastageMgtToWarehouse.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
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
        public static string InsertCorporateStoreLogFromWarehouse(string RequestID, string IMEI_1,string IMEI_2, string WareHouseStatus, string AddedBy)
        {
            string msg = "";

            Int64 request_ID = DataAccessHelper.InsertCorporateStoreLogFromWarehouse(Int64.Parse(RequestID),IMEI_1,IMEI_2, WareHouseStatus, AddedBy);

            if (request_ID >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string LoadWastageReport(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                WastageSetReportForWarehouse userControl = (WastageSetReportForWarehouse)page.LoadControl("~/Module/WastageSetReportForWarehouse.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
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
        public static string LoadWarehouseReport(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                WarehouseReport userControl = (WarehouseReport)page.LoadControl("~/Module/WarehouseReport.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
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


    }
}