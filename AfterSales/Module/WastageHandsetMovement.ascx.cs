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

namespace WSMS.Module
{
    public partial class WastageHandsetMovement : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        public String UserID { get; set; }
        public String SearchBy { get; set; }

        private void LoadData()
        {

            DataSet datasource = GetServiceByUserID(UserID, SearchBy);
            DataTable dtTop = null;
            if (datasource != null)
                dtTop = datasource.Tables[0].Rows.Cast<System.Data.DataRow>().Take(20).CopyToDataTable();
            rptrServicePending.DataSource = dtTop;
            rptrServicePending.DataBind();

        }
        static DataSet ds = null;

        public static DataSet GetServiceByUserID(string UserID, string SearchBy)
        {

            if (UserID != null && SearchBy != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string[] search = SearchBy.Split(';');
                string queryString = "select im.AddedBy,ru.RepUserID,ru.ZoneID,im.RequestID,wi.AddedDate as WastageReceivedDate, im.RequestDate,im.IMEI_1,im.IMEI_2,im.Model,ru.RepUserFullName as ServicePointName, par.PlazaAndRSMCode as ServicePointID,im.RequestStatus,im.Issues from RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.IMEIReplacementMaster.WastageManagementInventory wi on wi.RequestID=im.RequestID left join WSMS.ReplaceMentdb.RepUsers ru on im.AddedBy=ru.RepUserID left join WSMS.ReplaceMentdb.PlazaAndRSM par on par.PlazaAndRSMID=ru.PlazaAndRSMID where im.RequestStatus='WastageReceived' ";

                if (search[0] == "Date1")
                {
                    queryString += "and cast(CONVERT(varchar(8), wi.AddedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";
                }
                else if (search[0] == "IMEI1")
                {
                    queryString += "and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "') ";
                }

                else if (search[0] == "RequestID1")
                {

                    queryString += "and im.RequestID= '" + search[1] + "' ";

                }

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RBSYNERGYConnectionString"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 1800;
                adapter.Fill(ds, "Service1");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return ds;
                }
                else
                    return null;
            }
            else
                return null;

        }
    }
}