# Code Standards

Comprehensive coding standards for TypeScript, React, NestJS, and database code.

## General Principles

### SOLID Principles
- **S**ingle Responsibility: One class/function, one purpose
- **O**pen/Closed: Open for extension, closed for modification
- **L**iskov Substitution: Subtypes must be substitutable for base types
- **I**nterface Segregation: Many specific interfaces > one general
- **D**ependency Inversion: Depend on abstractions, not concretions

### DRY (Don't Repeat Yourself)
Extract repeated code into functions/utilities.

### KISS (Keep It Simple, Stupid)
Simplest solution that works wins.

### YAGNI (You Aren't Gonna Need It)
Don't build for hypothetical future needs.

## TypeScript Standards

### Type Safety
```typescript
// ❌ AVOID
function process(data: any) { ... }

// ✅ PREFER
function process(data: User) { ... }
// Or use unknown with type guards
function process(data: unknown) {
  if (isUser(data)) { ... }
}
```

### Explicit Types
```typescript
// ❌ IMPLICIT
function calculate(x, y) {
  return x + y;
}

// ✅ EXPLICIT
function calculate(x: number, y: number): number {
  return x + y;
}
```

### Interface vs Type
```typescript
// ✅ Use interface for objects (extendable)
interface User {
  id: string;
  email: string;
}

interface Admin extends User {
  role: 'admin';
}

// ✅ Use type for unions, primitives, tuples
type Status = 'pending' | 'approved' | 'rejected';
type Coordinates = [number, number];
```

### Naming Conventions
- **Interfaces**: PascalCase (`UserInterface` or `User`)
- **Types**: PascalCase (`StatusType` or `Status`)
- **Enums**: PascalCase (`UserRole`)
- **Variables**: camelCase (`userName`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRIES`)
- **Functions**: camelCase (`getUserById`)
- **Classes**: PascalCase (`UserService`)
- **Files**: kebab-case (`user-service.ts`)

### Strict Mode
```json
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noImplicitThis": true,
    "alwaysStrict": true
  }
}
```

## React/NextJS Standards

### Component Structure
```typescript
// Props interface above component
interface ButtonProps {
  variant: 'primary' | 'secondary';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
  onClick?: () => void;
  children: React.ReactNode;
}

// Functional component with TypeScript
export function Button({
  variant,
  size = 'md',
  disabled = false,
  loading = false,
  onClick,
  children,
}: ButtonProps) {
  // Implementation
  return (
    <button
      className={`btn btn-${variant} btn-${size}`}
      disabled={disabled || loading}
      onClick={onClick}
    >
      {loading ? <Spinner /> : children}
    </button>
  );
}
```

### Hooks Usage
```typescript
// ✅ Custom hooks start with 'use'
function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => clearTimeout(handler);
  }, [value, delay]);

  return debouncedValue;
}

// ✅ Include all dependencies
useEffect(() => {
  fetchData(userId, filter);
}, [userId, filter]); // Complete dependency array

// ✅ Cleanup side effects
useEffect(() => {
  const subscription = subscribe();
  return () => subscription.unsubscribe();
}, []);
```

### Component Size
- Keep components under 250 lines
- Extract complex logic to custom hooks
- Split large components into smaller ones
- One component per file

### Server vs Client Components (NextJS)
```typescript
// ✅ Server Component (default in App Router)
export default async function Page() {
  const data = await fetchData(); // Server-side
  return <Display data={data} />;
}

// ✅ Client Component (explicit directive)
'use client';

import { useState } from 'react';

export function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}
```

### Performance
```typescript
// ✅ Memoize expensive computations
const expensiveValue = useMemo(() => {
  return computeExpensiveValue(a, b);
}, [a, b]);

// ✅ Memoize callbacks passed to children
const handleClick = useCallback(() => {
  doSomething(value);
}, [value]);

// ✅ Memoize components (use sparingly)
export const MemoizedComponent = React.memo(Component);
```

## NestJS/Backend Standards

### Module Organization
```typescript
// user.module.ts
@Module({
  imports: [TypeOrmModule.forFeature([User])],
  controllers: [UserController],
  providers: [UserService, UserRepository],
  exports: [UserService], // Export if used by other modules
})
export class UserModule {}
```

### Controller Pattern
```typescript
@Controller('api/v1/users')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class UserController {
  constructor(
    private readonly userService: UserService,
  ) {}

  @Get(':id')
  @ApiOperation({ summary: 'Get user by ID' })
  @ApiResponse({ status: 200, type: UserDto })
  async findOne(@Param('id') id: string): Promise<UserDto> {
    return this.userService.findOne(id);
  }

  @Post()
  @UsePipes(new ValidationPipe())
  @ApiOperation({ summary: 'Create user' })
  async create(@Body() dto: CreateUserDto): Promise<UserDto> {
    return this.userService.create(dto);
  }
}
```

### Service Pattern
```typescript
@Injectable()
export class UserService {
  constructor(
    private readonly userRepo: UserRepository,
    private readonly emailService: EmailService,
    private readonly logger: Logger,
  ) {}

