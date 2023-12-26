using System.Web;
using System.Text;
using System.Web.UI;


public static class Alert
{

 
  public static void Show(string message)
  {
 
    string cleanMessage = message.Replace("'", "\\'");
    string script = "<script type=\"text/javascript\">alert('" + cleanMessage + "');</script>";

   
    Page page = HttpContext.Current.CurrentHandler as Page;

  
    if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
    {
      page.ClientScript.RegisterClientScriptBlock(typeof(Alert), "alert", script);
    }
  }
	
}


//using System.Web;
//using System.Text;
//using System.Web.UI;

///// <summary> 
///// A JavaScript alert 
///// </summary> 
//public static class Alert
//{

///// <summary> 
///// Shows a client-side JavaScript alert in the browser. 
///// </summary> 
///// <param name="message">The message to appear in the alert.</param> 
//public static void Show(string message)
//{
//   // Cleans the message to allow single quotation marks 
//   string cleanMessage = message.Replace("'", "\\'");
//   string script = "<script type=\"text/javascript\">alert('" + cleanMessage + "');</script>";

//   // Gets the executing web page 
//   Page page = HttpContext.Current.CurrentHandler as Page;

//   // Checks if the handler is a Page and that the script isn't allready on the Page 
//   if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
//   {
//      page.ClientScript.RegisterClientScriptBlock(typeof(Alert), "alert", script);
//   }
//}    
//}
//Demonstration
//That class of only 30 lines of code enables us to add a JavaScript alert to any page at any time. Here is an example of a Button.Click event handler that uses the method for displaying status messages.
//void btnSave_Click(object sender, EventArgs e)
//{
//   try 
//   {
//      SaveSomething();
//      Alert.Show("You document has been saved");
//   }
//   catch (ReadOnlyException)
//   {
//      Alert.Show("You do not have write permission to this file");
//   }
//}