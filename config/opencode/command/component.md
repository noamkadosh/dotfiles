---
description: Generate React component with TypeScript, tests, and Storybook story
agent: build
temperature: 0.2
---

Create React component: **$COMPONENT_NAME**

$ARGUMENTS

## Generate

1. `$COMPONENT_NAME.tsx` - TypeScript component with props interface
2. `$COMPONENT_NAME.module.css` - Styles
3. `$COMPONENT_NAME.stories.tsx` - Storybook with variants
4. `$COMPONENT_NAME.test.tsx` - Unit tests with RTL

Check existing patterns:
!ls src/components/*/index.tsx | head -3

Place in `@components/`
