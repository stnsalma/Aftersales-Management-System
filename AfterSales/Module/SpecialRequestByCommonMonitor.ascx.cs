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
    public partial class SpecialRequestByCommonMonitor : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            LoadData();

        }

        public String UserID { get; set; }
        public static String UserID1 { get; set; }
        public String SearchByDate { get; set; }

        private void LoadData()
        {
            rptrServicePending.DataSource = GetServiceByUserID(UserID, SearchByDate);
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


                // string queryString = "select  ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' and (ime.BarCode='0' or ime.BarCode2='0') ";
                string queryString = "select * from WSMS.ReplaceMentdb.reproles where RepRoleID=0";

                if (search[0] == "special")
                {
                    // queryString = "select  pr.*,ime.* from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 where ime.BarCode = '" + search[1] + "' or ime.BarCode2 = '" + search[1] + "' ";
                    // queryString = "select ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,pam.* from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMS.ReplaceMentdb.PlazaAndRSM pam on  ime.DealerCode = pam.PlazaAndRSMCode where ime.BarCode = '" + search[1] + "' or ime.BarCode2 = '" + search[1] + "' ";
                    //queryString = "select ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model, ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID, pr.ProductID,pr.RegistrationDate,pam.* from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMS.ReplaceMentdb.PlazaAndRSM pam on  ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=547 ";
                    queryString = "select ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model, ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID, pr.ProductID,pr.RegistrationDate,pam.* from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMS.ReplaceMentdb.PlazaAndRSM pam on  ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID in (10,31,98,97) and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=365 ";
                    //queryString = "select ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model, ime.DealerdistributionId, ime.DistributionDate, pr.ProductRegID, pr.ProductID,pr.RegistrationDate,pam.* from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 join WSMS.ReplaceMentdb.PlazaAndRSM pam on  ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE  RequestStatus  in ('Requested','WareHouseReceived','WareHouseDeclined','PrimaryRecommended','PrimaryDecline','Recommended','RecommendDeclined','Approved','ManagementApproved') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 8, irpm.UpdatedDate)) >= 8 and (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) )  and (ime.BarCode ='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' ";

                }
                else if (user != null && search[0] == "RegisterednotRegisteredDisplay")
                {

                    //queryString = "select  ime.*,tb.RegistrationDate from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode left join RBSYNERGY.dbo.tblProductRegistration tb on (tb.ProductID=ime.BarCode or tb.ProductID=ime.BarCode2) WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 ='" + search[1] + "' or irpm.IMEI_2 ='" + search[1] + "') ) and ( NOT EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tb1 where tb1.ProductID=ime.BarCode or tb1.ProductID=ime.BarCode2) or EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tb1 where tb1.ProductID=ime.BarCode or tb1.ProductID=ime.BarCode2)) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=365 ";

                    /////old one 2017-03-02/////

                    //queryString = "select  ime.*,tb.RegistrationDate from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode left join RBSYNERGY.dbo.tblProductRegistration tb on (tb.ProductID=ime.BarCode or tb.ProductID=ime.BarCode2) WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 ='" + search[1] + "' or irpm.IMEI_2 ='" + search[1] + "') ) and ( NOT EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tb1 where tb1.ProductID=ime.BarCode or tb1.ProductID=ime.BarCode2) or EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tb1 where tb1.ProductID=ime.BarCode or tb1.ProductID=ime.BarCode2)) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=547 ";

                    //                    queryString = String.Format(@"select  tprr.RegistrationDate,tprr.ProductID,tdp.DisplayProductID,tdp.IMEI_1 as BarCode, tdp.IMEI_2 as BarCode2,tdp.Model,tdp.DealerCode,tdp.IsApprovedByNSM,tdp.DisplayDate as DistributionDate,tdp.AddedBy,tdp.AddedDate,
                    //
                    //                    pam.* from  WSMS.ReplaceMentdb.PlazaAndRSM pam  left join RBSYNERGY.IMEIReplacementMaster.tblDisplayProduct tdp on tdp.DealerCode = pam.PlazaAndRSMCode 
                    //
                    //                    left join RBSYNERGY.dbo.tblProductRegistration tprr on (tprr.ProductID = tdp.IMEI_1 or tprr.ProductID=tdp.IMEI_2) 
                    //
                    //                    WHERE  pam.ZoneID='" + user.ZoneID + "' and (tdp.IMEI_1 ='" + search[1] + "' or tdp.IMEI_2 ='" + search[1] + "')  and (tdp.IMEI_1 not in (SELECT IMEI_1 FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm where irpm.IMEI_1=tdp.IMEI_1  or irpm.RequestType='Display') or tdp.IMEI_2 not in (SELECT IMEI_2 FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm where irpm.IMEI_2=tdp.IMEI_2 or irpm.RequestType='Display'))");

                    queryString = "select  ime.*,tb.RegistrationDate from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode left join RBSYNERGY.dbo.tblProductRegistration tb on (tb.ProductID=ime.BarCode or tb.ProductID=ime.BarCode2) WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 ='" + search[1] + "' or irpm.IMEI_2 ='" + search[1] + "') ) and ( NOT EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tb1 where tb1.ProductID=ime.BarCode or tb1.ProductID=ime.BarCode2) or EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tb1 where tb1.ProductID=ime.BarCode or tb1.ProductID=ime.BarCode2)) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID  in (10,31,98,97) and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=547 ";



                }

                else if (search[0] == "RegisterednotRegisteredDisplay")
                {

                    //queryString = "select  ime.*,tb.RegistrationDate from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode left join RBSYNERGY.dbo.tblProductRegistration tb on (tb.ProductID=ime.BarCode or tb.ProductID=ime.BarCode2) WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 ='" + search[1] + "' or irpm.IMEI_2 ='" + search[1] + "') ) and ( NOT EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tb1 where tb1.ProductID=ime.BarCode or tb1.ProductID=ime.BarCode2) or EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tb1 where tb1.ProductID=ime.BarCode or tb1.ProductID=ime.BarCode2)) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=365 ";

                    /////old one 2017-03-02/////

                    //                    queryString = String.Format(@"select  tprr.RegistrationDate,tprr.ProductID,tdp.DisplayProductID,tdp.IMEI_1 as BarCode, tdp.IMEI_2 as BarCode2,tdp.Model,tdp.DealerCode,tdp.IsApprovedByNSM,tdp.DisplayDate as DistributionDate,tdp.AddedBy,tdp.AddedDate,
                    //
                    //                    pam.* from  WSMS.ReplaceMentdb.PlazaAndRSM pam  left join RBSYNERGY.IMEIReplacementMaster.tblDisplayProduct tdp on tdp.DealerCode = pam.PlazaAndRSMCode 
                    //
                    //                    left join RBSYNERGY.dbo.tblProductRegistration tprr on (tprr.ProductID = tdp.IMEI_1 or tprr.ProductID=tdp.IMEI_2) 
                    //
                    //                    WHERE  pam.ZoneID='" + user.ZoneID + "' and (tdp.IMEI_1 ='" + search[1] + "' or tdp.IMEI_2 ='" + search[1] + "')  and (tdp.IMEI_1 not in (SELECT IMEI_1 FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm where irpm.IMEI_1=tdp.IMEI_1  or irpm.RequestType='Display') or tdp.IMEI_2 not in (SELECT IMEI_2 FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm where irpm.IMEI_2=tdp.IMEI_2 or irpm.RequestType='Display'))");

                    queryString = String.Format(@"select  tdp.DisplayProductID,tdp.IMEI_1 as BarCode, tdp.IMEI_2 as BarCode2,tdp.Model,tdp.DealerCode,tdp.IsApprovedByNSM,

                    tdp.AddedBy,tdp.AddedDate,tdd.DealerCode,tdd.DistributionDate,tprr.RegistrationDate,tprr.ProductID,

                    pam.* from  
                    RBSYNERGY.IMEIReplacementMaster.tblDisplayProduct tdp
                    left join WSMS.ReplaceMentdb.PlazaAndRSM pam on tdp.DealerCode = pam.PlazaAndRSMCode

                    left join  RBSYNERGY.dbo.tblDealerDistributionDetails tdd on (tdd.DealerCode = pam.PlazaAndRSMCode and tdp.IMEI_1=tdd.BarCode)

                    left join RBSYNERGY.dbo.tblProductRegistration tprr on (tprr.ProductID = tdp.IMEI_1 or tprr.ProductID=tdp.IMEI_2) 

                    WHERE  
                    pam.ZoneID in (10,31,98,97) and (tdp.IMEI_1 ='" + search[1] + "' or tdp.IMEI_2 ='" + search[1] + "') and (tdp.IMEI_1 not in (SELECT IMEI_1 FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm where irpm.IMEI_1=tdp.IMEI_1  or irpm.RequestType='Display') or tdp.IMEI_2 not in (SELECT IMEI_2 FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm where irpm.IMEI_2=tdp.IMEI_2 or irpm.RequestType='Display'))");

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

        public static String DDLModel
        {
            get
            {

                string ss = "<select class=\"ddl-model\" style=\"width:200px\" id=\"ddlmodel\" >" +
                            "<option value=\"0\" selected=\"selected\">-------- Select Model --------</option>";

                DataSet ds = new DataSet(); ;

                WSMSDataContext contx = new WSMSDataContext();

                string queryString = "select ProductID,ProductCode,ProductModel from RBSYNERGY.dbo.tblProductMaster where producttype ='Cell Phone' ORDER BY ProductModel ";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "model");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string opt = "<option value=\"" + dr[0] + "\"> " + dr[2] + "</option>";
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