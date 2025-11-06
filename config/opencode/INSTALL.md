# Quick Installation Guide

## Step-by-Step Setup

### 1. Download Files

Download all files from the `opencode-setup/` directory.

### 2. Copy to OpenCode Config

```bash
# Backup existing config (if any)
cp -r ~/.config/opencode ~/.config/opencode.backup

# Copy all new files
cp -r opencode-setup/* ~/.config/opencode/

# Verify structure
tree ~/.config/opencode
```

Expected structure:
```
~/.config/opencode/
├── AGENTS.md
├── opencode.json
├── agent/
│   ├── frontend.md
│   ├── backend.md
│   ├── test-expert.md
│   ├── database.md
│   ├── infrastructure.md
│   ├── security.md
│   ├── documentation.md
│   ├── code-reviewer.md
│   ├── debugger.md
│   └── architect.md
├── command/
│   ├── component.md
│   ├── hook.md
│   ├── endpoint.md
│   ├── test.md
│   ├── e2e.md
│   ├── review.md
│   ├── debug.md
│   └── performance.md
└── docs/
    ├── MCP_SERVERS.md
    ├── security-guidelines.md
    └── code-standards.md
```

### 3. Merge Existing Config

If you have existing `opencode.json` settings:

```bash
# Your existing settings will be preserved
# Just manually add the new agent and mcp sections
# Or use the provided opencode.json as-is
```

### 4. Set Up Environment Variables

Create `~/.config/opencode/.env`:

```bash
# Required for GitHub integration
export GITHUB_TOKEN="ghp_your_token_here"

# Optional - enable as needed
export DATABASE_URL="postgresql://user:password@localhost:5432/dbname"
export AWS_REGION="us-east-1"
export AWS_ACCESS_KEY_ID="your_key"
export AWS_SECRET_ACCESS_KEY="your_secret"
export OBSIDIAN_VAULT_PATH="~/Documents/Obsidian/MyVault"
export CONTEXT7_API_KEY="your_key"
```

Load environment:
```bash
# Add to ~/.bashrc or ~/.zshrc
source ~/.config/opencode/.env
```

### 5. Test Installation

```bash
# Navigate to a project
cd ~/your-project

# Start OpenCode
opencode

# Test agents
Tab  # Should see build/plan agents
@frontend  # Should see frontend agent

# Test commands
/help  # Should see custom commands

# Initialize project
/init
```

### 6. Configure MCP Servers

Most MCP servers are disabled by default. Enable as needed:

```bash
# Edit opencode.json
# Change "enabled": false to "enabled": true for desired servers
```

**Common MCP servers:**
- `git` - Always enabled (universal)
- `github` - Enable for PR/issue work
- `postgres` - Enable when working with database
- `docker` - Enable for container work
- `playwright` - Enable for E2E testing

See `docs/MCP_SERVERS.md` for detailed setup.

## Quick Start Examples

### Frontend Development
```bash
opencode
/component Button with loading state
@frontend Create a form with validation
```

### Backend Development
```bash
opencode
/endpoint users with CRUD
@backend Add rate limiting to API
@database Optimize user queries
```

### Testing
```bash
opencode
/test @src/services/user.service.ts
/e2e login flow with validation errors
@test-expert Generate comprehensive test suite
```

### Debugging
```bash
opencode
/debug TypeError in user controller line 42
@debugger Investigate memory leak in WebSocket
```

### Code Review
```bash
opencode
/review @src/auth/auth.service.ts
@security Audit authentication implementation
```

## Troubleshooting

**Agents not showing:**
```bash
ls ~/.config/opencode/agent/
# Should see all .md files
```

**Commands not working:**
```bash
ls ~/.config/opencode/command/
# Should see all .md files
/help  # Lists available commands
```

**MCP server errors:**
```bash
# Test manually
npx -y @modelcontextprotocol/server-git --version

# Check environment variables
echo $GITHUB_TOKEN
```

## Next Steps

1. Read [README.md](README.md) for detailed usage
2. Review [MCP_SERVERS.md](docs/MCP_SERVERS.md) for MCP setup
3. Check [security-guidelines.md](docs/security-guidelines.md)
4. Review [code-standards.md](docs/code-standards.md)
5. Customize agents/commands for your needs

## Support

- [OpenCode Docs](https://opencode.ai/docs)
- [OpenCode GitHub](https://github.com/opencode-ai/opencode)
- File issues for bugs or improvements
