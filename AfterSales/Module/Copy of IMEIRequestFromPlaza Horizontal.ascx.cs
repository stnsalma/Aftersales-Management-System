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
    public partial class IMEIRequestFromPlaza : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            

            LoadData();
         //   Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "alert('jjjjjjjjjjjjjjjjjj')", true);
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
            
            //if (SearchBy != "undefined")
            //{

                if (UserID != null && SearchBy != null)
                {
                    ds = new DataSet(); ;
                    WSMSDataContext contx = new WSMSDataContext();
                    RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                    //   String queryString; 
                    string[] search = SearchBy.Split(';');

                  
                   
                    string queryString = "select  ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' and (ime.BarCode='0' or ime.BarCode2='0') ";



                    //if (search[0] == "imeno")
                    //{
                    //    queryString = "select * from RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster WHERE IMEI_1='" + search[1] + "' or IMEI_2='" + search[1] + "' ";

                    //  //  Alert.Show("Already Requested");
                       
                       
                    //}
                    //else{
                            if (search[0] == "smart")
                            {
                               // queryString = "select  ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') ";
                               // queryString = "select  pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') ";

                                queryString = "select  pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate)) RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' and pam.ZoneID='" + user.ZoneID + "' ";

                               
                               
                            }
                             
                            else if (search[0] == "walpad")
                            {
                                //queryString = "select  ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0  and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and ime.Model like '%Walpad%' ";

                               // queryString = "select  pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0  and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and ime.Model like '%Walpad%' ";


                                queryString = " select  pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm WHERE (irpm.IMEI_1 =pr.ProductID  or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "')  and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Walpad%' and pam.ZoneID='" + user.ZoneID + "' ";
                            }
                            else if (search[0] == "feature")
                            {
                               // queryString = "select pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))<= 35 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))>=0 and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and ime.Model like '%Excel%'  ";

                                queryString = "select pam.*,ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()), DATEADD(day, 35, RegistrationDate))RequestDateValidity, case  when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))<= 35 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID)  ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 35, RegistrationDate))>=0 and (ime.Model like '%Excel%' or ime.Model like '%Olvio%') and pam.ZoneID='" + user.ZoneID + "' "; 
               

                             }
                            else if (search[0] == "stock")
                            {
                               // queryString = "select  ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate, DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))<= 10 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))>=0 and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') ";
                               // queryString = "select  pam.*, ime.BarCode, ime.BarCode2, ime.DealerCode, ime.Model, ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate, DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))<= 10 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))>=0 and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') ";


                                queryString = "select  pam.*, ime.BarCode, ime.BarCode2, ime.DealerCode, ime.Model, ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate, DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))<= 10 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE  NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))>=0 and pam.ZoneID='" + user.ZoneID + "' ";
                            }
                            else if (search[0] == "registereddisplay")
                            {
                               // queryString = "select  ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate, DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))<= 10 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))>=0 and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') ";
                               // queryString = "select  pam.*, ime.BarCode, ime.BarCode2, ime.DealerCode, ime.Model, ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID, pr.RegistrationDate, DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))<= 10 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))>=0 and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') ";


                                queryString = "select  pam.*, ime.BarCode, ime.BarCode2, ime.DealerCode, ime.Model, ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate, DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))<= 10 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE  NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 10, RegistrationDate))>=0 and pam.ZoneID='" + user.ZoneID + "' ";
                            }
                            else if (search[0] == "special")
                            {
                               // queryString = "select  pr.*,ime.* from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 where ime.BarCode = '" + search[1] + "' or ime.BarCode2 = '" + search[1] + "' ";

                               // queryString = "select ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,pam.* from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on  ime.DealerCode = pam.PlazaAndRSMCode where ime.BarCode = '" + search[1] + "' or ime.BarCode2 = '" + search[1] + "' ";

                                queryString = "select ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model, ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID, pr.ProductID,pr.RegistrationDate,pam.* from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMSTEST.ReplaceMentdb.PlazaAndRSM pam on  ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' ";

                            }
                     //  }
                   // return msg;
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
        public string GetDisplayCommentInput(object status)
        {
            if (string.IsNullOrEmpty(status.ToString()))
                return "inline-block";
            return "none";
        }
        public string GetDisplayComment(object status)
        {
            if (string.IsNullOrEmpty(status.ToString()))
                return "none";
            return "inline-block";
        }
    }
}