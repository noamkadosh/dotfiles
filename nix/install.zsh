#!/bin/zsh

# https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050

# Remove shell backup files, if exists
[ -f /etc/bashrc.backup-before-nix ] && rm /etc/bashrc.backup-before-nix
[ -f /etc/bash.bashrc.backup-before-nix ] && rm /etc/bash.bashrc.backup-before-nix
[ -f /etc/zshrc.backup-before-nix ] && rm /etc/zshrc.backup-before-nix
[ -f /etc/zsh.zshrc.backup-before-nix ] && rm /etc/zsh.zshrc.backup-before-nix

# Install nix
if [ ! -f "/nix/var/nix/profiles/default/bin/nix" ]; then
    sh <(curl -L https://nixos.org/nix/install) --daemon || die "Nix installation failed"
else
    echo "Nix already installed."
fi

# Enable nix-command and flakes to bootstrap
\cat <<EOF > ~/dotfiles/nix/nix.conf
experimental-features = nix-command flakes
EOF

if [ $? -ne 0 ]; then
  die "Failed to edit nix.conf"
fi

# Until this is addressed https://github.com/LnL7/nix-darwin/issues/149
mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf || die "Failed to move nix.conf"

# Build configuration
/nix/var/nix/profiles/default/bin/nix build $HOME/dotfiles/nix#darwinConfigurations.Noam.system || die "Failed to build nix"
$HOME/result/sw/bin/darwin-rebuild switch --flake $HOME/dotfiles/nix#Noam || die "Failed to switch to flake"

[ -f "$HOME/.zshrc" ] && \. "$HOME/.zshrc"

# Might be useful to install x86 packages in the nix profile manually
$(command -v nix) profile install nixpkgs#legacyPackages.x86_64-darwin.haskellPackages.stack
