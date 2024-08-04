using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace TaskManagementSystem.Models
{
    public class UpdateTaskRequest
    {
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        public string Title { get; set; }

        public string Description { get; set; }

        [Required]
        public string DueDate { get; set; }

        public bool IsCompleted { get; set; }

        public string? Notes { get; set; }

        [JsonIgnore]
        public string? FileName { get; set; }

        [Required]
        public int EmployeeId { get; set; }

        [Required]
        public int TeamLeaderId { get; set; }

        public IFormFile? documents { get; set; }
    }
}
