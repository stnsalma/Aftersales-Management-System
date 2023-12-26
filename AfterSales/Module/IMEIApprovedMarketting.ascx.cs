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
    public partial class IMEIApprovedMarketting : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();


        }

        public String UserID { get; set; }
        public String SearchByDate { get; set; }
    

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

                string[] search = SearchByDate.Split(';');

                //string queryString = "select pam.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('StockFaulty','Special Case','Display')";
               
                ///recent/string queryString = "select prl.PrimaryRecomDate,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.PrimaryRecomLog prl on prl.RequestID=im.RequestID where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('StockFaulty','Special Case','Display') ";
                string queryString = "select prl.PrimaryRecomDate,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.PrimaryRecomLog prl on prl.RequestID=im.RequestID where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('Special Case','Display') ";

                if (search[0] == "Date")
                {

                           
                    // queryString = "select pam.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('StockFaulty','Special Case','Display') and cast(CONVERT(varchar(8), im.UpdatedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";
                    // queryString = "select pam.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('StockFaulty','Special Case','Display') and cast(CONVERT(varchar(8), im.UpdatedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";
                     ///recent//queryString = "select prl.PrimaryRecomDate,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.PrimaryRecomLog prl on prl.RequestID=im.RequestID where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('StockFaulty','Special Case','Display') and cast(CONVERT(varchar(8), im.UpdatedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";

                    queryString = "select prl.PrimaryRecomDate,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.PrimaryRecomLog prl on prl.RequestID=im.RequestID where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('Special Case','Display') and cast(CONVERT(varchar(8), im.UpdatedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";
                
                }
                else if (search[0] == "IMEI")
                {
                   
                   // queryString = "select pam.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('StockFaulty','Special Case','Display') and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "')";
                    
                    //recent//queryString = "select  prl.PrimaryRecomDate,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.PrimaryRecomLog prl on prl.RequestID=im.RequestID  where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('StockFaulty','Special Case','Display') and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "')";

                    queryString = "select  prl.PrimaryRecomDate,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCode,pam.ZoneID,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode left join RBSYNERGY.IMEIReplacementMaster.PrimaryRecomLog prl on prl.RequestID=im.RequestID  where im.RequestStatus='PrimaryRecommended' and im.RequestType in ('Special Case','Display') and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "')";
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