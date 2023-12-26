using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WSMS.Helpers;
using System.Data;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;
using Microsoft.Reporting.Common;
using Microsoft.Reporting.WebForms;
using Microsoft.Reporting.WinForms;
using WSMS.DAL;



namespace WSMS.RDLCReports
{
    public partial class PrintActiveServiceIDFromPlaza : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadData();
            }

        }

        public static Int64 UserID
        {
            get
            {
                try
                {
                    return LoginHelper.LoggedInUsers.RepUserID;
                }
                catch (Exception ex)
                {

                    return 0;
                }

            }
        }
        public String ServiceID { get; set; }


        private void LoadData()
        {

            string serviceID = CommonHelper.QueryString("ServiceID");
            dtListReceiveMemo.DataSource = GetPrintServiceID(serviceID);
            dtListReceiveMemo.DataBind();
        }
        public static DataSet GetPrintServiceID(String ServiceID)
        {
            if (ServiceID != null)
            {
                DataSet ds = new DataSet();

               
               // string queryString = "select ic.Comment,tbdd.DealerCode,tbdd.Barcode,tbdd.Barcode2,sm.*,asr.*,ru.RepUserID,ru.RepUserFullName,CASE WHEN asr.PermissionFromCoOrdinator  = 1 THEN 'YES' ELSE 'NO' END AS PermissionFromCoOrdinator1,CASE WHEN asr.WarrantyAvailability  = 1 THEN 'YES' ELSE 'NO' END AS Warranty, CASE WHEN NewHandsetPrice-FaultyHandsetPriceByPlaza>0 THEN NewHandsetPrice-FaultyHandsetPriceByPlaza ELSE 0  END AS Total from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement asr left join WSMS.dbo.ServiceMaster sm on asr.ServiceID=sm.ServiceID left join RBSYNERGY.dbo.tbldealerdistributiondetails tbdd on (tbdd.Barcode=sm.IME or tbdd.BarCode2=sm.IME) left join WSMS.dbo.ServiceIssue si on si.ServiceID=sm.ServiceID left join WSMS.dbo.IssueComment ic on ic.ServiceIssueID=si.ServiceIssueID  left join WSMS.ReplaceMentdb.RepUsers ru on ru.RepUserID=asr.AddedBy where sm.ServiceID='" + ServiceID + "' ";


//                string queryString = String.Format(@"SELECT  (SELECT STUFF((
// SELECT ', ' + s.Comment FROM (select ServiceID, Comment from WSMS.dbo.ServiceIssue SI,WSMS.dbo.IssueComment IC where SI.ServiceIssueID=IC.ServiceIssueID) AS s WHERE s.ServiceID = t.ServiceID FOR XML PATH('') ),1,1,'') AS CSV
//FROM (select ServiceID, Comment from WSMS.dbo.ServiceIssue SI,WSMS.dbo.IssueComment IC where SI.ServiceIssueID=IC.ServiceIssueID) AS t where ServiceID='" + ServiceID + "'  GROUP BY t.ServiceID) tech_comm,tbdd.DealerCode,tbdd.Barcode,tbdd.Barcode2,sm.ServiceID,asr.ServiceID,ru.RepUserID,ru.RepUserFullName,CASE WHEN asr.PermissionFromCoOrdinator  = 1 THEN 'YES' ELSE 'NO' END AS PermissionFromCoOrdinator1,CASE WHEN asr.WarrantyAvailability  = 1 THEN 'YES' ELSE 'NO' END AS WarrantyAvailability1, CASE WHEN NewHandsetPrice-FaultyHandsetPriceByPlaza>0 THEN NewHandsetPrice-FaultyHandsetPriceByPlaza ELSE 0  END AS ReceiveByPlazaTotal, sm.CustomerName,sm.CustomerAddress,sm.ServicePlaceDate,asr.RegistrationDate,sm.ServicePointID, asr.AcceptFromCustomer,asr.DealerName,asr.AfterServiceRepID,asr.WarrantyAvailability,asr.AcceptFromCustomer,asr.ServiceInchargeComment,asr.CustomerMobile,asr.DepricationRate,asr.Invoice,asr.NewHandsetIMEI,sm.IME,asr.NewHandsetModel,asr.ServicePointName,asr.RepalcementCause,asr.NewHandsetPrice,asr.FaultyHandsetPriceByPlaza,asr.Model as FaultyhandsetModel,asr.FaultyHandetPrice,asr.AcceptFromCustomer as AcceptByCustomerByIncharge,asr.ReplacementGivenBy FROM WSMS.dbo.ServiceIssue si left join RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement asr on asr.ServiceID=si.ServiceID left join WSMS.dbo.ServiceMaster sm on asr.ServiceID=sm.ServiceID left join RBSYNERGY.dbo.tbldealerdistributiondetails tbdd on (tbdd.Barcode=sm.IME or tbdd.BarCode2=sm.IME) left join WSMS.ReplaceMentdb.RepUsers ru on ru.RepUserID=asr.AddedBy where si.ServiceID='" + ServiceID + "'  GROUP BY si.ServiceID,tbdd.DealerCode,tbdd.Barcode,tbdd.Barcode2,sm.ServiceID,asr.ServiceID,ru.RepUserID,ru.RepUserFullName,sm.ServicePlaceDate,sm.ServicePointID,asr.AcceptFromCustomer,asr.DealerName,asr.AfterServiceRepID,asr.WarrantyAvailability,asr.AcceptFromCustomer,asr.CustomerMobile,asr.DepricationRate,asr.Invoice,asr.NewHandsetIMEI,asr.NewHandsetModel,asr.PermissionFromCoOrdinator,asr.NewHandsetPrice,asr.FaultyHandsetPriceByPlaza,asr.ServicePointName,asr.RepalcementCause, asr.Model,asr.FaultyHandetPrice,asr.AcceptFromCustomer,asr.ReplacementGivenBy,sm.CustomerName,sm.CustomerAddress,sm.IME,asr.RegistrationDate,asr.ServiceInchargeComment");



                string queryString = String.Format(@"SELECT  (SELECT STUFF((
 SELECT ', ' + s.Comment FROM (select ServiceID, Comment from WSMS.dbo.ServiceIssue SI,WSMS.dbo.IssueComment IC where SI.ServiceIssueID=IC.ServiceIssueID) AS s
 WHERE s.ServiceID = t.ServiceID
 FOR XML PATH('')),1,1,'') AS CSV
FROM (select ServiceID, Comment from WSMS.dbo.ServiceIssue SI,WSMS.dbo.IssueComment IC where SI.ServiceIssueID=IC.ServiceIssueID) AS t 
where ServiceID='" + ServiceID + "' GROUP BY t.ServiceID) tech_comm, tbdd.DealerCode,sm.ServiceID,asr.ServiceID,ru.RepUserID,ru.RepUserFullName,CASE WHEN asr.PermissionFromCoOrdinator  = 1  THEN 'YES' ELSE 'NO' END AS PermissionFromCoOrdinator1,CASE WHEN asr.WarrantyAvailability  = 1 THEN 'YES' ELSE 'NO' END AS WarrantyAvailability1, CASE WHEN NewHandsetPrice-FaultyHandsetPriceByPlaza>0 THEN NewHandsetPrice-FaultyHandsetPriceByPlaza ELSE 0  END AS ReceiveByPlazaTotal, sm.ServicePlaceDate,sm.ServicePointID,asr.AcceptFromCustomer,asr.DealerName,asr.AfterServiceRepID,asr.AcceptFromCustomer,asr.CustomerMobile,asr.DepricationRate,asr.Invoice, asr.NewHandsetIMEI,asr.NewHandsetModel,asr.ServicePointName,asr.RepalcementCause ,asr.Model as FaultyhandsetModel,asr.FaultyHandetPrice,asr.AcceptFromCustomer as AcceptByCustomerByIncharge,asr.ReplacementGivenBy,sm.CustomerName,sm.CustomerAddress,asr.RegistrationDate,asr.ServiceInchargeComment,asr.NewHandsetPrice,asr.FaultyHandsetPriceByPlaza,(select BarCode2 from RBSYNERGY.dbo.tblBarCodeInv tbb1 where tbb1.BarCode=asr.IME or tbb1.BarCode2=asr.IME) Barcode2,asr.IME FROM WSMS.dbo.ServiceIssue si left join RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement asr on asr.ServiceID=si.ServiceID left join WSMS.dbo.ServiceMaster sm on asr.ServiceID=sm.ServiceID left join RBSYNERGY.dbo.tbldealerdistributiondetails tbdd on (tbdd.Barcode=sm.IME or tbdd.BarCode2=sm.IME) left join WSMS.ReplaceMentdb.RepUsers ru on ru.RepUserID=asr.AddedBy where si.ServiceID='" + ServiceID + "' GROUP BY si.ServiceID,tbdd.DealerCode,Barcode2,sm.ServiceID,asr.ServiceID,ru.RepUserID,ru.RepUserFullName,sm.ServicePlaceDate,sm.ServicePointID,asr.AcceptFromCustomer,asr.DealerName,asr.AfterServiceRepID,asr.WarrantyAvailability,asr.AcceptFromCustomer,asr.CustomerMobile,asr.DepricationRate,asr.Invoice, asr.NewHandsetIMEI,asr.NewHandsetModel,asr.PermissionFromCoOrdinator,asr.NewHandsetPrice,asr.FaultyHandsetPriceByPlaza,asr.ServicePointName,asr.RepalcementCause,asr.Model,asr.FaultyHandetPrice,asr.AcceptFromCustomer,asr.ReplacementGivenBy,asr.IME,sm.CustomerName,sm.CustomerAddress,asr.RegistrationDate,asr.ServiceInchargeComment");



                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "Issue11");

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