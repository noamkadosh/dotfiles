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

# Pnpm aliases
alias p="pnpm"
alias pex="pnpm exec"
alias pnx="pnpm nx"
alias pr="pnpm run"
alias px="pnpm dlx"

# Nix aliases
alias nixgc="nix-collect-garbage -d"
alias nixq="nix-env -qaP"
alias nixb="nix build --out-link ~/result ~/.dotfiles/.config/nix#darwinConfigurations.Noam.system
~/result/sw/bin/darwin-rebuild switch --flake ~/.dotfiles/.config/nix#Noam"
alias nixup="nix-env -u"
alias nixupdate="nix flake update ~/.dotfiles/.config/nix/"
alias nixupgrade="sudo -i sh -c 'nix-channel --update && nix-env --install --attr nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'"

# Config aliases
alias alacrittyconfig="$EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml"
alias gitconfig="$EDITOR $HOME/.gitconfig"
alias nixconfig="$EDITOR $XDG_CONFIG_HOME/nix/.nixpkgs/darwin-configuration.nix"
alias nvimconfig="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias reloadzsh="source $ZDOTDIR/.zshrc"
alias zellijconfig="$EDITOR $XDG_CONFIG_HOME/zellij/config.kdl"
alias zshconfig="$EDITOR $ZDOTDIR/.zshrc"

# Dotfiles bare repo management
alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias dotsa="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME add"
alias dotsc="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME commit"
alias dotsco="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout"
alias dotsl="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME pull"
alias dotsp="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME push"
alias dotss="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME status"

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
alias cop="gh copilot"
alias cope="gh copilot explain"
alias cops="gh copilot suggest"
alias copsh="gh copilot suggest -t shell"
alias copg="gh copilot suggest -t git"
alias copgh="gh copilot suggest -t gh"
alias autogpt="docker compose -f ~/Developer/AutoGPT/docker-compose.yaml run --rm auto-gpt"
