using System.ComponentModel.DataAnnotations;
using JobTracker.Domain.Enums;

namespace JobTracker.Domain.Entities;

public class JobApplication
{
  [Key]
  public int Id { get; set; }

  public int UserId { get; set; }

  public required string CompanyName { get; set; }

  public required string JobTitle { get; set; }

  public ApplicationStatus Status { get; set; }

  public DateTimeOffset AppliedAt { get; set; }

  public string? Notes { get; set; }

  public string? JobPostingUrl { get; set; }

  public User User { get; set; } = null!;
}


