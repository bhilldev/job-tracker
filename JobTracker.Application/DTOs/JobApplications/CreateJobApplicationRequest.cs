using System.ComponentModel.DataAnnotations;
using JobTracker.Domain.Enums;

namespace JobTracker.Application.DTOs.JobApplications;

public class CreateJobApplicationRequest
{
    [Required]
    [StringLength(255, MinimumLength = 1)]
    public string CompanyName { get; set; } = string.Empty;

    [Required]
    [StringLength(100, MinimumLength = 1)]
    public string JobTitle { get; set; } = string.Empty;

    [Required]
    public ApplicationStatus Status { get; set; }

    // Optional: client can send it, but usually server overrides it
    public DateTimeOffset AppliedAt { get; set; }

    [StringLength(2000)]
    public string? Notes { get; set; }

    [Url]
    [StringLength(500)]
    public string? JobPostingUrl { get; set; }
}
