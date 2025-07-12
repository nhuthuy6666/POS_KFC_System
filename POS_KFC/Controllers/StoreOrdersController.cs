using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using POS_KFC.Models;

namespace POS_KFC.Controllers
{
    public class StoreOrdersController : Controller
    {
        private KFC_ManageEntities db = new KFC_ManageEntities();

        // GET: StoreOrders
        public ActionResult Index()
        {
            return View(db.StoreOrders.OrderByDescending(o => o.OrderDate).ToList());
        }

        // GET: StoreOrders/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            // Include các chi tiết đơn hàng
            var storeOrder = db.StoreOrders
                               .Include(s => s.StoreOrderDetails.Select(d => d.Ingredient)) 
                               .FirstOrDefault(s => s.StoreOrderId == id);

            if (storeOrder == null)
            {
                return HttpNotFound();
            }

            return View(storeOrder);
        }

        // GET: StoreOrders/Create
        public ActionResult Create()
        {
            var ingredients = db.Ingredients.ToList();

            ViewBag.Ingredients = ingredients.Select(i => new SelectListItem
            {
                Value = i.IngredientId.ToString(),
                Text = i.IngredientName
            }).ToList();

            ViewBag.AllIngredients = ingredients;

            var model = new StoreOrder
            {
                OrderDate = DateTime.Today 
            };

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(StoreOrder storeOrder, List<StoreOrderDetail> StoreOrderDetails)
        {
            if (ModelState.IsValid)
            {
                storeOrder.StoreOrderDetails = new List<StoreOrderDetail>();
                decimal total = 0;

                foreach (var detail in StoreOrderDetails)
                {
                    if (detail != null && detail.Quantity > 0)
                    {
                        var ingredient = db.Ingredients.Find(detail.IngredientId);
                        if (ingredient != null)
                        {
                            // Tính tổng giá trị
                            total += ingredient.Price * detail.Quantity;

                            // Cập nhật tồn kho
                            ingredient.Quantity += detail.Quantity;

                            // Thêm chi tiết vào đơn
                            storeOrder.StoreOrderDetails.Add(detail);
                        }
                    }
                }

                // Thêm phí vận chuyển
                total += storeOrder.ShippingFee ?? 0;

                // Gán tổng tiền
                storeOrder.TotalPrice = (int?)Math.Round(total);

                db.StoreOrders.Add(storeOrder);
                db.SaveChanges();

                return RedirectToAction("Index", "Ingredients");
            }

            // Nếu ModelState không hợp lệ, load lại dữ liệu
            var ingredients = db.Ingredients.ToList();
            ViewBag.Ingredients = ingredients.Select(i => new SelectListItem
            {
                Value = i.IngredientId.ToString(),
                Text = i.IngredientName
            }).ToList();
            ViewBag.AllIngredients = ingredients;

            return View(storeOrder);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
