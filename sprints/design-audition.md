# Design-Audition Sprint — UI/UX Design Exploration

> **Version:** 1.0.0

## Purpose
Sprint for exploring and selecting a UI design direction. Produces competing
variations, evaluates them against criteria, and outputs a spec for implementation.

## Tasks

### Task 1: Design Requirements
- **Worker:** architect
- **Input:** Sprint item (what needs designing) + existing design system if any
- **Process:**
  1. Define functional requirements (what the UI must do).
  2. Define constraints (existing design system, brand guidelines, viewports).
  3. Define evaluation criteria (accessibility, consistency, performance, simplicity).
  4. Identify reference points from competitive research if available.
- **Output:** Design brief with requirements, constraints, criteria, and references.
- **Verification:** Brief covers all functional needs from the sprint item.

### Task 2: Variation Design
- **Worker:** ui-designer
- **Input:** Design brief from Task 1
- **Process:**
  1. Produce at least 2 distinct design variations.
  2. Each variation is a self-contained HTML file viewable in any browser.
  3. Each variation includes mobile (375px) and desktop (1280px) layouts.
  4. Follow accessibility requirements (semantic HTML, ARIA, contrast).
- **Output:** HTML mockup files in `design/` directory.
- **Verification:** Files render correctly. Both viewports covered. At least 2 distinct approaches.

### Task 3: Comparative Evaluation
- **Worker:** reviewer
- **Input:** Design brief + all variation HTML files
- **Process:**
  1. Evaluate each variation against every criterion from the brief.
  2. Score or rank each criterion per variation.
  3. Identify the strongest variation with justification.
  4. Note any elements from losing variations worth incorporating.
- **Output:** Comparison table + recommendation with rationale.
- **Verification:** Every criterion scored for every variation. Selection justified.

### Task 4: Design Specification
- **Worker:** writer
- **Input:** Winning variation + comparison evaluation
- **Process:**
  1. Document the chosen design: layout, components, spacing, colors, typography.
  2. Reference the mockup file paths.
  3. Note any adaptations from the comparison (cherry-picked elements).
  4. Write implementation notes for the coder.
- **Output:** DESIGN_SPEC.md ready for a feature-dev sprint.
- **Verification:** Spec is specific enough that a coder can implement without design ambiguity.

## Completion Criteria
- At least 2 variations produced and compared.
- Winning design selected with documented rationale.
- DESIGN_SPEC.md complete and implementation-ready.
