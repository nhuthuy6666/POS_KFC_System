using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using POS_KFC.Models;

namespace POS_KFC.Controllers
{
    public class StatisticsController : Controller
    {
        private KFC_ManageEntities db = new KFC_ManageEntities();

        public ActionResult Index(string filterType = "day", int? year = null, int? month = null)
        {
            year = year ?? DateTime.Now.Year;
            month = month ?? DateTime.Now.Month;

            var orders = db.Orders.Where(o => o.OrderDate.Year == year);
            var storeOrders = db.StoreOrders.Where(s => s.OrderDate.Year == year);

            List<string> labels = new List<string>();
            List<decimal> revenueData = new List<decimal>();
            List<decimal> costData = new List<decimal>();
            List<decimal> profitData = new List<decimal>();
            List<int> orderCountData = new List<int>(); // 👈 Thêm dòng này

            if (filterType == "month")
            {
                for (int m = 1; m <= 12; m++)
                {
                    labels.Add($"Tháng {m}");

                    var revenue = orders.Where(o => o.OrderDate.Month == m).Sum(o => (decimal?)o.TotalPrice) ?? 0;
                    var cost = storeOrders.Where(s => s.OrderDate.Month == m).Sum(s => (decimal?)s.TotalPrice) ?? 0;
                    var count = orders.Count(o => o.OrderDate.Month == m);

                    revenueData.Add(revenue);
                    costData.Add(cost);
                    profitData.Add(revenue - cost);
                    orderCountData.Add(count); 
                }
            }
            else if (filterType == "day" && month.HasValue)
            {
                int daysInMonth = DateTime.DaysInMonth(year.Value, month.Value);

                for (int d = 1; d <= daysInMonth; d++)
                {
                    labels.Add($"{d}/{month}/{year}");

                    var revenue = orders.Where(o => o.OrderDate.Month == month && o.OrderDate.Day == d).Sum(o => (decimal?)o.TotalPrice) ?? 0;
                    var cost = storeOrders.Where(s => s.OrderDate.Month == month && s.OrderDate.Day == d).Sum(s => (decimal?)s.TotalPrice) ?? 0;
                    var count = orders.Count(o => o.OrderDate.Month == month && o.OrderDate.Day == d); 

                    revenueData.Add(revenue);
                    costData.Add(cost);
                    profitData.Add(revenue - cost);
                    orderCountData.Add(count); 
                }
            }

            ViewBag.Labels = labels;
            ViewBag.RevenueData = revenueData;
            ViewBag.CostData = costData;
            ViewBag.ProfitData = profitData;
            ViewBag.OrderCountData = orderCountData; 

            ViewBag.FilterType = filterType;
            ViewBag.Year = year;
            ViewBag.Month = month;

            return View();
        }
    }
}
