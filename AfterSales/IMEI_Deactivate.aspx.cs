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
    public partial class IMEI_Deactivate : System.Web.UI.Page
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
        public static string LoadIMEIRecommend(string UserID, string SearchByDate)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                IMEIRecommendMonitoring userControl = (IMEIRecommendMonitoring)page.LoadControl("~/Module/IMEIRecommendMonitoring.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
                userControl.SearchByDate = SearchByDate;
                //userControl.SearchByIMEI = SearchByIMEI;

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
        public static string InsertReplacementLogInsertApprovelMasterUpdateMaster(string RequestID, string IMEI_1, string IMEI_2, 
            string Model,string RegistrationDate, string DistributionDate,
            string AddedBy, string RequestStatus,string RequestType)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_value = DataAccessHelper.InsertReplacementLogInsertApprovelMasterUpdateMaster(Int64.Parse(RequestID), IMEI_1, IMEI_2, Model, 
               RegistrationDate, DistributionDate, AddedBy,RequestStatus,RequestType );

            if (request_value >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string InsertDeclineReplacementLogUpdateMaster(string RequestID, string IMEI_1, string IMEI_2,
            string Model, string RegistrationDate, string DistributionDate,
            string AddedBy, string RequestStatus, string AppDeclinedRemarks)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_value1 = DataAccessHelper.InsertDeclineReplacementLogUpdateMaster(Int64.Parse(RequestID), IMEI_1, IMEI_2, Model,
               RegistrationDate, DistributionDate, AddedBy, RequestStatus, AppDeclinedRemarks);

            if (request_value1 >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string LoadMonitoringAndMarkettingReport(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                MonitoringAndMarkettingReport userControl = (MonitoringAndMarkettingReport)page.LoadControl("~/Module/MonitoringAndMarkettingReport.ascx");
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
        public static string LoadDeclinedIMEIRequest(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                DeclinedFinalPhase userControl = (DeclinedFinalPhase)page.LoadControl("~/Module/DeclinedFinalPhase.ascx");
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
        public static string InsertManagementApprovalLog(string RequestID, string IMEI_1, string IMEI_2, string Model,
        string RegistrationDate, string DistributionDate,
        string WarehouseDeclinedDate, string ManagementStatus, string AddedBy)
        {
            string msg = "";

            Int64 request_ID = DataAccessHelper.InsertManagementApprovalLog(Int64.Parse(RequestID), IMEI_1, IMEI_2, Model,
                RegistrationDate, DistributionDate, WarehouseDeclinedDate, ManagementStatus, AddedBy);

            if (request_ID >= 0)
            {
                msg = "success";
            }
            else

                msg = "Data can not be saved";
            return msg;

        }
    }
}