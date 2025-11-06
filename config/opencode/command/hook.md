---
description: Generate custom React hook with TypeScript and tests
agent: build
temperature: 0.2
---

Create hook: **$HOOK_NAME**

$ARGUMENTS

## Generate

1. `hooks/$HOOK_NAME.ts` - Hook with TypeScript, JSDoc, generics
2. `hooks/$HOOK_NAME.test.ts` - Tests with @testing-library/react-hooks

Must start with `use`. Check patterns:
!grep "^export function use" src/hooks/*.ts | head -3
