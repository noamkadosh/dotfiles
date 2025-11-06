---
description: Comprehensive code review for quality, security, and performance
agent: code-reviewer
temperature: 0.1
---

Review: **@$FILE_PATH**

## Context

$ARGUMENTS

## Review Checklist

**Code Quality**: Naming, abstraction, DRY, error handling  
**Functionality**: Solves problem, handles edge cases  
**Performance**: No obvious issues, efficient algorithms  
**Security**: Input validation, no hardcoded secrets  
**Testing**: Tests included, adequate coverage  
**Documentation**: Complex logic documented

## Output Format

### Summary
Brief overview of code quality.

### Strengths
- What's done well

### Issues

**[BLOCKING]** Critical issues:
- Issue with fix

**[HIGH]** Important issues:
- Issue with fix

**[MEDIUM]** Improvements:
- Suggestion

**[LOW]** Nice-to-have:
- Minor suggestion

### Recommendations
Overall recommendations and refactoring suggestions.

### Approval
□ Approved  
□ Approved with comments  
□ Request changes
