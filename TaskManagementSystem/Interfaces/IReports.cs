using TaskManagementSystem.Models;

namespace TaskManagementSystem.Interfaces
{
    public interface IReports
    {
        Task<List<TaskReport>> GetTeamTaskReportAsync(DateTime startDate, DateTime endDate);
    }
}
