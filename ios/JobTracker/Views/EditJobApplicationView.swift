//
//  EditJobApplicationView.swift
//  JobTracker
//

import SwiftUI

struct EditJobApplicationView: View {
    let application: JobApplicationDTO
    let store: JobApplicationsStore

    @Environment(\.dismiss) private var dismiss

    @State private var companyName: String
    @State private var jobTitle: String
    @State private var status: ApplicationStatusDTO
    @State private var errorMessage: String?

    init(application: JobApplicationDTO, store: JobApplicationsStore) {
        self.application = application
        self.store = store

        _companyName = State(initialValue: application.companyName)
        _jobTitle = State(initialValue: application.jobTitle)
        _status = State(initialValue: application.status)
    }

    var body: some View {
        ZStack {
            Color("ScreenBackground")
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Form {
                    Section {
                        TextField("Company", text: $companyName)
                            .foregroundStyle(Color("PrimaryText"))
                        TextField("Role", text: $jobTitle)
                            .foregroundStyle(Color("PrimaryText"))
                    } header: {
                        Text("Application details")
                            .foregroundStyle(Color("SecondaryText"))
                    }
                    .listRowBackground(Color("CardBackground"))

                    Section {
                        ApplicationProgressSlider(
                            status: $status,
                            isEditable: true
                        )
                    } header: {
                        Text("Application status")
                            .foregroundStyle(Color("SecondaryText"))
                    }
                    .listRowBackground(Color.clear)

                    if let errorMessage {
                        Section {
                            Text(errorMessage)
                                .foregroundStyle(.red)
                        }
                        .listRowBackground(Color("CardBackground"))
                    }
                }
                .scrollContentBackground(.hidden)
                .tint(Color("AccentGreen"))

                Button {
                    let request = UpdateJobApplicationRequest(
                        companyName: companyName,
                        jobTitle: jobTitle,
                        status: status,
                        appliedAt: application.appliedAt,
                        notes: application.notes,
                        jobPostingUrl: application.jobPostingUrl
                    )

                    Task {
                        do {
                            try await store.updateJobApplication(
                                id: application.id,
                                request: request
                            )
                            dismiss()
                        } catch {
                            errorMessage = error.localizedDescription
                        }
                    }
                } label: {
                    Text(store.isSaving ? "Saving…" : "Save changes")
                        .frame(maxWidth: .infinity, minHeight: 36)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("AccentGreen"))
                .disabled(companyName.isEmpty || jobTitle.isEmpty || store.isSaving)
                .padding()
            }
        }
        .navigationTitle("Edit application")
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NavigationStack {
        EditJobApplicationView(
            application: JobApplicationDTO(
                id: 1,
                companyName: "Maple Labs",
                jobTitle: "iOS Developer",
                notes: nil,
                status: .applied,
                appliedAt: .now,
                jobPostingUrl: nil
            ),
            store: JobApplicationsStore()
        )
    }
}
