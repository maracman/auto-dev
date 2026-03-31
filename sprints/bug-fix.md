# Bug-Fix Sprint — Diagnosis and Repair

> **Version:** 1.0.0

## Purpose
Sprint for diagnosing and fixing a reported bug. Starts with reproduction,
works through root cause analysis, and ends with a verified fix plus regression test.

## Tasks

### Task 1: Reproduction
- **Worker:** qa-engineer
- **Input:** Bug report (symptoms, steps to reproduce if available)
- **Process:**
  1. Attempt to reproduce the bug from the report description.
  2. If reproducible, capture the exact steps, input data, and error output.
  3. If not reproducible, document what was tried and request more info.
  4. Write a failing test that demonstrates the bug.
- **Output:** Reproduction steps + failing test that captures the bug.
- **Verification:** The failing test reliably demonstrates the bug (fails consistently, not flaky).

### Task 2: Root Cause Analysis
- **Worker:** reviewer
- **Input:** Failing test + reproduction steps from Task 1
- **Process:**
  1. Trace the code path exercised by the reproduction steps.
  2. Identify the exact location and cause of the incorrect behavior.
  3. Assess blast radius: what else might be affected?
  4. Determine if this is an isolated bug or a symptom of a systemic issue.
- **Output:** Root cause report: file, line, cause, blast radius, recommended fix approach.
- **Verification:** Report points to specific code with explanation of why it's wrong.

### Task 3: Fix Implementation
- **Worker:** coder
- **Input:** Root cause report from Task 2 + failing test from Task 1
- **Process:**
  1. Implement the fix following the recommended approach.
  2. Keep the fix minimal — change only what's needed.
  3. Ensure the regression test from Task 1 now passes.
  4. Check that no other tests broke.
- **Output:** Fix diff + passing regression test + full test suite results.
- **Verification:** The regression test passes. No other tests broke. Fix matches the root cause (not a workaround).

### Task 4: Verification
- **Worker:** qa-engineer
- **Input:** Fix diff + test results from Task 3
- **Process:**
  1. Run the original reproduction steps — confirm bug is fixed.
  2. Run the full test suite — confirm no regressions.
  3. Test adjacent functionality (based on blast radius from Task 2).
  4. Run lint and type-check.
  5. Verify the fix addresses the root cause, not just the symptom.
- **Output:** Verification report with reproduction re-test, full test results, lint results.
- **Verification:** Bug no longer reproduces. All tests pass. Lint clean.

## Completion Criteria
- Bug is no longer reproducible.
- Regression test exists and passes.
- No other tests broken.
- Root cause addressed (not papered over).
