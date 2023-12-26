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
    public partial class RequestForStockFaulty : System.Web.UI.UserControl
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

            //if (SearchBy != "undefined")
            //{

            if (UserID != null && SearchBy != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                //   String queryString; 
                string[] search = SearchBy.Split(';');



                //string queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =ime.BarCode or irpm.IMEI_2 =ime.BarCode2) ) and (ime.BarCode='0' or ime.BarCode2='0') and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' ";

                string queryString = "select * from WSMS.ReplaceMentdb.reproles where RepRoleID=0";

               
                    if (search[0] == "stockfaulty1")
                    {
                        // queryString = "select  ime.BarCode,ime.BarCode2,ime.DealerCode,ime.Model,ime.DealerdistributionId,ime.DistributionDate, pr.ProductRegID,pr.ProductID,pr.RegistrationDate,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))RequestDateValidity, case when  DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))<= 20 then 'YES' end Warranty from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblDealerDistributionDetails ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 WHERE DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 20, RegistrationDate))>=0 and ime.Model like '%Primo%' and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') ";
                       // queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode  WHERE (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') ";
                        //queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE  RequestStatus  in ('Requested','WareHouseReceived','WareHouseDeclined','PrimaryRecommended','PrimaryDecline','Recommended','RecommendDeclined','Approved','ManagementApproved') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 8, irpm.UpdatedDate)) >= 8 and (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) )  and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' ";
                  
                       //* queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =ime.BarCode or irpm.IMEI_2 =ime.BarCode2) ) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' ";
                       // queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 ='" + search[1] + "' or irpm.IMEI_2 ='" + search[1] + "') ) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' ";

                        queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm WHERE (irpm.IMEI_1 ='" + search[1] + "' or irpm.IMEI_2 ='" + search[1] + "') ) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and NOT EXISTS(select * from RBSYNERGY.dbo.tblProductRegistration tbprs where tbprs.ProductID=ime.BarCode or tbprs.ProductID=ime.BarCode2) and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' and  DATEDIFF(day,ime.DistributionDate,GETDATE())<=365 ";
                    }

                    //else if (search[0] == "notRegisteredDisplay")
                    //{
                    //    // queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE  RequestStatus  in ('Requested','WareHouseReceived','WareHouseDeclined','PrimaryRecommended','PrimaryDecline','Recommended','RecommendDeclined','Approved','ManagementApproved') and DATEDIFF(day,CONVERT(date,getdate()),DATEADD(day, 8, irpm.UpdatedDate)) >= 8 and (irpm.IMEI_1 =pr.ProductID or irpm.IMEI_2 =pr.ProductID) ) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.ZoneID='" + user.ZoneID + "' ";
                    //    //queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 =ime.BarCode or irpm.IMEI_2 =ime.BarCode2) ) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' ";
                    //    queryString = "select  * from RBSYNERGY.dbo.tblDealerDistributionDetails ime left join WSMS.ReplaceMentdb.PlazaAndRSM pam on ime.DealerCode = pam.PlazaAndRSMCode WHERE NOT EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irpm  WHERE (irpm.IMEI_1 ='" + search[1] + "' or irpm.IMEI_2 ='" + search[1] + "') ) and (ime.BarCode='" + search[1] + "' or ime.BarCode2='" + search[1] + "') and pam.PlazaAndRSMID='" + user.PlazaAndRSMID + "' ";
                       
                    //}
                   
             
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