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
    public partial class IMEIPrimaryRecommend : System.Web.UI.Page
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
        public static string LoadIMEIPrimaryRecommend(string UserID, string SearchByDate)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                PrimaryRecommend userControl = (PrimaryRecommend)page.LoadControl("~/Module/PrimaryRecommend.ascx");
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
        public static string LoadNewSpecialRequest(string UserID, string SearchByDate)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                SpecialRequest userControl = (SpecialRequest)page.LoadControl("~/Module/SpecialRequest.ascx");
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
        public static string GetIMEReg(string IMENo)
        {


            DataTable dt = new DataTable();

            string returnValue = "err";
            string IME2 = DataAccessHelper.GetIMEAlternate(IMENo);
            if (IME2 == "invalid")
            {
                returnValue = "invalid";
            }

            return returnValue;
        }


        [WebMethod]
        public static string InsertPrimaryRecomLogUpdateIMEIReplacementMaster(string RequestID, string IMEI_1, string IMEI_2,
            string Model, string RegistrationDate, string DistributionDate,
            string AddedBy, string PrimaryRecomStatus)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_value = DataAccessHelper.InsertPrimaryRecomLogUpdateIMEIReplacementMaster(Int64.Parse(RequestID), IMEI_1, IMEI_2, Model,
               RegistrationDate, DistributionDate, AddedBy, PrimaryRecomStatus);

            if (request_value >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }


        [WebMethod]
        public static string InsertDeclinePrimaryRecomLogUpdateIMEIReplacementMaster(string RequestID, string IMEI_1, string IMEI_2,
            string Model, string RegistrationDate, string DistributionDate,
            string AddedBy, string PrimaryRecomStatus)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_value = DataAccessHelper.InsertDeclinePrimaryRecomLogUpdateIMEIReplacementMaster(Int64.Parse(RequestID), IMEI_1, IMEI_2, Model,
               RegistrationDate, DistributionDate, AddedBy, PrimaryRecomStatus);

            if (request_value >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }


        [WebMethod]
        public static string LoadMonitorReport(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                MonitorReport userControl = (MonitorReport)page.LoadControl("~/Module/MonitorReport.ascx");
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
        public static string InsertIMEIReplacementMasterTable(string IMEI_1, string IMEI_2, string Model, string DealerCode,
            string RequestType, string RegistrationDate, string DistributionDate, string Issues,
            string PhoneNumber, string IssueDetails, string IsSeen, string ReplaceIMEI_1, string ReplaceIMEI_2, string ReplaceModel, string RequestStatus, string AddedBy)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_ID = DataAccessHelper.InsertIMEIReplacementMasterTable(IMEI_1, IMEI_2, Model, DealerCode, RequestType,
               RegistrationDate, DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, ReplaceIMEI_1, ReplaceIMEI_2, ReplaceModel, RequestStatus, AddedBy);

            if (request_ID >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string GetRequestedIMEIStatus(string SearchBy)
        {
            if (SearchBy != "")
            {

                DataSet ds = new DataSet();

                string msg = "";


                string queryString = "select IMEI_1,IMEI_2 from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster where IMEI_1='" + SearchBy + "' or  IMEI_2='" + SearchBy + "' ";


                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds);
                    }
                }
                if (ds.Tables[0].Rows.Count > 0)
                {
                    msg = "success";
                }
                else
                {
                    msg = "Data previously not saved";
                }
                return msg;

            }
            else
                return null;
        }


    }
}