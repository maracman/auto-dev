# Content Analysis Validation Sprint — Copy & Documentation Quality

> **Version:** 1.0.0

## Purpose
Validation sprint that reviews all user-facing content (UI copy, error messages,
documentation, help text) for quality, consistency, accuracy, and tone.

## Tasks

### Task 1: Content Inventory
- **Worker:** researcher
- **Input:** Codebase (UI strings, error messages, docs, README, help text)
- **Process:**
  1. Extract all user-facing strings from the codebase.
  2. Inventory documentation files.
  3. Categorize: UI labels, error messages, help text, marketing copy, technical docs.
  4. Note any existing style guide or tone guidelines.
- **Output:** Content inventory organized by category and location.
- **Verification:** All user-facing string sources identified.

### Task 2: Quality Review
- **Worker:** writer
- **Input:** Content inventory from Task 1
- **Process:**
  1. Check for spelling and grammar errors.
  2. Check for consistency (same concept uses same terminology everywhere).
  3. Check error messages: are they helpful? Do they explain what went wrong and how to fix it?
  4. Check tone: appropriate for the audience? Consistent throughout?
  5. Check for placeholder text, TODO comments in user-facing copy, or lorem ipsum.
  6. Check technical accuracy of documentation against actual code behavior.
- **Output:** Content findings report with location, issue, severity, and suggested fix.
- **Verification:** Each finding references the specific string/file and line.

### Task 3: Verdict
- **Worker:** reviewer
- **Input:** Findings report + `project/validation-criteria.md`
- **Process:**
  1. Count issues by severity.
  2. Compare against project-specific content quality thresholds.
  3. Identify the most impactful issues (user-facing errors > internal docs).
  4. Render verdict.
- **Output:** Content quality verdict with issue counts and threshold comparison.
- **Verification:** Verdict references specific thresholds. Issues prioritized by user impact.

## Scoring Rubric

**Inputs from `project/validation-criteria.md`:**
- `max_spelling_grammar_errors` (default: 0)
- `max_placeholder_text` (default: 0)
- `max_undocumented_public_apis` (default: 0)
- `max_inconsistency_issues` (per project)

**Score calculation:**
```
spelling_grammar  = count of spelling/grammar errors
placeholders      = count of TODO/lorem/placeholder in user-facing text
undocumented_apis = count of public APIs without docs
inconsistencies   = count of terminology/tone inconsistencies
inaccuracies      = count of docs that don't match code behavior

PASS if:  spelling_grammar  <= max_spelling_grammar_errors
      AND placeholders      <= max_placeholder_text
      AND undocumented_apis <= max_undocumented_public_apis
      AND inaccuracies      == 0

PARTIAL if: inaccuracies == 0 but other thresholds exceeded

FAIL if: inaccuracies > 0 (docs that lie about behavior are always a fail)
```

**Reported metrics (for SPRINT_LOG.md):**
| Metric | Value |
|--------|-------|
| Content items reviewed | {count} |
| Spelling/grammar errors | {count} / max {threshold} |
| Placeholder text found | {count} / max {threshold} |
| Undocumented public APIs | {count} / max {threshold} |
| Terminology inconsistencies | {count} |
| Accuracy errors (docs ≠ code) | {count} (zero tolerance) |
| **Verdict** | PASS / PARTIAL / FAIL |

## Completion Criteria
- All user-facing content reviewed.
- Issues documented with specific locations and fixes.
- Scoring rubric applied with numeric verdict.
- Critical issues generate remediation sprint items.
