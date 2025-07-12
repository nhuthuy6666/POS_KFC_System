using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using POS_KFC.Models;

namespace POS_KFC.Controllers
{
    public class ProductsController : Controller
    {
        private KFC_ManageEntities db = new KFC_ManageEntities();

        // GET: Products
        public ActionResult Index(string searchString, int? productTypeId, int? promotionId)
        {
            var products = db.Products.Include(p => p.ProductType).Include(p => p.Promotion);

            if (!string.IsNullOrEmpty(searchString))
            {
                products = products.Where(p => p.ProductName.Contains(searchString));
            }
            if (productTypeId.HasValue)
            {
                products = products.Where(p => p.ProductTypeId == productTypeId);
            }
            if (promotionId.HasValue && promotionId != 11)
            {
                products = products.Where(p => p.PromotionId == promotionId);
            }
            if (promotionId == 11)
            {
                products = products.Where(p => p.PromotionId == null || p.PromotionId == 11);
            }

            ViewBag.ProductTypes = new SelectList(db.ProductTypes, "ProductTypeId", "ProductTypeName");
            ViewBag.Promotions = new SelectList(db.Promotions, "PromotionId", "PromotionName");

            return View(products.ToList());
        }

        // GET: Products/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // GET: Products/Create
        public ActionResult Create()
        {
            ViewBag.ProductTypeId = new SelectList(db.ProductTypes, "ProductTypeId", "ProductTypeName");
            ViewBag.PromotionId = new SelectList(db.Promotions, "PromotionId", "PromotionName");
            return View();
        }

        // POST: Products/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Product product, HttpPostedFileBase ProductImageFile)
        {
            if (ModelState.IsValid)
            {
                if (ProductImageFile != null && ProductImageFile.ContentLength > 0)
                {
                    // Tạo tên file unique để tránh trùng lặp
                    var fileExtension = Path.GetExtension(ProductImageFile.FileName);
                    var fileName = Guid.NewGuid().ToString() + fileExtension;
                    var filePath = Path.Combine(Server.MapPath("~/Content/images/products"), fileName);

                    var folderPath = Server.MapPath("~/Content/images/products");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    ProductImageFile.SaveAs(filePath);
                    // Chỉ lưu tên file, không lưu full path
                    product.ProductImage = fileName;
                }

                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ProductTypeId = new SelectList(db.ProductTypes, "ProductTypeId", "ProductTypeName", product.ProductTypeId);
            ViewBag.PromotionId = new SelectList(db.Promotions, "PromotionId", "PromotionName", product.PromotionId);
            return View(product);
        }


        // GET: Products/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.ProductTypeId = new SelectList(db.ProductTypes, "ProductTypeId", "ProductTypeName", product.ProductTypeId);
            ViewBag.PromotionId = new SelectList(db.Promotions, "PromotionId", "PromotionName", product.PromotionId);
            return View(product);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Product product, HttpPostedFileBase ProductImageFile)
        {
            if (ModelState.IsValid)
            {
                // Xử lý upload file mới nếu có
                if (ProductImageFile != null && ProductImageFile.ContentLength > 0)
                {
                    // Xóa ảnh cũ nếu có
                    var existingProduct = db.Products.AsNoTracking().FirstOrDefault(p => p.ProductId == product.ProductId);
                    if (existingProduct != null && !string.IsNullOrEmpty(existingProduct.ProductImage))
                    {
                        var oldImagePath = Path.Combine(Server.MapPath("~/Content/images/products"), existingProduct.ProductImage);
                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }

                    // Upload ảnh mới
                    var fileExtension = Path.GetExtension(ProductImageFile.FileName);
                    var fileName = Guid.NewGuid().ToString() + fileExtension;
                    var filePath = Path.Combine(Server.MapPath("~/Content/images/products"), fileName);

                    var folderPath = Server.MapPath("~/Content/images/products");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    ProductImageFile.SaveAs(filePath);
                    product.ProductImage = fileName;
                }
                else
                {
                    // Giữ lại ảnh cũ nếu không upload ảnh mới
                    var existingProduct = db.Products.AsNoTracking().FirstOrDefault(p => p.ProductId == product.ProductId);
                    if (existingProduct != null)
                    {
                        product.ProductImage = existingProduct.ProductImage;
                    }
                }

                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ProductTypeId = new SelectList(db.ProductTypes, "ProductTypeId", "ProductTypeName", product.ProductTypeId);
            ViewBag.PromotionId = new SelectList(db.Promotions, "PromotionId", "PromotionName", product.PromotionId);
            return View(product);
        }

        // GET: Products/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpGet]
        public JsonResult GetProducts()
        {
            var products = db.Products
                .Select(p => new
                {
                    p.ProductId,
                    p.ProductName,
                    p.ProductImage,
                    ProductTypeName = p.ProductType.ProductTypeName,
                    p.PromotionId
                }).ToList();

            return Json(new { success = true, data = products }, JsonRequestBehavior.AllowGet);
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
