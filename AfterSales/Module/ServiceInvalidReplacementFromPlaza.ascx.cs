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
    public partial class ServiceInvalidReplacementFromPlaza : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();

        }

        public String UserID { get; set; }
        public String SearchBy { get; set; }

        private void LoadData()
        {
            rptrinvalidServicereplace.DataSource = GetServiceByServiceID1(UserID, SearchBy);
            rptrinvalidServicereplace.DataBind();
        }
        static DataSet ds = null;


        public static DataSet GetServiceByServiceID1(string UserID, string SearchBy)
        {


            if (UserID != null && SearchBy != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string[] search = SearchBy.Split(';');

                string queryString = "select * from WSMSTEST.ReplaceMentdb.reproles where RepRoleID=0";

                if (search[0] == "ServiceID1")
                {

                  
                    queryString = "select sm.ServiceID,sm.IME,sm.Model,spp.ServicePointID,spp.ServicePointName,asr.AfterServiceRepID,asr.FaultyHandetPrice,tblpg.RegistrationDate,ddd.DealerCode,sm.ServicePlaceDate, sm.CustomerMobile, CASE WHEN sm.WarrantyAvailable  = 1 THEN 'YES' ELSE 'NO' END AS WarrantyAvailable,par.Organaization_Name from WSMSTEST.dbo.ServiceMaster sm left join RBSYNERGY.dbo.tblDealerDistributionDetails ddd on (sm.IME=ddd.BarCode or sm.IME=ddd.BarCode2) left join WSMSTEST.ReplaceMentdb.PlazaAndRSM par on par.PlazaAndRSMCode=ddd.DealerCode left join RBSYNERGY.dbo.tblProductRegistration tblpg on (tblpg.ProductID=ddd.BarCode or tblpg.ProductID=ddd.BarCode2) left join WSMSTEST.dbo.ServicePoint spp on sm.ServicePointID=spp.ServicePointID left join RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement asr on asr.ServiceID =sm.ServiceID where EXISTS (SELECT * FROM RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement asr WHERE asr.ServiceID =sm.ServiceID )  and Not exists(Select AfterServiceRepID from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacementLog afl where afl.AfterServiceRepID=asr.AfterServiceRepID) and sm.ServiceStatus in ('ReplacementDelivered') and  tblpg.RegistrationDate is null  and sm.ServiceID='" + search[1] + "' ";

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

        public static String DDLModel
        {
            get
            {

                string ss = "<select class=\"ddl-model\" style=\"width:200px\" id=\"ddlmodel\" >" +
                            "<option value=\"0\" selected=\"selected\">-------- Select Model --------</option>";

                DataSet ds = new DataSet();

                WSMSDataContext contx = new WSMSDataContext();

                string queryString = "select ProductID,ProductCode,ProductModel from RBSYNERGY.dbo.tblProductMaster where producttype ='Cell Phone' ORDER BY ProductModel";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RBSYNERGYConnectionString"].ConnectionString);
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

    }
}