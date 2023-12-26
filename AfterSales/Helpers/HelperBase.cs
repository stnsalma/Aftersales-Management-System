using System.Web;
using System.Web.SessionState;

namespace WSMS.Helpers
{
    public class HelperBase
    {
        protected static HttpContext Context
        {
            get { return HttpContext.Current; }
        }

        protected static HttpRequest Request
        {
            get { return Context.Request; }
        }

        protected static HttpResponse Response
        {
            get { return Context.Response; }
        }

        public static HttpSessionState Session
        {
            get { return Context.Session; }
        }

        protected static HttpServerUtility Server
        {
            get { return Context.Server; }
        }


    }
}
