//
//  StatusSummaryCard.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/20/26.
//

import SwiftUI

struct StatusSummaryCard: View {
    let count: Int
    let title: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 19))
                .foregroundStyle(Color("AccentGreen"))

            Text(String(count))
                .font(.system(size: 27, weight: .semibold))
                .foregroundStyle(Color("PrimaryText"))

            Text(title)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
        }
        .padding(17)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(red: 34 / 255.0, green: 37 / 255.0, blue: 42 / 255.0)
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    HStack(spacing: 12) {
        StatusSummaryCard(
            count: 2,
            title: "Interviewing",
            icon: "bubble.left.and.bubble.right"
        )

        StatusSummaryCard(
            count: 1,
            title: "Offer",
            icon: "sparkles"
        )
    }
    .padding()
    .background(Color("ScreenBackground"))
    .preferredColorScheme(.dark)
}
