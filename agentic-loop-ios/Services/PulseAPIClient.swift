import Foundation

// MARK: - Client Errors

enum PulseAPIError: LocalizedError {
    case invalidURL
    case encodingFailed(Error)
    case networkError(Error)
    case httpError(statusCode: Int, body: String?)
    case decodingFailed(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:                    return "Invalid URL."
        case .encodingFailed(let e):         return "Encoding failed: \(e.localizedDescription)"
        case .networkError(let e):           return "Network error: \(e.localizedDescription)"
        case .httpError(let code, let body): return "HTTP \(code): \(body ?? "no body")"
        case .decodingFailed(let e):         return "Decoding failed: \(e.localizedDescription)"
        case .unknown:                       return "An unknown error occurred."
        }
    }
}

// MARK: - PulseAPIClient

final class PulseAPIClient {

    // One-line switch: flip `AppEnvironment.useMock` in Config/Environment.swift
    static let shared = PulseAPIClient()

    private let baseURL: String
    private let teamID:  String
    private let session: URLSession
    private let decoder: JSONDecoder

    private init() {
        baseURL = AppEnvironment.apiBaseURL
        teamID  = AppEnvironment.teamID
        session = URLSession.shared
        decoder = JSONDecoder()
    }

    // MARK: - Public API

    /// Submit a mood score (1–5) with an optional comment.
    func submitMood(mood: Int, comment: String? = nil) async throws -> MoodSubmitResponse {
        if AppEnvironment.useMock {
            return MockData.submitResponse
        }

        let body = MoodSubmitRequest(teamID: teamID, mood: mood, comment: comment)
        return try await post(path: "/pulse", body: body)
    }

    /// Fetch the latest aggregated pulse results for the team.
    func getResults() async throws -> ResultsResponse {
        if AppEnvironment.useMock {
            return MockData.resultsResponse
        }

        return try await get(path: "/pulse/results", queryItems: [URLQueryItem(name: "team_id", value: teamID)])
    }

    /// Fetch the mood history for the team.
    func getHistory(limit: Int = 20) async throws -> HistoryResponse {
        if AppEnvironment.useMock {
            return MockData.historyResponse
        }

        let items = [
            URLQueryItem(name: "team_id", value: teamID),
            URLQueryItem(name: "limit",   value: "\(limit)")
        ]
        return try await get(path: "/pulse/history", queryItems: items)
    }

    /// Fetch anonymised comments for the team.
    func getComments(limit: Int = 20) async throws -> CommentsResponse {
        if AppEnvironment.useMock {
            return MockData.commentsResponse
        }

        let items = [
            URLQueryItem(name: "team_id", value: teamID),
            URLQueryItem(name: "limit",   value: "\(limit)")
        ]
        return try await get(path: "/pulse/comments", queryItems: items)
    }

    /// Ping the API to confirm it is reachable.
    func healthCheck() async throws -> HealthCheckResponse {
        if AppEnvironment.useMock {
            return MockData.healthResponse
        }

        return try await get(path: "/health", queryItems: [])
    }

    // MARK: - Private Helpers

    private func get<T: Decodable>(path: String, queryItems: [URLQueryItem]) async throws -> T {
        guard var components = URLComponents(string: baseURL + path) else {
            throw PulseAPIError.invalidURL
        }
        if !queryItems.isEmpty { components.queryItems = queryItems }
        guard let url = components.url else { throw PulseAPIError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return try await perform(request)
    }

    private func post<B: Encodable, T: Decodable>(path: String, body: B) async throws -> T {
        guard let url = URL(string: baseURL + path) else { throw PulseAPIError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw PulseAPIError.encodingFailed(error)
        }

        return try await perform(request)
    }

    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw PulseAPIError.networkError(error)
        }

        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            let body = String(data: data, encoding: .utf8)
            throw PulseAPIError.httpError(statusCode: http.statusCode, body: body)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw PulseAPIError.decodingFailed(error)
        }
    }
}

// MARK: - Mock Data

private enum MockData {

    static let submitResponse = MoodSubmitResponse(
        id: 1,
        createdAt: "2026-03-09T12:00:00Z",
        mood: 4,
        hasComment: true
    )

    static let resultsResponse = ResultsResponse(
        teamID: AppEnvironment.teamID,
        totalSubmissions: 42,
        averageMood: 3.8,
        distribution: ["1": 2, "2": 5, "3": 10, "4": 15, "5": 10],
        lastUpdated: "2026-03-09T12:00:00Z"
    )

    static let historyResponse = HistoryResponse(
        entries: [
            HistoryEntry(id: 1, mood: 4, createdAt: "2026-03-09T09:00:00Z"),
            HistoryEntry(id: 2, mood: 2, createdAt: "2026-03-08T17:00:00Z"),
            HistoryEntry(id: 3, mood: 5, createdAt: "2026-03-07T14:30:00Z")
        ],
        total: 3
    )

    static let commentsResponse = CommentsResponse(
        comments: [
            MoodComment(id: 1, comment: "Great collaboration this week.", mood: 5, createdAt: "2026-03-09T09:00:00Z"),
            MoodComment(id: 2, comment: "Feeling a bit overwhelmed with scope.", mood: 2, createdAt: "2026-03-08T17:00:00Z"),
            MoodComment(id: 3, comment: "Sprint retro was productive.", mood: 4, createdAt: "2026-03-07T14:30:00Z")
        ],
        total: 3
    )

    static let healthResponse = HealthCheckResponse(
        status: "ok",
        timestamp: "2026-03-09T12:00:00Z",
        error: nil
    )
}
