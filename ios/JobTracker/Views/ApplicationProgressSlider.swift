//
//  ApplicationProgressSlider.swift
//  JobTracker
//

import SwiftUI

struct ApplicationProgressSlider: View {
    // The parent owns this temporary value; the slider only updates its binding.
    @Binding var progress: Double
    let isEditable: Bool

    private let stages = [
        "Applied",
        "Phone screen",
        "Interviewing",
        "Offer",
        "Accepted"
    ]

    private var selectedIndex: Int {
        min(max(Int(progress.rounded()), 0), stages.count - 1)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(stages[selectedIndex])
                    .font(.headline)

                Spacer()

                Image(systemName: isEditable ? "pencil" : "lock")
                    .accessibilityLabel(isEditable ? "Editable" : "Read only")
            }
            .foregroundStyle(Color("PrimaryText"))

            // Whole-number steps snap to the five stages; disabling prevents edits.
            Slider(
                value: $progress,
                in: 0...Double(stages.count - 1),
                step: 1
            )
            .tint(Color("AccentGreen"))
            .disabled(!isEditable)
            .accessibilityLabel("Application progress")
            .accessibilityValue(stages[selectedIndex])

            HStack {
                Text("Applied")
                Spacer()
                Text("Accepted")
            }
            .font(.caption)
            .foregroundStyle(Color("SecondaryText"))
        }
        .padding()
        .background(Color("CardBackground"))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    @Previewable @State var progress = 2.0

    ApplicationProgressSlider(progress: $progress, isEditable: true)
        .padding()
        .background(Color("ScreenBackground"))
        .preferredColorScheme(.dark)
}
