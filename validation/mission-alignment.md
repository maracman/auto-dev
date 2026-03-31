# Mission Alignment Validation Sprint — Goal Fidelity Check

> **Version:** 1.0.0

## Purpose
Validation sprint that verifies the project as built actually serves the mission
as defined. Guards against scope drift, gold-plating, and missing the point.

## Tasks

### Task 1: Mission Decomposition
- **Worker:** reviewer
- **Input:** MISSION.md
- **Process:**
  1. Extract every stated objective from MISSION.md.
  2. Extract every success metric.
  3. Extract every constraint.
  4. Create a checklist: each objective, metric, and constraint becomes a line item.
- **Output:** Mission checklist with every requirement as a verifiable item.
- **Verification:** Checklist is exhaustive — nothing in MISSION.md is missed.

### Task 2: Implementation Mapping
- **Worker:** reviewer
- **Input:** Mission checklist from Task 1 + PROJECT_STATE.md + codebase
- **Process:**
  1. For each checklist item, identify the code/feature that fulfills it.
  2. Mark each item: fulfilled, partially fulfilled, not fulfilled, over-fulfilled.
  3. For "partially fulfilled": what's missing?
  4. For "over-fulfilled": is this intentional or scope creep?
  5. For constraints: verify they are respected.
- **Output:** Alignment matrix mapping every mission item to implementation status.
- **Verification:** Every mission item has a status. Partial/missing items have specific explanations.

### Task 3: Metric Verification
- **Worker:** qa-engineer
- **Input:** Success metrics from MISSION.md + current project
- **Process:**
  1. For each quantitative metric (test coverage, performance targets, etc.):
     - Measure the actual current value.
     - Compare against the target.
  2. For each qualitative metric (usability, readability, etc.):
     - Assess and justify the rating.
  3. Produce a scorecard: metric, target, actual, pass/fail.
- **Output:** Metrics scorecard with measured values vs targets.
- **Verification:** Every metric measured with documented methodology. No self-assessed "pass" without evidence.

### Task 4: Verdict
- **Worker:** architect
- **Input:** Alignment matrix + metrics scorecard + `project/validation-criteria.md`
- **Process:**
  1. Calculate overall alignment score (fulfilled items / total items).
  2. Calculate metrics pass rate.
  3. Identify the most critical gaps.
  4. Render verdict: mission-aligned / partially-aligned / misaligned.
  5. Generate sprint items for critical alignment gaps.
- **Output:** Mission alignment verdict + gap sprint items.
- **Verification:** Verdict is quantified. Critical gaps have concrete remediation paths.

## Scoring Rubric

**Inputs from MISSION.md (objectives + metrics) and `project/validation-criteria.md`:**
- Each objective is scored: fulfilled (1.0), partially fulfilled (0.5), not fulfilled (0.0)
- Each quantitative metric is scored: pass (1.0) if actual meets target, fail (0.0) if not
- Each constraint is scored: respected (1.0), violated (0.0)

**Score calculation:**
```
objective_scores  = [1.0, 0.5, 1.0, 0.0, ...]  # per objective
metric_scores     = [1.0, 1.0, 0.0, ...]         # per quantitative metric
constraint_scores = [1.0, 1.0, 1.0, ...]          # per constraint

alignment_score = (mean(objective_scores) * 0.5)
                + (mean(metric_scores) * 0.3)
                + (mean(constraint_scores) * 0.2)

PASS if:    alignment_score >= 0.9
        AND no constraint violated
        AND no objective scored 0.0

PARTIAL if: alignment_score >= 0.7
        AND no constraint violated

FAIL if:    alignment_score < 0.7
        OR  any constraint violated
```

**Reported metrics (for SPRINT_LOG.md):**
| Metric | Value |
|--------|-------|
| Objectives fulfilled | {n} / {total} ({n} partial) |
| Quantitative metrics passing | {n} / {total} |
| Constraints respected | {n} / {total} |
| Alignment score | {0.0–1.0} |
| **Verdict** | PASS / PARTIAL / FAIL |

## Completion Criteria
- Every mission objective mapped to implementation status.
- Every success metric measured.
- Scoring rubric applied with numeric alignment score.
- Critical gaps converted to sprint items.
