//
//  JobApplicationsCard.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/21/26.
//

import SwiftUI

struct JobApplicationsCard: View {
    // Use one application as input instead of hardcoded company, role, status, and date.
    let application: JobApplicationDTO

    // Scale the mockup's font sizes with the user's preferred text size.
    @ScaledMetric(relativeTo: .subheadline) private var initialsFontSize = 14.0
    @ScaledMetric(relativeTo: .headline) private var companyFontSize = 15.0
    @ScaledMetric(relativeTo: .subheadline) private var roleFontSize = 13.0
    @ScaledMetric(relativeTo: .caption2) private var detailFontSize = 11.0

    // Take the first letters of up to two company-name words; handle empty names too.
    private var companyInitials: String {
        let initials = application.companyName
            .split(whereSeparator: { $0.isWhitespace })
            .prefix(2)
            .compactMap { $0.first }
            .map { String($0) }
            .joined()
            .uppercased()

        return initials.isEmpty ? "?" : initials
    }

    // Match each API status to its display label and named badge colors.
    private var statusStyle: (title: String, textAsset: String, backgroundAsset: String) {
        switch application.status {
        case .draft:
            return ("Draft", "SecondaryText", "ScreenBackground")
        case .applied:
            return ("Applied", "AppliedText", "AppliedBackground")
        case .phoneScreen:
            return ("Phone screen", "InterviewingText", "InterviewingBackground")
        case .interviewing:
            return ("Interviewing", "InterviewingText", "InterviewingBackground")
        case .offer:
            return ("Offer", "OfferText", "OfferBackground")
        case .rejected:
            return ("Rejected", "SecondaryText", "ScreenBackground")
        case .withdrawn:
            return ("Withdrawn", "SecondaryText", "ScreenBackground")
        case .accepted:
            return ("Accepted", "OfferText", "OfferBackground")
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 11) {
            // Keep the initials square beside the top of the company details.
            Text(companyInitials)
                .font(.system(size: initialsFontSize, weight: .semibold))
                .foregroundStyle(Color("SecondaryText"))
                .frame(width: 38, height: 38)
                .background(Color("ScreenBackground"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                Text(application.companyName)
                    .font(.system(size: companyFontSize, weight: .semibold))
                    .foregroundStyle(Color("PrimaryText"))

                Text(application.jobTitle)
                    .font(.system(size: roleFontSize))
                    .foregroundStyle(Color("SecondaryText"))

                // Keep the badge and date on one row, or stack them when text needs more room.
                ViewThatFits(in: .horizontal) {
                    HStack(spacing: 8) {
                        statusBadge
                        Spacer(minLength: 8)
                        applicationDate
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        statusBadge
                        applicationDate
                    }
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        // Internal padding belongs to the card; the parent supplies its outer margins.
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("CardBackground"))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private var statusBadge: some View {
        Text(statusStyle.title)
            .font(.system(size: detailFontSize, weight: .medium))
            .foregroundStyle(Color(statusStyle.textAsset))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(statusStyle.backgroundAsset))
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .fixedSize(horizontal: true, vertical: false)
    }

    private var applicationDate: some View {
        // Format the application's real date using the user's locale.
        Text(application.appliedAt, format: .dateTime.month(.abbreviated).day().year())
            .font(.system(size: detailFontSize))
            .foregroundStyle(Color("SecondaryText"))
            .fixedSize(horizontal: true, vertical: false)
    }
}

#Preview {
    // Show the three badge styles with sample data without requesting anything from the API.
    VStack(spacing: 10) {
        JobApplicationsCard(application: JobApplicationDTO(
            id: 1,
            companyName: "Maple Labs",
            jobTitle: "iOS Developer",
            notes: nil,
            status: .applied,
            appliedAt: .now,
            jobPostingUrl: nil
        ))

        JobApplicationsCard(application: JobApplicationDTO(
            id: 2,
            companyName: "Northstar Software",
            jobTitle: "Software Engineer",
            notes: nil,
            status: .interviewing,
            appliedAt: .now,
            jobPostingUrl: nil
        ))

        JobApplicationsCard(application: JobApplicationDTO(
            id: 3,
            companyName: "Cedar Health",
            jobTitle: "Junior Swift Developer",
            notes: nil,
            status: .offer,
            appliedAt: .now,
            jobPostingUrl: nil
        ))
    }
    .padding()
    .background(Color("ScreenBackground"))
    .preferredColorScheme(.dark)
}
