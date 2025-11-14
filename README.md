# Dotfiles

A comprehensive macOS development environment configuration featuring Neovim, terminal emulators, window management, and custom keyboard firmware.

## Overview

This repository contains personal configuration files (dotfiles) for a modern development setup on macOS, with a focus on keyboard-driven workflows and developer productivity.

### What's Included

**Development Environment:**
- **Neovim** - Feature-rich configuration with LSP, AI assistance, and extensive plugins
- **Zsh** - Shell configuration with plugins managed by Sheldon
- **Git** - Enhanced git config with delta diff viewer and useful aliases

**Terminal Emulators:**
- **Ghostty** - Modern GPU-accelerated terminal
- **WezTerm** - Lua-configured terminal with custom hyperlinks
- **Alacritty** - Fast, minimalist terminal alternative

**Development Tools:**
- **Nix** - Declarative package management with nix-darwin and home-manager
- **Zellij** - Modern terminal multiplexer with custom statusbar
- **Direnv** - Automatic environment variable management
- **Starship** - Fast, customizable shell prompt

**Window Management:**
- **Yabai** - Tiling window manager for macOS
- **SKHD** - Hotkey daemon for macOS
- **Aerospace** - Alternative window manager configuration

**Languages & Tools:**
- **Volta** - JavaScript toolchain manager
- **Rust/Cargo** - Rust development tools
- **Go** - Go development setup
- **Delve** - Go debugger configuration

**Utilities:**
- **Bat** - Cat clone with syntax highlighting
- **Yazi** - Terminal file manager
- **GitHub CLI** - GitHub command-line tools
- **1Password CLI** - Password manager integration
- **VS Code** - Editor configuration and keybindings

**Hardware:**
- **Kinesis Advantage 360 Pro** - Custom ZMK keyboard firmware configuration

**Knowledge Management:**
- **Obsidian** - Note-taking vault with extensive plugins and themes

## Prerequisites

### Required
- macOS (tested on Apple Silicon)
- `git`
- `stow` - GNU Stow for symlink management
- `zsh` - Z shell (default on modern macOS)

