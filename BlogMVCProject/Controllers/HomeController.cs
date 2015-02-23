using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BlogMVCProject.Models;

namespace BlogMVCProject.Controllers
{
    public class HomeController : Controller
    {
        private BlogDbContext aDbContext=new BlogDbContext();
        public ActionResult Index()
        {
            ViewBag.User = Session.Count==0 ? null : aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));

            var allPosts = aDbContext.Posts.ToList();
            allPosts.ForEach(post=>post.User = aDbContext.Users.Find(post.UserId));

            var mostRecentPosts = allPosts.Where(x => x.IsDeleted == false && x.IsPublished).OrderByDescending(post => post.PostedDate).Take(5).ToList();
            var mostviewedPosts = allPosts.Where(x => x.IsDeleted == false && x.IsPublished).OrderByDescending(post => post.NoOfView).Take(5).ToList();

            mostRecentPosts.ForEach(x => x.Content = x.Content.Take(200).Aggregate("", (current, ch) => current + ch));
            mostviewedPosts.ForEach(x => x.Content = x.Content.Take(200).Aggregate("", (current, ch) => current + ch));

            ViewBag.MostViewed = mostviewedPosts;
            return View(mostRecentPosts);
        }

        public JsonResult CheckUser(string userName, string password)
        {
            var user = aDbContext.Users.FirstOrDefault(x => x.UserName == userName && x.Password == password);
            if (user != null)
            {
                Session["userId"] = user.Id;
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            return Json(false, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CheckUserName(string username)
        {
            if (aDbContext.Users.FirstOrDefault(x => x.UserName == username) == null)
                return Json(true, JsonRequestBehavior.AllowGet);
            return Json(false, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CheckEmail(string email)
        {
            if (aDbContext.Users.FirstOrDefault(x => x.Email == email) == null)
                return Json(true, JsonRequestBehavior.AllowGet);
            return Json(false, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Register()
        {
            ViewBag.User = Session.Count == 0 ? null : aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(User anUser)
        {
            if (anUser != null)
            {
                if (ModelState.IsValid)
                {
                    anUser.CreatedDate = DateTime.Now;
                    aDbContext.Users.Add(anUser);
                    aDbContext.SaveChanges();
                    Session["userId"] = aDbContext.Users.FirstOrDefault(x => x.UserName == anUser.UserName).Id;
                    return RedirectToAction("Index", "Home");
                }
            }
            return View();
        }

        public ActionResult SignOut()
        {
            Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Users(int? id)
        {
            ViewBag.User = Session.Count == 0 ? null : aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));
            var userList = aDbContext.Users.ToList();
            userList.ForEach(x=>x.Posts=aDbContext.Posts.Where(post=>post.UserId==x.Id&&post.IsPublished&&post.IsDeleted==false).ToList());
            var allUsers = userList.OrderByDescending(x => x.Posts.Count).ToList();
            
            var author = allUsers[0];
            if (id != null)
            {
                author = aDbContext.Users.Find(id);
            }
            author.Posts.ToList().ForEach(x => x.Content = x.Content.Take(200).Aggregate("", (current, ch) => current + ch));
            ViewBag.Author = author;
            return View(allUsers);
        }
	}
}