# OpenCode Agent System Setup

Complete agent system for OpenCode with specialized subagents, custom commands, and MCP server integrations.

## 📋 Overview

This setup provides a comprehensive 2-tier agent architecture for software development:

**Tier 1:** Built-in Build and Plan agents for routine tasks  
**Tier 2:** Specialized subagents for domain-specific work

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────┐
│                  Tier 1 Agents                       │
│  ┌─────────────────┐  ┌─────────────────────────┐  │
│  │  Build Agent    │  │    Plan Agent           │  │
│  │  (Modify Code)  │  │    (Read-only)          │  │
│  └─────────────────┘  └─────────────────────────┘  │
└─────────────────────────────────────────────────────┘
                      ↓ escalate
┌─────────────────────────────────────────────────────┐
│              Tier 2 Subagents                        │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐            │
│  │ Frontend │ │ Backend  │ │   Test   │            │
│  │          │ │          │ │  Expert  │            │
│  └──────────┘ └──────────┘ └──────────┘            │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐            │
│  │ Database │ │  Infra   │ │ Security │            │
│  │          │ │          │ │          │            │
│  └──────────┘ └──────────┘ └──────────┘            │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐            │
│  │   Docs   │ │ Reviewer │ │ Debugger │            │
│  │          │ │          │ │          │            │
│  └──────────┘ └──────────┘ └──────────┘            │
│  ┌──────────────────────────────────────┐          │
│  │         Architect                     │          │
│  │  (System Design & Strategy)          │          │
│  └──────────────────────────────────────┘          │
└─────────────────────────────────────────────────────┘
```

## 📦 What's Included

### Agents (10 Total)

**Tier 1 (Primary):**
- `build` - Default agent with full tools
- `plan` - Read-only analysis agent

**Tier 2 (Subagents):**
- `@frontend` - React, NextJS, TypeScript, Storybook
- `@backend` - NestJS, Node, REST API, GraphQL
- `@test-expert` - Jest, Vitest, Playwright, Storybook
- `@database` - PostgreSQL schema, queries, optimization
- `@infrastructure` - Docker, AWS, Nix, CI/CD
- `@security` - Vulnerability auditing, best practices
- `@documentation` - Technical docs, API docs, guides
- `@code-reviewer` - Code quality, best practices review
- `@debugger` - Troubleshooting, root cause analysis
- `@architect` - System design, architectural decisions

### Custom Commands (9 Total)

- `/component` - Generate React component
- `/hook` - Generate custom React hook
- `/endpoint` - Create API endpoint
- `/test` - Generate unit tests
- `/e2e` - Generate E2E tests
- `/review` - Perform code review
- `/debug` - Debug an issue
- `/performance` - Analyze performance

### Global Instructions

- `AGENTS.md` - Tech stack, code standards, security guidelines
- Comprehensive instructions for all agents
- Escalation procedures
- File organization standards

### MCP Servers

**Universal:**
- Git operations
- NPM package search

**Optional (Enable as needed):**
- GitHub API
- PostgreSQL
- Docker
- AWS
- Playwright
- Obsidian
- Context7 (library docs)

## 🚀 Installation

### Prerequisites

- OpenCode installed ([installation guide](https://opencode.ai/docs))
- Node.js 18+ for MCP servers
- Git configured

### Step 1: Copy Configuration Files

```bash
# Navigate to your OpenCode config directory
cd ~/.config/opencode

