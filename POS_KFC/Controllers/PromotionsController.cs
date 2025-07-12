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
    public class PromotionsController : Controller
    {
        private KFC_ManageEntities db = new KFC_ManageEntities();

        // GET: Promotions
        public ActionResult Index()
        {
            return View(db.Promotions.ToList());
        }

        // GET: Promotions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Promotion promotion = db.Promotions.Find(id);
            if (promotion == null)
            {
                return HttpNotFound();
            }
            return View(promotion);
        }

        // GET: Promotions/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Promotions/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "PromotionId,PromotionName,PromotionPrice")] Promotion promotion)
        {
            if (ModelState.IsValid)
            {
                // Chuyển đổi từ phần trăm sang hệ số (0-1)
                promotion.PromotionPrice = promotion.PromotionPrice / 100m;

                db.Promotions.Add(promotion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(promotion);
        }

        // GET: Promotions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Promotion promotion = db.Promotions.Find(id);
            if (promotion == null)
            {
                return HttpNotFound();
            }
            return View(promotion);
        }

        // POST: Promotions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Promotion promotion = db.Promotions.Find(id);
            db.Promotions.Remove(promotion);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult ApplyToProducts(int promotionId, List<int> productIds)
        {
            if (productIds == null || !productIds.Any())
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, "Không có sản phẩm nào được chọn.");
            }

            try
            {
                using (var db = new KFC_ManageEntities())
                {
                    var products = db.Products.Where(p => productIds.Contains(p.ProductId)).ToList();
                    foreach (var product in products)
                    {
                        product.PromotionId = promotionId;
                    }
                    db.SaveChanges();
                }

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }

        [HttpPost]
        public ActionResult RemoveFromProducts(int promotionId, List<int> productIds)
        {
            if (productIds == null || !productIds.Any())
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, "Không có sản phẩm nào để gỡ khuyến mãi.");
            }

            try
            {
                using (var db = new KFC_ManageEntities())
                {
                    var products = db.Products
                        .Where(p => productIds.Contains(p.ProductId) && p.PromotionId == promotionId)
                        .ToList();

                    foreach (var product in products)
                    {
                        product.PromotionId = null; 
                    }

                    db.SaveChanges();
                }

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }


        [HttpPost]
        public JsonResult ApplyToAllProducts(int promotionId)
        {
            var allProducts = db.Products.ToList();
            foreach (var product in allProducts)
            {
                product.PromotionId = promotionId;
            }
            db.SaveChanges();

            return Json(new { success = true, message = "Đã áp dụng cho tất cả sản phẩm." });
        }

        [HttpPost]
        public JsonResult RemoveFromAppliedProducts(int promotionId)
        {
            var products = db.Products.Where(p => p.PromotionId == promotionId).ToList();
            foreach (var product in products)
            {
                product.PromotionId = null;
            }
            db.SaveChanges();

            return Json(new { success = true, message = "Đã huỷ áp dụng khỏi sản phẩm." });
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
