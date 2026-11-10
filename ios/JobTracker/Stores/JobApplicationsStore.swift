//
//  JobApplicationsStore.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/24/26.
//

import Foundation
import Observation

@MainActor
@Observable
class JobApplicationsStore {
    var applications: [JobApplicationDTO] = []
    var isLoading = false
    var isSaving = false
    var errorMessage: String?

    private let apiService = JobApplicationAPIService()

    func loadJobApplications() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            applications = try await apiService.fetchJobApplications()
        } catch {
            errorMessage = error.localizedDescription
        }

    }

    func createJobApplication(
        request: CreateJobApplicationRequest
    ) async throws {
        isSaving = true
        errorMessage = nil
        defer { isSaving = false }

        let application = try await apiService.createJobApplication(request: request)
        applications.append(application)
    }
    
    func deleteJobApplication(id: Int) async throws {
        isSaving = true
        errorMessage = nil

        defer {
            isSaving = false
        }

        try await apiService.deleteJobApplication(id: id)

        applications.removeAll { application in
            application.id == id
        }
    }
}


