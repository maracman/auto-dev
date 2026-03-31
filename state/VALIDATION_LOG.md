# VALIDATION_LOG.md

> Structured log of validation sprint outcomes. Written by the Manager after
> each validation sprint completes. Main reads this to assess project quality
> trajectory and validation sprint effectiveness.

## Format

Each entry records the full outcome of a validation sprint run:

```markdown
## {validation-sprint-type} — {date} — {verdict}

**Sprint:** {sprint_id}
**Triggered by:** {what prompted this validation — e.g., "dev queue empty", "post feature-dev sprint-012"}
**Criteria source:** project/validation-criteria.md

### Metrics vs Thresholds

| Metric | Threshold | Actual | Pass/Fail |
|--------|-----------|--------|-----------|
| {metric name} | {from validation-criteria.md} | {measured value} | {pass/fail} |
| ... | ... | ... | ... |

### Findings

| Severity | Count | Key Examples |
|----------|-------|-------------|
| Critical | {n} | {brief descriptions} |
| High | {n} | {brief descriptions} |
| Medium | {n} | {brief descriptions} |
| Low | {n} | {brief descriptions} |

### Remediation Generated

| New Sprint Item | Type | Priority | Sprint Template |
|-----------------|------|----------|-----------------|
| {task description} | {bug-fix/feature-dev/etc.} | {P0-P3} | {template from sprints/} |
| ... | ... | ... | ... |

### Evidence Artifacts
- {path to test output log}
- {path to screenshots}
- {path to comparison report}
- {etc.}
```

## Entries

*No validation runs yet.*

---

*This file is append-only. The Manager adds entries; Main reads them.*
