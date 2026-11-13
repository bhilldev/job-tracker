//
//  JobApplicationAPIService.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/14/26.
//
import Foundation

enum JobAPIError: LocalizedError {
    case invalidResponse
    case httpError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid response."
        case .httpError(let statusCode):
            return "The server could not complete the request (HTTP \(statusCode))."
        }
    }
}

struct JobApplicationAPIService {
    private let applicationsURL = URL(string: "http://localhost:5226/api/JobApplications")!

    func fetchJobApplications() async throws -> [JobApplicationDTO] {
        let (data, response) = try await URLSession.shared.data(from: applicationsURL)
        try validate(response)
        return try makeDecoder().decode([JobApplicationDTO].self, from: data)
    }

    func createJobApplication(
        request: CreateJobApplicationRequest
    ) async throws -> JobApplicationDTO {
        var urlRequest = URLRequest(url: applicationsURL)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        urlRequest.httpBody = try encoder.encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        try validate(response)
        return try makeDecoder().decode(JobApplicationDTO.self, from: data)
    }

    func updateJobApplication(
        id: Int,
        request: UpdateJobApplicationRequest
    ) async throws -> JobApplicationDTO {
        let url = applicationsURL.appendingPathComponent(String(id))

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        urlRequest.httpBody = try encoder.encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        try validate(response)
        return try makeDecoder().decode(JobApplicationDTO.self, from: data)
    }

    func deleteJobApplication(id: Int) async throws {
        let url = applicationsURL.appendingPathComponent(String(id))

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"

        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        try validate(response)
    }

    private func validate(_ response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else {
            throw JobAPIError.invalidResponse
        }

        guard (200..<300).contains(response.statusCode) else {
            throw JobAPIError.httpError(statusCode: response.statusCode)
        }
    }

    // Fetch and create return the same timestamp format, with or without fractions.
    private func makeDecoder() -> JSONDecoder {
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

        return decoder
    }
}
