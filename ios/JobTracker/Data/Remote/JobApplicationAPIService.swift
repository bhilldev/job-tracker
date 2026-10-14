//
//  JobApplicationAPIService.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/14/26.
//
import Foundation

enum JobAPIError: Error {
    case invalidResponse
    case httpError(statusCode: Int)
}

struct JobApplicationAPIService {
    func fetchJobApplications() async throws -> [JobApplicationDTO] {
        let url = URL(string: "http://localhost:5226/api/JobApplications")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw JobAPIError.invalidResponse
        }
        
        guard (200..<300).contains(response.statusCode) else {
            throw JobAPIError.httpError(statusCode: response.statusCode)
        }
        
        let decoder = JSONDecoder()

        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)

            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [
                .withInternetDateTime,
                .withFractionalSeconds
            ]

            if let date = formatter.date(from: value) {
                return date
            }

            // Also accept dates without fractional seconds.
            formatter.formatOptions = [.withInternetDateTime]

            if let date = formatter.date(from: value) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date: \(value)"
            )
        }

        return try decoder.decode([JobApplicationDTO].self, from: data)
    }
}
