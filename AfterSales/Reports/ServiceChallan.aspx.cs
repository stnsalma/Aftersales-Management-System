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
    public partial class ServiceChallan : System.Web.UI.Page
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
            dtListReceiveMemo.DataSource = DataAccessHelper.GetServiceDetailByServiceID(Int64.Parse(serviceID));
            dtListReceiveMemo.DataBind();
        }

        protected void btnExportToPDF_Click(object sender, EventArgs e)
        {
            //Response.ContentType = "application/pdf";
            //Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //StringWriter sw = new StringWriter();
            //HtmlTextWriter hw = new HtmlTextWriter(sw);
            //receiveMemo.RenderControl(hw);
            //StringReader sr = new StringReader(sw.ToString());
            //Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
            //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            //pdfDoc.Open();
            //htmlparser.Parse(sr);
            //pdfDoc.Close();
            //Response.Write(pdfDoc);
            //Response.End();

            string serviceID = CommonHelper.QueryString("ServiceID");
            DataSet dsn = GetDataSet(Int64.Parse(serviceID));
            //DataSet dsnSubreport = GetDataSetSubReport(Int64.Parse(serviceID));
            if (dsn.Tables[0].Rows.Count > 0)
            {
                ReportDocument pdfReport = new ReportDocument();
                if (Boolean.Parse(dsn.Tables[0].Rows[0]["WarrantyAvailable"].ToString()))
                {
                    pdfReport.Load(Server.MapPath("~/Reports/ServiceChallanReport.rpt"));
                }
                else
                {
                    pdfReport.Load(Server.MapPath("~/Reports/ServiceChallanReportBilling.rpt"));
                }
                
                pdfReport.Database.Tables[0].SetDataSource(dsn.Tables[0].DefaultView);
                //pdfReport.SetDatabaseLogon("sa", "m*kormee", "MOZAHARUL-HP", "WSMS");

                //ReportDocument subReport = new ReportDocument();
                //subReport = pdfReport.Subreports[0];
                //subReport.SetDataSource(dsnSubreport);

                //pdfReport.OpenSubreport("ServiceRequisition.rpt"); 
                //pdfReport.SetParameterValue("@ServiceID", serviceID, "ServiceRequisition.rpt");
                
                Response.Buffer = true;
                Response.ClearContent();
                Response.ClearHeaders();
                pdfReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "ServiceChallan");
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