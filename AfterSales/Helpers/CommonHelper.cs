using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text.RegularExpressions;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace WSMS.Helpers
{
    public class CommonHelper
    {
        public static byte[] ConvertToByteArray(Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (MemoryStream ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }

        public static string MD5(string PlainText)
        {
            MD5CryptoServiceProvider md5Provider = new MD5CryptoServiceProvider();
            byte[] buffer = Encoding.ASCII.GetBytes(PlainText);
            return BitConverter.ToString(md5Provider.ComputeHash(buffer));
        }
        
        public static bool IsValidEmail(string Email)
        {
            bool result = false;
            if (String.IsNullOrEmpty(Email))
                return result;
            Email = Email.Trim();
            result = Regex.IsMatch(Email, @"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
            return result;
        }

        public static string QueryString(string Name)
        {
            string result = string.Empty;
            if (HttpContext.Current != null && HttpContext.Current.Request.QueryString[Name] != null)
                result = HttpContext.Current.Request.QueryString[Name].ToString();
            return result;
        }

        public static bool QueryStringBool(string Name)
        {
            string resultStr = QueryString(Name).ToUpperInvariant();
            return (resultStr == "YES" || resultStr == "TRUE" || resultStr == "1");
        }

        public static DateTime QueryStringDate(string Name)
        {
            string resultStr = QueryString(Name).ToUpperInvariant();
            DateTime result;
            DateTime.TryParse(resultStr, out result);
            return result;
        }

        public static int QueryStringInt(string Name)
        {
            string resultStr = QueryString(Name).ToUpperInvariant();
            int result;
            int.TryParse(resultStr, out result);
            return result;
        }

        public static Int64 QueryStringInt64(string Name)
        {
            string resultStr = QueryString(Name).ToUpperInvariant();
            if (resultStr.Length > 0)
            {
                return Int64.Parse(resultStr);
            }
            return 0;
        }

        public static Guid? QueryStringGUID(string Name)
        {
            string resultStr = QueryString(Name).ToUpperInvariant();
            Guid? result = null;
            try
            {
                result = new Guid(resultStr);
            }
            catch
            {
            }
            return result;
        }

        public static void SelectListItem(DropDownList List, object Value)
        {
            if (List.Items.Count != 0)
            {
                var selectedItem = List.SelectedItem;
                if (selectedItem != null)
                    selectedItem.Selected = false;
                if (Value != null)
                {
                    selectedItem = List.Items.FindByValue(Value.ToString());
                    if (selectedItem != null)
                        selectedItem.Selected = true;
                }
            }
        }

        public static string GetThisPageURL(bool includeQueryString)
        {
            string URL = string.Empty;
            if (HttpContext.Current == null)
                return URL;

            if (includeQueryString)
            {
                bool useSSL = IsCurrentConnectionSecured();
                string siteHost = GetSiteHost(useSSL);
                if (siteHost.EndsWith("/"))
                    siteHost = siteHost.Substring(0, siteHost.Length - 1);
                URL = siteHost + HttpContext.Current.Request.RawUrl;
            }
            else
            {
                URL = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Path);
            }
            return URL;
        }

        public static string GetSiteHost(bool UseSSL)
        {
            string result = "http://" + ServerVariables("HTTP_HOST");
            if (!result.EndsWith("/"))
                result += "/";

            if (UseSSL)
            {
                if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["SharedSSL"]))
                {
                    result = ConfigurationManager.AppSettings["SharedSSL"];
                }
                else
                {
                    result = result.Replace("http:/", "https:/");
                }
            }

            if (!result.EndsWith("/"))
                result += "/";

            return result;
        }

        public static string ServerVariables(string Name)
        {
            string tmpS = String.Empty;
            try
            {
                if (HttpContext.Current.Request.ServerVariables[Name] != null)
                {
                    tmpS = HttpContext.Current.Request.ServerVariables[Name].ToString();
                }
            }
            catch
            {
                tmpS = String.Empty;
            }
            return tmpS;
        }


        public static void WriteResponsePDF(string filePath, string targetFileName)
        {
            if (!String.IsNullOrEmpty(filePath))
            {
                HttpResponse response = HttpContext.Current.Response;
                response.Clear();
                response.Charset = "utf-8";
                response.ContentType = "text/pdf";
                response.AddHeader("content-disposition", string.Format("attachment; filename={0}", targetFileName));
                response.BinaryWrite(File.ReadAllBytes(filePath));
                response.End();
            }
        }

        public static string GenerateRandomDigitCode(int Length)
        {
            var random = new Random();
            string s = "";
            for (int i = 0; i < Length; i++)
                s = String.Concat(s, random.Next(10).ToString());
            return s;
        }

        public static void ReloadCurrentPage()
        {
            bool useSSL = IsCurrentConnectionSecured();
            ReloadCurrentPage(useSSL);
        }

        public static void ReloadCurrentPage(bool UseSSL)
        {
            string siteHost = GetSiteHost(UseSSL);
            if (siteHost.EndsWith("/"))
                siteHost = siteHost.Substring(0, siteHost.Length - 1);
            string URL = siteHost + HttpContext.Current.Request.RawUrl;
            HttpContext.Current.Response.Redirect(URL);
        }

        public static bool IsCurrentConnectionSecured()
        {
            bool useSSL = false;
            if (HttpContext.Current != null && HttpContext.Current.Request != null)
            {
                useSSL = HttpContext.Current.Request.IsSecureConnection;
                //when your hosting uses a load balancer on their server then the Request.IsSecureConnection is never got set to true, use the statement below
                //just uncomment it
                //useSSL = HttpContext.Current.Request.ServerVariables["HTTP_CLUSTER_HTTPS"] == "on" ? true : false;
            }

            return useSSL;
        }

        public static void CreateDirectory(string path)
        {

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
        }

        #region "PATH PROPERTIES"

        public static string KeyStore
        {
            get { return ConfigurationManager.AppSettings["KeyStore"]; }
        }

        #endregion
    }
}
