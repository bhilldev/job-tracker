using JobTracker.Domain.Enums;

namespace JobTracker.Application.DTOs.JobApplications;

public class JobApplicationResponse
{
    public int Id { get; set; }
    public string CompanyName { get; set; } = string.Empty;
    public string JobTitle { get; set; } = string.Empty;
    public ApplicationStatus Status { get; set; }
    public DateTimeOffset AppliedAt { get; set; }
    public string? Notes { get; set; }
    public string? JobPostingUrl { get; set; }
}
