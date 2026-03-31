# Documentation Sprint — Technical & User Documentation

> **Version:** 1.0.0

## Purpose
Sprint for creating or updating project documentation. Covers README, API docs,
architecture docs, and user guides. All documentation is verified against the
actual codebase.

## Tasks

### Task 1: Documentation Audit
- **Worker:** researcher
- **Input:** Current codebase + existing docs
- **Process:**
  1. Inventory existing documentation (README, inline comments, doc files).
  2. Identify gaps: undocumented features, outdated docs, missing examples.
  3. Prioritize by impact (README > API docs > architecture > internal).
- **Output:** Documentation gap report with prioritized list.
- **Verification:** Gap report references specific undocumented features or outdated sections.

### Task 2: Documentation Writing
- **Worker:** writer
- **Input:** Gap report from Task 1 + actual codebase
- **Process:**
  1. Write or update documentation in priority order.
  2. Read the actual code before documenting any behavior.
  3. Include concrete examples (code snippets, request/response pairs).
  4. Keep docs co-located with the code they describe where possible.
- **Output:** Documentation files ready to commit.
- **Verification:** Every documented behavior verified against the code. Examples are runnable.

### Task 3: Verification
- **Worker:** reviewer
- **Input:** New/updated docs + codebase
- **Process:**
  1. Spot-check: pick 5 documented behaviors and verify them against the code.
  2. Check all code examples: do they compile/run?
  3. Check for completeness: are the major features covered?
  4. Check for accuracy: do documented interfaces match actual signatures?
- **Output:** Verification report with spot-check results and accuracy findings.
- **Verification:** Spot-checks pass. Code examples verified. No inaccuracies found.

## Completion Criteria
- Priority documentation gaps filled.
- All documented behaviors verified against code.
- Code examples compile/run.
