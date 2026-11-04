//
//  CreateJobApplicationRequest.swift
//  JobTracker
//
//  Created by Brandon Hill on 11/2/26.
//

import Foundation

struct CreateJobApplicationRequest: Encodable {
    let companyName: String
    let jobTitle: String
    let status: ApplicationStatusDTO
    let appliedAt: Date?
    let notes: String?
    let jobPostingUrl: String?
}
