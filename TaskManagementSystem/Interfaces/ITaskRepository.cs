using Microsoft.AspNetCore.Mvc;
using TaskManagementSystem.Models;

namespace TaskManagementSystem.Interfaces
{
    public interface ITaskRepository
    {
        Task<IEnumerable<Tasks>> GetAllTasksAsync(int? employeeType, int? userId);
        Task<Tasks> GetTaskByIdAsync(int id);
        Task<Tasks> AddTaskAsync(Tasks task, IFormFile documents);
        Task<UpdateTaskRequest> UpdateTaskAsync(UpdateTaskRequest task);
        Task DeleteTaskAsync(int id);
    }
}
