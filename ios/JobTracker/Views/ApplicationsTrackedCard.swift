//
//  ApplicationsTrackedCard.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/19/26.
//

import SwiftUI

struct ApplicationsTrackedCard: View {
    let numOfApps: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Applications tracked")
                .font(.system(size: 13))

            Text(String(numOfApps))
                .font(.system(size: 46, weight: .semibold))

            Text("Every opportunity, in one place.")
                .font(.system(size: 13))

            Divider()
                .overlay(Color("ScreenBackground").opacity(0.3))
                .padding(.top, 12)

            Button {
                // Navigate to the applications screen
            } label: {
                HStack {
                    Text("View applications")

                    Spacer()

                    Image(systemName: "arrow.up.right")
                }
                .font(.system(size: 13))
                .padding(.top, 5)
                .frame(minHeight: 44)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .foregroundStyle(Color("ScreenBackground"))
        .padding(23)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("AccentGreen"))
        .clipShape(RoundedRectangle(cornerRadius: 23))
    }
}

#Preview {
    ApplicationsTrackedCard(numOfApps: 4)
}
