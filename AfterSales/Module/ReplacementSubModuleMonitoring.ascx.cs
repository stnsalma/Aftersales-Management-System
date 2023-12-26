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
    public partial class ReplacementSubModuleMonitoring : System.Web.UI.UserControl
    {
        public String RequestID { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

            LoadReplacementIMEI();
           
        }
        private void LoadReplacementIMEI()
        {
            rptrReplacementReport.DataSource = GetServiceIssues3(RequestID);
            rptrReplacementReport.DataBind();
        }
        public static DataSet GetServiceIssues3(String RequestID)
        {
            if (RequestID != null)
            {
                DataSet ds = new DataSet();

                
                string queryString = "select irm.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster irm where irm.RequestID ='" + RequestID + "' ";
                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RBSYNERGYConnectionString"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "Request");

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