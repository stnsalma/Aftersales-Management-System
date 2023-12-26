using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace WSMS.Module
{
    public partial class PrintFaultySpareParts : System.Web.UI.UserControl
    {
        public String ServiceID { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                LoadFaultySpare();
           
        }
        private void LoadFaultySpare()
        {
            rptrfaultyspare.DataSource = GetFaultySpare(ServiceID);
            rptrfaultyspare.DataBind();
        }
        public static DataSet GetFaultySpare(String ServiceID)
        {
            if (ServiceID != null)
            {
                DataSet ds = new DataSet();

                string queryString = "select fsd.* from RBSYNERGY.IMEIReplacementMaster.FaultySparePartsDetails fsd left join RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement asr on asr.ServiceID = fsd.ServiceID where asr.ServiceID ='" + ServiceID + "'";
                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "Issue");

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