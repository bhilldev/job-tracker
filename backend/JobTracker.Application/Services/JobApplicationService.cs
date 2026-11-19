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

    public async Task<JobApplicationResponse> CreateAsync(
        int userId,
        CreateJobApplicationRequest request)
    {
        var entity = new JobApplication
        {
            UserId = userId,
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

    public async Task<JobApplicationResponse?> GetByIdAsync(int id, int userId)
    {
        var entity = await _context.JobApplications
            .AsNoTracking()
            .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);

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

    public async Task<List<JobApplicationResponse>> GetAllAsync(int userId)
    {
        return await _context.JobApplications
            .AsNoTracking()
            .Where(application => application.UserId == userId)
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

    public async Task<JobApplicationResponse?> UpdateAsync(
        int id,
        int userId,
        UpdateJobApplicationRequest request)
    {
        var application = await _context.JobApplications
            .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);

        if (application == null)
        {
            return null;
        }

        application.CompanyName = request.CompanyName;
        application.JobTitle = request.JobTitle;
        application.Status = request.Status;
        application.AppliedAt = request.AppliedAt != default
            ? request.AppliedAt.ToUniversalTime()
            : application.AppliedAt;
        application.Notes = request.Notes;
        application.JobPostingUrl = request.JobPostingUrl;

        await _context.SaveChangesAsync();

        return new JobApplicationResponse
        {
            Id = application.Id,
            CompanyName = application.CompanyName,
            JobTitle = application.JobTitle,
            Status = application.Status,
            AppliedAt = application.AppliedAt,
            Notes = application.Notes,
            JobPostingUrl = application.JobPostingUrl
        };
    }

    public async Task<bool> DeleteAsync(int id, int userId)
    {
        var application = await _context.JobApplications
            .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);

        if (application == null)
        {
            return false;
        }

        _context.JobApplications.Remove(application);
        await _context.SaveChangesAsync();

        return true;
    }
}
