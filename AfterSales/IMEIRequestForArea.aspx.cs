using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using WSMS.Module;
using System.IO;
using WSMS.Helpers;
using WSMS.DAL;
using System.Web.Script.Serialization;

namespace WSMS
{
    public partial class IMEIRequestForArea : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = CommonHelper.GetSiteHost(false);

            if (Session["LOGGED_IN_USERS"] == null)
            {
                Response.Redirect(url + "Login.aspx", true);
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
        private static Int64 UserIDQueryString
        {
            get
            {
                return CommonHelper.QueryStringInt("userID");
            }
        }

        [WebMethod]
        public static string LoadNewIMEIRequest(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                AreaIMEIRequest userControl = (AreaIMEIRequest)page.LoadControl("~/Module/AreaIMEIRequest.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
                userControl.SearchBy = SearchBy;

                page.Controls.Add(userControl);

                StringWriter textWriter = new StringWriter();
                HttpContext.Current.Server.Execute(page, textWriter, false);
                return textWriter.ToString();
            }
            catch (Exception ex)
            {
                return "err";
            }
        }

        [WebMethod]
        public static string LoadNewStockFaultyRequest(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                AreaStockFaulty userControl = (AreaStockFaulty)page.LoadControl("~/Module/AreaStockFaulty.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
                userControl.SearchBy = SearchBy;

                page.Controls.Add(userControl);

                StringWriter textWriter = new StringWriter();
                HttpContext.Current.Server.Execute(page, textWriter, false);
                return textWriter.ToString();
            }
            catch (Exception ex)
            {
                return "err";
            }
        }

        [WebMethod]
        public static string LoadPlazaReport(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                AreaReport userControl = (AreaReport)page.LoadControl("~/Module/AreaReport.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
                userControl.SearchBy = SearchBy;

                page.Controls.Add(userControl);

                StringWriter textWriter = new StringWriter();
                HttpContext.Current.Server.Execute(page, textWriter, false);
                return textWriter.ToString();
            }
            catch (Exception ex)
            {
                return "err";
            }
        }
   
        [WebMethod]
        public static string LoadAreaStockReconciliation(string UserID, string SearchBy1)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                StockReconciliation userControl = (StockReconciliation)page.LoadControl("~/Module/StockReconciliation.ascx");
                userControl.EnableViewState = false;
                userControl.UserID = UserID;
                userControl.SearchBy1 = SearchBy1;

                page.Controls.Add(userControl);

                StringWriter textWriter = new StringWriter();
                HttpContext.Current.Server.Execute(page, textWriter, false);
                return textWriter.ToString();
            }
            catch (Exception ex)
            {
                return "err";
            }
        }
        [WebMethod]
        public static string InsertIMEIReplacementMasterTable(string IMEI_1, string IMEI_2, string Model, string DealerCode,
            string RequestType, string RegistrationDate, string DistributionDate, string Issues,
            string PhoneNumber, string IssueDetails, string IsSeen, string ReplaceIMEI_1, string ReplaceIMEI_2, string ReplaceModel, string RequestStatus, string AddedBy)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_ID = DataAccessHelper.InsertIMEIReplacementMasterTable(IMEI_1, IMEI_2, Model, DealerCode, RequestType,
               RegistrationDate, DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, ReplaceIMEI_1, ReplaceIMEI_2, ReplaceModel, RequestStatus, AddedBy);

            if (request_ID >= 0)
            {
                msg = "success";
               
            }
            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string InsertIMEIReplacementMasterTable1(string IMEI_1, string IMEI_2, string Model, string DealerCode,
            string RequestType, string DistributionDate, string Issues,
            string PhoneNumber, string IssueDetails, string IsSeen, string RequestStatus, string AddedBy)
        {
            string msg = "";
            // DataAccessHelper.InsertIMEIReplacementMasterTable(Int64.Parse(ServiceID), ItemCode, ItemName, StoreStatus);


            Int64 request_ID = DataAccessHelper.InsertIMEIReplacementMasterTable1(IMEI_1, IMEI_2, Model, DealerCode, RequestType,
                DistributionDate, Issues, PhoneNumber, IssueDetails, IsSeen, RequestStatus, AddedBy);

            if (request_ID >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }
        [WebMethod]
        public static string InserttblStockReconciliation(string DealerName, string DealerCode, string itemArray, string AddedBy)
        {
            string msg = "";
            string[] ItemArray = null;
            Int64 stock_ID = 0;
            if (itemArray.Count() > 0)
            {
                ItemArray = itemArray.Remove(itemArray.Count() - 2, 2).Split(';');
                for (int i = 0; i < ItemArray.Count(); i++)
                {
                    string data = ItemArray[i];
                    if (data.StartsWith(","))
                    {
                        data = data.Remove(0, 1);
                    }
                    //if (data.EndsWith(","))
                    //{
                    //    data = data.Remove(data.Count() - 1, 1);
                    //}
                    string[] Items = data.Split(',');
                    stock_ID = DataAccessHelper.InserttblStockReconciliation(DealerName, DealerCode, AddedBy, Items[0].ToString(), Items[1].ToString(), Items[2].ToString());
                }
            }
            if (stock_ID >= 0)
            {
                msg = "success";
            }

            else
                msg = "Data can not be saved";
            return msg;
        }

        [WebMethod]
        public static string InsertIntotblDisplayProduct(string IMEI_1, string IMEI_2, string Model, string DealerCode, string DisplayDate, string AddedBy)
        {
            string msg = "";

            Int64 dis_id = DataAccessHelper.InsertIntotblDisplayProduct(IMEI_1, IMEI_2, Model, DealerCode, DisplayDate, AddedBy);

            if (dis_id >= 0)
            {
                msg = "success";
            }
            else
                msg = "Data can not be saved";
            return msg;
        }


        [WebMethod]
        public static string LoadDisplayEntry(string UserID, string SearchBy)
        {
            try
            {
                Page page = new Page();
                page.EnableViewState = false;
                DisplayProductEntryByTso userControl = (DisplayProductEntryByTso)page.LoadControl("~/Module/DisplayProductEntryByTso.ascx");
                userControl.EnableViewState = false;
                DisplayProductEntryByTso.UserID = UserID;
                userControl.SearchBy = SearchBy;

                page.Controls.Add(userControl);

                StringWriter textWriter = new StringWriter();
                HttpContext.Current.Server.Execute(page, textWriter, false);
                return textWriter.ToString();
            }
            catch (Exception ex)
            {
                return "err";
            }
        }

        [WebMethod]
        public static string GetIMEReg(string IMENo)
        {

            // IME imeobj = new IME();
            // imeobj.ime = IMENo;

            // Model modelobj = new Model();


            DataTable dt = new DataTable();

            string returnValue = "err";
            string IME2 = DataAccessHelper.GetIMEAlternate(IMENo);
            if (IME2 == "invalid")
            {
                returnValue = "invalid";
            }
            //else
            //{
            //    string productID = IsRegistered(IMENo, IME2);
            //    if (!String.IsNullOrEmpty(productID) && productID != null)
            //    {
            //        string queryString = "select ProductID,PhoneNumber ,RegistrationDate,WarrantyMonths, ime.Model,pr.WarrantyVoid,DATEADD(MONTH, WarrantyMonths,"
            //        + " RegistrationDate)WarrantyExpire,DATEDIFF(day,CONVERT(date,getdate()),DATEADD(MONTH, WarrantyMonths, RegistrationDate))WarrantyDays,pr.WarrantyID, "
            //        + " case when DATEDIFF(day,CONVERT(date,getdate()),DATEADD(MONTH, WarrantyMonths, RegistrationDate))>0 then 'YES' else 'NO' end Warranty "
            //        + " from RBSYNERGY.dbo.tblProductRegistration pr join RBSYNERGY.dbo.tblBarCodeInv ime on pr.ProductID = ime.BarCode or pr.ProductID = ime.BarCode2 "
            //        + " where pr.ProductID = '" + productID + "'";

            //        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
            //        {
            //            using (SqlCommand command = new SqlCommand(queryString, connection))
            //            {
            //                SqlDataAdapter da = new SqlDataAdapter(command);
            //                da.Fill(dt);
            //            }
            //        }
            //        if (dt.Rows.Count > 0)
            //        {
            //            modelobj.model = dt.Rows[0]["Model"].ToString();

            //            String daresult = null;
            //            daresult = DataSetToJSON(dt);
            //            returnValue = daresult;

            //        }
            //    }
            //    else
            //    {

            //        returnValue = "notregistered";
            //    }
            //}
            return returnValue;
        }

        public static string IsRegistered(string IME1, string IME2)
        {
            string query = "select ProductID from RBSYNERGY.dbo.tblProductRegistration where ProductID in ('" + IME1.Trim() + "','" + IME2.Trim() + "')";
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = query;
            cmd.CommandType = CommandType.Text;
            cmd.Connection = connection;

            connection.Open();
            string ProductID = Convert.ToString(cmd.ExecuteScalar());
            connection.Close();

            if (!String.IsNullOrEmpty(ProductID) && ProductID != null)
            {
                return ProductID;
            }
            else
            {
                return null;
            }
        }

        public static string DataSetToJSON(DataTable dt)
        {

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }

        public static String DDL
        {
            get
            {

                string ss = "<select class=\"ddl-issue\" style=\"width:150px\" id=\"ddlissue\" >" +
                            "<option value=\"0\" selected=\"selected\">-- Select Problem --</option>";

                DataSet ds = new DataSet(); ;

                WSMSDataContext contx = new WSMSDataContext();

                string queryString = "select IssueID,IssueName,IssueCatagory from dbo.Issues where IsActive =1 order by IssueName";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "Service");

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

        public static String DDLModel
        {
            get
            {

                string ss = "<select class=\"ddl-model\" style=\"width:200px\" id=\"ddlmodel\" >" +
                            "<option value=\"0\" selected=\"selected\">-------- Select Model --------</option>";

                DataSet ds = new DataSet(); ;

                WSMSDataContext contx = new WSMSDataContext();

                string queryString = "select ProductID,ProductCode,ProductModel from RBSYNERGY.dbo.tblProductMaster where producttype ='Cell Phone' ORDER BY ProductModel ";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

                adapter.Fill(ds, "model");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string opt = "<option value=\"" + dr[0] + "\"> " + dr[2] + "</option>";
                        ss += opt;
                    }
                }
                ss = ss + "</select>";
                return ss;
            }
        }

        [WebMethod]
        public static string GetRequestedIMEIStatus(string SearchBy)
        {
            if (SearchBy != "")
            {

                DataSet ds = new DataSet();

                string msg = "";


                string queryString = "select IMEI_1,IMEI_2 from  RBSYNERGY.IMEIReplacementMaster.IMEIReplacementMaster where IMEI_1='" + SearchBy + "' or  IMEI_2='" + SearchBy + "' ";


                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(queryString, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(command);
                        da.Fill(ds);
                    }
                }
                if (ds.Tables[0].Rows.Count > 0)
                {
                    msg = "success";
                }
                else
                {
                    msg = "Data previously not saved";
                }
                return msg;

            }
            else
                return null;
        }

        public static String DDLDealerName
        {
            get
            {

                string ss = "<select class=\"ddl-dealer\" style=\"width:199px\" id=\"ddldealer\" >" +
                            "<option value=\"0\" selected=\"selected\">---- Select Dealer Name ----</option>";

                DataSet ds = new DataSet();

                WSMSDataContext contx = new WSMSDataContext();
                RepUser user = contx.RepUsers.Where(x => x.RepUserID == Int32.Parse(UserID.ToString())).FirstOrDefault();

                string queryString = "select PlazaAndRSMCode,Organaization_Name from WSMS.ReplaceMentdb.PlazaAndRSM where ZoneID not in (1,7,13,19,40) and ZoneID='" + user.ZoneID + "' order by Organaization_Name";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

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

    }
}