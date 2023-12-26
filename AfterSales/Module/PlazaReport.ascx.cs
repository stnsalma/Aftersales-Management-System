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
    public partial class PlazaReport : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();


        }

        public String UserID { get; set; }
        public String SearchBy { get; set; }

        //private void LoadData()
        //{
        //    rptrServicePending.DataSource = GetServiceByUserID(UserID, SearchBy);
        //    rptrServicePending.DataBind();
        //}

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

            //if (SearchBy != "undefined")
            //{

            if (UserID != null && SearchBy != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                //   String queryString; 
                string[] search = SearchBy.Split(';');



                //string queryString = "select * from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster where RequestStatus in ('Approved','ApprovedDeclined') order by UpdatedDate desc ";
                //string queryString = "select top 20 im.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','Approved Declined','WareHouse Received','WareHouse Declined') and  pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc ";
               // string queryString = "select  im.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where  pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc ";

                string queryString="select  im.RequestID,im.IMEI_1,im.IMEI_2,im.Model,im.DealerCode,im.RegistrationDate,im.DistributionDate,im.RequestType,im.Issues,im.RequestStatus,rl.AppDeclinedRemarks from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.ReplacementLog rl on rl.RequestID=im.RequestID where  pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc ";


                if (search[0] == "Date")
                {
                    //queryString = "select * from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster where RequestStatus in ('Approved','ApprovedDeclined') and cast(CONVERT(varchar(8), RequestDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' order by UpdatedDate desc";
                   // queryString = "select im.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','Approved Declined','WareHouse Received','WareHouse Declined') and cast(CONVERT(varchar(8), im.RequestDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc ";
                   // queryString = "select im.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where cast(CONVERT(varchar(8), im.RequestDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc ";

                    queryString = "select  im.RequestID,im.IMEI_1,im.IMEI_2,im.Model,im.DealerCode,im.RegistrationDate,im.DistributionDate,im.RequestType,im.Issues,im.RequestStatus,rl.AppDeclinedRemarks from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.ReplacementLog rl on rl.RequestID=im.RequestID where cast(CONVERT(varchar(8), im.RequestDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc ";


                }
                else if (search[0] == "IMEI")
                {

                  //  queryString = "select * from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster where RequestStatus in ('Approved','ApprovedDeclined') and (IMEI_1= '" + search[1] + "' or IMEI_2= '" + search[1] + "') order by UpdatedDate desc";
                   // queryString = "select im.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','Approved Declined','WareHouse Received','WareHouse Declined') and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "') and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc";
                   // queryString = "select im.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "') and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc";                   
                
                     queryString = "select  im.RequestID,im.IMEI_1,im.IMEI_2,im.Model,im.DealerCode,im.RegistrationDate,im.DistributionDate,im.RequestType,im.Issues,im.RequestStatus,rl.AppDeclinedRemarks from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.ReplacementLog rl on rl.RequestID=im.RequestID where (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "') and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc";

                }

                else if (search[0] == "DealerCode")
                {
                    //queryString = "select * from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster where RequestStatus in ('Approved','ApprovedDeclined') and DealerCode='" + search[1] + "' order by UpdatedDate desc";
                    //queryString = "select im.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','Approved Declined','WareHouse Received','WareHouse Declined') and im.DealerCode='" + search[1] + "' and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc";
                    //queryString = "select im.*,pam.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.DealerCode='" + search[1] + "' and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc";
                  queryString = "select  im.RequestID,im.IMEI_1,im.IMEI_2,im.Model,im.DealerCode,im.RegistrationDate,im.DistributionDate,im.RequestType,im.Issues,im.RequestStatus,rl.AppDeclinedRemarks from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.ReplacementLog rl on rl.RequestID=im.RequestID where im.DealerCode='" + search[1] + "' and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' order by im.UpdatedDate desc";
                }
                // return msg;
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