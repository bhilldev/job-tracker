using JobTracker.Application.DTOs.JobApplications;
using JobTracker.Application.Services;
using Microsoft.AspNetCore.Mvc;

namespace JobTracker.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class JobApplicationsController : ControllerBase
{
  private readonly JobApplicationService _service;
  private readonly ILogger<JobApplicationsController> _logger;

  public JobApplicationsController(
      JobApplicationService service,
      ILogger<JobApplicationsController> logger)
  {
    _service = service;
    _logger = logger;
  }

  [HttpPost]
  public async Task<ActionResult<JobApplicationResponse>> CreateJobApplication(
      CreateJobApplicationRequest request)
  {
    // Temporary development user until authentication supplies the user ID.
    var userId = 1;
    var result = await _service.CreateAsync(userId, request);

    return CreatedAtAction(
        nameof(GetJobApplicationById),
        new { id = result.Id },
        result);
  }

  [HttpGet]
  public async Task<ActionResult<List<JobApplicationResponse>>> GetJobApplications()
  {
    // Temporary development user until authentication supplies the user ID.
    var userId = 1;
    var applications = await _service.GetAllAsync(userId);

    return Ok(applications);
  }

  [HttpGet("{id:int}")]
  public async Task<ActionResult<JobApplicationResponse>> GetJobApplicationById(int id)
  {
    // Temporary development user until authentication supplies the user ID.
    var userId = 1;
    var result = await _service.GetByIdAsync(id, userId);

    if (result == null)
    {
      _logger.LogWarning("Job application with ID {Id} was not found.", id);

      return NotFound();
    }

    return Ok(result);
  }

  [HttpPut("{id:int}")]
  public async Task<ActionResult<JobApplicationResponse>> UpdateJobApplication(
      int id,
      UpdateJobApplicationRequest request)
  {
    // Temporary development user; match the IDs used by create and delete.
    var userId = 1;

    var result = await _service.UpdateAsync(id, userId, request);

    if (result == null)
    {
      return NotFound();
    }

    return Ok(result);
  }

  [HttpDelete("{id:int}")]
  public async Task<IActionResult> DeleteJobApplication(int id)
  {
    // Temporary development user; match the ID used when creating.
    var userId = 1;

    var deleted = await _service.DeleteAsync(id, userId);

    if (!deleted)
    {
      return NotFound();
    }

    return NoContent();
  }
}
