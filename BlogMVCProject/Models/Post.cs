using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BlogMVCProject.Models
{
    public class Post
    {
        public int Id { get; set; }

        [StringLength(300)]
        [Required(ErrorMessage = "Title is Required")]
        public string Title { get; set; }

        [Required(ErrorMessage = "Content is Required")]
        public string Content { get; set; }

        [Required]
        public DateTime PostedDate { get; set; }

        [Required]
        public int UserId { get; set; }

        [Required]
        public bool IsPublished { get; set; }

        [Required]
        public bool IsDeleted { get; set; }

        [Required]
        public int NoOfView { get; set; }

        public User User { get; set; }
        public ICollection<Comment> Comments { get; set; }
    }
}