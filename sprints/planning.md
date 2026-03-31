# Planning Sprint — Project Bootstrap

> **Version:** 1.0.0

## Purpose
First sprint for any new project. Produces the foundational research, architecture,
scaffolding, and initial sprint queue that all subsequent work builds on. The Manager
always deploys this sprint before any other.

## Tasks

### Task 1: Competitive & Prior-Art Research
- **Worker:** researcher
- **Input:** MISSION.md (project goals, domain, target users)
- **Process:**
  1. Search for existing products/libraries that solve similar problems.
  2. Identify 3–5 comparable projects and document their approach.
  3. Note architectural patterns, tech choices, and pitfalls observed.
  4. Identify reusable libraries/tools that could accelerate development.
- **Output:** Research report (markdown) with comparison table, recommended patterns, and dependency shortlist.
- **Verification:** Report contains at least 3 comparable projects with cited sources. Each recommendation includes a rationale.

### Task 2: Architecture Design
- **Worker:** architect
- **Input:** Research report from Task 1 + MISSION.md
- **Process:**
  1. Define the system architecture (components, data flow, boundaries).
  2. Select the tech stack with justification.
  3. Design the directory structure.
  4. Define key interfaces and contracts (APIs, types, protocols).
  5. Identify technical risks and mitigation strategies.
- **Output:** Architecture document with diagrams (mermaid/ASCII), file tree, interface definitions, and risk register.
- **Verification:** Architecture covers all features in MISSION.md. Every component has defined inputs/outputs. Tech stack choices reference findings from Task 1.

### Task 3: Project Scaffolding
- **Worker:** coder
- **Input:** Architecture document from Task 2
- **Process:**
  1. Initialize the project (package.json, pyproject.toml, Cargo.toml, etc.).
  2. Create the directory structure from the architecture doc.
  3. Set up build tooling, linting, formatting, type-checking.
  4. Create placeholder files for key modules with interface stubs.
  5. Set up the test framework with a single passing smoke test.
  6. Initialize git with a clean first commit.
- **Output:** Working project scaffold that builds, lints, and passes its smoke test.
- **Verification:** `validate.sh baseline` passes. The project builds. The smoke test runs. Directory structure matches the architecture doc.

### Task 4: Sprint Queue Population
- **Worker:** architect
- **Input:** MISSION.md + Architecture document + scaffolded project
- **Process:**
  1. Break down every feature/requirement in MISSION.md into implementable units.
  2. Order by dependency (foundational pieces first) then priority.
  3. For each item, define: type, priority, acceptance criteria, estimated files, size.
  4. Identify which sprint templates from the library each task maps to.
- **Output:** Populated `state/SPRINT_QUEUE.md` with fully specified items.
- **Verification:** Every requirement in MISSION.md maps to at least one sprint item. Items are ordered so no item depends on a later item. Each item has concrete acceptance criteria.

### Task 5: Planning Verification
- **Worker:** reviewer
- **Input:** All outputs from Tasks 1–4
- **Process:**
  1. Check architecture against MISSION.md — does it cover all requirements?
  2. Check scaffold against architecture — does the code match the design?
  3. Check sprint queue against architecture — does the queue build what was designed?
  4. Verify there are no orphaned requirements (in MISSION but not in queue).
  5. Verify there are no orphaned queue items (in queue but not justified by MISSION).
- **Output:** Verification report with pass/fail per check and specific findings.
- **Verification:** Cross-reference check between MISSION → architecture → scaffold → queue. All links verified.

## Completion Criteria
- Architecture document exists and covers all MISSION.md requirements.
- Project scaffold builds, lints, and passes smoke test.
- Sprint queue contains at least one item per MISSION.md requirement.
- Verification report shows all cross-references are valid.
