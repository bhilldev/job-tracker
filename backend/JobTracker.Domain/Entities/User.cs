using System.ComponentModel.DataAnnotations;
using JobTracker.Domain.Entities;

namespace JobTracker.Domain.Entities;

public class User
{
  [Key]
  public int Id { get; set; }

  public required string Email { get; set; }

  public byte[] PasswordHash { get; set; } = Array.Empty<byte>();

  public byte[] PasswordSalt { get; set; } = Array.Empty<byte>();

  public required string FirstName { get; set; }

  public required string LastName { get; set; }

  public ICollection<JobApplication> JobApplications { get; set; } = new List<JobApplication>();
}
