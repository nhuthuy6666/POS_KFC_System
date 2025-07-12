using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using POS_KFC.Models;

namespace POS_KFC.Controllers
{
    public class OrdersController : Controller
    {
        private KFC_ManageEntities db = new KFC_ManageEntities();

        // GET: Orders
        public ActionResult Index(string orderId, DateTime? specificDate, int? month, int? year,
                          DateTime? fromDate, DateTime? toDate, decimal? minPrice, decimal? maxPrice)
        {
            var orders = db.Orders.Include(o => o.Customer).Include(o => o.Employee).AsQueryable();

            // Lọc dữ liệu theo các tiêu chí tìm kiếm
            if (!string.IsNullOrEmpty(orderId) && int.TryParse(orderId, out int orderIdInt))
            {
                orders = orders.Where(o => o.OrderId == orderIdInt);
            }

            if (specificDate.HasValue)
            {
                orders = orders.Where(o => DbFunctions.TruncateTime(o.OrderDate) == DbFunctions.TruncateTime(specificDate.Value));
            }

            if (month.HasValue && month.Value >= 1 && month.Value <= 12)
            {
                orders = orders.Where(o => o.OrderDate.Month == month.Value);
            }

            if (year.HasValue)
            {
                orders = orders.Where(o => o.OrderDate.Year == year.Value);
            }

            if (fromDate.HasValue)
            {
                orders = orders.Where(o => DbFunctions.TruncateTime(o.OrderDate) >= DbFunctions.TruncateTime(fromDate.Value));
            }

            if (toDate.HasValue)
            {
                orders = orders.Where(o => DbFunctions.TruncateTime(o.OrderDate) <= DbFunctions.TruncateTime(toDate.Value));
            }

            if (minPrice.HasValue && minPrice.Value >= 0)
            {
                orders = orders.Where(o => o.TotalPrice >= minPrice.Value);
            }

            if (maxPrice.HasValue && maxPrice.Value >= 0)
            {
                orders = orders.Where(o => o.TotalPrice <= maxPrice.Value);
            }

            // Sắp xếp kết quả
            var result = orders
                .OrderByDescending(o => o.OrderDate)
                .ThenByDescending(o => o.OrderTime)
                .ToList(); 

            return View(result); 
        }

        // GET: Orders/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Include(o => o.OrdersProducts).FirstOrDefault(o => o.OrderId == id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // GET: Orders/Create
        public ActionResult Create()
        {
            ViewBag.CustomerId = new SelectList(db.Customers, "CustomerId", "FirstName");
            ViewBag.EmployeeId = new SelectList(db.Employees, "EmployeeId", "FirstName");
            ViewBag.Products = db.Products.ToList();
            return View();
        }

        // POST: Orders/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Order order)
        {
            try
            {
                if (Session["EmployeeId"] != null)
                {
                    order.EmployeeId = (int)Session["EmployeeId"];
                }

                string selectedProductsJson = Request.Form["SelectedProductsJson"];
                if (string.IsNullOrEmpty(selectedProductsJson))
                {

                    ViewBag.Products = new KFC_ManageEntities().Products
                        .Include(p => p.Promotion)
                        .ToList();

                    return View(order);
                }

                var selectedProducts = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(selectedProductsJson);

                using (var context = new KFC_ManageEntities())
                {
                    // Lưu Order
                    context.Orders.Add(order);
                    context.SaveChanges();

                    // Lưu từng dòng OrdersProduct
                    foreach (var item in selectedProducts)
                    {
                        var orderProduct = new OrdersProduct
                        {
                            OrderId = order.OrderId,
                            ProductId = Convert.ToInt32(item["productId"]),
                            Quantity = Convert.ToInt32(item["quantity"])
                        };

                        context.OrdersProducts.Add(orderProduct);
                    }

                    context.SaveChanges();
                }

                return RedirectToAction("Confirm", new { id = order.OrderId });
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Lỗi khi tạo đơn hàng: " + ex.Message);
                return View(order);
            }
        }

        public ActionResult Confirm(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var order = db.Orders
                .Include(o => o.OrdersProducts.Select(op => op.Product))
                .FirstOrDefault(o => o.OrderId == id);

            if (order == null)
            {
                return HttpNotFound();
            }

            return View(order);
        }

        public ActionResult PDF(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var order = db.Orders
                .Include(o => o.OrdersProducts.Select(op => op.Product))
                .FirstOrDefault(o => o.OrderId == id);

            if (order == null)
            {
                return HttpNotFound();
            }

            return View(order);
        }
        public ActionResult PrintOrder(int id)
        {
            try
            {
                var order = db.Orders
                    .Include(o => o.OrdersProducts.Select(op => op.Product.Promotion))
                    .FirstOrDefault(o => o.OrderId == id);

                if (order == null)
                {
                    return HttpNotFound();
                }

                // Tạo PDF từ View như trước
                var pdfResult = new Rotativa.ViewAsPdf("PDF", order)
                {
                    PageOrientation = Rotativa.Options.Orientation.Portrait,
                    PageMargins = new Rotativa.Options.Margins(5, 5, 5, 5),
                    CustomSwitches = "--page-width 90mm --page-height 130mm"
                };

                var pdfBytes = pdfResult.BuildFile(ControllerContext);

                // Đường dẫn tuyệt đối lưu PDF
                var savePath = Server.MapPath($"~/Content/Images/Invoices/Order_{id}.pdf");

                // Tạo thư mục nếu chưa tồn tại
                var folderPath = Path.GetDirectoryName(savePath);
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                    System.Diagnostics.Debug.WriteLine($"Thư mục đã được tạo: {folderPath}");
                }

                // Lưu file
                System.IO.File.WriteAllBytes(savePath, pdfBytes);
                System.Diagnostics.Debug.WriteLine($"PDF đã lưu: {savePath}");

                // Trả về file PDF cho client
                return File(pdfBytes, "application/pdf", $"Order_{id}.pdf");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LỖI KHI LƯU PDF:");
                System.Diagnostics.Debug.WriteLine(ex.ToString());

                return new HttpStatusCodeResult(500, "Lỗi khi xử lý đơn hàng.");
            }
        }
    }
}
