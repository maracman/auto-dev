# Feature-Dev Sprint — New Feature Implementation

> **Version:** 1.0.0

## Purpose
Standard sprint for implementing a new feature. Used when adding functionality
that doesn't exist yet. Covers the full cycle from scoping through verified delivery.

## Tasks

### Task 1: Scope & Acceptance
- **Worker:** architect
- **Input:** Sprint item from queue (feature description, priority, acceptance criteria)
- **Process:**
  1. Clarify the feature boundaries: what's in scope, what's not.
  2. Refine acceptance criteria into testable assertions.
  3. Identify all files that will be created or modified.
  4. Identify dependencies on other features or external services.
  5. Flag if V3 (integration) or V4 (visual) validation is needed.
- **Output:** Scoping document with refined criteria, file list, dependency map, and validation level flags.
- **Verification:** Every acceptance criterion is phrased as a testable assertion.

### Task 2: Test Specification
- **Worker:** qa-engineer
- **Input:** Scoping document from Task 1
- **Process:**
  1. Write test cases for every acceptance criterion (happy path).
  2. Write edge-case tests (boundary values, null inputs, error states).
  3. Write regression tests if the feature touches existing functionality.
  4. Tests should be written to fail (red phase of red-green-refactor).
- **Output:** Test files that compile/parse but fail when run (no implementation yet).
- **Verification:** Tests exist for every acceptance criterion. Tests fail with clear "not implemented" errors (not compilation errors).

### Task 3: Implementation
- **Worker:** coder
- **Input:** Scoping document from Task 1 + failing tests from Task 2
- **Process:**
  1. Implement the feature to make all tests pass.
  2. Follow existing code style and patterns.
  3. Keep changes minimal — implement what's needed, nothing more.
  4. If implementation reveals missing tests, note them but don't add without QA sign-off.
- **Output:** Implementation code + passing test results.
- **Verification:** All tests from Task 2 now pass. No previously passing tests have broken. Lint and type-check pass.

### Task 4: Review
- **Worker:** reviewer
- **Input:** Diff of all changes (Task 2 tests + Task 3 implementation)
- **Process:**
  1. Review code quality, style consistency, and naming conventions.
  2. Check for security issues (injection, auth, data exposure).
  3. Check for performance issues (N+1 queries, unnecessary re-renders).
  4. Verify tests are meaningful (not tautological, cover real behavior).
  5. Check that acceptance criteria from Task 1 are met with evidence.
- **Output:** Review verdict (approve / request-changes) with specific findings.
- **Verification:** Review references specific lines/files. Every finding is categorized (blocking/suggestion/nitpick).

### Task 5: Verification
- **Worker:** qa-engineer
- **Input:** Final implementation + review approval
- **Process:**
  1. Run full test suite — capture before/after counts.
  2. Run lint — capture before/after warning counts.
  3. Run type-check — must pass clean.
  4. Verify diffs match what was claimed in the implementation.
  5. If V4 flagged: capture screenshots at mobile + desktop viewports.
  6. If V3 flagged: run integration tests with actual (or mocked) external services.
- **Output:** Verification report with all evidence (test output, lint output, screenshots, diffs).
- **Verification:** Tests pass. Lint warnings did not increase. All acceptance criteria have concrete evidence.

## Completion Criteria
- All acceptance criteria met with evidence.
- All tests pass (new + existing).
- Lint warnings did not increase.
- Review approved.
- Verification report complete with artifacts.
