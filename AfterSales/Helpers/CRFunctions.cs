using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System;
using System.Configuration;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.ReportSource;
using CrystalDecisions.Web;

namespace WSMS.Helpers
{
    public class CRFunctions
    {
        CrystalDecisions.CrystalReports.Engine.ReportDocument crReportDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
        DiskFileDestinationOptions crDiskFileDestinationOptions;
        ExportOptions crExportOptions;

        public void CreateEnglishPdf(string ReportPathAndName, string Spid, string Cls, string PDFPathAndName, string DatabaseName, string CalculationCurrency, string guid)
        {

            //Call the report from its stored directory
            crReportDocument.Load(ReportPathAndName);

            //Apply logon information to the main report and all sub reports
            Logon(crReportDocument, Cls, DatabaseName);

            //Pass the parameters required
            crReportDocument.DataDefinition.ParameterFields[0].ApplyCurrentValues(AddDiscreteValueString(Spid));
            crReportDocument.DataDefinition.ParameterFields[1].ApplyCurrentValues(AddDiscreteValueString(CalculationCurrency));
            crReportDocument.DataDefinition.ParameterFields[2].ApplyCurrentValues(AddDiscreteValueString(""));

            crDiskFileDestinationOptions = new DiskFileDestinationOptions();
            crDiskFileDestinationOptions.DiskFileName = PDFPathAndName;
            crExportOptions = crReportDocument.ExportOptions;
            {
                crExportOptions.DestinationOptions = crDiskFileDestinationOptions;
                crExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                crExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
            }

            crReportDocument.Export();
        }

        private bool Logon(CrystalDecisions.CrystalReports.Engine.ReportDocument cr, string cls, string databasename)
        {

            // Declare and populate a new connection info object.
            CrystalDecisions.Shared.ConnectionInfo ci = new CrystalDecisions.Shared.ConnectionInfo();

            {
                ci.ServerName = ConfigurationManager.AppSettings.Get("connectionserver");
                ci.DatabaseName = databasename;
                ci.UserID = ConfigurationManager.AppSettings.Get("connectionuserID");
                ci.Password = ConfigurationManager.AppSettings.Get("connectionpassword");
            }

            // If the ApplyLogon function fails then return a false for this function.
            // We are applying logon information to the main report at this stage.
            if ((!ApplyLogon(cr, ci)))
            {
                return false;
            }

            //Declare both a report object as well as a subreport object.
            CrystalDecisions.CrystalReports.Engine.ReportObject obj = default(CrystalDecisions.CrystalReports.Engine.ReportObject);
            CrystalDecisions.CrystalReports.Engine.ReportObjects crReportObjects = default(CrystalDecisions.CrystalReports.Engine.ReportObjects);
            CrystalDecisions.CrystalReports.Engine.SubreportObject subobj = default(CrystalDecisions.CrystalReports.Engine.SubreportObject);

            // Loop through all the report objects and locate subreports.
            // If a subreport is found then apply logon information to
            // the subreport.
            foreach (Section Sectionobj in cr.ReportDefinition.Sections)
            {
                crReportObjects = Sectionobj.ReportObjects;
                foreach (var obj in crReportObjects)
                {
                    if ((obj.Kind == CrystalDecisions.Shared.ReportObjectKind.SubreportObject))
                    {
                        subobj = (CrystalDecisions.CrystalReports.Engine.SubreportObject)obj;

                        if ((!ApplyLogon(cr.OpenSubreport(subobj.SubreportName), ci)))
                        {
                            return false;
                        }
                    }
                }
            }
            //Return True if the code runs to this stage.

            return true;
        }


        private bool ApplyLogon(CrystalDecisions.CrystalReports.Engine.ReportDocument cr, CrystalDecisions.Shared.ConnectionInfo ci)
        {
            // This function is called by the "Logon" function 
            // It loops through the report tables and applies
            // the connection information to each table.
            // Declare the TableLogOnInfo object and a table object for use later.
            CrystalDecisions.Shared.TableLogOnInfo li = default(CrystalDecisions.Shared.TableLogOnInfo);
            CrystalDecisions.CrystalReports.Engine.Table tbl = default(CrystalDecisions.CrystalReports.Engine.Table);

            //For each table apply connection info.
            foreach (var tbl in cr.Database.Tables)
            {
                li = tbl.LogOnInfo;
                li.ConnectionInfo = ci;
                tbl.ApplyLogOnInfo(li);

                //Verify that the logon was successful.
                //If TestConnectivity returns false, correct table locations.
                if ((tbl.TestConnectivity()))
                {
                    // If there is a "." in the location then remove the beginning of the fully qualified location.
                    // Example "dbo.northwind.customers" would become "customers".
                    if ((tbl.Location.IndexOf(".") > 0))
                    {
                        tbl.Location = tbl.Location.Substring(tbl.Location.LastIndexOf(".") + 1);
                    }
                    else
                    {
                        // If the location is not returning as a fully qualified location we still set it to tbl.location
                        // because Crystal Reports 9 installed on top of .NET can *store* fully qualified names but will only return
                        // the table name itself.
                        tbl.Location = tbl.Location;
                    }
                }
                else
                {
                    return false;
                }
            }
            return true;
        }
    }
}