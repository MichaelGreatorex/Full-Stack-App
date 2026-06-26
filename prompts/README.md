# Prompts

This directory contains the LLM prompt templates used by the AI Interview Coach backend.

## Structure

```
prompts/
├── cv_analysis.md         → Prompt for extracting structured data from a CV
├── jd_analysis.md         → Prompt for parsing job descriptions
├── question_generation.md → Prompt for generating interview questions
├── answer_evaluation.md   → Prompt for scoring and evaluating candidate answers
└── feedback.md            → Prompt for generating structured feedback reports
```

## Guidelines

- Prompts use `{variable}` placeholders for runtime values injected by the backend.
- Keep prompts modular and focused on a single responsibility.
- Version significant prompt changes alongside the code that depends on them.

> **Note:** This directory is a placeholder. Prompt templates will be added in a subsequent PR.
