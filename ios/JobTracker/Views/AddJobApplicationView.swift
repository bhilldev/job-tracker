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
    var body: some View {
        ZStack {
            Color("ScreenBackground")
                .ignoresSafeArea()
            VStack(spacing: 12) {
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
            }
            .padding(.horizontal, 16)
        }
    }
}

// Share the same field appearance while keeping spacing between fields in the parent.
private struct ApplicationTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .font(.body)
            .foregroundStyle(Color("PrimaryText"))
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .frame(minHeight: 50)
            .background(Color("CardBackground"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color("SecondaryText").opacity(0.2), lineWidth: 1)
            }
    }
}

#Preview {
    AddJobApplicationView()
}
