# General aliases
# alias act="act --container-architecture linux/amd64"
alias byebye="killPort" # byebye <port>
alias cat="batOrMdcat"
alias cmon="sudo -s eval $(history -p !!)"
alias du="dust"
alias find="fd"
alias grep="rg"
alias ls="eza --icons"
alias myip="curl http://ipecho.net/plain; echo"
alias ports="lsof -i -P -n | grep LISTEN"
alias ps="procs"
# alias sed="sd"
alias top="btm"
alias unique="typeset -U"
alias gui="gitui"
alias fzp="fzf --preview 'bat --color=always {} --style=numbers'"

# Cargo aliases
alias c="cargo"
alias cb="cargo build"
alias cr="cargo run"
alias crr="cargo run --release"
alias ct="cargo test"
alias cta="cargo test && cargo test -- --ignored"

# Package Manegers aliases
alias b="bun"
alias bx="bunx"
alias d="deno"
alias n="npm"
alias nx="npx"
alias p="pnpm"
alias px="pnpm dlx"
alias y="yarn"

# Nix aliases
alias nixb="nix build --out-link ~/result $HOME/.dotfiles/.config/nix#darwinConfigurations.Noam.system
$HOME/result/sw/bin/darwin-rebuild switch --flake $HOME/.dotfiles/.config/nix#Noam"
alias nixupdate="nix flake update ~/.dotfiles/.config/nix/"
alias nixupgrade="sudo -i sh -c 'nix-channel --update && nix-env --install --attr nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'"
alias reloadnixdaemon="sudo launchctl unload /Libray/LaunchDaemons/org.nixos.nix-daemon.plist && sudo launchctl load /Libray/LaunchDaemons/org.nixos.nix-daemon.plist"

# Config aliases
alias reloadzsh="source $ZDOTDIR/.zshrc"

# Git worktrees aliases
alias gwt="git worktree"
alias gwtan="gitWorktreeAdd new"
alias gwtco="gitWorktreeAdd existing"
alias gwtls="git worktree list"
alias gwtprn="git worktree prune"
alias gwtrm="git worktree remove"
alias gwtrmf="git worktree remove -f"
alias gwtrt="gitWorktreeAdd root"

# Git aliases
alias gbstop="git bisect reset HEAD"
alias cplast="git rev-parse --short HEAD | pbcopy"
alias gcplast="git cherry-pick ${pbpaste}"

# AI tools
alias ai="aider"
alias cop="gh copilot"
alias cope="gh copilot explain"
alias cops="gh copilot suggest"
alias copsh="gh copilot suggest -t shell"
alias copg="gh copilot suggest -t git"
alias copgh="gh copilot suggest -t gh"
