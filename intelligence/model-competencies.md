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

> Fill in with your available models. Example entries below.

### {model-alias-1}
- **Provider:** {provider}
- **Canonical:** {model-string}
- **Strengths:** {competencies rated "strong"}
- **Weaknesses:** {competencies rated "weak"}
- **Default assignment:** {which worker role(s)}
- **Cost tier:** low | medium | high
- **Context window:** {tokens}

### {model-alias-2}
- **Provider:** {provider}
- **Canonical:** {model-string}
- **Strengths:** {list}
- **Weaknesses:** {list}
- **Default assignment:** {role(s)}
- **Cost tier:** {tier}
- **Context window:** {tokens}

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
