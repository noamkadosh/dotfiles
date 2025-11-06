---
description: Generate Playwright E2E tests for complete user flows
agent: test-expert
temperature: 0.1
---

Generate E2E tests for: **$FEATURE_NAME**

$ARGUMENTS

## Requirements

- Complete user flow (happy path + errors)
- Page object pattern for reusable selectors
- Setup/teardown with test data
- Assertions at each step
- Screenshots on failure (automatic)

Place in `tests/e2e/` or `e2e/`
  });

  test.afterEach(async ({ page }) => {
    // Cleanup test data
  });
});
```

## Page Object Pattern (if needed)

```typescript
class FeaturePage {
  constructor(private page: Page) {}

  async navigate() {
    await this.page.goto('/feature');
  }

  async fillForm(data: FormData) {
    await this.page.fill('input[name="email"]', data.email);
    await this.page.fill('input[name="password"]', data.password);
  }

  async submit() {
    await this.page.click('button[type="submit"]');
  }

  async expectSuccess() {
    await expect(this.page).toHaveURL('/success');
  }
}
```

## Test Coverage

- Happy path (success scenario)
- Validation errors
- Authentication failures
- Network errors (mock failed requests)
- Loading states
- Empty states

## Additional Context

$ARGUMENTS

Place tests in `tests/e2e/` directory.
