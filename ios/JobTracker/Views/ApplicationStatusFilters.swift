//
//  ApplicationStatusFilters.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/27/26.
//

import SwiftUI

struct ApplicationStatusFilters: View {
    @Binding var selectedStatus: ApplicationStatusDTO?

    private let statuses: [(title: String, status: ApplicationStatusDTO)] = [
        ("Draft", .draft),
        ("Applied", .applied),
        ("Phone screen", .phoneScreen),
        ("Interviewing", .interviewing),
        ("Offer", .offer),
        ("Rejected", .rejected),
        ("Withdrawn", .withdrawn),
        ("Accepted", .accepted)
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                StatusFilterButton(
                    title: "All",
                    isSelected: selectedStatus == nil
                ) {
                    selectedStatus = nil
                }

                ForEach(statuses, id: \.status.rawValue) { item in
                    StatusFilterButton(
                        title: item.title,
                        isSelected: selectedStatus == item.status
                    ) {
                        selectedStatus = item.status
                    }
                }
            }
        }
    }
}
