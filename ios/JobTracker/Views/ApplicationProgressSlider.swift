//
//  ApplicationProgressSlider.swift
//  JobTracker
//

import SwiftUI

struct ApplicationProgressSlider: View {
    @Binding var status: ApplicationStatusDTO
    let isEditable: Bool

    private let stages: [(status: ApplicationStatusDTO, title: String)] = [
        (.draft, "Draft"),
        (.applied, "Applied"),
        (.phoneScreen, "Phone screen"),
        (.interviewing, "Interviewing"),
        (.offer, "Offer"),
        (.accepted, "Accepted"),
        (.rejected, "Rejected"),
        (.withdrawn, "Withdrawn")
    ]

    private var selectedIndex: Int {
        stages.firstIndex { $0.status == status } ?? 0
    }

    private var sliderValue: Binding<Double> {
        Binding(
            get: { Double(selectedIndex) },
            set: { newValue in
                let index = min(max(Int(newValue.rounded()), 0), stages.count - 1)
                status = stages[index].status
            }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(stages[selectedIndex].title)
                    .font(.headline)

                Spacer()

                Image(systemName: isEditable ? "pencil" : "lock")
                    .accessibilityLabel(isEditable ? "Editable" : "Read only")
            }
            .foregroundStyle(Color("PrimaryText"))

            // Whole-number steps snap to the five stages; disabling prevents edits.
            Slider(
                value: sliderValue,
                in: 0...Double(stages.count - 1),
                step: 1
            )
            .tint(Color("AccentGreen"))
            .disabled(!isEditable)
            .accessibilityLabel("Application progress")
            .accessibilityValue(stages[selectedIndex].title)

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
    @Previewable @State var status: ApplicationStatusDTO = .interviewing

    ApplicationProgressSlider(status: $status, isEditable: true)
        .padding()
        .background(Color("ScreenBackground"))
        .preferredColorScheme(.dark)
}
