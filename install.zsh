#!/bin/zsh

# Volta
curl https://get.volta.sh | bash || die "Failed to install Volta"

~/.volta/bin/volta install node || die "Failed to install Node via Volta"
~/.volta/bin/volta install pnpm || die "Failed to install pnpm via Volta"

# Nix
\. "./nix/install.zsh" || die "Failed to install Nix"

# Rust
$(command -v rustup) default stable || die "Failed to install Rust"

# Cargo
\. "$HOME/config/cargo/install.zsh" || die "Failed to install Cargo"

# Zellij
\. "$HOME/config/zellij/install.zsh" || die "Failed to install Zellij"

# VSCode
\. "$HOME/config/vscode/install.zsh" || die "Failed to install VSCode"

# Bat
$(command -v bat) cache --build || die "Failed to build bat cache"

stow --dotfiles --target ~ home
stow --dotfiles --target ~/.config dot-config

stow --target ~/.config/opencode ai/clients/opencode
stow --target ~/.config/nvim nvim
