//
//  AddJobApplicationView.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/28/26.
//

import SwiftUI

struct AddJobApplicationView: View {
    let store: JobApplicationsStore
    @Environment(\.dismiss) private var dismiss

    @State private var companyText = ""
    @State private var jobDescriptionText = ""
    @State private var errorMessage: String?

    private var trimmedCompany: String {
        companyText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedRole: String {
        jobDescriptionText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        ZStack {
            Color("ScreenBackground")
                .ignoresSafeArea()
            Form {
                Section {
                    TextField(
                        "",
                        text: $companyText,
                        prompt: Text("Company")
                            .foregroundStyle(Color("SecondaryText"))
                    )
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .modifier(ApplicationTextFieldModifier())
                    TextField(
                        "",
                        text: $jobDescriptionText,
                        prompt: Text("Role")
                            .foregroundStyle(Color("SecondaryText"))
                    )
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .modifier(ApplicationTextFieldModifier())

                } header: {
                    Text("Application details")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color("SecondaryText"))
                }
                // The section supplies one grouped surface around its fields.
                .listRowBackground(Color("CardBackground"))
                .listRowSeparatorTint(Color("SecondaryText").opacity(0.2))
                .listRowInsets(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
                .disabled(store.isSaving)

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                    .listRowBackground(Color("CardBackground"))
                }

                Section {
                    Button {
                        let request = CreateJobApplicationRequest(
                            companyName: trimmedCompany,
                            jobTitle: trimmedRole,
                            status: .applied,
                            appliedAt: nil,
                            notes: nil,
                            jobPostingUrl: nil
                        )

                        Task {
                            errorMessage = nil

                            do {
                                try await store.createJobApplication(request: request)
                                dismiss()
                            } catch {
                                errorMessage = error.localizedDescription
                            }
                        }
                    } label: {
                        HStack {
                            if store.isSaving {
                                ProgressView()
                            }
                            Text(store.isSaving ? "Saving…" : "Save application")
                        }
                        .frame(maxWidth: .infinity, minHeight: 36)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(trimmedCompany.isEmpty || trimmedRole.isEmpty || store.isSaving)
                }
                .listRowBackground(Color("CardBackground"))
            }
            .formStyle(.grouped)
            // Reveal the app's background instead of the Form's default background.
            .scrollContentBackground(.hidden)
            .tint(Color("AccentGreen"))
        }
        .navigationTitle("Add application")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
                    .disabled(store.isSaving)
            }
        }
        // Keep the form available until the server confirms the save or returns an error.
        .interactiveDismissDisabled(store.isSaving)
    }
}

// Form rows now supply padding and backgrounds, so fields only need text styling.
private struct ApplicationTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .font(.body)
            .foregroundStyle(Color("PrimaryText"))
            .frame(minHeight: 24)
    }
}

#Preview {
    NavigationStack {
        AddJobApplicationView(store: JobApplicationsStore())
    }
    .preferredColorScheme(.dark)
}
