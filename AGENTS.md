# Agent Guidelines for Dotfiles Repository

## Build/Test/Lint Commands
- **Install all packages**: `zsh install.zsh` (from repo root)
- **Keyboard firmware build**: `make` (in keyboard/ dir) - builds ZMK firmware for Kinesis Advantage 360 Pro
- **Keyboard clean**: `make clean` (in keyboard/) - removes firmware files
- **Lua formatting**: `stylua .` (in nvim/ or dot-config/wezterm/ dirs) - 80 char width
- **Lua linting**: `selene .` (in nvim/ or dot-config/wezterm/ dirs)
- **Rust build**: `cargo build --release` (in zellij-statusbar/) - targets wasm32-wasip1
- **Rust test**: `cargo test [TESTNAME]` (in zellij-statusbar/) - run specific test by name substring
- **Rust format/lint**: `cargo fmt && cargo clippy` (in zellij-statusbar/)
- **Nix build**: `nix build .#darwinConfigurations.Noam.system` (from repo root)
- **Apply configuration**: `stow --dotfiles --target ~ home && stow --dotfiles --target ~/.config dot-config`
- **Bat cache rebuild**: `bat cache --build` (after bat theme changes)

## Code Style Guidelines
- **Lua**: 80 char line width, spaces for indentation, lua51+vim std for nvim, lua52 for wezterm, relative imports with `require("filename")`
- **Shell scripts**: Use zsh syntax, error handling with `|| die "message"`, shebang `#!/bin/zsh`, snake_case variables, export env vars in env.zsh
- **Rust**: PascalCase structs/enums, snake_case functions/variables, external crates before `use crate::`, `eprintln!` for errors, inline comments for complex logic
- **Nix**: Functional style, inherit statements grouped, 2-space indentation, alphabetize imports
- **Configuration files**: Maintain existing patterns per tool (YAML, TOML, KDL), Tokyo Night theme consistently
- **Naming**: snake_case for shell vars, camelCase for Lua locals, kebab-case for config files, PascalCase for Lua modules
- **Error handling**: Always include descriptive error messages for critical operations, use `die` function in shell scripts
- **Comments**: Minimal, only for complex logic or non-obvious configurations, inline comments for datetime/timezone calculations
- **Formatting**: No trailing whitespace, consistent indentation per file type, run formatters before committing
- **File organization**: Group related configs, maintain directory structure, keep submodules (nvim, keyboard) independent
- **Symlinks**: Use stow for dotfile management, avoid manual symlinking, `--dotfiles` flag converts dot- prefix
- **Dependencies**: Install via package managers (Volta for JS, Cargo for Rust, Nix for system packages, Homebrew via Nix)