using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BlogMVCProject.Models;

namespace BlogMVCProject.Controllers
{
    public class PostController : Controller
    {
        private BlogDbContext aDbContext = new BlogDbContext();
        public ActionResult Index()
        {
            return RedirectToAction("Index", "Home");
        }
        public ActionResult Details(int? id, string val)
        {
            ViewBag.User = Session.Count == 0 ? null : aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));

            var allPosts = aDbContext.Posts.ToList();
            allPosts.ForEach(post => post.User = aDbContext.Users.Find(post.UserId));
            allPosts.ForEach(post => post.Comments = aDbContext.Comments.Where(x => x.PostId == post.Id).ToList());
            allPosts.ForEach(post => post.Comments.ToList().ForEach(comment => comment.User = aDbContext.Users.Find(comment.UserId)));
            var selectedPost = aDbContext.Posts.Find(id);
            if (val == null && selectedPost.UserId != Convert.ToInt32(Session["userId"]))
            {
                selectedPost.NoOfView++;
                aDbContext.Entry(selectedPost).State = EntityState.Modified;
                aDbContext.SaveChanges();
            }
            ViewBag.LikePost =
                allPosts.Where(
                    x =>
                        x.UserId == selectedPost.UserId && x.Id != selectedPost.Id && x.IsPublished &&
                        x.IsDeleted == false);
            return View(selectedPost);
        }
        public JsonResult AddComment(Comment aComment)
        {
            aComment.CommentDate = DateTime.Now;
            aComment.IsDeleted = false;
            aDbContext.Comments.Add(aComment);
            aDbContext.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Search(string search)
        {
            ViewBag.User = Session.Count == 0 ? null : aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));

            var str = search.Split(' ').ToList();
            var posts = new List<Post>();
            str.ForEach(ch => posts.AddRange(aDbContext.Posts.Where(x => x.IsDeleted == false && x.IsPublished && x.Content.ToLower().Contains(ch.ToLower()) || x.Title.ToLower().Contains(ch.ToLower()))));
            posts = posts.Distinct().ToList();
            posts.ForEach(post => post.Content = post.Content.Take(150).Aggregate("", (current, ch) => current + ch));
            posts.ForEach(post => post.User = aDbContext.Users.Find(post.UserId));
            ViewBag.SearchText = search;
            return View(posts);
        }

        public ActionResult Create()
        {
            if (Session.Count == 0)
                ViewBag.User = null;
            else
            {
                ViewBag.User = aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));
                return View();
            }
            return RedirectToAction("Register", "Home");
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(FormCollection formCollection)
        {
            if (Session.Count == 0)
                ViewBag.User = null;
            else
            {
                ViewBag.User = aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));
                var aPost = new Post
                {
                    Title = formCollection["Title"],
                    Content = Server.HtmlDecode(formCollection["Content"]),
                    IsDeleted = false,
                    IsPublished = false,
                    NoOfView = 0,
                    PostedDate = DateTime.Now,
                    UserId = Convert.ToInt32(Session["userId"])
                };
                if (formCollection.AllKeys.Contains("SaveAndPublish"))
                {
                    aPost.IsPublished = true;
                }
                aDbContext.Posts.Add(aPost);
                aDbContext.SaveChanges();
                return RedirectToAction("PostOfUser", "Post", new { id = Convert.ToInt32(Session["userId"]) });
            }
            return RedirectToAction("Register", "Home");
        }
        public ActionResult PostOfUser(int? id)
        {

            if (Session.Count == 0)
                ViewBag.User = null;

            else
            {
                var userId = Convert.ToInt32(Session["userId"]);
                if (id == userId)
                {
                    ViewBag.User = aDbContext.Users.Find(userId);
                    var posts =
                        aDbContext.Posts.Where(x => x.UserId == id && x.IsDeleted == false)
                            .OrderByDescending(x => x.PostedDate)
                            .ToList();
                    posts.ForEach(x => x.Content = x.Content.Take(250).Aggregate("", (current, ch) => current + ch));
                    posts.ForEach(x => x.Comments = aDbContext.Comments.Where(p => p.PostId == x.Id).ToList());
                    return View(posts);
                }
                return RedirectToAction("Index", "Home");
            }
            return RedirectToAction("Register", "Home");
        }
        public ActionResult Delete(int? id)
        {
            if (Session.Count == 0)
                ViewBag.User = null;
            else
            {
                ViewBag.User = aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));
                var post = aDbContext.Posts.Find(id);
                if (Convert.ToInt32(Session["userId"]) == post.UserId)
                {
                    post.IsDeleted = true;
                    aDbContext.Entry(post).State = EntityState.Modified;
                    aDbContext.SaveChanges();
                    return RedirectToAction("PostOfUser", "Post", new { id = post.UserId });
                }
                RedirectToAction("Index", "Home");
            }
            return RedirectToAction("Register", "Home");
        }
        public ActionResult Publish(int? id)
        {
            if (Session.Count == 0)
                ViewBag.User = null;
            else
            {
                ViewBag.User = aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));
                var post = aDbContext.Posts.Find(id);
                if (Convert.ToInt32(Session["userId"]) == post.UserId)
                {
                    post.IsPublished = true;
                    post.PostedDate = DateTime.Now;
                    aDbContext.Entry(post).State = EntityState.Modified;
                    aDbContext.SaveChanges();
                    return RedirectToAction("PostOfUser", "Post", new {id = post.UserId});
                }
                RedirectToAction("Index", "Home");
            }
            return RedirectToAction("Register", "Home");
        }
        public ActionResult Edit(int? id)
        {
            if (Session.Count == 0)
                ViewBag.User = null;

            else
            {
                var post = aDbContext.Posts.Find(id);

                if (Convert.ToInt32(Session["userId"]) == post.UserId)
                {
                    ViewBag.User = aDbContext.Users.Find(Convert.ToInt32(Session["userId"]));
                    return View(post);
                }
                RedirectToAction("Index", "Home");
            }
            return RedirectToAction("Register", "Home");
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(FormCollection formCollection)
        {
            if (Session.Count == 0)
                ViewBag.User = null;

            else
            {
                var userId = Convert.ToInt32(Session["userId"]);
                ViewBag.User = aDbContext.Users.Find(userId);
                var postId = Convert.ToInt32(formCollection["postId"]);
                var post = aDbContext.Posts.Find(postId);
                if (formCollection.AllKeys.Contains("SaveAndPublish"))
                {
                    post.IsPublished = true;
                }
                post.Title = formCollection["Title"];
                post.Content = Server.HtmlDecode(formCollection["Content"]);
                aDbContext.Entry(post).State = EntityState.Modified;
                aDbContext.SaveChanges();
                return RedirectToAction("PostOfUser", "Post", new { id = userId });
            }
            return RedirectToAction("Register", "Home");
        }
    }
}