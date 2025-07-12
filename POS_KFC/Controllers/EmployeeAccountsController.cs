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
using POS_KFC.Models.ViewModels;

namespace POS_KFC.Controllers
{
    public class EmployeeAccountsController : Controller
    {
        private KFC_ManageEntities db = new KFC_ManageEntities();

        // GET: EmployeeAccounts/Index
        public ActionResult Index()
        {
            if (Session["EmployeeId"] == null)
                return RedirectToAction("Login");

            int employeeId = (int)Session["EmployeeId"];

            var account = db.EmployeeAccounts.FirstOrDefault(a => a.EmployeeId == employeeId);
            var employee = db.Employees.Include(e => e.Position).FirstOrDefault(e => e.EmployeeId == employeeId);
            var workLogs = db.WorkLogs
                            .Where(w => w.EmployeeId == employeeId)
                            .OrderBy(w => w.WorkDate)
                            .ToList();

            var viewModel = new EmployeeProfileViewModel
            {
                Employee = employee,
                Account = account,
                WorkLogs = workLogs
            };

            return View(viewModel);
        }

        // GET: EmployeeAccounts/Create
        public ActionResult Create(int employeeId)
        {
            var model = new EmployeeAccount
            {
                EmployeeId = employeeId
            };

            return View(model);
        }

        // POST: EmployeeAccounts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(EmployeeAccount model, HttpPostedFileBase AvatarUpload)
        {
            if (ModelState.IsValid)
            {
                if (AvatarUpload != null && AvatarUpload.ContentLength > 0)
                {
                    // Tạo tên file duy nhất để tránh trùng
                    var fileName = Path.GetFileName(AvatarUpload.FileName);
                    var uniqueName = Guid.NewGuid().ToString() + Path.GetExtension(fileName);
                    var path = Path.Combine(Server.MapPath("~/Content/images/avatar"), uniqueName);
                    AvatarUpload.SaveAs(path);

                    model.Avatar = uniqueName;
                }

                db.EmployeeAccounts.Add(model);
                db.SaveChanges();
                return RedirectToAction("Details", "Employees", new { id = model.EmployeeId });
            }

            return View(model);
        }

        // GET: EmployeeAccounts/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmployeeAccount employeeAccount = db.EmployeeAccounts.Find(id);
            if (employeeAccount == null)
            {
                return HttpNotFound();
            }
            return View(employeeAccount);
        }

        // POST: EmployeeAccounts/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("EmployeeAccounts/DeleteConfirmed/{id}")]
        public ActionResult DeleteConfirmed(int id)
        {
            var employeeAccount = db.EmployeeAccounts.Find(id);
            if (employeeAccount == null)
            {
                return HttpNotFound();
            }

            db.EmployeeAccounts.Remove(employeeAccount);
            db.SaveChanges();
            return Json(new { success = true });
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        [HttpGet]
        public ActionResult Login()
        {
            var model = new EmployeeAccount();

            if (Request.Cookies["RememberUsername"] != null)
            {
                model.AccountName = Request.Cookies["RememberUsername"].Value;
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(EmployeeAccount model, bool rememberMe = false)
        {
            if (ModelState.IsValid)
            {
                var account = db.EmployeeAccounts
                                .FirstOrDefault(a => a.AccountName == model.AccountName && a.Password == model.Password);
                if (account != null)
                {
                    // Ghi session
                    Session["Username"] = account.AccountName;
                    Session["EmployeeId"] = account.EmployeeId;

                    // Nếu ghi nhớ thì tạo cookie
                    if (rememberMe)
                    {
                        HttpCookie usernameCookie = new HttpCookie("RememberUsername", account.AccountName);
                        usernameCookie.Expires = DateTime.Now.AddDays(7);
                        Response.Cookies.Add(usernameCookie);
                    }

                    return RedirectToAction("Index", "EmployeeAccounts");
                }

                ViewBag.LoginError = "Sai tên đăng nhập hoặc mật khẩu.";
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult ChangeAvatar(HttpPostedFileBase AvatarFile)
        {
            if (AvatarFile != null && AvatarFile.ContentLength > 0)
            {
                // Validate file type
                var allowedExtensions = new[] { ".jpg", ".jpeg", ".png", ".gif" };
                var extension = Path.GetExtension(AvatarFile.FileName).ToLower();

                var username = Session["Username"]?.ToString();
                if (string.IsNullOrEmpty(username))
                {
                    return Json(new { success = false, message = "Phiên đăng nhập hết hạn" });
                }

                var account = db.EmployeeAccounts.FirstOrDefault(a => a.AccountName == username);
                if (account == null)
                {
                    return Json(new { success = false, message = "Không tìm thấy tài khoản" });
                }

                // Create unique filename
                var uniqueName = Guid.NewGuid().ToString() + extension;
                var avatarPath = Server.MapPath("~/Content/images/avatar/");

                // Create directory if it doesn't exist
                if (!Directory.Exists(avatarPath))
                {
                    Directory.CreateDirectory(avatarPath);
                }

                var fullPath = Path.Combine(avatarPath, uniqueName);

                // Delete old avatar file if it exists and is not default
                if (!string.IsNullOrEmpty(account.Avatar) && account.Avatar != "default.png")
                {
                    var oldFilePath = Path.Combine(avatarPath, account.Avatar);
                    if (System.IO.File.Exists(oldFilePath))
                    {
                        try
                        {
                            System.IO.File.Delete(oldFilePath);
                        }
                        catch (Exception ex)
                        {
                            // Log error but don't fail the operation
                            System.Diagnostics.Debug.WriteLine($"Could not delete old avatar: {ex.Message}");
                        }
                    }
                }

                // Save new avatar
                AvatarFile.SaveAs(fullPath);

                // Update database
                account.Avatar = uniqueName;
                db.SaveChanges();
            }
            else
            {
                if (Request.IsAjaxRequest())
                {
                    return Json(new { success = false, message = "Vui lòng chọn file ảnh" });
                }

                TempData["Error"] = "Vui lòng chọn file ảnh.";
            }

            return RedirectToAction("Index", "EmployeeAccounts");
        }

        [HttpGet]
        public ActionResult ChangePassword()
        {
            if (Session["EmployeeId"] == null)
                return RedirectToAction("Login");

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {
            if (Session["EmployeeId"] == null)
                return RedirectToAction("Login");

            int employeeId = (int)Session["EmployeeId"];
            var account = db.EmployeeAccounts.FirstOrDefault(a => a.EmployeeId == employeeId);

            if (account == null)
                return HttpNotFound();

            if (account.Password != currentPassword)
            {
                ModelState.AddModelError("", "Mật khẩu hiện tại không đúng.");
            }
            else if (newPassword != confirmPassword)
            {
                ModelState.AddModelError("", "Mật khẩu mới không khớp.");
            }
            else
            {
                account.Password = newPassword;
                db.SaveChanges();
                ViewBag.Success = "Đổi mật khẩu thành công.";
            }

            return View();
        }

        public ActionResult Logout()
        {
            Session.Clear(); 
            return RedirectToAction("Login");
        }

    }
}
