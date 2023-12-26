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
    public partial class CorporateStore : System.Web.UI.Page
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
        public static string LoadHandsetForCorporate(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                CorporateStoreReceive userControl = (CorporateStoreReceive)page.LoadControl("~/Module/CorporateStoreReceive.ascx");
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
        public static string LoadHandsetReport(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                CorporateStoreReport userControl = (CorporateStoreReport)page.LoadControl("~/Module/CorporateStoreReport.ascx");
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
        public static string InsertWareHouseCorporateStoreLog(string RequestID, string CorporateStatus, string AddedBy)
        {
            string msg = "";

            Int64 request_ID = DataAccessHelper.InsertWareHouseCorporateStoreLog(Int64.Parse(RequestID), CorporateStatus, AddedBy);

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