### Recommended
- [Volta](https://volta.sh) - JavaScript toolchain (installed by setup script)
- [Nix](https://nixos.org) - Package manager (installed by setup script)
- [Rustup](https://rustup.rs) - Rust toolchain
- A [Nerd Font](https://nerdfonts.com) - For icon support (Geist Mono, JetBrains Mono included)

## Installation

```shell
# Clone this repository
git clone git@github.com:noamkadosh/dotfiles.git

# Navigate to the repository
cd dotfiles

# Checkout main branch
git checkout main

# Initialize and update submodules (nvim, keyboard configs, etc.)
git submodule update --init --force --checkout

# Run the installation script (installs Volta, Nix, Rust, and other tools)
zsh install.zsh

# Create symlinks using stow
stow --dotfiles --target ~ home
stow --dotfiles --target ~/.config dot-config

# Symlink AI and editor configs
stow --target ~/.config/opencode ai/clients/opencode
stow --target ~/.config/nvim nvim
```

**Note:** The install script will install various tools and may take some time. Review `install.zsh` before running to understand what will be installed.

## Repository Structure

```
dotfiles/
├── ai/                    # AI tooling configuration
│   ├── clients/opencode/  # OpenCode AI assistant config
│   └── docs/             # Development standards and guidelines
├── dot-config/           # XDG config files (~/.config)
│   ├── aerospace/        # Aerospace window manager
│   ├── alacritty/        # Alacritty terminal
│   ├── bat/             # Bat theme config
│   ├── cargo/           # Rust cargo config
│   ├── gh/              # GitHub CLI config
│   ├── ghostty/         # Ghostty terminal
│   ├── nvim/            # Neovim config (symlinked separately)
│   ├── skhd/            # Keyboard shortcuts
│   ├── starship/        # Shell prompt
│   ├── vscode/          # VS Code settings
│   ├── wezterm/         # WezTerm terminal
│   ├── yabai/           # Yabai window manager
│   ├── yazi/            # File manager
│   ├── zellij/          # Terminal multiplexer
│   └── zsh/             # Zsh configuration
├── home/                # Home directory dotfiles (~/)
│   ├── dot-gitconfig    # Git configuration
│   ├── dot-gitignore_global
│   ├── dot-editorconfig
│   ├── dot-lessfilter
│   └── dot-zshrc        # Zsh entry point
├── keyboard/            # Kinesis Advantage 360 Pro ZMK firmware
├── nix/                 # Nix configuration (nix-darwin + home-manager)
├── nvim/                # Neovim configuration (standalone)
├── obsidian/            # Obsidian vault and plugins
├── zellij-statusbar/    # Custom Zellij statusbar (Rust)
└── install.zsh          # Main installation script
```

## Key Features

### Neovim
- Modern LSP setup with Mason for auto-installation
- AI assistance with OpenCode and GitHub Copilot
- Full TypeScript/JavaScript, Go, Rust, Lua support
- Extensive keybindings and plugin ecosystem
- See [nvim/README.md](nvim/README.md) for details

### Terminal Experience
- Multiple terminal emulator options (Ghostty, WezTerm, Alacritty)
- Zellij multiplexer with custom Rust statusbar
- Tokyo Night color theme across all tools
- Starship prompt with git integration

### Window Management
- Yabai tiling window manager
- SKHD for global hotkeys
- Aerospace as alternative option

### Package Management
- Nix with nix-darwin for declarative macOS configuration
- Volta for Node.js/npm version management
- Cargo for Rust tools
- Homebrew integration via Nix

### Keyboard Firmware
- Custom ZMK firmware for Kinesis Advantage 360 Pro
- Build locally with `make` in `keyboard/` directory
- GitHub Actions workflow for automated builds
- See [keyboard/README.md](keyboard/README.md) for flashing instructions

## Useful Commands

### Development
```shell
# Rebuild Nix configuration
nix build .#darwinConfigurations.Noam.system

# Format Lua files (nvim/wezterm)
stylua .

# Lint Lua files
selene .

# Build keyboard firmware
cd keyboard && make

# Rebuild bat cache (after theme changes)
bat cache --build
```

### Stow Management
```shell
# Apply configuration changes
stow --dotfiles --target ~ home
stow --dotfiles --target ~/.config dot-config

# Remove symlinks
stow --delete --dotfiles --target ~ home
stow --delete --dotfiles --target ~/.config dot-config
```

## Customization

Most configurations can be customized by editing the relevant files:

- **Shell**: `dot-config/zsh/`
- **Terminal**: `dot-config/ghostty/config`, `dot-config/wezterm/wezterm.lua`
- **Editor**: `nvim/lua/`
- **Git**: `home/dot-gitconfig`
- **Packages**: `nix/home.nix`, `nix/configuration.nix`
- **Window Manager**: `dot-config/yabai/yabairc`, `dot-config/skhd/skhdrc`

After making changes, run `stow` commands again to update symlinks, or reload the relevant application.

## Additional Documentation

- [Neovim Configuration](nvim/README.md) - Detailed Neovim setup guide
- [Keyboard Firmware](keyboard/README.md) - ZMK configuration and flashing
- [Development Standards](ai/docs/CODE_STRANDARDS.md) - Coding guidelines
- [MCP Servers](ai/docs/MCP_SERVERS.md) - Model Context Protocol setup
- [Quick Reference](ai/docs/QUICK_REFERENCE.md) - Development quick reference

## Theme

All configurations use the **Tokyo Night** color scheme for visual consistency across:
- Neovim
- Terminal emulators
- Zellij
- Bat
- Git delta
- VS Code

## License

Personal configuration files - use at your own discretion.

## Acknowledgments

This configuration draws inspiration from the dotfiles community and various open-source projects.
