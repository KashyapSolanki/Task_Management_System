using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TaskManagementSystem.Interfaces;
using TaskManagementSystem.Models;
using TaskManagementSystem.Repositories;

namespace TaskManagementSystem.Controllers
{
    [Route("api")]
    [ApiController]
    public class ReportsController : ControllerBase
    {
        private readonly IReports _reports;

        public ReportsController(IReports reports)
        {
            _reports = reports;
        }

        [HttpPost]
        [Route("GetTeamTaskReport")]
        public async Task<IActionResult> GetTeamTaskReport([FromBody] ReportRequest request)
        {
            if (request == null || request.StartDate == default || request.EndDate == default)
            {
                return BadRequest("Invalid report request.");
            }

            var taskReports = await _reports.GetTeamTaskReportAsync(request.StartDate, request.EndDate);
            return Ok(taskReports);
        }
    }
}
