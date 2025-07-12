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
    public class IngredientsController : Controller
    {
        private KFC_ManageEntities db = new KFC_ManageEntities();

        // GET: Ingredients
        public ActionResult Index()
        {
            var ingredients = db.Ingredients.ToList();
            var storeOrders = db.StoreOrders.ToList(); 

            ViewBag.StoreOrders = storeOrders; 

            return View(ingredients);
        }

        [HttpPost]
        public ActionResult UpdateIngredient(int id, int newQuantity, int newPrice)
        {
            var ingredient = db.Ingredients.Find(id);
            if (ingredient == null)
            {
                return HttpNotFound();
            }

            ingredient.Quantity = newQuantity;
            ingredient.Price = newPrice;

            db.SaveChanges();

            return RedirectToAction("Index"); 
        }


        // GET: Ingredients/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Ingredients/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IngredientId,IngredientName,Price,Quantity")] Ingredient ingredient)
        {
            if (ModelState.IsValid)
            {
                db.Ingredients.Add(ingredient);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            var ingredients = db.Ingredients.ToList();
            var storeOrders = db.StoreOrders.ToList();
            ViewBag.StoreOrders = storeOrders;

            return View("Index", ingredients);
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
