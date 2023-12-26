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
    public partial class PrintActiveReplacementServiceIDFromPlaza : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadData();
            }

        }

         //public String UserID { get; set; }
        public String SearchBy { get; set; }


        //Int64.Parse(SearchBy)
        //string SerarchBy2 = Int64.Parse(SearchBy);

        private void LoadData()
        {
            rptrActiveServiceIDfromPlaza.DataSource = GetServiceIDByServiceID(SearchBy);
            rptrActiveServiceIDfromPlaza.DataBind();
        }
        static DataSet ds = null;
        public static DataSet GetServiceIDByServiceID(string SearchBy)
        {
            if (SearchBy != null)
            {
                ds = new DataSet(); ;
                //WSMSDataContext contx = new WSMSDataContext();
                //RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string[] search = SearchBy.Split(';');

               // string ss = Int32.Parse(SearchBy);

               // string queryString = "select  ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' and (ime.BarCode='0' or ime.BarCode2='0') ";
               // string queryString = "select * from WSMS.ReplaceMentdb.reproles where RepRoleID=0";
               // string queryString;


                //if (search[0] == "UserID")
                //{
                //    queryString += " and ServiceStatus in('New','Queue','ServiceFailed','PartsUnavailable','UnAuthorizedService', 'LiquidDamage','Service','SendToQC','QC','QCPending','QCFailed','QCPassed', 'ApprovedReq','QCPostponed','Delivery','ServicePostponed') order by sm.ServiceID desc";
                //}

               // string queryString = "select * from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement";

               string queryString = "select * from WSMS.ReplaceMentdb.reproles where RepRoleID=0";

               // string queryString = null;

                if (search[0] == "ServiceID")
                {

                   // queryString = "select af.*,CASE WHEN af.WarrantyAvailability  = 1 THEN 'YES' ELSE 'NO' END AS WarrantyAvailability1, CASE WHEN af.NewHandsetPrice-af.FaultyHandsetPriceByPlaza>0 THEN af.NewHandsetPrice-af.FaultyHandsetPriceByPlaza ELSE 0  END AS Total from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement af where af.RegistrationDate is not null and  af.ServiceID='" + Int64.Parse(search[1]) + "' ";
                  
                    queryString = "select af.*,CASE WHEN af.WarrantyAvailability  = 1 THEN 'YES' ELSE 'NO' END AS WarrantyAvailability1, CASE WHEN af.NewHandsetPrice-af.FaultyHandsetPriceByPlaza>0 THEN af.NewHandsetPrice-af.FaultyHandsetPriceByPlaza ELSE 0 END AS Total from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement af  left join WSMS.dbo.ServiceMaster sm on sm.ServiceID=af.ServiceID where af.RegistrationDate is not null and af.ServiceID='" + Int64.Parse(search[1]) + "' and sm.ServiceStatus in ('ReplacementDelivered')";
                  

                    // queryString += "where ServiceID='" + Int64.Parse(SearchBy) + "' ";
               
               }

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RBSYNERGYConnectionString"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 1800;
                adapter.Fill(ds, "Service2");

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