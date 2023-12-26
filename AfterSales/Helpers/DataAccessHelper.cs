using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Configuration;
using System.Data.Common;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;

namespace WSMS.Helpers
{
    public class DataAccessHelper
    {
        #region DBSingleton

        private static SqlDatabase db = null;

        private static SqlDatabase GetDB()
        {
            if (db == null)
                db = new SqlDatabase(GetConnectionString("RBSYNERGYConnectionString"));
                //db = new SqlDatabase(GetConnectionString("Connection_OFFICE"));
                
            return db;
        }
        
        #endregion

        #region "Database Connectivity"

        internal static string GetConnectionString(string ConnectionStringName)
        {
            string connectionString = null;
            ConnectionStringSettings settings = WebConfigurationManager.ConnectionStrings[ConnectionStringName];
            //connectionString = ConfigurationManager.ConnectionStrings[ConnectionStringName].ConnectionString;
            if (settings != null)
            {
                connectionString = settings.ConnectionString;
            }

            return connectionString;
        }

        /// <summary>
        /// Creates a connection to a data soruce
        /// </summary>
        /// <param name="ConnectionString">Connection string</param>
        /// <returns>Database instance</returns>
        public static SqlDatabase CreateConnection()
        {

            SqlDatabase db = GetDB();
            return db;
        }

        #endregion
 

        public static DataSet GetUserDetail(Int32 ServicePointID, Int32 RoleID)
        {
            DataSet ds = null;
            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("GetUserDetail");
            if (ServicePointID > 0)
                db.AddInParameter(dbCommand, "@ServicePointID", DbType.Int32, ServicePointID);
            else
                db.AddInParameter(dbCommand, "@ServicePointID", DbType.String, null);
            if (RoleID > 0)
                db.AddInParameter(dbCommand, "@RoleID", DbType.Int32, RoleID);
            else
                db.AddInParameter(dbCommand, "@RoleID", DbType.String, null);

            ds = db.ExecuteDataSet(dbCommand);

            return ds;
        }


