# MCP Server Recommendations

This document outlines recommended MCP servers for your OpenCode setup with tier-specific loading strategies.

## Universal Servers (All Agents)

These servers are always available:

### @modelcontextprotocol/server-git
**Purpose:** Git operations (status, diff, commit, branch)  
**Tier:** Universal  
**Config:**
```json
{
  "git": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-git"],
    "enabled": true
  }
}
```

## Tier 1 Servers (Build & Plan Agents)

Basic development tools for routine tasks:

###  github/github-mcp-server 
**Purpose:** GitHub API (PRs, issues, comments, reviews)  
**Agents:** build, plan  
**Config:**
```json
{
  "github": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-github"],
    "env": {
      "GITHUB_TOKEN": "${GITHUB_TOKEN}"
    },
    "enabled": true
  }
}
```

**Setup:**
```bash
# Create GitHub token with repo scope
export GITHUB_TOKEN="ghp_your_token_here"
```

## Tier 2 Servers (Domain Specialists)

Loaded dynamically based on active subagent:

### Database Specialist → PostgreSQL MCP (Archived)
**Purpose:** Execute SQL queries, inspect schema, manage migrations  
**Agents:** database, backend, architect  
**Config:**
```json
{
  "postgres": {
    "type": "local",
    "command": [
      "npx",
      "-y",
      "@modelcontextprotocol/server-postgres",
      "${DATABASE_URL}"
    ],
    "enabled": false
  }
}
```

**Setup:**
```bash
export DATABASE_URL="postgresql://user:password@localhost:5432/dbname"
```

**Enable when:**
- Working on database schema
- Debugging queries
- Writing migrations
- Optimizing performance

### Test Specialist → Playwright MCP
**Purpose:** Browser automation, E2E test generation, web scraping  
**Agents:** test-expert, debugger  
**Config:**
```json
{
  "playwright": {
    "type": "local",
    "command": ["npx", "-y", "@executeautomation/playwright-mcp-server"],
    "enabled": false
  }
}
```

**Enable when:**
- Writing E2E tests
- Debugging UI issues
- Web scraping
- Visual testing

### Infrastructure Specialist → Docker MCP
**Purpose:** Container management, image inspection, logs  
**Agents:** infrastructure, debugger  
**Config:**
```json
{
  "docker": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-docker"],
    "enabled": false
  }
}
```

**Enable when:**
- Building containers
- Debugging containerized apps
- Optimizing Docker images
- Container orchestration

### Infrastructure Specialist → AWS MCP
**Purpose:** AWS resource inspection and management  
**Agents:** infrastructure, architect  
**Config:**
```json
{
  "aws": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-aws"],
    "env": {
      "AWS_REGION": "${AWS_REGION}",
      "AWS_ACCESS_KEY_ID": "${AWS_ACCESS_KEY_ID}",
      "AWS_SECRET_ACCESS_KEY": "${AWS_SECRET_ACCESS_KEY}"
    },
    "enabled": false
  }
}
```

**Setup:**
```bash
export AWS_REGION="us-east-1"
export AWS_ACCESS_KEY_ID="your_key"
export AWS_SECRET_ACCESS_KEY="your_secret"
```

**Enable when:**
- Deploying to AWS
- Debugging cloud issues
- Infrastructure as code
- Cost analysis

### Documentation Specialist → Obsidian MCP
**Purpose:** Notes management, documentation search  
**Agents:** documentation, architect  
**Config:**
```json
{
  "obsidian": {
    "type": "local",
    "command": [
      "npx",
      "-y",
      "mcp-obsidian",
      "--vault-path",
      "${OBSIDIAN_VAULT_PATH}"
    ],
    "enabled": false
  }
}
```

**Setup:**
```bash
export OBSIDIAN_VAULT_PATH="~/Documents/Obsidian/MyVault"
```

**Enable when:**
- Creating documentation
- Researching architecture decisions
- Planning features
- Meeting notes

### All Specialists → Context7 MCP (Remote)
**Purpose:** Up-to-date library documentation  
**Agents:** All  
**Config:**
```json
{
  "context7": {
    "type": "remote",
    "url": "https://mcp.context7.com/mcp",
    "headers": {
      "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
    },
    "enabled": false
  }
}
```

**Setup:**
1. Get API key from [context7.com](https://context7.com)
2. `export CONTEXT7_API_KEY="your_key"`

**Enable when:**
- Learning new libraries
- Checking API changes
- Migration guides
- Best practices lookup

## Agent-Specific MCP Loading

You can specify required MCP servers in agent markdown files:

**Example: agent/database.md**
```markdown
---
description: Database specialist
mode: subagent
tools:
  mcp_postgres_*: true
  mcp_git_*: true
---

# Database Specialist
...
```

This automatically enables PostgreSQL MCP when the database agent is invoked.

## Dynamic Loading Strategy

### Option 1: Manual Toggle
Enable/disable in `opencode.json`:
```json
{
  "mcp": {
    "postgres": {
      "enabled": true  // Toggle as needed
    }
  }
}
```

### Option 2: Project-Specific Config
Create `.opencode/opencode.json` in your project:
```json
{
  "mcp": {
    "postgres": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-postgres", "postgresql://localhost:5432/myproject"],
      "enabled": true
    }
  }
}
```

This overrides global config when working in this project.

### Option 3: Environment-Based
```bash
# .envrc (using direnv)
export DATABASE_URL="postgresql://localhost:5432/dev"
export ENABLE_POSTGRES_MCP="true"
```

## Performance Considerations

**Context Usage:**
- Each MCP server adds to context
- GitHub MCP: ~500-1000 tokens per tool
- Postgres MCP: ~300-500 tokens per tool
- Enable only what you need

**Best Practices:**
1. Start with universal servers only
2. Enable domain servers as needed
3. Disable after task completion
4. Use project-specific configs for automatic loading

## Recommended Server Combinations

**Frontend Development:**
```json
["git", "npm", "github", "context7"]
```

**Backend Development:**
```json
["git", "npm", "github", "postgres", "context7"]
```

**Full-Stack Development:**
```json
["git", "npm", "github", "postgres", "context7"]
```

**Infrastructure Work:**
```json
["git", "github", "docker", "aws"]
```

**Testing:**
```json
["git", "npm", "github", "playwright"]
```

**Documentation:**
```json
["git", "github", "obsidian", "context7"]
```

## Additional MCP Servers (Optional)

### Storybook MCP (Community/Custom)
**Status:** May need custom implementation  
**Purpose:** Component preview, story generation

### Bundle Analyzer MCP (Custom)
**Status:** Would need custom implementation  
**Purpose:** Webpack/Vite bundle analysis

### Sentry/Error Tracking MCP (Custom)
**Status:** Would need custom implementation  
**Purpose:** Error logs, performance monitoring

## Security Notes

- Store all tokens/keys in environment variables
- Never commit secrets to git
- Use `.env` files with `.gitignore`
- Rotate tokens regularly
- Limit token permissions to minimum needed

## Troubleshooting

**MCP Server Won't Start:**
```bash
# Check if server is installed
npx -y @modelcontextprotocol/server-git --version

# Check environment variables
echo $GITHUB_TOKEN

# Test server manually
npx -y @modelcontextprotocol/server-github
```

**High Context Usage:**
```bash
# Check which servers are enabled
grep -A5 "mcp" ~/.config/opencode/opencode.json | grep enabled

# Disable unused servers
# Edit opencode.json and set enabled: false
```

**Authentication Errors:**
```bash
# Verify token permissions
curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user

# For AWS, check credentials
aws sts get-caller-identity
```
