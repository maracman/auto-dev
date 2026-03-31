# Model Competencies Matrix

> Maintained by the Main agent. Updated based on observed performance and
> new model releases. Used to inform worker → model assignments.

## How to Read This

Each model is rated on task-specific competencies. Ratings are based on observed
performance in this pipeline, not general benchmarks. Main updates ratings based
on evidence from `state/progress.tsv` and `common-mistakes.md`.

Rating scale: strong | adequate | weak | untested

## Competency Matrix

| Competency | Best For | Notes |
|------------|----------|-------|
| **Code generation** | Coder worker | Measured by: test pass rate on first attempt, lint cleanliness |
| **Code review** | Reviewer worker | Measured by: issues caught that QA later confirms, false positive rate |
| **Reasoning / planning** | Architect, Manager | Measured by: quality of plans, sprint completion rate |
| **Search / research** | Researcher worker | Measured by: source quality, completeness, citation accuracy |
| **Prose / documentation** | Writer worker | Measured by: content analysis validation scores |
| **Vision / UI** | UI Designer worker | Measured by: UI review validation scores, design quality |
| **Testing / QA** | QA Engineer worker | Measured by: bugs found, false positive rate, test quality |
| **Long context** | Research-heavy tasks | Measured by: accuracy on tasks requiring large input processing |
| **Instruction following** | All workers | Measured by: output format compliance, task completion rate |
| **Speed** | Orchestrator, fast-iteration tasks | Measured by: tokens per second, time to completion |

## Model Roster

> Fill in with your available models. Below are example entries from a real
> deployment. Replace or extend with your own models and observed ratings.
> Main updates this roster as it observes performance and new models become
> available. Aliases make sprint templates and agent profiles readable without
> coupling to specific model strings.

### Surgeon
- **Provider:** OpenAI
- **Canonical:** `openai-codex/gpt-5.3-codex`
- **Strengths:** code generation (strong), instruction following (strong)
- **Weaknesses:** prose/documentation (weak), research (weak)
- **Default assignment:** coder (scaffolding, feature implementation)
- **Cost tier:** medium
- **Context window:** 128k

### Sprinter
- **Provider:** Google (via OpenRouter)
- **Canonical:** `openrouter/google/gemini-3-flash-preview`
- **Strengths:** speed (strong), long context (strong), research (adequate)
- **Weaknesses:** reasoning/planning (adequate), code review (weak)
- **Default assignment:** researcher, writer, unit test generation, orchestrator
- **Cost tier:** low
- **Context window:** 1M

### Lieutenant
- **Provider:** Anthropic
- **Canonical:** `anthropic/claude-sonnet-4-6`
- **Strengths:** reasoning/planning (strong), code review (strong), instruction following (strong)
- **Weaknesses:** speed (adequate)
- **Default assignment:** architect, reviewer, V3/V4 validation, manager
- **Cost tier:** medium
- **Context window:** 200k

### Scout
- **Provider:** DeepSeek (via OpenRouter)
- **Canonical:** `openrouter/deepseek/deepseek-chat`
- **Strengths:** code generation (strong), refactoring (strong), speed (strong)
- **Weaknesses:** vision/UI (weak), long-form prose (adequate)
- **Default assignment:** coder (refactoring), V1 validation
- **Cost tier:** low
- **Context window:** 128k

### Strategist
- **Provider:** OpenAI
- **Canonical:** `openai/gpt-5.4`
- **Strengths:** reasoning/planning (strong), vision/UI (strong), prose (strong)
- **Weaknesses:** speed (adequate)
- **Default assignment:** V4 strategic validation, design auditions, ui-designer
- **Cost tier:** high
- **Context window:** 128k

## Assignment Rules

1. Default to the cheapest model that is rated "adequate" or better for the task.
2. Escalate to a stronger model on second attempt after failure.
3. Never assign a model rated "weak" for a competency to a task requiring that competency.
4. For verification/review tasks, prefer a different model than the one that produced the work.
5. Track cost: Main should monitor total token spend and adjust if budget constraints exist.

## Update Log

| Date | Change | Evidence | Result |
|------|--------|----------|--------|
| — | — | — | — |

---

*This file is edited by the Main agent based on observed performance.*
