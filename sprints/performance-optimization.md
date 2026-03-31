# Performance Optimization Sprint — Measured Improvement

> **Version:** 1.0.0

## Purpose
Sprint for identifying and fixing performance bottlenecks. Every optimization
must be measured before and after. No speculative optimization.

## Tasks

### Task 1: Profiling & Measurement
- **Worker:** qa-engineer
- **Input:** Performance concern (slow endpoint, high memory usage, sluggish UI)
- **Process:**
  1. Establish baseline measurements (response time, memory, CPU, render time).
  2. Profile the hot path to identify where time/resources are spent.
  3. Rank bottlenecks by impact (% of total time).
  4. Identify the top 3 optimization targets.
- **Output:** Performance profile with baseline numbers and ranked bottleneck list.
- **Verification:** Baseline numbers are reproducible. Profiling methodology documented.

### Task 2: Optimization Plan
- **Worker:** architect
- **Input:** Performance profile from Task 1
- **Process:**
  1. For each bottleneck, propose an optimization approach.
  2. Estimate expected improvement for each.
  3. Assess risk (could this break something? introduce complexity?).
  4. Order by effort-to-impact ratio.
- **Output:** Optimization plan with approach, expected gain, and risk per target.
- **Verification:** Each optimization references the specific bottleneck data from Task 1.

### Task 3: Implementation
- **Worker:** coder
- **Input:** Optimization plan from Task 2
- **Process:**
  1. Implement optimizations one at a time.
  2. Run tests after each change to catch regressions.
  3. Measure the specific metric after each change.
  4. If a change doesn't improve things, revert it.
- **Output:** Optimized code + per-change measurement results.
- **Verification:** Each kept change shows measurable improvement. All tests pass.

### Task 4: Verification
- **Worker:** qa-engineer
- **Input:** Optimized code + original baseline from Task 1
- **Process:**
  1. Re-run the exact same benchmark/profile from Task 1.
  2. Compare before and after numbers.
  3. Verify no regressions in correctness (all tests pass).
  4. Stress test if applicable (high concurrency, large data sets).
- **Output:** Before/after comparison table with percentage improvements.
- **Verification:** Measurements are reproducible. Improvement is real, not noise.

## Completion Criteria
- Measurable performance improvement documented with before/after data.
- All tests still pass.
- No speculative optimizations — every change backed by profiling data.
