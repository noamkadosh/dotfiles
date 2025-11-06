# Security Guidelines

Comprehensive security standards for all code and infrastructure.

## Authentication & Authorization

### Password Security
- **Hash passwords** with bcrypt (cost factor ≥12) or Argon2
- **Never log** passwords or tokens
- **Enforce** minimum 8 characters, complexity requirements
- **Implement** account lockout after 5 failed attempts
- **Rotate** sessions after privilege changes

### Token Management
- **JWT tokens**: Include expiration (≤24h for access, ≤7d for refresh)
- **Store securely**: httpOnly, secure, sameSite cookies
- **Refresh tokens**: Rotate on use, invalidate on logout
- **API keys**: Rotate regularly, scope permissions minimally

### Session Security
- **Timeout**: Idle sessions after 30 minutes
- **Invalidation**: Clear sessions on logout, password change
- **Storage**: Use Redis or secure session store
- **CSRF protection**: Required for state-changing operations

## Input Validation

### Always Validate
- **User input**: Whitelist allowed values
- **File uploads**: Check type, size, scan for malware
- **URLs**: Validate and sanitize before redirect
- **SQL queries**: Use parameterized queries only
- **Shell commands**: Avoid user input; use allowlist if necessary

### Sanitization
```typescript
// ❌ VULNERABLE
const query = `SELECT * FROM users WHERE email = '${email}'`;
element.innerHTML = userInput;

// ✅ SECURE
const query = 'SELECT * FROM users WHERE email = $1';
await db.query(query, [email]);
element.textContent = userInput; // or use DOMPurify
```

### DTO Validation (NestJS)
```typescript
import { IsEmail, IsString, MinLength, MaxLength } from 'class-validator';

export class CreateUserDto {
  @IsEmail()
  email: string;

  @IsString()
  @MinLength(8)
  @MaxLength(128)
  password: string;
}
```

## Data Protection

### Encryption
- **In transit**: TLS 1.2+ only, no mixed content
- **At rest**: Encrypt sensitive fields (PII, financial)
- **Keys**: Store in secrets manager (AWS Secrets, Vault)
- **Backup**: Encrypt backups, test restoration

### PII Handling
- **Minimize collection**: Only necessary data
- **Access control**: Log PII access, limit to need-to-know
- **Retention**: Delete after purpose fulfilled
- **Export**: Provide user data on request (GDPR)
- **Deletion**: Hard delete on request, cascade properly

### Secrets Management
```typescript
// ❌ HARDCODED SECRET
const apiKey = 'sk-1234567890abcdef';

// ✅ ENVIRONMENT VARIABLE
const apiKey = process.env.API_KEY;
if (!apiKey) {
  throw new Error('API_KEY not configured');
}
```

**Never commit:**
- API keys, tokens, passwords
- Private keys, certificates
- Database credentials
- `.env` files (use `.env.example` template)

## API Security

### Rate Limiting
```typescript
// Implement rate limiting per IP/user
@UseGuards(ThrottlerGuard)
@Throttle(10, 60) // 10 requests per 60 seconds
@Post('login')
async login() { ... }
```

### CORS Configuration
```typescript
// ❌ ALLOW ALL
app.enableCors({ origin: '*' });

// ✅ SPECIFIC ORIGINS
app.enableCors({
  origin: ['https://yourdomain.com'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
});
```

### Authentication on Endpoints
```typescript
// All endpoints need auth unless explicitly public
@Controller('api/v1/users')
@UseGuards(JwtAuthGuard) // Apply to entire controller
export class UserController {
  
  @Public() // Explicitly mark public endpoints
  @Get('health')
  health() { ... }
  
  @Get('profile')
  getProfile(@CurrentUser() user: User) {
    // Authenticated user available
  }
}
```

### Authorization Checks
```typescript
// Always verify ownership/permissions
@Get('users/:id')
async getUser(@Param('id') id: string, @CurrentUser() user: User) {
  // Check if user can access this resource
  if (user.id !== id && !user.isAdmin) {
    throw new ForbiddenException('Cannot access other users');
  }
  return this.userService.findById(id);
}
```

### Request Validation
- **Content-Type**: Verify expected type
- **Size limits**: Prevent DoS (e.g., max 10MB for uploads)
- **Payload structure**: Validate with DTOs
- **Headers**: Validate required headers

## Common Vulnerabilities

### SQL Injection Prevention
```typescript
// ❌ VULNERABLE - String concatenation
const email = req.body.email;
const query = `SELECT * FROM users WHERE email = '${email}'`;

// ✅ SECURE - Parameterized query
const query = 'SELECT * FROM users WHERE email = $1';
const result = await db.query(query, [email]);
```

### XSS Prevention
```typescript
// ❌ VULNERABLE
res.send(`<h1>Welcome ${username}</h1>`);
element.innerHTML = userInput;

// ✅ SECURE
res.render('welcome', { username }); // Template engine escapes
element.textContent = userInput; // Sets text, not HTML
// Or use DOMPurify for rich content
```

