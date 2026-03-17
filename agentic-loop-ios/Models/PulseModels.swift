import Foundation

// MARK: - Submit Mood

struct MoodSubmitRequest: Codable {
    let teamID:  String
    let mood:    Int       // 1–5
    let comment: String?

    enum CodingKeys: String, CodingKey {
        case teamID  = "team_id"
        case mood
        case comment
    }
}

struct MoodSubmitResponse: Codable {
    let id:         Int
    let createdAt:  String
    let mood:       Int
    let hasComment: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt  = "created_at"
        case mood
        case hasComment = "has_comment"
    }
}

// MARK: - Get Results

struct ResultsResponse: Codable {
    let teamID:           String
    let totalSubmissions: Int
    let averageMood:      Double
    let distribution:     [String: Int]
    let lastUpdated:      String?

    enum CodingKeys: String, CodingKey {
        case teamID           = "team_id"
        case totalSubmissions = "total_submissions"
        case averageMood      = "average_mood"
        case distribution
        case lastUpdated      = "last_updated"
    }
}

// MARK: - Get History

struct HistoryEntry: Codable, Identifiable {
    let id:        Int
    let mood:      Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case mood
        case createdAt = "created_at"
    }
}

struct HistoryResponse: Codable {
    let entries: [HistoryEntry]
    let total:   Int
}

// MARK: - Get Comments

struct MoodComment: Codable, Identifiable {
    let id:        Int
    let comment:   String
    let mood:      Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case comment
        case mood
        case createdAt = "created_at"
    }
}

struct CommentsResponse: Codable {
    let comments: [MoodComment]
    let total:    Int
}

// MARK: - Health Check

struct HealthCheckResponse: Codable {
    let status:    String   // "ok" | "degraded"
    let timestamp: String
    let error:     String?

    enum CodingKeys: String, CodingKey {
        case status
        case timestamp
        case error
    }
}

// MARK: - API Error

struct APIErrorResponse: Codable {
    let error: String
}
