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
    public class WorkLogsController : Controller
    {
        private KFC_ManageEntities db = new KFC_ManageEntities();

        // GET: WorkLogs
        public ActionResult Index()
        {
            var workLogs = db.WorkLogs.Include(w => w.Employee);
            return View(workLogs.ToList());
        }

        // GET: WorkLogs/Create
        public ActionResult Create(int employeeId)
        {
            var workLog = new WorkLog
            {
                EmployeeId = employeeId,
            };
            return View(workLog);
        }

        // POST: WorkLogs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "WorkLogId,EmployeeId,WorkDate,TimeIn,TimeOut,ShiftName")] WorkLog workLog)
        {
            if (ModelState.IsValid)
            {
                db.WorkLogs.Add(workLog);
                db.SaveChanges();
                return RedirectToAction("Details", "Employees", new { id = workLog.EmployeeId });
            }

            ViewBag.EmployeeId = new SelectList(db.Employees, "EmployeeId", "FirstName", workLog.EmployeeId);
            return View(workLog);
        }

        // GET: WorkLogs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            WorkLog workLog = db.WorkLogs.Find(id);
            if (workLog == null)
            {
                return HttpNotFound();
            }
            return View(workLog);
        }

        // POST: WorkLogs/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var workLog = db.WorkLogs.Find(id);
            if (workLog == null)
                return HttpNotFound();

            db.WorkLogs.Remove(workLog);
            db.SaveChanges();

            return new HttpStatusCodeResult(200); 
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
