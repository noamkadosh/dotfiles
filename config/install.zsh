#!/bin/zsh

# Volta
curl https://get.volta.sh | bash || die "Failed to install Volta"

~/.volta/bin/volta install node || die "Failed to install Node via Volta"
~/.volta/bin/volta install pnpm || die "Failed to install pnpm via Volta"

# Nix
\. "$HOME/.config/nix/install.zsh" || die "Failed to install Nix"

# Rust
$(command -v rustup) default stable || die "Failed to install Rust"

# Cargo
\. "$HOME/.config/cargo/install.zsh" || die "Failed to install Cargo"

# Zellij
\. "$HOME/.config/zellij/install.zsh" || die "Failed to install Zellij"

# VSCode
\. "$HOME/.config/vscode/install.zsh" || die "Failed to install VSCode"

# Bat
$(command -v bat) cache --build || die "Failed to build bat cache"

# Obsidian
[ -e "$HOME/.config/obsidian" -a ! -L "$HOME/obsidian" ] && ln -s "$HOME/.config/obsidian" "$HOME/obsidian" || die "Failed to create Obsidian symlink"

# Editor Config
[ -e "$HOME/.config/editorconfig" -a ! -L "$HOME/.editorconfig" ] && ln -s "$HOME/.config/editorconfig" "$HOME/.editorconfig" || die "Failed to create EditorConfig symlink"

stow ~ home
stow ~/.config config
