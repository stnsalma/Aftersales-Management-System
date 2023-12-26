using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using WSMS.Helpers;
using WSMS.DAL;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

//using System.Web.SessionState;



namespace WSMS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

          
          
        }

      //  private const string LOGIN_SESSION_KEY = "LOGGED_IN_USER";
      //  private const string LOGIN_SESSION_KEYS = "LOGGED_IN_USERS";

       

        //public string URL
        //{
        //    get
        //    {
        //        return url;
        //    }
        //}
        //public static String url = "";

        //[WebMethod]
        //public static string DoLogin(string UserName, string Password)
        //{
        //    string msg="success";
        //    try
        //    {
        //        WSMSDataContext contx = new WSMSDataContext();
        //        RepUser objUser = contx.RepUsers.Where(x => x.RepUserName == UserName).FirstOrDefault();
                
        //        if (objUser != null && objUser.IsActive == true)
        //        {

                    
        //            if (LoginHelper.DoLogin(UserName, Password) >= 0)
        //            {
        //                if (objUser.RepRoleID == 2)
        //                {
        //                    msg = "IMEI_Deactivate.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 3)
        //                {
        //                    msg = "IMEISpecialAndSoockFaulty.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 1)
        //                {
        //                    msg = "IMEIRequest.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 4)
        //                {
        //                    msg = "IMEIPrimaryRecommend.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 5)
        //                {
        //                    msg = "WareHouse.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 6)
        //                {
        //                    msg = "WarehouseDeclinedFinalPhase.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 7)
        //                {
        //                    msg = "IMEIRequestForArea.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 8)
        //                {
        //                    msg = "ServiceCenterActivities.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 9)
        //                {
        //                    msg = "WastageInventory.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 10)
        //                {
        //                    msg = "CorporateStore.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //                else if (objUser.RepRoleID == 11)
        //                {
        //                    msg = "StockReconciliationForTSO.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
        //                }
        //            }
        //            else
        //                msg = "IP";
        //        }
        //        else
        //            msg = "IU";
                
        //    }
        //    catch (Exception ex)
        //    {
        //        msg = "err";
        //    }
        //    return msg;
        //}

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //Response.Write(Page.User.Identity.Name);
            string username = txtUserName.Value;
            string password = txtPassword.Value;


            WSMSDataContext contx = new WSMSDataContext();
            RepUser objUser = contx.RepUsers.Where(x => x.RepUserName == username).FirstOrDefault();
            if (objUser != null && objUser.IsActive == true)
            {
                HttpContext.Current.Session["UserID"] = objUser.RepUserID;


                FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                      1, // Ticket version
                      Convert.ToString(objUser.RepUserID), // Username associated with ticket
                      DateTime.Now, // Date/time issued
                      DateTime.Now.AddMinutes(60), // Date/time to expire
                      false, // "true" for a persistent user cookie
                      Convert.ToString(objUser.RepRoleID), // User-data, in this case the roles
                      FormsAuthentication.FormsCookiePath);// Path cookie valid for

                // Encrypt the cookie using the machine key for secure transport
                string hash = FormsAuthentication.Encrypt(ticket);
                HttpCookie cookie = new HttpCookie(
                   FormsAuthentication.FormsCookieName, // Name of auth cookie
                   hash); // Hashed ticket

                // Set the cookie's expiration time to the tickets expiration time
                if (ticket.IsPersistent) cookie.Expires = ticket.Expiration;

                // Add the cookie to the list for outgoing response
                Response.Cookies.Add(cookie);

                if (LoginHelper.DoLogin(username, password) >= 0)
                {

                     if (objUser.RepRoleID == 2)
                     {
                         Response.Redirect("IMEI_Deactivate.aspx?UserID=" + objUser.RepUserID);
                     }
                     else if (objUser.RepRoleID == 3)
                     {
                         Response.Redirect("IMEISpecialAndSoockFaulty.aspx?UserID=" + objUser.RepUserID);
                        // msg = "IMEISpecialAndSoockFaulty.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 1)
                     {
                         Response.Redirect("IMEIRequest.aspx?UserID=" + objUser.RepUserID);
                        // msg = "IMEIRequest.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 4)
                     {
                         Response.Redirect("IMEIPrimaryRecommend.aspx?UserID=" + objUser.RepUserID);
                      //   msg = "IMEIPrimaryRecommend.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 5)
                     {
                         Response.Redirect("WareHouse.aspx?UserID=" + objUser.RepUserID);
                        // msg = "WareHouse.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 6)
                     {
                         Response.Redirect("WarehouseDeclinedFinalPhase.aspx?UserID=" + objUser.RepUserID);
                        // msg = "WarehouseDeclinedFinalPhase.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 7)
                     {
                         Response.Redirect("IMEIRequestForArea.aspx?UserID=" + objUser.RepUserID);
                        // msg = "IMEIRequestForArea.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 8)
                     {
                         Response.Redirect("ServiceCenterActivities.aspx?UserID=" + objUser.RepUserID);
                        // msg = "ServiceCenterActivities.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 9)
                     {
                         Response.Redirect("WastageInventory.aspx?UserID=" + objUser.RepUserID);
                         //msg = "WastageInventory.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 10)
                     {
                         Response.Redirect("CorporateStore.aspx?UserID=" + objUser.RepUserID);
                        // msg = "CorporateStore.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 11)
                     {
                         Response.Redirect("StockReconciliationForTSO.aspx?UserID=" + objUser.RepUserID);
                       //  msg = "StockReconciliationForTSO.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                     else if (objUser.RepRoleID == 12)
                     {
                         Response.Redirect("IMEIPrimaryRecommendByCommonMonitor.aspx?UserID=" + objUser.RepUserID);
                         //  msg = "StockReconciliationForTSO.aspx?userID=" + LoginHelper.LoggedInUsers.RepUserID;
                     }
                }


            }

            else
            {
                lblError.Visible = true;


                lblError.Text = "User Name or PassWord Seems To Be Wrong ";
                Response.Write("User Does not exists");
            }


        }
    }

}