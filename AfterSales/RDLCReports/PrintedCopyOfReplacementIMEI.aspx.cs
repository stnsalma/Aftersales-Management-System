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
    public partial class PrintedCopyOfReplacementIMEI : System.Web.UI.Page
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
        public String RequestID { get; set; }


        private void LoadData()
        {

            string requestID = CommonHelper.QueryString("RequestID");
            dtListReceiveMemo.DataSource = GetPrintServiceID(requestID);
            dtListReceiveMemo.DataBind();
        }
        public static DataSet GetPrintServiceID(String RequestID)
        {
            if (RequestID != null)
            {
                DataSet ds = new DataSet();


                string queryString = String.Format(@"select td.DealerCode,td.DealerName,ru.*,im.*,wi.ServiceCenterUserID from RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im
inner join WSMS.ReplaceMentdb.RepUsers ru on im.AddedBy=ru.RepUserID
inner join RBSYNERGY.IMEIReplacementMaster.WastageManagementInventory wi on wi.RequestID=im.RequestID
inner join RBSYNERGY.dbo.tblDealerInfo td on td.DealerCode=im.DealerCode 

where im.RequestID='" + RequestID + "'  ");

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