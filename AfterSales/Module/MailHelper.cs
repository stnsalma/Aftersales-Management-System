using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using System.Net.Mail;
using System.Collections.Generic;
using System.Net;
using System.IO;

namespace WSMS.Helpers
{
    public class MailHelper
    {

        #region Properties
        /// <summary>
        /// Gets or sets an admin email address
        /// </summary>
        private static string AdminEmailAddress
        {
            get
            {
                return "sadeq@surroundapps.com";
            }
        }

        /// <summary>
        /// Gets or sets an admin email display name
        /// </summary>
        private static string AdminEmailDisplayName
        {
            get
            {
                return "Meer @ NewsApp";
            }
        }

        /// <summary>
        /// Gets or sets an admin email host
        /// </summary>
        private static string AdminEmailHost
        {
            get
            {
                return "mail.surroundapps.com";
            }
        }

        /// <summary>
        /// Gets or sets an admin email port
        /// </summary>
        private static int AdminEmailPort
        {
            get
            {
                return 26;
            }
        }

        /// <summary>
        /// Gets or sets an admin email user name
        /// </summary>
        private static string AdminEmailUser
        {
            get
            {
                return "sadeq@surroundapps.com";
            }
        }

        /// <summary>
        /// Gets or sets an admin email password
        /// </summary>
        private static string AdminEmailPassword
        {
            get
            {
                return "sdjfkh%9";
            }
        }

        /// <summary>
        /// Gets or sets a value that controls whether the default system credentials of the application are sent with requests.
        /// </summary>
        private static bool AdminEmailUseDefaultCredentials
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// Gets or sets a value that controls whether the SmtpClient uses Secure Sockets Layer (SSL) to encrypt the connection
        /// </summary>
        private static bool AdminEmailEnableSsl
        {
            get
            {
                return false;
            }
        }
        #endregion

        #region "Send Email Method"
        private static bool SendEmail(string FileName, string Subject, string Body, MailAddress From, MailAddress To, List<string> bcc, List<string> cc)
        {

            try
            {
                MailMessage message = new MailMessage();
                FileInfo fi = null;
                message.From = From;
                message.To.Add(To);
                if (null != bcc)
                    foreach (string address in bcc)
                    {
                        if (!String.IsNullOrEmpty(address))
                            message.Bcc.Add(address);
                    }
                if (null != cc)
                    foreach (string address in cc)
                    {
                        if (!String.IsNullOrEmpty(address))
                            message.CC.Add(address);
                    }
                message.Subject = Subject;
                message.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");
                //message.Body = Body;
                //message.IsBodyHtml = true;

                System.Net.Mail.AlternateView plainView = System.Net.Mail.AlternateView.CreateAlternateViewFromString
    (System.Text.RegularExpressions.Regex.Replace(Body, @"<(.|\n)*?>", string.Empty), null, "text/plain");
                System.Net.Mail.AlternateView htmlView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(Body, null, "text/html");
                message.AlternateViews.Add(plainView);
                message.AlternateViews.Add(htmlView);

                SmtpClient smtpClient = new SmtpClient();
                smtpClient.UseDefaultCredentials = AdminEmailUseDefaultCredentials;
                smtpClient.Host = AdminEmailHost;
                smtpClient.Port = AdminEmailPort;
                smtpClient.EnableSsl = AdminEmailEnableSsl;

                if (AdminEmailUseDefaultCredentials)
                    smtpClient.Credentials = CredentialCache.DefaultNetworkCredentials;
                else
                    smtpClient.Credentials = new NetworkCredential(AdminEmailUser, AdminEmailPassword);
                smtpClient.Send(message);
                if (null != fi)
                    fi.Delete();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }


        #endregion

        #region "Public Mail Sending Methods"

        //public static bool SendEmail(string Subject, string MSG)
        //{
        //    return SendEmail(Subject, MSG, new System.Net.Mail.MailAddress("sadeq@surroundapps.com"), new System.Net.Mail.MailAddress("sadeq@surroundapps.com"), null, null, null);

        //}

        #endregion

        public static bool SendEmail(string FileName, string Subject, string MSG)
        {
            return SendEmail(FileName, FileName + Subject, FileName + MSG, new System.Net.Mail.MailAddress("sadeq@surroundapps.com"), new System.Net.Mail.MailAddress("ncloudsite@gmail.com"), null, null);
        }
    }
}
