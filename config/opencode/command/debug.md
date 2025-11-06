---
description: Analyze and debug an issue with root cause analysis
agent: debugger
temperature: 0.1
---

Debug issue: $ARGUMENTS

## Recent Changes

Check git history:
```
!git log --oneline -10
```

## Investigation

1. **Reproduce**: Analyze error/symptom, verify across environments
2. **Analyze**: Review code paths, check common issues
3. **Root Cause**: Identify exact cause

## Output Format

### Summary
Brief description of issue.

### Root Cause
Detailed explanation of what's causing it and why.

### Location
Files and line numbers affected.

### Fix
Proposed solution:

```typescript
// Before (problematic)
const user = users.find(u => u.id === id);
return user.email; // Fails if undefined

// After (fixed)
const user = users.find(u => u.id === id);
if (!user) throw new NotFoundException();
return user.email;
```

### Testing
How to verify the fix works.

### Prevention
How to prevent similar issues.

### Priority
- **Critical**: System down, data loss
- **High**: Major functionality broken
- **Medium**: Feature impaired
- **Low**: Minor inconvenience
