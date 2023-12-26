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
    public partial class PrintInactiveReplacementServiceIDFromPlaza : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadData();
            }

        }

        //public String UserID { get; set; }
        public String SearchBy { get; set; }


        //Int64.Parse(SearchBy)
        //string SerarchBy2 = Int64.Parse(SearchBy);

        private void LoadData()
        {
            rptrInactiveServiceIDfromPlaza.DataSource = GetInactiveServiceIDByServiceID(SearchBy);
            rptrInactiveServiceIDfromPlaza.DataBind();
        }
        static DataSet ds = null;
        public static DataSet GetInactiveServiceIDByServiceID(string SearchBy)
        {
            if (SearchBy != null)
            {
                ds = new DataSet(); ;
                

                string[] search = SearchBy.Split(';');

                

                string queryString = "select * from WSMSTEST.ReplaceMentdb.reproles where RepRoleID=0";


                if (search[0] == "ServiceID1")
                {

                    queryString = "select af.*, CASE WHEN NewHandsetPrice-FaultyHandsetPriceByPlaza>0 THEN NewHandsetPrice-FaultyHandsetPriceByPlaza ELSE 0  END AS Total from RBSYNERGY.IMEIReplacementMaster.AfterServiceReplacement af where af.RegistrationDate is not null and af.ServiceID='" + Int64.Parse(search[1]) + "' ";
                    

                }

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RBSYNERGYConnectionString"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 1800;
                adapter.Fill(ds, "Service2");

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