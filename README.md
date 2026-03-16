# agentic-loop-ios

iOS SwiftUI client for the Pulse team-mood API.

---

## Setup

1. **Clone** this repo.
2. Open `agentic-loop-ios.xcodeproj` in **Xcode 15+**.
3. Edit `agentic-loop-ios/Config/Environment.swift`:
   - Set `apiBaseURL` to your API server.
   - Set `teamID` to your team identifier.
4. Select an iPhone 17.0+ simulator and press **Run** (`⌘R`).

### Mock Mode

Flip one line in `Config/Environment.swift` to use static data with no network:

```swift
static let useMock: Bool = true   // ← change this
```

---

## Requirements

| Tool  | Version |
|-------|---------|
| Xcode | 15+     |
| iOS   | 17.0+   |
| Swift | 5.9+    |

No third-party dependencies. URLSession only.

---

## Folder Structure

```
agentic-loop-ios/
├── agentic-loop-ios.xcodeproj/
└── agentic-loop-ios/
    ├── agentic_loop_iosApp.swift   # @main entry point
    ├── ContentView.swift           # Root TabView
    ├── Config/
    │   ├── Environment.swift       # ← Edit base URL + team ID here
    │   └── DesignTokens.swift      # Colors, typography, spacing constants
    ├── Models/
    │   └── PulseModels.swift       # All Codable request/response structs
    ├── Services/
    │   └── PulseAPIClient.swift    # Singleton API client (5 endpoints)
    ├── Views/
    │   ├── Submit/
    │   │   └── SubmitView.swift    # ← Build mood submission UI here
    │   └── Dashboard/
    │       └── DashboardView.swift # ← Build dashboard UI here
    └── Preview Content/
        └── PreviewData.swift       # Static sample data for SwiftUI previews
```

---

## API Contract

Base URL is configured in `Config/Environment.swift`.

### POST `/mood/submit`

Submit a mood score for the team.

**Request body**
```json
{
  "team_id": "team-123",
  "score": 4,
  "comment": "Great sprint!",
  "user_id": "optional-user-id"
}
```

**Response**
```json
{
  "success": true,
  "submission_id": "abc123",
  "message": "Mood submitted successfully."
}
```

---

### GET `/results?team_id=team-123`

Fetch aggregated pulse results.

**Response**
```json
{
  "team_id": "team-123",
  "results": [
    {
      "id": "result-001",
      "team_id": "team-123",
      "average_score": 3.8,
      "total_votes": 12,
      "period": "2025-W10",
      "breakdown": { "1": 1, "2": 2, "3": 3, "4": 4, "5": 2 }
    }
  ]
}
```

---

### GET `/history?team_id=team-123&limit=20&offset=0`

Fetch submission history.

**Response**
```json
{
  "team_id": "team-123",
  "entries": [
    {
      "id": "h-001",
      "score": 4,
      "comment": "Good week.",
      "submitted_at": "2025-03-07T10:00:00Z",
      "period": "2025-W10"
    }
  ]
}
```

---

### GET `/comments?team_id=team-123&period=2025-W10`

Fetch anonymised comments.

**Response**
```json
{
  "team_id": "team-123",
  "comments": [
    {
      "id": "c-001",
      "text": "Great team energy!",
      "score": 5,
      "submitted_at": "2025-03-07T10:00:00Z",
      "period": "2025-W10"
    }
  ]
}
```

---

### GET `/health`

Ping the API.

**Response**
```json
{
  "status": "ok",
  "version": "1.0.0",
  "uptime": 86400
}
```

---

## Design Tokens

All tokens live in `Config/DesignTokens.swift`.

### Colors

| Token                       | Hex       | Usage                  |
|-----------------------------|-----------|------------------------|
| `Colors.background`         | `#0D0D0D` | Screen backgrounds     |
| `Colors.surface`            | `#1A1A2E` | Cards, sheets          |
| `Colors.surfaceElevated`    | `#252545` | Elevated cards         |
| `Colors.textPrimary`        | `#F0F0F0` | Headlines, body        |
| `Colors.textSecondary`      | `#9090A0` | Labels, subtitles      |
| `Colors.accent`             | `#7C5CBF` | CTAs, active tabs      |
| `Colors.accentLight`        | `#A07EE0` | Icons, highlights      |
| `Colors.mood1`              | `#F44336` | Score 1 — red          |
| `Colors.mood2`              | `#FF9800` | Score 2 — orange       |
| `Colors.mood3`              | `#FFEB3B` | Score 3 — yellow       |
| `Colors.mood4`              | `#4CAF50` | Score 4 — green        |
| `Colors.mood5`              | `#3F51B5` | Score 5 — indigo       |

Use `DesignTokens.Colors.moodColor(for: score)` to get a mood color by score.

### Spacing

| Token           | Value  |
|-----------------|--------|
| `Spacing.xxs`   | 4 pt   |
| `Spacing.xs`    | 8 pt   |
| `Spacing.sm`    | 12 pt  |
| `Spacing.md`    | 16 pt  |
| `Spacing.lg`    | 24 pt  |
| `Spacing.xl`    | 32 pt  |
| `Spacing.xxl`   | 48 pt  |

### Corner Radius

| Token        | Value   |
|--------------|---------|
| `Radius.sm`  | 8 pt    |
| `Radius.md`  | 12 pt   |
| `Radius.lg`  | 16 pt   |
| `Radius.xl`  | 24 pt   |

---

## API Client Usage

```swift
// Submit a mood
let response = try await PulseAPIClient.shared.submitMood(score: 4, comment: "Good week!")

// Fetch results
let results = try await PulseAPIClient.shared.getResults()

// Fetch history
let history = try await PulseAPIClient.shared.getHistory(limit: 10)

// Fetch comments
let comments = try await PulseAPIClient.shared.getComments(period: "2025-W10")

// Health check
let health = try await PulseAPIClient.shared.healthCheck()
```

---

## What You Build

The scaffolding is complete and compiles with zero errors. Your job is to implement two views:

### `Views/Submit/SubmitView.swift`
- Mood selector (scores 1–5) using `DesignTokens.Colors.moodColor(for:)`
- Optional comment text field
- Submit button calling `PulseAPIClient.shared.submitMood()`
- Loading/error/success states

### `Views/Dashboard/DashboardView.swift`
- Team average score using `PulseAPIClient.shared.getResults()`
- History chart/list using `PulseAPIClient.shared.getHistory()`
- Recent comments using `PulseAPIClient.shared.getComments()`
- Pull-to-refresh

Use `PreviewData.*` for SwiftUI `#Preview` blocks so views render without a network connection.

---

## Verification Checklist

- [ ] Opens in Xcode, builds and runs on simulator with zero errors
- [ ] TabView shows both tabs (Submit + Dashboard)
- [ ] Both tabs render placeholder text
- [ ] API client calls all 5 endpoints successfully
- [ ] Mock fallback works (`useMock = true` returns static data)
- [ ] README is complete
