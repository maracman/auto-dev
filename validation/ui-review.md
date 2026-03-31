# UI Review Validation Sprint — Visual & Interaction Verification

> **Version:** 1.0.0

## Purpose
Validation sprint that verifies the UI against design specs, responsiveness
requirements, and interaction quality. Metrics defined in `project/validation-criteria.md`.

## Tasks

### Task 1: Visual Inventory
- **Worker:** ui-designer
- **Input:** List of UI pages/components + design specs (if available)
- **Process:**
  1. Capture screenshots of every page/component at:
     - Mobile (375px)
     - Tablet (768px)
     - Desktop (1280px)
  2. Document current visual state of each.
  3. Compare against design specs if available; note discrepancies.
- **Output:** Screenshot inventory with viewport labels and discrepancy notes.
- **Verification:** Every page/component captured at all three viewports.

### Task 2: Interaction Testing
- **Worker:** qa-engineer
- **Input:** Visual inventory + UI component list
- **Process:**
  1. Test every interactive element (buttons, links, forms, modals, dropdowns).
  2. Test keyboard navigation: tab order, focus indicators, keyboard shortcuts.
  3. Test loading states, empty states, and error states.
  4. Test responsive behavior: does layout adapt correctly across breakpoints?
  5. Test animations and transitions: smooth, performant, no jank?
- **Output:** Interaction test results with pass/fail per element and viewport.
- **Verification:** Every interactive element tested. Keyboard navigation verified.

### Task 3: Performance & Accessibility Check
- **Worker:** qa-engineer
- **Input:** UI pages
- **Process:**
  1. Run Lighthouse or equivalent for performance metrics.
  2. Run accessibility scanner for WCAG violations.
  3. Check for render-blocking resources, large layout shifts, slow paints.
  4. Measure time to interactive for key pages.
- **Output:** Performance scores + accessibility violation count.
- **Verification:** Metrics captured with tool output.

### Task 4: Verdict
- **Worker:** reviewer
- **Input:** All outputs from Tasks 1-3 + `project/validation-criteria.md`
- **Process:**
  1. Compare visual discrepancies against acceptable tolerance.
  2. Compare interaction failures against acceptable failure count.
  3. Compare performance scores against target thresholds.
  4. Compare accessibility violations against target.
  5. Render overall pass/fail verdict.
- **Output:** UI review verdict with metric-by-metric comparison against criteria.
- **Verification:** Verdict references specific metrics and thresholds from validation criteria.

## Scoring Rubric

**Inputs from `project/validation-criteria.md`:**
- `min_lighthouse_performance` (e.g., 90)
- `min_lighthouse_accessibility` (e.g., 95)
- `max_visual_discrepancies` (e.g., 3)
- `max_interaction_failures` (e.g., 0)
- `required_viewports` (e.g., [375, 768, 1280])

**Score calculation:**
```
visual_score       = 1 - (visual_discrepancies / total_components)
interaction_score  = 1 - (interaction_failures / total_interactive_elements)
performance_score  = lighthouse_performance / 100
accessibility_score = lighthouse_accessibility / 100

composite = (visual_score * 0.3) + (interaction_score * 0.3)
          + (performance_score * 0.2) + (accessibility_score * 0.2)

PASS if:    interaction_failures <= max_interaction_failures
        AND visual_discrepancies <= max_visual_discrepancies
        AND lighthouse_performance >= min_lighthouse_performance
        AND lighthouse_accessibility >= min_lighthouse_accessibility

PARTIAL if: composite >= 0.7 but one or more thresholds missed

FAIL if:    composite < 0.7
```

**Reported metrics (for SPRINT_LOG.md):**
| Metric | Value |
|--------|-------|
| Pages/components tested | {count} |
| Viewports covered | {list} |
| Visual discrepancies | {count} / max {threshold} |
| Interaction failures | {count} / max {threshold} |
| Lighthouse performance | {score} / min {threshold} |
| Lighthouse accessibility | {score} / min {threshold} |
| Composite score | {0.0–1.0} |
| **Verdict** | PASS / PARTIAL / FAIL |

## Completion Criteria
- All pages/components visually verified at all viewports.
- Interaction testing complete.
- Performance and accessibility scores captured.
- Scoring rubric applied with numeric verdict.
