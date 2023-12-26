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
    public partial class DealerHistoryIntoPlazaAndRSM : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // LoadData();
        }

        public String UserID { get; set; }
        public String SearchBy { get; set; }

        public String DDLDealerName
        {
            get
            {

                string ss = "<select class=\"ddl-dealer\" style=\"width:255px\" id=\"ddldealer\" >" +
                            "<option value=\"0\" selected=\"selected\">--------- Select Organaization Name ---------</option>";

                DataSet ds = new DataSet();

                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();


                string queryString1 = "select DealerCode,DealerName,DealerType from RBSYNERGY.dbo.tblDealerInfo where DealerType in ('Dealer','Electronics') order by DealerName";

                    SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                    SqlDataAdapter adapter = new SqlDataAdapter(queryString1, connection);

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

        public String DDLRSMName
        {
            get
            {


                string ss = "<select class=\"ddl-rsm\" style=\"width:255px\" id=\"ddlRsm\" >" +
                            "<option value=\"0\" selected=\"selected\">--------- Select RSM/Monitor Name ---------</option>";

                DataSet ds = new DataSet();

                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();


                string queryString1 = "select ZoneID,RepUserFullName,RepUserName,RepUserID from WSMS.ReplaceMentdb.RepUsers where RepRoleID=4 and ZoneID not in (1,7,13,19)";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString1, connection);

                adapter.Fill(ds, "model14");

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