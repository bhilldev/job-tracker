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
        var result = await _service.CreateAsync(request);

        return CreatedAtAction(
            nameof(GetJobApplicationById),
            new { id = result.Id },
            result);
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<JobApplicationResponse>> GetJobApplicationById(int id)
    {
        var result = await _service.GetByIdAsync(id);

        if (result == null)
        {
            _logger.LogWarning("Job application with ID {Id} was not found.", id);

            return NotFound();
        }

        return Ok(result);
    }
}
