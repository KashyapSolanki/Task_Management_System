using Microsoft.EntityFrameworkCore;
using TaskManagementSystem.Data;
using TaskManagementSystem.Interfaces;
using TaskManagementSystem.Models;

namespace TaskManagementSystem.Repositories
{
    public class ReportRepository : IReports
    {
        private readonly TaskManagementContext _context;

        public ReportRepository(TaskManagementContext context)
        {
            _context = context;
        }

        public async Task<List<TaskReport>> GetTeamTaskReportAsync(DateTime startDate, DateTime endDate)
        {
            return await (from task in _context.Tasks
                          join employee in _context.Employees
                          on task.TeamLeaderId equals employee.Id
                          where task.DueDate >= startDate && task.DueDate <= endDate
                          group task by new { task.TeamLeaderId, TeamLeaderName = employee.FirstName + " " + employee.LastName } into g
                          select new TaskReport
                          {
                              TeamLeaderId = g.Key.TeamLeaderId,
                              TeamLeaderName = g.Key.TeamLeaderName,
                              TotalTasks = g.Count(),
                              CompletedTasks = g.Count(t => t.IsCompleted)
                          })
                     .ToListAsync();
        }
    }
}
