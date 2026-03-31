# SPRINT_LOG.md

> Structured log of every sprint outcome — dev and validation.
> Written by the Manager after each sprint completes or fails.
> Main reads this to monitor sprint success rates, correlate pipeline versions
> with outcomes, and detect degradation.

## Format

Every sprint gets an entry, whether it succeeded or failed.

```markdown
## {sprint_id} — {sprint_type} — {verdict}

**Date:** {ISO 8601}
**Template:** {sprint template filename, e.g., feature-dev.md}
**Template version:** {version from the sprint template header}
**Manager version:** {version from agents/manager.md header}
**Orchestrator version:** {version from agents/orchestrator.md header}
**Workers used:** {worker: model pairs, e.g., coder: claude-sonnet-4-6, reviewer: gpt-5.4}

### Outcome
- **Verdict:** success | partial | fail | blocked
- **Tasks completed:** {n} / {total}
- **Tasks requiring retries:** {n} (list: {task names})
- **Interior loops triggered:** {n} (max iterations used: {n})

### Metrics Delta
| Metric | Before Sprint | After Sprint | Delta |
|--------|--------------|-------------|-------|
| Passing tests | {n} | {n} | {+/-n} |
| Lint warnings | {n} | {n} | {+/-n} |
| Build status | {pass/fail} | {pass/fail} | — |

### For Validation Sprints Only
| Metric | Threshold | Actual | Pass/Fail |
|--------|-----------|--------|-----------|
| {metric} | {from validation-criteria.md} | {measured} | {pass/fail} |

**Validation score:** {passed metrics} / {total metrics} = {percentage}%

### Evidence
- {path to key artifact — diff, test output, screenshot, report}

### Notes
{Brief free text — what went well, what was unexpected, why it failed if it failed.}
```

## Entries

*No sprints logged yet.*

---

*This file is append-only. The Manager adds entries; Main reads them for pattern analysis.*
