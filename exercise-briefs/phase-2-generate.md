# Phase 2 — GENERATE
### 35 minutes | Build it

---

## Your Goal

Build a working Team Pulse app — API client, submit screen, and dashboard — hitting the live API. By the end of this phase, you should be able to submit a mood and see it on your dashboard.

## What to Do

1. **Switch to the Builder agent** in VS Code (in VS Code — build and run with ⌘R in Xcode) (or use the handoff from Architect)
2. **Build in this order:**

### Step 1: API Client (10 min)
Build the HTTP client that calls all 5 endpoints. Use the typed models already in your project.

- Your team ID is `dev-XX` (check your assignment)
- Test it works: submit a mood and check the health endpoint
- Handle errors — don't just ignore failures

### Step 2: Submit Screen (12 min)
Build the mood submission UI:

- 5 mood buttons (1–5) with emojis and colors
- Optional comment text field (max 280 chars)
- Submit button that calls your API client
- Show loading while submitting
- Show success/error feedback after

### Step 3: Dashboard Screen (13 min)
Build the dashboard that displays live data:

- Average mood (big number + emoji)
- Mood distribution chart (bars for moods 1–5)
- Recent comments feed with mood indicator + timestamp
- Loading state while fetching
- Refresh button

## Your Team ID

Check your assignment sheet. Configure it in:
- **Web:** `lib/config.ts` → `teamId`
- **Android:** `config/Environment.kt` → `TEAM_ID`
- **iOS:** `Config/Environment.swift` → `teamID`

## If You're Stuck

**API client not working?**
> "My API calls are failing. Here's the base URL and endpoint. Help me debug the request."

**UI not coming together?**
> "Build me a [mood selector / dashboard / comment list] component. Here are the design tokens I'm using."

**Don't know where to start?**
> "Read my ARCHITECTURE.md and start building Step 1 — the API client."

## Don't

- ❌ Spend time on styling — get data flowing first
- ❌ Accept broken code — if it doesn't compile, fix it before moving on
- ❌ Build everything from scratch — use your architecture plan

## Output

✅ Working app: submit a mood → see it on the dashboard

---

📌 **Git checkpoint:** `git add -A && git commit -m "Phase 2 — working app"` — if things break later, you can always come back to this.

*⏱ At 30 min: "5 minutes. Get end-to-end working. Polish comes later."*
*✋ Checkpoint: "Raise your hand if you can submit a mood and see it on your dashboard."*
