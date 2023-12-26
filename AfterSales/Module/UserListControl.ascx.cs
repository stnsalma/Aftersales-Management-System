using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using WSMS.DAL;
using WSMS.Helpers;

namespace WSMS.Module
{
    public partial class UserListControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadData();
            }
            
        }
        public String ServicePointID { get; set; }
        public String RoleID { get; set; }    

        private void LoadData()
        {
            rptrUserList.DataSource = GetUser(string.IsNullOrEmpty(ServicePointID)?"0":ServicePointID, string.IsNullOrEmpty(RoleID)?"0":RoleID);
            rptrUserList.DataBind();
        }
        static DataSet ds = null;
        public static DataSet GetUser(String ServicePointID, String RoleID)
        {
            
            ds = new DataSet();
            ds = DataAccessHelper.GetUserDetail(Int32.Parse(ServicePointID), Int32.Parse(RoleID));
            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds;
            }
            else
                return null;
        }


        public static String DDLRole
        {
            get
            {

                string ss = "<select class=\"ddl-role\" style=\"width:150px;height:25px\" id=\"ddlrole\" >" ;

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

                string ss = "<select class=\"ddl-sp\" style=\"width:190px;height:25px;\" id=\"ddlsp\" >" ;

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