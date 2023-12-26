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
    public partial class ServiceCenterIMEIRequest : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        public String UserID { get; set; }
        public String SearchBy { get; set; }

        private void LoadData()
        {
            rptrServicePending.DataSource = GetServiceByUserID(UserID, SearchBy);
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
          
                string queryString = "select * from WSMSTEST.ReplaceMentdb.reproles where RepRoleID=0";

                if (search[0] == "smart")
                {

                    //queryString = "select  pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate)) RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=365";
                    queryString = "select  pam.Organaization_Name,pam.PlazaAndRSMCode,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DistributionDate,pr.ProductID, pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate)) RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' ";
                
                }

                else if (search[0] == "walpad")
                {
                   // queryString = " select  pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm WHERE (irpm.IMEI_1 =pr.ProductID  or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "')  and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Walpad%' and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=365";
                    queryString = "select pam.Organaization_Name,pam.PlazaAndRSMCode,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DistributionDate,pr.ProductID, pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm WHERE (irpm.IMEI_1 =pr.ProductID  or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "')  and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Walpad%' ";

                
                }
                else if (search[0] == "feature")
                {

                   // queryString = "select pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()), DATEADD(day, 35, RegistrationDate))RequestDateValidity, case  when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))<= 35 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID)  ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))>=0 and (ime.Model like '%Excel%' or ime.Model like '%Olvio%') and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=365";
                    queryString = "select pam.Organaization_Name,pam.PlazaAndRSMCode,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DistributionDate,ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()), DATEADD(day, 35, RegistrationDate))RequestDateValidity, case  when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))<= 35 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID)  ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))>=0 and (ime.Model like '%Excel%' or ime.Model like '%Olvio%') ";
                
                }
              
                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 1800;
                adapter.Fill(ds, "Service");

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
        public static String DDL
        {
            get
            {

                string ss = "<select class=\"ddl-issue\" style=\"width:150px\" id=\"ddlissue\" >" +
                            "<option value=\"0\" selected=\"selected\">-- Select Problem --</option>";

                DataSet ds = new DataSet(); ;

                WSMSDataContext contx = new WSMSDataContext();

                string queryString = "select IssueID,IssueName,IssueCatagory from dbo.Issues where IsActive =1 order by IssueName";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "Service");

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