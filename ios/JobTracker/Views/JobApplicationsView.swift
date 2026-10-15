//
//  SwiftUIView.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/15/26.
//

import SwiftUI

struct JobApplicationsView: View {
    var previewApplications: [JobApplicationDTO]? = nil

    @State private var applications: [JobApplicationDTO] = []
    @State private var errorMessage: String?

    var body: some View {
        List(applications) { application in
            VStack(alignment: .leading) {
                Text(application.companyName)
                Text(application.jobTitle)
            }
        }
        .overlay {
            if let errorMessage {
                Text(errorMessage)
            }
        }
        .task {
            if let previewApplications {
                applications = previewApplications
                return
            }

            do {
                applications = try await JobApplicationAPIService()
                    .fetchJobApplications()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
#Preview {
    NavigationStack {
        JobApplicationsView(previewApplications: [
            JobApplicationDTO(
                id: 1,
                companyName: "Maple Labs",
                jobTitle: "iOS Developer",
                notes: "Applied through the company website.",
                status: .applied,
                appliedAt: .now,
                jobPostingUrl: nil
            ),
            JobApplicationDTO(
                id: 2,
                companyName: "Northstar Software",
                jobTitle: "Software Engineer",
                notes: "Interview scheduled for next week.",
                status: .interviewing,
                appliedAt: .now,
                jobPostingUrl: nil
            ),
            JobApplicationDTO(
                id: 3,
                companyName: "Cedar Health",
                jobTitle: "Junior Swift Developer",
                notes: nil,
                status: .offer,
                appliedAt: .now,
                jobPostingUrl: nil
            )
        ])
    }
}
