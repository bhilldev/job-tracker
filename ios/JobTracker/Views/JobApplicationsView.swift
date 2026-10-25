//
//  JobApplicationsView.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/22/26.
//

import SwiftUI

struct JobApplicationsView: View {
    
    @State private var searchText = ""
    let store: JobApplicationsStore
    var body: some View {
        ZStack {
            Color("ScreenBackground")
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Opportunities".uppercased())
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(
                            Color("SecondaryText")
                        )
                    Text("Applications")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(
                            Color("PrimaryText")
                        )
                    Text("Keep your next move in sight.")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(
                            Color("SecondaryText")
                        )
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color("SecondaryText"))

                        TextField(
                            "",
                            text: $searchText,
                            prompt: Text("Company or role")
                                .foregroundStyle(Color("SecondaryText"))
                        )
                        .foregroundStyle(Color("PrimaryText"))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    }
                    .font(.system(size: 16))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color("CardBackground"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 14)
                    ForEach(store.applications) { application in
                        JobApplicationsCard(application: application)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
    }
}

#Preview {
    let store = JobApplicationsStore()

    // Sample data stays in the preview; the running app still uses its API-backed store.
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
        ),
        JobApplicationDTO(
            id: 4,
            companyName: "Orbit Studio",
            jobTitle: "Mobile Developer",
            notes: nil,
            status: .phoneScreen,
            appliedAt: .now,
            jobPostingUrl: nil
        )
    ]

    return JobApplicationsView(store: store)
        .preferredColorScheme(.dark)
}
