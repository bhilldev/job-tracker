//
//  JobApplication.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/13/26.
//

import Foundation
import SwiftData

@Model
class JobApplication {
    // Properties inside JobApplication
    var id: UUID = UUID()
    var companyName: String = ""
    var jobTitle: String = ""
    var notes: String = ""
    var status: ApplicationStatus = ApplicationStatus.applied
    var appliedAt: Date? = nil
    var createdAt: Date = Date()
    
    init(id: UUID, companyName: String, jobTitle: String, notes: String, status: ApplicationStatus, appliedAt: Date? = nil, createdAt: Date) {
        self.id = id
        self.companyName = companyName
        self.jobTitle = jobTitle
        self.notes = notes
        self.status = status
        self.appliedAt = appliedAt
        self.createdAt = createdAt
    }
}
