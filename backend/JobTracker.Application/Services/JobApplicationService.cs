using JobTracker.Application.DTOs.JobApplications;
using JobTracker.Domain.Entities;
using JobTracker.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace JobTracker.Application.Services;

public class JobApplicationService
{
    private readonly AppDbContext _context;

    public JobApplicationService(AppDbContext context)
    {
        _context = context;
    }

    public async Task<JobApplicationResponse> CreateAsync(CreateJobApplicationRequest request)
    {
        var entity = new JobApplication
        {
            CompanyName = request.CompanyName,
            JobTitle = request.JobTitle,
            Status = request.Status,
            AppliedAt = request.AppliedAt != default
                ? request.AppliedAt.ToUniversalTime()
                : DateTimeOffset.UtcNow,
            Notes = request.Notes,
            JobPostingUrl = request.JobPostingUrl
        };

        _context.JobApplications.Add(entity);
        await _context.SaveChangesAsync();

        return new JobApplicationResponse
        {
            Id = entity.Id,
            CompanyName = entity.CompanyName,
            JobTitle = entity.JobTitle,
            Status = entity.Status,
            AppliedAt = entity.AppliedAt,
            Notes = entity.Notes,
            JobPostingUrl = entity.JobPostingUrl
        };
    }

    public async Task<JobApplicationResponse?> GetByIdAsync(int id)
    {
        var entity = await _context.JobApplications
            .AsNoTracking()
            .FirstOrDefaultAsync(x => x.Id == id);

        if (entity == null)
            return null;

        return new JobApplicationResponse
        {
            Id = entity.Id,
            CompanyName = entity.CompanyName,
            JobTitle = entity.JobTitle,
            Status = entity.Status,
            AppliedAt = entity.AppliedAt,
            Notes = entity.Notes,
            JobPostingUrl = entity.JobPostingUrl
        };
    }

    public async Task<List<JobApplicationResponse>> GetAllAsync()
    {
        return await _context.JobApplications
            .AsNoTracking()
            .OrderByDescending(application => application.AppliedAt)
            .ThenByDescending(application => application.Id)
            .Select(application => new JobApplicationResponse
            {
                Id = application.Id,
                CompanyName = application.CompanyName,
                JobTitle = application.JobTitle,
                Status = application.Status,
                AppliedAt = application.AppliedAt,
                Notes = application.Notes,
                JobPostingUrl = application.JobPostingUrl
            })
            .ToListAsync();
    }
}