# Copy all files from this setup
cp -r /path/to/opencode-setup/* .

# Your directory structure should look like:
# ~/.config/opencode/
# ├── AGENTS.md
# ├── opencode.json
# ├── agent/
# │   ├── frontend.md
# │   ├── backend.md
# │   ├── test-expert.md
# │   ├── database.md
# │   ├── infrastructure.md
# │   ├── security.md
# │   ├── documentation.md
# │   ├── code-reviewer.md
# │   ├── debugger.md
# │   └── architect.md
# ├── command/
# │   ├── component.md
# │   ├── hook.md
# │   ├── endpoint.md
# │   ├── test.md
# │   ├── e2e.md
# │   ├── review.md
# │   ├── debug.md
# │   └── performance.md
# └── docs/
#     └── MCP_SERVERS.md
```

### Step 2: Merge Your Existing Config

If you have an existing `opencode.json`:

```bash
# Backup your current config
cp ~/.config/opencode/opencode.json ~/.config/opencode/opencode.json.backup

# Manually merge or replace
# The provided opencode.json includes:
# - Your existing settings (model, theme, share)
# - Agent definitions
# - MCP server configurations
```

### Step 3: Set Up Environment Variables

Create `~/.config/opencode/.env`:

```bash
# GitHub (for PR/issue management)
export GITHUB_TOKEN="ghp_your_token_here"

# Database (enable when needed)
export DATABASE_URL="postgresql://user:password@localhost:5432/dbname"

# AWS (enable when needed)
export AWS_REGION="us-east-1"
export AWS_ACCESS_KEY_ID="your_key"
export AWS_SECRET_ACCESS_KEY="your_secret"

# Obsidian (enable when needed)
export OBSIDIAN_VAULT_PATH="~/Documents/Obsidian/MyVault"

# Context7 (optional - get API key from context7.com)
export CONTEXT7_API_KEY="your_key"
```

Load the environment:
```bash
# Add to your shell profile (~/.bashrc, ~/.zshrc)
source ~/.config/opencode/.env
```

### Step 4: Test Installation

```bash
# Start OpenCode in a project
cd ~/your-project
opencode

# Test agents are loaded
# Press Tab to see build/plan agents
# Type @frontend to see subagent is available

# Test commands
/help
# You should see custom commands listed

# Initialize project
/init
# This creates project-specific AGENTS.md
```

## 📖 Usage Guide

### Using Tier 1 Agents

**Build Agent (Default):**
```
Make the submit button primary color
```

**Plan Agent (Read-only):**
```
Tab  # Switch to Plan agent
How should I implement user authentication?
```

### Using Tier 2 Subagents

**Manual Invocation:**
```
@frontend Create a loading spinner component
@backend Add rate limiting to the API
@test-expert Write tests for the UserService
@database Optimize the posts query
@security Review authentication implementation
@architect Design a caching strategy
```

**Automatic Escalation:**

Agents automatically invoke specialist subagents when needed:

```
User: Fix the slow database query in user service
Build Agent: [Invokes @database subagent]
@database: [Analyzes query, adds index, optimizes]
```

### Using Custom Commands

**Component Generation:**
```
/component Button primary secondary with loading state
```

**API Endpoint:**
```
/endpoint posts with CRUD operations
```

**Testing:**
```
/test @src/utils/validation.ts
/e2e user login flow
```

**Code Review:**
```
/review @src/services/user.service.ts
```

**Debugging:**
```
/debug TypeError: Cannot read property 'id' of undefined in user controller
```

**Performance:**
```
/performance @src/components/Dashboard.tsx slow rendering
```

### MCP Server Management

**Enable for Current Session:**
```bash
# Edit opencode.json
{
  "mcp": {
    "postgres": {
      "enabled": true  # Change to true
    }
  }
}
```

**Project-Specific MCP:**

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

## 🎯 Common Workflows

### Frontend Development

```bash
# 1. Create component
/component UserProfile with avatar, name, bio

# 2. Add tests
/test @components/UserProfile.tsx

# 3. Create Storybook story
# (automatically created by /component)

# 4. Review
/review @components/UserProfile.tsx
```

### Backend Development

```bash
# 1. Create endpoint
/endpoint users with authentication

# 2. Add database migration
@database Create users table with email, password, timestamps

# 3. Write tests
/test @users/users.service.ts

# 4. Review security
@security Review user authentication in @users/
```

### Full-Stack Feature

```bash
# 1. Plan with architect
@architect Design a notification system with real-time updates

# 2. Backend implementation
@backend Implement notification API with WebSocket support

# 3. Frontend implementation  
@frontend Create notification UI component

# 4. Testing
@test-expert Create E2E tests for notifications

# 5. Documentation
@documentation Document notification API and usage
```

### Bug Fixing

```bash
# 1. Debug the issue
/debug User registration fails with 500 error

# 2. Implement fix
# (Build agent or specific subagent)

# 3. Add regression test
@test-expert Add test to prevent this bug

# 4. Verify
/review @src/auth/register.ts
```

### Performance Optimization

```bash
# 1. Analyze performance
/performance @src/components/Dashboard.tsx

# 2. Optimize database
@database Add indexes for dashboard queries

# 3. Optimize frontend
@frontend Implement React.memo and code splitting

# 4. Verify improvements
# Run benchmarks, check bundle size
```

## 🔧 Customization

### Adding Your Own Agents

Create `~/.config/opencode/agent/my-agent.md`:

```markdown
---
description: My custom agent
mode: subagent
model: claude-sonnet-4-5
temperature: 0.2
tools:
  write: true
  edit: true
---

# My Custom Agent

Specialized instructions here...
```

### Adding Custom Commands

Create `~/.config/opencode/command/my-command.md`:

```markdown
---
description: My custom command
agent: build
---

Do something with $ARGUMENT_NAME

Additional instructions...
```

### Modifying Global Instructions

Edit `~/.config/opencode/AGENTS.md`:

```markdown
# Add your team's specific standards
## Our API Conventions
- Use snake_case for endpoints
- Always return 200 with data wrapper
...
```

### Project-Specific Instructions

Create `.opencode/AGENTS.md` in your project:

```markdown
# Project-Specific Rules

## This Project
- Uses Prisma ORM
- Styled with Tailwind
- React Server Components only
...
```

## 📊 Agent Capabilities Matrix

| Agent | Write Code | Read Only | Bash | Domain |
|-------|-----------|-----------|------|--------|
| build | ✅ | ✅ | ✅ | General |
| plan | ❌ | ✅ | ❌ | General |
| @frontend | ✅ | ✅ | ✅ | React, Next, TS |
| @backend | ✅ | ✅ | ✅ | NestJS, Node, API |
| @test-expert | ✅ | ✅ | ✅ | Jest, Vitest, Playwright |
| @database | ✅ | ✅ | ✅ | PostgreSQL |
| @infrastructure | ✅ | ✅ | ✅ | Docker, AWS, Nix |
| @security | ❌ | ✅ | Ask | Security auditing |
| @documentation | ✅ | ✅ | ❌ | Technical writing |
| @code-reviewer | ❌ | ✅ | Ask | Code quality |
| @debugger | ✅ | ✅ | ✅ | Troubleshooting |
| @architect | ✅ | ✅ | ✅ | System design |

## 🐛 Troubleshooting

### Agent Not Found

```bash
# Check agent files exist
ls ~/.config/opencode/agent/

# Verify file naming (must be .md)
# Agent name = filename without .md
# e.g., frontend.md creates @frontend agent
```

### Command Not Working

```bash
# Check command files
ls ~/.config/opencode/command/

# Use /help to see available commands

# Check command syntax in markdown frontmatter
```

### MCP Server Not Starting

```bash
# Test server manually
npx -y @modelcontextprotocol/server-git --version

# Check environment variables
echo $GITHUB_TOKEN

# Enable debug logging
DEBUG=* opencode
```

### High Token Usage

```bash
# Disable unused MCP servers
# Edit opencode.json: "enabled": false

# Use /compact to compress context
/compact

# Check which tools are enabled
# Only enable what you need
```

## 📚 Additional Resources

- [OpenCode Documentation](https://opencode.ai/docs)
- [MCP Server Guide](./docs/MCP_SERVERS.md)
- [Agent Instructions Best Practices](https://opencode.ai/docs/agents)
- [Custom Commands Guide](https://opencode.ai/docs/commands)

## 🤝 Contributing

Have improvements or additional agents? Create an issue or PR:

1. Test your agent/command thoroughly
2. Document usage and examples
3. Follow existing patterns
4. Update this README

## 📝 License

MIT - Use freely, modify as needed.

## 🙏 Credits

Created for efficient software development with OpenCode.

Based on:
- OpenCode documentation and best practices
- Real-world multi-agent system patterns
- Community MCP server implementations

---

**Happy Coding! 🚀**

For questions or issues, refer to [OpenCode Docs](https://opencode.ai/docs) or open an issue.
