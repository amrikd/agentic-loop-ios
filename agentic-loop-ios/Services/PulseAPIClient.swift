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

/// Build this! Implement each function to call the real API using URLSession.
///
/// API Base URL: https://agentic-loop-api.vercel.app/api/v1
///
/// Endpoints:
///   POST /pulse                        → body: { mood: 1-5, comment?, team_id }
///   GET  /pulse/results?team_id=dev-XX → aggregated stats
///   GET  /pulse/history?team_id=dev-XX → mood entries over time
///   GET  /pulse/comments?team_id=dev-XX → recent anonymous comments
///   GET  /health                       → API health check
///
/// Use `AppEnvironment.apiBaseURL` and `AppEnvironment.teamID` for configuration.
/// Use `PulseAPIError` for error handling.
/// All response types are defined in `Models/PulseModels.swift`.
final class PulseAPIClient {

    static let shared = PulseAPIClient()

    private init() {}

    // MARK: - Public API

    /// Submit a mood score (1–5) with an optional comment.
    /// POST /pulse  →  body: { "team_id": "dev-XX", "mood": 1-5, "comment": "optional" }
    func submitMood(mood: Int, comment: String? = nil) async throws -> MoodSubmitResponse {
        fatalError("TODO: Implement POST /pulse")
    }

    /// Fetch the latest aggregated pulse results for the team.
    /// GET /pulse/results?team_id=dev-XX
    func getResults() async throws -> ResultsResponse {
        fatalError("TODO: Implement GET /pulse/results")
    }

    /// Fetch the mood history for the team.
    /// GET /pulse/history?team_id=dev-XX&limit=20
    func getHistory(limit: Int = 20) async throws -> HistoryResponse {
        fatalError("TODO: Implement GET /pulse/history")
    }

    /// Fetch anonymised comments for the team.
    /// GET /pulse/comments?team_id=dev-XX&limit=20
    func getComments(limit: Int = 20) async throws -> CommentsResponse {
        fatalError("TODO: Implement GET /pulse/comments")
    }

    /// Ping the API to confirm it is reachable.
    /// GET /health
    func healthCheck() async throws -> HealthCheckResponse {
        fatalError("TODO: Implement GET /health")
    }
}
