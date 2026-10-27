//
//  StatusFilterButton.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/27/26.
//

import SwiftUI

struct StatusFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(
                    Color(isSelected ? "ScreenBackground" : "SecondaryText")
                )
                .padding(.horizontal, 12)
                .frame(minHeight: 44)
                .background(
                    Color(isSelected ? "AccentGreen" : "CardBackground")
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}
