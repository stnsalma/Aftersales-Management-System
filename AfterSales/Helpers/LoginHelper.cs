using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using WSMS.DAL;


namespace WSMS.Helpers
{
    public class LoginHelper : HelperBase
    {
        private const string LOGIN_SESSION_KEY = "LOGGED_IN_USER";
        private const string LOGIN_SESSION_KEYS = "LOGGED_IN_USERS";

        public static bool IsLoggedIn
        {
            get
            {
                return (LoggedInUser != null);
            }
        }

        public static string LoggedInUser
        {
            get
            {
                try
                {
                    return (string)Session[LOGIN_SESSION_KEY];
                }
                catch (Exception ex)
                {
                    ValidateLogIn();
                }
                return null;
            }
        }
        public static WSMS.DAL.RepUser LoggedInUsers
        {
            get
            {
                try
                {
                    return (WSMS.DAL.RepUser)Session[LOGIN_SESSION_KEYS];
                }
                catch (Exception ex)
                {
                    ValidateLogIn();
                }
                return null;
            }
        }

        //public static Int32 DoLogin(string UserName, string Password)
        public static Int32 DoLogin(string UserName, string Password)
        {
            WSMSDataContext contx = new WSMSDataContext();
            RepUser objUser = contx.RepUsers.Where(x => x.RepUserName == UserName).FirstOrDefault();
            if (objUser != null && objUser.IsActive == true)
            {
                if (objUser.RepUserName == UserName && objUser.Password == Password)
                {
                    Session[LOGIN_SESSION_KEYS] = objUser;
                    return objUser.RepUserID;
                }
            }
            return -1;
        }

        public static void DoLogOut()
        {
            //if (IsLoggedIn)
            //{
            Session[LOGIN_SESSION_KEYS] = null;
            Response.Redirect("Login.aspx");
            //}
        }

        public static void ValidateLogIn()
        {
            if (!IsLoggedIn)
                Response.Redirect("Login.aspx");
        }

    }
}
