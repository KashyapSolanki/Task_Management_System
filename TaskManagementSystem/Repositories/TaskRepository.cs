using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TaskManagementSystem.Data;
using TaskManagementSystem.Interfaces;
using TaskManagementSystem.Models;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace TaskManagementSystem.Repositories
{
    public class TaskRepository : ITaskRepository
    {
        private readonly TaskManagementContext _context;

        public TaskRepository(TaskManagementContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Tasks>> GetAllTasksAsync(int? employeeType, int? userId)
        {
            IQueryable<Tasks> query = _context.Tasks;

            if (employeeType == 1) // Employee
            {
                if (userId.HasValue)
                {
                    query = query.Where(t => t.EmployeeId == userId.Value);
                }
            }
            else if (employeeType == 2) // Team Leader
            {
                if (userId.HasValue)
                {
                    query = query.Where(t => t.TeamLeaderId == userId.Value);
                }
            }
            return await query.ToListAsync();
        }

        public async Task<Tasks> GetTaskByIdAsync(int id)
        {
            return await _context.Tasks
                .FirstOrDefaultAsync(t => t.Id == id);
        }

        public async Task<Tasks> AddTaskAsync(Tasks task, IFormFile documents)
        {
            using (var transaction = await _context.Database.BeginTransactionAsync())
            {
                try
                {
                    _context.Tasks.Add(task);

                    if (documents != null)
                    {
                        // Define the file path, including TaskId as a subdirectory
                        var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Files", task.Id.ToString());
                        var fileName = Path.GetFileName(documents.FileName);
                        var filePath = Path.Combine(uploadsFolder, fileName);

                        // Ensure the directory exists
                        if (!Directory.Exists(uploadsFolder))
                        {
                            Directory.CreateDirectory(uploadsFolder);
                        }

                        // Save the file
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            await documents.CopyToAsync(stream);
                        }
                    }

                    await _context.SaveChangesAsync();
                    await transaction.CommitAsync();
                    return task;
                }
                catch (Exception ex)
                {
                    await transaction.RollbackAsync();
                    return null;
                }
            }
        }

        public async Task<UpdateTaskRequest> UpdateTaskAsync(UpdateTaskRequest task)
        {
            // Ensure that the provided task is not null and has a valid Id
            if (task == null || task.Id <= 0)
            {
                throw new ArgumentException("Invalid task or task Id.");
            }

            using (var transaction = await _context.Database.BeginTransactionAsync())
            {
                try
                {
                    // Check if the record with the provided Id exists
                    var existingTask = await _context.Tasks.FindAsync(task.Id);

                    if (existingTask == null)
                    {
                        return null;
                    }

                    // Map UpdateTaskRequest to Tasks entity
                    existingTask.Title = task.Title;
                    existingTask.Description = task.Description;
                    existingTask.DueDate = DateTime.Parse(task.DueDate); // Convert DueDate string to DateTime
                    existingTask.IsCompleted = task.IsCompleted;
                    existingTask.Notes = task.Notes;
                    existingTask.EmployeeId = task.EmployeeId;
                    existingTask.TeamLeaderId = task.TeamLeaderId;

                    if (task.documents != null)
                    {
                        // Define the file path, including TaskId as a subdirectory
                        var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Files", task.Id.ToString());
                        var fileName = Path.GetFileName(task.documents.FileName);
                        var filePath = Path.Combine(uploadsFolder, fileName);

                        // Ensure the directory exists
                        if (!Directory.Exists(uploadsFolder))
                        {
                            Directory.CreateDirectory(uploadsFolder);
                        }

                        // Save the file
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            await task.documents.CopyToAsync(stream);
                        }

                        // Update the FileName property if needed
                        existingTask.FileName = fileName;
                    }

                    await _context.SaveChangesAsync();
                    await transaction.CommitAsync();
                    return task;
                }
                catch (Exception ex)
                {
                    await transaction.RollbackAsync();
                    return null;
                }
            }
        }

        public async Task DeleteTaskAsync(int id)
        {
            using (var transaction = await _context.Database.BeginTransactionAsync())
            {
                try
                {
                    var task = await _context.Tasks.FindAsync(id);
                    _context.Tasks.Remove(task);
                    await _context.SaveChangesAsync();
                    await transaction.CommitAsync();
                }
                catch (Exception ex)
                {
                    await transaction.RollbackAsync();
                }
            }
        }
    }
}
