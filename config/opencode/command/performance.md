---
description: Analyze and optimize performance issues
agent: build
temperature: 0.2
---

Analyze performance: **@$FILE_PATH**

$ARGUMENTS

## Analysis Areas

**Frontend**: Re-renders, bundle size, Core Web Vitals (FCP, LCP, CLS)  
**Backend**: N+1 queries, missing indexes, slow endpoints, caching  
**Network**: Request count, payload size, CDN usage

## Check

Bundle size:
!npm run build -- --stats

Slow queries:
!grep "SLOW" logs/*.log | tail -10

## Output Format

### Issues Found

**Critical** (>2s or >90% resources):
- Issue, location, measurement

**High** (>1s or >70% resources):
- Issue with impact

### Recommendations

**Quick wins** (easy + high impact):
- Fix with expected improvement

**Medium effort**:
- Implementation approach

### Expected Results

Specific targets for response time, resource usage, user experience.
**Resource Usage:**
- Memory leaks
- CPU intensive operations
- File handle leaks

### 3. Network Performance

- Number of requests
- Request payload size
- Response size
- Caching strategy
- CDN usage

## Performance Profiling

**Frontend:**
```typescript
// Profile React rendering
import { Profiler } from 'react';

<Profiler id="Component" onRender={logRenderTime}>
  <Component />
</Profiler>

// Measure specific operations
console.time('expensive-operation');
const result = expensiveOperation();
console.timeEnd('expensive-operation');
```

**Backend:**
```typescript
// Profile database queries
const start = Date.now();
const result = await db.query(sql);
const duration = Date.now() - start;
if (duration > 100) {
  logger.warn(`Slow query: ${duration}ms`);
}
```

**Database:**
```sql
-- Analyze query performance
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'test@example.com';
```

## Output Format

### Performance Issues Found

**Critical (>2s response time or >90% resource usage):**
1. Issue description
   - Location: file:line
   - Impact: Users affected, severity
   - Measurement: Current vs expected performance

**High (>1s response time or >70% resource usage):**
1. Issue description

**Medium (>500ms response time or >50% resource usage):**
1. Issue description

### Optimization Recommendations

#### Quick Wins (Easy + High Impact)
1. Recommendation with expected improvement
2. Code example

#### Medium Effort
1. Recommendation
2. Implementation approach

#### Long-term Improvements
1. Architectural changes
2. Infrastructure upgrades

### Implementation Plan

For each optimization:
```typescript
// Before (slow)
const users = await Promise.all(
  ids.map(id => db.users.findById(id))
); // N queries

// After (fast)
const users = await db.users.findByIds(ids); // 1 query

// Expected improvement: 90% faster for 10+ users
```

### Monitoring Recommendations

- Metrics to track
- Alerts to set up
- Performance budgets

## Benchmarking

```bash
# Frontend
!npm run build
# Check bundle size

# Backend
!npm test -- --coverage
# Check test performance

# Load testing (if applicable)
!npx autocannon http://localhost:3000/api/endpoint
```

## Expected Results

- Specific performance targets
- Response time goals
- Resource usage limits
- User experience improvements
