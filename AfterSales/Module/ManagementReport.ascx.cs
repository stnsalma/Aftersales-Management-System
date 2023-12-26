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
    public partial class ManagementReport : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();


        }

        public String UserID { get; set; }
        public String SearchBy { get; set; }

        private void LoadData()
        {
            //rptrServicePending.DataSource = GetIMEIByUserID(UserID, SearchBy);
            //rptrServicePending.DataBind();

            DataSet datasource = GetIMEIByUserID(UserID, SearchBy);
            DataTable dtTop = null;
            if (datasource != null)
                dtTop = datasource.Tables[0].Rows.Cast<System.Data.DataRow>().Take(20).CopyToDataTable();
            rptrServicePending.DataSource = dtTop;
            rptrServicePending.DataBind();
        }
        static DataSet ds = null;



        public static DataSet GetIMEIByUserID(string UserID, string SearchBy)
        {


            if (UserID != null && SearchBy != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string[] search = SearchBy.Split(';');

                string queryString = "select irm.*,wp.*,pam.* from RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irm left join RBSYNERGY.IMEIReplacementMaster.WareHouseApproval wp on wp.RequestID=irm.RequestID left join WSMS.ReplaceMentdb.PlazaAndRSM pam on irm.DealerCode=pam.PlazaAndRSMCode where irm.RequestStatus in ('ManagementApproved','ManagementDeclined') ";
                if (search[0] == "Date")
                {

                    queryString = "select irm.*,wp.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irm left join RBSYNERGY.IMEIReplacementMaster.WareHouseApproval wp on wp.RequestID=irm.RequestID left join WSMS.ReplaceMentdb.PlazaAndRSM pam on irm.DealerCode=pam.PlazaAndRSMCode where irm.RequestStatus in ('ManagementApproved','ManagementDeclined') and cast(CONVERT(varchar(8), irm.UpdatedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";

                }
                else if (search[0] == "IMEI")
                {

                    queryString = " select irm.*,wp.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irm left join RBSYNERGY.IMEIReplacementMaster.WareHouseApproval wp on wp.RequestID=irm.RequestID left join WSMS.ReplaceMentdb.PlazaAndRSM pam on irm.DealerCode=pam.PlazaAndRSMCode where irm.RequestStatus in ('ManagementApproved','ManagementDeclined') and (irm.IMEI_1= '" + search[1] + "' or irm.IMEI_2= '" + search[1] + "') ";
                }
                else if (search[0] == "requestID")
                {
                    queryString = "select irm.*,wp.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irm left join RBSYNERGY.IMEIReplacementMaster.WareHouseApproval wp on wp.RequestID=irm.RequestID left join WSMS.ReplaceMentdb.PlazaAndRSM pam on irm.DealerCode=pam.PlazaAndRSMCode where irm.RequestStatus in ('ManagementApproved','ManagementDeclined') and irm.RequestID='" + search[1] + "' ";
                
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