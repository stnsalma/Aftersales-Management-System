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
    public partial class ServiceCenterReplacementIMEIReq : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadData();
            }
        }

       
        public String SearchBy { get; set; }

        private void LoadData()
        {
            rptrServicePending.DataSource = GetServiceIDByIMEI(SearchBy);
            rptrServicePending.DataBind();
        }
        static DataSet ds = null;
        public static DataSet GetServiceIDByIMEI(string SearchBy)
        {
            if (SearchBy != "")
            {
                ds = new DataSet();

                //string queryString = "select im.*,wi.RequestID,wi.ServiceCenterUserID from RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im inner join RBSYNERGY.IMEIReplacementMaster.WastageManagementInventory wi on im.RequestID=wi.RequestID where (im.IMEI_1='" + SearchBy + "' or im.IMEI_2='" + SearchBy + "') and  im.RequestStatus='ServiceRequested' ";

                string queryString = "select im.*,wi.RequestID,wi.ServiceCenterUserID from RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im inner join RBSYNERGY.IMEIReplacementMaster.WastageManagementInventory wi on im.RequestID=wi.RequestID where (im.IMEI_1='" + SearchBy + "' or im.IMEI_2='" + SearchBy + "') ";


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

                string ss = "<select class=\"ddl-model\" style=\"width:290px\" id=\"ddlmodel\" >" +
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


    }
}