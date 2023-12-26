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
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;

namespace WSMS
{
    public partial class ServiceLoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadData();
            }
        }
        public String ServiceID { get; set; }
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
        private void LoadData()
        {
            string serviceID = CommonHelper.QueryString("ServiceID");
            dtListReceiveMemo.DataSource = GetDataSet(Int64.Parse(serviceID));
            dtListReceiveMemo.DataBind();
        }

        protected void btnExportToPDF_Click(object sender, EventArgs e)
        {

            string serviceID = CommonHelper.QueryString("ServiceID");
            DataSet dsn = GetDataSet(Int64.Parse(serviceID));
            //DataSet dsnSubreport = GetDataSetSubReport(Int64.Parse(serviceID));
            if (dsn.Tables[0].Rows.Count > 0)
            {
                ReportDocument pdfReport = new ReportDocument();
                pdfReport.Load(Server.MapPath("~/Reports/LoanRequisitionSlip.rpt"));
                
                pdfReport.Database.Tables[0].SetDataSource(dsn.Tables[0].DefaultView);
                
                Response.Buffer = true;
                Response.ClearContent();
                Response.ClearHeaders();
                pdfReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "LoanRequisitionSlip");
                Response.End();
                pdfReport.Close();
                pdfReport.Dispose();
                GC.Collect();
            }
            else
            {
                //rgdVSettlementSummary.DataSource = null;
                //rgdVSettlementSummary.DataBind();
                //lblMsg.Text = "No Data Fund...";
            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {

        }
        public DataSet GetDataSet(Int64 ServiceID)
        {
            string cnnstr = ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString;

            SqlConnection con = new SqlConnection(cnnstr);
            SqlDataAdapter SqlDA = new SqlDataAdapter("rptGetServiceDetail", con);
            SqlDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            SqlDA.SelectCommand.Parameters.AddWithValue("@ServiceID", ServiceID);
            DataSet ds = new DataSet();
            SqlDA.Fill(ds);
            SqlDA.Dispose();
            con.Close();
            con.Close();
            return ds;
        }

        public DataSet GetDataSetSubReport(Int64 ServiceID)
        {
            string cnnstr = ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString;

            SqlConnection con = new SqlConnection(cnnstr);
            SqlDataAdapter SqlDA = new SqlDataAdapter("rptGetServiceRequisition", con);
            SqlDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            SqlDA.SelectCommand.Parameters.AddWithValue("@ServiceID", ServiceID);
            DataSet ds = new DataSet();
            SqlDA.Fill(ds);
            SqlDA.Dispose();
            con.Close();
            con.Close();
            return ds;
        }

        public string GetWarranty(object status)
        {
            if (Boolean.Parse(status.ToString()))
                return "YES";
            return "NO";
        }
    }
}