        public static Int32 InsertUser(String UserName, String UserFullName, String Email, String Password, String Address, String Level,
            Int32 RoleID, String EmployeeCode, Int32 ServicePointID, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("InsertUser");
            db.AddInParameter(dbCommand, "@UserName", DbType.String, UserName);
            db.AddInParameter(dbCommand, "@UserFullName", DbType.String, UserFullName);
            db.AddInParameter(dbCommand, "@Email", DbType.String, Email);
            db.AddInParameter(dbCommand, "@Password", DbType.String, Password);
            db.AddInParameter(dbCommand, "@Address", DbType.String, Address);
            db.AddInParameter(dbCommand, "@Level", DbType.String, Level);
            db.AddInParameter(dbCommand, "@RoleID", DbType.Int32, RoleID);
            db.AddInParameter(dbCommand, "@EmployeeCode", DbType.String, EmployeeCode);
            db.AddInParameter(dbCommand, "@ServicePointID", DbType.Int32, ServicePointID);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            db.AddOutParameter(dbCommand, "@UserID", DbType.Int32, 0);
            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                Int64 UserID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@UserID"));
                return 1;
            }
            return -1;
        }
        public static Int32 UpdateUser(Int32 UserID, Int32 RoleID, String Password, Int32 ServicePointID, Int32 IsActive, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("UpdateUser");
            db.AddInParameter(dbCommand, "@UserID", DbType.Int32, UserID);
            db.AddInParameter(dbCommand, "@RoleID", DbType.Int32, RoleID);
            db.AddInParameter(dbCommand, "@Password", DbType.String, Password);
            db.AddInParameter(dbCommand, "@ServicePointID", DbType.Int32, ServicePointID);
            db.AddInParameter(dbCommand, "@IsActive", DbType.Int32, IsActive);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                // Int64 AssignID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@AssignID"));
                return 1;
            }
            return -1;
        }


        public static DataSet GetServiceDetailByServiceID(Int64 ServiceID)
        {
            DataSet ds = null;
            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("GetServiceDetail");
            db.AddInParameter(dbCommand, "@ServiceID", DbType.String, ServiceID);

            ds = db.ExecuteDataSet(dbCommand);

            return ds;
        }


        /////////////////////my code

        /// <summary>
        /// ///////////my one new module
        /// </summary>

        public static String GetIMEAlternate(String IME)
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection_LOCAL"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "GetIMEAlternate";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.Parameters.AddWithValue("@IME", IME);

            cmd.CommandTimeout = 580;

            connection.Open();
            string IMEAlternate = Convert.ToString(cmd.ExecuteScalar());
            connection.Close();

            if (!String.IsNullOrEmpty(IMEAlternate) || IMEAlternate != null)
            {
                return IMEAlternate;
            }
            else
            {
                return IME;
            }
        }

    

        public static Int64 InsertIMEIReplacementMasterTable(String IMEI_1, String IMEI_2, String Model, String DealerCode,
         String RequestType, String RegistrationDate, String DistributionDate,
         String Issues, String PhoneNumber, String IssueDetails, String IsSeen, String ReplaceIMEI_1, String ReplaceIMEI_2, String ReplaceModel, String RequestStatus, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertIMEIReplacementMasterTable");
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@DealerCode", DbType.String, DealerCode);

            db.AddInParameter(dbCommand, "@RequestType", DbType.String, RequestType);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);
            db.AddInParameter(dbCommand, "@Issues", DbType.String, Issues);
            db.AddInParameter(dbCommand, "@PhoneNumber", DbType.String, PhoneNumber);

            db.AddInParameter(dbCommand, "@IssueDetails", DbType.String, IssueDetails);
            db.AddInParameter(dbCommand, "@IsSeen", DbType.String, IsSeen);
            db.AddInParameter(dbCommand, "@ReplaceIMEI_1", DbType.String, ReplaceIMEI_1);
            db.AddInParameter(dbCommand, "@ReplaceIMEI_2", DbType.String, ReplaceIMEI_2);
            db.AddInParameter(dbCommand, "@ReplaceModel", DbType.String, ReplaceModel);

            db.AddInParameter(dbCommand, "@RequestStatus", DbType.String, RequestStatus);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;

        }

        public static Int64 InsertIMEIReplacementMasterTable1(String IMEI_1, String IMEI_2, String Model, String DealerCode,
         String RequestType, String DistributionDate,
         String Issues, String PhoneNumber, String IssueDetails, String IsSeen, String RequestStatus, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertIMEIReplacementMasterTable1");
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@DealerCode", DbType.String, DealerCode);
            db.AddInParameter(dbCommand, "@RequestType", DbType.String, RequestType);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);
            db.AddInParameter(dbCommand, "@Issues", DbType.String, Issues);
            db.AddInParameter(dbCommand, "@PhoneNumber", DbType.String, PhoneNumber);

            db.AddInParameter(dbCommand, "@IssueDetails", DbType.String, IssueDetails);
            db.AddInParameter(dbCommand, "@IsSeen", DbType.String, IsSeen);
            //db.AddInParameter(dbCommand, "@ReplaceIMEI_1", DbType.String, ReplaceIMEI_1);
            //db.AddInParameter(dbCommand, "@ReplaceIMEI_2", DbType.String, ReplaceIMEI_2);
            //db.AddInParameter(dbCommand, "@ReplaceModel", DbType.String, ReplaceModel);

            db.AddInParameter(dbCommand, "@RequestStatus", DbType.String, RequestStatus);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;
        }

        public static Int64 InsertAfterServiceIMEIReplacement(String AfterServiceRepID,String ServiceID, String IME, String Model, String RegistrationDate,
        String ServicePlaceDate, String DealerName, String CustomerMobile, Boolean WarrantyAvailability, String Invoice,
        String ReplacementIMEI, String ReplacementModel, String ServicePointName,String ReplacementGivenBy, String NewHandsetPrice, String FaultyHandsetPriceByPlaza,String AddedBy)
        {
            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertAfterServiceIMEIReplacement");
            db.AddInParameter(dbCommand, "@AfterServiceRepID", DbType.String, AfterServiceRepID);
            db.AddInParameter(dbCommand, "@ServiceID", DbType.String, ServiceID);
            db.AddInParameter(dbCommand, "@IME", DbType.String, IME);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@ServicePlaceDate", DbType.String, ServicePlaceDate);
            db.AddInParameter(dbCommand, "@DealerName", DbType.String, DealerName);
            db.AddInParameter(dbCommand, "@CustomerMobile", DbType.String, CustomerMobile);
            db.AddInParameter(dbCommand, "@WarrantyAvailability", DbType.Boolean, WarrantyAvailability);
            db.AddInParameter(dbCommand, "@Invoice", DbType.String, Invoice);
            db.AddInParameter(dbCommand, "@ReplacementIMEI", DbType.String,ReplacementIMEI);
            db.AddInParameter(dbCommand, "@ReplacementModel",DbType.String,ReplacementModel);
            db.AddInParameter(dbCommand, "@ServicePointName", DbType.String, ServicePointName);
            db.AddInParameter(dbCommand, "@ReplacementGivenBy", DbType.String, ReplacementGivenBy);
            db.AddInParameter(dbCommand, "@NewHandsetPrice", DbType.String, NewHandsetPrice);
            db.AddInParameter(dbCommand, "@FaultyHandsetPriceByPlaza", DbType.String, FaultyHandsetPriceByPlaza);
            //db.AddInParameter(dbCommand, "@Total", DbType.String, Total);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;
        }

        //public static Int64 InsertAfterServiceInvalidIMEIReplacement(String AfterServiceRepID, String ServiceID, String IME, String Model, String RegistrationDate,
        //String ServicePlaceDate, String DealerName, String CustomerMobile, Boolean WarrantyAvailability, String Invoice,
        //String ReplacementIMEI, String ReplacementModel, String ServicePointName, String ReplacementGivenBy, String NewHandsetPrice, String FaultyHandsetPriceByPlaza, String AddedBy)
        //{
        //    Database db = DataAccessHelper.CreateConnection();
        //    DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertAfterServiceInvalidIMEIReplacement");
        //    db.AddInParameter(dbCommand, "@AfterServiceRepID", DbType.String, AfterServiceRepID);
        //    db.AddInParameter(dbCommand, "@ServiceID", DbType.String, ServiceID);
        //    db.AddInParameter(dbCommand, "@IME", DbType.String, IME);
        //    db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
        //    db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
        //    db.AddInParameter(dbCommand, "@ServicePlaceDate", DbType.String, ServicePlaceDate);
        //    db.AddInParameter(dbCommand, "@DealerName", DbType.String, DealerName);
        //    db.AddInParameter(dbCommand, "@CustomerMobile", DbType.String, CustomerMobile);
        //    db.AddInParameter(dbCommand, "@WarrantyAvailability", DbType.Boolean, WarrantyAvailability);
        //    db.AddInParameter(dbCommand, "@Invoice", DbType.String, Invoice);
        //    db.AddInParameter(dbCommand, "@ReplacementIMEI", DbType.String, ReplacementIMEI);
        //    db.AddInParameter(dbCommand, "@ReplacementModel", DbType.String, ReplacementModel);
        //    db.AddInParameter(dbCommand, "@ServicePointName", DbType.String, ServicePointName);
        //    db.AddInParameter(dbCommand, "@ReplacementGivenBy", DbType.String, ReplacementGivenBy);
        //    db.AddInParameter(dbCommand, "@NewHandsetPrice", DbType.String, NewHandsetPrice);
        //    db.AddInParameter(dbCommand, "@FaultyHandsetPriceByPlaza", DbType.String, FaultyHandsetPriceByPlaza);
        //    //db.AddInParameter(dbCommand, "@Total", DbType.String, Total);
        //    db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

        //    if (db.ExecuteNonQuery(dbCommand) > 0)
        //    {
        //        return 1;
        //    }
        //    return -1;
        //}

        public static Int64 InsertReplacementLogInsertApprovelMasterUpdateMaster(Int64 RequestID, String IMEI_1, String IMEI_2, String Model, 
        String RegistrationDate, String DistributionDate,
        String AddedBy, String RequestStatus, String RequestType)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertReplacementLogInsertApprovelMasterUpdateMaster");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);          
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);         
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            db.AddInParameter(dbCommand, "@RequestStatus", DbType.String, RequestStatus);
            db.AddInParameter(dbCommand, "@RequestType", DbType.String, RequestType);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;



        }

        public static Int64 InsertDeclineReplacementLogUpdateMaster(Int64 RequestID, String IMEI_1, String IMEI_2, String Model,
        String RegistrationDate, String DistributionDate,
        String AddedBy, String RequestStatus, String AppDeclinedRemarks)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertDeclineReplacementLogUpdateMaster");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            db.AddInParameter(dbCommand, "@RequestStatus", DbType.String, RequestStatus);
            db.AddInParameter(dbCommand, "@AppDeclinedRemarks", DbType.String, AppDeclinedRemarks);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;

        }


        public static Int64 UpdateApprovelMasterUpdateIMEIReplacementMaster(Int64 RequestID, String IMEI_1, String IMEI_2,

         String AddedBy, String RequestStatus, String Model, String RegistrationDate, String DistributionDate, String RequestType)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.UpdateApprovelMasterUpdateIMEIReplacementMaster");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            db.AddInParameter(dbCommand, "@RequestStatus", DbType.String, RequestStatus);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);
            db.AddInParameter(dbCommand, "@RequestType", DbType.String, RequestType);
            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;

        }

        public static Int64 UpdateIMEIReplacementMasterForApprovedDecline(Int64 RequestID, String IMEI_1, String IMEI_2, String Model, String RegistrationDate, String DistributionDate, String RequestStatus, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.UpdateIMEIReplacementMasterForApprovedDecline");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);        
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);           
            db.AddInParameter(dbCommand, "@RequestStatus", DbType.String, RequestStatus);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;

        }

        public static Int64 InsertPrimaryRecomLogUpdateIMEIReplacementMaster(Int64 RequestID, String IMEI_1, String IMEI_2, String Model,
        String RegistrationDate, String DistributionDate,
        String AddedBy, String PrimaryRecomStatus)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertPrimaryRecomLogUpdateIMEIReplacementMaster");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            db.AddInParameter(dbCommand, "@PrimaryRecomStatus", DbType.String, PrimaryRecomStatus);


            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;



        }


        public static Int64 InsertDeclinePrimaryRecomLogUpdateIMEIReplacementMaster(Int64 RequestID, String IMEI_1, String IMEI_2, String Model,
     String RegistrationDate, String DistributionDate,
      String AddedBy, String PrimaryRecomStatus)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertDeclinePrimaryRecomLogUpdateIMEIReplacementMaster");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            db.AddInParameter(dbCommand, "@PrimaryRecomStatus", DbType.String, PrimaryRecomStatus);


            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;



        }

        public static Int64 ReceiveInsertWareHouseApproval(Int64 RequestID, String IMEI_1, String IMEI_2, String WAppStatus, String Reason, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.ReceiveInsertWareHouseApproval");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@WAppStatus", DbType.String, WAppStatus);
            db.AddInParameter(dbCommand, "@Reason", DbType.String, Reason);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);


            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
               return 1;
            }
            return -1;
        
        }
        public static Int64 DeclineInsertWareHouseApproval(Int64 RequestID, String WAppStatus, String Reason, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.DeclineInsertWareHouseApproval");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@WAppStatus", DbType.String, WAppStatus);
            db.AddInParameter(dbCommand, "@Reason", DbType.String, Reason);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);


            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }

        public static Int64 InsertManagementApprovalLog(Int64 RequestID, String IMEI_1, String IMEI_2, String Model,
        String RegistrationDate, String DistributionDate, String WarehouseDeclinedDate, String ManagementStatus,
        String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertManagementApprovalLog");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);
            db.AddInParameter(dbCommand, "@WarehouseDeclinedDate", DbType.String, WarehouseDeclinedDate);
            db.AddInParameter(dbCommand, "@ManagementStatus", DbType.String, ManagementStatus);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
                return 1;
            }
            return -1;

        }

        //public static Int64 PrintActiveServiceIDFromPlaza(String UserID,Int64 SearchBy)
        //{

        //    Database db = DataAccessHelper.CreateConnection();
        //    DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.PrintActiveServiceIDFromPlaza");
        //    db.AddInParameter(dbCommand, "@UserID", DbType.Int64, UserID);
        //    db.AddInParameter(dbCommand, "@SearchBy", DbType.Int64, SearchBy);

        //    if (db.ExecuteNonQuery(dbCommand) > 0)
        //    {
        //        //Int64 StoreAcceptID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@StoreAcceptID"));
        //        return 1;
        //    }
        //    return -1;


        //}

        //String ReplaceIMEI_1, String ReplaceIMEI_2, String ReplaceModel,
        public static Int64 InsertIntoIMEIReplacementMasterFromServiceCenter(String IMEI_1, String IMEI_2, String Model, String DealerCode,
        String RequestType, String RegistrationDate, String DistributionDate,
        String Issues, String PhoneNumber, String IssueDetails, String IsSeen, String RequestStatus, String AddedBy, String ReplacementGivenBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertIntoIMEIReplacementMasterFromServiceCenter");
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@DealerCode", DbType.String, DealerCode);

            db.AddInParameter(dbCommand, "@RequestType", DbType.String, RequestType);
            db.AddInParameter(dbCommand, "@RegistrationDate", DbType.String, RegistrationDate);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);
            db.AddInParameter(dbCommand, "@Issues", DbType.String, Issues);
            db.AddInParameter(dbCommand, "@PhoneNumber", DbType.String, PhoneNumber);
            db.AddInParameter(dbCommand, "@IssueDetails", DbType.String, IssueDetails);
            db.AddInParameter(dbCommand, "@IsSeen", DbType.String, IsSeen);

            //db.AddInParameter(dbCommand, "@ReplaceIMEI_1", DbType.String, ReplaceIMEI_1);
            //db.AddInParameter(dbCommand, "@ReplaceIMEI_2", DbType.String, ReplaceIMEI_2);
            //db.AddInParameter(dbCommand, "@ReplaceModel", DbType.String, ReplaceModel);

            db.AddInParameter(dbCommand, "@RequestStatus", DbType.String, RequestStatus);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            db.AddInParameter(dbCommand, "@ReplacementGivenBy", DbType.String, ReplacementGivenBy);

            db.AddOutParameter(dbCommand, "@RequestID", DbType.Int64, 0);
            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                Int64 RequestID = Convert.ToInt64(db.GetParameterValue(dbCommand, "@RequestID"));
                return RequestID;
            }
            return -1;

        }


        public static Int64 InsertRepIMEIIntoIMEIReplacementMasterFromServiceCenter(Int64 RequestID, String ReplaceIMEI_1, String ReplaceIMEI_2, String ReplaceModel)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertRepIMEIIntoIMEIReplacementMasterFromServiceCenter");

            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@ReplaceIMEI_1", DbType.String, ReplaceIMEI_1);
            db.AddInParameter(dbCommand, "@ReplaceIMEI_2", DbType.String, ReplaceIMEI_2);
            db.AddInParameter(dbCommand, "@ReplaceModel", DbType.String, ReplaceModel);


            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
               
                return 1;
            }
            return -1;

        }
        public static Int64 InsertWastageManagement(Int64 RequestID, String IMEI_1, String IMEI_2, String Model, String ServicePointID, String RequestStatus, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertWastageManagement");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@ServicePointID", DbType.String, ServicePointID);
            db.AddInParameter(dbCommand, "@RequestStatus", DbType.String, RequestStatus);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }

        public static Int64 InsertWarCorporateUpdateWastageLog(Int64 RequestID, String DeliverTo, String StatusFromWastage,String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertWarCorporateUpdateWastageLog");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@DeliverTo", DbType.String, DeliverTo);
            db.AddInParameter(dbCommand, "@StatusFromWastage", DbType.String, StatusFromWastage);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);


            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }

        public static Int64 InsertWareHouseCorporateStoreLog(Int64 RequestID, String CorporateStatus, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertWareHouseCorporateStoreLog");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@CorporateStatus", DbType.String, CorporateStatus);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }

        public static Int64 InsertCorporateStoreLogFromWarehouse(Int64 RequestID, String IMEI_1, String IMEI_2, String WareHouseStatus, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertCorporateStoreLogFromWarehouse");
            db.AddInParameter(dbCommand, "@RequestID", DbType.Int64, RequestID);
            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@WareHouseStatus", DbType.String, WareHouseStatus);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }

        public static Int64 InserttblStockReconciliation(String DealerName, String DealerCode, String AddedBy, String Model, String InHouseStock, String MarketStock)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InserttblStockReconciliation");

            db.AddInParameter(dbCommand, "@DealerName", DbType.String, DealerName);
            db.AddInParameter(dbCommand, "@DealerCode", DbType.String, DealerCode);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@InHouseStock", DbType.String, InHouseStock);
            db.AddInParameter(dbCommand, "@MarketStock", DbType.String, MarketStock);


            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }
        public static Int64 InsertIntotblDisplayProduct(String IMEI_1, String IMEI_2, String Model, String DealerCode, String DisplayDate, String AddedBy)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertIntotblDisplayProduct");

            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@DealerCode", DbType.String, DealerCode);
            db.AddInParameter(dbCommand, "@DisplayDate", DbType.String, DisplayDate);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }
        public static Int64 InsertIntotblDealerSales(String DealerCode, String SalesDate, String AddedBy, String Model, String Quantity)
        {

            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertIntotblDealerSales");

            db.AddInParameter(dbCommand, "@DealerCode", DbType.String, DealerCode);
            db.AddInParameter(dbCommand, "@SalesDate", DbType.String, SalesDate);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@Quantity", DbType.String, Quantity);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }
        public static Int64 UpdatetblDisplayProductFromNSM(Int64 DisplayProductID, String AddedBy)
        {
            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.UpdatetblDisplayProductFromNSM");
            db.AddInParameter(dbCommand, "@DisplayProductID", DbType.Int64, DisplayProductID);
            db.AddInParameter(dbCommand, "@AddedBy", DbType.String, AddedBy);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;

        }

        public static Int64 InsertDistributionRecord(String IMEI_1, String IMEI_2, String Model, String DealerCode, String DONumber, String DistributionDate)
        {
            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertIntotblDealerDistributionDetails");

            db.AddInParameter(dbCommand, "@IMEI_1", DbType.String, IMEI_1);
            db.AddInParameter(dbCommand, "@IMEI_2", DbType.String, IMEI_2);
            db.AddInParameter(dbCommand, "@Model", DbType.String, Model);
            db.AddInParameter(dbCommand, "@DealerCode", DbType.String, DealerCode);
            db.AddInParameter(dbCommand, "@DONumber", DbType.String, DONumber);
            db.AddInParameter(dbCommand, "@DistributionDate", DbType.String, DistributionDate);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;
        }


        public static Int64 InsertPlazaAndRsmRecord(string DealerCode,string DealerName,string ZoneID)
        {
            Database db = DataAccessHelper.CreateConnection();
            DbCommand dbCommand = db.GetStoredProcCommand("IMEIReplacementMaster.InsertPlazaAndRsmRecord");

            db.AddInParameter(dbCommand, "@DealerCode", DbType.String, DealerCode);
            db.AddInParameter(dbCommand, "@DealerName", DbType.String, DealerName);
            db.AddInParameter(dbCommand, "@ZoneID", DbType.String, ZoneID);

            if (db.ExecuteNonQuery(dbCommand) > 0)
            {
                return 1;
            }
            return -1;
        }
    }
}