import Foundation

// MARK: - Submit Mood

struct MoodSubmitRequest: Codable {
    let teamID:  String
    let score:   Int       // 1–5
    let comment: String?
    let userID:  String?

    enum CodingKeys: String, CodingKey {
        case teamID  = "team_id"
        case score
        case comment
        case userID  = "user_id"
    }
}

struct MoodSubmitResponse: Codable {
    let success:     Bool
    let submissionID: String
    let message:     String?

    enum CodingKeys: String, CodingKey {
        case success
        case submissionID = "submission_id"
        case message
    }
}

// MARK: - Get Results

struct PulseResult: Codable, Identifiable {
    let id:          String
    let teamID:      String
    let averageScore: Double
    let totalVotes:  Int
    let period:      String   // e.g. "2025-W10"
    let breakdown:   [Int: Int]?  // score → count

    enum CodingKeys: String, CodingKey {
        case id
        case teamID       = "team_id"
        case averageScore = "average_score"
        case totalVotes   = "total_votes"
        case period
        case breakdown
    }
}

struct ResultsResponse: Codable {
    let teamID:  String
    let results: [PulseResult]

    enum CodingKeys: String, CodingKey {
        case teamID  = "team_id"
        case results
    }
}

// MARK: - Get History

struct HistoryEntry: Codable, Identifiable {
    let id:          String
    let score:       Int
    let comment:     String?
    let submittedAt: Date
    let period:      String

    enum CodingKeys: String, CodingKey {
        case id
        case score
        case comment
        case submittedAt = "submitted_at"
        case period
    }
}

struct HistoryResponse: Codable {
    let teamID:  String
    let entries: [HistoryEntry]

    enum CodingKeys: String, CodingKey {
        case teamID  = "team_id"
        case entries
    }
}

// MARK: - Get Comments

struct MoodComment: Codable, Identifiable {
    let id:          String
    let text:        String
    let score:       Int
    let submittedAt: Date
    let period:      String

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case score
        case submittedAt = "submitted_at"
        case period
    }
}

struct CommentsResponse: Codable {
    let teamID:   String
    let comments: [MoodComment]

    enum CodingKeys: String, CodingKey {
        case teamID   = "team_id"
        case comments
    }
}

// MARK: - Health Check

struct HealthCheckResponse: Codable {
    let status:  String   // "ok" | "degraded" | "down"
    let version: String?
    let uptime:  Double?
}

// MARK: - API Error

struct APIErrorResponse: Codable {
    let error:   String
    let message: String?
    let code:    Int?
}
