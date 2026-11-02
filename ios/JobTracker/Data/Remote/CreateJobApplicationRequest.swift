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

struct JobApplicationService {
    func createJobApplication(
        request: CreateJobApplicationRequest
    ) async throws -> JobApplicationDTO {

        let url = URL(string: "http://localhost:5000/api/jobapplications")!
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "POST"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        urlRequest.httpBody = try encoder.encode(request)

        let (data, response) = try await URLSession.shared.data(
            for: urlRequest
        )

        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(
            JobApplicationDTO.self,
            from: data
        )
    }
}
