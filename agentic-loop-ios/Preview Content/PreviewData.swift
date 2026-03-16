import Foundation

/// Static sample data matching API response shapes.
/// Drop any of these into `#Preview` blocks or inject via the environment.
enum PreviewData {

    // MARK: MoodSubmitResponse
    static let submitResponse = MoodSubmitResponse(
        success: true,
        submissionID: "preview-sub-001",
        message: "Preview submission successful."
    )

    // MARK: PulseResult
    static let pulseResult = PulseResult(
        id: "preview-result-001",
        teamID: "team-preview",
        averageScore: 4.1,
        totalVotes: 8,
        period: "2025-W10",
        breakdown: [1: 0, 2: 1, 3: 1, 4: 4, 5: 2]
    )

    static let resultsResponse = ResultsResponse(
        teamID: "team-preview",
        results: [pulseResult]
    )

    // MARK: HistoryEntry
    static let historyEntries: [HistoryEntry] = [
        HistoryEntry(id: "preview-h-001", score: 5, comment: "Shipped the big feature!", submittedAt: Date(), period: "2025-W10"),
        HistoryEntry(id: "preview-h-002", score: 4, comment: "Good sprint.", submittedAt: Date().addingTimeInterval(-604800), period: "2025-W09"),
        HistoryEntry(id: "preview-h-003", score: 2, comment: "Heavy on-call week.", submittedAt: Date().addingTimeInterval(-1209600), period: "2025-W08"),
        HistoryEntry(id: "preview-h-004", score: 3, comment: nil, submittedAt: Date().addingTimeInterval(-1814400), period: "2025-W07")
    ]

    static let historyResponse = HistoryResponse(
        teamID: "team-preview",
        entries: historyEntries
    )

    // MARK: MoodComment
    static let comments: [MoodComment] = [
        MoodComment(id: "preview-c-001", text: "Great team energy this week!", score: 5, submittedAt: Date(), period: "2025-W10"),
        MoodComment(id: "preview-c-002", text: "Too many meetings, hard to focus.", score: 2, submittedAt: Date(), period: "2025-W10"),
        MoodComment(id: "preview-c-003", text: "Loved the retro format.", score: 4, submittedAt: Date(), period: "2025-W10")
    ]

    static let commentsResponse = CommentsResponse(
        teamID: "team-preview",
        comments: comments
    )

    // MARK: HealthCheckResponse
    static let healthOK = HealthCheckResponse(
        status: "ok",
        version: "1.0.0-preview",
        uptime: 86_400
    )
}