  async create(dto: CreateUserDto): Promise<User> {
    this.logger.debug(`Creating user: ${dto.email}`);

    // Validation
    const exists = await this.userRepo.findByEmail(dto.email);
    if (exists) {
      throw new ConflictException('Email already exists');
    }

    // Business logic
    const user = await this.userRepo.create(dto);

    // Side effects
    await this.emailService.sendWelcome(user.email);

    this.logger.log(`User created: ${user.id}`);
    return user;
  }

  async findOne(id: string): Promise<User> {
    const user = await this.userRepo.findById(id);
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }
}
```

### DTO Validation
```typescript
export class CreateUserDto {
  @IsEmail()
  @IsNotEmpty()
  @ApiProperty({ example: 'user@example.com' })
  email: string;

  @IsString()
  @MinLength(8)
  @MaxLength(128)
  @Matches(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]/)
  @ApiProperty({ example: 'SecurePass123' })
  password: string;

  @IsOptional()
  @IsString()
  @MaxLength(255)
  @ApiProperty({ example: 'John Doe', required: false })
  name?: string;
}
```

### Error Handling
```typescript
// ✅ Use specific exceptions
throw new NotFoundException('User not found');
throw new BadRequestException('Invalid input');
throw new ConflictException('Email exists');
throw new ForbiddenException('Access denied');

// ✅ Custom exceptions for business logic
export class InsufficientFundsException extends HttpException {
  constructor() {
    super('Insufficient funds', HttpStatus.UNPROCESSABLE_ENTITY);
  }
}

// ✅ Global exception filter
@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    const request = ctx.getRequest();

    const status = exception instanceof HttpException
      ? exception.getStatus()
      : HttpStatus.INTERNAL_SERVER_ERROR;

    this.logger.error('Exception occurred', {
      path: request.url,
      method: request.method,
      status,
      error: exception,
    });

    response.status(status).json({
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
      message: this.getErrorMessage(exception),
    });
  }
}
```

## Database Standards

### Migration Naming
```
20240115120000_create_users_table.ts
20240115130000_add_role_to_users.ts
YYYYMMDDHHMMSS_descriptive_name.ts
```

### Migration Pattern
```typescript
export class CreateUsersTable1234567890 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'users',
        columns: [
          {
            name: 'id',
            type: 'uuid',
            isPrimary: true,
            default: 'gen_random_uuid()',
          },
          {
            name: 'email',
            type: 'varchar',
            length: '255',
            isUnique: true,
          },
          {
            name: 'created_at',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
        ],
      }),
    );

    await queryRunner.createIndex('users', new TableIndex({
      name: 'idx_users_email',
      columnNames: ['email'],
    }));
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropIndex('users', 'idx_users_email');
    await queryRunner.dropTable('users');
  }
}
```

### Query Optimization
```typescript
// ❌ N+1 Query Problem
const users = await userRepo.find();
for (const user of users) {
  user.posts = await postRepo.findByUserId(user.id); // N queries
}

// ✅ Eager Loading
const users = await userRepo.find({
  relations: ['posts'], // Single query with JOIN
});

// ✅ Or use query builder
const users = await userRepo
  .createQueryBuilder('user')
  .leftJoinAndSelect('user.posts', 'post')
  .where('user.active = :active', { active: true })
  .getMany();
```

### Index Strategy
```sql
-- Index foreign keys
CREATE INDEX idx_posts_user_id ON posts(user_id);

-- Composite index for common queries
CREATE INDEX idx_posts_user_published 
ON posts(user_id, published, created_at DESC);

-- Partial index for filtered queries
CREATE INDEX idx_posts_published 
ON posts(created_at DESC) 
WHERE published = true;

