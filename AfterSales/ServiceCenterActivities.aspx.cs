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
    public partial class ServiceCenterActivities : System.Web.UI.Page
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
        public static string LoadIMEIRequestByServiceCenter(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                ServiceCenterIMEIRequest userControl = (ServiceCenterIMEIRequest)page.LoadControl("~/Module/ServiceCenterIMEIRequest.ascx");
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
        public static string GetRequestedIMEIInfo(string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                ServiceCenterReplacementIMEIReq userControl = (ServiceCenterReplacementIMEIReq)page.LoadControl("~/Module/ServiceCenterReplacementIMEIReq.ascx");
                userControl.EnableViewState = false;
                //userControl.UserID = UserID;
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
        public static string LoadReportForServiceCenter(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                ServiceCenterReport userControl = (ServiceCenterReport)page.LoadControl("~/Module/ServiceCenterReport.ascx");
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

        // string ReplaceIMEI_1, string ReplaceIMEI_2, string ReplaceModel,
        [WebMethod]
        public static string InsertIntoIMEIReplacementMasterFromServiceCenter(string IMEI_1, string IMEI_2, string Model, string DealerCode,
            string RequestType, string RegistrationDate, string DistributionDate, string Issues,
            string PhoneNumber, string IssueDetails, string IsSeen, string RequestStatus, string AddedBy, string ReplacementGivenBy)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_ID = DataAccessHelper.InsertIntoIMEIReplacementMasterFromServiceCenter(IMEI_1, IMEI_2, Model, DealerCode, RequestType,
               RegistrationDate, DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, RequestStatus, AddedBy, ReplacementGivenBy);

            if (request_ID >= 0)
            {
                msg = "success";

            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        // string ReplaceIMEI_1, string ReplaceIMEI_2, string ReplaceModel,
        [WebMethod]
        public static string InsertRepIMEIIntoIMEIReplacementMasterFromServiceCenter(string RequestID,string ReplaceIMEI_1, string ReplaceIMEI_2, string ReplaceModel)
        {
            string msg = "";
            
            Int64 request_ID = DataAccessHelper.InsertRepIMEIIntoIMEIReplacementMasterFromServiceCenter(Int64.Parse(RequestID), ReplaceIMEI_1, ReplaceIMEI_2, ReplaceModel);

            if (request_ID >= 0)
            {
                msg = "success";

            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        //[WebMethod]
        //public static string GetRequestedIMEIStatus(string SearchBy)
        //{


        //    if (SearchBy != "")
        //    {

        //        DataSet ds = new DataSet();

        //        string msg = "";


        //        string queryString = "select IMEI_1,IMEI_2 from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster where IMEI_1='" + SearchBy + "' or  IMEI_2='" + SearchBy + "' ";


        //        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
        //        {

        //            using (SqlCommand command = new SqlCommand(queryString, connection))
        //            {
        //                SqlDataAdapter da = new SqlDataAdapter(command);
        //                da.Fill(ds);
        //            }
        //        }
        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            msg = "success";
        //        }
        //        else
        //        {
        //            msg = "Data previously not saved";
        //        }
        //        return msg;

        //    }
        //    else
        //        return null;
        //}

        [WebMethod]
        public static string GetIMERegForReplacement(string RepIMENo)
        {

            DataTable dt = new DataTable();

            string returnValue = "err";
            string IME2 = DataAccessHelper.GetIMEAlternate(RepIMENo);
            if (IME2 == "invalid")
            {
                returnValue = "invalid";
            }

            return returnValue;
        }

        public static String DDL
        {
            get
            {

                string ss = "<select class=\"ddl-issue\" style=\"width:150px\" id=\"ddlissue\" >" +
                            "<option value=\"0\" selected=\"selected\">-- Select Problem --</option>";

                DataSet ds = new DataSet(); ;

                WSMSDataContext contx = new WSMSDataContext();

                string queryString = "select IssueID,IssueName,IssueCatagory from dbo.Issues where IsActive =1 order by IssueName";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "Service");

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