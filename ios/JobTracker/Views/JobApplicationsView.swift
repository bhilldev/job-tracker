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
    
    private var interviewingCount: Int {
        applications.filter { $0.status == .interviewing }.count
    }

    private var offerCount: Int {
        applications.filter { $0.status == .offer }.count
    }

    var body: some View {
        ZStack {
            Color("ScreenBackground")
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading){
                        Text("Your next chapter".uppercased())
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(
                                Color("PrimaryText")
                            )
                        Text("Job Tracker")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(
                                Color("PrimaryText")
                            )
                        Text("A little clarity in your job search")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(
                                Color("PrimaryText")
                            )
                        
                    }
                    .padding(.vertical)
                    
                    
                    ApplicationsTrackedCard(numOfApps: applications.count)

                    HStack(spacing: 12) {
                        StatusSummaryCard(
                            count: interviewingCount,
                            title: "Interviewing",
                            icon: "bubble.left.and.bubble.right"
                        )

                        StatusSummaryCard(
                            count: offerCount,
                            title: "Offer",
                            icon: "sparkles"
                        )
                    }
                    Text("Recently applied")
                        .font(.headline)
                        .foregroundStyle(Color("PrimaryText"))

                    ForEach(applications) { application in
                        JobApplicationsCard(application: application)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
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
