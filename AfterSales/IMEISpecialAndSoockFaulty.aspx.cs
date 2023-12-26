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
    public partial class IMEISpecialAndSoockFaulty : System.Web.UI.Page
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
        public static string LoadIMEIApproved(string UserID, string SearchByDate)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                IMEIApprovedMarketting userControl = (IMEIApprovedMarketting)page.LoadControl("~/Module/IMEIApprovedMarketting.ascx");
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
        public static string UpdateApprovelMasterUpdateIMEIReplacementMaster(string RequestID, string IMEI_1, string IMEI_2,
          
            string AddedBy, string RequestStatus, string Model, string RegistrationDate, string DistributionDate, string RequestType)
        {
            string msg = "";

            Int64 request_value1 = DataAccessHelper.UpdateApprovelMasterUpdateIMEIReplacementMaster(Int64.Parse(RequestID), IMEI_1, IMEI_2,
                AddedBy, RequestStatus, Model, RegistrationDate, DistributionDate, RequestType);

            if (request_value1 >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string UpdateIMEIReplacementMasterForApprovedDecline(string RequestID, string IMEI_1, string IMEI_2, string Model, string RegistrationDate, string DistributionDate, string RequestStatus, string AddedBy)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_value2 = DataAccessHelper.UpdateIMEIReplacementMasterForApprovedDecline(Int64.Parse(RequestID), IMEI_1, IMEI_2, Model, RegistrationDate, DistributionDate, RequestStatus, AddedBy);

            if (request_value2 >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string UpdatetblDisplayProductFromNSM(string DisplayProductID, string AddedBy)
        {
            string msg = "";

            Int64 dis_id22 = DataAccessHelper.UpdatetblDisplayProductFromNSM(Int64.Parse(DisplayProductID), AddedBy);

            if (dis_id22 >= 0)
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
                MarketingReport userControl = (MarketingReport)page.LoadControl("~/Module/MarketingReport.ascx");
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
        public static string LoadDisplayIMEIListByTSO(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                DisplayIMEIListApprovedByNSM userControl = (DisplayIMEIListApprovedByNSM)page.LoadControl("~/Module/DisplayIMEIListApprovedByNSM.ascx");
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