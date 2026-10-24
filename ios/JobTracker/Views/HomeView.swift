//
//  HomeView.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/15/26.
//

import SwiftUI

struct HomeView: View {
    var previewApplications: [JobApplicationDTO]? = nil

    let store: JobApplicationsStore
    
    private var interviewingCount: Int {
        store.applications.filter { $0.status == .interviewing }.count
    }

    private var offerCount: Int {
        store.applications.filter { $0.status == .offer }.count
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
                                Color("SecondaryText")
                            )
                        Text("Job Tracker")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(
                                Color("PrimaryText")
                            )
                        Text("A little clarity in your job search")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(
                                Color("SecondaryText")
                            )
                        
                    }
                    .padding(.vertical)
                    
                    
                    ApplicationsTrackedCard(numOfApps: store.applications.count)

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

                    ForEach(store.applications) { application in
                        JobApplicationsCard(application: application)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}
#Preview {
    let store = JobApplicationsStore()

    store.applications = [
        JobApplicationDTO(
            id: 1,
            companyName: "Maple Labs",
            jobTitle: "iOS Developer",
            notes: nil,
            status: .applied,
            appliedAt: .now,
            jobPostingUrl: nil
        ),
        JobApplicationDTO(
            id: 2,
            companyName: "Northstar Software",
            jobTitle: "Software Engineer",
            notes: nil,
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
    ]

    return HomeView(store: store)
}
