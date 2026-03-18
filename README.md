# Team Pulse

An anonymous team mood and feedback tool. Submit how you're feeling, see the team's pulse in real time.

---

## What You're Building

Two views, one API client, from scratch.

### Submit View
Submit your mood on a 1–5 scale with an optional anonymous comment.

- **5 mood buttons** — each with an emoji, color, and label (Awful → Great)
- **Comment field** — optional, max 280 characters, with live character count
- **Submit button** — disabled until a mood is selected, shows loading state
- **Success feedback** — clear confirmation that your mood was recorded
- **Error handling** — if the API fails, show the error with a retry option

### Dashboard View
See the team's mood at a glance. Updates with real data as people submit.

- **Average mood** — big number with emoji, colored by mood
- **Total submissions** — how many moods have been recorded
- **Mood distribution** — horizontal bar chart showing count per mood (1–5)
- **Recent comments** — anonymous comments with mood indicator and timestamp
- **Loading state** — ProgressView or skeleton while data loads
- **Empty state** — friendly message when no submissions exist yet
- **Refresh** — `.refreshable` pull-to-refresh or refresh button

### API Client
A typed HTTP client that connects your app to the live backend.

- **5 functions** — submitMood, getResults, getHistory, getComments, healthCheck
- **Error handling** — throw `PulseAPIError` for network, HTTP, and decoding errors
- **Type safety** — all responses use Codable structs from `PulseModels.swift`

---

## API Contract

**Base URL:** `https://agentic-loop-api.vercel.app/api/v1`

### POST /pulse — Submit a mood

```json
// Request body
{ "mood": 4, "comment": "Great retro today", "team_id": "dev-01" }

// Response (201)
{ "id": 42, "created_at": "2026-03-20T14:30:00Z", "mood": 4, "has_comment": true }
```

### GET /pulse/results?team_id=dev-01 — Team stats

```json
{
  "team_id": "dev-01",
  "total_submissions": 28,
  "average_mood": 3.6,
  "distribution": { "1": 2, "2": 3, "3": 8, "4": 10, "5": 5 },
  "last_updated": "2026-03-20T14:30:00Z"
}
```

### GET /pulse/history?team_id=dev-01&limit=20 — Mood timeline

```json
{
  "entries": [
    { "id": 42, "mood": 4, "created_at": "2026-03-20T14:30:00Z" }
  ],
  "total": 28
}
```

### GET /pulse/comments?team_id=dev-01&limit=20 — Anonymous comments

```json
{
  "comments": [
    { "id": 42, "comment": "Great retro today", "mood": 4, "created_at": "2026-03-20T14:30:00Z" }
  ]
}
```

### GET /health — API health check

```json
{ "status": "ok", "timestamp": "2026-03-20T14:30:00Z" }
```

### Validation Rules
- `mood`: integer 1–5 only
- `comment`: max 280 characters, optional
- `team_id`: format `dev-XX` where XX is 01–40
- Rate limit: 60 POSTs per minute per team_id

---

## Design Guidelines

Dark theme. Mood-driven colors.

| Mood | Emoji | Color | Label |
|------|-------|-------|-------|
| 1 | 😡 | `#FF6B6B` Red | Awful |
| 2 | 😟 | `#FFA502` Orange | Bad |
| 3 | 😐 | `#FFD43B` Yellow | Okay |
| 4 | 😊 | `#51CF66` Green | Good |
| 5 | 🤩 | `#6C5CE7` Purple | Great |

**Background:** `#0D0D1A` · **Surface:** `#1A1A2E` · **Accent:** `#6C5CE7`

All tokens are in `Config/DesignTokens.swift`. Use `DesignTokens.Colors.moodColor(for: score)` for mood colors.

---

## Setup

### Prerequisites
- Xcode 15+
- iOS 17.0+ simulator
- GitHub Copilot for Xcode (separate app, runs alongside Xcode)

### Run

```bash
git clone https://github.com/amrikd/agentic-loop-ios.git
cd agentic-loop-ios
open agentic-loop-ios.xcodeproj
```

Select an iPhone simulator → Run (`⌘R`)

No third-party dependencies. No CocoaPods, no SPM. Pure URLSession.

### Configure Your Team ID

Edit `Config/Environment.swift`:
```swift
static let teamID: String = "dev-XX"  // ← Your assigned number
```

---

## What's Already Built

| File | What It Does |
|---|---|
| `Models/PulseModels.swift` | All Codable request/response structs |
| `Config/Environment.swift` | Base URL, team ID, mock toggle |
| `Config/DesignTokens.swift` | Colors, mood colors, spacing, typography, corner radius |
| `ContentView.swift` | TabView with Submit + Dashboard tabs |
| `Preview Content/PreviewData.swift` | Sample data for SwiftUI previews |

## What You Build

| File | What to Build |
|---|---|
| `Services/PulseAPIClient.swift` | URLSession client — all 5 API functions (shell + error enum provided) |
| `Views/Submit/SubmitView.swift` | Mood submission UI + ViewModel |
| `Views/Dashboard/DashboardView.swift` | Dashboard with stats, chart, comments + ViewModel |
| `Views/Components/*.swift` | Shared subviews (optional) |

**Note:** When creating new `.swift` files, run `ruby scripts/add-to-xcode.rb <path>` to add them to the Xcode project.

---

## Stretch Features

Done early? Try these:
- Swift Charts for mood trend line
- Time range filtering
- Animated transitions (`.scaleEffect`, `.animation(.spring)`)
- Haptic feedback (`UIImpactFeedbackGenerator`)
- Custom pull-to-refresh indicator
- Widget extension showing team mood

---

## Stack

| Layer | Technology |
|---|---|
| Language | Swift 5.9+ |
| UI | SwiftUI |
| HTTP | URLSession (async/await) |
| Architecture | MVVM with @Observable |
| Min Target | iOS 17.0 |

## License

MIT
