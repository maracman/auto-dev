# auto-dev

**A self-improving software development pipeline, run by AI agents.**

Inspired by [karpathy/autoresearch](https://github.com/karpathy/autoresearch) — where an AI agent autonomously improves a training script overnight — **auto-dev** applies the same principle to software engineering. But instead of one agent modifying one file, it's a four-tier hierarchy of specialized agents running structured sprints, with a meta-agent that improves the pipeline itself over time.

Auto-dev is a **skill**, not a framework. It's a set of markdown files you drop into any agentic coding harness. No runtime, no server, no database — just markdown, bash, and git.

---

## Why auto-dev?

A single large model in an agentic loop is the default approach to AI-assisted development. It works — until it doesn't. Context windows fill up, the model drifts off task, costs balloon, and you have no visibility into what went wrong. Auto-dev takes a different approach.

### The pipeline improves itself

This is the core idea. The Main agent watches every sprint's metrics — success rates, retry counts, token usage, blocker patterns — and makes targeted changes to agent profiles, sprint templates, and model assignments based on evidence. Bad changes are reverted. Good changes compound. The factory gets better every time it runs, without human intervention.

### Smaller models, used where they're strongest

You don't need a frontier model for every task. A researcher needs broad knowledge. A coder needs precise syntax. A reviewer needs critical reasoning. Auto-dev assigns each worker the model best suited to its role, exploiting the specialized strengths of smaller, cheaper models rather than paying for one large model to do everything adequately.

### Agents only see what they need

Each worker receives only the context relevant to its task — not the full codebase, not the conversation history, not every prior decision. This keeps agents focused and accurate, avoids context window pollution, and means the framework works regardless of model context window size.

### Agents stay on track

Structured sprints with defined inputs, outputs, and verification steps prevent the drift that plagues long-running single-agent sessions. Each task has a clear scope, a specific worker, and an evidence-based acceptance check. Three strikes and a task escalates — no infinite loops.

### Projects break into manageable chunks

Instead of asking one model to hold an entire project in its head, auto-dev decomposes work into sprints and tasks that each fit comfortably within a single agent's capabilities. The Orchestrator chains outputs between tasks, so context flows through the pipeline without any one agent needing to hold it all.

### Cost scales with complexity, not with context

Smaller models cost less per token. Short, focused contexts mean fewer tokens per call. Parallel workers don't duplicate each other's context. The result: total cost can be a fraction of running a frontier model in a long-running agentic loop, especially for larger projects.

### Every decision is auditable

Progress metrics, sprint logs, blocker reports, validation scores — everything is written to files you can read. When something goes wrong, you can trace exactly which agent, model, sprint, and task was responsible. Single-agent loops give you a chat transcript; auto-dev gives you an audit trail.

### Mix and match models and providers

Agent profiles define roles, not models. Swap in a new model for a specific worker and measure whether it improves results. Run your researcher on one provider and your coder on another. The pipeline's versioned metrics make model comparisons empirical, not anecdotal.

---

## Architecture

### Agent Hierarchy

Four layers. Each layer has a single, clear responsibility. Information flows down as instructions and up as results.

```mermaid
graph TD
    H["👤 Human"] -->|"MISSION.md\nvalidation-criteria.md"| M

    subgraph "auto-dev pipeline"
        M["🔵 Main Agent\n━━━━━━━━━━━━━━━\nPipeline Architect\n• Selects & creates sprints\n• Tunes agent profiles\n• Reassigns models\n• Evolves the system"]

        M -->|"sprint plan +\nvalidation strategy"| MGR

        MGR["🟢 Manager Agent\n━━━━━━━━━━━━━━━\nProject Driver\n• Contextualizes sprints\n• Reviews output\n• Manages queue\n• Runs validation cascade"]

        MGR -->|"contextualized\nsprint"| O

        O["🟡 Orchestrator Agent\n━━━━━━━━━━━━━━━\nSequence Executor\n• Chains task outputs\n• Dispatches to workers\n• Manages retries\n• Returns results"]

        O -->|"task + context"| W

        W["⚪ Worker Agents\n━━━━━━━━━━━━━━━\nSpecialists\n• researcher · architect\n• coder · writer\n• ui-designer · reviewer\n• qa-engineer"]
    end

    W -->|"task output\n+ evidence"| O
    O -->|"completed sprint\n+ verification"| MGR
    MGR -->|"escalations +\nperformance data"| M

    style M fill:#1e3a5f,stroke:#4a9eff,color:#fff
    style MGR fill:#1a4a2a,stroke:#4aff7f,color:#fff
    style O fill:#4a3a1a,stroke:#ffcc4a,color:#fff
    style W fill:#3a3a3a,stroke:#aaa,color:#fff
    style H fill:#555,stroke:#aaa,color:#fff
```

### What Each Agent Owns

| Agent | Reads | Writes | Decides |
|-------|-------|--------|---------|
| **Main** | Everything | `agents/`, `sprints/`, `validation/`, `intelligence/`, `validate.sh`, `program.md` | Sprint templates, agent profiles, model assignments, validation strategies |
| **Manager** | `project/`, `state/`, sprint library | `state/SPRINT_QUEUE.md`, `state/PROJECT_STATE.md`, `state/BLOCKER_REPORT.md`, `state/progress.tsv` | Which sprint to run next, accept/reject output, when to escalate |
| **Orchestrator** | Assigned sprint, relevant `state/PROJECT_STATE.md` sections | Task-level logs | Task dispatch order, retry decisions, context passed to workers |
| **Workers** | Task input + their `agent.md` profile | Task output artifacts (code, docs, tests, reports) | Implementation details within their task scope |

---

## System Flow

### Initialization → Delivery → Improvement

The full lifecycle from a new project to continuous improvement:

```mermaid
flowchart TB
    subgraph INIT ["① Initialization (Main Agent)"]
        direction TB
        A1["Read MISSION.md"] --> A2["Scan sprint library"]
        A2 --> A3{"Gaps in\nlibrary?"}
        A3 -->|Yes| A4["Author new\nsprint templates"]
        A3 -->|No| A5["Select relevant\nsprints"]
        A4 --> A5
        A5 --> A6["Determine validation\nstrategy"]
        A6 --> A7["Hand off to Manager:\nsprint plan + validation strategy"]
    end

    subgraph DEV ["② Development Loop (Manager → Orchestrator → Workers)"]
        direction TB
        B1["Deploy planning sprint"] --> B2["Orchestrator executes:\nresearch → architecture →\nscaffold → populate queue"]
        B2 --> B3["Manager reviews output"]
        B3 --> B4["Deploy next dev sprint\nfrom queue"]
        B4 --> B5["Orchestrator executes:\ntask₁ → task₂ → ... → taskₙ"]
        B5 --> B6["Manager reviews:\ncheck evidence, verify criteria"]
        B6 --> B7{"Accept?"}
        B7 -->|Yes| B8{"Queue\nempty?"}
        B7 -->|No| B9["Add corrective\ntasks to queue"]
        B9 --> B4
        B8 -->|No| B4
        B8 -->|Yes| B10["Enter validation phase"]
    end

    subgraph VAL ["③ Validation Phase (Manager)"]
        direction TB
        C1["Deploy validation sprints:\nbug-check, ui-review,\nmission-alignment, etc."] --> C2["Each validation sprint\nruns as full sprint\nwith workers + evidence"]
        C2 --> C3{"All\npass?"}
        C3 -->|No| C4["Generate remediation\nsprint items"]
        C4 --> C5["Return to dev loop"]
        C3 -->|Yes| C6["✅ Project complete"]
    end

    subgraph META ["④ Self-Improvement (Main Agent)"]
        direction TB
        D1["Read progress.tsv +\nblocker reports +\nerror ledger"] --> D2{"Pattern\ndetected?\n(≥3 occurrences)"}
        D2 -->|No| D3["Continue observing"]
        D2 -->|Yes| D4["Diagnose root cause"]
        D4 --> D5["Make ONE targeted change\n(sprint / profile / model)"]
        D5 --> D6["Log to pipeline-changelog.md"]
        D6 --> D7["Verify improvement\nnext run"]
        D7 --> D1
    end

    INIT --> DEV
    DEV --> VAL
    VAL -->|remediation| DEV
    C5 --> B4
    META -.->|"observes all phases"| DEV
    META -.->|"observes all phases"| VAL

    style INIT fill:#0d1b2a,stroke:#4a9eff,color:#fff
    style DEV fill:#0a1f0a,stroke:#4aff7f,color:#fff
    style VAL fill:#2a1f0a,stroke:#ffcc4a,color:#fff
    style META fill:#1a0a2a,stroke:#cc7fff,color:#fff
```

### Inside a Sprint

Every sprint — development or validation — follows the same execution pattern. The Orchestrator chains task outputs so each task builds on the last:

```mermaid
flowchart LR
    MGR["Manager\ncontextualizes\nsprint template"] --> T1

    subgraph SPRINT ["Sprint Execution (Orchestrator)"]
        T1["Task 1\n─────\nWorker: researcher\nInput: mission brief\nOutput: research report"]
        T2["Task 2\n─────\nWorker: architect\nInput: research report\nOutput: architecture doc"]
        T3["Task 3\n─────\nWorker: coder\nInput: architecture doc\nOutput: implemented code"]
        T4["Task 4\n─────\nWorker: reviewer\nInput: code + tests\nOutput: review verdict"]
        T5["Task 5: Verify\n─────\nWorker: qa-engineer\nInput: all outputs\nOutput: evidence bundle\n⚠ Anti-hallucination\n   safeguards enforced"]

        T1 -->|"output → input"| T2
        T2 -->|"output → input"| T3
        T3 -->|"output → input"| T4
        T4 -->|"output → input"| T5
    end

    T5 -->|"completed sprint\n+ evidence"| RET["Manager\nreviews"]

    style T5 fill:#4a1a1a,stroke:#ff6666,color:#fff
    style SPRINT fill:#1a1a2a,stroke:#666,color:#fff
```

### Escalation & Interior Validation

When things go wrong, the system has two mechanisms: the Manager's interior validation loop for tricky code sections, and escalation to Main for structural problems.

```mermaid
flowchart TD
    subgraph INTERIOR ["Manager: Interior Validation Loop"]
        direction TB
        I1["Tricky section\nkeeps failing"] --> I2["Constrain scope\nto that section only"]
        I2 --> I3["implement → verify →\niterate"]
        I3 --> I4{"Passes?"}
        I4 -->|Yes| I5["Continue sprint"]
        I4 -->|"No (≤5 retries)"| I3
        I4 -->|"No (>5 retries)"| I6["Log blocker"]
    end

    subgraph ESCALATION ["Manager → Main Escalation"]
        direction TB
        E1["No viable sprint\nexists for task"] --> E4
        E2["Sprint template\nconsistently failing"] --> E4
        E3["Worker/model\nunderperforming"] --> E4
        E4["Manager files\nescalation report"] --> E5["Main diagnoses\nroot cause"]
        E5 --> E6["Main makes\ntargeted change"]
        E6 --> E7["Hands back\nto Manager"]
    end

    I6 --> E4

    style INTERIOR fill:#1a2a1a,stroke:#4aff7f,color:#fff
    style ESCALATION fill:#0d1b2a,stroke:#4a9eff,color:#fff
```

---

## The Self-Improvement Loop

This is what separates auto-dev from a static pipeline. The Main agent watches everything and makes the factory better over time.

```mermaid
flowchart LR
    subgraph OBSERVE ["Observe"]
        O1["progress.tsv\n(metrics per sprint)"]
        O2["common-mistakes.md\n(error ledger)"]
        O3["BLOCKER_REPORT.md\n(stuck tasks)"]
    end

    subgraph ANALYZE ["Analyze"]
        A1{"Pattern?\n≥3 data points"}
    end

    subgraph DIAGNOSE ["Diagnose"]
        D1["Sprint structure?"]
        D2["Worker assignment?"]
        D3["Model choice?"]
        D4["Agent prompt?"]
        D5["Validation design?"]
    end

    subgraph ACT ["Act (one change)"]
        C1["Edit sprint template"]
        C2["Reassign worker model"]
        C3["Update agent profile"]
        C4["Modify validation sprint"]
        C5["Create new sprint type"]
    end

    subgraph LOG ["Log & Verify"]
        L1["pipeline-changelog.md\n• What changed\n• Why (evidence)\n• Expected impact\n• Verification plan"]
    end

    O1 --> A1
    O2 --> A1
    O3 --> A1
    A1 -->|Yes| D1
    A1 -->|Yes| D2
    A1 -->|Yes| D3
    A1 -->|Yes| D4
    A1 -->|Yes| D5
    D1 --> C1
    D2 --> C2
    D3 --> C2
    D4 --> C3
    D5 --> C4
    C1 --> L1
    C2 --> L1
    C3 --> L1
    C4 --> L1
    C5 --> L1

    style OBSERVE fill:#1a1a2a,stroke:#666,color:#fff
    style ANALYZE fill:#2a1a1a,stroke:#ff6666,color:#fff
    style DIAGNOSE fill:#1a2a2a,stroke:#66ccff,color:#fff
    style ACT fill:#1a2a1a,stroke:#66ff66,color:#fff
    style LOG fill:#2a2a1a,stroke:#ffcc66,color:#fff
```

**Main's improvement toolkit:**

| File | Purpose | Main Uses It To... |
|------|---------|--------------------|
| `intelligence/model-competencies.md` | Which models excel at what | Reassign workers to better models |
| `intelligence/common-mistakes.md` | Recurring error tally | Detect patterns before acting |
| `intelligence/pipeline-changelog.md` | Audit trail of all changes | Track what worked and what didn't |

---

## Repository Structure

```
auto-dev/
│
├── program.md                          ← Main agent instructions (the "brain")
│
├── agents/                             ← Agent profiles with roles + model assignments
│   ├── manager.md                         Project driver
│   ├── orchestrator.md                    Sequence executor
│   └── workers/
│       ├── researcher.md                  Research & analysis
│       ├── architect.md                   System design & planning
│       ├── coder.md                       Implementation
│       ├── writer.md                      Documentation & content
│       ├── ui-designer.md                 Interface design & visual
│       ├── reviewer.md                    Code review & quality gate
│       └── qa-engineer.md                 Testing & verification
│
├── sprints/                            ← Dev sprint library (project-agnostic)
│   ├── planning.md                        Bootstrap: research → arch → scaffold → queue
│   ├── feature-dev.md                     New feature implementation
│   ├── bug-fix.md                         Bug diagnosis and repair
│   ├── refactor.md                        Code improvement without behavior change
│   ├── design-audition.md                 UI/UX design exploration
│   ├── api-integration.md                 External service integration
│   ├── testing-harness.md                 Test infrastructure setup
│   ├── documentation.md                   Docs creation and update
│   ├── performance-optimization.md        Measured performance improvement
│   ├── security-audit.md                  Vulnerability assessment & remediation
│   ├── dependency-update.md               Safe dependency management
│   ├── ci-cd-setup.md                     CI/CD pipeline setup
│   ├── accessibility.md                   WCAG compliance audit & fix
│   └── database-migration.md              Schema change management
│
├── validation/                         ← Validation sprint library (project-agnostic)
│   ├── bug-check.md                       Edge-case & adversarial input testing
│   ├── ui-review.md                       Visual & interaction verification
│   ├── content-analysis.md                Copy & documentation quality
│   ├── competitor-analysis.md             Feature parity & differentiation
│   ├── mission-alignment.md               Goal fidelity check
│   └── board-of-examiners.md              Final multi-perspective panel review
│
├── intelligence/                       ← Main agent's self-improvement toolkit
│   ├── model-competencies.md              Model strengths/weaknesses matrix
│   ├── common-mistakes.md                 Recurring error ledger (tally-based)
│   └── pipeline-changelog.md              Audit trail of every pipeline change
│
├── project/                            ← Project-specific (human fills in)
│   ├── MISSION.md                         Goals, success metrics, constraints
│   └── validation-criteria.md             Pass/fail thresholds per validation type
│
├── state/                              ← Live runtime state (agents manage)
│   ├── SPRINT_QUEUE.md                    Active queue (Manager-populated)
│   ├── PROJECT_STATE.md                   Cumulative codebase knowledge
│   ├── BLOCKER_REPORT.md                  Stuck tasks awaiting escalation
│   ├── SPRINT_LOG.md                      Per-sprint outcomes (Manager writes)
│   ├── VALIDATION_LOG.md                  Detailed validation results + scores
│   └── progress.tsv                       Per-task metrics with versions (Orchestrator writes)
│
├── validate.sh                         ← Automated check runner (lint, test, build)
└── README.md
```

### What's Project-Agnostic vs Project-Specific

```mermaid
graph LR
    subgraph AGNOSTIC ["🔄 Project-Agnostic (reusable across all projects)"]
        S["sprints/\n14 dev templates"]
        V["validation/\n6 validation templates"]
        A["agents/\n9 agent profiles"]
        I["intelligence/\nself-improvement toolkit"]
    end

    subgraph SPECIFIC ["📌 Project-Specific (human provides)"]
        PM["MISSION.md\ngoals + constraints"]
        PV["validation-criteria.md\nthresholds + test data"]
    end

    subgraph STATE ["📊 Runtime State (agents manage)"]
        SQ["SPRINT_QUEUE.md"]
        PS["PROJECT_STATE.md"]
        BR["BLOCKER_REPORT.md"]
        PT["progress.tsv"]
    end

    SPECIFIC -->|"seeds"| STATE
    AGNOSTIC -->|"templates executed\nagainst"| STATE

    style AGNOSTIC fill:#1a2a1a,stroke:#4aff7f,color:#fff
    style SPECIFIC fill:#2a1a1a,stroke:#ff9966,color:#fff
    style STATE fill:#1a1a2a,stroke:#6699ff,color:#fff
```

The sprint templates and agent profiles are universal — they work for a React app, a CLI tool, an API server, or anything else. The Manager contextualizes them with project-specific details when deploying. Main can author new templates when gaps appear.

---

## Key Principles

### Short Context Discipline

Workers receive only what they need for their specific task. No full-codebase reads. The Orchestrator manages the context chain, passing relevant outputs between tasks. This keeps each agent fast and accurate regardless of model context window size.

### Evidence Over Prose

Every verification task requires concrete artifacts:

| Claim | Not Evidence | Evidence |
|-------|-------------|----------|
| "Bug is fixed" | Prose description | Failing test → now passes + diff |
| "UI looks correct" | "I checked it" | Screenshots at 375px + 1280px |
| "API integration works" | "Tested successfully" | Request/response logs + error handling proof |
| "Code is clean" | "Reviewed and approved" | Specific findings with line references |

### Anti-Hallucination Safeguards

Verification tasks guard against agents fabricating results:

- **Diff check** — does a file diff exist that matches the claimed change?
- **Test check** — does a test pass that didn't pass before?
- **Output check** — does the actual output match the claimed output?
- **Cross-agent verification** — a different agent independently confirms the claim
- **Board of Examiners rule** — every examiner must cite at least 2 weaknesses. Zero-weakness reviews are rejected as insufficiently rigorous.

### Escalation Protocol

Three strikes and move on. No infinite loops.

```
Attempt 1: Standard approach + default model
Attempt 2: Detailed failure context + alternate approach
Attempt 3: Simplified scope — can a smaller version work?
Blocked:   Log to BLOCKER_REPORT.md → escalate to Main → move on
```

### Metrics & Observability

Every action is tracked at two levels:

```mermaid
flowchart LR
    subgraph TASK ["Task Level (Orchestrator → progress.tsv)"]
        direction TB
        T1["Per task, per attempt\nworker, model, result,\ntests, lint, tokens, duration,\npipeline version, template version"]
    end

    subgraph SPRINT ["Sprint Level (Manager → SPRINT_LOG.md)"]
        direction TB
        S1["Per sprint\nverdict, metrics delta,\ntemplate + agent versions,\nworker/model combos,\nretries, interior loops"]
    end

    subgraph VALIDATION ["Validation Level (Manager → VALIDATION_LOG.md)"]
        direction TB
        V1["Per validation sprint\nmetric vs threshold,\nscoring rubric outcome,\nfindings by severity,\nremediation generated"]
    end

    subgraph META ["Meta Level (Main → intelligence/)"]
        direction TB
        M1["common-mistakes.md\n(error tallies)\npipeline-changelog.md\n(version audit trail)\nmodel-competencies.md\n(model ratings)"]
    end

    TASK --> SPRINT
    SPRINT --> VALIDATION
    TASK --> META
    SPRINT --> META
    VALIDATION --> META

    style TASK fill:#1a2a1a,stroke:#4aff7f,color:#fff
    style SPRINT fill:#1a1a2a,stroke:#6699ff,color:#fff
    style VALIDATION fill:#2a1a1a,stroke:#ff9966,color:#fff
    style META fill:#1a0a2a,stroke:#cc7fff,color:#fff
```

Main computes derived metrics (revert rate, retry rate, worker/model/sprint fail rates, tokens per success) and uses them to detect patterns before making pipeline changes.

### Versioning

Every mutable file has a `> **Version:** X.Y.Z` header. The Orchestrator logs both the pipeline version and the sprint template version with every task row in progress.tsv. This lets Main do version-correlated analysis:

```
# Did feature-dev v1.1.0 perform better than v1.0.0?
Filter progress.tsv by template_version, compare success rates

# Did the pipeline change from v1.2.0 → v1.3.0 improve things overall?
Filter progress.tsv by pipeline_version, compare all metrics

# Is bug-check validation getting stricter over versions?
Filter SPRINT_LOG.md by template version, compare score trajectories
```

Changes that worsen performance are reverted. The revert is versioned too (patch bump), so Main never tries the same failed change twice.

---

## Quick Start

```bash
# 1. Clone into your project
git clone https://github.com/yourname/auto-dev.git .auto-dev

# 2. Fill in project-specific files
#    project/MISSION.md — what you're building
#    project/validation-criteria.md — your quality thresholds
#    intelligence/model-competencies.md — your available models

# 3. (Optional) Create .auto-dev.env to override validation commands
#    See validate.sh for auto-detection or set LINT_CMD, UNIT_TEST_CMD, etc.

# 4. Point your Main agent at program.md and let it run
```

Works with any agentic harness: Claude Code, Cursor, Cline, OpenClaw, Aider, or custom setups. The agents are defined by their markdown profiles, not by any specific runtime.

---

## Sprint Library Reference

### Development Sprints

| Sprint | First Task | Key Workers | Use When |
|--------|-----------|-------------|----------|
| `planning` | Competitive research | researcher → architect → coder → reviewer | Starting a new project |
| `feature-dev` | Scope & acceptance | architect → qa-engineer → coder → reviewer | Adding new functionality |
| `bug-fix` | Reproduction | qa-engineer → reviewer → coder | Fixing a reported bug |
| `refactor` | Scope definition | architect → qa-engineer → coder | Improving code without behavior change |
| `design-audition` | Requirements | architect → ui-designer → reviewer → writer | Exploring UI directions |
| `api-integration` | API research | researcher → architect → coder → qa-engineer | Connecting to external services |
| `testing-harness` | Assessment | researcher → coder → qa-engineer | Setting up test infrastructure |
| `documentation` | Audit | researcher → writer → reviewer | Creating/updating docs |
| `performance-optimization` | Profiling | qa-engineer → architect → coder | Measured perf improvement |
| `security-audit` | Dependency scan | qa-engineer → reviewer → coder | Vulnerability assessment |
| `dependency-update` | Assessment | researcher → coder → qa-engineer | Safe dependency updates |
| `ci-cd-setup` | Pipeline design | architect → coder → qa-engineer | Build/deploy automation |
| `accessibility` | Audit | qa-engineer → coder | WCAG compliance |
| `database-migration` | Migration design | architect → coder → qa-engineer | Schema changes |

### Validation Sprints

| Sprint | What It Checks | Triggered By | Generates |
|--------|---------------|-------------|-----------|
| `bug-check` | Edge-case inputs, fringe data, adversarial patterns | After dev sprints complete | Remediation sprint items |
| `ui-review` | Visual fidelity, responsiveness, interaction quality | UI changes | Remediation sprint items |
| `content-analysis` | Spelling, consistency, tone, accuracy of all copy | Content changes | Remediation sprint items |
| `competitor-analysis` | Feature parity, differentiation, market readiness | Pre-release | Gap sprint items |
| `mission-alignment` | Does the product serve the stated mission? | Pre-release | Alignment gap items |
| `board-of-examiners` | Final multi-perspective panel review | Final gate | Blocking issues |

Main can create additional validation types per project (e.g., regulatory compliance, localization review, data integrity audit).

---

## Design Philosophy

The human defines the destination (`MISSION.md`) and the quality bar (`validation-criteria.md`). Everything else is the pipeline's job.

```
Human:        "Build X that meets these standards"
Main agent:   assembles the factory
Manager:      runs the factory
Orchestrator: manages the assembly line
Workers:      build the product
Main agent:   makes the factory better for next time
```

The system is **provider-agnostic** (agent profiles define roles, not models), **framework-free** (just markdown + bash + git), **self-contained** (no external services), **observable** (every action logged), and **self-improving** (Main evolves the pipeline based on measured evidence).

---

## License

MIT
