using System;
using System.ComponentModel.DataAnnotations;

namespace BlogMVCProject.Models
{
    public class Comment
    {
        public int Id { get; set; }
        [Required]
        public string Content { get; set; }
        [Required]
        public DateTime CommentDate { get; set; }
        [Required]
        public int PostId { get; set; }
        [Required]
        public int UserId { get; set; }
        [Required]
        public bool IsDeleted { get; set; }

        public Post Post { get; set; }
        public User User { get; set; }
    }
}