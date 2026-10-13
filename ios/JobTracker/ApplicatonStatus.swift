//
//  ApplicatonStatus.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/13/26.
//

import Foundation

enum ApplicationStatus: String, Codable {
    case applied = "Applied"
    case interviewing = "Interviewing"
    case rejected = "Rejected"
}