### CSRF Prevention
```typescript
// Enable CSRF protection
app.use(csurf({ cookie: true }));

// Include token in forms
<form method="POST">
  <input type="hidden" name="_csrf" value="{{ csrfToken }}">
</form>
```

### Command Injection Prevention
```typescript
// ❌ VULNERABLE
const { exec } = require('child_process');
exec(`convert ${filename} output.jpg`); // User controls filename!

// ✅ SECURE - Avoid shell, use allowlist
const { execFile } = require('child_process');
const allowedFiles = ['image1.png', 'image2.jpg'];
if (!allowedFiles.includes(filename)) {
  throw new Error('Invalid file');
}
execFile('convert', [filename, 'output.jpg']);
```

### Path Traversal Prevention
```typescript
// ❌ VULNERABLE
const filePath = path.join(__dirname, 'uploads', req.query.file);

// ✅ SECURE - Validate path
const fileName = path.basename(req.query.file);
const filePath = path.join(__dirname, 'uploads', fileName);
if (!filePath.startsWith(path.join(__dirname, 'uploads'))) {
  throw new Error('Invalid path');
}
```

## Dependency Security

### Package Management
```bash
# Regular security audits
npm audit
npm audit fix

# Use lockfiles
npm ci  # Use in CI, not npm install

# Check for known vulnerabilities
npx snyk test
```

### Update Strategy
- **Critical**: Apply immediately
- **High**: Within 7 days
- **Medium**: Within 30 days
- **Low**: Next sprint
- **Test thoroughly**: After any updates

### Supply Chain Security
- **Verify sources**: Only trusted registries
- **Check signatures**: When available
- **Review dependencies**: Before adding new packages
- **Minimize deps**: Fewer dependencies = smaller attack surface

## Infrastructure Security

### Container Security
```dockerfile
# Use official, minimal base images
FROM node:20-alpine

# Don't run as root
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
USER nodejs

# Scan for vulnerabilities
# docker scan myimage:latest
```

### Environment Variables
```bash
# ❌ DON'T
docker run -e DATABASE_PASSWORD=secret123 myapp

# ✅ DO
# Use secrets management
docker run --env-file .env myapp
# Or cloud provider secrets (AWS Secrets Manager, etc.)
```

### Network Security
- **Firewall rules**: Allow only necessary ports
- **VPC**: Isolate resources in private networks
- **Security groups**: Minimal ingress/egress rules
- **TLS everywhere**: Internal services too

## Logging & Monitoring

### Secure Logging
```typescript
// ❌ DON'T LOG SENSITIVE DATA
logger.info('Login attempt', { email, password });

// ✅ LOG SAFELY
logger.info('Login attempt', {
  email: email.split('@')[0] + '@***', // Partial masking
  ip: req.ip,
  userAgent: req.headers['user-agent']
});

// ✅ LOG SECURITY EVENTS
logger.warn('Failed login attempt', {
  email: email.split('@')[0] + '@***',
  ip: req.ip,
  attempts: loginAttempts
});
```

### Audit Trail
- **Log all** auth events (login, logout, password change)
- **Log all** permission changes
- **Log all** sensitive data access
- **Retain logs** per compliance requirements
- **Protect logs** from tampering

### Monitoring & Alerts
- **Failed login attempts** (>5 in 5 min)
- **Unusual access patterns**
- **Permission escalations**
- **Error rate spikes**
- **Resource exhaustion**

## Incident Response

### When Breach Suspected
1. **Isolate** affected systems
2. **Preserve** evidence (logs, snapshots)
3. **Notify** security team immediately
4. **Document** timeline and actions
5. **Rotate** all credentials
6. **Investigate** root cause
7. **Patch** vulnerabilities
8. **Notify** affected users (if required)

### Security Contact
- Internal: [security@yourcompany.com]
- External: Responsible disclosure policy

## Compliance

### GDPR (EU)
- Right to access data
- Right to deletion
- Right to portability
- Consent for processing
- Data breach notification (<72h)

### SOC2
- Access controls
- Encryption
- Monitoring
- Incident response
- Regular audits

### PCI-DSS (if handling payments)
- Never store CVV
- Encrypt cardholder data
- Use certified payment processors
- Regular security assessments

## Security Checklist

Before deployment:
- [ ] All secrets in environment variables
- [ ] TLS/HTTPS enabled
- [ ] Authentication on all endpoints
- [ ] Authorization checks implemented
- [ ] Input validation on all user data
- [ ] SQL queries parameterized
- [ ] XSS prevention in place
- [ ] CSRF protection enabled
- [ ] Rate limiting configured
- [ ] Dependencies scanned for vulnerabilities
- [ ] Security headers set (HSTS, CSP, etc.)
- [ ] Error messages don't leak sensitive info
- [ ] Logging excludes sensitive data
- [ ] Backups encrypted
- [ ] Incident response plan documented

## Security Headers

```typescript
// Set security headers
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", 'data:', 'https:'],
    },
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true,
  },
}));
```

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheets](https://cheatsheetseries.owasp.org/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
