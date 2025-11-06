---
description: Create API endpoint with controller, service, DTOs, and tests
agent: build
temperature: 0.2
---

Create API endpoint: **$RESOURCE_NAME**

$ARGUMENTS

## Generate

1. `$RESOURCE_NAME.controller.ts` - CRUD routes with guards
2. `$RESOURCE_NAME.service.ts` - Business logic
3. `dto/create-$RESOURCE_NAME.dto.ts` - DTO with validation
4. `dto/update-$RESOURCE_NAME.dto.ts` - Update DTO
5. `$RESOURCE_NAME.module.ts` - Module registration
6. Tests for controller and service

RESTful: GET/POST/PUT/DELETE at `/api/v1/$RESOURCE_NAME`

Check patterns:
!ls src/**/*.controller.ts | head -3
