using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using TaskManagementSystem.Interfaces;
using TaskManagementSystem.Models;

namespace TaskManagementSystem.Controllers
{
    [Route("api")]
    [ApiController]
    public class TasksController : ControllerBase
    {
        private readonly ITaskRepository _taskRepository;

        public TasksController(ITaskRepository taskRepository)
        {
            _taskRepository = taskRepository;
        }

        /// <summary>
        /// Get All Tasks
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAllTasks")]
        public async Task<ActionResult<IEnumerable<Tasks>>> GetAllTasks([FromQuery] int? employeeType, [FromQuery] int? userId)
        {
            var tasks = await _taskRepository.GetAllTasksAsync(employeeType, userId);
            return Ok(tasks);
        }

        /// <summary>
        /// Get task by Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetTaskById/{id}")]
        public async Task<ActionResult<Tasks>> GetTaskById(int id)
        {
            var task = await _taskRepository.GetTaskByIdAsync(id);

            if (task == null)
            {
                return NotFound();
            }

            return Ok(task);
        }

        /// <summary>
        /// Create task will be added from API only
        /// </summary>
        /// <param name="task"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("CreateTask")]
        public async Task<ActionResult<Tasks>> CreateTask(Tasks task, [FromForm] IFormFile documents)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var createdTask = await _taskRepository.AddTaskAsync(task, documents);
            if (createdTask != null)
            {
                return CreatedAtAction(nameof(GetTaskById), new { id = createdTask.Id }, createdTask);
            }
            return BadRequest();
        }

        /// <summary>
        /// Update task
        /// </summary>
        /// <param name="task"></param>
        /// <param name="documents"></param>
        /// <returns></returns>
        [HttpPut]
        [Route("UpdateTask")]
        public async Task<IActionResult> UpdateTask([FromForm] UpdateTaskRequest task)
        {
            if (task == null || task.Id <= 0)
            {
                return BadRequest("Invalid task or task Id.");
            }

            await _taskRepository.UpdateTaskAsync(task);
            return Ok("Task updated successfully");
        }

        /// <summary>
        /// Delete task
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete]
        [Route("DeleteTask/{id}")]
        public async Task<IActionResult> DeleteTask(int id)
        {
            await _taskRepository.DeleteTaskAsync(id);
            return Ok("Task deleted successfully");
        }
    }
}
