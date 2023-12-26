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
    public partial class WareHouseApproval : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();


        }

        public String UserID { get; set; }
        public String SearchByDate { get; set; }
       
        private void LoadData()
        {
            //rptrServicePending.DataSource = GetServiceByUserID(UserID, SearchByDate);
            //rptrServicePending.DataBind();

            DataSet datasource = GetServiceByUserID(UserID, SearchByDate);
            DataTable dtTop = null;
            if (datasource != null)
                dtTop = datasource.Tables[0].Rows.Cast<System.Data.DataRow>().Take(20).CopyToDataTable();
            rptrServicePending.DataSource = dtTop;
            rptrServicePending.DataBind();
        }
        static DataSet ds = null;

        public static DataSet GetServiceByUserID(string UserID, string SearchByDate)
        {



            if (UserID != null && SearchByDate != null)
            {
                ds = new DataSet(); ;
                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID)).FirstOrDefault();

            
                string[] search = SearchByDate.Split(';');

               // string queryString = "select top 100 td.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.dbo.tblDealerInfo td on im.DealerCode=td.DealerCode where im.RequestStatus='Approved'";

                 string queryString = "select am.RequestID,am.ApprovalID,am.ApprovedDate,im.*,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCOde,pam.ZoneID,pam.IsActive from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.IMEIReplacementMaster.ApprovalMaster am on am.RequestID=im.RequestID left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','ManagementApproved')";

                if (search[0] == "Date")
                {
                    //queryString = "select td.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.dbo.tblDealerInfo td on im.DealerCode=td.DealerCode where im.RequestStatus='Approved' and cast(CONVERT(varchar(8), im.UpdatedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";

                    //queryString = "select pam.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','ManagementApproved') and cast(CONVERT(varchar(8), im.UpdatedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";
                    queryString = "select am.RequestID,am.ApprovalID,am.ApprovedDate,im.*,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCOde,pam.ZoneID,pam.IsActive  from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.IMEIReplacementMaster.ApprovalMaster am on am.RequestID=im.RequestID left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','ManagementApproved') and cast(CONVERT(varchar(8), im.UpdatedDate, 112) AS datetime) between '" + search[1] + @" 00:00:00' And '" + search[1] + @" 23:59:59' ";

                }
                else if (search[0] == "IMEI")
                {

                    //queryString = "select td.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.dbo.tblDealerInfo td on im.DealerCode=td.DealerCode where im.RequestStatus='Approved' and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "')";

                    //queryString += " and sm.ServiceID = '" + search[1] + "' and ServiceStatus ='Deliverable' order by sm.ServiceID desc";

                    //queryString = "select pam.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','ManagementApproved') and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "')";

                    queryString = " select am.RequestID,am.ApprovalID,am.ApprovedDate,im.*,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCOde,pam.ZoneID,pam.IsActive  from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.IMEIReplacementMaster.ApprovalMaster am on am.RequestID=im.RequestID left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','ManagementApproved')  and (im.IMEI_1= '" + search[1] + "' or im.IMEI_2= '" + search[1] + "')";

                }
                else if (search[0] == "DealerCode")
                {
                   // queryString = "select td.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join RBSYNERGY.dbo.tblDealerInfo td on im.DealerCode=td.DealerCode where im.RequestStatus='Approved' and td.DealerCode='" + search[1] + "' ";
                 //queryString = "select pam.*,im.* from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','ManagementApproved') and pam.PlazaAndRSMCode='" + search[1] + "' ";
                    queryString = " select am.RequestID,am.ApprovalID,am.ApprovedDate,im.*,pam.PlazaAndRSMID,pam.Organaization_Name,pam.PlazaAndRSMCOde,pam.ZoneID,pam.IsActive from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster im  left join RBSYNERGY.IMEIReplacementMaster.ApprovalMaster am on am.RequestID=im.RequestID left join WSMS.ReplaceMentdb.PlazaAndRSM pam on im.DealerCode=pam.PlazaAndRSMCode where im.RequestStatus in ('Approved','ManagementApproved') and pam.PlazaAndRSMCode='" + search[1] + "' ";
                }


                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RBSYNERGYConnectionString"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.SelectCommand.CommandTimeout = 5000;
                adapter.Fill(ds, "Service1");

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

       

        //protected void rptrServicePending_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    Repeater rptDemo = sender as Repeater; // Get the Repeater control object.

        //    // If the Repeater contains no data.
        //    if (rptrServicePending != null && rptrServicePending.Items.Count < 1)
        //    {
        //        if (e.Item.ItemType == ListItemType.Footer)
        //        {
        //            // Show the Error Label (if no data is present).
        //            Label lblErrorMsg = e.Item.FindControl("lblErrorMsg") as Label;
        //            if (lblErrorMsg != null)
        //            {
        //                lblErrorMsg.Visible = true;
        //            }
        //        }
        //    }
        //}

        //protected void rptrServicePending_ItemCommand(object source, RepeaterCommandEventArgs e)
        //{

        //}

    }
}