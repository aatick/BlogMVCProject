using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace BlogMVCProject.Models
{
    public class User
    {
        public int Id { get; set; }

        [StringLength(150)]
        [Required(ErrorMessage = "Full Name is Required")]
        public string FullName { get; set; }

        [StringLength(30)]
        [Required(ErrorMessage = "User Name is Required")]
        [Remote("CheckUserName","Home",ErrorMessage = "User Name is not available")]
        public string UserName { get; set; }

        [StringLength(150)]
        [Required(ErrorMessage = "Email is Required")]
        [Remote("CheckEmail", "Home", ErrorMessage = "Email is not available")]
        public string Email { get; set; }

        [StringLength(30)]
        [Required(ErrorMessage = "Password is Required")]
        public string Password { get; set; }

        [Required]
        public DateTime CreatedDate { get; set; }
        [Required(ErrorMessage = "Mobile No is Required")]
        public string MobileNo { set; get; }
        [Required(ErrorMessage = "Gender is Required")]
        public string Gender { set; get; }

        public ICollection<Post> Posts { get; set; }
        public ICollection<Comment> Comments { get; set; }
    }
}