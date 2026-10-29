//
//  AddJobApplicationView.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/28/26.
//

import SwiftUI

struct AddJobApplicationView: View {
    @State private var companyText = ""
    @State private var jobDescriptionText = ""
    @State private var applicationStatus = ""
    // Preview-only progress state; nothing is saved or sent to the backend.
    @State private var progress = 0.0
    @State private var isProgressEditable = false
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

                Section {
                    Toggle("Allow editing", isOn: $isProgressEditable)
                        .foregroundStyle(Color("PrimaryText"))

                    ApplicationProgressSlider(
                        progress: $progress,
                        isEditable: isProgressEditable
                    )
                    .listRowInsets(EdgeInsets())
                } header: {
                    Text("Application progress")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color("SecondaryText"))
                }
                .listRowBackground(Color("CardBackground"))
                .listRowSeparatorTint(Color("SecondaryText").opacity(0.2))
            }
            .formStyle(.grouped)
            // Reveal the app's background instead of the Form's default background.
            .scrollContentBackground(.hidden)
            .tint(Color("AccentGreen"))
        }
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
    AddJobApplicationView()
        .preferredColorScheme(.dark)
}