-- Full-text search index
CREATE INDEX idx_posts_search 
ON posts USING gin(to_tsvector('english', title || ' ' || content));
```

## Testing Standards

### Test Structure
```typescript
describe('UserService', () => {
  let service: UserService;
  let mockRepo: jest.Mocked<UserRepository>;

  beforeEach(() => {
    mockRepo = {
      findById: jest.fn(),
      create: jest.fn(),
    } as any;
    service = new UserService(mockRepo, mockLogger);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('create', () => {
    it('should create user with valid data', async () => {
      // Arrange
      const dto = { email: 'test@example.com', password: 'pass123' };
      const expectedUser = { id: '1', ...dto };
      mockRepo.create.mockResolvedValue(expectedUser);

      // Act
      const result = await service.create(dto);

      // Assert
      expect(result).toEqual(expectedUser);
      expect(mockRepo.create).toHaveBeenCalledWith(dto);
    });

    it('should throw ConflictException if email exists', async () => {
      // Arrange
      mockRepo.findByEmail.mockResolvedValue({ id: '1' } as User);

      // Act & Assert
      await expect(service.create(dto)).rejects.toThrow(ConflictException);
    });
  });
});
```

### Test Naming
```typescript
// ✅ Descriptive names
it('should return user when id exists')
it('should throw NotFoundException when id does not exist')
it('should hash password before saving')

// ❌ Vague names
it('works')
it('test user creation')
```

### Coverage Guidelines
- Critical business logic: 90%+
- Services: 80%+
- Controllers: 70%+
- Utilities: 80%+
- Focus on edge cases and error paths

## Documentation Standards

### JSDoc Comments
```typescript
/**
 * Creates a new user account and sends welcome email.
 *
 * @param dto - User registration data
 * @returns The created user (password excluded)
 * @throws {ConflictException} If email already exists
 * @throws {BadRequestException} If validation fails
 *
 * @example
 * ```typescript
 * const user = await userService.create({
 *   email: 'user@example.com',
 *   password: 'SecurePass123',
 * });
 * ```
 */
async create(dto: CreateUserDto): Promise<UserDto> {
  // Implementation
}
```

### README Structure
```markdown
# Component/Module Name

Brief description.

## Features
- Feature 1
- Feature 2

## Installation
\`\`\`bash
npm install
\`\`\`

## Usage
\`\`\`typescript
import { Component } from './component';
\`\`\`

## API Reference
### `functionName(param)`
Description...

## Testing
\`\`\`bash
npm test
\`\`\`

## License
MIT
```

## Git Conventions

### Branch Naming
```
feature/add-user-authentication
fix/resolve-memory-leak
refactor/improve-error-handling
docs/update-api-documentation
chore/upgrade-dependencies
```

### Commit Messages
```
feat: add user authentication with JWT
fix: resolve memory leak in WebSocket handler
refactor: improve error handling in UserService
docs: update API documentation for /users endpoint
chore: upgrade dependencies to latest versions
test: add unit tests for UserService
style: format code with prettier
perf: optimize database queries in dashboard
```

**Format:**
```
type(scope): subject

body (optional)

footer (optional)
```

**Types:** feat, fix, docs, style, refactor, test, chore, perf

## File Organization

### Project Structure
```
src/
├── modules/              # Feature modules
│   ├── user/
│   │   ├── dto/
│   │   │   ├── create-user.dto.ts
│   │   │   └── user-response.dto.ts
│   │   ├── entities/
│   │   │   └── user.entity.ts
│   │   ├── user.controller.ts
│   │   ├── user.service.ts
│   │   ├── user.module.ts
│   │   ├── user.controller.spec.ts
│   │   └── user.service.spec.ts
│   └── auth/
├── common/               # Shared across modules
│   ├── decorators/
│   ├── filters/
│   ├── guards/
│   ├── interceptors/
│   └── pipes/
├── config/               # Configuration
└── shared/               # Utilities
    ├── utils/
    └── types/
```

### Import Order
```typescript
// 1. External dependencies
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';

// 2. Internal dependencies (absolute)
import { UserRepository } from '@/repositories/user.repository';
import { EmailService } from '@/services/email.service';

// 3. Relative dependencies
import { CreateUserDto } from './dto/create-user.dto';
import { User } from './entities/user.entity';
```

## Code Review Checklist

- [ ] Follows naming conventions
- [ ] Types are explicit
- [ ] No code duplication
- [ ] Functions are single-purpose
- [ ] Error handling is comprehensive
- [ ] Tests are included
- [ ] Documentation is updated
- [ ] Security best practices followed
- [ ] Performance is acceptable
- [ ] No hardcoded values
- [ ] Environment variables used correctly
- [ ] Logging is appropriate
- [ ] Comments explain "why" not "what"
