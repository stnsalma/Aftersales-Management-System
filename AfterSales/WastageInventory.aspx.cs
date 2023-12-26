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
    public partial class WastageInventory : System.Web.UI.Page
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
        public static string LoadHandsetReceive(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                WastageHandsetReceive userControl = (WastageHandsetReceive)page.LoadControl("~/Module/WastageHandsetReceive.ascx");
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
        public static string LoadHandsetMovement(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                WastageHandsetMovement userControl = (WastageHandsetMovement)page.LoadControl("~/Module/WastageHandsetMovement.ascx");
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
        public static string LoadWastageReport(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                WastageReport userControl = (WastageReport)page.LoadControl("~/Module/WastageReport.ascx");
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
        public static string InsertWastageManagement(string RequestID,string IMEI_1, string IMEI_2, string Model,
            string ServicePointID, string RequestStatus, string AddedBy)
        {
            string msg = "";

            Int64 request_ID = DataAccessHelper.InsertWastageManagement(Int64.Parse(RequestID), IMEI_1, IMEI_2, Model, ServicePointID, RequestStatus, AddedBy);

            if (request_ID >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string InsertWarCorporateUpdateWastageLog(string RequestID, string DeliverTo, string StatusFromWastage, string AddedBy)
        {
            string msg = "";

            Int64 request_ID = DataAccessHelper.InsertWarCorporateUpdateWastageLog(Int64.Parse(RequestID), DeliverTo, StatusFromWastage, AddedBy);

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