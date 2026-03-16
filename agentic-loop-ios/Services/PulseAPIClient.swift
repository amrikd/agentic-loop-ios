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
        decoder.dateDecodingStrategy = .iso8601
    }

    // MARK: - Public API

    /// Submit a mood score (1–5) with an optional comment.
    func submitMood(score: Int, comment: String? = nil, userID: String? = nil) async throws -> MoodSubmitResponse {
        if AppEnvironment.useMock {
            return MockData.submitResponse
        }

        let body = MoodSubmitRequest(teamID: teamID, score: score, comment: comment, userID: userID)
        return try await post(path: "/mood/submit", body: body)
    }

    /// Fetch the latest aggregated pulse results for the team.
    func getResults() async throws -> ResultsResponse {
        if AppEnvironment.useMock {
            return MockData.resultsResponse
        }

        return try await get(path: "/results", queryItems: [URLQueryItem(name: "team_id", value: teamID)])
    }

    /// Fetch the submission history for the team.
    func getHistory(limit: Int = 20, offset: Int = 0) async throws -> HistoryResponse {
        if AppEnvironment.useMock {
            return MockData.historyResponse
        }

        let items = [
            URLQueryItem(name: "team_id", value: teamID),
            URLQueryItem(name: "limit",   value: "\(limit)"),
            URLQueryItem(name: "offset",  value: "\(offset)")
        ]
        return try await get(path: "/history", queryItems: items)
    }

    /// Fetch anonymised comments for the team.
    func getComments(period: String? = nil) async throws -> CommentsResponse {
        if AppEnvironment.useMock {
            return MockData.commentsResponse
        }

        var items = [URLQueryItem(name: "team_id", value: teamID)]
        if let period { items.append(URLQueryItem(name: "period", value: period)) }
        return try await get(path: "/comments", queryItems: items)
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
        success: true,
        submissionID: "mock-submission-001",
        message: "Mood submitted successfully (mock)."
    )

    static let resultsResponse = ResultsResponse(
        teamID: AppEnvironment.teamID,
        results: [
            PulseResult(
                id: "result-001",
                teamID: AppEnvironment.teamID,
                averageScore: 3.8,
                totalVotes: 12,
                period: "2025-W10",
                breakdown: [1: 1, 2: 2, 3: 3, 4: 4, 5: 2]
            )
        ]
    )

    static let historyResponse = HistoryResponse(
        teamID: AppEnvironment.teamID,
        entries: [
            HistoryEntry(id: "h-001", score: 4, comment: "Good week overall.", submittedAt: Date(), period: "2025-W10"),
            HistoryEntry(id: "h-002", score: 3, comment: nil,                  submittedAt: Date().addingTimeInterval(-604800), period: "2025-W09"),
            HistoryEntry(id: "h-003", score: 5, comment: "Shipped big feature!", submittedAt: Date().addingTimeInterval(-1209600), period: "2025-W08")
        ]
    )

    static let commentsResponse = CommentsResponse(
        teamID: AppEnvironment.teamID,
        comments: [
            MoodComment(id: "c-001", text: "Great collaboration this week.", score: 5, submittedAt: Date(), period: "2025-W10"),
            MoodComment(id: "c-002", text: "Feeling a bit overwhelmed with scope.", score: 2, submittedAt: Date(), period: "2025-W10"),
            MoodComment(id: "c-003", text: "Sprint retro was productive.", score: 4, submittedAt: Date(), period: "2025-W10")
        ]
    )

    static let healthResponse = HealthCheckResponse(
        status: "ok",
        version: "1.0.0-mock",
        uptime: 99_999
    )
}
