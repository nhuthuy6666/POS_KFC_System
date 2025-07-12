using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace POS_KFC.App_Code
{
    public static class HtmlHelpers
    {
        public static string IsActive(this HtmlHelper html, string controller, string action = null)
        {
            var routeData = html.ViewContext.RouteData;
            var currentController = routeData.Values["controller"]?.ToString();
            var currentAction = routeData.Values["action"]?.ToString();

            if (controller.Equals(currentController, System.StringComparison.OrdinalIgnoreCase) &&
                (action == null || action.Equals(currentAction, System.StringComparison.OrdinalIgnoreCase)))
            {
                return "active";
            }

            return "";
        }
    }
}