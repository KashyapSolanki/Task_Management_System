using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;
using System.Reflection.Metadata;
using System.Text.Json.Serialization;

namespace TaskManagementSystem.Models
{
    public class Tasks
    {
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        public string Title { get; set; }

        public string Description { get; set; }

        [Required]
        public DateTime DueDate { get; set; }

        public bool IsCompleted { get; set; }
        
        public string? Notes { get; set; }

        [JsonIgnore]
        public string? FileName { get; set; }

        [Required]
        public int EmployeeId { get; set; }

        [Required]
        public int TeamLeaderId { get; set; }
    }
}
