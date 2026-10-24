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
}


