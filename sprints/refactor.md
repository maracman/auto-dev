# Refactor Sprint — Code Improvement Without Behavior Change

> **Version:** 1.0.0

## Purpose
Sprint for improving code structure, readability, or performance without changing
external behavior. All existing tests must continue to pass unchanged.

## Tasks

### Task 1: Refactor Scope
- **Worker:** architect
- **Input:** Refactor request (what to improve and why)
- **Process:**
  1. Identify the code to be refactored and its current responsibilities.
  2. Define the target state (how the code should look after refactoring).
  3. Map all tests that cover the affected code.
  4. Identify the refactoring strategy (extract, inline, rename, restructure).
  5. Define "done" in terms of measurable improvement (fewer lines, fewer dependencies, better cohesion).
- **Output:** Refactoring plan with before/after structure, affected files, and success metrics.
- **Verification:** Plan preserves all existing behavior. Success metrics are measurable.

### Task 2: Pre-Refactor Snapshot
- **Worker:** qa-engineer
- **Input:** Refactoring plan from Task 1
- **Process:**
  1. Run the full test suite and capture pass/fail counts.
  2. Run lint and capture warning counts.
  3. Capture code metrics if available (lines of code, complexity, dependency count).
  4. These become the baseline that must be matched or improved.
- **Output:** Baseline metrics snapshot.
- **Verification:** Snapshot captured with concrete numbers.

### Task 3: Implementation
- **Worker:** coder
- **Input:** Refactoring plan from Task 1 + baseline from Task 2
- **Process:**
  1. Apply the refactoring in small, incremental steps.
  2. Run tests after each step to catch regressions immediately.
  3. Do NOT add new features. Do NOT change behavior. Only restructure.
  4. Update imports, references, and internal documentation as needed.
- **Output:** Refactored code with all tests still passing.
- **Verification:** All tests pass. No test was modified (unless it tested internal structure that legitimately changed).

### Task 4: Verification
- **Worker:** qa-engineer
- **Input:** Refactored code + baseline snapshot from Task 2
- **Process:**
  1. Run full test suite — compare against baseline (pass count must match or improve).
  2. Run lint — compare against baseline (warnings must match or decrease).
  3. Compare code metrics against baseline (complexity, lines, dependencies).
  4. Verify no behavioral changes by checking API contracts and public interfaces.
- **Output:** Comparison report: before vs after metrics, test results, lint results.
- **Verification:** All baseline tests pass. Metrics improved or held steady. No behavior changes.

## Completion Criteria
- All existing tests pass without modification.
- Code metrics improved (or at least did not worsen).
- No external behavior changes.
- Lint warnings did not increase.
