import Foundation

/// Static sample data matching API response shapes.
/// Drop any of these into `#Preview` blocks or inject via the environment.
enum PreviewData {

    // MARK: MoodSubmitResponse
    static let submitResponse = MoodSubmitResponse(
        id: 1,
        createdAt: "2026-03-09T12:00:00Z",
        mood: 4,
        hasComment: true
    )

    // MARK: ResultsResponse
    static let resultsResponse = ResultsResponse(
        teamID: "dev-01",
        totalSubmissions: 42,
        averageMood: 3.8,
        distribution: ["1": 2, "2": 5, "3": 10, "4": 15, "5": 10],
        lastUpdated: "2026-03-09T12:00:00Z"
    )

    // MARK: HistoryEntry
    static let historyEntries: [HistoryEntry] = [
        HistoryEntry(id: 1, mood: 5, createdAt: "2026-03-09T09:00:00Z"),
        HistoryEntry(id: 2, mood: 4, createdAt: "2026-03-08T15:30:00Z"),
        HistoryEntry(id: 3, mood: 2, createdAt: "2026-03-07T11:00:00Z"),
        HistoryEntry(id: 4, mood: 3, createdAt: "2026-03-06T14:00:00Z")
    ]

    static let historyResponse = HistoryResponse(
        entries: historyEntries,
        total: historyEntries.count
    )

    // MARK: MoodComment
    static let comments: [MoodComment] = [
        MoodComment(id: 1, comment: "Great team energy this week!", mood: 5, createdAt: "2026-03-09T09:00:00Z"),
        MoodComment(id: 2, comment: "Too many meetings, hard to focus.", mood: 2, createdAt: "2026-03-08T16:00:00Z"),
        MoodComment(id: 3, comment: "Loved the retro format.", mood: 4, createdAt: "2026-03-07T17:00:00Z")
    ]

    static let commentsResponse = CommentsResponse(
        comments: comments,
        total: comments.count
    )

    // MARK: HealthCheckResponse
    static let healthOK = HealthCheckResponse(
        status: "ok",
        timestamp: "2026-03-09T12:00:00Z",
        error: nil
    )
}
