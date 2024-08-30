using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TaskManagementSystem.Interfaces;
using TaskManagementSystem.Models;

namespace TaskManagementSystem.Controllers
{
    [Route("api")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            var emp = await _authService.AuthenticateAsync(request.Email, request.Password);
            if (emp == null)
            {
                return Unauthorized();
            }

            return Ok(new { UserType = emp.EmpoyeeType, UserId = emp.Id, FullName = emp.FirstName + " " + emp.LastName });
        }
    }
}
