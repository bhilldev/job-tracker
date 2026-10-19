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
        ZStack {
            Color("ScreenBackground")
                .ignoresSafeArea()
            VStack(alignment: .leading) {
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
                .padding()
                
                ApplicationsTrackedCard(numOfApps: applications.count)
                    .padding(.horizontal)
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
