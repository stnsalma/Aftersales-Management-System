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
    public partial class DisplayProductEntryByTso : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();
        }
        public static String UserID { get; set; }
        public String SearchBy { get; set; }

        private void LoadData()
        {
            rptrDisplayEntry.DataSource = GetDisplayEntryDetails(UserID, SearchBy);
            rptrDisplayEntry.DataBind();
        }
        static DataSet ds = null;
        public static DataSet GetDisplayEntryDetails(string UserID, string SearchBy)
        {
            if (UserID != null && SearchBy != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string[] search = SearchBy.Split(';');
            
                string queryString = String.Format(@"select top 1 tbr.BarCode,tbr.BarCode2,tbr.Model,tbr.ProductType,
                tdi.DealerCode,tdi.DealerName,tdp.DealerCode,tdp.Model,tdp.IMEI_1,tdp.IMEI_2,tdp.DisplayDate,tdp.IsApprovedByNSM, case when tdp.IsApprovedByNSM=1 then 'YES' else 'NO' end IsDisplayApprovedByNSM, tddd.DistributionDate   
                from RBSYNERGY.dbo.tblBarCodeInv tbr 
                left join RBSYNERGY.dbo.tblDealerDistributionDetails tddd on tddd.BarCode=tbr.BarCode
                left join RBSYNERGY.IMEIReplacementMaster.tblDisplayProduct tdp on tdp.IMEI_1=tbr.BarCode
                left join RBSYNERGY.dbo.tblDealerInfo tdi on tdi.DealerCode=tdp.DealerCode
                where (tbr.BarCode in (select tdp1.IMEI_1 from RBSYNERGY.IMEIReplacementMaster.tblDisplayProduct tdp1 where tdp1.IMEI_1=tbr.BarCode)
                or tbr.BarCode not in (select tdp1.IMEI_1 from RBSYNERGY.IMEIReplacementMaster.tblDisplayProduct tdp1 where tdp1.IMEI_1=tbr.BarCode))
                and (tbr.Barcode='" + search[0] + "' or tbr.Barcode2='" + search[0] + "') and (tddd.Barcode='" + search[0] + "' or tddd.Barcode2='" + search[0] + "')  order by tdp.AddedDate desc");
                
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
        public static String DDLDealerName
        {
            get
            {
               

                string ss = "<select class=\"ddl-dealer\" style=\"width:255px\" id=\"ddldealer\" >" +
                            "<option value=\"0\" selected=\"selected\">------------- Select Dealer Name -------------</option>";

                DataSet ds = new DataSet();

                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string queryString = "select PlazaAndRSMCode,Organaization_Name from WSMS.ReplaceMentdb.PlazaAndRSM where ZoneID not in (1,7,13,19,40) and ZoneID='" + user.ZoneID + "' order by Organaization_Name";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "model");

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