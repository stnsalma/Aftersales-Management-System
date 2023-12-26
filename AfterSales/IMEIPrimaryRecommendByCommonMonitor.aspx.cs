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
    public partial class IMEIPrimaryRecommendByCommonMonitor : System.Web.UI.Page
    {
        //#region authorization
        //protected void Page_PreInit(object sender, EventArgs e)
        //{
        //    if (Page.User.Identity.Name == null)
        //    {
        //        Response.Redirect("Login.aspx");
        //    }
        //    if (Convert.ToInt32(Page.User.Identity.Name) == 0)
        //    {
        //        Response.Redirect("Login.aspx");
        //    }
        //    if (!(User.IsInRole("12")))
        //    {
        //        Response.Redirect("Login.aspx");
        //    }

        //}
        //#endregion
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
                PrimaryRecommendByCommonMonitor userControl = (PrimaryRecommendByCommonMonitor)page.LoadControl("~/Module/PrimaryRecommendByCommonMonitor.ascx");
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
                SpecialRequestByCommonMonitor userControl = (SpecialRequestByCommonMonitor)page.LoadControl("~/Module/SpecialRequestByCommonMonitor.ascx");
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
                MonitorReportByCommonMonitor userControl = (MonitorReportByCommonMonitor)page.LoadControl("~/Module/MonitorReportByCommonMonitor.ascx");
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
        public static string LoadDealerDistributionDetails(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                DealerHistory userControl = (DealerHistory)page.LoadControl("~/Module/DealerHistory.ascx");
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
        public static string LoadPlazaAndRSMTable(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                DealerHistoryIntoPlazaAndRSM userControl = (DealerHistoryIntoPlazaAndRSM)page.LoadControl("~/Module/DealerHistoryIntoPlazaAndRSM.ascx");
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

        static DataSet ds = null;

        [WebMethod]
        public static string GetRequestedIMEIStatus(string UserID, string SearchBy, string RequestedValue)
        {

            if (SearchBy != "")
            {

                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                DataSet ds1 = new DataSet();
                DataSet ds2 = new DataSet();
                DataSet ds3 = new DataSet();
                DataSet ds4 = new DataSet();
                DataSet ds5 = new DataSet();
                DataSet ds6 = new DataSet();
                DataSet ds7 = new DataSet();

                string msg = "";

                string queryString1 = "select IMEI_1,IMEI_2,RequestDate from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster where IMEI_1='" + SearchBy + "' or  IMEI_2='" + SearchBy + "'  order by RequestID desc";


                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString1, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds1);
                    }
                }

                string queryString2 = "select pr.RegistrationDate from RBSYNERGY.dbo.tblbarcodeinv tbrc left join RBSYNERGY.dbo.tblproductregistration pr on (pr.ProductID=tbrc.BarCode or pr.ProductID=tbrc.BarCode2) where tbrc.BarCode='" + SearchBy + "' or tbrc.BarCode2='" + SearchBy + "' ";


                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString2, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds2);
                    }
                }

                string queryString3 = "select IMEI_1,IMEI_2,DealerCode from RBSYNERGY.IMEIReplacementMaster.tblDisplayProduct where IMEI_1='" + SearchBy + "' or  IMEI_2='" + SearchBy + "' ";


                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString3, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds3);
                    }
                }
                string queryString4 = String.Format(@"select tddd.DistributionDate,
                case when  DATEDIFF(day,tddd.DistributionDate,getdate())<= 365 then 'YES' else 'NO' end as DistributionDateRange , DATEDIFF(day,tddd.DistributionDate,getdate()) as totalDays
                from RBSYNERGY.dbo.tblbarcodeinv tbrc 
                left join RBSYNERGY.dbo.tblDealerDistributionDetails tddd on (tddd.BarCode='" + SearchBy + "' or tddd.BarCode2='" + SearchBy + "')  where (tbrc.BarCode='" + SearchBy + "' or tbrc.BarCode2='" + SearchBy + "') ");

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString4, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds4);
                    }
                }

                string queryString5 = String.Format(@"select tddd.DistributionDate,
                case when  DATEDIFF(day,tddd.DistributionDate,getdate())<= 547 then 'YES' else 'NO' end as DistributionDateRange , DATEDIFF(day,tddd.DistributionDate,getdate()) as totalDays
                from RBSYNERGY.dbo.tblbarcodeinv tbrc 
                left join RBSYNERGY.dbo.tblDealerDistributionDetails tddd on (tddd.BarCode='" + SearchBy + "' or tddd.BarCode2='" + SearchBy + "')  where (tbrc.BarCode='" + SearchBy + "' or tbrc.BarCode2='" + SearchBy + "') ");

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString5, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds5);
                    }
                }

                string queryString6 = String.Format(@"select * from RBSYNERGY.dbo.tblDealerDistributionDetails tddd where tddd.BarCode='" + SearchBy + "' or tddd.BarCode2='" + SearchBy + "'");

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString6, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds6);
                    }
                }

                string queryString7 = String.Format(@"select * from RBSYNERGY.dbo.tblDealerDistributionDetails tddd left join WSMS.ReplaceMentdb.PlazaAndRSM par on par.PlazaAndRSMCode = tddd.DealerCode where tddd.BarCode='" + SearchBy + "' or tddd.BarCode2='" + SearchBy + "' ");

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString7, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds7);
                    }
                }


                if (ds6.Tables[0].Rows.Count == 0)
                {
                    msg = "tblDealerDisDetails";

                }
                // ReSharper disable once ConditionIsAlwaysTrueOrFalse
                else if (ds7.Tables[0].Rows.Count > 0 && !(user == null || (user.ZoneID == 98 || user.ZoneID == 97 || user.ZoneID == 10 || user.ZoneID == 31)) && ds7.Tables[0].Rows[0]["Organaization_Name"].ToString() == "" && ds7.Tables[0].Rows[0]["PlazaAndRSMCode"].ToString() == "" && ds7.Tables[0].Rows[0]["ZoneID"].ToString() == "")
                {
                    msg = "plazaAndRSM";

                }

                else if (ds1.Tables[0].Rows.Count > 0)
                {
                    DateTime reqDate = (DateTime)ds1.Tables[0].Rows[0]["RequestDate"];
                    string requestDate = reqDate.ToString("yyyy-MM-dd");

                    Console.Write("reqDate  :" + reqDate);
                    Console.Write("requestDate  :" + requestDate);

                    List<String> lstOfAnswers = new List<String>();
                    lstOfAnswers.Add("success");
                    lstOfAnswers.Add(requestDate);


                    msg = lstOfAnswers[0] + " " + lstOfAnswers[1];

                    Console.Write("msg :" + msg);

                }


                else if (ds2.Tables[0].Rows[0]["RegistrationDate"].ToString() == "" && RequestedValue == "special")
                {

                    msg = "RegDateNull";

                }
                else if (!(user == null || (user.ZoneID == 10 || user.ZoneID == 31 || user.ZoneID == 98 || user.ZoneID == 97)) && ds3.Tables[0].Rows.Count == 0 && RequestedValue == "RegisterednotRegisteredDisplay")
                {
                    msg = "tblDisplayPro";

                }
                else if (user != null && ds5.Tables[0].Rows[0]["DistributionDate"].ToString() != "" && ds5.Tables[0].Rows[0]["DistributionDateRange"].ToString() == "NO" && (user.ZoneID == 10 || user.ZoneID == 31 || user.ZoneID == 98 || user.ZoneID == 97) && RequestedValue == "RegisterednotRegisteredDisplay")
                {

                    var distriDate4 = (DateTime)ds5.Tables[0].Rows[0]["DistributionDate"];
                    string distriDate41 = distriDate4.ToString("yyyy-MM-dd");

                    string disDateRang = (string)ds5.Tables[0].Rows[0]["DistributionDateRange"];
                    Console.Write("disDateRang  :" + disDateRang);

                    List<String> lstOfAnswers = new List<String>();
                    lstOfAnswers.Add("displayForPlaza");
                    lstOfAnswers.Add(distriDate41);
                    lstOfAnswers.Add(disDateRang);


                    msg = lstOfAnswers[0] + " " + lstOfAnswers[1];

                    Console.Write("msg :" + msg);

                }


                else if (ds4.Tables[0].Rows[0]["DistributionDate"].ToString() != "" && ds4.Tables[0].Rows[0]["DistributionDateRange"].ToString() == "NO" && RequestedValue == "special")
                {

                    var distriDate4 = (DateTime)ds4.Tables[0].Rows[0]["DistributionDate"];
                    string distriDate41 = distriDate4.ToString("yyyy-MM-dd");

                    string disDateRang = (string)ds4.Tables[0].Rows[0]["DistributionDateRange"];
                    Console.Write("disDateRang  :" + disDateRang);

                    List<String> lstOfAnswers = new List<String>();
                    lstOfAnswers.Add("DisDateSuccess");
                    lstOfAnswers.Add(distriDate41);
                    lstOfAnswers.Add(disDateRang);


                    msg = lstOfAnswers[0] + " " + lstOfAnswers[1];

                    Console.Write("msg :" + msg);

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

        [WebMethod]
        public static string InsertDistributionRecord(string IMEI_1, string IMEI_2, string Model, string DealerCode,
            string DONumber, string DistributionDate)
        {


            string msg = "";
            Int64 afterServiceRepID = DataAccessHelper.InsertDistributionRecord(IMEI_1, IMEI_2, Model, DealerCode, DONumber, DistributionDate);

            if (afterServiceRepID >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string InsertPlazaAndRsmRecord(string DealerCode, string DealerName, string ZoneID)
        {
            string msg = "";
            Int64 afterServiceRepID = DataAccessHelper.InsertPlazaAndRsmRecord(DealerCode, DealerName, ZoneID);

            if (afterServiceRepID >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }
    }
}