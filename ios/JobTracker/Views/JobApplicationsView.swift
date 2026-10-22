//
//  JobApplicationsView.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/22/26.
//

import SwiftUI

struct JobApplicationsView: View {
    @State private var searchText = ""
    var body: some View {
        ZStack {
            Color("ScreenBackground")
                .ignoresSafeArea()

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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

#Preview {
    JobApplicationsView()
}
