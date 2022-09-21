# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

setopt autocd autopushd # this command will let you navigatge without cding
setopt correct # this command correct typos in your commands

autoload -U compinit # zsh completion
compinit

expand-or-complete-with-dots() {
  echo -n "\e[31m...\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

eval "$(starship init zsh)"

test -r ~/.dir_colors && eval $(gdircolors ~/.dir_colors)

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

eval "$(sheldon source)"

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

export BAT_THEME="Nord"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/Users/noam/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# ZSH_TMUX_AUTOSTART=true
# ZSH_TMUX_AUTOCONNECT=true

export EDITOR='code'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias cmon='sudo $(fc -ln -1)'
alias c='cargo'
alias cr='cargo run'
alias crr='cargo run --release'
alias cb='cargo build'
alias ct='cargo test'
alias cta='cargo test && cargo test -- --ignored'
alias p='pnpm'
alias px='pnpm exec'
alias pr='pnpm run'
alias pnx='pnpm nx'
alias zshconfig='$EDITOR ~/.zshrc'
alias tmuxconfig='$EDITOR ~/.tmux.conf'
alias nvimconfig='$EDITOR ~/.config/nvim/init.vim'
alias gitconfig='$EDITOR ~/.gitconfig'
alias reloadzsh='source ~/.zshrc'
alias reloadtmux='tmux source-file ~/.tmux.conf'
alias myip='curl http://ipecho.net/plain; echo'
alias unique='typeset -U'
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias dotsc='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME commit'
alias dotsl='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME pull'
alias dotsp='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME push'
alias dotsa='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME add'
alias dotss='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME status'
alias dotsco='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout'
alias gwt='git worktree'
alias gwta='gitWorktreeAdd existsing'
alias gwtab='gitWorktreeAdd new'
alias gwtls='git worktree list'
alias gwtrm='git worktree remove'
alias gwtrmf='git worktree remove -f'
alias gwtprn='git worktree prune'
alias gcns='gc && saveLastCommit'
alias gcplast='gcp $lastCommit'
alias gbstop='git bisect reset HEAD'
# gco-- <commit> <filename>
alias gco--='gRemoveFileChangesTillCommit'
# byebye <port>
alias byebye='killPort'

# Define personal functions
# getLastCommit
function saveLastCommit() {
    lastCommit=$(git rev-parse HEAD | cut -c 1-8)
}

# gitWorktreeAdd <new/existing> <branch>
function gitWorktreeAdd() {
    if [[ -n "$2" ]]
    then
      local folder_name=$(echo "$2" | tr '/' '-')
      local folder_path="../.git-worktrees/${folder_name}"
      if [[ "$1" == "new" ]]
      then
          git worktree add --track -b "$2" "${folder_path}"
          pushd "${folder_path}" > /dev/null
      else
          git worktree add "${folder_path}" "$2"
          pushd "${folder_path}" > /dev/null
      fi
    else
        echo 'Error: please provide path and a branch.'
    fi
}

# gRemoveFileChangesTillCommit <commit> <filename>
function gRemoveFileChangesTillCommit() {
    if [[ -n "$1" || -n "$2" ]]
    then
        git checkout "$1" -- "$2"
    else
        echo 'Error: please provide a commit and a filename.'
    fi
}

# killPort <port>
function killPort() {
    if [[ -n "$1" ]]
    then
        lsof -t -i tcp:"$1" | xargs kill
    else
        echo 'Error: please provide a port number.'
    fi
}

export PATH="$HOME/.local/bin:$PATH"

# prevent duplicates in $PATH and $FPATH, check why this is happening.
unique path
unique fpath
