# Competitor Analysis Validation Sprint — Feature Parity & Differentiation

> **Version:** 1.0.0

## Purpose
Validation sprint that compares the project against competitors or reference
implementations to assess feature completeness, quality, and differentiation.

## Tasks

### Task 1: Competitor Identification
- **Worker:** researcher
- **Input:** MISSION.md (target market, problem space, target users)
- **Process:**
  1. Identify 3–5 direct competitors or comparable products.
  2. Document each competitor's core features.
  3. Note their strengths and weaknesses.
  4. Identify features that are table-stakes for the market.
- **Output:** Competitor landscape document with feature matrices.
- **Verification:** At least 3 competitors analyzed. Feature matrix is comprehensive.

### Task 2: Feature Gap Analysis
- **Worker:** reviewer
- **Input:** Competitor landscape from Task 1 + current PROJECT_STATE.md
- **Process:**
  1. Map project features against competitor feature matrix.
  2. Identify gaps: table-stakes features the project is missing.
  3. Identify differentiators: features the project has that competitors don't.
  4. Assess quality parity: where the project has the feature but it's inferior.
  5. Prioritize gaps by market impact.
- **Output:** Gap analysis with prioritized missing features and quality gaps.
- **Verification:** Every table-stakes feature accounted for. Gaps prioritized with rationale.

### Task 3: Verdict & Recommendations
- **Worker:** architect
- **Input:** Gap analysis from Task 2 + `project/validation-criteria.md`
- **Process:**
  1. Compare gap count and severity against project-specific competitive thresholds.
  2. Recommend which gaps to address (and which to intentionally skip).
  3. Generate sprint items for critical gaps.
  4. Render overall competitive readiness verdict.
- **Output:** Competitive readiness verdict + recommended sprint items.
- **Verification:** Verdict references specific criteria. New sprint items have acceptance criteria.

## Scoring Rubric

**Inputs from `project/validation-criteria.md`:**
- `min_table_stakes_coverage` (default: 100% — all must-have features present)
- `min_quality_parity_score` (e.g., 80% — subjective but structured)

**Score calculation:**
```
table_stakes_total   = count of features deemed table-stakes for the market
table_stakes_present = count of those features the project has
quality_comparisons  = per-feature quality rating vs top competitor (0–100)

coverage_score = table_stakes_present / table_stakes_total
quality_score  = mean(quality_comparisons) / 100

PASS if:    coverage_score >= min_table_stakes_coverage
        AND quality_score  >= min_quality_parity_score

PARTIAL if: coverage_score >= min_table_stakes_coverage
        AND quality_score  < min_quality_parity_score

FAIL if:    coverage_score < min_table_stakes_coverage
```

**Reported metrics (for SPRINT_LOG.md):**
| Metric | Value |
|--------|-------|
| Competitors analyzed | {count} |
| Table-stakes features | {present} / {total} = {coverage}% |
| Quality parity score | {score}% / min {threshold}% |
| Feature gaps (critical) | {count} |
| Feature gaps (nice-to-have) | {count} |
| **Verdict** | PASS / PARTIAL / FAIL |

## Completion Criteria
- Competitor landscape documented.
- Feature gaps identified and prioritized.
- Scoring rubric applied with numeric verdict.
- Critical gaps converted to sprint items.
