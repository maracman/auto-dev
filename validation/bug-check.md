# Bug-Check Validation Sprint — Edge-Case & Fringe Input Testing

> **Version:** 1.0.0

## Purpose
Validation sprint that systematically tests the project with adversarial and edge-case
inputs designed to expose hidden bugs. Deployed by the Manager after dev sprints complete.
Metrics and pass/fail thresholds are defined in `project/validation-criteria.md`.

## Tasks

### Task 1: Test Surface Mapping
- **Worker:** qa-engineer
- **Input:** PROJECT_STATE.md + codebase entry points (APIs, forms, CLI args, event handlers)
- **Process:**
  1. Enumerate all input surfaces (every place the system accepts external data).
  2. For each surface, document: expected input type, constraints, and current validation.
  3. Identify surfaces with weak or missing validation.
- **Output:** Input surface map with validation coverage assessment.
- **Verification:** Every public API endpoint, form field, and CLI argument listed.

### Task 2: Adversarial Test Data Generation
- **Worker:** qa-engineer
- **Input:** Surface map from Task 1
- **Process:**
  1. For each input surface, generate adversarial test data:
     - Null / undefined / empty
     - Type mismatches (string where number expected, object where array expected)
     - Boundary values (0, -1, MAX_INT, MAX_INT+1, empty string, very long string)
     - Special characters (unicode, emoji, null bytes, SQL injection patterns, XSS patterns)
     - Malformed data (incomplete JSON, truncated input, wrong encoding)
     - Concurrent/race condition scenarios if applicable.
  2. Document the expected behavior for each test case (error message, graceful degradation, rejection).
- **Output:** Test data set with expected behaviors, organized by input surface.
- **Verification:** Each input surface has at least 5 adversarial test cases. Expected behaviors are specific.

### Task 3: Test Execution
- **Worker:** qa-engineer
- **Input:** Test data set from Task 2
- **Process:**
  1. Run each adversarial test case against the system.
  2. Record actual behavior vs expected behavior.
  3. Classify results: pass (handled correctly), fail (crash, wrong output, silent corruption).
  4. For failures, capture: error output, stack trace, system state after failure.
- **Output:** Test execution results with pass/fail per test case and failure details.
- **Verification:** Every test case executed. Failures include reproducible details.

### Task 4: Severity Assessment
- **Worker:** reviewer
- **Input:** Test execution results from Task 3
- **Process:**
  1. Classify each failure by severity:
     - Critical: crash, data corruption, security vulnerability
     - High: incorrect output, silent failure, poor error message
     - Medium: graceless degradation, missing validation
     - Low: cosmetic error handling issues
  2. Cross-reference failures against `project/validation-criteria.md` thresholds.
  3. Determine overall pass/fail against project-specific metrics.
- **Output:** Severity report + overall verdict (pass/fail against validation criteria).
- **Verification:** Every failure classified. Verdict references specific criteria thresholds.

## Scoring Rubric

The verdict is computed numerically, not subjectively.

**Inputs from `project/validation-criteria.md`:**
- `max_critical_bugs` (default: 0)
- `max_high_bugs` (default: 0)
- `max_medium_bugs` (threshold set per project)

**Score calculation:**
```
critical_count = number of critical severity findings
high_count     = number of high severity findings
medium_count   = number of medium severity findings

PASS if:  critical_count <= max_critical_bugs
      AND high_count     <= max_high_bugs
      AND medium_count   <= max_medium_bugs

PARTIAL if: critical_count <= max_critical_bugs
        AND (high_count > max_high_bugs OR medium_count > max_medium_bugs)

FAIL if: critical_count > max_critical_bugs
```

**Reported metrics (for SPRINT_LOG.md):**
| Metric | Value |
|--------|-------|
| Input surfaces tested | {count} |
| Test cases executed | {count} |
| Critical findings | {count} / max {threshold} |
| High findings | {count} / max {threshold} |
| Medium findings | {count} / max {threshold} |
| Low findings | {count} (informational, not scored) |
| **Verdict** | PASS / PARTIAL / FAIL |

## Completion Criteria
- All input surfaces tested with adversarial data.
- Failures classified by severity.
- Scoring rubric applied with numeric verdict.
- Critical/high failures generate new sprint items for remediation.
