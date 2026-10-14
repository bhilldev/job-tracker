//
//  JobApplicationDTO.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/14/26.
//
import Foundation

struct JobApplicationDTO: Decodable, Identifiable {
    let id: Int
    let companyName: String
    let jobTitle: String
    let notes: String?
    let status: ApplicationStatusDTO
    let appliedAt: Date
    let jobPostingUrl: String?
}

enum ApplicationStatusDTO: Int, Decodable {
    case draft = 0
    case applied = 1
    case phoneScreen = 2
    case interviewing = 3
    case offer = 4
    case rejected = 5
    case withdrawn = 6
    case accepted = 7
}
