# Phase 3 — HARDEN
### 35 minutes | Break it, fix it, prove it

---

## Your Goal

Make your app bulletproof. Write tests, find edge cases, handle errors properly. This phase is worth **30% of your score** — the rigor score. Judges will look for this.

## What to Do

1. **Switch to the Reviewer agent** (in VS Code) (or use the handoff from Builder)
2. **Work through this checklist:**

### Step 1: AI Code Review (10 min)

Ask the Reviewer agent:
> "Review my entire codebase as a senior engineer. Flag bugs, missing error handling, edge cases, accessibility gaps, and code smells."

Read what it finds. Prioritize: **crashes > wrong behavior > missing states > style**

### Step 2: Write Tests (15 min)

Ask the agent to generate tests for:

- **API client** — success path, error path (non-2xx), network failure
- **Submit flow** — mood selection, comment validation, loading state, double-submit prevention
- **Dashboard** — data loading, empty state, missing distribution keys

Run the tests. Fix what fails.

### Step 3: Edge Cases (10 min)

Check these yourself and fix any gaps:

| Edge Case | What Should Happen |
|---|---|
| Submit without selecting a mood | Button disabled, can't submit |
| Comment > 280 chars | Prevented client-side |
| API returns 500 | Error message shown, retry option |
| No internet / timeout | Graceful error, not a crash |
| Dashboard with zero submissions | Empty state, not broken UI |
| Distribution missing a mood key | Show 0, not crash |
| Double-tap submit | Prevented — button disabled while loading |
| `last_updated` is null | Handle gracefully |

## If You're Stuck

**Don't know what to test?**
> "What are the most important tests for a mood tracking app with submit and dashboard screens? Generate them."

**Tests won't run?**
> "Help me set up and run tests for my project. Here's my current test setup."

**Found a bug but not sure how to fix it?**
> "I found this edge case: [describe]. How should I handle it?"

## Don't

- ❌ Skip this phase — it's 30% of your score
- ❌ Write tests that just test the obvious happy path — edge cases matter
- ❌ Ignore what the AI review found — at least address the top 3 items

## Output

✅ Tests that run and pass
✅ Error handling for network failures and bad data
✅ Edge cases addressed

---

📌 **Git checkpoint:** `git add -A && git commit -m "Phase 3 — hardened"` — save your work before polishing.

*⏱ At 25 min: "10 minutes. Prioritize your most critical fixes."*
*✋ Checkpoint: "Who found something AI surfaced that you hadn't thought of?"*
