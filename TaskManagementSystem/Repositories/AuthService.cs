using Microsoft.EntityFrameworkCore;
using TaskManagementSystem.Data;
using TaskManagementSystem.Interfaces;
using TaskManagementSystem.Models;

namespace TaskManagementSystem.Repositories
{
    public class AuthService : IAuthService
    {
        private readonly TaskManagementContext _context;

        public AuthService(TaskManagementContext context)
        {
            _context = context;
        }

        public async Task<Employee> AuthenticateAsync(string email, string password)
        {
            return await _context.Employees.FirstOrDefaultAsync(u => u.Email == email && u.Password == password);
        }
    }
}