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
    public partial class PrimaryRecommend : System.Web.UI.UserControl
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();


        }

        public String UserID { get; set; }
        public String SearchByDate { get; set; }
        // public String SearchByIMEI { get; set; }

        private void LoadData()
        {
            //rptrServicePending.DataSource = GetServiceByUserID(UserID, SearchByDate);
            //rptrServicePending.DataBind();

            DataSet datasource = GetServiceByUserID(UserID, SearchByDate);
            DataTable dtTop = null;
            if (datasource != null)
                dtTop = datasource.Tables[0].Rows.Cast<System.Data.DataRow>().Take(20).CopyToDataTable();
            rptrServicePending.DataSource = dtTop;
            rptrServicePending.DataBind();
        }
        static DataSet ds = null;

        public static DataSet GetServiceByUserID(string UserID, string SearchByDate)
        {



            if (UserID != null && SearchByDate != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                //   String queryString; 
                string[] search = SearchByDate.Split(';');

                //string queryString = "select top 100 td.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.dbo.tblDealerInfo td on im.DealerCode=td.DealerCode where im.RequestStatus='Requested'";

                string queryString = "select pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.RequestID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus='Requested' and pam.ZoneID='" + user.ZoneID + "' ";

                if (search[0] == "Date")
                {
                    //queryString = "select td.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.dbo.tblDealerInfo td on im.DealerCode=td.DealerCode where im.RequestStatus='Requested' and cast(CONVERT(varchar(8), im.RequestDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59'";
                    queryString = "select pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.RequestID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus='Requested' and cast(CONVERT(varchar(8), im.RequestDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' and pam.ZoneID='" + user.ZoneID + "' ";
                }
                else if (search[0] == "IMEI")
                {

                   // queryString = "select td.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.dbo.tblDealerInfo td on im.DealerCode=td.DealerCode where im.RequestStatus='Requested' and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "')";

                    //queryString += " and sm.ServiceID = '" + search[1] + "' and ServiceStatus ='Deliverable' order by sm.ServiceID desc";
                    queryString = "select pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.RequestID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus='Requested' and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' ";
                
                }
                else if (search[0] == "DealerCode")
                {
                  //  queryString = "select td.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.dbo.tblDealerInfo td on im.DealerCode=td.DealerCode where im.RequestStatus='Requested' and td.DealerCode='" + search[1] + "' ";
                    queryString = "select pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.RequestID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus='Requested' and pam.PlazaAndRSMCode='" + search[1] + "' and pam.ZoneID='" + user.ZoneID + "' ";
                
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