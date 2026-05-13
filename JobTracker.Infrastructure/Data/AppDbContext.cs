using Microsoft.EntityFrameworkCore;
using JobTracker.Domain.Entities;

namespace JobTracker.Infrastructure.Data;

public class AppDbContext : DbContext
{
  public AppDbContext(DbContextOptions<AppDbContext> options)
    : base(options)
  {}
  public DbSet<User> Users { get; set; }
  public DbSet<JobApplication> JobApplications { get; set; }

  protected override void OnModelCreating(ModelBuilder modelBuilder)
  {
    base.OnModelCreating(modelBuilder);
   
    modelBuilder.Entity<User>(entity => 
    {
      entity.HasKey(e => e.Id);
      entity.HasIndex(e => e.Email).IsUnique();
      entity.Property(e => e.Email).IsRequired().HasMaxLength(255);
      entity.Property(e => e.FirstName).IsRequired().HasMaxLength(100);
      entity.Property(e => e.LastName).IsRequired().HasMaxLength(100);
    });
      
    modelBuilder.Entity<JobApplication>(entity => 
    {
      entity.HasKey(e => e.Id);
      entity.Property(e => e.CompanyName).IsRequired().HasMaxLength(255);
      entity.Property(e => e.JobTitle).IsRequired().HasMaxLength(100);
      entity.Property(e => e.Status)
      .HasConversion<string>();
      entity.HasOne(e => e.User)
          .WithMany(e => e.JobApplications)
          .HasForeignKey(e => e.UserId)
          .OnDelete(DeleteBehavior.Cascade);
    });
  } 
}
