using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BlogMVCProject.Models
{
    public class UserViewModel
    {
        public int Id { get; set; }

        [StringLength(150)]
        [Required(ErrorMessage = "Full Name is Required")]
        [DisplayName("Full Name")]
        public string FullName { get; set; }

        [StringLength(30)]
        [Required(ErrorMessage = "User Name is Required")]
        [DisplayName("User Name")]
        [Remote("CheckUserName", "Home", ErrorMessage = "User Name is not available")]
        [MinLength(4, ErrorMessage = "User Name must be at least 4 character.")]
        public string UserName { get; set; }

        [StringLength(150)]
        [Required(ErrorMessage = "Email is Required")]
        [Remote("CheckEmail", "Home", ErrorMessage = "Email is not available")]
        public string Email { get; set; }

        [StringLength(30)]
        [Required(ErrorMessage = "Password is Required")]
        [MinLength(8,ErrorMessage = "Password must be at least 8 character.")]
        public string Password { get; set; }
        [StringLength(30)]
        [Required(ErrorMessage = "This field is required")]
        [System.ComponentModel.DataAnnotations.Compare("Password",ErrorMessage = "Password does not match")]
        [DisplayName("Confirm Password")]
        public string ConfirmPassword { get; set; }

        [Required]
        public DateTime CreatedDate { get; set; }

        [Required(ErrorMessage = "Mobile No is Required")]
        [MinLength(11, ErrorMessage = "Mobile must be at least 11 character.")]
        [DisplayName("Mobile No.")]
        public string MobileNo { set; get; }
        [Required(ErrorMessage = "Gender is Required")]
        public string Gender { set; get; }
    }
}