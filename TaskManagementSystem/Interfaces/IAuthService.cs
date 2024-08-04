using TaskManagementSystem.Models;

namespace TaskManagementSystem.Interfaces
{
    public interface IAuthService
    {
        Task<Employee> AuthenticateAsync(string email, string password);
    }
}
