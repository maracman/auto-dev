# Design-Audition Sprint — UI/UX Design Competition

> **Version:** 1.1.0

## Purpose
Sprint for exploring and selecting a UI design direction through model competition.
Multiple models (or the same model with different prompts) each produce a complete
design variation independently. A review panel evaluates the entries blind, selects
a winner, and produces an implementation-ready spec.

This approach was developed because single-model design exploration tends to produce
variations that are too similar. Running different models against the same brief
produces genuinely distinct approaches — different layout paradigms, color theories,
and interaction patterns.

## Tasks

### Task 1: Design Requirements
- **Worker:** architect
- **Input:** Sprint item (what needs designing) + existing design system if any
- **Process:**
  1. Define functional requirements (what the UI must do).
  2. Define constraints (existing design system, brand guidelines, viewports).
  3. Define evaluation criteria (accessibility, consistency, performance, simplicity).
  4. Identify reference points from competitive research if available.
  5. Select 2–4 models from `intelligence/model-competencies.md` to compete.
     Prefer models with different strengths (e.g., one vision-strong, one code-strong).
- **Output:** Design brief with requirements, constraints, criteria, references, and
  list of competing models.
- **Verification:** Brief covers all functional needs. At least 2 competing models selected.

### Task 2: Design Variations (parallel)
- **Worker:** ui-designer (run once per competing model)
- **Input:** Design brief from Task 1 (identical brief to each model)
- **Process:**
  1. Each competing model receives the same brief independently.
  2. Each produces a self-contained HTML file viewable in any browser.
  3. Each variation includes mobile (375px) and desktop (1280px) layouts.
  4. Follow accessibility requirements (semantic HTML, ARIA, contrast).
  5. Variations are labeled by model alias (e.g., `design/variation-surgeon.html`).
- **Output:** HTML mockup files in `design/` directory, one per competing model.
- **Verification:** Files render correctly. Both viewports covered. Variations are
  genuinely distinct (not trivial color swaps).

### Task 3: Comparative Evaluation
- **Worker:** reviewer (use a model not involved in the competition)
- **Input:** Design brief + all variation HTML files
- **Process:**
  1. Evaluate each variation against every criterion from the brief.
  2. Score each criterion per variation on a consistent scale.
  3. Rank variations overall with justification.
  4. Identify the strongest variation as the winner.
  5. Note any elements from losing variations worth incorporating into the winner.
  6. Record which model produced each variation and note any model-specific patterns
     (e.g., "Model X consistently produces better responsive layouts").
- **Output:** Comparison table with scores, ranking, winner declaration, and
  cherry-pick recommendations.
- **Verification:** Every criterion scored for every variation. Winner justified.
  Model performance notes included for Main's `intelligence/` files.

### Task 4: Design Specification
- **Worker:** writer
- **Input:** Winning variation + comparison evaluation + cherry-pick recommendations
- **Process:**
  1. Document the chosen design: layout, components, spacing, colors, typography.
  2. Reference the winning mockup file path.
  3. Incorporate cherry-picked elements from losing variations.
  4. Break the design into implementable phases (foundation → layout → components → polish).
  5. Write implementation notes for the coder, including CSS tokens, font stacks,
     and component hierarchy.
- **Output:** DESIGN_SPEC.md + DESIGN_TASKS.md (phased implementation plan) ready
  for feature-dev sprints.
- **Verification:** Spec is specific enough that a coder can implement without design
  ambiguity. Phases have clear dependency order.

## Completion Criteria
- At least 2 model-produced variations compared.
- Winning design selected with scored comparison and documented rationale.
- DESIGN_SPEC.md complete and implementation-ready.
- DESIGN_TASKS.md breaks implementation into ordered phases.
- Model performance observations captured for Main's intelligence files.
