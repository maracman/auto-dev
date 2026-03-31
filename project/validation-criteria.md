# Validation Criteria

> Project-specific thresholds and test data for validation sprints.
> Set by the human. The Main agent decides which validation sprints to run
> and may suggest changes, but only the human edits this file.

## Test Suite Thresholds

| Metric | Minimum | Target | Notes |
|--------|---------|--------|-------|
| Unit test pass rate | 100% | 100% | No failing unit tests allowed |
| Integration test pass rate | 95% | 100% | Some flakiness tolerated at minimum |
| Test coverage (lines) | {x}% | {y}% | Measured by {tool} |
| Test coverage (branches) | {x}% | {y}% | |

## Code Quality Thresholds

| Metric | Maximum | Target | Notes |
|--------|---------|--------|-------|
| Lint warnings | {n} | 0 | |
| Type errors | 0 | 0 | No type errors ever |
| Cyclomatic complexity (per function) | {n} | {n} | |
| File size (lines) | {n} | {n} | |

## Performance Thresholds

| Metric | Maximum | Target | Notes |
|--------|---------|--------|-------|
| Page load (LCP) | {x}s | {y}s | |
| Time to interactive | {x}s | {y}s | |
| API response time (p95) | {x}ms | {y}ms | |
| Memory usage | {x}MB | {y}MB | |
| Bundle size | {x}KB | {y}KB | |

## UI/Visual Thresholds

| Metric | Requirement | Notes |
|--------|------------|-------|
| WCAG compliance | AA | |
| Supported viewports | 375px, 768px, 1280px | |
| Visual regression tolerance | {x}% pixel diff | |
| Lighthouse performance score | >{n} | |
| Lighthouse accessibility score | >{n} | |

## Content Quality Thresholds

| Metric | Maximum | Notes |
|--------|---------|-------|
| Spelling/grammar errors | 0 | |
| Placeholder/TODO in user-facing text | 0 | |
| Undocumented public APIs | 0 | |

## Competitive Thresholds

| Metric | Requirement | Notes |
|--------|------------|-------|
| Table-stakes feature coverage | 100% | All must-have features implemented |
| Quality parity with top competitor | ≥80% | Subjective, assessed by board-of-examiners |

## Bug-Check Thresholds

| Metric | Maximum | Notes |
|--------|---------|-------|
| Critical bugs | 0 | Crashes, data corruption, security holes |
| High-severity bugs | 0 | Incorrect output, silent failures |
| Medium-severity bugs | {n} | Graceless degradation, missing validation |

## Custom Thresholds

{Add project-specific validation thresholds here.}

---

*This file is set by the human. No agent may modify it.*
