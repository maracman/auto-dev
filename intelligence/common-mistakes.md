# Common Mistakes Ledger

> Maintained by the Main agent. Records recurring errors and inefficiencies
> observed across pipeline runs. Main uses this to identify patterns before
> making structural changes. Pattern = 3+ occurrences of the same mistake type.

## How to Use This

1. After each sprint completes, Main scans `state/progress.tsv`,
   `state/VALIDATION_LOG.md`, and `state/BLOCKER_REPORT.md`.
2. Any row in progress.tsv with `result` = `fail`, `retry`, or `blocked` is a candidate.
3. Any validation sprint in VALIDATION_LOG.md with findings is a candidate.
4. For each candidate, Main classifies the root cause using the Decision Tree below.
5. Root causes are tallied in the appropriate category table.
6. When a category reaches the action threshold, Main investigates and acts.
7. Corrective action is logged in `pipeline-changelog.md`.

## Classification Decision Tree

When analyzing a failure, walk this tree top-to-bottom. Use the first match.

```
1. Did the agent claim something was done that wasn't actually done?
   → HALLUCINATION INCIDENT

2. Did the task fail because the output of a previous task was missing or wrong?
   → CONTEXT CHAIN ERROR

3. Did the task fail because the verification step missed something it should have caught?
   (i.e., verified as passing but actually wasn't)
   → VERIFICATION FAILURE

4. Did the task fail because the model couldn't do the work?
   (wrong format, couldn't follow instructions, generated broken code)
   a. Would a different model likely succeed? → MODEL CAPABILITY ERROR
   b. Would a different worker role be more appropriate? → WORKER ASSIGNMENT ERROR

5. Did the task fail because the sprint steps were wrong?
   (missing prerequisite, wrong order, scope too large for a single task)
   → SPRINT STRUCTURE ERROR

6. None of the above / unclear
   → Log in notes column of progress.tsv for now, revisit if it recurs
```

## Derived Metrics

Main should also compute these aggregate metrics periodically from progress.tsv:

| Metric | Formula | What It Reveals |
|--------|---------|-----------------|
| **Revert rate** | rows with result=fail / total rows | Overall pipeline health |
| **Retry rate** | rows with attempt>1 / total rows | Tasks that aren't clean first-pass |
| **Worker fail rate** | fails per worker / tasks per worker | Which workers struggle |
| **Sprint fail rate** | fails per sprint_type / sprints per type | Which sprint templates need work |
| **Model fail rate** | fails per model / tasks per model | Which models underperform |
| **Avg attempts to success** | mean(attempt) where result=success | Cost of getting things right |
| **Tokens per success** | sum(tokens) for successful tasks / count(successes) | Efficiency |
| **Interior loop frequency** | rows containing "interior" in sprint_id / total rows | Where the Manager gets stuck |
| **Validation pass rate** | pass verdicts / total verdicts in VALIDATION_LOG | Quality trajectory |
| **Time per sprint type** | sum(duration_s) grouped by sprint_type | Where time is spent |

## Error Categories

### Sprint Structure Errors
Mistakes caused by the sprint template itself (wrong task order, missing steps, etc.)

| Tally | Sprint | Error | First Seen | Last Seen |
|-------|--------|-------|------------|-----------|
| — | — | — | — | — |

### Worker Assignment Errors
Mistakes caused by assigning the wrong worker or model to a task.

| Tally | Worker | Task Type | Error | First Seen | Last Seen |
|-------|--------|-----------|-------|------------|-----------|
| — | — | — | — | — | — |

### Model Capability Errors
Mistakes caused by a model's limitations (can't follow format, hallucinates, etc.)

| Tally | Model | Competency | Error | First Seen | Last Seen |
|-------|-------|------------|-------|------------|-----------|
| — | — | — | — | — | — |

### Verification Failures
Cases where verification was passed but should have been caught.

| Tally | Verification Sprint | What Was Missed | First Seen | Last Seen |
|-------|---------------------|-----------------|------------|-----------|
| — | — | — | — | — |

### Context Chain Errors
Mistakes caused by information not being passed correctly between tasks.

| Tally | Sprint | From Task | To Task | What Was Lost | First Seen | Last Seen |
|-------|--------|-----------|---------|---------------|------------|-----------|
| — | — | — | — | — | — | — |

### Hallucination Incidents
Cases where an agent fabricated information, invented APIs, or claimed false results.

| Tally | Agent/Model | Task | What Was Hallucinated | First Seen | Last Seen |
|-------|-------------|------|-----------------------|------------|-----------|
| — | — | — | — | — | — |

## Action Threshold

- **3 tallies in any category:** Main investigates and proposes a change.
- **5 tallies in any category:** Main implements the change immediately.
- **Hallucination incidents:** threshold is 2 (lower tolerance).

---

*This file is append-only during a run. Main may reorganize between runs.*
