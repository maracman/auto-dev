# Board of Examiners Validation Sprint — Final Multi-Perspective Review

> **Version:** 1.0.0

## Purpose
The final and most rigorous validation sprint. Simulates a panel review where
multiple perspectives examine the project independently, then synthesize findings.
Deployed as the last validation before a project is declared complete.

## Tasks

### Task 1: Technical Examination
- **Worker:** reviewer
- **Input:** Complete codebase + PROJECT_STATE.md + all previous validation results
- **Process:**
  1. Review architecture: is it sound, maintainable, and appropriate for the problem?
  2. Review code quality: consistency, readability, error handling, test coverage.
  3. Review technical debt: are there known shortcuts that need addressing?
  4. Assess: would a new developer be able to onboard and contribute?
  5. Score on a scale: exemplary / adequate / needs-work / failing.
- **Output:** Technical examination report with score and specific findings.
- **Verification:** Score justified with specific examples from the codebase.

### Task 2: User Perspective Examination
- **Worker:** qa-engineer
- **Input:** Running application + MISSION.md (target users, use cases)
- **Process:**
  1. Walk through every primary user flow end-to-end.
  2. Assess: is each flow intuitive, complete, and error-resistant?
  3. Test with realistic scenarios (not just happy paths).
  4. Note friction points, confusion risks, and missing affordances.
  5. Score on a scale: exemplary / adequate / needs-work / failing.
- **Output:** User perspective report with flow-by-flow assessment and score.
- **Verification:** Every primary user flow tested. Score justified with specific observations.

### Task 3: Documentation & Maintainability Examination
- **Worker:** writer
- **Input:** All documentation + codebase
- **Process:**
  1. Can someone set up the project from the README alone?
  2. Are key decisions documented (architecture, trade-offs, constraints)?
  3. Is the API documented accurately?
  4. Are there clear contribution guidelines?
  5. Score on a scale: exemplary / adequate / needs-work / failing.
- **Output:** Documentation examination report with score and specific gaps.
- **Verification:** Setup instructions tested. API docs verified against actual behavior.

### Task 4: Panel Synthesis
- **Worker:** architect
- **Input:** All three examination reports + `project/validation-criteria.md`
- **Process:**
  1. Synthesize findings across all three perspectives.
  2. Identify consensus issues (flagged by multiple examiners).
  3. Calculate overall score (weighted average per validation criteria).
  4. Determine verdict: release-ready / conditionally-ready / not-ready.
  5. For conditionally-ready: specify exact conditions to be met.
  6. For not-ready: prioritize the blocking issues as sprint items.
- **Output:** Board verdict with overall score, consensus findings, and conditions/blockers.
- **Verification:** Verdict references all three examinations. Conditions are specific and testable.

## Anti-Hallucination Safeguards
This sprint is especially vulnerable to rubber-stamping. Safeguards:
- Each examiner must cite at least 2 specific weaknesses, even if minor.
  A review with zero weaknesses is rejected as insufficiently rigorous.
- Scores of "exemplary" require specific evidence of excellence, not just absence of problems.
- The synthesis in Task 4 must cross-reference: if Examiner A found an issue,
  did Examiners B and C also check that area?
- No examiner may review their own previous work. If a worker produced code
  earlier in the pipeline, a different worker must examine it.

## Scoring Rubric

Each examiner scores their domain on a 4-point scale. The panel synthesizes.

**Per-examiner scoring:**
```
exemplary    = 4  (must cite specific evidence of excellence)
adequate     = 3  (meets expectations, minor issues only)
needs-work   = 2  (significant issues but not blocking)
failing      = 1  (blocking issues present)
```

**Examiner validity check (anti-rubber-stamp):**
- Each examiner must cite ≥2 specific weaknesses. If not, the examination
  is REJECTED and re-run. A score of 4 with zero weaknesses is invalid.

**Panel score calculation:**
```
technical_score     = examiner 1 score  (weight: 0.4)
user_score          = examiner 2 score  (weight: 0.35)
documentation_score = examiner 3 score  (weight: 0.25)

composite = (technical_score * 0.4) + (user_score * 0.35) + (documentation_score * 0.25)

RELEASE-READY if:       composite >= 3.2 AND no examiner scored 1
CONDITIONALLY-READY if: composite >= 2.5 AND no examiner scored 1
NOT-READY if:           composite < 2.5 OR any examiner scored 1
```

**Reported metrics (for SPRINT_LOG.md):**
| Metric | Value |
|--------|-------|
| Technical examination score | {1–4} |
| User perspective score | {1–4} |
| Documentation score | {1–4} |
| Weaknesses cited (total) | {count} (min 6 required across 3 examiners) |
| Consensus issues (flagged by 2+) | {count} |
| Composite score | {1.0–4.0} |
| **Verdict** | RELEASE-READY / CONDITIONALLY-READY / NOT-READY |

## Completion Criteria
- All three examinations complete with specific, evidence-backed findings.
- Each examiner cited ≥2 weaknesses (validity check passed).
- Panel synthesis complete with composite score.
- Scoring rubric applied with numeric verdict.
- Any blocking issues converted to sprint items.
