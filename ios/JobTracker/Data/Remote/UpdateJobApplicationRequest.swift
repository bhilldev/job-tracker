//
//  UpdateJobApplicationRequest.swift
//  JobTracker
//

import Foundation

struct UpdateJobApplicationRequest: Encodable {
    let companyName: String
    let jobTitle: String
    let status: ApplicationStatusDTO
    let appliedAt: Date
    let notes: String?
    let jobPostingUrl: String?
}
