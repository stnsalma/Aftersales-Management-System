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
    public partial class ReplacementReportForPlaza : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadData();
            }
        }
        public String UserID { get; set; }
        public String SearchBy { get; set; }

        private void LoadData()
        {
            rptrReplacementForPlaza.DataSource = GetReplacementDetails(UserID,SearchBy);
            rptrReplacementForPlaza.DataBind();
        }
        static DataSet ds = null;
        public static DataSet GetReplacementDetails(string UserID,string SearchBy)
        {
            if (UserID != null && SearchBy != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

                string[] search = SearchBy.Split(';');

                string queryString = "select * from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement where AddedBy='" + user.RepUserID + "' and NewHandsetIMEI  is not null  ";


                if (search[0] == "repdate")
                {

                    queryString = "select * from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement  where  NewHandsetIMEI is not null and AddedBy='" + user.RepUserID + "' and cast(CONVERT(varchar(8), AddedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";

                }
                else if (search[0] == "ServiceID2")
                {

                    queryString = "select * from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement  where NewHandsetIMEI is not null and AddedBy='" + user.RepUserID + "' and ServiceID='" + Int64.Parse(search[1]) + "' ";

                }

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RBSYNERGYConnectionString"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 1800;
                adapter.Fill(ds, "Service3");

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