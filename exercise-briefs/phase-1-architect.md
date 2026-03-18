# Phase 1 — ARCHITECT
### 25 minutes | Design before you code

---

## Your Goal

Use Copilot Chat to design the full architecture for Team Pulse **before writing any code**. By the end of this phase, you should have a documented plan you trust enough to build from.

## What to Do

1. **Open your Copilot agent** → Select the **Architect** agent in VS Code
2. **Ask it to propose** the full component architecture for Team Pulse
3. **Ask it to define** the API client design, state management, and data flow
4. **Challenge it** — ask: *"What are the weaknesses? What would a senior engineer push back on?"*
5. **Refine** based on the critique
6. **Save** — the agent will write your architecture to `ARCHITECTURE.md`

## What You're Designing

| Component | What to Think About |
|---|---|
| **API Client** | How do you call 5 endpoints? How do you handle errors? Types? |
| **Submit Screen** | What state do you need? Selected mood, comment text, loading, success, error? |
| **Dashboard Screen** | How do you load 3 endpoints in parallel? What if one fails? |
| **Shared Components** | Mood button, comment card, chart — reusable or inline? |

## API Contract

```
Base URL: https://agentic-loop-api.vercel.app/api/v1

POST /pulse                        → { mood: 1-5, comment?, team_id }
GET  /pulse/results?team_id=dev-XX → { total_submissions, average_mood, distribution, last_updated }
GET  /pulse/history?team_id=dev-XX → { entries: [{ id, mood, created_at }], total }
GET  /pulse/comments?team_id=dev-XX → { comments: [{ id, comment, mood, created_at }], total }
GET  /health                       → { status, timestamp }
```

Validation: mood 1–5, comment max 280 chars, team_id `dev-XX` (01–40)

## If You're Stuck

Try this prompt:
> "I have a [React/SwiftUI/Compose] app with typed API models already set up. I need to build an API client, a mood submission screen, and a dashboard. Propose the architecture — component tree, state management, and data flow."

## Don't

- ❌ Write code yet — that's Phase 2
- ❌ Skip this phase — architects build faster than cowboys
- ❌ Accept the first answer — push back, ask "what if"

## Output

✅ `ARCHITECTURE.md` in your project root with component tree, state shapes, and data flow

---

*⏱ At 20 min: "5 minutes. Finalize your architecture. You're building from it next."*
