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

namespace WSMS
{
    public partial class SuperAdmin : System.Web.UI.Page
    {
        public string MobileNoList = "";
        public string IMEList = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //LoadUserDetails(0,0);
        }
        public void LoadUserDetails(int ServicePointID, int RoleID)
        {
            //string msg = "";

            //DataSet dsUser = DataAccessHelper.GetUserDetail(ServicePointID,RoleID);
            //if (dsUser.Tables[0].Rows.Count >= 0)
            //{
            //    rptrUserList.DataSource = dsUser;
            //    rptrUserList.DataBind();
            //}
            //else
            //{
            //    rptrUserList.DataSource = null;
            //    rptrUserList.DataBind();
            //}
            
            
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
        public static string LoadUserList(string ServicePointID , string RoleID)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                UserListControl userControl = (UserListControl)page.LoadControl("~/Module/UserListControl.ascx");
                userControl.EnableViewState = false;
                userControl.ServicePointID = ServicePointID;
                userControl.RoleID = RoleID;
            
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
        public static string InsertUser(String UserName,String UserFullName ,String Email, String Password, String Address,String Level,
            String RoleID, String EmployeeCode, String ServicePointID, String AddedBy)
        {
            string msg = "";

            Int32 UserID = DataAccessHelper.InsertUser(UserName,UserFullName, Email, Password, Address,Level, Int32.Parse(RoleID), EmployeeCode, Int32.Parse(ServicePointID), AddedBy);
            if (UserID >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string UpdateUser(string UserID, string ServicePointID, string RoleID, string Password, string IsActive, string AddedBy)
        {
            string msg = "";

            Int32 ServiceAssignID = DataAccessHelper.UpdateUser(Int32.Parse(UserID), Int32.Parse(RoleID), Password.Length>0?Password:string.Empty ,Int32.Parse(ServicePointID),
                                                                 Int32.Parse(IsActive), AddedBy);
            if (ServiceAssignID >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string ValidateEmployeeCode(string EmployeeCode)
        {
            DataSet ds = new DataSet(); ;

            WSMSDataContext contx = new WSMSDataContext();

            string queryString = "select *  from dbo.Users where EmployeeCode = '" + EmployeeCode + "'"; 

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

            adapter.Fill(ds, "Role");
            if (ds.Tables[0].Rows.Count > 0)
            {
                return "err";
            }
            else
                return "success";
        }

        [WebMethod]
        public static string ValidateUserName(string UserName)
        {
            DataSet ds = new DataSet(); ;

            WSMSDataContext contx = new WSMSDataContext();

            string queryString = "select *  from dbo.Users where UserName = '" + UserName + "'";

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

            adapter.Fill(ds, "Role");
            if (ds.Tables[0].Rows.Count > 0)
            {
                return "err";
            }
            else
                return "success";
        }
        [WebMethod]
        public static string ValidateEmail(string Email)
        {
            DataSet ds = new DataSet(); ;

            WSMSDataContext contx = new WSMSDataContext();

            string queryString = "select *  from dbo.Users where Email = '" + Email + "'";

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

            adapter.Fill(ds, "Role");
            if (ds.Tables[0].Rows.Count > 0)
            {
                return "err";
            }
            else
                return "success";
        }

        public static String DDLRole
        {
            get
            {

                string ss = "<select class=\"ddl-role\" style=\"width:150px;height:25px\" id=\"ddlrole\" >" +
                            "<option value=\"0\" selected=\"selected\">All</option>";

                DataSet ds = new DataSet(); ;

                WSMSDataContext contx = new WSMSDataContext();

                string queryString = "select RoleID,RoleName from dbo.Role where IsActive =1";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "Role");

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
        public static String DDLServicePoint
        {
            get
            {

                string ss = "<select class=\"ddl-sp\" style=\"width:190px;height:25px;\" id=\"ddlsp\" >" +
                            "<option value=\"0\" selected=\"selected\">All</option>";

                DataSet ds = new DataSet(); ;

                WSMSDataContext contx = new WSMSDataContext();

                string queryString = "select ServicePointID,ServicePointName from dbo.ServicePoint where IsActive =1";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "Role");

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