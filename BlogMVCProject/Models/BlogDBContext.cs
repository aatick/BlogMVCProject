using System.Data.Entity;

namespace BlogMVCProject.Models
{
    public class BlogDbContext : DbContext
    {
        public BlogDbContext() : base("BlogDBConnectionString")
        {
            Configuration.ProxyCreationEnabled = false;
        }

        public DbSet<User> Users { set; get; }
        public DbSet<Post> Posts { set; get; }
        public DbSet<Comment> Comments { set; get; }
    }
}