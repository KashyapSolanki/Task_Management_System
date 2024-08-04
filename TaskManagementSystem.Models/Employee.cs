using System.ComponentModel.DataAnnotations;

namespace TaskManagementSystem.Models
{
    public class Employee
    {
        public int Id { get; set; }

        [Required]
        [StringLength(50)]
        public string FirstName { get; set; }

        [Required]
        [StringLength(50)]
        public string LastName { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }

        public int? EmpoyeeType { get; set; } // e.g., "Employee", "Manager", "Admin"

        public bool? IsActive { get; set; }
        
        public bool? IsDeleted { get; set; }

        //public List<Tasks>? Tasks { get; set; } = new List<Tasks>();
    }
}
